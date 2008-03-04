Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2008 20:51:08 +0000 (GMT)
Received: from dotcorporate.com ([67.50.105.12]:27964 "EHLO
	dotexchange.dotcorporation.com") by ftp.linux-mips.org with ESMTP
	id S28601762AbYCDUvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Mar 2008 20:51:06 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87E39.76196329"
Subject: RE: smp8634 add memory at dram1
Date:	Tue, 4 Mar 2008 12:51:03 -0800
Message-ID: <2D30722FBBDE6749973243F4F01BE984A242CC@dotexchange.dotcorporation.com>
In-Reply-To: <2D30722FBBDE6749973243F4F01BE984A242CB@dotexchange.dotcorporation.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: smp8634 add memory at dram1
Thread-Index: Ach9jncajtrbM7+KS8auCZEQx2hQEQABxn5wACewQeA=
From:	"James Zipperer" <jamesz@modsystems.com>
To:	"David Daney" <ddaney@avtrex.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <jamesz@modsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamesz@modsystems.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C87E39.76196329
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

James Zipperer wrote:
>>>=20
>>> =20
>>>=20
>>> I'm running out of memory in linux on the smp86xx and attempting to=20
>>> implement this solution.  Did you ever get it to work?  No luck for
me=20
>>> yet.  I'm still a bit unclear why you must switch linux to run off
DRAM=20
>>> 1 instead of leaving it on DRAM 0 and adding an additional call to=20
>>> add_memory_region in prom_init for DRAM 1.  But then again, I
haven't=20
>>> gotten that to work yet either :)
>>>=20
>>> =20
>>>=20
>>> Any info/patches are greatly appreciated.  Thanks!
>>>=20
>>> =20
>>>=20
>>
>>Typically DRAM 1 must be accessed through the TLB as its address lays=20
>>outside of the 512MB window of KSEG[012].
>>
>>The best way to make this memory available to Linux may still be up
for=20
>>debate.
>>
>>David Daney
>>
>
>I'm sure this is a dumb question due to the fact that my grasp of the
>problem is less than acceptable... =20
>
>Can remapped addresses (namely CPU_remap[34]_addr) be used for the call
to >add_memory_region()?  That would allow the address for DRAM 1 to be
within >the 512MB window of KSEG[012].  I'm unclear whether the
CPU_remap addresses >count as PHSYICAL or VIRTUAL addresses. =20
>
>I'm guessing that my plan won't work since I tried it and it didn't
work.  >My results were that the kernel booted but didn't report any
additional >memory available via the 'free' command.
>
>Thanks.
>
>-James

So I think I've got a little better grasp on the problem.  Is the reason
you can't just remap DRAM 1 to 0x08000000 - 0x1000000000 because this is
below the start address of linux 0x10020000?  Can this restriction be
worked around easily?
=20
So as far as I can tell, the options are:
=20
1. YH's proposed solution to use CPU remap registers to map DRAM1 to
0x08000000 - 0x10000000 in the bootloader, make linux run from DRAM1,
and then add_memory_region for DRAM1 and DRAM0.
=20
2. YH's other proposed solution to leave linux running from DRAM0,
enable HIMEM, add_memory_region for DRAM1 using HIMEM, fix HIMEM issues
regarding cache aliasing.
=20
3. Work around adding memory that starts below linux (not sure if this
is even possible).
=20
Are there other options as well?  Thanks!
=20
-James
=20

------_=_NextPart_001_01C87E39.76196329
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C87DF6.67EB2670">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;
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

<p class=3DMsoPlainText><st1:PersonName><font size=3D2 face=3D"Courier =
New"><span
 style=3D'font-size:10.0pt'>James =
Zipperer</span></font></st1:PersonName> wrote:<o:p></o:p></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt;<span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; I'm running out of memory in linux on the smp86xx =
and
attempting to <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; implement this solution.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Did you ever get it to =
work?<span
style=3D'mso-spacerun:yes'>&nbsp; </span>No luck for me =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <span class=3DGramE>yet</span>.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>I'm still a bit unclear why you =
must
switch linux to run off DRAM <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; 1 instead of leaving it on DRAM 0 and adding an =
additional
call to <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <span class=3DSpellE><span =
class=3DGramE>add_memory_region</span></span>
in prom_init for DRAM 1.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>But then
again, I haven't <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; gotten that to work yet either =
:)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt;<span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; Any info/patches are greatly appreciated.<span
style=3D'mso-spacerun:yes'>&nbsp; =
</span>Thanks!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt;<span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;Typically DRAM 1 must be accessed through the TLB as its
address <span class=3DGramE>lays</span> <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;outside of the 512MB window of <span =
class=3DGramE>KSEG[</span>012].<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;The best way to make this memory available to Linux may =
still
be up for <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><span class=3DGramE><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt;&gt;debate.</span></font></span><o:p></o:p=
></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;David Daney<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;I'm sure this is a dumb question due to the fact that my =
grasp of
the &gt;problem is less than acceptable...<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;Can remapped addresses (namely CPU_<span =
class=3DGramE>remap[</span>34]_addr)
be used for the call to &gt;<span =
class=3DSpellE>add_memory_region</span>()?<span
style=3D'mso-spacerun:yes'>&nbsp; </span>That would allow the address =
for DRAM 1
to be within &gt;the 512MB window of <span =
class=3DGramE>KSEG[</span>012].<span
style=3D'mso-spacerun:yes'>&nbsp; </span>I'm unclear whether the =
CPU_remap
addresses &gt;count as PHSYICAL or VIRTUAL addresses.<span
style=3D'mso-spacerun:yes'>&nbsp; </span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;I'm guessing that my plan won't work since I tried it and it =
didn't
work.<span style=3D'mso-spacerun:yes'>&nbsp; </span>&gt;My results were =
that the
kernel booted but didn't report any additional &gt;memory available via =
the
'free' command.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;Thanks.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;-James<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><br>
So I think I've got a little better grasp on the problem.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Is the reason you can't just =
remap DRAM
1 to 0x08000000 - 0x1000000000 because this is below the start address =
of <span
class=3DSpellE>linux</span> 0x10020000?<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>Can this restriction be worked around =
easily?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>So as far as I can tell, the =
options are:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>1. <span =
class=3DSpellE>YH's</span> proposed
solution to use CPU remap registers to map DRAM1 to 0x08000000 - =
0x10000000 in
the <span class=3DSpellE>bootloader</span>, make <span =
class=3DSpellE>linux</span>
run from DRAM1, and then <span class=3DSpellE>add_memory_region</span> =
for DRAM1
and DRAM0.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>2. <span =
class=3DSpellE>YH's</span> other
proposed solution to leave <span class=3DSpellE>linux</span> running =
from DRAM0,
enable HIMEM, <span class=3DSpellE>add_memory_region</span> for DRAM1 =
using HIMEM,
<span class=3DGramE>fix</span> HIMEM issues regarding cache =
aliasing.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>3. Work around adding memory that =
starts
below <span class=3DSpellE>linux</span> (not sure if this is even =
possible).<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>Are there other options as =
well?<span
style=3D'mso-spacerun:yes'>&nbsp; =
</span>Thanks!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>-James<o:p></o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C87E39.76196329--
