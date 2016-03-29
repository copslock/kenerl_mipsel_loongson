Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 10:35:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44368 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006779AbcC2Ifpmdhbk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Mar 2016 10:35:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2T8ZiRR013043;
        Tue, 29 Mar 2016 10:35:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2T8ZhR4013042;
        Tue, 29 Mar 2016 10:35:43 +0200
Date:   Tue, 29 Mar 2016 10:35:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Lars Persson <lars.persson@axis.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/4] MIPS: Flush highmem pages in __flush_dcache_page
Message-ID: <20160329083543.GD11282@linux-mips.org>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
 <1456799879-14711-3-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456799879-14711-3-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Mar 01, 2016 at 02:37:57AM +0000, Paul Burton wrote:

> When flush_dcache_page is called on an executable page, that page is
> about to be provided to userland & we can presume that the icache
> contains no valid entries for its address range. However if the icache
> does not fill from the dcache then we cannot presume that the pages
> content has been written back as far as the memories that the dcache
> will fill from (ie. L2 or further out).
> 
> This was being done for lowmem pages, but not for highmem which can lead
> to icache corruption. Fix this by mapping highmem pages & flushing their
> content from the dcache in __flush_dcache_page before providing the page
> to userland, just as is done for lowmem pages.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars Persson <lars.persson@axis.com>
> ---
> 
>  arch/mips/mm/cache.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 3f159ca..5a67d8c 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -16,6 +16,7 @@
>  #include <linux/mm.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/highmem.h>
>  #include <asm/processor.h>
>  #include <asm/cpu.h>
>  #include <asm/cpu-features.h>
> @@ -83,8 +84,6 @@ void __flush_dcache_page(struct page *page)
>  	struct address_space *mapping = page_mapping(page);
>  	unsigned long addr;
>  
> -	if (PageHighMem(page))
> -		return;
>  	if (mapping && !mapping_mapped(mapping)) {
>  		SetPageDcacheDirty(page);
>  		return;
> @@ -95,8 +94,15 @@ void __flush_dcache_page(struct page *page)
>  	 * case is for exec env/arg pages and those are %99 certainly going to
>  	 * get faulted into the tlb (and thus flushed) anyways.
>  	 */
> -	addr = (unsigned long) page_address(page);
> +	if (PageHighMem(page))
> +		addr = (unsigned long)kmap_atomic(page);
> +	else
> +		addr = (unsigned long)page_address(page);
> +
>  	flush_data_cache_page(addr);
> +
> +	if (PageHighMem(page))
> +		__kunmap_atomic((void *)addr);
>  }
>  
>  EXPORT_SYMBOL(__flush_dcache_page);

I don't see how this should work with cache aliases.  If the page is unmapped
kmap_atomic will pick a deterministic address only under some circumstances,
kmap won't.  As the result the wrong cache way will be flushed out, I think.

  Ralf
