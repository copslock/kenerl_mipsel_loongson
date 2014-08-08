Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 18:55:20 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33663 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856018AbaHHQzQ1UVFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2014 18:55:16 +0200
Received: by mail-ig0-f177.google.com with SMTP id hn18so1326297igb.10
        for <multiple recipients>; Fri, 08 Aug 2014 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=k1GwElRBJeqq+uccZwRtUHWi5JfgRUVVRseizkdfumQ=;
        b=J9KMkjCOA/SqDu6mPRv33vifzE7r5bxeyEu4sB+YZlFRk4n9+rtjQabKYBKl7kFBAZ
         riQqBKeYiIDiYPoHBPXfeuihos/RXD2T5KEkhlRNgOaSQ6X/EAhav7L1b51bwZBKv55p
         KDqsbqirNLeebdJkukzo+ldysaPxZn6lxg3Da/Avm/hJgfLmJC3WoSelJSfGpjHiLi98
         KMtt2g9i7zGmQyEpIzK6WoH9VYePdADWBL7XckaFJ5MrCIvqJFHZlyvvC6ajNGe047wL
         z5xma8P0h0DdRih1gdWj3S3OZXC4Xa1aGxcNFYiHo3PvL5qJvNrgEUQ7w3jyD8GaryC3
         Nknw==
X-Received: by 10.42.62.6 with SMTP id w6mr13733364ich.24.1407516907727;
        Fri, 08 Aug 2014 09:55:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id w10sm10965685igr.18.2014.08.08.09.55.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 Aug 2014 09:55:07 -0700 (PDT)
Message-ID: <53E500E4.5020509@gmail.com>
Date:   Fri, 08 Aug 2014 09:55:00 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Lars Persson <lars.persson@axis.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Lars Persson <larper@axis.com>
Subject: Re: [PATCH v2] MIPS: Remove race window in page fault handling
References: <1407505668-18547-1-git-send-email-larper@axis.com>
In-Reply-To: <1407505668-18547-1-git-send-email-larper@axis.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41910
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

On 08/08/2014 06:47 AM, Lars Persson wrote:
> Multicore MIPSes without I/D hardware coherency suffered from a race
> condition in the page fault handler. The page table entry was
> published before any pending lazy D-cache flush was committed, hence
> it allowed execution of stale page cache data by other VPEs in the
> system.
>
> To make the cache handling safe we need to perform flushing already in
> the set_pte_at function. MIPSes without coherent I-caches can get a
> small increase in flushes due to the unavailability of the execute
> flag in set_pte_at.
>
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>   arch/mips/include/asm/pgtable.h |   22 +++++++++++++++++-----
>   arch/mips/mm/cache.c            |   16 ++++++++--------
>   2 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 027c74d..1834298 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -122,6 +122,9 @@ do {									\
>   	}								\
>   } while(0)
>
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +	pte_t *ptep, pte_t pteval);
> +

Is it possible to reorder the code such that this declaration is not 
necessary?


>   #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
>
>   #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
> @@ -145,7 +148,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>   		}
>   	}
>   }
> -#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
>
>   static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> @@ -183,7 +185,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>   	}
>   #endif
>   }
> -#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
>
>   static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> @@ -198,6 +199,20 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
>   }
>   #endif
>
> +extern void mips_flush_dcache_from_pte(pte_t pteval, unsigned long address);
> +
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +	pte_t *ptep, pte_t pteval)
> +{
> +	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
> +		if (pte_present(pteval))
> +			mips_flush_dcache_from_pte(pteval, addr);
> +	}
> +
> +	set_pte(ptep, pteval);
> +}
> +
> +
>
[...]
