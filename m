Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA08036
	for <pstadt@stud.fh-heilbronn.de>; Sun, 8 Aug 1999 15:03:27 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA05997; Sun, 8 Aug 1999 06:00:25 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA66749
	for linux-list;
	Sun, 8 Aug 1999 05:33:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA66132;
	Sun, 8 Aug 1999 05:33:28 -0700 (PDT)
	mail_from (sccsmith@concentric.net)
Received: from uhura.concentric.net (uhura.concentric.net [206.173.118.93]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA05388; Sun, 8 Aug 1999 05:33:27 -0700 (PDT)
	mail_from (sccsmith@concentric.net)
Received: from cliff.concentric.net (cliff [206.173.118.90])
	by uhura.concentric.net (8.9.1a/(98/12/15 5.12))
	id IAA24395; Sun, 8 Aug 1999 08:30:13 -0400 (EDT)
	[1-800-745-2747 The Concentric Network]
Received: from Jennifer (ts002d13.stl-mo.concentric.net [206.173.152.73])
	by cliff.concentric.net (8.9.1a)
	id IAA03673; Sun, 8 Aug 1999 08:29:46 -0400 (EDT)
Message-ID: <004701bee19a$34f46e40$6501a8c0@Jennifer.cncx.com>
From: "Steven Smith" <sccsmith@concentric.net>
To: "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Configuring 2nd Drive
Date: Sun, 8 Aug 1999 07:33:18 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0044_01BEE170.48F11B20"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0044_01BEE170.48F11B20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Configure your disks
With IRIX tools, create an EFS partition on your Linux disk. Use command =
fx to do that. I recommend that you create the default "root" layout on =
the disk (provided you have the whole second disk for Linux). At this =
point, a swap partition won't be recognized. Yes, we're working on it. =
The installer does include fdisk, although it is untested.=20


I have used fx to create to root layout on my second drive, but when I =
use disk manager to try and make the EFS file system, Disk manager =
changes my partition back to a user partition. I can get linux to =
install doing that but linux cannot mount drive on reboot. Questions :

1. How do I get mkfs_efs to work using xterm window?
2. Where is there more information about configuring 2nd drive? I have =
read the web page about the mini-HOWTO, but I don't have a CDROM drive =
and my screen doesn't have the menu's that is referred to in the HOWTO.


Thanks,
Steven

------=_NextPart_000_0044_01BEE170.48F11B20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD W3 HTML//EN">
<HTML>
<HEAD>

<META content=3Dtext/html;charset=3Diso-8859-1 =
http-equiv=3DContent-Type>
<META content=3D'"MSHTML 4.72.3110.7"' name=3DGENERATOR>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<H3>Configure your disks</H3>With IRIX tools, create an EFS partition on =
your=20
Linux disk. Use command <TT>fx</TT> to do that. I recommend that you =
create the=20
default &quot;root&quot; layout on the disk (provided you have the whole =
second=20
disk for Linux). At this point, a swap partition won't be recognized. =
Yes, we're=20
working on it. The installer does include fdisk, although it is =
untested. </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>I have used fx to create to root =
layout on my=20
second drive, but when I use disk manager to try and make the EFS file =
system,=20
Disk manager changes my partition back to a user partition. I can get =
linux to=20
install doing that but linux cannot mount drive on reboot. Questions=20
:</FONT></DIV>
<DIV><FONT color=3D#000000 size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>1. How do I get mkfs_efs to work =
using xterm=20
window?</FONT></DIV>
<DIV><FONT color=3D#000000 size=3D2>2. Where is there more information =
about=20
configuring 2nd drive? I have read the web page about the mini-HOWTO, =
but I=20
don't have a CDROM drive and my screen doesn't have the menu's that is =
referred=20
to in the HOWTO.</FONT></DIV>
<DIV><FONT color=3D#000000 size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>Thanks,</FONT></DIV>
<DIV><FONT color=3D#000000 size=3D2>Steven</FONT></DIV></BODY></HTML>

------=_NextPart_000_0044_01BEE170.48F11B20--
