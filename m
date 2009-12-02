Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 12:56:57 +0100 (CET)
Received: from mail.hstx.com ([64.95.133.106]:9615 "EHLO mail.hstx.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492435AbZLBLPT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 12:15:19 +0100
Received: from edgecaus01.caus.global.vpn ([10.10.0.28]) by mail.hstx.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 2 Dec 2009 03:15:11 -0800
Received: from exchtxuk2.HSTX.global.vpn ([10.11.65.54]) by edgecaus01.caus.global.vpn with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 2 Dec 2009 03:15:11 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----_=_NextPart_001_01CA7340.B5457A50"
Subject: Reserved instruction in kernel code
Date:   Wed, 2 Dec 2009 11:15:06 -0000
Message-ID: <C5BD21D6E1A3114C8765C8FBBD0087BA330A85@exchtxuk2.HSTX.global.vpn>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserved instruction in kernel code
Thread-Index: AcpzQLP1sZJGDFhmS7mG82KGzLMtSw==
From:   "Ales Mulej" <Ales.Mulej@HSTX.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 02 Dec 2009 11:15:11.0878 (UTC) FILETIME=[B6FF8260:01CA7340]
Return-Path: <Ales.Mulej@HSTX.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25268
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ales.Mulej@HSTX.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA7340.B5457A50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I'm porting linux(2.6.31.6) to the Wintegra WINHDP2 refrence board.

As a refrence I already have an old BSP from Wintegra based on kernel
2.6.10.

=20

During the kernel start up process I receive following error:

=20

Reserved instruction in kernel code[#1]:

Cpu 0

$ 0   : 00000000 1000fc00 802be630 00000001

$ 4   : 802be670 802be674 ffffffff 802f4d4c

$ 8   : 1000fc01 1000001f 00000001 0000002b

$12   : 00000000 000001f5 07a0d380 00000000

$16   : 00000000 00000000 00000000 1000fc00

$20   : 802e9674 bd030f04 3e490000 00000a72

$24   : 00000008 8000167c                 =20

$28   : 802ba000 802bbd30 ffffffff 802f4d4c

Hi    : 000000fb

Lo    : 00000001

epc   : 801013a0 handle_ri_int+0x18/0x38

    Not tainted

ra    : 802f4d4c __log_buf+0x0/0x20000

Status: 1000fc03    KERNEL EXL IE=20

Cause : 50808000

PrId  : 00019365 (MIPS 24Kc)

Modules linked in:

Process swapper (pid: 0, threadinfo=3D802ba000, task=3D802bc000,
tls=3D00000000)

Stack : 1000fc00 1000001f 00000001 0000002b 00000000 000001f5 00000000
1000fc00

        802be630 00000001 802be670 802be674 ffffffff 802f4d4c 1000fc00
1000001f

        00000001 0000002b 00000000 000001f5 07a0d380 00000000 00000000
00000000

        00000000 1000fc00 802e9674 bd030f04 3e490000 00000a72 00000008
8000167c

        802bbe94 802a2954 802ba000 802bbde0 ffffffff 802f4d4c 1000fc02
000000fb

        ...

Call Trace:

[<801013a0>] handle_ri_int+0x18/0x38

=20

=20

Code: 01094025  3908001e  40886000 <00000040> 00000040  00000040
000000c0  03a02021  3c1f8010=20

Disabling lock debugging due to kernel taint

Kernel panic - not syncing: Attempted to kill the idle task!

=20

=20

Does anybody know where is the problem?

I suspect, that the problem is in my interrupt routine, because I
receive this error as soon as the tick timer start's up.

=20

Regards,

Ales

=20

=20

=20


------_=_NextPart_001_01CA7340.B5457A50
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
	{margin:0cm;
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
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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

<body lang=3DSL link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I'm porting linux(2.6.31.6) to the Wintegra WINHDP2 =
refrence
board.<o:p></o:p></p>

<p class=3DMsoNormal>As a refrence I already have an old BSP from =
Wintegra based
on kernel 2.6.10.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>During the kernel start up process I receive =
following
error:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Reserved instruction in kernel =
code[#1]:<o:p></o:p></p>

<p class=3DMsoNormal>Cpu 0<o:p></o:p></p>

<p class=3DMsoNormal>$ 0&nbsp;&nbsp; : 00000000 1000fc00 802be630 =
00000001<o:p></o:p></p>

<p class=3DMsoNormal>$ 4&nbsp;&nbsp; : 802be670 802be674 ffffffff =
802f4d4c<o:p></o:p></p>

<p class=3DMsoNormal>$ 8&nbsp;&nbsp; : 1000fc01 1000001f 00000001 =
0000002b<o:p></o:p></p>

<p class=3DMsoNormal>$12&nbsp;&nbsp; : 00000000 000001f5 07a0d380 =
00000000<o:p></o:p></p>

<p class=3DMsoNormal>$16&nbsp;&nbsp; : 00000000 00000000 00000000 =
1000fc00<o:p></o:p></p>

<p class=3DMsoNormal>$20&nbsp;&nbsp; : 802e9674 bd030f04 3e490000 =
00000a72<o:p></o:p></p>

<p class=3DMsoNormal>$24&nbsp;&nbsp; : 00000008
8000167c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>

<p class=3DMsoNormal>$28&nbsp;&nbsp; : 802ba000 802bbd30 ffffffff =
802f4d4c<o:p></o:p></p>

<p class=3DMsoNormal>Hi&nbsp;&nbsp;&nbsp; : 000000fb<o:p></o:p></p>

<p class=3DMsoNormal>Lo&nbsp;&nbsp;&nbsp; : 00000001<o:p></o:p></p>

<p class=3DMsoNormal>epc&nbsp;&nbsp; : 801013a0 =
handle_ri_int+0x18/0x38<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; Not tainted<o:p></o:p></p>

<p class=3DMsoNormal>ra&nbsp;&nbsp;&nbsp; : 802f4d4c =
__log_buf+0x0/0x20000<o:p></o:p></p>

<p class=3DMsoNormal>Status: 1000fc03&nbsp;&nbsp;&nbsp; KERNEL EXL IE =
<o:p></o:p></p>

<p class=3DMsoNormal>Cause : 50808000<o:p></o:p></p>

<p class=3DMsoNormal>PrId&nbsp; : 00019365 (MIPS 24Kc)<o:p></o:p></p>

<p class=3DMsoNormal>Modules linked in:<o:p></o:p></p>

<p class=3DMsoNormal>Process swapper (pid: 0, threadinfo=3D802ba000, =
task=3D802bc000,
tls=3D00000000)<o:p></o:p></p>

<p class=3DMsoNormal>Stack : 1000fc00 1000001f 00000001 0000002b =
00000000
000001f5 00000000 1000fc00<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 802be630 =
00000001
802be670 802be674 ffffffff 802f4d4c 1000fc00 1000001f<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000001 =
0000002b
00000000 000001f5 07a0d380 00000000 00000000 00000000<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 =
1000fc00
802e9674 bd030f04 3e490000 00000a72 00000008 8000167c<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 802bbe94 =
802a2954
802ba000 802bbde0 ffffffff 802f4d4c 1000fc02 000000fb<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
...<o:p></o:p></p>

<p class=3DMsoNormal>Call Trace:<o:p></o:p></p>

<p class=3DMsoNormal>[&lt;801013a0&gt;] =
handle_ri_int+0x18/0x38<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Code: 01094025&nbsp; 3908001e&nbsp; 40886000
&lt;00000040&gt; 00000040&nbsp; 00000040&nbsp; 000000c0&nbsp; =
03a02021&nbsp;
3c1f8010 <o:p></o:p></p>

<p class=3DMsoNormal>Disabling lock debugging due to kernel =
taint<o:p></o:p></p>

<p class=3DMsoNormal>Kernel panic - not syncing: Attempted to kill the =
idle task!<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Does anybody know where is the =
problem?<o:p></o:p></p>

<p class=3DMsoNormal>I suspect, that the problem is in my interrupt =
routine,
because I receive this error as soon as the tick timer start's =
up.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal>Ales<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CA7340.B5457A50--
