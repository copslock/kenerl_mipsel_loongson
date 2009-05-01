Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 14:47:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45688 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20027498AbZEANrc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 May 2009 14:47:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n41DlRkI021663;
	Fri, 1 May 2009 15:47:29 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n41DlLfa021660;
	Fri, 1 May 2009 15:47:21 +0200
Date:	Fri, 1 May 2009 15:47:21 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] flash_setup should only be built when CONFIG_MTD is
	enabled
Message-ID: <20090501134720.GA15672@linux-mips.org>
References: <200904301748.52718.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200904301748.52718.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 30, 2009 at 05:48:51PM +0200, Florian Fainelli wrote:

> Building flash_setup while CONFIG_MTD is not enabled does work, but
> results in the following oops while booting:
> 
> Bootbus flash: Setting flash for 32MB flash at 0x1dc00000
> Kernel bug detected[#1]:
> Cpu 0
> $ 0   : 0000000000000000 0000000000000010 000000000000003d 0000000000000002
> $ 4   : 0000000000000001 0000000000000000 ffffffffffffffff 0000000000000d52
> $ 8   : 0000000000000d52 000000000000003e 000000000000000a 0000000000000d17
> $12   : 0000000000000031 ffffffff81105e2c 00000000f34c39b5 0000000017da5c01
> $16   : ffffffff813ab588 ffffffff8138b514 0000000000000001 ffffffff814d2390
> $20   : 0000000000000010 0000000000000010 0000000000000000 0000000000000000
> $24   : 000000000931a549 ffffffff8110e68c
> $28   : a800000007828000 a80000000782bf00 0000000000000000 ffffffff8138b594
> Hi    : 0000000000000191
> Lo    : 36978d4fdf254137
> epc   : ffffffff8138b594 0xffffffff8138b594
>     Not tainted
> ra    : ffffffff8138b594 0xffffffff8138b594
> Status: 10008ce3    KX SX UX KERNEL EXL IE
> Cause : 00800024
> PrId  : 000d0601 (Cavium Octeon)
> Modules linked in:
> Process swapper (pid: 1, threadinfo=a800000007828000, task=a800000007825540, tls=0000000000000000)
> Stack : ffffffff813ab580 ffffffff8110d918 0000000007885780 ffffffff81385080
>         ffffffff81385080 ffffffff8116ca10 3135310000000000 0000000000000000
>         0000000000000098 ffffffff81360000 ffffffff81350000 ffffffff813ab588
>         ffffffff813ab5d0 ffffffff81350000 ffffffff814d2390 ffffffff813862e8
>         000000000000ffff 0000000000000000 0000000000000000 0000000000000000
>         0000000000000000 0000000000000000 0000000000000000 0000000000000000
>         0000000000000000 ffffffff81114f38 0000000000000000 0000000000000000
>         0000000000000000 0000000000000000 0000000000000000 0000000000000000
> Call Trace:[<ffffffff8110d918>] 0xffffffff8110d918
> [<ffffffff8116ca10>] 0xffffffff8116ca10
> [<ffffffff813862e8>] 0xffffffff813862e8
> [<ffffffff81114f38>] 0xffffffff81114f38
> 
> This patch makes flash_setup be compiled only when CONFIG_MTD
> which solves issue, the MTD driver then fails to register but this is
> less critical.

I think your code blows up if !CONFIG_MTD_COMPLEX_MAPPINGS and
!CONFIG_MTD_MAP_BANK_WIDTH_1 in which case simple_map_init is defined as:

#define simple_map_init(map) BUG_ON(!map_bankwidth_supported((map)->bankwidth))

bankwidth is 1, so:

static inline int map_bankwidth_supported(int w)
{
        switch (w) {
#ifdef CONFIG_MTD_MAP_BANK_WIDTH_1
        case 1:
#endif
                return 1;
[...]
        default:
                return 0;
        }
}

  Ralf
