Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 17:44:42 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:61656 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225239AbVBDRoZ>; Fri, 4 Feb 2005 17:44:25 +0000
Received: from gw.junsun.net (c-24-6-106-170.client.comcast.net[24.6.106.170])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20050204174413015009kfmie>; Fri, 4 Feb 2005 17:44:13 +0000
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id j14HiBb9000914;
	Fri, 4 Feb 2005 09:44:11 -0800
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id j14HiAuZ000913;
	Fri, 4 Feb 2005 09:44:10 -0800
Date:	Fri, 4 Feb 2005 09:44:10 -0800
From:	Jun Sun <jsun@junsun.net>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: dcache aliasing problem on fork
Message-ID: <20050204174410.GC30430@gw.junsun.net>
References: <20050204.183813.132760959.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204.183813.132760959.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Fri, Feb 04, 2005 at 06:38:13PM +0900, Atsushi Nemoto wrote:
> There is a dcache aliasing problem on preempt kernel (or SMP kernel,
> perhaps) when a multi-threaded program calls fork().
> 
> 1. Now there is a process containing two thread (T1 and T2).  The
>    thread T1 call fork().  dup_mmap() function called on T1 context.
> 
> static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
> {
> 	...
> 	flush_cache_mm(current->mm);
> 	/* A */
> 	...
> 	(write-protect all Copy-On-Write pages)
> 	...
> 	/* B */
> 	flush_tlb_mm(current->mm);
> 	...
> }
> 
> 2. When preemption happens between A and B (or on SMP kernel), the
>    thread T2 can run and modify data on COW pages without page fault
>    (modified data will stay in cache).
> 
> 3. Some time after fork() completed, the thread T2 may cause page
>    fault by write-protect on COW pages .
> 
> 4. Then data of the COW page will be copied to newly allocated
>    physical page (copy_cow_page()).  It reads data via kernel mapping.
>    The kernel mapping can have different 'color' with user space
>    mapping of the thread T2 (dcache aliasing).  Therefore
>    copy_cow_page() will copy stale data.  Then the modified data in
>    cache will be lost.
> 
> 
> How should we fix this problem?  Any idea?
> 

It seems to me a naive solution is to introduce a spinlock to make all
three operation automic.  you flush tlb first and make relavent tlb fault
handling sync with this spinlock as well.

At in theory it should fix the problem, but the spinlock might be held
for too long this dup_mmap().

BTW, is this problem real or hypothetic?

Jun
