Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 07:41:52 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:8146
	"EHLO p508B65B9.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225194AbTA1Hlv>; Tue, 28 Jan 2003 07:41:51 +0000
Received: from fep2.goldenlines.net.il ([IPv6:::ffff:212.117.129.202]:12691
	"EHLO fep2.012.net.il") by ralf.linux-mips.org with ESMTP
	id <S869813AbTA1Hlw>; Tue, 28 Jan 2003 08:41:52 +0100
Received: from NinaZ ([212.199.155.240]) by fep2.012.net.il with ESMTP
          id <20030128074132.XZDQ1458.fep2@NinaZ>
          for <linux-mips@linux-mips.org>; Tue, 28 Jan 2003 09:41:32 +0200
From: "Victor I. Zaslavsky" <victor@zaslavsky.org>
To: <linux-mips@linux-mips.org>
Subject: Cross compiler installation
Date: Tue, 28 Jan 2003 09:41:31 +0200
Message-ID: <000a01c2c6a0$acdb37b0$f09bc7d4@NinaZ>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C2C6B1.706407B0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <victor@zaslavsky.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: victor@zaslavsky.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C2C6B1.706407B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi folks,
 
I am looking for step-by-step instruction how to install cross compiler
for MIPS on my RedHat 8 Intel-based machine.
 
Any help will be very appreciated.
 
Thanks in advance,
Victor
 

------=_NextPart_000_000B_01C2C6B1.706407B0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C2C6B1.6FE3B420">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:ApplyBreakingRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-ansi-language:EN-US;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:56.7pt 42.5pt 56.7pt 85.05pt;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DRU link=3Dblue vlink=3Dpurple style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>Hi folks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>I am looking for step-by-step instruction how =
to
install cross compiler for MIPS on my <span class=3DSpellE>RedHat</span> =
8 Intel-based
machine.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>Any help will be <span =
class=3DGramE>very</span>
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt;mso-ansi-language:EN-US;mso-no-proof:yes'>Thank=
s in
advance,</span><span =
style=3D'mso-no-proof:yes'><o:p></o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt;mso-ansi-language:EN-US;mso-no-proof:yes'>Victo=
r</span><span
style=3D'mso-no-proof:yes'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000B_01C2C6B1.706407B0--
