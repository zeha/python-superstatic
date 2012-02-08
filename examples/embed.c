#include <windows.h>
#include <Python.h>

void add_path_to_list(PyObject* list, const char* path) {
  PyObject *pPath = PyString_FromString(path);
  PyList_Append(list, pPath);
  Py_DECREF(pPath);
}

// extern, an importer based on zipimport.c
PyMODINIT_FUNC initcustomimport(void);

int init_py(int argc, char* argv[]) {
  Py_NoSiteFlag++;
  Py_OptimizeFlag++;
  Py_Initialize();
  PySys_SetArgvEx(argc, argv, 0);

  initcustomimport();
  PyObject* m_customimport = PyImport_ImportModule("customimport");
  if (m_customimport == NULL) {
    return -1;
  }
  PyObject *customimporter = PyObject_GetAttrString(m_customimport, "customimporter");
  Py_DECREF(m_customimport);
  if (customimporter == NULL) {
    return -1;
  }
  PyObject* path_hooks = PySys_GetObject("path_hooks");
  /* sys.path_hooks.append(customimporter) */
  PyList_Append(path_hooks, customimporter);
  Py_DECREF(customimporter);

  /* reset sys.path */
  std::string app_path = get_app_path();
  PyObject *pSearchPathList = PyList_New(0);
  add_path_to_list(pSearchPathList, (app_path + "\\lib").c_str());
  add_path_to_list(pSearchPathList, (app_path + "\\lib-custom").c_str());
  PySys_SetObject("path", pSearchPathList);
  Py_DECREF(pSearchPathList);
  return 0;
}

int end_py() {
  Py_Finalize();
  return 0;
}

int run_py_module(const char* module_name, int argc, char *argv[]) {
  int rc = init_py(argc, argv);
  if (rc != 0)
    return rc;

  /* import requested module and go */
  PyObject *pModuleName;
  PyObject *pModule;
  pModuleName = PyString_FromString(module_name);
  pModule = PyImport_Import(pModuleName);
  Py_DECREF(pModuleName);

  if (pModule != NULL) {
    PyObject *pFunc = PyObject_GetAttrString(pModule, "main");
    PyObject *pResult = PyObject_CallObject(pFunc, NULL);
    if (pResult == NULL) {
      PyErr_Print();
    } else {
      if (PyInt_Check(pResult))
        rc = PyInt_AsLong(pResult);
      Py_DECREF(pResult);
    }
    Py_DECREF(pFunc);
  } else {
    PyErr_Print();
  }
  end_py();
  return rc;
}

int main(int argc, char *argv[]) {
  if (run_py_module("example.xyz", argc, argv) == 0)
    return 0;
  else
    return 1;
}
