Received:  by oss.sgi.com id <S553692AbRADBjM>;
	Wed, 3 Jan 2001 17:39:12 -0800
Received: from mail.cosinecom.com ([63.88.104.16]:37895 "EHLO
        exchsrv1.cosinecom.com") by oss.sgi.com with ESMTP
	id <S553646AbRADBiz>; Wed, 3 Jan 2001 17:38:55 -0800
Received: by exchsrv1.cosinecom.com with Internet Mail Service (5.5.2650.21)
	id <Y4YLXZFD>; Wed, 3 Jan 2001 17:36:46 -0800
Message-ID: <7EB7C6B62C4FD41196A80090279A29113D7353@exchsrv1.cosinecom.com>
From:   John Van Horne <JohnVan.Horne@cosinecom.com>
To:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Cc:     "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: 
Date:   Wed, 3 Jan 2001 17:36:44 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C075EE.CBD95CA0"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C075EE.CBD95CA0
Content-Type: text/plain;
	charset="iso-8859-1"

Hello,

I downloaded cross-all-001027.tar from
oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev,
built it on my ix86 Linux box, and have tried to use it on our Linux
application and Linux kernel.
I'm getting errors which we didn't see when we were using
binutils-mips-linux-2.8.1 and
egcs-mips-linux-1.0.3a.

First, while the kernel builds just fine, when we use objcopy to convert the
elf image into a binary
image which we can download to our target, objcopy fails with warnings
saying that it is writing
sections to huge (i.e. negative) file offsets. When I use objdump to analyze
the kernel image,
I see that our start address of 0x80102584 has been turned into
0xffffffff80102584. I'm thinking that
I need to tell ld something to stop it from doing this. Any ideas?

Second, the way we build our application, we first create a partially linked
image, with the -r flag. Then 
we run ld on this (and an additional object file). When we do this with the
tools from cross-all-001027
we get the following error on the second link step:

mips-linux-ld:  BFD internal error, aborting at
/homes/local/mips-cross/crossdev-build/src/binutils-001027/bfd/elf32-mips.c
line 6942 in _bfd_mips_elf_relocate_section

mips-linux-ld: Please report this bug.

Actually, on the application we didn't get this far using
binutils-mips-linux-2.8.1 and egcs-mips-linux-1.0.3a,
so I have nothing to compare it to.  I'm not sure if this is a bug or if I
should be passing some flags to gcc or ld.

Any help you can provide would be appreciated.

Thanks,
-John



------_=_NextPart_001_01C075EE.CBD95CA0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2652.35">
<TITLE></TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I downloaded cross-all-001027.tar from =
oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">built it on my ix86 Linux box, and =
have tried to use it on our Linux application and Linux kernel.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I'm getting errors which we didn't =
see when we were using binutils-mips-linux-2.8.1 and</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">egcs-mips-linux-1.0.3a.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">First, while the kernel builds just =
fine, when we use objcopy to convert the elf image into a binary</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">image which we can download to our =
target, objcopy fails with warnings saying that it is writing</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">sections to huge (i.e. negative) file =
offsets. When I use objdump to analyze the kernel image,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I see that our start address of =
0x80102584 has been turned into 0xffffffff80102584. I'm thinking =
that</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I need to tell ld something to stop =
it from doing this. Any ideas?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Second, the way we build our =
application, we first create a partially linked image, with the -r =
flag. Then </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">we run ld on this (and an additional =
object file). When we do this with the tools from =
cross-all-001027</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">we get the following error on the =
second link step:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">mips-linux-ld:&nbsp; BFD internal =
error, aborting at =
/homes/local/mips-cross/crossdev-build/src/binutils-001027/bfd/elf32-mip=
s.c line 6942 in _bfd_mips_elf_relocate_section</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">mips-linux-ld: Please report this =
bug.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Actually, on the application we didn't =
get this far using binutils-mips-linux-2.8.1 and =
egcs-mips-linux-1.0.3a,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">so I have nothing to compare it =
to.&nbsp; I'm not sure if this is a bug or if I should be passing some =
flags to gcc or ld.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Any help you can provide would be =
appreciated.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">-John</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C075EE.CBD95CA0--
