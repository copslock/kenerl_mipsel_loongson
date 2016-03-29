Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 10:39:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45538 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006779AbcC2Ij4ErEVk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Mar 2016 10:39:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2T8dt5h013129;
        Tue, 29 Mar 2016 10:39:55 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2T8dssr013128;
        Tue, 29 Mar 2016 10:39:54 +0200
Date:   Tue, 29 Mar 2016 10:39:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Lars Persson <lars.persson@axis.com>,
        "stable # v4 . 1+" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/4] MIPS: Handle highmem pages in __update_cache
Message-ID: <20160329083953.GE11282@linux-mips.org>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
 <1456799879-14711-4-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456799879-14711-4-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52725
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

On Tue, Mar 01, 2016 at 02:37:58AM +0000, Paul Burton wrote:

> The following patch will expose __update_cache to highmem pages. Handle
> them by mapping them in for the duration of the cache maintenance, just
> like in __flush_dcache_page. The code for that isn't shared because we
> need the page address in __update_cache so sharing became messy. Given
> that the entirity is an extra 5 lines, just duplicate it.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars Persson <lars.persson@axis.com>
> Cc: stable <stable@vger.kernel.org> # v4.1+
> ---
> 
>  arch/mips/mm/cache.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 5a67d8c..8befa55 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -149,9 +149,17 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
>  		return;
>  	page = pfn_to_page(pfn);
>  	if (page_mapping(page) && Page_dcache_dirty(page)) {
> -		addr = (unsigned long) page_address(page);
> +		if (PageHighMem(page))
> +			addr = (unsigned long)kmap_atomic(page);
> +		else
> +			addr = (unsigned long)page_address(page);
> +
>  		if (exec || pages_do_alias(addr, address & PAGE_MASK))
>  			flush_data_cache_page(addr);
> +
> +		if (PageHighMem(page))
> +			__kunmap_atomic((void *)addr);
> +
>  		ClearPageDcacheDirty(page);
>  	}
>  }

Yet again this is betting the house on getting the right virtual address
from kmap_atomic.

  Ralf
