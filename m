Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jun 2003 01:00:13 +0100 (BST)
Received: from localhost [127.0.0.1] by ftp.linux-mips.org
	with SpamAssassin (2.55 1.174.2.19-2003-05-19-exp);
	Fri, 06 Jun 2003 19:08:30 +0100
From: Dennis Castleman <DennisCastleman@oaktech.com>
To: linux-mips@linux-mips.org
Subject: MIPS CACHE TESTS
Date: Fri, 6 Jun 2003 11:00:23 -0700 
Message-Id: <56BEF0DBC8B9D611BFDB00508B5E2634102FAC@tlexposeidon.teralogic-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_3EE0D89E.2FD31CBE"
X-archive-position: 2559
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: DennisCastleman@oaktech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------------=_3EE0D89E.2FD31CBE
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

This mail is probably spam.  The original message has been attached
along with this report, so you can recognize or block similar unwanted
mail in future.  See http://spamassassin.org/tag/ for more details.

Content preview:  This message is in MIME format. Since your mail reader
  does not understand this format, some or all of this message may not be
  legible. Hi ALL I trying to find a way of test both the instruction and
  data caches for a MIPS 5KC core. Does any body have any ideas? Data
  cache is easy instruction cache is not so easy. The Magnum pc-50 use to
  have a monitor called Rx4230 MIPS Monitor. This monitor dumped the
  following on power up [...] 

Content analysis details:   (8.10 points, 5 required)
HTML_70_80         (4.0 points)  BODY: Message is 70% to 80% HTML
HTML_MESSAGE       (3.0 points)  BODY: HTML included in message
SUBJ_ALL_CAPS      (1.1 points)  Subject is all capitals

The original message did not contain plain text, and may be unsafe to
open with some email clients; in particular, it may contain a virus,
or confirm that your address can receive spam.  If you wish to view
it, it may be safer to save it to a file and open it with an editor.


------------=_3EE0D89E.2FD31CBE
Content-Type: message/rfc822; x-spam-type=original
Content-Description: original message before SpamAssassin
Content-Disposition: attachment
Content-Transfer-Encoding: 8bit

Received: from mx1.teralogic.tv ([IPv6:::ffff:207.16.148.27]:6624 "EHLO
	mail.teralogic.tv") by linux-mips.org with ESMTP
	id <S8225199AbTFFSI2>; Fri, 6 Jun 2003 19:08:28 +0100
Received: from tlexmail.teralogic.tv (uugate-2.oaktech.com [207.16.148.1])
	by mail.teralogic.tv (8.11.6/8.11.6) with ESMTP id h56I4Tt02407
	for <linux-mips@linux-mips.org>; Fri, 6 Jun 2003 11:04:29 -0700 (PDT)
Received: by tlexposeidon.teralogic-inc.com with Internet Mail Service (5.5.2653.19)
	id <L92RWCZ2>; Fri, 6 Jun 2003 11:00:29 -0700
Message-ID: <56BEF0DBC8B9D611BFDB00508B5E2634102FAC@tlexposeidon.teralogic-inc.com>
From:	Dennis Castleman <DennisCastleman@oaktech.com>
To:	linux-mips@linux-mips.org
Subject: MIPS CACHE TESTS
Date:	Fri, 6 Jun 2003 11:00:23 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C32C55.807E0290"
Return-Path: <DennisCastleman@oaktech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C32C55.807E0290
Content-Type: text/plain

Hi ALL
 
I trying to find a way of test both the instruction and data caches for a
MIPS 5KC core.
Does any body have any ideas?  Data cache is easy instruction cache is not
so easy.
The Magnum pc-50 use to have a monitor called Rx4230 MIPS Monitor.
This monitor dumped the following on power up
 
Memory Test 256kb - 5mb...Passed
I/O Cache Test...Passed
NVRAM Test ...Passed
Parallel Test...Passed
Floppy Chip Test...Passed
Primary Data Cache Test...Passed
Primary Instruction Cache Test...Passed
Primary DCache TAG Test...Passed
Primary ICache TAG Test...Passed
Secondary Cache Test...Skipped
Secondary Cache TAG Test...Skipped
Read Merge Write Test...Passed
High Memory Test 5mb -> end...Passed
FP Test...Passed
Keyboard Selftest...Passed
Keyboard Basic Assurance...Passed
Video board Test...Skipped
SCSI Register Test...Passed
Audio Chip Test...Passed
Sonic Reset Test...Passed
Sonic Register Test...Passed
 
PONs Complete...
PON Diagnostics Version 5.05 MIPS OPT Fri May 29 14:22:07 
 
YOMAN doesn't have any thing like this.  If any one knows of power on tests
for a 5KC it would be of great interest to me.
 
 
Dennis Castleman
Oak Technology.
 
 
 
 
 

------_=_NextPart_001_01C32C55.807E0290
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C32C1B.AADDAF20">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
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
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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
	mso-fareast-font-family:"Times New Roman";
	color:black;}
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
font-family:Arial'>Hi ALL<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I trying to find a way of test both the instruction =
and data
caches for a MIPS 5KC core.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does any body have any ideas?<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Data cache is easy instruction =
cache is
not so easy.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The Magnum pc-50 use to have a monitor called =
</span></font>Rx4230
MIPS Monitor.<o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>This monitor dumped the following on power =
up<o:p></o:p></span></font></p>

<pre><font size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fo=
nt
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Memory Test 256kb - =
5mb...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>I/O Cache =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>NVRAM Test =
...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Parallel =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Floppy Chip =
Test...Passed<o:p></o:p></span></font></pre><pre><b
style=3D'mso-bidi-font-weight:normal'><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:normal'>=
Primary Data Cache =
Test...Passed<o:p></o:p></span></font></b></pre><pre><b
style=3D'mso-bidi-font-weight:normal'><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:normal'>=
Primary Instruction Cache =
Test...Passed<o:p></o:p></span></font></b></pre><pre><b
style=3D'mso-bidi-font-weight:normal'><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:normal'>=
Primary <span
class=3DSpellE>DCache</span> TAG =
Test...Passed<o:p></o:p></span></font></b></pre><pre><b
style=3D'mso-bidi-font-weight:normal'><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:normal'>=
Primary <span
class=3DSpellE>ICache</span> TAG =
Test...Passed<o:p></o:p></span></font></b></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Secondary Cache =
Test...Skipped<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Secondary Cache TAG =
Test...Skipped<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Read Merge Write =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>High Memory Test 5mb -&gt; =
end...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>FP =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Keyboard <span
class=3DSpellE>Selftest</span>...Passed<o:p></o:p></span></font></pre><p=
re><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Keyboard Basic =
Assurance...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Video board =
Test...Skipped<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>SCSI Register =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Audio Chip =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Sonic Reset =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Sonic Register =
Test...Passed<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'> <o:p></o:p></span></font></pre><pre><span
class=3DSpellE><font size=3D2 color=3Dblack face=3D"Courier New"><span
style=3D'font-size:10.0pt'>PONs</span></font></span> =
Complete...<o:p></o:p></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>PON Diagnostics Version 5.05 MIPS OPT Fri =
May 29 </span></font><st1:time
Hour=3D"14" Minute=3D"22">14:22:07</st1:time> =
<o:p></o:p></pre><pre><font size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fo=
nt
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>YOMAN doesn't have any thing like this.<span =
style=3D'mso-spacerun:yes'>&nbsp; </span>If any one knows of power on =
tests for a 5KC it would be of great interest to =
me.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fo=
nt
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><st=
1:PersonName><font
 size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Dennis =
Castleman</span></font></st1:PersonName><o:p></o:p></pre><pre><span
class=3DGramE><font size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Oak Technology.</span></font></span><o:p></o:p></pre><pre><font =
size=3D2
color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt'> =
<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span></span></font><font size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C32C55.807E0290--

------------=_3EE0D89E.2FD31CBE--
