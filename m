Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 11:03:15 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:45473 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225478AbTIXKDN>;
	Wed, 24 Sep 2003 11:03:13 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h8OA0EYY025999;
	Wed, 24 Sep 2003 03:00:14 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA16863;
	Wed, 24 Sep 2003 03:03:24 -0700 (PDT)
Message-ID: <00d301c38283$67145be0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Gill" <gill.robles@exterity.co.uk>, <linux-mips@linux-mips.org>
References: <000901c3826e$9703adc0$4300a8c2@gillpc>
Subject: Re: Page fault question
Date: Wed, 24 Sep 2003 12:05:31 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00CE_01C38294.271C4280"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00CE_01C38294.271C4280
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The EMMA2 (uPD61130) uses the NEC Vr4130 core, wheras the EMMA2L =
(uPD61120)
uses a MIPS 4Kc core.  The 4Kc is a MIPS32-compliant core, but the =
Vr41xx family
predates the MIPS32 spec for the MMU interface, and has some significant =
incompatibilities,
mostly due to the fact that the Vr4100's assume a 1K page granularity, =
versus 4K for the 4Kc
and almost all other MIPS processors.  You can't use the same MMU code =
for both chips.
One kernel needs to be configured for a "MIPS32" CPU, the other for =
"R41xx".
  ----- Original Message -----=20
  From: Gill=20
  To: linux-mips@linux-mips.org=20
  Sent: Wednesday, September 24, 2003 9:36 AM
  Subject: Page fault question


  Hello -



  I'm currently porting vmlinux from NEC's EMMA2L platform to EMMA2.  =
The problem I'm having is that linux hangs when it attempts to do its =
first page fault: the page fault handler is successfully called, the =
call to handle_mm_fault returns 2 (major fault).but then code execution =
appears to just stop.  Linux is not completely dead, however - it still =
responds to a timer interrupt.



  As the code for handling page faults is standard code, and TLB =
hardware should be the same on EMMA2 as on EMMA2L (where it works!), I =
don't understand what's gone wrong!  Does anyone have any ideas?



  Thanks for your help,





  Gill

------=_NextPart_000_00CE_01C38294.271C4280
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4919.2200" name=3DGENERATOR>
<STYLE>@page Section1 {size: 595.3pt 841.9pt; margin: 72.0pt 90.0pt =
72.0pt 90.0pt; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: Arial
}
DIV.Section1 {
	page: Section1
}
</STYLE>
</HEAD>
<BODY lang=3DEN-GB vLink=3Dpurple link=3Dblue bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>The EMMA2 (uPD61130) uses the NEC =
Vr4130 core,=20
wheras the EMMA2L (uPD61120)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>uses a MIPS 4Kc core.&nbsp; The 4Kc is =
a=20
MIPS32-compliant core, but the Vr41xx family</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>predates the MIPS32 spec for the MMU =
interface, and=20
has some significant incompatibilities,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mostly due to the fact that the =
Vr4100's assume a=20
1K page granularity, versus 4K for the 4Kc</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and almost all other MIPS =
processors.&nbsp; You=20
can't use the same MMU code for both chips.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>One kernel needs to be configured for a =
"MIPS32"=20
CPU, the other for "R41xx".</FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dgill.robles@exterity.co.uk=20
  href=3D"mailto:gill.robles@exterity.co.uk">Gill</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dlinux-mips@linux-mips.org=20
  =
href=3D"mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, September 24, =
2003 9:36=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Page fault =
question</DIV>
  <DIV><BR></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hello =
=96</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I=92m currently porting =
vmlinux from=20
  NEC=92s EMMA2L platform to EMMA2.&nbsp; The problem I=92m having is =
that linux=20
  hangs when it attempts to do its first page fault: the page fault =
handler is=20
  successfully called, the call to handle_mm_fault returns 2 (major =
fault)=85but=20
  then code execution appears to just stop.&nbsp; Linux is not =
completely dead,=20
  however =96 it still responds to a timer interrupt.</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">As the code for handling =
page=20
  faults is standard code, and TLB hardware should be the same on EMMA2 =
as on=20
  EMMA2L (where it works!), I don=92t understand what=92s gone =
wrong!&nbsp; Does=20
  anyone have any ideas?</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks for your=20
  help,</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Gill</SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_00CE_01C38294.271C4280--
