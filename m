Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 19:38:13 +0100 (BST)
Received: from 66-126-253-28.ded.pacbell.net ([IPv6:::ffff:66.126.253.28]:29705
	"EHLO blunote.bluzona.com") by linux-mips.org with ESMTP
	id <S8225474AbTI3SiB>; Tue, 30 Sep 2003 19:38:01 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C38781.F17AA991"
Subject: Backtrace capability
Date: Tue, 30 Sep 2003 11:37:46 -0700
Message-ID: <2EEAE99C5AA0B14BB6A0BBB4ABF8D1E117960E@blunote.bluzona.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Backtrace capability
Thread-Index: AcOHgfFyYmJVB4rfRLq7BbQIOJuDaw==
From: "Sudeep Kottilingal" <skottilingal@kinetowireless.com>
To: <linux-mips@linux-mips.org>
Cc: "Joe Baranowski" <jbaranowski@kinetowireless.com>
Return-Path: <skottilingal@kinetowireless.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skottilingal@kinetowireless.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C38781.F17AA991
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
=20
I am trying to debug some SIGSEGV when I leave my system ON for a few
days. At the time of the
Crash I am not able to get a nice back-trace/stack trace yet. (I do not
see the execinfo.h file on my uclibc toolchain
Which implies its not supported yet on my toolchain release).
=20
=20
Has anyone had success in incorporating backtrace capability into a
uclibc binary yet ...?
If your answer is yes, could u give me some pointers on how to do it and
set it up ..?
=20
=20
If your answer is no is there any other alternative set up to get more
information.
I do not run an ICD or ICE on my board. Neither do I have a serial
console. My console is redirected via Telnet.
=20
=20
Currently I am running the application which crashes on the linux PC
through totalview debugger.
Waiting for it to crash.
=20
sudeep

------_=_NextPart_001_01C38781.F17AA991
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C38747.45109BD0">
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
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to debug some SIGSEGV when I leave my =
system ON
for a few days. At the time of the<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Crash I am not able to get a nice back-trace/stack =
trace yet.
(I do not see the <span class=3DSpellE>execinfo.h</span> file on my =
<span
class=3DSpellE>uclibc</span> <span =
class=3DSpellE>toolchain</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Which implies <span class=3DGramE>its</span> not =
supported yet
on my <span class=3DSpellE>toolchain</span> =
release).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b style=3D'mso-bidi-font-weight:normal'><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold;
mso-bidi-font-weight:normal'>Has anyone had success in incorporating =
<span
class=3DSpellE>backtrace</span> capability into <span =
class=3DGramE>a</span> <span
class=3DSpellE>uclibc</span> binary yet =
&#8230;?<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b style=3D'mso-bidi-font-weight:normal'><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold;
mso-bidi-font-weight:normal'>If your answer is yes, could u give me some
pointers on how to do it and set it <span class=3DGramE>up =
..?</span><o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b style=3D'mso-bidi-font-weight:normal'><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold;
mso-bidi-font-weight:normal'>If your answer is no is there any other
alternative set up to get more =
information.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I do not run an ICD or ICE on my board. Neither do I =
have a
serial console. My console is redirected via =
Telnet.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Currently I am running the application which crashes =
on the <span
class=3DSpellE>linux</span> PC through <span =
class=3DSpellE>totalview</span>
debugger.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Waiting for it to =
crash.</span></font></span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>sudeep</span></font></span><=
/span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C38781.F17AA991--
