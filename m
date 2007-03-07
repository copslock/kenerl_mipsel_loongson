Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2007 13:23:23 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:22214 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20021589AbXCGNXV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2007 13:23:21 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HOw3u-0007wL-00; Wed, 07 Mar 2007 14:20:10 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 04481C2349; Wed,  7 Mar 2007 14:18:42 +0100 (CET)
Date:	Wed, 7 Mar 2007 14:18:42 +0100
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	mbizon@freebox.fr, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Message-ID: <20070307131842.GA9361@alpha.franken.de>
References: <116841864595-git-send-email-fbuihuu@gmail.com> <1172879147.964.65.camel@sakura.staff.proxad.net> <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com> <1173112433.7093.36.camel@sakura.staff.proxad.net> <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Mar 06, 2007 at 10:39:59PM +0100, Franck Bui-Huu wrote:
> I think you missed PAGE_OFFSET meaning...
> 
> PAGE_OFFSET is the start of the kernel virtual address space and
> before this patchset pa(PAGE_OFFSET) was always 0.
> 
> In your case, you said:
> 
>        PAGE_OFFSET = 0x80000000
>        PHYS_OFFSET = 0x10000000
> 
> this means that the first kernel virtual address is 0x80000000 and the
> corresponding physical address is 0x10000000. If you load your kernel
> at 0x9000xxxx, it will be loaded in physical memory located at
> 0x2000xxxx which is obviously not what you want.

which sound like a very bogus setup for at leat 32bit MIPS. The mapping
virtual 0x80000000 to physical 0x00000000 is a CPU thing and can't
be changed.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
