Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 18:49:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17963 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab1EQQtv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2011 18:49:51 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dd2a7680000>; Tue, 17 May 2011 09:50:48 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 17 May 2011 09:49:46 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 17 May 2011 09:49:46 -0700
Message-ID: <4DD2A729.9090502@caviumnetworks.com>
Date:   Tue, 17 May 2011 09:49:45 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jian Peng <jipeng@broadcom.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: patch to support topdown mmap allocation in MIPS
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com> <4DD1BD72.2000408@caviumnetworks.com> <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2011 16:49:46.0015 (UTC) FILETIME=[6D76FAF0:01CC14B2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/16/2011 06:06 PM, Jian Peng wrote:
> Thank you for reviewing. Here is new one with all fixings you want.
>
>> From 8dee85a8da61f74568ab9e0eadc8d7602a3f6fc6 Mon Sep 17 00:00:00 2001
> From: Jian Peng<jipeng2005@gmail.com>
> Date: Mon, 16 May 2011 18:00:33 -0700
> Subject: [PATCH 1/1] MIPS: topdown mmap support
>
> This patch introduced topdown mmap support in user process address
> space allocation policy.
>
> Recently, we ran some large applications that use mmap heavily and
> lead to OOM due to inflexible mmap allocation policy on MIPS32.
>
> Since most other major archs supported it for years, it is reasonable
> to follow the trend and reduce the pain of porting applications.
>
> Due to cache aliasing concern, arch_get_unmapped_area_topdown() and
> other helper functions are implemented in arch/mips/kernel/syscall.c.
>
> Signed-off-by: Jian Peng<jipeng2005@gmail.com>
> ---

Still too much code duplication.

Try regenerating after Ralf's recent patch, and do something like:

enum map_allocation_direction { up, down };

long arch_get_unmapped_area_foo(num map_allocation_direction, ....)
{
/* a function that does both without code duplication */
.
.
.
}

long arch_get_unmapped_area(....)
{
	return arch_get_unmapped_area_foo(up, ...);
}

long arch_get_unmapped_area_topdown(....)
{
	return arch_get_unmapped_area_foo(down, ...);
}



>   arch/mips/include/asm/pgtable.h |    1 +
>   arch/mips/kernel/syscall.c      |  185 +++++++++++++++++++++++++++++++++++++-
>   2 files changed, 181 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 7e40f37..b2202a6 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -414,6 +414,7 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
>    * constraints placed on us by the cache architecture.
>    */
>   #define HAVE_ARCH_UNMAPPED_AREA
> +#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
>
>   /*
>    * No page table caches to initialise
> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> index 58beabf..e2f0ed5 100644
> --- a/arch/mips/kernel/syscall.c
> +++ b/arch/mips/kernel/syscall.c
> @@ -42,6 +42,7 @@
>   #include<asm/shmparam.h>
>   #include<asm/sysmips.h>
>   #include<asm/uaccess.h>
> +#include<linux/personality.h>
>
>   /*
>    * For historic reasons the pipe(2) syscall on MIPS has an unusual calling
> @@ -70,14 +71,60 @@ unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
>
>   EXPORT_SYMBOL(shm_align_mask);
>
> -#define COLOUR_ALIGN(addr,pgoff)				\
> +/* gap between mmap and stack */
> +#define MIN_GAP (128*1024*1024UL)
> +#define MAX_GAP(task_size)	((task_size)/6*5)
> +
> +static int mmap_is_legacy(void)
> +{
> +	if (current->personality&  ADDR_COMPAT_LAYOUT)
> +		return 1;
> +
> +	if (rlimit(RLIMIT_STACK) == RLIM_INFINITY)
> +		return 1;
> +
> +	return sysctl_legacy_va_layout;
> +}
> +
> +static unsigned long mmap_base(unsigned long rnd)
> +{
> +	unsigned long gap = rlimit(RLIMIT_STACK);
> +	unsigned long task_size;
> +
> +#ifdef CONFIG_32BIT
> +	task_size = TASK_SIZE;
> +#else /* Must be CONFIG_64BIT*/
> +	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
> +#endif
> +
> +	if (gap<  MIN_GAP)
> +		gap = MIN_GAP;
> +	else if (gap>  MAX_GAP(task_size))
> +		gap = MAX_GAP(task_size);
> +
> +	return PAGE_ALIGN(task_size - gap - rnd);
> +}
> +
> +static inline unsigned long COLOUR_ALIGN_DOWN(unsigned long addr,
> +					      unsigned long pgoff)
> +{
> +	unsigned long base = addr&  ~shm_align_mask;
> +	unsigned long off = (pgoff<<  PAGE_SHIFT)&  shm_align_mask;
> +
> +	if (base + off<= addr)
> +		return base + off;
> +
> +	return base - off;
> +}
> +
> +#define COLOUR_ALIGN(addr, pgoff)				\
>   	((((addr) + shm_align_mask)&  ~shm_align_mask) +	\
>   	 (((pgoff)<<  PAGE_SHIFT)&  shm_align_mask))
>
>   unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
>   	unsigned long len, unsigned long pgoff, unsigned long flags)
>   {
> -	struct vm_area_struct * vmm;
> +	struct vm_area_struct *vmm;
>   	int do_color_align;
>   	unsigned long task_size;
>
> @@ -136,6 +183,128 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
>   	}
>   }
>
> +unsigned long
> +arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
> +			  const unsigned long len, const unsigned long pgoff,
> +			  const unsigned long flags)
> +{
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr = addr0;
> +	int do_color_align;
> +	unsigned long task_size;
> +
> +#ifdef CONFIG_32BIT
> +	task_size = TASK_SIZE;
> +#else /* Must be CONFIG_64BIT*/
> +	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
> +#endif
> +
> +	if (unlikely(len>  task_size))
> +		return -ENOMEM;
> +
> +	if (flags&  MAP_FIXED) {
> +		/* Even MAP_FIXED mappings must reside within task_size.  */
> +		if (task_size - len<  addr)
> +			return -EINVAL;
> +
> +		/* We do not accept a shared mapping if it would violate
> +		 * cache aliasing constraints.
> +		 */
> +		if ((flags&  MAP_SHARED)&&
> +		    ((addr - (pgoff<<  PAGE_SHIFT))&  shm_align_mask))
> +			return -EINVAL;
> +		return addr;
> +	}
> +
> +	do_color_align = 0;
> +	if (filp || (flags&  MAP_SHARED))
> +		do_color_align = 1;
> +
> +	/* requesting a specific address */
> +	if (addr) {
> +		if (do_color_align)
> +			addr = COLOUR_ALIGN(addr, pgoff);
> +		else
> +			addr = PAGE_ALIGN(addr);
> +
> +		vma = find_vma(mm, addr);
> +		if (task_size - len>= addr&&
> +		    (!vma || addr + len<= vma->vm_start))
> +			return addr;
> +	}
> +
> +	/* check if free_area_cache is useful for us */
> +	if (len<= mm->cached_hole_size) {
> +		mm->cached_hole_size = 0;
> +		mm->free_area_cache = mm->mmap_base;
> +	}
> +
> +	/* either no address requested or can't fit in requested address hole */
> +	addr = mm->free_area_cache;
> +	if (do_color_align) {
> +		unsigned long base = COLOUR_ALIGN_DOWN(addr-len, pgoff);
> +
> +		addr = base + len;
> +	}
> +
> +	/* make sure it can fit in the remaining address space */
> +	if (likely(addr>  len)) {
> +		vma = find_vma(mm, addr-len);
> +		if (!vma || addr<= vma->vm_start) {
> +			/* remember the address as a hint for next time */
> +			return mm->free_area_cache = addr-len;
> +		}
> +	}
> +
> +	if (unlikely(mm->mmap_base<  len))
> +		goto bottomup;
> +
> +	addr = mm->mmap_base-len;
> +	if (do_color_align)
> +		addr = COLOUR_ALIGN_DOWN(addr, pgoff);
> +
> +	do {
> +		/*
> +		 * Lookup failure means no vma is above this address,
> +		 * else if new region fits below vma->vm_start,
> +		 * return with success:
> +		 */
> +		vma = find_vma(mm, addr);
> +		if (likely(!vma || addr+len<= vma->vm_start)) {
> +			/* remember the address as a hint for next time */
> +			return mm->free_area_cache = addr;
> +		}
> +
> +		/* remember the largest hole we saw so far */
> +		if (addr + mm->cached_hole_size<  vma->vm_start)
> +			mm->cached_hole_size = vma->vm_start - addr;
> +
> +		/* try just below the current vma->vm_start */
> +		addr = vma->vm_start-len;
> +		if (do_color_align)
> +			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
> +	} while (likely(len<  vma->vm_start));
> +
> +bottomup:
> +	/*
> +	 * A failed mmap() very likely causes application failure,
> +	 * so fall back to the bottom-up function here. This scenario
> +	 * can happen with large stack limits and large mmap()
> +	 * allocations.
> +	 */
> +	mm->cached_hole_size = ~0UL;
> +	mm->free_area_cache = TASK_UNMAPPED_BASE;
> +	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
> +	/*
> +	 * Restore the topdown base:
> +	 */
> +	mm->free_area_cache = mm->mmap_base;
> +	mm->cached_hole_size = ~0UL;
> +
> +	return addr;
> +}
> +
>   void arch_pick_mmap_layout(struct mm_struct *mm)
>   {
>   	unsigned long random_factor = 0UL;
> @@ -149,9 +318,15 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
>   			random_factor&= 0xffffffful;
>   	}
>
> -	mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -	mm->get_unmapped_area = arch_get_unmapped_area;
> -	mm->unmap_area = arch_unmap_area;
> +	if (mmap_is_legacy()) {
> +		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> +		mm->get_unmapped_area = arch_get_unmapped_area;
> +		mm->unmap_area = arch_unmap_area;
> +	} else {
> +		mm->mmap_base = mmap_base(random_factor);
> +		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> +		mm->unmap_area = arch_unmap_area_topdown;
> +	}
>   }
>
>   static inline unsigned long brk_rnd(void)
