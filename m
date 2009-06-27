Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 16:04:03 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51796 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492416AbZF0OD4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jun 2009 16:03:56 +0200
Received: from localhost (p8220-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.220])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 966FB91D9; Sat, 27 Jun 2009 22:59:32 +0900 (JST)
Date:	Sat, 27 Jun 2009 22:59:33 +0900 (JST)
Message-Id: <20090627.225933.208964286.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090626232432.GB3235@linux-mips.org>
References: <20090624063453.GA16846@volta.aurel32.net>
	<DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
	<20090626232432.GB3235@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 27 Jun 2009 00:24:32 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > At some point in the kernel history, Ralfie decided that
> > the flush_icache_page function is unnecessary and
> > turned it into a MIPS-wide noop. But the SB1 core, which has
> > a VIVT instruction cache, it appears that there
> > is some kind of issue whereby when it
> > is handling a fault for a not-present virtual page,
> > it somehow ends up with bad data in the instruction
> > cache---perhaps an inconsistent state due to not having
> > been able to complete the fetch, but having initiated
> > a cache update on the expectation that the fetch
> > will complete. It seems that the the fault handler
> > is expected to do a flush.
> > 
> > Anyway, see if you can work this patch (based on 2.6.26)
> > into your kernel, and report whether it makes any difference.
> 
> The functionality of flush_icache_page() is being handled update_mmu_cache.

A bit off-topic question.  The update_mmu_cache (or __update_cache)
itself does not flush icache.  When icache is invalidated (especially
VIPT case) ?

---
Atsushi Nemoto
