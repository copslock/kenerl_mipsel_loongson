Received:  by oss.sgi.com id <S553719AbRCAByq>;
	Wed, 28 Feb 2001 17:54:46 -0800
Received: from smtp.psdc.com ([209.125.203.83]:17487 "EHLO smtp.psdc.com")
	by oss.sgi.com with ESMTP id <S553650AbRCAByY>;
	Wed, 28 Feb 2001 17:54:24 -0800
Received: from BANANA ([209.125.203.85])
	by smtp.psdc.com (8.8.8/8.8.8) with SMTP id RAA25611
	for <linux-mips@oss.sgi.com>; Wed, 28 Feb 2001 17:38:09 -0800
Message-ID: <001001c0a18e$3f494bd0$dde0490a@BANANA>
From:   "Steven Liu" <stevenliu@psdc.com>
To:     <linux-mips@oss.sgi.com>
Subject: mips-tfile and gcc.
Date:   Wed, 28 Feb 2001 05:56:28 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01C0A14B.31090DF0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_000D_01C0A14B.31090DF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, All:

I have just got a problem when I egcs-1.1.2 for MIPS R3000 under i386. I =
did the following.

./configure --prefix=3D/root/liumips/ --with-newlib =
--target=3Dmips-linux
make SUBDIRS=3D"libiberty textinfo gcc" ALLTARGET_MODULES=3D =
CONFIGURE_TARGET_MODULES=3D INSTALL_TARGET_MODULES=3D LANGUAGES=3D"c"

Here is what I got.

cp xgcc gcc-cross
/root/liumips/egcs-1.1.2/gcc/xgcc -B/root/liumips/egcs-1.1.2/gcc/ =
-dumpspecs > tmp-specs
mv tmp-specs specs
if [ -f libgcc2.ready ] ; then \
 true; \
else \
 touch libgcc2.ready; \
fi
rm -f tmplibgcc2.a
for name in _muldi3 _divdi3 _moddi3 _udivdi3 _umoddi3 _negdi2 _lshrdi3 =
_ashldi3 _ashrdi3 _ffsdi2 _udiv_w_sdiv _udivmoddi4 _cmpdi2 _ucmpdi2 =
_floatdidf _floatdisf _fixunsdfsi _fixunssfsi _fixunsdfdi _fixdfdi =
_fixunssfdi _fixsfdi _fixxfdi _fixunsxfdi _floatdixf _fixunsxfsi =
_fixtfdi _fixunstfdi _floatditf __gcc_bcmp _varargs __dummy _eprintf _bb =
_shtab _clear_cache _trampoline __main _exit _ctors _pure; \
do \
  echo ${name}; \
  /root/liumips/egcs-1.1.2/gcc/xgcc -B/root/liumips/egcs-1.1.2/gcc/ -O2  =
-DCROSS_COMPILE -DIN_GCC    -g -O2 -I./include   -g1  -DIN_LIBGCC2 =
-D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc  -I. -I. -I./config -c =
-DL${name} \
      ./libgcc2.c -o ${name}.o; \
  if [ $? -eq 0 ] ; then true; else exit 1; fi; \
  mips-linux-ar rc tmplibgcc2.a ${name}.o; \
  rm -f ${name}.o; \
done
_muldi3
xgcc: installation problem, cannot exec `mips-tfile': No such file or =
directory
make[1]: *** [libgcc2.a] Error 1
make[1]: Leaving directory `/root/liumips/egcs-1.1.2/gcc'
make: *** [all-gcc] Error 2

Thank you.

Steven Liu

------=_NextPart_000_000D_01C0A14B.31090DF0
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
<DIV><FONT face=3DArial size=3D2>Hi, All:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have just got a problem when I =
egcs-1.1.2 for=20
MIPS R3000 under i386. I did the following.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>./configure --prefix=3D/root/liumips/ =
--with-newlib=20
--target=3Dmips-linux</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>make SUBDIRS=3D"libiberty textinfo gcc" =

ALLTARGET_MODULES=3D CONFIGURE_TARGET_MODULES=3D =
INSTALL_TARGET_MODULES=3D=20
LANGUAGES=3D"c"</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Here is what I got.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>cp xgcc=20
gcc-cross<BR>/root/liumips/egcs-1.1.2/gcc/xgcc =
-B/root/liumips/egcs-1.1.2/gcc/=20
-dumpspecs &gt; tmp-specs<BR>mv tmp-specs specs<BR>if [ -f libgcc2.ready =
] ;=20
then \<BR>&nbsp;true; \<BR>else \<BR>&nbsp;touch libgcc2.ready; =
\<BR>fi<BR>rm -f=20
tmplibgcc2.a<BR>for name in _muldi3 _divdi3 _moddi3 _udivdi3 _umoddi3 =
_negdi2=20
_lshrdi3 _ashldi3 _ashrdi3 _ffsdi2 _udiv_w_sdiv _udivmoddi4 _cmpdi2 =
_ucmpdi2=20
_floatdidf _floatdisf _fixunsdfsi _fixunssfsi _fixunsdfdi _fixdfdi =
_fixunssfdi=20
_fixsfdi _fixxfdi _fixunsxfdi _floatdixf _fixunsxfsi _fixtfdi =
_fixunstfdi=20
_floatditf __gcc_bcmp _varargs __dummy _eprintf _bb _shtab _clear_cache=20
_trampoline __main _exit _ctors _pure; \<BR>do \<BR>&nbsp; echo ${name}; =

\<BR>&nbsp; /root/liumips/egcs-1.1.2/gcc/xgcc =
-B/root/liumips/egcs-1.1.2/gcc/=20
-O2&nbsp; -DCROSS_COMPILE -DIN_GCC&nbsp;&nbsp;&nbsp; -g -O2=20
-I./include&nbsp;&nbsp; -g1&nbsp; -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED=20
-Dinhibit_libc&nbsp; -I. -I. -I./config -c -DL${name}=20
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./libgcc2.c -o ${name}.o; =
\<BR>&nbsp; if [=20
$? -eq 0 ] ; then true; else exit 1; fi; \<BR>&nbsp; mips-linux-ar rc=20
tmplibgcc2.a ${name}.o; \<BR>&nbsp; rm -f ${name}.o;=20
\<BR>done<BR>_muldi3<BR>xgcc: installation problem, cannot exec =
`mips-tfile': No=20
such file or directory<BR>make[1]: *** [libgcc2.a] Error 1<BR>make[1]: =
Leaving=20
directory `/root/liumips/egcs-1.1.2/gcc'<BR>make: *** [all-gcc] Error=20
2</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thank you.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Steven Liu</FONT></DIV></BODY></HTML>

------=_NextPart_000_000D_01C0A14B.31090DF0--
