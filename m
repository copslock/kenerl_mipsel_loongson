Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2007 09:21:51 +0100 (BST)
Received: from marmite.frogfoot.net ([196.1.58.49]:59876 "EHLO
	marmite.frogfoot.net") by ftp.linux-mips.org with ESMTP
	id S20022470AbXGBIVt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Jul 2007 09:21:49 +0100
Received: from michael by marmite.frogfoot.net with local (Exim 4.63)
	(envelope-from <michael@frogfoot.com>)
	id 1I5H78-0004f9-Sd; Mon, 02 Jul 2007 10:18:30 +0200
Date:	Mon, 2 Jul 2007 10:18:30 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Unhandled kernel unaligned access debugging
Message-ID: <20070702081830.GH5929@marmite.frogfoot.net>
References: <20070629163951.GG5929@marmite.frogfoot.net> <20070701.014454.126142904.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070701.014454.126142904.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Michael Wood <michael@frogfoot.com>
Return-Path: <michael@frogfoot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@frogfoot.com
Precedence: bulk
X-list: linux-mips

On Sun, Jul 01, 2007 at 01:44:54AM +0900, Atsushi Nemoto wrote:
> On Fri, 29 Jun 2007 18:39:51 +0200, Michael Wood <michael@frogfoot.com> wrote:
> > I think understand more or less what this means, but am unsure of how to
> > debug it.  I think OpenWRT is using the vanilla kernel, but maybe I'm
> > missing something.  Is this because I'm not using the kernel from
> > linux-mips.org?
> 
> It is not vanilla kernel.  squashfs is not merged mainline yet.

Sorry, I should have said that they start with a vanilla kernel, rather
than starting with a kernel from linux-mips.org before adding in
squashfs-lzma etc.

> > Unhandled kernel unaligned access[#1]:
> > Cpu 0
> > $ 0   : 00000000 10008400 69725020 94001b90
> > $ 4   : 94003200 7265746e 00000002 00000000
> > $ 8   : 94016338 940162b0 94016228 940161a0
> > $12   : 94e5653c 943a0000 943a0000 94e5659c
> > $16   : 94001b80 00000000 94003200 00000002
> > $20   : 00000000 00000000 00000000 00000000
> > $24   : 00000000 9410b8a0
> > $28   : 943e4000 943e5ec0 00000000 94175e40
> > Hi    : 00000003
> > Lo    : 00000002
> > epc   : 941742bc drain_freelist+0x6c/0xf8     Not tainted
> > ra    : 94175e40 cache_reap+0xc0/0x124
> > Status: 10008402    KERNEL EXL
> > Cause : 10800010
> > BadVA : 7265746e
> > PrId  : 00018448
> ...
> > 0xffffffff941742bc <drain_freelist+108>:        lw      v1,0(a1)
> 
> The value of a1 (0x7265746e) is not a kernel address and I do not
> think drain_freelist use such an address.  So it would not be an
> "unaligned access" problem.  I support it would be some sort of memory
> corruption.

OK thanks.

-- 
Michael Wood <michael@frogfoot.com>
