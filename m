Received:  by oss.sgi.com id <S553702AbRCCCs0>;
	Fri, 2 Mar 2001 18:48:26 -0800
Received: from smtp.psdc.com ([209.125.203.83]:57924 "EHLO smtp.psdc.com")
	by oss.sgi.com with ESMTP id <S553652AbRCCCsD>;
	Fri, 2 Mar 2001 18:48:03 -0800
Received: from BANANA ([209.125.203.85])
	by smtp.psdc.com (8.8.8/8.8.8) with SMTP id SAA24492;
	Fri, 2 Mar 2001 18:31:39 -0800
Message-ID: <001b01c0a328$11736b50$dde0490a@BANANA>
From:   "Steven Liu" <stevenliu@psdc.com>
To:     <Franz.Sirl-kernel@lauterbach.com>
Cc:     <linux-mips@oss.sgi.com>, "Kevin D. Kissell" <kevink@paralogos.com>
Subject: libgcc2.a and mips-tfile
Date:   Fri, 2 Mar 2001 06:50:00 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0017_01C0A2E5.00ECE6F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C0A2E5.00ECE6F0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0018_01C0A2E5.00ECE6F0"


------=_NextPart_001_0018_01C0A2E5.00ECE6F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, Franz:

I am doing cross-compiler for mips r3000 now and meet alot of problems.

My host system is i386 with Rad Hat 7.0 installed.=20

First, I successfully built and installed binutils-2.8.1 by using =
binutils-2.8.1.tar.gz and egcs-mips-linux-1.1.2-2.i386.rpm. This created =
bin, lib, mips-linux subdirectories.

Second, I installed the linux kernel source code for mips by using =
linux-2.2.14-000715.tar.gz and configured it and enabled =
CONFIG_CROSSCOMPILE.  Made soft links: let  mips-linux/include/asm =
pointd to linux-2.2.14-000715/include/asm-mips and=20
mips-linux/include/linux pointd to linux-2.2.14-000715/include/linux.

Third, unziped the egcs-1.1.2.tar.gz, added the patch =
egcs-mips-linux-1.1.2-2.i386.rpm and configured it as following:
     ./configure --prefix=3D/home/sliu --with-newlib =
--target=3Dmips-linux
and made it this way:
     make SUBDIRS=3D"libiberty texinfo gcc" ALL_TARGET_MODULES=3D =
CONFIGURE_TARGET_MODULES=3D INSTALL_TARGET_MODULES=3D LANGUAGES=3D"c"

Then, it gave the following errors in gcc subdirectory:

xgcc: installation problem, cannot exec `mips-tfile': No such file or =
directory
make[1]: *** [libgcc2.a] Error 1
make[1]: Leaving directory `/home/sliu/egcs-1.1.2/gcc'
make: *** [all-gcc] Error 2


If you could give me any help, I would be greatly appreciated.

Regards,


Steven Liu


------=_NextPart_001_0018_01C0A2E5.00ECE6F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3103.1000" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi, Franz:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am doing cross-compiler for mips =
r3000 now and=20
meet alot of problems.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My host system is i386 with Rad Hat 7.0 =
installed.=20
</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>First, I successfully built and =
installed=20
binutils-2.8.1 by using <STRONG>binutils-2.8.1.tar.gz </STRONG>and=20
<STRONG>egcs-mips-linux-1.1.2-2.i386.rpm</STRONG>. This created bin, =
lib,=20
mips-linux subdirectories.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Second, I installed the linux kernel =
source code=20
for mips by using <STRONG>linux-2.2.14-000715.tar.gz </STRONG>and=20
configured&nbsp;it&nbsp;and enabled </FONT><FONT face=3DArial=20
size=3D2>CONFIG_CROSSCOMPILE.&nbsp; <STRONG>Made soft links</STRONG>: =
let =20
mips-linux/include/asm pointd to linux-2.2.14-000715/include/asm-mips =
and=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mips-linux/include/linux pointd to=20
linux-2.2.14-000715/include/linux.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Third,&nbsp;unziped the=20
<STRONG>egcs-1.1.2.tar.gz</STRONG>, added the patch=20
<STRONG>egcs-mips-linux-1.1.2-2.i386.rpm </STRONG>and configured =
it&nbsp;as=20
following:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; =
<STRONG>./configure=20
--prefix=3D/home/sliu --with-newlib =
--target=3Dmips-linux</STRONG></FONT><FONT=20
face=3DArial size=3D2></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and made it this way:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; <STRONG>make=20
SUBDIRS=3D"libiberty texinfo gcc" ALL_TARGET_MODULES=3D =
CONFIGURE_TARGET_MODULES=3D=20
INSTALL_TARGET_MODULES=3D LANGUAGES=3D"c"</STRONG></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Then, it gave the following errors in =
gcc=20
subdirectory:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG><FONT face=3DArial size=3D2>xgcc: installation problem, =
cannot exec=20
`mips-tfile': No such file or directory<BR>make[1]: *** [libgcc2.a] =
Error=20
1<BR>make[1]: Leaving directory `/home/sliu/egcs-1.1.2/gcc'<BR>make: *** =

[all-gcc] Error 2<BR></FONT></STRONG><FONT face=3DArial =
size=3D2></DIV></FONT>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If you could give me any help, I would =
be greatly=20
appreciated.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Steven =
Liu<BR></DIV></FONT></BODY></HTML>

------=_NextPart_001_0018_01C0A2E5.00ECE6F0--

------=_NextPart_000_0017_01C0A2E5.00ECE6F0
Content-Type: text/plain;
	name="liu.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="liu.txt"

make[1]: Entering directory `/home/sliu/egcs-1.1.2/libiberty'=0A=
f=3D" "; \=0A=
case $f in \=0A=
  *alloca.o*) f=3D"$f xmalloc.o xexit.o" ;; \=0A=
esac; \=0A=
echo $f > needed-list=0A=
echo argv.o choose-temp.o concat.o cplus-dem.o fdmatch.o fnmatch.o =
getopt.o getopt1.o getruntime.o hex.o floatformat.o objalloc.o obstack.o =
pexecute.o spaces.o strerror.o strsignal.o xatexit.o xexit.o xmalloc.o =
xstrdup.o xstrerror.o > required-list=0A=
make[1]: Leaving directory `/home/sliu/egcs-1.1.2/libiberty'=0A=
make[1]: Entering directory `/home/sliu/egcs-1.1.2/texinfo'=0A=
make all-recursive=0A=
make[2]: Entering directory `/home/sliu/egcs-1.1.2/texinfo'=0A=
Making all in intl=0A=
make[3]: Entering directory `/home/sliu/egcs-1.1.2/texinfo/intl'=0A=
make[3]: Nothing to be done for `all'.=0A=
make[3]: Leaving directory `/home/sliu/egcs-1.1.2/texinfo/intl'=0A=
Making all in lib=0A=
make[3]: Entering directory `/home/sliu/egcs-1.1.2/texinfo/lib'=0A=
make[3]: Nothing to be done for `all'.=0A=
make[3]: Leaving directory `/home/sliu/egcs-1.1.2/texinfo/lib'=0A=
Making all in makeinfo=0A=
make[3]: Entering directory `/home/sliu/egcs-1.1.2/texinfo/makeinfo'=0A=
make[3]: Nothing to be done for `all'.=0A=
make[3]: Leaving directory `/home/sliu/egcs-1.1.2/texinfo/makeinfo'=0A=
Making all in util=0A=
make[3]: Entering directory `/home/sliu/egcs-1.1.2/texinfo/util'=0A=
make[3]: Nothing to be done for `all'.=0A=
make[3]: Leaving directory `/home/sliu/egcs-1.1.2/texinfo/util'=0A=
make[2]: Leaving directory `/home/sliu/egcs-1.1.2/texinfo'=0A=
make[1]: Leaving directory `/home/sliu/egcs-1.1.2/texinfo'=0A=
make[1]: Entering directory `/home/sliu/egcs-1.1.2/etc'=0A=
make[1]: Nothing to be done for `all'.=0A=
make[1]: Leaving directory `/home/sliu/egcs-1.1.2/etc'=0A=
make[1]: Entering directory `/home/sliu/egcs-1.1.2/gcc'=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H     -I. -I. =
-I./config \=0A=
  =
-DGCC_INCLUDE_DIR=3D\"/home/sliu/lib/gcc-lib/mips-linux/egcs-2.91.66/incl=
ude\" \=0A=
  -DGPLUSPLUS_INCLUDE_DIR=3D\"/home/sliu/include/g++\" \=0A=
  -DOLD_GPLUSPLUS_INCLUDE_DIR=3D\"/home/sliu/lib/g++-include\" \=0A=
  -DLOCAL_INCLUDE_DIR=3D\"/usr/local/include\" \=0A=
  -DCROSS_INCLUDE_DIR=3D\"/home/sliu/mips-linux/sys-include\" \=0A=
  -DTOOL_INCLUDE_DIR=3D\"/home/sliu/mips-linux/include\" \=0A=
  -c `echo ./cccp.c | sed 's,^\./,,'`=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H     -I. -I. =
-I./config \=0A=
-DPREFIX=3D\"/home/sliu\" \=0A=
  -c `echo ./prefix.c | sed 's,^\./,,'`=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H   -o cccp cccp.o =
cexp.o prefix.o \=0A=
  version.o obstack.o     =0A=
rm -f cpp=0A=
ln cccp cpp=0A=
gcc -c -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H     -I. -I. =
-I./config ./gencheck.c=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H   -o gencheck \=0A=
 gencheck.o ` case "obstack.o" in ?*) echo obstack.o ;; esac ` ` case "" =
in ?*) echo  ;; esac ` ` case "" in ?*) echo  ;; esac ` ` case "" in ?*) =
echo  ;; esac ` ` case "" in ?*) echo  ;; esac ` =0A=
./gencheck > tmp-check.h=0A=
./move-if-change tmp-check.h tree-check.h=0A=
tree-check.h is unchanged=0A=
touch s-check=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H     -I. -I. =
-I./config  \=0A=
  -DTARGET_NAME=3D\"mips-linux\" \=0A=
  -c `echo ./toplev.c | sed 's,^\./,,'`=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H   -o cc1 =
c-parse.o c-lang.o c-lex.o c-pragma.o c-decl.o c-typeck.o c-convert.o =
c-aux-info.o c-common.o c-iterate.o  toplev.o version.o tree.o =
print-tree.o stor-layout.o fold-const.o function.o stmt.o except.o =
expr.o calls.o expmed.o explow.o optabs.o varasm.o rtl.o print-rtl.o =
rtlanal.o emit-rtl.o genrtl.o real.o regmove.o dbxout.o sdbout.o =
dwarfout.o dwarf2out.o xcoffout.o bitmap.o alias.o integrate.o jump.o =
cse.o loop.o unroll.o flow.o stupid.o combine.o varray.o regclass.o =
local-alloc.o global.o reload.o reload1.o caller-save.o gcse.o =
insn-peep.o reorg.o sched.o final.o recog.o reg-stack.o insn-opinit.o =
insn-recog.o insn-extract.o insn-output.o insn-emit.o profile.o =
insn-attrtab.o mips.o getpwd.o  convert.o dyn-string.o obstack.o     =0A=
/bin/sh ./genmultilib \=0A=
  "" \=0A=
  "" \=0A=
  "" \=0A=
  "" \=0A=
  "" > tmp-mlib.h=0A=
./move-if-change tmp-mlib.h multilib.h=0A=
multilib.h is unchanged=0A=
touch s-mlib=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H     -I. -I. =
-I./config \=0A=
  -DSTANDARD_STARTFILE_PREFIX=3D\"/home/sliu/lib/\" =
-DSTANDARD_EXEC_PREFIX=3D\"/home/sliu/lib/gcc-lib/\" =
-DDEFAULT_TARGET_VERSION=3D\"egcs-2.91.66\" =
-DDEFAULT_TARGET_MACHINE=3D\"mips-linux\" =
-DTOOLDIR_BASE_PREFIX=3D\"/home/sliu/\" \=0A=
  -c `echo ./gcc.c | sed 's,^\./,,'`=0A=
gcc -DCROSS_COMPILE -DIN_GCC    -g -O2  -DHAVE_CONFIG_H   -o xgcc gcc.o =
prefix.o version.o \=0A=
  choose-temp.o pexecute.o mkstemp.o  obstack.o     =0A=
echo "int xxy_us_dummy;" >tmp-dum.c=0A=
/home/sliu/egcs-1.1.2/gcc/xgcc -B/home/sliu/egcs-1.1.2/gcc/ -S tmp-dum.c=0A=
echo '/*WARNING: This file is automatically generated!*/' >tmp-under.c=0A=
if grep _xxy_us_dummy tmp-dum.s > /dev/null ; then \=0A=
  echo "int prepends_underscore =3D 1;" >>tmp-under.c; \=0A=
else \=0A=
  echo "int prepends_underscore =3D 0;" >>tmp-under.c; \=0A=
fi=0A=
./move-if-change tmp-under.c underscore.c=0A=
underscore.c is unchanged=0A=
rm -f tmp-dum.c tmp-dum.s=0A=
touch s-under=0A=
cp xgcc gcc-cross=0A=
/home/sliu/egcs-1.1.2/gcc/xgcc -B/home/sliu/egcs-1.1.2/gcc/ -dumpspecs > =
tmp-specs=0A=
mv tmp-specs specs=0A=
if [ -f libgcc2.ready ] ; then \=0A=
	true; \=0A=
else \=0A=
	touch libgcc2.ready; \=0A=
fi=0A=
rm -f tmplibgcc2.a=0A=
for name in _muldi3 _divdi3 _moddi3 _udivdi3 _umoddi3 _negdi2 _lshrdi3 =
_ashldi3 _ashrdi3 _ffsdi2 _udiv_w_sdiv _udivmoddi4 _cmpdi2 _ucmpdi2 =
_floatdidf _floatdisf _fixunsdfsi _fixunssfsi _fixunsdfdi _fixdfdi =
_fixunssfdi _fixsfdi _fixxfdi _fixunsxfdi _floatdixf _fixunsxfsi =
_fixtfdi _fixunstfdi _floatditf __gcc_bcmp _varargs __dummy _eprintf _bb =
_shtab _clear_cache _trampoline __main _exit _ctors _pure; \=0A=
do \=0A=
  echo ${name}; \=0A=
  /home/sliu/egcs-1.1.2/gcc/xgcc -B/home/sliu/egcs-1.1.2/gcc/ -O2  =
-DCROSS_COMPILE -DIN_GCC    -g -O2 -I./include   -g1  -DIN_LIBGCC2 =
-D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc  -I. -I. -I./config -c =
-DL${name} \=0A=
      ./libgcc2.c -o ${name}.o; \=0A=
  if [ $? -eq 0 ] ; then true; else exit 1; fi; \=0A=
  mips-linux-ar rc tmplibgcc2.a ${name}.o; \=0A=
  rm -f ${name}.o; \=0A=
done=0A=
_muldi3=0A=
xgcc: installation problem, cannot exec `mips-tfile': No such file or =
directory=0A=
make[1]: *** [libgcc2.a] Error 1=0A=
make[1]: Leaving directory `/home/sliu/egcs-1.1.2/gcc'=0A=
make: *** [all-gcc] Error 2=0A=

------=_NextPart_000_0017_01C0A2E5.00ECE6F0--
