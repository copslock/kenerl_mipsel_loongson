Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2002 19:19:44 +0200 (CEST)
Received: from www.2m.dk ([194.239.1.24]:38408 "HELO 2m.dk")
	by linux-mips.org with SMTP id <S1122978AbSIBRTn>;
	Mon, 2 Sep 2002 19:19:43 +0200
Received: by 2m.dk (Postfix, from userid 1)
	id A74BC1285; Mon,  2 Sep 2002 19:19:36 +0200 (CEST)
Received: from LarsN (unknown [194.239.1.62])
	by 2m.dk (Postfix) with SMTP id CF8A312A5
	for <linux-mips@linux-mips.org>; Mon,  2 Sep 2002 17:19:34 +0000 (/etc/localtime)
Message-ID: <00c301c252a4$9a802a00$016d100a@2m.dk>
From: "Stephen Mose Aaskov" <sma@2m.dk>
To: <linux-mips@linux-mips.org>
Subject: MTD drivers and byte/word mode
Date: Mon, 2 Sep 2002 19:17:23 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00C0_01C252B5.5DD69F60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Return-Path: <sma@2m.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sma@2m.dk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00C0_01C252B5.5DD69F60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I=B4m working on a 2.4 port to a design with FLASH devices connected =
through a 16 bit bus.
The FLASH (AMD) is set to word mode.

I have quite a hard time trying to understand the FLASH geometry =
settings and calculations of the addresses used for CFI query etc.
It looks as if the adresses calculated by cfi_build_cmd_addr() is the =
double of what my FLASH chips are using.
eg. the CFI query is written to 0xaa where my chip in word mode expects =
the query command to be written to 0x55

Is there any direct support in the MTD driver for differentiating =
between word/byte mode ?

The buswidth is set to 16 bits (=3D2), and interleave to 1 (I have two =
chips sharing the bus, not in parallel)



Stephen Mose Aaskov
Engineer, R&D
2M ELECTRONIC A/S
Malervej 10, DK-2630 Taastrup
Denmark
Tel: +45 43300555  Fax: +45 43300567

------=_NextPart_000_00C0_01C252B5.5DD69F60
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2614.3500" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I=B4m working on a 2.4 port to a design =
with FLASH=20
devices connected through a 16 bit bus.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The FLASH (AMD) is set to word =
mode.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have quite a hard time trying to =
understand the=20
FLASH geometry settings and calculations of the addresses used for CFI =
query=20
etc.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>It looks as if the adresses calculated =
by=20
cfi_build_cmd_addr() is the double of what my FLASH chips are=20
using.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>eg. the CFI query is written to 0xaa =
where my chip=20
in word mode expects the query command to be written to =
0x55</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is there any direct support in the MTD =
driver for=20
differentiating between word/byte mode ?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The buswidth is set to 16 bits (=3D2), =
and interleave=20
to 1 (I have two chips sharing the bus, not in parallel)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Stephen Mose Aaskov<BR>Engineer, =
R&amp;D<BR>2M=20
ELECTRONIC A/S<BR>Malervej 10, DK-2630 Taastrup<BR>Denmark<BR>Tel: +45=20
43300555&nbsp; Fax: +45 43300567</FONT></DIV></BODY></HTML>

------=_NextPart_000_00C0_01C252B5.5DD69F60--
