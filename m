Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 07:38:34 +0200 (CEST)
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48557 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbeGEFiWDFJ3K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 07:38:22 +0200
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EA0AA1BF208;
        Thu,  5 Jul 2018 05:37:54 +0000 (UTC)
Subject: Re: [PATCH v2 06/11] hugetlb: Introduce generic version of
 huge_pte_none
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
References: <20180705050323.301-1-alex@ghiti.fr>
 <20180705051242.694-1-alex@ghiti.fr> <20180705051242.694-6-alex@ghiti.fr>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <92f84f1e-652c-6442-fafa-acfa63607601@ghiti.fr>
Date:   Thu, 5 Jul 2018 05:37:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180705051242.694-6-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64648
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

Please drop this serie, sorry for the noise.


On 07/05/2018 05:12 AM, Alexandre Ghiti wrote:
> arm, arm64, ia64, parisc, powerpc, sh, sparc, x86 architectures
> use the same version of huge_pte_none, so move this generic
> implementation into asm-generic/hugetlb.h.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/arm/include/asm/hugetlb.h     | 5 -----
>   arch/arm64/include/asm/hugetlb.h   | 5 -----
>   arch/ia64/include/asm/hugetlb.h    | 5 -----
>   arch/mips/include/asm/hugetlb.h    | 1 +
>   arch/parisc/include/asm/hugetlb.h  | 5 -----
>   arch/powerpc/include/asm/hugetlb.h | 5 -----
>   arch/sh/include/asm/hugetlb.h      | 5 -----
>   arch/sparc/include/asm/hugetlb.h   | 5 -----
>   arch/x86/include/asm/hugetlb.h     | 5 -----
>   include/asm-generic/hugetlb.h      | 7 +++++++
>   10 files changed, 8 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 047b893ef95d..3d2ce4dbc145 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -43,11 +43,6 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 4c8dd488554d..49247c6f94db 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -42,11 +42,6 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index 41b5f6adeee4..bf573500b3c4 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -26,11 +26,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 7df1f116a3cc..1c9c4531376c 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -55,6 +55,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   	flush_tlb_page(vma, addr & huge_page_mask(hstate_vma(vma)));
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTE_NONE
>   static inline int huge_pte_none(pte_t pte)
>   {
>   	unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 9afff26747a1..c09d8c74553c 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -38,11 +38,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index de0769f0b5b2..530b817e097c 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -152,11 +152,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   	flush_hugetlb_page(vma, addr);
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index 9abf9c86b769..a9f8266f33cf 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -31,11 +31,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 651a9593fcee..11115bbd712e 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -48,11 +48,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 8347d5abf882..c5fdc53b6e41 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -27,11 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index ffa63fd8388d..2fc3d68424e9 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -73,4 +73,11 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   }
>   #endif
>   
> +#ifndef __HAVE_ARCH_HUGE_PTE_NONE
> +static inline int huge_pte_none(pte_t pte)
> +{
> +	return pte_none(pte);
> +}
> +#endif
> +
>   #endif /* _ASM_GENERIC_HUGETLB_H */
