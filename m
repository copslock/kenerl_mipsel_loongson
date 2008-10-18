Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2008 03:57:24 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:53462 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S21750705AbYJRC5U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Oct 2008 03:57:20 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C930CD.38BB1D5C"
Subject: stop_this_cpu - redundant code?
Date:	Fri, 17 Oct 2008 19:57:12 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C50130734A@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: stop_this_cpu - redundant code?
Thread-Index: AckwzTe0Slnm4CUpRhmklLYNDkrcjg==
From:	"Anirban Sinha" <ASinha@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>, "Ralf Baechle" <ralf@linux-mips.org>
Return-Path: <ASinha@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ASinha@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C930CD.38BB1D5C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All:

=20

This function  (stop_this_cpu) in /arch/mips/kernel/smp.c does a
local_irq_enable() and the adjacent comment says that it's because it
may need to service _machine_restart IPI. Unfortunately,
smp_call_function only sends IPIs to cores that are still online ( it
uses the cpu_online_map U all_but_myself_map in
smp_call_function_map()).

=20

So the bottom-line is, should we still keep the local irqs enabled or is
this code totally redundant? I have seen other similar functions in
other archs where they actually disable the local irqs.

=20

Cheers,

=20

Ani

=20


------_=_NextPart_001_01C930CD.38BB1D5C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi All:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>This function &nbsp;(stop_this_cpu) in
/arch/mips/kernel/smp.c does a local_irq_enable() and the adjacent =
comment says
that it&#8217;s because it may need to service _<i>machine_restart</i> =
IPI. Unfortunately,
smp_call_function only sends IPIs to cores that are still online ( it =
uses the
cpu_online_map U all_but_myself_map in =
smp_call_function_map()).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>So the bottom-line is, should we still keep the =
local irqs
enabled or is this code totally redundant? I have seen other similar =
functions
in other archs where they actually disable the local =
irqs.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Cheers,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Ani<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C930CD.38BB1D5C--
