Received:  by oss.sgi.com id <S553822AbRCFArY>;
	Mon, 5 Mar 2001 16:47:24 -0800
Received: from smtp.psdc.com ([209.125.203.83]:51788 "EHLO smtp.psdc.com")
	by oss.sgi.com with ESMTP id <S553819AbRCFArX>;
	Mon, 5 Mar 2001 16:47:23 -0800
Received: from BANANA ([209.125.203.85])
	by smtp.psdc.com (8.8.8/8.8.8) with SMTP id QAA01895
	for <linux-mips@oss.sgi.com>; Mon, 5 Mar 2001 16:31:02 -0800
Message-ID: <000801c0a572$b7471e40$dde0490a@BANANA>
From:   "Steven Liu" <stevenliu@psdc.com>
To:     <linux-mips@oss.sgi.com>
Subject: mips-tfile
Date:   Mon, 5 Mar 2001 04:49:28 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C0A52F.A8FAAB60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C0A52F.A8FAAB60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, All:

Hi, All:

I am working on cross-compiler for mips R3000 on Linux now and meet a =
problem in egcs.

My host system is i386 with Rad Hat 7.0 installed.

First, I successfully built and installed binutils-2.8.1 by using=20
binutils-2.8.1.tar.gz and egcs-mips-linux-1.1.2-2.i386.rpm. This created =

bin, lib, mips-linux subdirectories.

Second, I installed the linux kernel source code for mips by using=20
linux-2.2.14-000715.tar.gz and configured it and enabled=20
CONFIG_CROSSCOMPILE.  Made soft links: let  mips-linux/include/asm=20
pointd to linux-2.2.14-000715/include/asm-mips and
mips-linux/include/linux pointd to linux-2.2.14-000715/include/linux.

Third, unziped the egcs-1.1.2.tar.gz, added the patch=20
egcs-mips-linux-1.1.2-2.i386.rpm and configured it as following:
     ./configure --prefix=3D3D/home/sliu --with-newlib =
--target=3Dmips-linux
and made it this way:
     make SUBDIRS=3D3D"libiberty texinfo gcc" ALL_TARGET_MODULES=3D3D =
=3D
CONFIGURE_TARGET_MODULES=3D3D INSTALL_TARGET_MODULES=3D3D =
LANGUAGES=3D3D"c"

Then, it gave the following errors in gcc subdirectory:

xgcc: installation problem, cannot exec `mips-tfile': No such file or =
=3D
directory
make[1]: *** [libgcc2.a] Error 1
make[1]: Leaving directory `/home/sliu/egcs-1.1.2/gcc'
make: *** [all-gcc] Error 2

Any help would be greatly appreciated.

Regards,


Steven

------=_NextPart_000_0005_01C0A52F.A8FAAB60
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
<DIV><FONT face=3DArial size=3D2>Hi, All:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am working on cross-compiler for mips =
R3000 on=20
Linux now and meet a problem in egcs.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My host system is i386 with Rad Hat 7.0 =

installed.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>First, I successfully built and =
installed=20
binutils-2.8.1 by using <BR>binutils-2.8.1.tar.gz and=20
egcs-mips-linux-1.1.2-2.i386.rpm. This created <BR>bin, lib, mips-linux=20
subdirectories.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Second, I installed the linux kernel =
source code=20
for mips by using <BR>linux-2.2.14-000715.tar.gz and configured it and =
enabled=20
<BR>CONFIG_CROSSCOMPILE.&nbsp; Made soft links: let&nbsp; =
mips-linux/include/asm=20
<BR>pointd to linux-2.2.14-000715/include/asm-mips=20
and<BR>mips-linux/include/linux pointd to=20
linux-2.2.14-000715/include/linux.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Third, unziped the egcs-1.1.2.tar.gz, =
added the=20
patch <BR>egcs-mips-linux-1.1.2-2.i386.rpm and configured it as=20
following:<BR>&nbsp;&nbsp;&nbsp;&nbsp; ./configure =
--prefix=3D3D/home/sliu=20
--with-newlib --target=3Dmips-linux<BR>and made it this=20
way:<BR>&nbsp;&nbsp;&nbsp;&nbsp; make SUBDIRS=3D3D"libiberty texinfo =
gcc"=20
ALL_TARGET_MODULES=3D3D =3D<BR>CONFIGURE_TARGET_MODULES=3D3D =
INSTALL_TARGET_MODULES=3D3D=20
LANGUAGES=3D3D"c"</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Then, it gave the following errors in =
gcc=20
subdirectory:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>xgcc: installation problem, cannot exec =

`mips-tfile': No such file or =3D<BR>directory<BR>make[1]: *** =
[libgcc2.a] Error=20
1<BR>make[1]: Leaving directory `/home/sliu/egcs-1.1.2/gcc'<BR>make: *** =

[all-gcc] Error 2</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any help would be greatly =
appreciated.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><BR>Steven</FONT></DIV></BODY></HTML>

------=_NextPart_000_0005_01C0A52F.A8FAAB60--
