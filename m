Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 02:51:55 +0100 (BST)
Received: from simp98.iserver.net ([IPv6:::ffff:128.121.222.84]:10724 "EHLO
	simp98.iserver.net") by linux-mips.org with ESMTP
	id <S8225583AbTJIBvX>; Thu, 9 Oct 2003 02:51:23 +0100
Received: from simpledemkyosn (dsl092-191-011.sfo1.dsl.speakeasy.net [66.92.191.11])
	by simp98.iserver.net (8.12.9p1/8.11.2) with SMTP id h991pJ2Q024739
	for <linux-mips@linux-mips.org>; Thu, 9 Oct 2003 01:51:21 GMT
Message-ID: <00b001c38e03$bbc23960$e201a8c0@simpledemkyosn>
From: "Yuri" <yuri@simpledevices.com>
To: <linux-mips@linux-mips.org>
Subject: tx4927 support (newbie question)
Date: Wed, 8 Oct 2003 18:21:57 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00AD_01C38DC9.0EA8EB00"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Return-Path: <yuri@simpledevices.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuri@simpledevices.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00AD_01C38DC9.0EA8EB00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I'm trying to get the 2.4 kernel running on rbtx4927 toshiba eval board.
There are config options to enable the board support in the kernel tree =
and also some relatively recent patches
specific to the board.  However the furthest I could get in the boot =
process is to the calibration of the delay loop.
I'm not sure whether all of the interrupts are disabled or just the =
timer, but jiffies are not getting incremented.  As far as I could trace =
it so far, the right irq setup routines are called in the init, but to =
no avail.  I'm using mipsel-linux-gcc version 2.95.4. version 2.95.3 had =
the same results.  I have tried linux_2_4 and linux_2_4_22_rc3 tags of =
the cvs
Thanks
Yuri


------=_NextPart_000_00AD_01C38DC9.0EA8EB00
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3700.6699" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm trying to get the 2.4 kernel =
running on=20
rbtx4927 toshiba eval board.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>There are config options to enable the =
board=20
support in the kernel tree and also some relatively recent =
patches</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>specific to the board.&nbsp; However =
the furthest I=20
could get in the boot process is to the calibration of the delay=20
loop.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm not sure whether&nbsp;all of the =
interrupts=20
are&nbsp;disabled or just the timer, but jiffies are not&nbsp;getting=20
incremented.&nbsp; As far as I could trace it so far, the right irq =
setup=20
routines are called in the init, but to no avail.&nbsp; I'm using=20
mipsel-linux-gcc version 2.95.4.&nbsp;version 2.95.3 had the same =
results.&nbsp;=20
I have tried linux_2_4 and linux_2_4_22_rc3 tags of the cvs</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Yuri</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_00AD_01C38DC9.0EA8EB00--
