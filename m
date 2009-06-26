Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2009 23:23:44 +0200 (CEST)
Received: from hall.aurel32.net ([88.191.82.174]:42402 "EHLO hall.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491858AbZFZVXi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Jun 2009 23:23:38 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1MKIpU-0001Gm-RN; Fri, 26 Jun 2009 23:19:28 +0200
Date:	Fri, 26 Jun 2009 23:19:28 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Kaz Kylheku <KKylheku@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
Message-ID: <20090626211928.GM18476@hall.aurel32.net>
References: <20090624063453.GA16846@volta.aurel32.net> <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Wed, Jun 24, 2009 at 03:18:24PM -0700, Kaz Kylheku wrote:
> Aurelien Jarno wrote:
> > Hi all,
> > 
> > I am still trying to get a Broadcom Swarm boot on a recent kernel. I
> > have made some progress, but I am now stuck on another problem.
> > 
> > I am using a lmo 2.6.30 kernel, using the defconfig 
> 
> [ snip ]
> 
> > | Kernel panic - not syncing: Attempted to kill init!
> > | Rebooting in 5 seconds..Passing control back to CFE...
> 
> What kernel were you running prior to trying 30?

I am currently stuck with 2.6.18. I have tested a lot of kernels between
2.6.18 and 2.6.30, but they all have a different problem. Kernels 2.6.26
to 2.6.30 suffer from a similar problem, though from some versions it
hangs instead of panicking.

> When I migrated from 2.6.17 to 2.6.26, on a Broadcom
> 1480 based board, I discovered that there is some kind
> of instruction cache problem, which causes userland to
> fetch garbage instead of code from its mmap-ped executables.
> I could not get init to execute successfully.
> 
> Sorry, I can no longer remember whether this problem was
> SMP specific or not (like what you're experiencing);
> it might have been.
> 
> At some point in the kernel history, Ralfie decided that
> the flush_icache_page function is unnecessary and
> turned it into a MIPS-wide noop. But the SB1 core, which has
> a VIVT instruction cache, it appears that there
> is some kind of issue whereby when it
> is handling a fault for a not-present virtual page,
> it somehow ends up with bad data in the instruction
> cache---perhaps an inconsistent state due to not having
> been able to complete the fetch, but having initiated
> a cache update on the expectation that the fetch
> will complete. It seems that the the fault handler
> is expected to do a flush.
> 
> Anyway, see if you can work this patch (based on 2.6.26)
> into your kernel, and report whether it makes any difference.

I have applied the patch on 2.6.30 after a few changes, and it works!!!

Thanks a lot!

> Index: include/asm-mips/cacheflush.h
> ===================================================================
> --- include/asm-mips/cacheflush.h	(revision 2677)
> +++ include/asm-mips/cacheflush.h	(revision 2678)
> @@ -37,6 +37,7 @@
>  	unsigned long start, unsigned long end);
>  extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned
> long page, unsigned long pfn);
>  extern void __flush_dcache_page(struct page *page);
> +extern void __flush_icache_page(struct vm_area_struct *vma, struct page
> *page);
>  
>  static inline void flush_dcache_page(struct page *page)
>  {
> @@ -57,11 +58,6 @@
>  		__flush_anon_page(page, vmaddr);
>  }
>  
> -static inline void flush_icache_page(struct vm_area_struct *vma,
> -	struct page *page)
> -{
> -}
> -
>  extern void (*flush_icache_range)(unsigned long start, unsigned long
> end);
>  
>  extern void (*__flush_cache_vmap)(void);
> @@ -93,6 +89,13 @@
>  extern void (*local_flush_data_cache_page)(void * addr);
>  extern void (*flush_data_cache_page)(unsigned long addr);
>  
> +static inline void flush_icache_page(struct vm_area_struct *vma,
> +	struct page *page)
> +{
> +        __flush_icache_page(vma, page);
> +}
> +
> +
>  /*
>   * This flag is used to indicate that the page pointed to by a pte
>   * is dirty and requires cleaning before returning it to the user.
> Index: arch/mips/mm/cache.c
> ===================================================================
> --- arch/mips/mm/cache.c	(revision 2677)
> +++ arch/mips/mm/cache.c	(revision 2678)
> @@ -93,6 +93,14 @@
>  
>  EXPORT_SYMBOL(__flush_dcache_page);
>  
> +void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
> +{
> +	if (vma->vm_flags & VM_EXEC)
> +		flush_icache_range((unsigned long) page_address(page),
> PAGE_SIZE); 
> +}
> +
> +EXPORT_SYMBOL(__flush_icache_page);
> +
>  void __flush_anon_page(struct page *page, unsigned long vmaddr)
>  {
>  	unsigned long addr = (unsigned long) page_address(page);
> 
> 

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
