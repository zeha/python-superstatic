all: Python-2.7/PCbuild/python27.lib

clean:
	-rmdir /s /q Python-2.7
	-rmdir /s /q openssl-0.9.8o

Python-2.7: Python-2.7.tgz python-2.7-superstatic-build.patch
	@echo Unpacking Python
	7z x -y Python-2.7.tgz >nul:
	7z x -y Python-2.7.tar >nul:
	del Python-2.7.tar
	patch-11.01.py python-2.7-superstatic-build.patch

openssl-0.9.8o: openssl-0.9.8o.tar.gz
	@echo Unpacking OpenSSL
	7z x -y openssl-0.9.8o.tar.gz >nul:
	7z x -y openssl-0.9.8o.tar >nul:
	del openssl-0.9.8o.tar

Python-2.7/PC/build_ssl.py: Python-2.7

openssl-0.9.8o/out32/libeay32.lib: openssl-0.9.8o Python-2.7/PC/build_ssl.py
	cd Python-2.7\PCbuild
	build_ssl.py Release Win32
	cd ..\..

Python-2.7/PCbuild/python27.lib: Python-2.7 openssl-0.9.8o/out32/libeay32.lib Python-2.7/PC/config.c
	cd Python-2.7\PCbuild
	-rmdir /s /q Win32-temp-Release
	mkdir Win32-temp-Release
	mkdir Win32-temp-Release\pythoncore
	-del cl.rsp
	echo /O2 /Ob1 /Oi /GL /I "..\Python" /I "..\Modules\zlib" /I "..\Modules\_ctypes\libffi_msvc" /I "..\..\openssl-0.9.8o\inc32" /I "..\Include" /I "..\PC" /D "_USRDLL" /D "Py_BUILD_CORE" /D "Py_NO_ENABLE_SHARED" /D "WIN32" /D "NDEBUG" /D "_WIN32" /GF /FD /MD /Gy /Fo"%CD%\Win32-temp-Release\pythoncore\\" /Fd"%CD%\Win32-temp-Release\pythoncore\\vc90.pdb" /W3 /c /Zi  /Zm200  > cl.rsp
	echo "..\Modules\getbuildinfo.c" >> cl.rsp
	echo "..\Modules\_bisectmodule.c" "..\Python\traceback.c" "..\Python\thread.c" "..\Python\sysmodule.c" "..\Python\symtable.c" "..\Python\structmember.c" "..\Python\pythonrun.c" "..\Python\Python-ast.c" "..\Python\dtoa.c" "..\Python\pystrtod.c" "..\Python\pystrcmp.c" "..\Python\pystate.c" "..\Python\pymath.c" "..\Python\pyfpe.c" "..\Python\pyctype.c" "..\Python\pyarena.c" "..\Python\peephole.c" "..\Python\mystrtoul.c" "..\Python\mysnprintf.c" "..\Python\modsupport.c" "..\Python\marshal.c" "..\Python\importdl.c" "..\Python\import.c" "..\Python\graminit.c" "..\Python\getversion.c" "..\Python\getplatform.c" "..\Python\getopt.c" "..\Python\getcopyright.c" "..\Python\getcompiler.c" "..\Python\getargs.c" "..\Python\future.c" "..\Python\frozen.c" "..\Python\formatter_unicode.c" "..\Python\formatter_string.c" "..\Python\errors.c" "..\Python\compile.c" "..\Python\codecs.c" "..\Python\ceval.c" "..\Python\bltinmodule.c" "..\Python\ast.c" "..\Python\asdl.c" "..\Python\_warnings.c" "..\PC\msvcrtmodule.c" "..\PC\import_nt.c" "..\PC\getpathp.c" "..\PC\config.c" "..\PC\_winreg.c" "..\PC\_subprocess.c" "..\Parser\tokenizer.c" "..\Parser\parsetok.c" "..\Parser\parser.c" "..\Parser\node.c" "..\Parser\myreadline.c" "..\Parser\metagrammar.c" "..\Parser\listnode.c" "..\Parser\grammar1.c" "..\Parser\grammar.c" "..\Parser\firstsets.c" "..\Parser\bitset.c" "..\Parser\acceler.c" "..\Objects\weakrefobject.c" "..\Objects\unicodeobject.c" "..\Objects\unicodectype.c" "..\Objects\typeobject.c" "..\Objects\tupleobject.c" "..\Objects\structseq.c" "..\Objects\sliceobject.c" "..\Objects\setobject.c" "..\Objects\rangeobject.c" "..\Objects\obmalloc.c" "..\Objects\object.c" "..\Objects\moduleobject.c" "..\Objects\methodobject.c" "..\Objects\memoryobject.c" "..\Objects\longobject.c" "..\Objects\listobject.c" "..\Objects\iterobject.c" "..\Objects\intobject.c" "..\Objects\genobject.c" >> cl.rsp
	echo "..\Objects\funcobject.c" "..\Objects\frameobject.c" "..\Objects\floatobject.c" "..\Objects\fileobject.c" "..\Objects\exceptions.c" "..\Objects\enumobject.c" "..\Objects\dictobject.c" "..\Objects\descrobject.c" "..\Objects\complexobject.c" "..\Objects\codeobject.c" "..\Objects\cobject.c" "..\Objects\classobject.c" "..\Objects\cellobject.c" "..\Objects\capsule.c" "..\Objects\stringobject.c" "..\Objects\bytearrayobject.c" "..\Objects\bytes_methods.c" "..\Objects\bufferobject.c" "..\Objects\boolobject.c" "..\Objects\abstract.c" "..\Modules\selectmodule.c" "..\Modules\_ssl.c" "..\Modules\_hashopenssl.c" "..\Modules\socketmodule.c" "..\Modules\_ctypes\libffi_msvc\win32.c" "..\Modules\_ctypes\stgdict.c" "..\Modules\_ctypes\libffi_msvc\prep_cif.c" "..\Modules\_ctypes\malloc_closure.c" "..\Modules\_ctypes\libffi_msvc\ffi.c" "..\Modules\_ctypes\cfield.c" "..\Modules\_ctypes\callproc.c" "..\Modules\_ctypes\callbacks.c" "..\Modules\_ctypes\_ctypes.c" "..\Modules\_io\textio.c" "..\Modules\_io\stringio.c" "..\Modules\_io\iobase.c" "..\Modules\_io\fileio.c" "..\Modules\_io\bytesio.c" "..\Modules\_io\bufferedio.c" "..\Modules\_io\_iomodule.c" "..\Modules\cjkcodecs\multibytecodec.c" "..\Modules\cjkcodecs\_codecs_tw.c" "..\Modules\cjkcodecs\_codecs_kr.c" "..\Modules\cjkcodecs\_codecs_jp.c" "..\Modules\cjkcodecs\_codecs_iso2022.c" "..\Modules\cjkcodecs\_codecs_hk.c" "..\Modules\cjkcodecs\_codecs_cn.c" "..\Modules\zlib\zutil.c" "..\Modules\zlib\uncompr.c" "..\Modules\zlib\trees.c" "..\Modules\zlib\inftrees.c" "..\Modules\zlib\inflate.c" "..\Modules\zlib\inffast.c" "..\Modules\zlib\infback.c" "..\Modules\zlib\gzio.c" "..\Modules\zlib\deflate.c" "..\Modules\zlib\crc32.c" "..\Modules\zlib\compress.c" "..\Modules\zlib\adler32.c" "..\Modules\zlibmodule.c" "..\Modules\zipimport.c" "..\Modules\xxsubtype.c" "..\Modules\timemodule.c" "..\Modules\threadmodule.c" >> cl.rsp
	echo "..\Modules\symtablemodule.c" "..\Modules\stropmodule.c" "..\Modules\signalmodule.c" "..\Modules\shamodule.c" "..\Modules\sha512module.c" "..\Modules\sha256module.c" "..\Modules\rotatingtree.c" "..\Modules\posixmodule.c" "..\Modules\parsermodule.c" "..\Modules\operator.c" "..\Modules\mmapmodule.c" "..\Modules\md5module.c" "..\Modules\md5.c" "..\Modules\mathmodule.c" "..\Modules\main.c" "..\Modules\itertoolsmodule.c" "..\Modules\imageop.c" "..\Modules\gcmodule.c" "..\Modules\future_builtins.c" "..\Modules\errnomodule.c" "..\Modules\datetimemodule.c" "..\Modules\cStringIO.c" "..\Modules\cPickle.c" "..\Modules\cmathmodule.c" "..\Modules\binascii.c" "..\Modules\audioop.c" "..\Modules\arraymodule.c" "..\Modules\_weakref.c" "..\Modules\_struct.c" "..\Modules\_sre.c" "..\Modules\_randommodule.c" "..\Modules\_math.c" "..\Modules\_lsprof.c" "..\Modules\_localemodule.c" "..\Modules\_json.c" "..\Modules\_hotshot.c" "..\Modules\_heapqmodule.c" "..\Modules\_functoolsmodule.c" "..\Modules\_csv.c" "..\Modules\_collectionsmodule.c" "..\Modules\_codecsmodule.c" >> cl.rsp
	cl.exe @cl.rsp
	cd Win32-temp-Release\pythoncore
	-del lib.rsp
	echo /OUT:"..\..\python27.lib" /NODEFAULTLIB:"libc" /NODEFAULTLIB:"libcmt" /LTCG getbuildinfo.obj > lib.rsp
	echo "_bisectmodule.obj" "_codecsmodule.obj" "_collectionsmodule.obj" "_csv.obj" "_functoolsmodule.obj" "_heapqmodule.obj" "_hotshot.obj" "_json.obj" "_localemodule.obj" "_lsprof.obj" "_math.obj" "_randommodule.obj" "_sre.obj" "_struct.obj" "_weakref.obj" "arraymodule.obj" "audioop.obj" "binascii.obj" "cmathmodule.obj" "cPickle.obj" "cStringIO.obj" "datetimemodule.obj" "errnomodule.obj" "future_builtins.obj" "gcmodule.obj" "imageop.obj" "itertoolsmodule.obj" "main.obj" "mathmodule.obj" "md5.obj" "md5module.obj" "mmapmodule.obj" "operator.obj" "parsermodule.obj" "posixmodule.obj" "rotatingtree.obj" "sha256module.obj" >> lib.rsp
	echo "sha512module.obj" "shamodule.obj" "signalmodule.obj" "stropmodule.obj" "symtablemodule.obj" "threadmodule.obj" "timemodule.obj" "xxsubtype.obj" "zipimport.obj" "zlibmodule.obj" "adler32.obj" "compress.obj" "crc32.obj" "deflate.obj" "gzio.obj" "infback.obj" "inffast.obj" "inflate.obj" "inftrees.obj" "trees.obj" "uncompr.obj" "zutil.obj" "_codecs_cn.obj" "_codecs_hk.obj" "_codecs_iso2022.obj" "_codecs_jp.obj" "_codecs_kr.obj" "_codecs_tw.obj" "multibytecodec.obj" "_iomodule.obj" "bufferedio.obj" "bytesio.obj" "fileio.obj" "iobase.obj" "stringio.obj" "textio.obj" "_ctypes.obj" "callbacks.obj" >> lib.rsp
	echo  "callproc.obj" "cfield.obj" "ffi.obj" "malloc_closure.obj" "prep_cif.obj" "stgdict.obj" "win32.obj" "socketmodule.obj" "_hashopenssl.obj" "_ssl.obj" "selectmodule.obj" "abstract.obj" "boolobject.obj" "bufferobject.obj" "bytes_methods.obj" "bytearrayobject.obj" "stringobject.obj" "capsule.obj" "cellobject.obj" "classobject.obj" "cobject.obj" "codeobject.obj" "complexobject.obj" "descrobject.obj" "dictobject.obj" "enumobject.obj" "exceptions.obj" "fileobject.obj" "floatobject.obj" "frameobject.obj" "funcobject.obj" "genobject.obj" "intobject.obj" "iterobject.obj" "listobject.obj" "longobject.obj" "memoryobject.obj" >> lib.rsp
	echo "methodobject.obj" "moduleobject.obj" "object.obj" "obmalloc.obj" "rangeobject.obj" "setobject.obj" "sliceobject.obj" "structseq.obj" "tupleobject.obj" "typeobject.obj" "unicodectype.obj" "unicodeobject.obj" "weakrefobject.obj" "acceler.obj" "bitset.obj" "firstsets.obj" "grammar.obj" "grammar1.obj" "listnode.obj" "metagrammar.obj" "myreadline.obj" "node.obj" "parser.obj" "parsetok.obj" "tokenizer.obj" "_subprocess.obj" "_winreg.obj" "config.obj" "getpathp.obj" "import_nt.obj" "msvcrtmodule.obj" "_warnings.obj" "asdl.obj" "ast.obj" "bltinmodule.obj" "ceval.obj" "codecs.obj" "compile.obj" >> lib.rsp
	echo "errors.obj" "formatter_string.obj" "formatter_unicode.obj" "frozen.obj" "future.obj" "getargs.obj" "getcompiler.obj" "getcopyright.obj" "getopt.obj" "getplatform.obj" "getversion.obj" "graminit.obj" "import.obj" "importdl.obj" "marshal.obj" "modsupport.obj" "mysnprintf.obj" "mystrtoul.obj" "peephole.obj" "pyarena.obj" "pyctype.obj" "pyfpe.obj" "pymath.obj" "pystate.obj" "pystrcmp.obj" "pystrtod.obj" "dtoa.obj" "Python-ast.obj" "pythonrun.obj" "structmember.obj" "symtable.obj" "sysmodule.obj" "thread.obj" "traceback.obj" >> lib.rsp
	lib.exe @lib.rsp
	cd ..\..\..\..

