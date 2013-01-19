PYTHON_V=2.7.3
OPENSSL_V=1.0.1c

all: Python-$(PYTHON_V)/PCbuild/pythonembed.lib

clean:
	-rmdir /s /q Python-$(PYTHON_V)
	-rmdir /s /q openssl-$(OPENSSL_V)

Python-$(PYTHON_V)\stamp: Python-$(PYTHON_V).tgz python-2.7-superstatic-build.patch
	@echo Unpacking Python $(PYTHON_V)
	7za x -y Python-$(PYTHON_V).tgz >nul:
	7za x -y Python-$(PYTHON_V).tar >nul:
	del Python-$(PYTHON_V).tar
	cd Python-$(PYTHON_V) && patch -p1 < ..\python-2.7-superstatic-build.patch
	echo>$@

openssl-$(OPENSSL_V)\stamp: openssl-$(OPENSSL_V).tar.gz
	@echo Unpacking OpenSSL $(OPENSSL_V)
	7za x -y openssl-$(OPENSSL_V).tar.gz >nul:
	7za x -y openssl-$(OPENSSL_V).tar >nul:
	del openssl-$(OPENSSL_V).tar
	echo>$@

openssl-$(OPENSSL_V)/out32/libeay32.lib: openssl-$(OPENSSL_V)\stamp
	cd openssl-$(OPENSSL_V)
	perl Configure VC-WIN32
	ms\do_nasm
	nmake -f ms\nt.mak
	cd ..

Python-$(PYTHON_V)/PCbuild/pythonembed.lib: Python-$(PYTHON_V)\stamp openssl-$(OPENSSL_V)/out32/libeay32.lib
	cd Python-$(PYTHON_V)
	-del PC\frozen_dllmain.c PC\python3dll.c PC\w9xpopen.c PC\WinMain.c PC\make_versioninfo.c PC\empty.c PC\dl_nt.c PC\_msi.c PC\generrmap.c
	-del Python\dynload_s* Python\dynload_next.c Python\dynload_aix.c Python\dynload_dl.c Python\dynload_hpux.c Python\dynload_os2.c Python\dup2.c Python\python.c
	-del Modules\tk*.c Modules\_tk*.c Modules\getnameinfo.c Modules\getaddrinfo.c Modules\grpmodule.c Modules\pwdmodule.c Modules\nismodule.c Modules\termios.c Modules\_gestalt.c Modules\syslogmodule.c Modules\spwdmodule.c Modules\bz2module.c Modules\readline.c Modules\ossaudiodev.c Modules\fcntlmodule.c Modules\_test* Modules\main.c Modules\getpath.c Modules\pyexpat.c Modules\_dbmmodule.c Modules\_cursesmodule.c Modules\_scproxy.c Modules\resource.c Modules\_posixsubprocess.c Modules\_elementtree.c Modules\_gdbmmodule.c Modules\getcwd.c
#	-del Modules\signalmodule.c # needed on 2.7
	-del Modules\_bsddb.c Modules\_curses_panel.c Modules\glmodule.c Modules\timingmodule.c Modules\fmmodule.c Modules\flmodule.c Modules\dbmmodule.c Modules\linuxaudiodev.c Modules\sunaudiodev.c Modules\almodule.c Modules\clmodule.c Modules\dlmodule.c Modules\bsddbmodule.c Modules\gdbmmodule.c Modules\imgfile.c Modules\winsound.c
	-del Python\dynload_beos.c Python\dynload_atheos.c Python\mactoolboxglue.c Python\sigcheck.c
	-del Modules\_ctypes\_ctypes_test* Modules\_ctypes\libffi_msvc\types.c
	-del Modules\zlib\minigzip.c Modules\zlib\example.c Modules\zlib\gzclose.c Modules\zlib\gzlib.z Modules\zlib\gzread.c Modules\zlib\gzwrite.c
	-del Modules\cdmodule.c Modules\sgimodule.c Modules\svmodule.c
	-del Parser\pgen.c Parser\pgenmain.c Parser\printgrammar.c Parser\tokenizer_pgen.c Parser\intrcheck.c
	cd ..
	cd Python-$(PYTHON_V)\PCbuild
	cd
	copy ..\..\python.vcxproj.tpl python.vcxproj
	msbuild /m:$(NUMBER_OF_PROCESSORS) python.vcxproj "/p:OPENSSL_V=$(OPENSSL_V);Configuration=Release"
