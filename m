Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 19:00:50 +0100 (BST)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:21134 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225982AbVF0SAb>;
	Mon, 27 Jun 2005 19:00:31 +0100
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Mon, 27 Jun 2005 10:59:59 -0700
Received: by miles.echelon.echcorp.com with Internet Mail Service (5.5.2653.19)
	id <NRBD2XF8>; Mon, 27 Jun 2005 10:59:56 -0700
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4356@miles.echelon.echcorp.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	linux-mips@linux-mips.org
Subject: crosstool (glibc based toolchain for MIPS)
Date:	Mon, 27 Jun 2005 10:59:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C57B42.06B4EE09"
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C57B42.06B4EE09
Content-Type: text/plain

Thanks a bunch to everybody who replied to my email and suggested toolchain
options. Many of you suggested crosstool and I am going to give it a shot.
However, the build matrix shows that the toolchain for mips fails.
 
http://kegel.com/crosstool/crosstool-0.35/buildlogs/
<http://kegel.com/crosstool/crosstool-0.35/buildlogs/> 
 
Has anybody been able to build a toolchain for MIPS using crosstool
successfully? And if so, could you please reply to me with the configuration
used (gcc, glibc, binutils, etc).
 
Thanks again,
Prashant

------_=_NextPart_001_01C57B42.06B4EE09
Content-Type: text/html
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C57B07.CEE85F90">
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
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
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
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
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
	margin:1.0in 1.25in 1.0in 1.25in;
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks a bunch to everybody who replied to my email =
and
suggested <span class=3DSpellE>toolchain</span> options. Many of you =
suggested <span
class=3DSpellE>crosstool</span> and I am going to give it a shot. =
However, the
build matrix shows that the <span class=3DSpellE>toolchain</span> for =
<span
class=3DSpellE><span class=3DGramE>mips</span></span> =
fails.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a
href=3D"http://kegel.com/crosstool/crosstool-0.35/buildlogs/">http://keg=
el.com/crosstool/crosstool-0.35/buildlogs/</a><o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Has anybody been able to build a <span =
class=3DSpellE>toolchain</span>
for MIPS using <span class=3DSpellE>crosstool</span> successfully? And =
if so,
could you please reply to me with the configuration used (<span =
class=3DSpellE>gcc</span>,
<span class=3DSpellE>glibc</span>, <span =
class=3DSpellE>binutils</span>, etc).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks again,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Prashant<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C57B42.06B4EE09--
