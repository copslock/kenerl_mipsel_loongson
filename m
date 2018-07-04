Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 08:52:35 +0200 (CEST)
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37211 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990946AbeGDGwWop51f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jul 2018 08:52:22 +0200
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (LNeuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B750040005;
        Wed,  4 Jul 2018 06:52:08 +0000 (UTC)
Subject: Re: [PATCH 05/11] hugetlb: Introduce generic version of
 huge_ptep_clear_flush
To:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20180704055207.27978-1-alex@ghiti.fr>
 <20180704055207.27978-6-alex@ghiti.fr>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <6f468be6-6d6b-407a-eb3d-8d1fa7d3673e@ghiti.fr>
Date:   Wed, 4 Jul 2018 08:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180704055207.27978-6-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@ghiti.fr
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

Just discovered my email provider limit of mails per minute, please drop 
this serie, I'll send a v2 using --batch-size option of git send-email. 
Sorry about that.


On 07/04/2018 07:52 AM, Alexandre Ghiti wrote:
> arm, x86 architectures use the same version of
> huge_ptep_clear_flush, so move this generic implementation into
> asm-generic/hugetlb.h.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/arm/include/asm/hugetlb-3level.h | 6 ------
>   arch/arm64/include/asm/hugetlb.h      | 1 +
>   arch/ia64/include/asm/hugetlb.h       | 1 +
>   arch/mips/include/asm/hugetlb.h       | 1 +
>   arch/parisc/include/asm/hugetlb.h     | 1 +
>   arch/powerpc/include/asm/hugetlb.h    | 1 +
>   arch/sh/include/asm/hugetlb.h         | 1 +
>   arch/sparc/include/asm/hugetlb.h      | 1 +
>   arch/x86/include/asm/hugetlb.h        | 6 ------
>   include/asm-generic/hugetlb.h         | 8 ++++++++
>   10 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
> index ad36e84b819a..b897541520ef 100644
> --- a/arch/arm/include/asm/hugetlb-3level.h
> +++ b/arch/arm/include/asm/hugetlb-3level.h
> @@ -37,12 +37,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>   	return retval;
>   }
>   
> -static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> -					 unsigned long addr, pte_t *ptep)
> -{
> -	ptep_clear_flush(vma, addr, ptep);
> -}
> -
>   static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>   					   unsigned long addr, pte_t *ptep)
>   {
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 6ae0bcafe162..4c8dd488554d 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -71,6 +71,7 @@ extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>   				     unsigned long addr, pte_t *ptep);
>   extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
>   				    unsigned long addr, pte_t *ptep);
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>   extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   				  unsigned long addr, pte_t *ptep);
>   #define __HAVE_ARCH_HUGE_PTE_CLEAR
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index 6719c74da0de..41b5f6adeee4 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -20,6 +20,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>   		REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE);
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>   static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep)
>   {
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 0959cc5a41fa..7df1f116a3cc 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -48,6 +48,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>   	return pte;
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>   static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep)
>   {
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 6e281e1bb336..9afff26747a1 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -32,6 +32,7 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>   static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep)
>   {
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index ec3e0c2e78f8..de0769f0b5b2 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -143,6 +143,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>   #endif
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>   static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep)
>   {
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index 08ee6c00b5e9..9abf9c86b769 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -25,6 +25,7 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>   static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep)
>   {
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 944e3a4bfaff..651a9593fcee 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -42,6 +42,7 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>   static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep)
>   {
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 48b8d9b13cc6..8347d5abf882 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -27,12 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> -					 unsigned long addr, pte_t *ptep)
> -{
> -	ptep_clear_flush(vma, addr, ptep);
> -}
> -
>   static inline int huge_pte_none(pte_t pte)
>   {
>   	return pte_none(pte);
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 0f6f151780dd..ffa63fd8388d 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -65,4 +65,12 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>   }
>   #endif
>   
> +#ifndef __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
> +static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep)
> +{
> +	ptep_clear_flush(vma, addr, ptep);
> +}
> +#endif
> +
>   #endif /* _ASM_GENERIC_HUGETLB_H */
