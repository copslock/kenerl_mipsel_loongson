Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 18:41:51 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:22661 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20038613AbYBGSln (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2008 18:41:43 +0000
Received: (qmail invoked by alias); 07 Feb 2008 18:41:37 -0000
Received: from vpn58.rz.tu-ilmenau.de (EHLO [192.168.1.100]) [141.24.172.58]
  by mail.gmx.net (mp001) with SMTP; 07 Feb 2008 19:41:37 +0100
X-Authenticated: #44099387
X-Provags-ID: V01U2FsdGVkX19mpMBZ9JJmIBiZ+qKkXKo69bKHjP9z/hZayvc/I2
	ASZNmCqLOEGfuC
Message-ID: <47AB50DD.2050504@gmx.net>
Date:	Thu, 07 Feb 2008 19:41:33 +0100
From:	Andi <opencode@gmx.net>
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Problems booting Linux kernel on Sigma SMP8634
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <opencode@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hey Folks,

we are working on a SMP8634-based box to get Linux running on it.
Since we don't have any documentation, neither hardware nor software,
there is a lot of re-engineering work to be done.
However, we managed it to let the box load a Linux kernel .. but it
still fails at a certain point.
It's right before the kernel loads the "NET: .."-stuff. I got this from
an other SMP8634-based box, which runs the same kernel.

Any hints about what might doesn't work?


Regards,
	Andi


<output>
Execute final at 0x90020000 ..
Linux version 2.6.15-sigma (rolandhii@venus) (gcc version 4.0.4) #118
PREEMPT We
d Jan 23 10:43:14 CST 2008
Configured for SMP8634 (revision ES6/RevA), detected SMP8634 (revision
ES6/RevA)
.
SMP863x/SMP865x Enabled Devices under Linux/XENV 0x48000000 = 0x00023efe
 BM/IDE PCIHost Ethernet IR FIP I2CM I2CS USB PCIDev1 PCIDev2 PCIDev3
PCIDev4 SC
ARD
Valid MEMCFG found at 0x10000fc0.
CPU revision is: 00019068
Determined physical RAM map:
 memory: 05ee0000 @ 10020000 (usable)
On node 0 totalpages: 89856
  DMA zone: 89856 pages, LIFO batch:15
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: pci=disabled ip=dhcp root=/dev/nfs noinitrd
Primary instruction cache 16kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 16kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (20 instructions).
Synthesized TLB load handler fastpath (32 instructions).
Synthesized TLB store handler fastpath (32 instructions).
Synthesized TLB modify handler fastpath (31 instructions).
PID hash table entries: 2048 (order: 11, 32768 bytes)
Using 148.500 MHz high precision timer.
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 86656k/97152k available (3399k kernel code, 10476k reserved,
536k data,
3108k init, 0k highmem)
Calibrating delay loop... 292.86 BogoMIPS (lpj=146432)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
CPU 0 Unable to handle kernel paging request at virtual address
00000000, epc ==
 9006aea0, ra == 9036dd88
Oops[#1]:
Cpu 0
$ 0   : 00000000 00000001 90a7f87c 00000000
$ 4   : 95e88d38 90a7f870 00000001 00000000
$ 8   : 90702b80 90700000 90a7b000 00000000
$12   : 90a7e000 95e88cc0 00000012 00000010
$16   : 90a6df70 95e88d34 90a75be8 95e88d38
$20   : 90420000 90700000 00000030 90420000
$24   : 00000001 00000000
$28   : 90a7e000 90a7f860 90380000 9036dd88
Hi    : 2a8b2775
Lo    : 355f2140
epc   : 9006aea0     Not tainted
ra    : 9036dd88 Status: 10001c02    KERNEL EXL
Cause : 7080800c
BadVA : 00000000
PrId  : 00019068
Modules linked in:
Process swapper (pid: 1, threadinfo=90a7e000, task=90a75be8)
Stack : 00000000 00000000 00000001 00000000 00000001 90a75be8 90047cd0
95e88d38
        00000000 00000001 90a6df70 95e88d34 90700000 00007948 90420000
9009a838
        90a7b000 00007948 90420000 90700000 00001846 900b4d60 00000000
00000000
        900c9ec4 90a7b000 00000000 90a7f908 90a7b000 900b87c8 90a6df70
00000000
        90710000 00000000 00000000 00000000 00000000 9009a8e8 90420000
90700000
        ...
Call Trace: [<90047cd0>]  [<9009a838>]  [<900b4d60>]  [<900c9ec4>]
[<900b87c8>]
  [<9009a8e8>]  [<9009a900>]  [<903fa270>]  [<903fa2ec>]  [<903faa64>]
[<903700
00>]  [<903fb10c>]  [<9008190c>]  [<903fb92c>]  [<903fc5f0>]
[<90053b74>]  [<90
053b44>]  [<900204d0>]  [<90026bdc>]  [<90026bcc>]

Code: 24a2000c  aca4000c  ac820004 <ace20000> ac470004  10c00002
41606000  4160
6020  000000c0
Kernel panic - not syncing: Attempted to kill init!
</output>
