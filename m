Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 16:01:25 +0000 (GMT)
Received: from p508B7B47.dip.t-dialin.net ([IPv6:::ffff:80.139.123.71]:50728
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225269AbUCPQBS>; Tue, 16 Mar 2004 16:01:18 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2GG1FMk020561;
	Tue, 16 Mar 2004 17:01:15 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2GG1ECT020560;
	Tue, 16 Mar 2004 17:01:14 +0100
Date: Tue, 16 Mar 2004 17:01:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: sjhill@realitydiluted.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] [RFC] r4k_dma_cache_wback_inv function fails when size=0...
Message-ID: <20040316160114.GA19837@linux-mips.org>
References: <4055E320.8080808@realitydiluted.com> <20040316.230928.74756852.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316.230928.74756852.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 16, 2004 at 11:09:28PM +0900, Atsushi Nemoto wrote:

> sjhill> The 'r4k_dma_cache_wback_inv' function will fail when the
> sjhill> requested size equals 0 AND when the address is a multiple of
> sjhill> the line size. I discovered this bug while using the National
> sjhill> Semiconductor DP8381x series PCI ethernet driver. I have
> sjhill> attached a test program showing the bug as well as a patch for
> sjhill> comment. Okay to apply?
> 
> I think your patch is overkill.  It flushes many one line then needed.

So far I was simply considering any use with size 0 a bug.  In this case
a 0 argument was passed to pci_unmap_XXX, so I'll have to figure out with
the other architecture maintainers if that's just odd usage of the API
or an outright bug.

  Ralf
