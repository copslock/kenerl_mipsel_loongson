Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 08:39:01 +0000 (GMT)
Received: from mail.cybersmart.co.za ([IPv6:::ffff:196.15.138.20]:4106 "EHLO
	optical.cyberhost.co.za") by linux-mips.org with ESMTP
	id <S8224858AbVBCIin>; Thu, 3 Feb 2005 08:38:43 +0000
Received: from of0 (firewall.openfuel.com [196.15.138.55])
	by optical.cyberhost.co.za (Postfix) with ESMTP id 16CE25B121
	for <linux-mips@linux-mips.org>; Thu,  3 Feb 2005 10:38:43 +0200 (SAST)
From:	"Etienne Bauermeister" <etienne@openfuel.com>
To:	<linux-mips@linux-mips.org>
Subject: Kernel compile error - rtc.c
Date:	Thu, 3 Feb 2005 10:38:47 +0200
Message-ID: <000f01c509cb$c7420190$642aa8c0@of0>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0010_01C509DC.8ACAD190"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <etienne@openfuel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: etienne@openfuel.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C509DC.8ACAD190
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am compiling the linux-2.6.11-rc2-mipscvs-20050130 kernel using a
toolchain I built myself from instructions on this mailing list. The
toolchain consists of binutils-2.13.90.0.10, glibc-2.2.5,
glibc-linuxthreads-2.2.5 and gcc-3.2-7.1 from H.J. Lu with all the
patches like glibc-2.2.5-mips-build-gmon etc. applied. I am compiling
the kernel for the AMD Au1100 (big endian) on an i686 host.  When I do
this though I get the following error message a few minutes into the
compilation process:
 
CC      drivers/char/rtc.o
drivers/char/rtc.c: In function `rtc_init':
drivers/char/rtc.c:955: `r' undeclared (first use in this function)
drivers/char/rtc.c:955: (Each undeclared identifier is reported only
once
drivers/char/rtc.c:955: for each function it appears in.)
make[2]: *** [drivers/char/rtc.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2
drivers/char/rtc.ot:~/mips/kernel/linux-2.6.11-rc2-mipscvs-20050130]$
 
I understand that the variable 'r' is not declared and this causes the
error, but I don't know where to declare it or am I completely wrong and
something else is at fault?  Please provide some help with this.  
 
A second question relates to some warnings I got earlier in the
compilation process stating that some 'variables' (I assume) are
'deprecated'.  Is this anything to be concerned about?
 
Thanks.
 
Etienne Bauermeister
Design Engineer
OpenFuel (Pty) Ltd
WWW: http://www.openfuel.com
 
 

------=_NextPart_000_0010_01C509DC.8ACAD190
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C509DC.8AB303D0">
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
pre
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
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

<div class=3DSection1><pre><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>I am compiling =
the linux-2.6.11-rc2-mipscvs-20050130 kernel using a <span
class=3DSpellE>toolchain</span> I built myself from instructions on this =
mailing list. The <span
class=3DSpellE>toolchain</span> consists of binutils-2.13.90.0.10, =
glibc-2.2.5, glibc-linuxthreads-2.2.5 and gcc-3.2-7.1 from H.J. Lu with =
all the patches like glibc-2.2.5-mips-build-gmon etc. applied. I am =
compiling the kernel for the AMD Au1100 (big <span
class=3DSpellE>endian</span>) on an i686 host.<span =
style=3D'mso-spacerun:yes'>&nbsp; </span>When I do this though I get the =
following error message a few minutes into the compilation =
process:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>CC<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>drivers/char/<span
class=3DSpellE>rtc.o</span><o:p></o:p></span></font></pre><pre><font =
size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>drivers/char/<span
class=3DSpellE>rtc.c</span>: In function `<span =
class=3DSpellE>rtc_init</span>':<o:p></o:p></span></font></pre><pre><font=

size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>drivers/char/rtc.c:955: `r' undeclared (first use in this =
function)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>drivers/char/rtc.c:955: (Each undeclared identifier is reported =
only once<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>drivers/char/rtc.c:955: for each function it appears =
in.)<o:p></o:p></span></font></pre><pre><span
class=3DGramE><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
font-family:"Times New Roman"'>make[</span></font></span><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>2]: *** =
[drivers/char/<span
class=3DSpellE>rtc.o</span>] Error =
1<o:p></o:p></span></font></pre><pre><span
class=3DGramE><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
font-family:"Times New Roman"'>make[</span></font></span><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>1]: *** =
[drivers/char] Error 2<o:p></o:p></span></font></pre><pre><span
class=3DGramE><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
font-family:"Times New Roman"'>make</span></font></span><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>: *** [drivers] =
Error 2<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>drivers/char/rtc.ot:~/mips/kernel/linux-2.6.11-rc2-mipscvs-200501=
30]$<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>I understand =
that the variable &#8216;r&#8217; is not declared and this causes the =
error, but I don&#8217;t know where to declare it or am I completely =
wrong and something else is at fault?<span =
style=3D'mso-spacerun:yes'>&nbsp; </span>Please provide some help with =
this.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>A second =
question relates to some warnings I got earlier in the compilation =
process stating that some &#8216;variables&#8217; (I assume) are =
&#8216;deprecated&#8217;.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>Is this anything to be concerned =
about?<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>Thanks.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p>&nbsp;</o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>Etienne =
Bauermeister</span></font><span
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>Design&nbsp;Engineer</span></font><sp=
an
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>OpenFuel (Pty) =
Ltd</span></font><span
style=3D'mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;mso-no-proof:yes'>WWW: <a =
href=3D"http://www.openfuel.com">http://www.openfuel.com</a></span></font=
><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<pre><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
font-family:"Times New =
Roman"'><o:p>&nbsp;</o:p></span></font></pre></div>

</body>

</html>

------=_NextPart_000_0010_01C509DC.8ACAD190--
