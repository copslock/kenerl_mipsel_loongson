Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 16:06:39 +0100 (BST)
Received: from web13301.mail.yahoo.com ([IPv6:::ffff:216.136.175.37]:52034
	"HELO web13301.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225474AbUEQPGg>; Mon, 17 May 2004 16:06:36 +0100
Message-ID: <20040517150631.13795.qmail@web13301.mail.yahoo.com>
Received: from [12.33.232.234] by web13301.mail.yahoo.com via HTTP; Mon, 17 May 2004 08:06:31 PDT
Date: Mon, 17 May 2004 08:06:31 -0700 (PDT)
From: Ken Giusti <manwithastinkydog@yahoo.com>
Subject: running 2.6 on swarm pass1
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <manwithastinkydog@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manwithastinkydog@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I've got a swarm board with a pass1 sibyte sb1250. 
Here's the relevant system info from the boot up
console:

CFE version 1.0.36 for SWARM (64bit,MP,BE)
Build Date: Tue Jan 28 17:17:30 PST 2003
(mpl@lc-sj1-092)
Copyright (C) 2000,2001,2002,2003 Broadcom
Corporation.

Initializing Arena.
Initializing Devices.
SWARM board revision 1
Config switch: 0
CPU: BCM1250 Pass 1
L2 Cache Status: OK
Wafer ID:  Not set
SysCfg: 0000000000DB0400 [PLL_DIV: 8, IOB0_DIV:
CPUCLK/4, IOB1_DIV: CPUCLK/3]
CPU type 0x1040101: 400MHz
Total memory: 0x80000000 bytes (2048MB)

Total memory used by CFE:  0x8FE83A00 - 0x90000000
(1558016)
Initialized Data:          0x8FE83A00 - 0x8FE8D940
(40768)
BSS Area:                  0x8FE8D940 - 0x8FE8E000
(1728)
Local Heap:                0x8FE8E000 - 0x8FF8E000
(1048576)
Stack Area:                0x8FF8E000 - 0x8FF90000
(8192)
Text (code) segment:       0x8FF90000 - 0x8FFFFFB4
(458676)
Boot area (physical):      0x0FE42000 - 0x0FE82000
Relocation Factor:         I:F0390000 - D:0FE82A00

I've been running 2.4.26 taken directly from
kernel.org, using 3.0.3 gcc toolset.  Runs great, once
I applied a set of pass1 patches, and some fixes from
linux-mips.org code.

Now I'm trying to get 2.6 running, but I'm having no
luck.

I've pulled both the 2.6.6 release from kernel.org,
and the 2.6.5 release from linux-mip cvs.  In both
cases, I've used the default swarm config that shipped
with the release, unmodified.  Gcc 3.0.3 - same as
2.4.

2.6.6 from kernel.org doesn't appear to run at all.
Once I load the image via CFE and type "go" I get
absolutely no console output - the system just hangs.

2.6.5 from linux-mips is a bit better - I get bootup
console output, then an immediate crash (included
below).

Has anyone had any luck getting 2.6 running on swarm
with pass1?  

Thanks for any help you can provide,

-Ken.


Algorithmics/MIPS FPU Emulator v1.5
Kernel unaligned instruction access in
arch/mips/kernel/unaligned.c::do_ade, lin
e 544[#1]:
Cpu 1
$ 0   : 00000000 801357e0 00000071 8f9fceb8
$ 4   : 00000012 00000000 8f9a7d00 00000000
$ 8   : 00000000 00000002 801359f8 00000002
$12   : 0047e048 00000000 803b77a8 803b7788
$16   : 00000000 80134350 00000000 80143000
$20   : 00800020 fffffffd 8ffb7d40 ffffffe0
$24   : 00000000 00000002
$28   : ffffffff 8f9a7ce8 8ffaad10 8f9a7cf8
Hi    : 80134350
Lo    : 80143000
epc   : 00000002 0x2     Not tainted
ra    : 8f9a7cf8 0x8f9a7cf8
Status: 10001f03    KERNEL EXL IE
Cause : 00800010
BadVA : 00000002
PrId  : 03040101
Process events/1 (pid: 112, threadinfo=8f9a6000,
task=8f9fceb8)
Stack : 0fbcdbc0 00001fe0 00000001 00000020 24021017
0000000c 2ab07e30 10001f03
        00000000 80109bdc 00000000 00000000 00000000
801357e0 00000000 00000071
        00000000 8f9fceb8 00000000 00800112 00000000
8f985cf8 00000000 8f9a7f80
        00000000 00000000 00000000 00000000 00000000
00000002 00000000 801359f8
        00000000 00000002 00000000 0047e048 00000000
7fff7f82 00000000 803b77a8
        ...
Call Trace:
 [<80109bdc>] kernel_thread+0x3c/0x80
 [<801357e0>] do_exit+0x350/0x528
 [<801359f8>] next_thread+0x0/0x78
 [<80146b20>] ____call_usermodehelper+0x0/0x110
 [<8010bb78>] do_signal+0x720/0xe68
 [<80146c98>] wait_for_helper+0x68/0xb0
 [<80146b20>] ____call_usermodehelper+0x0/0x110
 [<80131828>] do_fork+0x198/0x240
 [<80146b20>] ____call_usermodehelper+0x0/0x110
 [<8010c2e8>] do_notify_resume+0x28/0x38
 [<80106c10>] work_notifysig+0xc/0x14
 [<80106bcc>] work_resched+0x8/0x40
 [<801357e0>] do_exit+0x350/0x528
 [<801359f8>] next_thread+0x0/0x78
 [<80134350>] allow_signal+0xb0/0xf8
 [<80143000>] do_sigaction+0x2d8/0x338
 [<80143000>] do_sigaction+0x2d8/0x338
 [<80134350>] allow_signal+0xb0/0xf8
 [<80146c30>] wait_for_helper+0x0/0xb0
 [<80146c98>] wait_for_helper+0x68/0xb0
 [<80146c30>] wait_for_helper+0x0/0xb0
 [<80109bf0>] kernel_thread+0x50/0x80
 [<80146d10>] __call_usermodehelper+0x30/0xa0
 [<80109bdc>] kernel_thread+0x3c/0x80


Code: (Bad address in epc)



	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
