Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 18:08:02 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:48330
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225336AbUAMSIC>; Tue, 13 Jan 2004 18:08:02 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id DDC8C132; Tue, 13 Jan 2004 19:07:55 +0100 (NFT)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29728-05; Tue, 13 Jan 2004 19:07:54 +0100 (NFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 2C553121; Tue, 13 Jan 2004 19:07:53 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1AgSx6-0006Oq-00; Tue, 13 Jan 2004 19:07:44 +0100
To: linux-mips@linux-mips.org
Cc: ppopov@mvista.com
Subject: Kernel oops on XXS1500 in au1000eth.c
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 13 Jan 2004 19:07:44 +0100
Message-ID: <87lloblo27.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Hi,

when compiling a kernel for my XXS1500 I allways ended up with a
kernel oops in the network driver (au1000eth.c).

Finaly I checked the actual kernel source the running kernel was build
from and found "CONFIG_BCM5222_DUAL_PHY" was set. Setting that solves
the oops.

Maybe that could be caught in some way and prevented.

MfG
        Goswin

----------------------------------------------------------------------
Start = 0x80274040, range = (0x80100000,0x802bbfff), format = SREC

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 1) is a 16550
ttyS02 at 0xb1300000 (irq = 2) is a 16550
ttyS03 at 0xb1400000 (irq = 3) is a 16550
Generic MIPS RTC Driver v1.0
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
au1000eth.c:1.4 ppopov@mvista.com
eth0: Au1x Ethernet found at 0xb1500000, irq 28
eth0: Broadcom BCM5222 10/100 BaseT PHY at phy address 0
eth0: Using Broadcom BCM5222 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb1510000, irq 29
Unable to handle kernel paging request at virtual address 00000000, epc == 801c0
Oops in fault.c::do_page_fault, line 206:
$0 : 00000000 1000fc00 00000000 001e3000 802597c8 0000001f 00000001 00000013
$8 : 810cc800 b1510018 000011e0 802a1434 00000004 ba2e8ba3 1000fc01 00000002
$16: 8029f940 802db12c 00000001 00000020 810cc800 810cc9e4 810cc960 802b4cf4
$24: ffffffff 00000001                   802e4000 802e5ed8 0000ffff 801c5b60
Hi : 000304cc
Lo : ecaf8000
epc   : 801c5c10    Not tainted
Status: 1000fc03
epc   : 00800008
PrId  : 01030200
Process swapper (pid: 1, stackpage=802e4000)
Stack:    b1510000 801196ac 802598b8 810cc800 8029f940 802db12c 00000001
 810cc960 810cc800 810cc9e4 810cc9f4 b1510000 0000001d 801c63a0 80259890
 810cc800 b1510000 0000001d 87000266 00001123 00000001 802db12c 00000001
 04000000 00000000 00000000 00000000 00000000 8008aa54 80287dac 80287c80
 80287c6c 00000000 00000000 8028e530 8028e55c 00010f00 802746ec 80122ed8
 8028100c ...
Call Trace:   [<801196ac>] [<802598b8>] [<801c63a0>] [<80259890>] [<80122ed8>]
 [<8025b9cc>] [<801007c4>] [<801007d4>] [<801007c4>] [<801047d4>] [<80111e94>]
 [<8016125c>] [<80161220>] [<801047c4>]

Code: 8c420004  3c048026  248497c8 <8c460000> 0c044dc1  02802821  0807171f  000
Kernel panic: Attempted to kill init!
