Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56HxEm09563
	for linux-mips-outgoing; Wed, 6 Jun 2001 10:59:14 -0700
Received: from op.teknuts.com (139.muba.lsan.lsancass.dsl.att.net [12.98.69.139])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56HxDh09560
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 10:59:13 -0700
Received: from rjrtower (2093182197.weiderpub.com [209.3.182.197] (may be forged))
	(authenticated)
	by op.teknuts.com (8.11.3/8.10.1) with ESMTP id f56HxCR01722
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 10:59:12 -0700
Message-ID: <006001c0eeb2$642a7f70$031010ac@rjrtower>
From: "Robert Rusek" <robru@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: SGI Challenge S Serial Port (zs0) Driver question 
Date: Wed, 6 Jun 2001 10:59:11 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_005D_01C0EE77.B777BB10"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_005D_01C0EE77.B777BB10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am trying to install RedHat 5.1 Linux on my Challenge.  I finally got =
the kernel to boot from the prom via bootp/tftp.  The loading of the =
kernel stops with the following messag:

Warning: unable to open an initial console.

The HOW-TO states the following:


-------------------------------------------------------------------------=
-------
This problem has two possible solutions. First make sure you actually =
have a driver for the console of your system configured. If this is the =
case and the problem persists you probably got victim of a widespead bug =
in Linux distributions and root filesystems out there. The console of a =
Linux systems should be a character device of major id 5, minor 1 with =
permissions of 622 and owned by user and group root. If that's not the =
case, cd to the root of the filesystem and execute the following =
commands as root:=20

   rm -f dev/console
   mknod --mode=3D622 dev/console
 =20

You can also do this on a NFS root filesystem, even on the NFS server =
itself. However note that the major and minor ids are changed by NFS, =
therefore you must do this from a Linux system even if it's only a NFS =
client or the major / minor ID might be wrong when your Linux client =
boots from it.=20
-------------------------------------------------------------------------=
-------


I have followed the above instructions and still I get:

Warning: unable to open an initial console.

I would assume then that I need a special driver for for the serial port =
(zs0).  Just to clarify I am connecting a terminal to the serial port of =
the Challenge.

Any help would be greatly appreciated.

Thank you in advance,
Robert Rusek

------=_NextPart_000_005D_01C0EE77.B777BB10
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4611.1300" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I am trying to install RedHat 5.1 Linux =
on my=20
Challenge.&nbsp; I finally got the kernel to boot from the prom via=20
bootp/tftp.&nbsp; The loading of the kernel stops with the following=20
messag:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><STRONG>Warning: unable to open an initial console</STRONG>.</DIV>
<DIV>
<P>
<P><FONT face=3DArial size=3D2>The HOW-TO states the following:</FONT>
<P>
<HR>
This problem has two possible solutions. First make sure you actually =
have a=20
driver for the console of your system configured. If this is the case =
and the=20
problem persists you probably got victim of a widespead bug in Linux=20
distributions and root filesystems out there. The console of a Linux =
systems=20
should be a character device of major id 5, minor 1 with permissions of =
622 and=20
owned by user and group root. If that's not the case, cd to the root of =
the=20
filesystem and execute the following commands as root: <PRE>   rm -f =
dev/console
   mknod --mode=3D622 dev/console
 =20
</PRE>You can also do this on a NFS root filesystem, even on the NFS =
server=20
itself. However note that the major and minor ids are changed by NFS, =
therefore=20
you must do this from a Linux system even if it's only a NFS client or =
the major=20
/ minor ID might be wrong when your Linux client boots from it.=20
<HR>
</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have followed the above instructions =
and still I=20
get:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><STRONG>Warning: unable to open an initial console</STRONG>.</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I would assume then that I need a =
special driver=20
for for the serial port (zs0).&nbsp; Just to clarify I am connecting a =
terminal=20
to the serial port of the Challenge.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any help would be greatly =
appreciated.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thank you in advance,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Robert Rusek</FONT></DIV></BODY></HTML>

------=_NextPart_000_005D_01C0EE77.B777BB10--
