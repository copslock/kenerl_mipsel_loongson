Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 16:18:24 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:8967 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20039134AbXKZQSM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 16:18:12 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B87A9D8E0; Mon, 26 Nov 2007 16:17:34 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A679E544F2; Mon, 26 Nov 2007 17:17:20 +0100 (CET)
Date:	Mon, 26 Nov 2007 17:17:20 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, manoj.ekbote@broadcom.com,
	mark.e.mason@broadcom.com
Subject: Re: BigSur: oops loading ramdisk
Message-ID: <20071126161720.GD23315@deprecation.cyrius.com>
References: <20071125125229.GJ20922@deprecation.cyrius.com> <20071126144543.GA19679@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126144543.GA19679@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2007-11-26 14:45]:
> > With a 32 bit kernel (current git) on BigSur, I get an oops while
> > trying to load the ramdisk:
> I've just modified the memory initialization code significantly to add
> support for ZONE_DMA32 for the Sibyte boxes, so could you retest?

Same problem with your patch (current Linus git plus your patch):

Freeing unused kernel memory: 136k freed
CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 8029a238, ra == 8029d674
Oops[#1]:
Cpu 0
$ 0   : 00000000 10001f00 00000000 00000000
$ 4   : 8e89f000 00000000 8f421df8 00000000
$ 8   : 80440000 8e889a6c 00000000 0000000e
$12   : 8ec6903c ffffffff 00000000 00000088
$16   : 8eda0240 80450000 00500001 8e89f000
$20   : 00000002 8f00d114 00000000 00000000
$24   : 00000003 000000cd
$28   : 8f420000 8f421da8 00000000 8029d674
Hi    : 00000002
Lo    : 82828285
epc   : 8029a238 init_dev+0x8c/0x56c     Not tainted
ra    : 8029d674 tty_open+0x148/0x330
Status: 10001f03    KERNEL EXL IE
Cause : 00808008
BadVA : 00000000
PrId  : 01041100 (SiByte SB1A)
Modules linked in:
Process swapper (pid: 1, threadinfo=8f420000, task=8f41f928)
Stack : 801789f0 00000003 8044e874 8e89f000 8f421dfc 00000000 8eda0240 80450000
        00500001 00000001 00000002 8f00d114 00000000 00000000 00000000 8029d674
        8ec69d28 00000000 8f421df8 00000000 8ec69d28 00000000 00000000 80496fe0
        8ec69d28 8eda0240 8f4032a0 80172fa8 00000000 8f413000 ffffff9c 8017bb04
        00000000 8043bba0 8eda0240 8ec69d28 00000000 80172e88 8016df1c 80440000
        ...
Call Trace:
[<8029a238>] init_dev+0x8c/0x56c
[<8029d674>] tty_open+0x148/0x330
[<80172fa8>] chrdev_open+0x120/0x178
[<8016df1c>] __dentry_open+0x104/0x210
[<8016e0d4>] nameidata_to_filp+0x30/0x54
[<8016e138>] do_filp_open+0x40/0x54
[<8016e1b0>] do_sys_open+0x64/0x114
[<80100448>] init_post+0x30/0xe8
[<80456874>] kernel_init+0x2e4/0x314


Code: 8c8200a0  00051880  00431021 <8c510000> 162000e2  00000000  8e64003c  10800009  24020002
Kernel panic - not syncing: Attempted to kill init!

-- 
Martin Michlmayr
http://www.cyrius.com/
