Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Sep 2004 10:07:26 +0100 (BST)
Received: from [IPv6:::ffff:218.108.42.27] ([IPv6:::ffff:218.108.42.27]:56773
	"EHLO hzvscan2.utstar.com.cn") by linux-mips.org with ESMTP
	id <S8224922AbUIDJHV>; Sat, 4 Sep 2004 10:07:21 +0100
Received: from cnmail01.cn.utstarcom.com (localhost [127.0.0.1])
	by hzvscan2.utstar.com.cn (8.11.6/8.11.6) with SMTP id i8493DR17682
	for <linux-mips@linux-mips.org>; Sat, 4 Sep 2004 17:03:13 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4925E.9C852458"
Subject: How to compile the  binutils-2.13.2.1.tar.gz  build for mips
Date: Sat, 4 Sep 2004 17:07:30 +0800
Message-ID: <BA3B937FD9473E41998E125463A3914301C682CD@cnmail01.cn.utstarcom.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to compile the  binutils-2.13.2.1.tar.gz  build for mips
Thread-Index: AcSSXpumnKR+FzoRTCCOYhpP1FROog==
From: "Li Shishan" <lishishan@utstar.com>
To: <linux-mips@linux-mips.org>
Return-Path: <lishishan@utstar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lishishan@utstar.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4925E.9C852458
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable




 Hi All:

           I try to build toolchain for big-endian mips , But the first =
step , When I building the binutils , some troubles happened. Can each =
of all help me resolve it.
The step I followed like below:

       gzip -cd binutils-<version>.tar.gz | tar xf -
    cd binutils-<version>
    patch -p1 < ../binutils-<version>-mips.patch
    ./configure --prefix=3D<prefix> --target=3D<target>
    make CFLAGS=3D-O2

 But ,I make it not success, there some comple error:

  gcc -W -Wall -Wstrict-prototypes -Wmissing-prototypes -g -O2 -o =
objdump objdump.o      budemang.o prdbg.o rddbg.o debug.o stabs.o ieee.o =
rdcoff.o bucomm.o version.o filemode.o  ../opcodes/.libs/libopcodes.a =
../bfd/.libs/libbfd.a ../libiberty/libiberty.a
bucomm.o(.text+0x3f6): In function `make_tempname':
/home/liss/bmips/binutils-2.13.2.1/binutils/bucomm.c:238: warning: the =
use of `mktemp' is dangerous, better use `mkstemp'
../libiberty/libiberty.a(cp-demangle.o)(.text+0xd64): In function =
`demangle_identifier':
/home/liss/bmips/binutils-2.13.2.1/libiberty/cp-demangle.c:1486: =
undefined reference to `__ctype_b'
collect2: ld returned 1 exit status
make[3]: *** [objdump] Error 1
make[3]: Leaving directory `/home/liss/bmips/binutils-2.13.2.1/binutils'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/liss/bmips/binutils-2.13.2.1/binutils'
make[1]: *** [all-recursive-am] Error 2
make[1]: Leaving directory `/home/liss/bmips/binutils-2.13.2.1/binutils'
make: *** [all-binutils] Error 2

  I think the source code is some error,but when I download the =
binutils2.14 ,binutils2.15 ,the error all exit.  So I cann't know what's =
wrong with it,the source is wrong ? or my operation isn't right.
 =20
   Hoping for anybody reply to me ,very thanks.  =20


your sincerely liss
2004.09.04  17:07
 =20


  =20


------_=_NextPart_001_01C4925E.9C852458
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.6980.72">
<TITLE>How to compile the  binutils-2.13.2.1.tar.gz  build for =
mips</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>
<BR>
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"><B></B></FONT><B>&nbsp;<FONT SIZE=3D4 FACE=3D"Arial">Hi =
All:</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D4 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; </FONT><FONT COLOR=3D"#0000FF" SIZE=3D4 FACE=3D"Arial">I try to build =
toolchain for big-</FONT><FONT COLOR=3D"#0000FF" SIZE=3D5 =
FACE=3D"Arial">endian mips ,</FONT></B> <FONT COLOR=3D"#0000FF" SIZE=3D5 =
FACE=3D"Arial">But the first step , When I building the binutils , some =
troubles happened. Can each of all help me resolve it.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D5 =
FACE=3D"Arial">The step I followed like below:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;</FONT> <FONT SIZE=3D5 =
FACE=3D"Simsun">&nbsp; gzip -cd binutils-&lt;version&gt;.tar.gz | tar xf =
-<BR>
&nbsp;&nbsp;&nbsp; cd binutils-&lt;version&gt;<BR>
&nbsp;&nbsp;&nbsp; patch -p1 &lt; =
../binutils-&lt;version&gt;-mips.patch<BR>
&nbsp;&nbsp;&nbsp; ./configure --prefix=3D&lt;prefix&gt; =
--target=3D&lt;target&gt;<BR>
&nbsp;&nbsp;&nbsp; make CFLAGS=3D-O2</FONT></B></SPAN></P>
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT COLOR=3D"#0000FF" SIZE=3D5 =
FACE=3D"Simsun">&nbsp;But ,I make it not success, there some comple =
error:</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">&nbsp; gcc -W -Wall -Wstrict-prototypes =
-Wmissing-prototypes -g -O2 -o objdump =
objdump.o&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; budemang.o prdbg.o rddbg.o =
debug.o stabs.o ieee.o rdcoff.o bucomm.o version.o filemode.o&nbsp; =
../opcodes/.libs/libopcodes.a ../bfd/.libs/libbfd.a =
../libiberty/libiberty.a</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">bucomm.o(.text+0x3f6): In function =
`make_tempname':</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">/home/liss/bmips/binutils-2.13.2.1/binutils/bucomm.c:238:=
 warning: the use of `mktemp' is dangerous, better use =
`mkstemp'</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">../libiberty/libiberty.a(cp-demangle.o)(.text+0xd64): In =
function `demangle_identifier':</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">/home/liss/bmips/binutils-2.13.2.1/libiberty/cp-demangle.=
c:1486: undefined reference to `__ctype_b'</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">collect2: ld returned 1 exit =
status</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">make[3]: *** [objdump] Error 1</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">make[3]: Leaving directory =
`/home/liss/bmips/binutils-2.13.2.1/binutils'</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">make[2]: *** [all-recursive] Error =
1</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">make[2]: Leaving directory =
`/home/liss/bmips/binutils-2.13.2.1/binutils'</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">make[1]: *** [all-recursive-am] Error =
2</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">make[1]: Leaving directory =
`/home/liss/bmips/binutils-2.13.2.1/binutils'</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">make: *** [all-binutils] Error 2</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT COLOR=3D"#0000FF" SIZE=3D5 =
FACE=3D"Simsun">&nbsp; I think the source code is some error,but when I =
download the binutils2.14 ,binutils2.15 ,the error all exit.&nbsp; So I =
cann't know what's wrong with it,the source is wrong ? or my operation =
isn't right.</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">&nbsp; </FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">&nbsp;&nbsp; Hoping for anybody reply to me ,very =
thanks.&nbsp;&nbsp; </FONT></B></SPAN></P>
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 FACE=3D"Simsun">your =
sincerely liss</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">2004.09.04&nbsp; 17:07</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D5 =
FACE=3D"Simsun">&nbsp; </FONT></B></SPAN></P>
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Simsun">&nbsp;&nbsp; </FONT></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C4925E.9C852458--
