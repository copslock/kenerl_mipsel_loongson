Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 18:21:44 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45307 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225336AbUAMSVn>;
	Tue, 13 Jan 2004 18:21:43 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA28217;
	Tue, 13 Jan 2004 10:21:37 -0800
Subject: Re: Kernel oops on XXS1500 in au1000eth.c
From: Pete Popov <ppopov@mvista.com>
To: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <87lloblo27.fsf@mrvn.homelinux.org>
References: <87lloblo27.fsf@mrvn.homelinux.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1074018143.21864.13.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jan 2004 10:22:24 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2004-01-13 at 10:07, Goswin von Brederlow wrote:
> Hi,
> 
> when compiling a kernel for my XXS1500 I allways ended up with a
> kernel oops in the network driver (au1000eth.c).
> 
> Finaly I checked the actual kernel source the running kernel was build
> from and found "CONFIG_BCM5222_DUAL_PHY" was set. Setting that solves
> the oops.
> 
> Maybe that could be caught in some way and prevented.

Well, the kernel shouldn't be crashing but as far as the BCM dual phy
thing -- I'm not sure how to detect it at run time without knowing ahead
of time that we've got one.  I admittedly haven't spent too much time
thinking about this problem but I didn't see an easy way to handle it.

Pete

> MfG
>         Goswin
> 
> ----------------------------------------------------------------------
> Start = 0x80274040, range = (0x80100000,0x802bbfff), format = SREC
> 
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> pty: 256 Unix98 ptys configured
> Serial driver version 1.01 (2001-02-08) with no serial options enabled
> ttyS00 at 0xb1100000 (irq = 0) is a 16550
> ttyS01 at 0xb1200000 (irq = 1) is a 16550
> ttyS02 at 0xb1300000 (irq = 2) is a 16550
> ttyS03 at 0xb1400000 (irq = 3) is a 16550
> Generic MIPS RTC Driver v1.0
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> au1000eth.c:1.4 ppopov@mvista.com
> eth0: Au1x Ethernet found at 0xb1500000, irq 28
> eth0: Broadcom BCM5222 10/100 BaseT PHY at phy address 0
> eth0: Using Broadcom BCM5222 10/100 BaseT PHY as default
> eth1: Au1x Ethernet found at 0xb1510000, irq 29
> Unable to handle kernel paging request at virtual address 00000000, epc == 801c0
> Oops in fault.c::do_page_fault, line 206:
> $0 : 00000000 1000fc00 00000000 001e3000 802597c8 0000001f 00000001 00000013
> $8 : 810cc800 b1510018 000011e0 802a1434 00000004 ba2e8ba3 1000fc01 00000002
> $16: 8029f940 802db12c 00000001 00000020 810cc800 810cc9e4 810cc960 802b4cf4
> $24: ffffffff 00000001                   802e4000 802e5ed8 0000ffff 801c5b60
> Hi : 000304cc
> Lo : ecaf8000
> epc   : 801c5c10    Not tainted
> Status: 1000fc03
> epc   : 00800008
> PrId  : 01030200
> Process swapper (pid: 1, stackpage=802e4000)
> Stack:    b1510000 801196ac 802598b8 810cc800 8029f940 802db12c 00000001
>  810cc960 810cc800 810cc9e4 810cc9f4 b1510000 0000001d 801c63a0 80259890
>  810cc800 b1510000 0000001d 87000266 00001123 00000001 802db12c 00000001
>  04000000 00000000 00000000 00000000 00000000 8008aa54 80287dac 80287c80
>  80287c6c 00000000 00000000 8028e530 8028e55c 00010f00 802746ec 80122ed8
>  8028100c ...
> Call Trace:   [<801196ac>] [<802598b8>] [<801c63a0>] [<80259890>] [<80122ed8>]
>  [<8025b9cc>] [<801007c4>] [<801007d4>] [<801007c4>] [<801047d4>] [<80111e94>]
>  [<8016125c>] [<80161220>] [<801047c4>]
> 
> Code: 8c420004  3c048026  248497c8 <8c460000> 0c044dc1  02802821  0807171f  000
> Kernel panic: Attempted to kill init!
> 
> 
