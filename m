Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 07:36:24 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:60815 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225215AbUERGgX>;
	Tue, 18 May 2004 07:36:23 +0100
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.11/8.12.11) with ESMTP id i4I6OeVh009562;
	Mon, 17 May 2004 23:24:41 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i4I6a6Md024372;
	Mon, 17 May 2004 23:36:07 -0700 (PDT)
Message-ID: <008c01c43ca2$d09264c0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <ratin@koperasw.com>, <linux-mips@linux-mips.org>
References: <005401c43c6b$35b750f0$6901a8c0@ratwin1>
Subject: Re: setup X11 on MIPS64/MALTA
Date: Tue, 18 May 2004 08:39:03 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0089_01C43CB3.92C65320"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0089_01C43CB3.92C65320
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I managed to make X11 work on a 5Kc/Malta configuration by overlaying =
part of the MIPS port
of RH 7.1 with the "zhang tarball" =
(ftp://ftp.paralogos.com/pub/linux/mips/tarballs/X11R6.mipsel.tar.gz )=20
and overlaying part of the linux-mips.org source tree with Matrox fixes =
from kernel.org.

Earl Mitchell of MIPS went through this exercise last year and came up =
with a revised procdeure
which I've bundled into a 33MB tarball and put up at=20
ftp://ftp.paralogos.com/pub/linux/mips/tarballs/earlm_xfree86_malta.tgz=20
I haven't actually used it yet, but it contains a revised X11 subtree, =
sample configuration files, and
a README.
  ----- Original Message -----=20
  From: Ratin Kumar=20
  To: linux-mips@linux-mips.org=20
  Sent: Tuesday, May 18, 2004 2:00
  Subject: setup X11 on MIPS64/MALTA


  Hi,



  I am trying to get X11 up on my MALTA (MIPS 64, little endian board). =
I have the frame buffer working (using Matrox Mill - II PCI card). I =
also have the Red Hat 7.3 installation going but I am not able to get X =
to work. Has any one tried this combination OR if there is any advice on =
this ??



  Thanks in advance.



  -Ratin.

------=_NextPart_000_0089_01C43CB3.92C65320
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE>@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in 1.0in =
1.25in; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
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
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I managed to make X11 work on a =
5Kc/Malta=20
configuration by overlaying part of the MIPS port</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>of RH 7.1 with the "zhang tarball" (<A=20
href=3D"ftp://ftp.paralogos.com/pub/linux/mips/tarballs/X11R6.mipsel.tar.=
gz ) ">ftp://ftp.paralogos.com/pub/linux/mips/tarballs/X11R6.mip<FONT=20
color=3D#000000>sel.tar.gz ) </FONT></A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and overlaying part of the =
linux-mips.org source=20
tree with </FONT><FONT face=3DArial size=3D2>Matrox fixes from=20
kernel.org.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Earl Mitchell of MIPS went through this =
exercise=20
last year and came up with a revised procdeure</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>which I've bundled into a 33MB tarball =
and put up=20
at </FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"ftp://ftp.paralogos.com/pub/linux/mips/tarballs/earlm_xfree86_mal=
ta.tgz">ftp://ftp.paralogos.com/pub/linux/mips/tarballs/earlm_xfree86_mal=
ta.tgz</A>=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I haven't actually used it yet, but it =
contains a=20
revised X11 subtree, sample configuration files, and</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>a README.</FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dratin@koperasw.com href=3D"mailto:ratin@koperasw.com">Ratin =
Kumar</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dlinux-mips@linux-mips.org=20
  =
href=3D"mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Tuesday, May 18, 2004 =
2:00</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> setup X11 on =
MIPS64/MALTA</DIV>
  <DIV><FONT face=3DArial size=3D2></FONT><BR></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hi,</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am trying to get X11 =
up on my=20
  </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">MALTA</SPAN></FONT><FONT =

  face=3DArial size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"> (MIPS 64,=20
  little endian board). I have the frame buffer working (using Matrox =
Mill =96 II=20
  PCI card). I also have the Red Hat 7.3 installation going but I am not =
able to=20
  get X to work. Has any one tried this combination OR if there is any =
advice on=20
  this ??</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks in=20
  advance.</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">-Ratin.</SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0089_01C43CB3.92C65320--
