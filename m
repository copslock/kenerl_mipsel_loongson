Received:  by oss.sgi.com id <S553897AbQLTLP3>;
	Wed, 20 Dec 2000 03:15:29 -0800
Received: from [210.241.238.126] ([210.241.238.126]:46097 "EHLO
        viditec-netmedia.com.tw") by oss.sgi.com with ESMTP
	id <S553895AbQLTLPH>; Wed, 20 Dec 2000 03:15:07 -0800
Received: from kjlin ([210.241.238.122])
	by viditec-netmedia.com.tw (8.9.3/8.8.7) with SMTP id TAA29446
	for <linux-mips@oss.sgi.com>; Wed, 20 Dec 2000 19:22:43 +0800
Message-ID: <053601c06a6c$ee66ca60$056aaac0@kjlin>
From:   "kjlin" <kj.lin@viditec-netmedia.com.tw>
To:     <linux-mips@oss.sgi.com>
Subject: Run the cross-compiled program.
Date:   Wed, 20 Dec 2000 18:09:25 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0533_01C06AAF.FC7019C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_0533_01C06AAF.FC7019C0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Can anyone point out which step i done wrong in the process of =
cross-compiling an program with the -static option?
I made the cross-compile toolkit by myself.
All the source code and patches for cross-compile were downloaded from =
the SGI ftp site.
The version is as following:
cross-binutils =3D version 2.10.90
cross-gcc =3D version 2.96 20000707
cross-usable glibc =3D libc-2.1.90
The cross-compile toolkits building process is ok!
I used the cross-compiler to compile a program with the " -static " =
option in the host and then ran it on the target.
But i got the error message:
# ./a.out
FATAL: kernel too old
Aborted

Where i be trapped?
My host system is x86 running linux-2.2.14(Redhat 6.2).
My target system is an embedded mips board running linux-2.2.14 and =
shell is the statically linked ash binary from a lib-2.6.0 =
filesystem(kernel version unknown).
By the way, i builded the cross-usable glibc-2.1.90 with configure =
"--enable-kernel=3D2.2.14".

Thanx,
KJ from kj.lin@viditec-netmedia.com.tw

------=_NextPart_000_0533_01C06AAF.FC7019C0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dbig5" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2919.6307" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Can anyone point out which step i done wrong in the =
process of=20
cross-compiling an program with the -static option?<BR>I made the =
cross-compile=20
toolkit by myself.<BR>All the source code and patches for cross-compile =
were=20
downloaded from the SGI ftp site.<BR>The version is as=20
following:<BR>cross-binutils =3D version 2.10.90<BR>cross-gcc =3D =
version 2.96=20
20000707<BR>cross-usable glibc =3D libc-2.1.90<BR>The cross-compile =
toolkits=20
building process is ok!<BR>I&nbsp;used the cross-compiler to compile a =
program=20
with the " -static " option in the host and then ran it on the =
target.<BR>But i=20
got the error message:</FONT></DIV>
<DIV><FONT size=3D2># ./a.out</FONT></DIV>
<DIV><FONT size=3D2>FATAL: kernel too old<BR>Aborted</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>Where i be trapped?<BR>My host system is x86 running =

linux-2.2.14(Redhat 6.2).<BR>My target system is an embedded mips board =
running=20
linux-2.2.14 and shell is the statically linked ash binary from a =
lib-2.6.0=20
filesystem(kernel version unknown).<BR>By the way, i builded the =
cross-usable=20
glibc-2.1.90 with configure "--enable-kernel=3D2.2.14".<BR></FONT></DIV>
<DIV><FONT size=3D2>Thanx,</FONT></DIV>
<DIV><FONT size=3D2>KJ from <A=20
href=3D"mailto:kj.lin@viditec-netmedia.com.tw">kj.lin@viditec-netmedia.co=
m.tw</A></DIV></FONT></BODY></HTML>

------=_NextPart_000_0533_01C06AAF.FC7019C0--
