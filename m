Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 09:47:14 +0000 (GMT)
Received: from mail.soc-soft.com ([IPv6:::ffff:202.56.254.199]:25096 "EHLO
	IGateway.soc-soft.com") by linux-mips.org with ESMTP
	id <S8224991AbVBHJq6>; Tue, 8 Feb 2005 09:46:58 +0000
Received: from mail.soc-soft.com ([192.168.4.25]) by IGateway with trend_isnt_name_B; Tue, 08 Feb 2005 15:18:23 +0530
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C50DC3.54885187"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Linux-mips port: HIGHMEM Address map
Date:	Tue, 8 Feb 2005 15:18:23 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C4C6E7F@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux-mips port: HIGHMEM Address map
Thread-Index: AcUNw1P4n2z9uvr5SQuKEdUGXPtCDg==
From:	<Rishabh@soc-soft.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Rishabh@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rishabh@soc-soft.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C50DC3.54885187
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,
=0D
Guys I am trying to figure out the virtual address map of linux mips
port for the HIGHMEM enabled kernel.
I am unable to figure out from which virtual address map is the HIGHMEM
Memory starts.=0D
=0D
I found in function mem_init()
=0D
                        high_memory =3D (KSEG1 - KSEG0) >> PAGE_SHIFT;
=0D
Also I have seen in many driver source codes that
__virt_to_phys(high_memory) has been used, will that mean that virtual
address for HIGHMEM is beginning from 0xa0000000.=0D
=0D
If that is so then if I want to relocate it to KSEG3 which I feel will
be free how can I do it?
I have my SDRAM mapped at 2 locations {virtual addresses} (0xa0000000 -
0xa3ffffff) and (0x80000000 - 0x83ffffff). Physical Address is
(0x00000000 - 0x03ffffff).
=0D
I have also physical memory 0x20000000 - 0x23ffffff(physical address) to
be used for HIGHMEM.
=0D
Regards,
=0D
Rishabh
=0D


The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If=
 you are not
the intended recipient, please notify the sender and delete the message=
 along with
any annexure. You should not disclose, copy or otherwise use the=
 information contained
in the message or any annexure. Any views expressed in this e-mail are=
 those of the
individual sender except where the sender specifically states them to be=
 the views of
SoCrates Software India Pvt Ltd., Bangalore.
------_=_NextPart_001_01C50DC3.54885187
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C50DF1.6DA73040">
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
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;
	mso-font-alt:"\FF2D\FF33 \660E\671D";
	mso-font-charset:128;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-1610612033 1757936891 16 0 131231 0;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;
	mso-font-charset:128;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-1610612033 1757936891 16 0 131231 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"MS Mincho";}
h1
	{mso-style-update:auto;
	mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.6in;
	text-indent:-.6in;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	mso-list:l0 level1 lfo1;
	tab-stops:list .6in;
	font-size:18.0pt;
	mso-bidi-font-size:16.0pt;
	font-family:"Times New Roman";
	mso-bidi-font-family:Arial;
	mso-font-kerning:16.0pt;}
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
 /* List Definitions */
 @list l0
	{mso-list-id:620767674;
	mso-list-template-ids:-1021003584;}
@list l0:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l0:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l0:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l0:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l0:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=0D
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>Guys I am trying to figure out the virtual address map=
 of <span
class=3DSpellE>linux</span> <span class=3DSpellE><span class=
=3DGramE>mips</span></span>
port for the HIGHMEM enabled kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>I am unable to figure out from which virtual address map=
 <span
class=3DGramE>is the HIGHMEM Memory starts</span>.=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>I found in function <span class=3DSpellE>mem_<span
class=3DGramE>init</span></span><span class=
=3DGramE>()</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><span style=
=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; </span><span
class=3DSpellE>high_memory</span> =3D (KSEG1 &#8211; KSEG0) &gt;&gt;=
 PAGE_SHIFT;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>Also I have seen in many driver source codes that <b
style=3D'mso-bidi-font-weight:normal'><span style=
=3D'font-weight:bold;mso-bidi-font-weight:
normal'>__<span class=3DSpellE>virt_to_<span class=
=3DGramE>phys</span></span><span
class=3DGramE>(</span><span class=3DSpellE>high_memory</span>)=
 </span></b>has been
used, will that mean that virtual address for HIGHMEM is beginning from
0xa0000000. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>If that is so then if I want to relocate it to KSEG3=
 which I
feel will be free how can I do it?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>I have my SDRAM mapped at 2 locations {virtual=
 addresses} (0xa0000000
&#8211; 0xa3ffffff) and (0x80000000 &#8211; 0x83ffffff). Physical Address=
 is
(0x00000000 &#8211; 0x03ffffff).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>I have also physical memory 0x20000000 &#8211; <span
class=3DGramE>0x23ffffff(</span>physical address) to be used for=
 HIGHMEM.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>Rishabh<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><pre>The information=
 contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If=
 you are not
the intended recipient, please notify the sender and delete the message=
 along with
any annexure. You should not disclose, copy or otherwise use the=
 information contained
in the message or any annexure. Any views expressed in this e-mail are=
 those of the
individual sender except where the sender specifically states them to be=
 the views of
SoCrates Software India Pvt Ltd., Bangalore.
</pre></font></td></tr></table>
------_=_NextPart_001_01C50DC3.54885187--
