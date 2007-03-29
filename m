Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 19:59:11 +0100 (BST)
Received: from 3phoenix.com ([207.234.209.100]:39869 "EHLO
	dedicated.3phoenix.com") by ftp.linux-mips.org with ESMTP
	id S20023203AbXC2S7H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Mar 2007 19:59:07 +0100
X-ClientAddr: 24.106.202.234
Received: from 3PiGAS (rrcs-24-106-202-234.se.biz.rr.com [24.106.202.234] (may be forged))
	(authenticated bits=0)
	by dedicated.3phoenix.com (8.13.6/8.13.6) with ESMTP id l2TIx7sC006551;
	Thu, 29 Mar 2007 14:59:08 -0400
From:	"Gary Smith" <gary.smith@3phoenix.com>
To:	<linux-mips@linux-mips.org>
Subject: 'mem= ' Kernel Boot Parameter on BCM1250/1480 Platform
Date:	Thu, 29 Mar 2007 14:56:49 -0400
Organization: 3 Phoenix, Inc.
Message-ID: <001301c77234$04d014c0$8eacaac0@3PiGAS>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0014_01C77212.7DBE74C0"
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcdyNAE1qiw3sdP2R5OSpi6yavpHpw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
X-3PHOENIX-MailScanner-Information: Please contact the ISP for more information
X-3PHOENIX-MailScanner:	Found to be clean
X-3PHOENIX-MailScanner-From: gary.smith@3phoenix.com
Return-Path: <gary.smith@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gary.smith@3phoenix.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0014_01C77212.7DBE74C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Linux-Mips Developers:

 

I'd like to ask a question about use of the 'mem=' kernel parameter.  When
booting without this parameter, the kernel automatically detects the amount
of memory as 989020 kB.  If a kernel parameter is added to specify
'mem=989020k' a TLB Miss error is encountered.  Do you all have guidance
about how the memory parameter can be specified without causing the error?
Since the mem= parameter was set to an identical value as the memory
reported by meminfo in the /proc filesystem, use of this kernel parameter
should be OK.  This behavior has been observed on both the BCM1250/1480
platforms when running Debian linux.  The 2.6.17-2 kernel is used with the
system.

 

Thanks,

Gary

--

Gary A. Smith, ABD PhD
Engineer, 3Phoenix, Inc.

3331 Heritage Trade Drive

Suite 101

Wake Forest, NC  27587

919.562.5333 x107

 <http://www.3Phoenix.com> http://www.3Phoenix.com

Gary.Smith@3Phoenix.com

 

 

debian:/proc# more meminfo

MemTotal:       989020 kB

MemFree:        957876 kB

Buffers:          1660 kB

Cached:          12076 kB

SwapCached:          0 kB

Active:          10308 kB

Inactive:         5224 kB

HighTotal:           0 kB

HighFree:            0 kB

LowTotal:       989020 kB

LowFree:        957876 kB

SwapTotal:       72252 kB

SwapFree:        72252 kB

Dirty:             524 kB

Writeback:           0 kB

Mapped:           4496 kB

Slab:             7236 kB

CommitLimit:    566760 kB

Committed_AS:     4360 kB

PageTables:        188 kB

VmallocTotal: 1073741824 kB

VmallocUsed:       916 kB

VmallocChunk: 1073739640 kB

 

 

CFE version 1.3.3 for SWARM (64bit,MP,BE,MIPS) Build Date: Tue Dec 19
06:41:38 EST 2006 (root@static-host) Copyright (C)
2000,2001,2002,2003,2004,2005 Broadcom Corporation.

 

Initializing Arena.

Initializing Devices.

SWARM board revision 3

sbeth: found phy 1, vendor 000818 part 0C

sbeth: found phy 1, vendor 000818 part 0C Config switch: 0

CPU: BCM1250 B2

L2 Cache Status: OK

Wafer ID:   0x7F21A009  [Lot 8136, Wafer 13]

Manuf Test: Bin A [2CPU_FI_FD_F2 (OK)]

SysCfg: 0000000008C20800 [PLL_DIV: 16, IOB0_DIV: CPUCLK/4, IOB1_DIV:

CPUCLK/3]

CPU type 0x1040102: 800MHz

Total memory: 0x40000000 bytes (1024MB)

 

Total memory used by CFE:  0x8FEB3000 - 0x8FFFF520 (1361184)

Initialized Data:          0x8FEF5408 - 0x8FEFD100 (31992)

BSS Area:                  0x8FEFD100 - 0x8FEFD520 (1056)

Local Heap:                0x8FEFD520 - 0x8FFFD520 (1048576)

Stack Area:                0x8FFFD520 - 0x8FFFF520 (8192)

Text (code) segment:       0x8FEB3000 - 0x8FEF4C75 (269429)

Boot area (physical):      0x0FE72000 - 0x0FEB2000

Relocation Factor:         I:F02B3000 - D:F02B3000

 

 

*** Autoboot: Trying device 'ide0.0' file  (ide0.0,raw)

 

Loader:raw Filesys:raw Dev:ide0.0 File: Options:(null)

Loading: ........... 130560 bytes read

Entry at 0x20000000

Starting program at 0x20000000

 

SiByte Loader, version 2.4.2

Built on Oct  4 2005

Getting configuration file ext2:ide0.0:*:sibyl.conf...

Config file retrieved.

Loading kernel (ELF64):

    4256456@0x80100000

done

Set up command line arguments to: root=/dev/hda3 console=duart0 mem=989020k
Setting up initial prom_init arguments **Exception 32: EPC=0000000020000BC8,
Cause=00009008 (TLBMissRd) (CPU0)

                RA=0000000020000BB4, VAddr=0000000000000000, SR=00000082

 

        0  ($00) = 0000000000000000     AT ($01) = 0000000000000001

        v0 ($02) = FFFFFFFF8FEFCC70     v1 ($03) = 0000000000000000

        a0 ($04) = 0000000000000010     a1 ($05) = 0000000000000000

        a2 ($06) = 000000008FEB3CDC     a3 ($07) = 0000000000000000

        t0 ($08) = 0000000000000080     t1 ($09) = 0000000000000001

        t2 ($10) = 0000000000000001     t3 ($11) = 0000000000000000

        t4 ($12) = 0000000000000000     t5 ($13) = 0000000000000000

        t6 ($14) = 0000000000000015     t7 ($15) = 0000000045000000

        s0 ($16) = FFFFFFFF8FEB3AF4     s1 ($17) = FFFFFFFF8FEFD4E0

        s2 ($18) = FFFFFFFF8FFFF250     s3 ($19) = FFFFFFFF8FEFD0B8

        s4 ($20) = 0000000000000000     s5 ($21) = 0000000000000000

        s6 ($22) = 0000000000000000     s7 ($23) = FFFFFFFF8FEB3000

        t8 ($24) = 0000000000000000     t9 ($25) = 0000000000000000

        k0 ($26) = 0000000000000001     k1 ($27) = 000000008FEB3CDC

        gp ($28) = 00000000200278F0     sp ($29) = FFFFFFFF8FFFECE0

        fp ($30) = FFFFFFFF8FFFECE0     ra ($31) = 0000000020000BB4


------=_NextPart_000_0014_01C77212.7DBE74C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Courier New";
	color:black;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>Dear =
Linux-Mips
Developers:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>I&#8217;d like
to ask a question about use of the &#8216;mem=3D&#8217; kernel =
parameter.&nbsp;
When booting without this parameter, the kernel automatically detects =
the
amount of memory as </span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>989020 kB.&nbsp; If =
a kernel
parameter is added to specify &#8216;mem=3D989020k&#8217; a TLB Miss =
error is
encountered.&nbsp; Do you all have guidance about how the memory =
parameter can
be specified without causing the error?&nbsp; Since the mem=3D parameter =
was set
to an identical value as the memory reported by meminfo in the /proc
filesystem, use of this kernel parameter should be OK.&nbsp; This =
behavior has
been observed on both the BCM1250/1480 platforms when running Debian =
linux.&nbsp;
The 2.6.17-2 kernel is used with the system.<font color=3Dblack><span
style=3D'color:black'><o:p></o:p></span></font></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Gary<font color=3Dblack><span =
style=3D'color:black'><o:p></o:p></span></font></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>--</span></font><font
color=3Dblack><span style=3D'color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>Gary A. =
Smith,
ABD PhD<br>
Engineer, 3Phoenix, Inc.</span></font><font color=3Dblack><span =
style=3D'color:
black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>3331 =
Heritage
Trade Drive</span></font><font color=3Dblack><span =
style=3D'color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>Suite =
101</span></font><font
color=3Dblack><span style=3D'color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>Wake =
Forest,
NC&nbsp; 27587</span></font><font color=3Dblack><span =
style=3D'color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>919.562.5333
x107</span></font><font color=3Dblack><span =
style=3D'color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><a =
href=3D"http://www.3Phoenix.com"
title=3D"blocked::http://www.3phoenix.com/"><font size=3D2 =
face=3D"Courier New"
title=3D"blocked::http://www.3phoenix.com/"><span
title=3D"blocked::http://www.3phoenix.com/"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>http://www.3Phoenix.com</span></span></font></a><o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>Gary.Smith@3Phoenix.com<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>debian:/proc# more =
meminfo<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
989020
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>MemFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
957876 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1660 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
12076 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
10308 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Inactive:&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;5224 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>HighTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
0 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>HighFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
0 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>LowTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
989020
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>LowFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
957876 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 72252
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
72252 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>Dirty:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
524 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>Writeback:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
0 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>Mapped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

4496 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>Slab:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
7236 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>CommitLimit:&nbsp;&nbsp;&nbsp; 566760 =
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Committed_AS:&nbsp;&nbsp;&nbsp;&nbsp; 4360 =
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>PageTables:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
188 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>VmallocTotal: 1073741824 =
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>VmallocUsed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 916
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>VmallocChunk: 1073739640 =
kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>CFE version 1.3.3 for SWARM =
(64bit,MP,BE,MIPS) Build
Date: Tue Dec 19 06:41:38 EST 2006 (root@static-host) Copyright (C)
2000,2001,2002,2003,2004,2005 Broadcom =
Corporation.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Initializing =
Arena.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Initializing =
Devices.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>SWARM board revision =
3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>sbeth: found phy 1, vendor 000818 part =
0C<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>sbeth: found phy 1, vendor 000818 part 0C =
Config
switch: 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>CPU: BCM1250 B2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>L2 Cache Status: =
OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Wafer ID:&nbsp;&nbsp; 0x7F21A009&nbsp; [Lot =
8136,
Wafer 13]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Manuf Test: Bin A [2CPU_FI_FD_F2 =
(OK)]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>SysCfg: 0000000008C20800 [PLL_DIV: 16, =
IOB0_DIV:
CPUCLK/4, IOB1_DIV:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>CPUCLK/3]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>CPU type 0x1040102: =
800MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Total memory: 0x40000000 bytes =
(1024MB)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Total memory used by CFE:&nbsp; 0x8FEB3000 -
0x8FFFF520 (1361184)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Initialized
Data:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8FEF5408 -
0x8FEFD100 (31992)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>BSS
Area:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x8FEFD100 - 0x8FEFD520 (1056)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Local
Heap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
0x8FEFD520 - 0x8FFFD520 (1048576)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Stack
Area:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
0x8FFFD520 - 0x8FFFF520 (8192)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Text (code)
segment:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8FEB3000 - 0x8FEF4C75 =
(269429)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Boot area =
(physical):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x0FE72000 - 0x0FEB2000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Relocation
Factor:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I:F02B3000 - =
D:F02B3000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>*** Autoboot: Trying device 'ide0.0' =
file&nbsp;
(ide0.0,raw)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Loader:raw Filesys:raw Dev:ide0.0 File:
Options:(null)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Loading: ........... 130560 bytes =
read<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Entry at =
0x20000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Starting program at =
0x20000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>SiByte Loader, version =
2.4.2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Built on Oct&nbsp; 4 =
2005<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Getting configuration file
ext2:ide0.0:*:sibyl.conf...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Config file =
retrieved.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Loading kernel =
(ELF64):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
4256456@0x80100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>done<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Set up command line arguments to: =
root=3D/dev/hda3
console=3Dduart0 mem=3D989020k Setting up initial prom_init arguments =
**Exception
32: EPC=3D0000000020000BC8, Cause=3D00009008 (TLBMissRd) =
(CPU0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
RA=3D0000000020000BB4, VAddr=3D0000000000000000, =
SR=3D00000082<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;
($00) =3D 0000000000000000&nbsp;&nbsp;&nbsp;&nbsp; AT ($01) =3D =
0000000000000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v0 =
($02)
=3D FFFFFFFF8FEFCC70&nbsp;&nbsp;&nbsp;&nbsp; v1 ($03) =3D =
0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a0 =
($04)
=3D 0000000000000010&nbsp;&nbsp;&nbsp;&nbsp; a1 ($05) =3D =
0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a2 =
($06)
=3D 000000008FEB3CDC&nbsp;&nbsp;&nbsp;&nbsp; a3 ($07) =3D =
0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t0 =
($08)
=3D 0000000000000080&nbsp;&nbsp;&nbsp;&nbsp; t1 ($09) =3D =
0000000000000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t2 =
($10)
=3D 0000000000000001&nbsp;&nbsp;&nbsp;&nbsp; t3 ($11) =3D =
0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t4 =
($12)
=3D 0000000000000000&nbsp;&nbsp;&nbsp;&nbsp; t5 ($13) =3D =
0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t6 =
($14)
=3D 0000000000000015&nbsp;&nbsp;&nbsp;&nbsp; t7 ($15) =3D =
0000000045000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s0 =
($16)
=3D FFFFFFFF8FEB3AF4&nbsp;&nbsp;&nbsp;&nbsp; s1 ($17) =3D =
FFFFFFFF8FEFD4E0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s2 =
($18)
=3D FFFFFFFF8FFFF250&nbsp;&nbsp;&nbsp;&nbsp; s3 ($19) =3D =
FFFFFFFF8FEFD0B8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s4 =
($20)
=3D 0000000000000000&nbsp;&nbsp;&nbsp;&nbsp; s5 ($21) =3D =
0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s6 =
($22)
=3D 0000000000000000&nbsp;&nbsp;&nbsp;&nbsp; s7 ($23) =3D =
FFFFFFFF8FEB3000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t8 =
($24)
=3D 0000000000000000&nbsp;&nbsp;&nbsp;&nbsp; t9 ($25) =3D =
0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k0 =
($26)
=3D 0000000000000001&nbsp;&nbsp;&nbsp;&nbsp; k1 ($27) =3D =
000000008FEB3CDC<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gp =
($28)
=3D 00000000200278F0&nbsp;&nbsp;&nbsp;&nbsp; sp ($29) =3D =
FFFFFFFF8FFFECE0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp =
($30)
=3D FFFFFFFF8FFFECE0&nbsp;&nbsp;&nbsp;&nbsp; ra ($31) =3D =
0000000020000BB4<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0014_01C77212.7DBE74C0--
