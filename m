Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2008 00:14:13 +0000 (GMT)
Received: from dotcorporate.com ([67.50.105.12]:54975 "EHLO
	dotexchange.dotcorporation.com") by ftp.linux-mips.org with ESMTP
	id S28601221AbYCDAOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Mar 2008 00:14:11 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87D8C.AABEC29A"
Subject: Re: smp8634 add memory at dram1
Date:	Mon, 3 Mar 2008 16:14:09 -0800
Message-ID: <2D30722FBBDE6749973243F4F01BE984A242CA@dotexchange.dotcorporation.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: smp8634 add memory at dram1
Thread-Index: Ach9jKrAm1qYdsZ0S3224VXIW+0Tqg==
From:	"James Zipperer" <jamesz@modsystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <jamesz@modsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamesz@modsystems.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C87D8C.AABEC29A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

=20
David Kuk" <david.kuk@entone.com <mailto:david.kuk%40entone.com> >
wrote:
> Dear YH
>=20
> I am sorry i have been disturbed by other issues, the memory problem
seems little bit difficult
> to me. In our case, i saw that in prom.c under mips/tango2, the
function prom_init , it shows
> that :
> memcfg_t
> *m=3D(memcfg_t*)KSEG1ADDR(MEM_BASE_dram_controller_0+FM_MEMCFG);=20


> it's seems the kernel has hard coded to point the starting memory to
DRAM controller 0's
> starting address, if now, i have remap 64mb memory at DRAM controller
1 at remap register
> 4, The problem is come, the kernel will ignore any memory before dram
controller 0's starting
> address. Even i have add 0x0c000000--0x10000000 as boot memory, it
still think it's first
> usable pfn is at 0x10000000.=20
>=20
> my solution is 3 steps
>=20
> 1, modify the compiler, let the linux start address moved to
0x0c000000,=20
> 2. modify the YAMON, and map the DRAM 1 controller to remap register4
in YAMON stage
> 3, modify the linux, to set the two piece of memory to the kernel as
boot memory .=20
>=20
> it's this possible, or it have other better solution ?
>=20
> thx a lot for your kindly help !
>=20
>=20
> best wishes
> David
=20
I'm running out of memory in linux on the smp86xx and attempting to
implement this solution.  Did you ever get it to work?  No luck for me
yet.  I'm still a bit unclear why you must switch linux to run off DRAM
1 instead of leaving it on DRAM 0 and adding an additional call to
add_memory_region in prom_init for DRAM 1.  But then again, I haven't
gotten that to work yet either :)
=20
Any info/patches are greatly appreciated.  Thanks!
=20
-James
=20

------_=_NextPart_001_01C87D8C.AABEC29A
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C87D49.9C9ABB90">
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

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>David <span class=3DSpellE>Kuk</span>&quot; &lt;<a
href=3D"mailto:david.kuk%40entone.com">david.kuk@entone.com</a>&gt; =
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; Dear YH<br>
&gt; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; I am sorry <span class=3DSpellE>i</span> have been =
disturbed by
other issues, the memory problem seems little bit =
difficult<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span class=3DGramE>to</span> me. In our case, <span =
class=3DSpellE>i</span>
saw that in <span class=3DSpellE>prom.c</span> under mips/tango2, the =
function <span
class=3DSpellE>prom_<span class=3DGramE>init</span></span><span =
class=3DGramE> ,</span>
it shows<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span class=3DGramE>that =
:</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span =
class=3DSpellE>memcfg_t</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; *m<span class=3DGramE>=3D(</span><span =
class=3DSpellE>memcfg_t</span>*)KSEG1ADDR(MEM_BASE_dram_controller_0+FM_M=
EMCFG);
<br style=3D'mso-special-character:line-break'>
<![if !supportLineBreakNewLine]><br =
style=3D'mso-special-character:line-break'>
<![endif]><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span class=3DGramE>it's</span> seems the kernel has hard =
coded to
point the starting memory to DRAM controller =
0's<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; starting address, if now, <span class=3DSpellE>i</span> =
have remap
64mb memory at DRAM controller 1 at remap =
register<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; 4, <span class=3DGramE>The</span> problem is come, the =
kernel will
ignore any memory before dram controller 0's =
starting<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; address. Even <span class=3DSpellE>i</span> have add
0x0c000000--0x10000000 as boot memory, it still think it's =
first<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span class=3DGramE>usable</span> <span =
class=3DSpellE>pfn</span> is
at 0x10000000. <br>
&gt; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span class=3DGramE>my</span> solution is 3 steps<br>
&gt; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; 1, modify the compiler, let the <span =
class=3DSpellE>linux</span>
start address moved to 0x0c000000, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; 2. <span class=3DGramE>modify</span> the YAMON, and map the =
DRAM 1
controller to remap register4 in YAMON =
stage<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; 3, modify the <span class=3DSpellE>linux</span>, to set the =
two
piece of memory to the kernel as boot <span class=3DGramE>memory =
.</span> <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span class=3DGramE>it's</span> this possible, or it have =
other
better solution ?<br>
&gt; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; thx a lot for your kindly <span class=3DGramE>help =
!</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; <span class=3DGramE>best</span> =
wishes<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&gt; David<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'>I'm running out of memory in =
<span
class=3DSpellE>linux</span> on the smp86xx and attempting to implement =
this
solution.<span style=3D'mso-spacerun:yes'>&nbsp; </span>Did you ever get =
it to
work?<span style=3D'mso-spacerun:yes'>&nbsp; </span>No luck for me =
yet.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>I'm still a bit unclear why you =
must
switch <span class=3DSpellE>linux</span> to run off DRAM 1 instead of =
leaving it
on DRAM 0 and adding an additional call to <span =
class=3DSpellE>add_memory_region</span>
in <span class=3DSpellE>prom_init</span> for DRAM 1.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>But then again, I haven't =
gotten that to
work yet either :)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'>Any info/patches are greatly =
appreciated.<span
style=3D'mso-spacerun:yes'>&nbsp; =
</span>Thanks!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'>-James<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C87D8C.AABEC29A--
