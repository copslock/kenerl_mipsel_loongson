Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 13:38:20 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:56805 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038207AbWJLMiS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2006 13:38:18 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 1C4BE44A92; Thu, 12 Oct 2006 14:38:17 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GXzot-0001m4-60; Thu, 12 Oct 2006 13:37:51 +0100
Date:	Thu, 12 Oct 2006 13:37:51 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
Message-ID: <20061012123751.GA4044@networkno.de>
References: <452CFC95.1080806@innova-card.com> <20061012.003007.08076055.anemo@mba.ocn.ne.jp> <452D1567.1050706@innova-card.com> <20061012.190559.96685979.nemoto@toshiba-tops.co.jp> <452E2BB2.2090601@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452E2BB2.2090601@innova-card.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Atsushi Nemoto wrote:
> > On Wed, 11 Oct 2006 18:01:43 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >>> __pa() is used in many place indirectly via virt_to_page().
> >> what about make virt_to_page() use virt_to_phys() instead ?
> > 
> > No objection for virt_to_phys(), but I found other __pa() usages in
> > kernel.
> > 
> > drivers/char/mem.c:       && addr >= __pa(high_memory);
> > drivers/char/mem.c:     return addr >= __pa(high_memory);
> > drivers/char/mem.c:     if (addr + count > __pa(high_memory))
> > drivers/char/mem.c:     pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
> > 
> > So __pa() should handle >512MB address unless we change all __pa() usages.
> 
> weird, I really thought that __pa() shouldn't be used by drivers...
> Let see what people on lkml think about this usage, you'll be CC'ed
> if you want to.

I guess /dev/mem is allowed to as an exception.


Thiemo
