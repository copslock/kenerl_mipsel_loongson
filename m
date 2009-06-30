Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 16:06:02 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:63087 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492993AbZF3OFz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jun 2009 16:05:55 +0200
Received: from localhost (p7065-ipad202funabasi.chiba.ocn.ne.jp [222.146.78.65])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DF7FDAFCA; Tue, 30 Jun 2009 23:00:38 +0900 (JST)
Date:	Tue, 30 Jun 2009 23:00:40 +0900 (JST)
Message-Id: <20090630.230040.173375181.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090629190809.GC22264@linux-mips.org>
References: <20090627154811.GA22264@linux-mips.org>
	<20090628.010906.115909054.anemo@mba.ocn.ne.jp>
	<20090629190809.GC22264@linux-mips.org>
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
X-archive-position: 23542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 29 Jun 2009 20:08:10 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Then, flush_cache_range or flush_cache_page should be called then the
> > page was unmmapped, right?  How about flush_cache_mm?  It does not
> > flush icache currently.
> 
> If that is being called then we're either about to terminate a process or
> to exec a new process.  In either case flush_tlb_cache (on VIVT I-cache)
> will drop the tlb context which effectively is a full I-cache flush.

Thanks, I see.  Then, how about VIPT I-cache case?

> > And how about kernel __init code pages?  These pages are just freed on
> > free_initmem.  Also how about code pages used by a module which is to
> > be unloaded from kernel?
> 
> Init code pages won't be used to store code that will be executed at
> KSEG0 or XKPHYS addresses so I-cache coherency is not of interest.
> 
> For modules the I-cache is being flushed on loading of the module, see
> calls to flush_icache_range() in kernel/module.c so I-cache coherency is
> not of concern on module unload.

Same here.  A physical page used to __init code might be reused for
user code page, so explicit flush (invalide) is required for VIPT
case, no?

---
Atsushi Nemoto
