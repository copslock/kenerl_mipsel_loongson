Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 18:13:36 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51369 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492678AbZF0QNa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jun 2009 18:13:30 +0200
Received: from localhost (p8220-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.220])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 791268730; Sun, 28 Jun 2009 01:09:05 +0900 (JST)
Date:	Sun, 28 Jun 2009 01:09:06 +0900 (JST)
Message-Id: <20090628.010906.115909054.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090627154811.GA22264@linux-mips.org>
References: <20090626232432.GB3235@linux-mips.org>
	<20090627.225933.208964286.anemo@mba.ocn.ne.jp>
	<20090627154811.GA22264@linux-mips.org>
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
X-archive-position: 23519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 27 Jun 2009 16:48:11 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Jun 27, 2009 at 10:59:33PM +0900, Atsushi Nemoto wrote:
> 
> > A bit off-topic question.  The update_mmu_cache (or __update_cache)
> > itself does not flush icache.  When icache is invalidated (especially
> > VIPT case) ?
> 
> Not off-topic at all in this thread.
> 
> The I-cache for page just being loaded is clean so no flushing needed.  It
> is clean because when the page has been unmapped it was flushed or because
> the CPU switched to a fresh ASID.

Then, flush_cache_range or flush_cache_page should be called then the
page was unmmapped, right?  How about flush_cache_mm?  It does not
flush icache currently.

And how about kernel __init code pages?  These pages are just freed on
free_initmem.  Also how about code pages used by a module which is to
be unloaded from kernel?

> The reason for this bug is that when data is being shoveled around by the
> processor (as opposed to DMA) as on PIO block devices it'll end up sitting
> in the D-cache so I-cache refills will grab stale data from S-cache or
> memory.

Yes, I suppose so on this swarm case, but I'm just thinking of other
case breaking icache coherency...

---
Atsushi Nemoto
