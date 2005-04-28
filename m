Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 15:51:04 +0100 (BST)
Received: from [IPv6:::ffff:61.246.180.169] ([IPv6:::ffff:61.246.180.169]:48649
	"EHLO mail.netsity.com") by linux-mips.org with ESMTP
	id <S8225783AbVD1Oum>; Thu, 28 Apr 2005 15:50:42 +0100
Received: by mail.netsity.com with Internet Mail Service (5.5.2653.19)
	id <JTJF9DG8>; Thu, 28 Apr 2005 20:20:32 +0530
Received: from ISINGH ([192.168.103.60]) by mail.netsity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id JTJF9DG7; Thu, 28 Apr 2005 20:20:24 +0530
From:	Inpreet Singh <Singh.Inpreet@netsity.com>
To:	linux-mips@linux-mips.org
Message-ID: <015301c54c01$9b8e4e00$3c67a8c0@netsity.com>
Subject: GD Library on MIPS Processor
Date:	Thu, 28 Apr 2005 20:20:23 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0150_01C54C2F.B52EBC40"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <Singh.Inpreet@netsity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Singh.Inpreet@netsity.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0150_01C54C2F.B52EBC40
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Sir I am using gd library on Linux intel processor sucessfully but now =
I
want to do same on MIPS. I don't know to how install, configure and =
test
gd library on MIPS. Sir please give me some clue or link to study for
the same.
=20
I tried to configure gd library compilation using following command =
from
linux intel processor:
=20
./configure --host=3Dmips
and it makes Makefile with some differences
***************************************************
host_triplet =3D mips-unknown-elf
host =3D mips-unknown-elf
host_alias =3D mips
host_cpu =3D mips
***************************************************
Now I tried to build a example using this Makefile "make gddemo". What =
I
expect that it will create gddemo binary that will output in correctly
on MIPS processor. But when I run this binary on MIPS it is showing
errors.
**************************************************************
/launchpad # ./gddemo
./gddemo: 1: Syntax error: "(" unexpected
**************************************************************
Also I have downloaded debian packages for gd library on MIPS processor
but don't know how to install them. I tried dpkg command but it shows =
no
such command. So sir please help me out.
So please help me how should I proceed.
Regards
=20
Inpreet singh

------=_NextPart_000_0150_01C54C2F.B52EBC40
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>

<META content=3D"MSHTML 6.00.2800.1479" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DVerdana size=3D2>
<DIV><FONT face=3DVerdana size=3D2>Sir I am using gd library on Linux =
intel=20
processor sucessfully but now&nbsp;I want to do same on MIPS.&nbsp;I =
don't know=20
to how install, configure and test&nbsp;gd library on MIPS. Sir please =
give me=20
some clue or link to study for the same.</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>
<DIV><FONT face=3DVerdana size=3D2>I tried to configure gd library =
compilation using=20
following command from linux intel processor:</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>./configure --host=3Dmips<BR>and it =
makes Makefile=20
with some differences</FONT></DIV>
<DIV><FONT face=3DVerdana=20
size=3D2>***************************************************</FONT></DIV=
>
<DIV><FONT face=3DVerdana size=3D2>host_triplet =3D =
mips-unknown-elf</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>host =3D =
mips-unknown-elf<BR>host_alias =3D=20
mips<BR>host_cpu =3D mips</DIV></FONT>
<DIV>
<DIV><FONT face=3DVerdana=20
size=3D2>***************************************************</FONT></DIV=
>
<DIV><FONT face=3DVerdana size=3D2>Now I tried to build a example using =
this=20
Makefile "make gddemo". What I expect that it will create gddemo binary =
that=20
will output in correctly on MIPS processor. But when I run this binary =
on MIPS=20
it is showing errors.</FONT></DIV>
<DIV>**************************************************************</DIV=
>
<DIV>/launchpad # ./gddemo<BR>./gddemo: 1: Syntax error: "(" =
unexpected</DIV>
<DIV><FONT face=3DVerdana=20
size=3D2>**************************************************************<=
/FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>Also I have downloaded debian =
packages for gd=20
library on MIPS processor but don't know how to install them. I tried =
dpkg=20
command but it shows no such command. So sir please help me =
out.</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>So please help me how should I=20
proceed.</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>Inpreet=20
singh</FONT></DIV></DIV></FONT></DIV></FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_0150_01C54C2F.B52EBC40--
