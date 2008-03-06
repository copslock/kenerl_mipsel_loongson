Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 15:44:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44986 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28603659AbYCFPoR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Mar 2008 15:44:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m26FiEAq016037;
	Thu, 6 Mar 2008 15:44:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m26FiD34016036;
	Thu, 6 Mar 2008 15:44:13 GMT
Date:	Thu, 6 Mar 2008 15:44:13 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Does HIGHMEM work on 32-bit MIPS ports?
Message-ID: <20080306154413.GA4537@linux-mips.org>
References: <47CF24F4.4010508@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47CF24F4.4010508@cisco.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 05, 2008 at 02:55:48PM -0800, David VomLehn wrote:

> We've made significant progress in getting HIGHMEM to work on our 24K 
> processor, but things do not completely work yet. Since I don't yet have 
> confidence that we know everything that's going on, I"m not ready to submit 
> a full-blown patch, but here's what we've done so far. Please send 
> comments/suggestions...

Even a work in progress patch would be useful.

> The function __flush_dcache_page (in arch/mips/mm/cache.c) was simply 
> returning if the struct page* argument it was given indicated we had a page 
> in high memory, so the dcache was never being flushed. This is an obvious 
> Bad Thing.

Sort of.  It could be argued that the flushing of highmem pages should
be done on kunmap but I haven't researched that into depth.

> Our first modification was to expand the check for high memory. If the page 
> had a temporary mapping, i.e. it was mapped through kmap_atomic(), we call 
> flush_data_cache_page(). We then immediately return:
>
>    if (PageHighMem(page)) {
>        addr = (unsigned long)kmap_atomic_to_vaddr(page);
>        if (addr != 0) {
>            flush_data_cache_page(addr);
>        }
>        return;
>    }
>
> (kmap_atomic_to_vaddr() returns the virtual address if the page is mapped 
> with kmap_atomic(), otherwise it returns NULL). This change by itself is 
> enough to be able to boot with NFS most of the time. I think it is not 
> sufficient for permanently mapped kernel pages (those mapped with 
> kmap_high()). So, I made two other modifications.
>
> Additional Modification #1: To me, it looks like the return should be moved 
> to right after the call to flush_data_cache_page() so that we only return 
> immediately for temporary kernel mappings.
>
> The next section of code, which I think already works correctly with high 
> memory, is:
>
>    if (mapping && !mapping_mapped(mapping)) {
>        SetPageDcacheDirty(page);
>        return;
>    }
>
> We then have the following:
>
>    addr = (unsigned long) page_address(page);
>    flush_data_cache_page(addr);
>
> Additional Modification #2: If the page is in high memory, it may not have 
> a kernel mapping, in which case page_address() will return NULL. So, I've 
> modified the code to only call flush_data_cache_page() if the 
> page_address() doesn't return NULL.

This assumes that kunmap and kunmap_atomic flush the cache.

> With the two additional modifications above, thing are still not completely 
> reliable. So, two questions:
>
>   1. Does what we've done so far make sense?
>   2. Since the behavior is still somewhat flaky, I'm still missing
>      something. Any suggestions?

copy_user_highpage, copy_to_user_page and copy_from_user_page could use
some review for correctness for the highmem case.

  Ralf
