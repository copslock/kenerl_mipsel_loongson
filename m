Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2003 15:45:33 +0100 (BST)
Received: from mail.bandspeed.com ([IPv6:::ffff:64.132.226.131]:4847 "EHLO
	mars.bandspeed.com") by linux-mips.org with ESMTP
	id <S8225454AbTJCOp3>; Fri, 3 Oct 2003 15:45:29 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C389BC.F8A1C4CB"
Subject: RE: Kernel Profile Patch for Au1x00?
Date: Fri, 3 Oct 2003 09:45:21 -0500
Message-ID: <F2DE90354F0ED94EB7061060D9396547B98A6B@mars.bandspeed.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel Profile Patch for Au1x00?
thread-index: AcOJuuK1Rc+kCj4jRhGnkbSO/46gVQAAC4Ow
From: "Vince Bridgers" <vbridgers@bandspeed.com>
To: <linux-mips@linux-mips.org>
Cc: "Eric DeVolder" <eric.devolder@amd.com>
Return-Path: <vbridgers@bandspeed.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbridgers@bandspeed.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C389BC.F8A1C4CB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks, Eric.=20
=20
I was looking for something more simple, like kernel-based statistical
hit profiling - for example: a timer interrupt that fires at some
regular rate, collects the current Program Counter value, bucket-izes
that data and does a symbol lookup on those buckets when queried. I'll
take a look at LTT to see if I can get it to work for my purposes.
=20
I sent an email to pcs.support previously, and Gerado told me there was
no patch available. I'll check with them again.
=20
Cheers!
=20
-----Original Message-----
From: Eric DeVolder [mailto:eric.devolder@amd.com]=20
Sent: Friday, October 03, 2003 9:30 AM
To: Vince Bridgers
Subject: Re: Kernel Profile Patch for Au1x00?
=20
There is the LTT, Linux Trace Toolkit, which can be used for profiling.
If you send email to pcs.support@amd.com, they should be able to
get you the files...


Vince Bridgers wrote:


Is there a kernel profile patch that anyone is aware of for the AMD
(Alchemy) part Au1000/Au1500? If not, can anyone provide info on a good
starting point to start a port?
=20
TIA,
=20
Vince
=20
=20

------_=_NextPart_001_01C389BC.F8A1C4CB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C38993.0FE3EFE0">
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
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:553679495 -2147483648 8 0 66047 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	color:black;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
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
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks, Eric. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I was looking for something more =
simple,
like kernel-based statistical hit profiling &#8211; for example: a timer
interrupt that fires at some regular rate, collects the current Program =
Counter
value, bucket-<span class=3DSpellE>izes</span> that data and does a =
symbol lookup
on those buckets when queried. I&#8217;ll take a look at LTT to see if I =
can
get it to work for my purposes.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I sent an email to <span =
class=3DSpellE>pcs.support</span>
previously, and <span class=3DSpellE>Gerado</span> told me there was no =
patch
available. I&#8217;ll check with them =
again.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Cheers!<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma;color:windowtext'>-----Origi=
nal
Message-----<br>
<b><span style=3D'font-weight:bold'>From:</span></b> Eric DeVolder
[mailto:eric.devolder@amd.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, October 03, =
2003
9:30 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Vince Bridgers<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: Kernel =
Profile Patch
for Au1x00?</span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
color=3Dblack
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
color=3Dblack
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>There is the =
LTT, Linux
Trace Toolkit, which can be used for profiling.<br>
If you send email to <a =
href=3D"mailto:pcs.support@amd.com">pcs.support@amd.com</a>,
they should be able to<br>
get you the files...<br>
<br>
<br>
Vince Bridgers wrote:<br style=3D'mso-special-character:line-break'>
<![if !supportLineBreakNewLine]><br =
style=3D'mso-special-character:line-break'>
<![endif]><o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'><!--[if =
gte mso 9]><xml>
 <u1:OfficeDocumentSettings>
  <u1:DoNotRelyOnCSS/>
 </u1:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <u2:WordDocument>
  <u2:SpellingState>Clean</u2:SpellingState>
  <u2:GrammarState>Clean</u2:GrammarState>
  <u2:DocumentKind>DocumentEmail</u2:DocumentKind>
  <u2:EnvelopeVis/>
  <u2:Compatibility>
   <u2:BreakWrappedTables/>
   <u2:SnapToGridInCell/>
   <u2:WrapTextWithPunct/>
   <u2:UseAsianBreakRules/>
  </u2:Compatibility>
  <u2:BrowserLevel>MicrosoftInternetExplorer4</u2:BrowserLevel>
 </u2:WordDocument>
</xml><![endif]-->Is there a kernel profile patch that anyone is aware =
of for
the AMD (Alchemy) part Au1000/Au1500? If not, can anyone provide info on =
a good
starting point to start a =
port?<u3:p></u3:p></span></font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><u3:p>&nbsp;</u3:p></span></=
font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>TIA,<u3:p></u3:p></span></fo=
nt><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><u3:p>&nbsp;</u3:p></span></=
font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Vince<u3:p></u3:p></span></f=
ont><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><u3:p>&nbsp;</u3:p></span></=
font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><u3:p>&nbsp;</u3:p></span></=
font><o:p></o:p></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C389BC.F8A1C4CB--
