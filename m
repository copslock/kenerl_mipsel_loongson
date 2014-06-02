Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2014 18:47:46 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55721 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816759AbaFBQrmV5bdd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Jun 2014 18:47:42 +0200
Received: by mail-ie0-f177.google.com with SMTP id y20so4684354ier.22
        for <linux-mips@linux-mips.org>; Mon, 02 Jun 2014 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mKHDINbTlCLOy5w57Kl6mUzU4gVmNkTrb7d85+/1J3A=;
        b=Ac67nGFCqyMUQgNhEb2mXOvC81ldNFTfWxWBqWpOpG4hsmZHywdUiwP0K85FS2fkCY
         Do3/C/wGLk0TJdBEPA4vRo8POtlkv8NYkPundJg7gRJy5Noos1klnaQnUxy3wvRgjxtY
         Ylc9DCQOJhXhTOKNW05crBzS9iirjfjCxDBRFE9OfZxh2tpqi1OhwNrpOJT7aT/XkKBe
         WqODMO9TcOs9Y4DiB6JK4ihXIdWQLoJ+DfobMwDFPG1eYtC5JDR4sNoC8h7//Rv4Ca1w
         WIAYV41cTke0UJgRT8Fp9K6gn25WliHD2uFFwczJRB6F39gjBhvOmnEEXHv9fRNXJArk
         Bz9w==
X-Received: by 10.42.98.145 with SMTP id s17mr3835037icn.73.1401727656338;
        Mon, 02 Jun 2014 09:47:36 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id h5sm29993483igi.4.2014.06.02.09.47.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 09:47:35 -0700 (PDT)
Message-ID: <538CAAA6.90509@gmail.com>
Date:   Mon, 02 Jun 2014 09:47:34 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Lars Persson <lars.persson@axis.com>
CC:     linux-mips@linux-mips.org, Lars Persson <larper@axis.com>
Subject: Re: [PATCH] MIPS: Remove race window in page fault handling
References: <1401532566-22929-1-git-send-email-larper@axis.com>
In-Reply-To: <1401532566-22929-1-git-send-email-larper@axis.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/31/2014 03:36 AM, Lars Persson wrote:
> Multicore MIPSes without I/D hardware coherency suffered from a race
> condition in the page fault handler. The page table entry was published
> before any pending lazy D-cache flush was committed, hence it allowed
> execution of stale page cache data by other VPEs in the system.
>

Shouldn't this only be done on machines that suffer from the problem?

There are many SMP MIPS machines that don't need this, so they shouldn't 
have to pay the price for doing this.

David Daney



> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>   arch/mips/include/asm/pgtable.h |   17 +++++++++++++++--
>   arch/mips/mm/cache.c            |   10 ++++++++++
>   2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 008324d..7b175e5 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -95,6 +95,9 @@ extern void paging_init(void);
>
>   #define pmd_page_vaddr(pmd)	pmd_val(pmd)
>
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +	pte_t *ptep, pte_t pteval);
> +
>   #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
>
>   #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
> @@ -118,7 +121,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>   		}
>   	}
>   }
> -#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
>
>   static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> @@ -155,7 +157,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>   	}
>   #endif
>   }
> -#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
>
>   static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> @@ -169,6 +170,18 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
>   }
>   #endif
>
> +extern void mips_flush_dcache_from_pte(pte_t pteval);
> +
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +	pte_t *ptep, pte_t pteval)
> +{
> +	/* Make code globally visible before publishing the page
> +	   table entry. */
> +	if (addr < TASK_SIZE && pte_present(pteval))
> +		mips_flush_dcache_from_pte(pteval);
> +	set_pte(ptep, pteval);
> +}
> +
>   /*
>    * (pmds are folded into puds so this doesn't get actually called,
>    * but the define is needed for a generic inline function.)
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 9e67cde..1320afc 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -137,6 +137,16 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
>   	}
>   }
>
> +void mips_flush_dcache_from_pte(pte_t pteval)
> +{
> +	unsigned long pfn = pte_pfn(pteval);
> +	if (likely(pfn_valid(pfn))) {
> +		struct page *page = pfn_to_page(pfn);
> +		if (Page_dcache_dirty(page))
> +			flush_dcache_page(page);
> +	}
> +}
> +
>   unsigned long _page_cachable_default;
>   EXPORT_SYMBOL(_page_cachable_default);
>
>
