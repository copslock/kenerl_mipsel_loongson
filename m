Received:  by oss.sgi.com id <S553997AbRBVC3i>;
	Wed, 21 Feb 2001 18:29:38 -0800
Received: from [210.241.238.126] ([210.241.238.126]:772 "EHLO
        viditec-netmedia.com.tw") by oss.sgi.com with ESMTP
	id <S553699AbRBVC3Q>; Wed, 21 Feb 2001 18:29:16 -0800
Received: from kjlin ([210.241.238.122])
	by viditec-netmedia.com.tw (8.9.3/8.8.7) with SMTP id LAA28570
	for <linux-mips@oss.sgi.com>; Thu, 22 Feb 2001 11:11:04 +0800
Message-ID: <00ba01c09c6e$84788380$056aaac0@kjlin>
From:   "kjlin" <kj.lin@viditec-netmedia.com.tw>
To:     <linux-mips@oss.sgi.com>
Subject: Does linux support for microprocessor without MMU?
Date:   Thu, 22 Feb 2001 09:26:44 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00B7_01C09CB1.9247D720"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_00B7_01C09CB1.9247D720
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Howdy,

I got an embedded MIPS board recently.
It has the following features:
- CPU implements a five-stage pipeline with performance similar to the =
MIPS R3000 pipeline.
- MIPS32 compatible instruction set
- R4000 style privileged resource architecture.
- Without MMU.

I am estimating the possibility of porting linux on it.
Can Linux/MIPS 2.2 or 2.4 support for such a board which without MMU ?
Because i consider it is the most difficult part in the porting process.
Am i right?

KJ




------=_NextPart_000_00B7_01C09CB1.9247D720
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
<DIV><FONT size=3D2>Howdy,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>I got an embedded MIPS board recently.</FONT></DIV>
<DIV><FONT size=3D2>It has the following features:</FONT></DIV>
<DIV><FONT size=3D2>- CPU implements a five-stage pipeline with =
performance=20
similar to the MIPS&nbsp;R3000 pipeline.</FONT></DIV>
<DIV><FONT size=3D2>- MIPS32 compatible instruction set</FONT></DIV>
<DIV><FONT size=3D2>- R4000 style privileged resource =
architecture.</FONT></DIV>
<DIV><FONT size=3D2>- Without MMU.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>I am estimating the possibility of porting linux on=20
it.</FONT></DIV>
<DIV><FONT size=3D2>Can&nbsp;Linux/MIPS 2.2 or 2.4 support for such a =
board which=20
without MMU ?</FONT></DIV>
<DIV><FONT size=3D2>Because i consider it is the most difficult part in =
the=20
porting process.</FONT></DIV>
<DIV><FONT size=3D2>Am i right?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>KJ</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_00B7_01C09CB1.9247D720--
