Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 08:01:07 +0000 (GMT)
Received: from mail.cryptoapps.com ([IPv6:::ffff:202.49.232.10]:58853 "EHLO
	iron-maiden.cryptoapps.com") by linux-mips.org with ESMTP
	id <S8224939AbTBYIBH>; Tue, 25 Feb 2003 08:01:07 +0000
Received: by iron-maiden.cryptoapps.com (Postfix, from userid 1000)
	id 4477027D51; Tue, 25 Feb 2003 00:01:04 -0800 (PST)
Date: Tue, 25 Feb 2003 00:01:04 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: linux-mips@linux-mips.org
Subject: Pb1500 PCI problems
Message-ID: <20030225080104.GA18741@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <chris@cryptoapps.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@cryptoapps.com
Precedence: bulk
X-list: linux-mips

I've seen some strange stuff in the PCI code in 2.4.19-rc1 and 2.4.20
from the CVS tree.

Neither trees compile out of the box for the PB1500, both having errors
in one place or another.  2.4.20 blows up during boot in:

...

00:10.0 Class 2000: 0356:2000 (rev 56)
        Mem unavailable -- skipping
        Mem unavailable -- skipping
        Mem unavailable -- skipping
        Mem unavailable -- skipping
        Mem unavailable -- skipping
        Mem unavailable -- skipping
00:11.0 Class 0000: 0000:0000
        Mem at 0x40000000 [size=0xffd0]
        Mem at 0x4000ffd0 [size=0xffd0]
Reserved instruction in kernel code in traps.c::do_ri, line 650:
$0 : 00000000 1000fc00 c0000000 c0000000 00000001 c0000000 00000000 1000fc00
$8 : 810fa7f0 00000000 ffffffbf ffffffff fffffff8 ffffffff 00000010 00000003
$16: 00000000 00000000 8034be88 00000000 00000000 00000098 00000000 00000000
$24: 8034bd53 00000000                   8034a000 8034be48 00000004 80274c80
Hi : 00000000
Lo : 000000c0
epc  : 80274ca0    Not tainted
Status: 1000fc02
Cause : 00800028
Process swapper (pid: 1, stackpage=8034a000)
Stack:    00000000 00000098 8027fe6f 80274c80 00000400 0000000d 00000000
 8034bef0 00000000 8030e108 80274e0c 00000088 00000000 00000000 802b4588
 802dbc68 8027fe58 4000ffd0 1000fc01 00000090 801e73d8 4000ffd0 ffff0036
 00000000 00000000 00000088 00000000 801084f0 00000000 00000098 00000000
 00000000 802b49d0 802b4b34 8027fea0 00000000 00000001 00000001 00000000
 8034bef0 ...
Call Trace:   [<8027fe6f>] [<80274c80>] [<80274e0c>] [<8027fe58>] [<801e73d8>]
 [<801084f0>] [<8027fea0>] [<8010078c>] [<8027ff6c>] [<8012cf90>] [<8010078c>]
 [<80101f24>] [<801e9040>] [<8010078c>] [<8010079c>] [<801022d4>] [<80100780>]
 [<801022c4>]

Code: 24040001  12640023  00431825 <8c620000> ae420000  0000000f  3c03000d  34631b72  3c02802d 
Kernel panic: Attempted to kill init!


2.4.19-rc1 fares a little better, but has strange problems as well:


chris@au1500:~$ lspci -vv
00:01.0 PIC: Unknown device bad7:0800 (rev db) (prog-if ba)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 255
        Region 0: Memory at <ignored> (type 3, prefetchable) [disabled]
        Region 2: I/O ports at <ignored> [disabled]
        Region 4: Memory at <ignored> (low-1M, prefetchable) [disabled]
        Expansion ROM at 0800b800 [disabled] [size=2K]

00:05.0 Class 1060: Unknown device 0007:1040 (rev 0d)
        !!! Invalid class 1060 for header type 02
        Subsystem: Unknown device 4054:0800
        Control: I/O- Mem+ BusMaster- SpecCycle+ MemWINV+ VGASnoop+ ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 255
        Region 0: I/O ports at <ignored> [disabled]
        Bus: primary=55, secondary=40, subordinate=00, sec-latency=8
        BridgeCtl: Parity+ SERR- ISA+ VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0006

00:0a.0 Class 8e10: Unknown device f809:0040 (rev 10)
        Subsystem: Unknown device 0008:03e0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 3000ns max), cache line size da
        Interrupt: pin         Region 5: Memory at <invalid-64bit-slot> (64-bit, non-prefetchable)
        Expansion ROM at 27bd0000 [disabled] [size=2K]

00:10.0 Class 2000: Unknown device 0356:2000 (rev 56) (prog-if 03)
        Subsystem: Unknown device 0356:2000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B+
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 3 (8000ns max), cache line size 56
        Interrupt: pin C routed to IRQ 255
        Region 0: Memory at 20000350 (type 3, non-prefetchable) [size=16]
        Region 1: Memory at 20000350 (type 3, non-prefetchable) [size=16]
        Region 2: Memory at 20000350 (type 3, non-prefetchable) [size=16]
        Region 3: Memory at 20000350 (type 3, non-prefetchable) [size=16]
        Region 4: Memory at 20000350 (type 3, non-prefetchable) [size=16]
        Region 5: Memory at 20000350 (type 3, non-prefetchable) [size=16]
        Expansion ROM at 20000000 [disabled] [size=512M]


Before I go digging too much, I'd like it if someone else with a PB1500
or similar can confirm what I'm seeing.

The kernel was built with defconfig-pb1500, and using GCC 3.2.2 and bintutils 2.13

The 2.4.19-rc1 kernel seems to work fine otherwise, BTW

Thanks

--Chris
