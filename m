Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 16:03:17 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:61090 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492890AbZGFODK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Jul 2009 16:03:10 +0200
Received: from localhost (p3132-ipad308funabasi.chiba.ocn.ne.jp [123.217.189.132])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 76BB3B30E; Mon,  6 Jul 2009 22:56:09 +0900 (JST)
Date:	Mon, 06 Jul 2009 22:56:10 +0900 (JST)
Message-Id: <20090706.225610.260797799.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090630.230040.173375181.anemo@mba.ocn.ne.jp>
References: <20090628.010906.115909054.anemo@mba.ocn.ne.jp>
	<20090629190809.GC22264@linux-mips.org>
	<20090630.230040.173375181.anemo@mba.ocn.ne.jp>
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
X-archive-position: 23662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 30 Jun 2009 23:00:40 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > > And how about kernel __init code pages?  These pages are just freed on
> > > free_initmem.  Also how about code pages used by a module which is to
> > > be unloaded from kernel?
> > 
> > Init code pages won't be used to store code that will be executed at
> > KSEG0 or XKPHYS addresses so I-cache coherency is not of interest.
> > 
> > For modules the I-cache is being flushed on loading of the module, see
> > calls to flush_icache_range() in kernel/module.c so I-cache coherency is
> > not of concern on module unload.
> 
> Same here.  A physical page used to __init code might be reused for
> user code page, so explicit flush (invalide) is required for VIPT
> case, no?

I tracked some icache flushes after free_initmem() on a VIPT CPU.

* free_initmem()
* r4k_flush_cache_range(start=0x7fff7000, end=0x7fff8000)
	backtraces:
	#0  0x801263c0 in r4k_flush_cache_range ()
	#1  0x801bc640 in move_page_tables ()
	#2  0x801d317c in setup_arg_pages ()
	#3  0x80210af8 in load_elf_binary ()
	#4  0x801d2200 in search_binary_handler ()
	#5  0x801d3640 in do_execve ()
	#6  0x80119d58 in sys_execve ()
	#7  0x801022d0 in handle_sys ()
	#8  0x80111018 in init_post ()
* r4k_flush_cache_range(start=0x2aac9000, end=0x2aada000)
	backtraces:
	#0  0x801263c0 in r4k_flush_cache_range ()
	#1  0x801b4abc in unmap_vmas ()
	#2  0x801b9798 in unmap_region ()
	#3  0x801bac44 in do_munmap ()
	#4  0x80210538 in elf_map ()
	#5  0x80211054 in load_elf_binary ()
	#6  0x801d2200 in search_binary_handler ()
	#7  0x801d3640 in do_execve ()
	#8  0x80119d58 in sys_execve ()
	#9  0x801022d0 in handle_sys ()
	#10 0x80111018 in init_post ()
* some page faults from outside [0x2aac9000, 0x2aada000] range
* r4k_flush_cache_range(start=0x2ab19000, end=0x2ab29000)
	backtraces:
	#0  0x801263c0 in r4k_flush_cache_range ()
	#1  0x801bc178 in mprotect_fixup ()
	#2  0x801bc560 in sys_mprotect ()
	#3  0x801022d0 in handle_sys ()

The first icache flush is for stack (arg pages).  The second one is
for unmap holes in ELF image (I do not understand details...).  Anyway
both flushes did not intend to flush text pages for the first
userspace program.

Since current implementation of r4k_flush_cache_range flushes all
icache regardless of its range arguments, all icaches used for __init
pages are flushed effectively, but it seems just a sort of luck for
me.

Also flusing icache in flush_cache_range is relatively young code ---
the commit 2eaa7e ("Handle I-cache coherency in flush_cache_range()")
on Feb 2008.  I'm wondering how icache were flushed before that
commit...

---
Atsushi Nemoto
