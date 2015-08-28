Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 16:31:41 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35910 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007749AbbH1ObhQ08NE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2015 16:31:37 +0200
Received: by wicfv10 with SMTP id fv10so9784047wic.1
        for <linux-mips@linux-mips.org>; Fri, 28 Aug 2015 07:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6LMwZCIfX073bDNfCvGuArxybDC33TkilQkNKOkxDps=;
        b=D+mqdUYM/VBGyZ0Uzfy0or4IOPtz84CSTDqZl/AMgKyEZN8o0kDDv3NUVgAxQjBWQQ
         A2RGfyEDGkAHHrorLPzAfgUgyWXS1wnyIY60Ag0Xc2+S9OKZTsG+uL2tRzgNdQjIdkUG
         inwmdFjFW6vuNNJpfKggf/+ijL9btgvCOKKgH3h9sMZxd/TpyinYmvcs7eU1rX8qJPNt
         Gu0McSkqU2NJPm91lWduIofAsaWpNdhuVLDJyxBQXGbUshrTx0YRa5wxsIjPCWhxZ1Az
         tNyYYf6DdQlPul3iBXTLYONc/wZVsRToebMcAyJAqueQc5I4CJMq/+BurYnZzd1EkEc4
         PiWg==
X-Received: by 10.194.250.40 with SMTP id yz8mr12737584wjc.37.1440772292032;
        Fri, 28 Aug 2015 07:31:32 -0700 (PDT)
Received: from localhost (nat1.scz.suse.com. [213.151.88.250])
        by smtp.gmail.com with ESMTPSA id fs8sm4085751wib.0.2015.08.28.07.31.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2015 07:31:31 -0700 (PDT)
Date:   Fri, 28 Aug 2015 16:31:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 4/6] mm: mlock: Add mlock flags to enable
 VM_LOCKONFAULT usage
Message-ID: <20150828143130.GE5301@dhcp22.suse.cz>
References: <1440613465-30393-1-git-send-email-emunson@akamai.com>
 <1440613465-30393-5-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440613465-30393-5-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Wed 26-08-15 14:24:23, Eric B Munson wrote:
> The previous patch introduced a flag that specified pages in a VMA
> should be placed on the unevictable LRU, but they should not be made
> present when the area is created.  This patch adds the ability to set
> this state via the new mlock system calls.
> 
> We add MLOCK_ONFAULT for mlock2 and MCL_ONFAULT for mlockall.
> MLOCK_ONFAULT will set the VM_LOCKONFAULT modifier for VM_LOCKED.
> MCL_ONFAULT should be used as a modifier to the two other mlockall
> flags.  When used with MCL_CURRENT, all current mappings will be marked
> with VM_LOCKED | VM_LOCKONFAULT.  When used with MCL_FUTURE, the
> mm->def_flags will be marked with VM_LOCKED | VM_LOCKONFAULT.  When used
> with both MCL_CURRENT and MCL_FUTURE, all current mappings and
> mm->def_flags will be marked with VM_LOCKED | VM_LOCKONFAULT.
> 
> Prior to this patch, mlockall() will unconditionally clear the
> mm->def_flags any time it is called without MCL_FUTURE.  This behavior
> is maintained after adding MCL_ONFAULT.  If a call to
> mlockall(MCL_FUTURE) is followed by mlockall(MCL_CURRENT), the
> mm->def_flags will be cleared and new VMAs will be unlocked.  This
> remains true with or without MCL_ONFAULT in either mlockall()
> invocation.
> 
> munlock() will unconditionally clear both vma flags.  munlockall()
> unconditionally clears for VMA flags on all VMAs and in the
> mm->def_flags field.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-mm@kvack.org

I haven't checked the arch specific bits but the core part looks good to
me.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/alpha/include/uapi/asm/mman.h     |  3 ++
>  arch/mips/include/uapi/asm/mman.h      |  6 ++++
>  arch/parisc/include/uapi/asm/mman.h    |  3 ++
>  arch/powerpc/include/uapi/asm/mman.h   |  1 +
>  arch/sparc/include/uapi/asm/mman.h     |  1 +
>  arch/tile/include/uapi/asm/mman.h      |  1 +
>  arch/xtensa/include/uapi/asm/mman.h    |  6 ++++
>  include/uapi/asm-generic/mman-common.h |  5 ++++
>  include/uapi/asm-generic/mman.h        |  1 +
>  mm/mlock.c                             | 52 +++++++++++++++++++++++++---------
>  10 files changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 0086b47..f2f9496 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -37,6 +37,9 @@
>  
>  #define MCL_CURRENT	 8192		/* lock all currently mapped pages */
>  #define MCL_FUTURE	16384		/* lock all additions to address space */
> +#define MCL_ONFAULT	32768		/* lock all pages that are faulted in */
> +
> +#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>  
>  #define MADV_NORMAL	0		/* no further special treatment */
>  #define MADV_RANDOM	1		/* expect random page references */
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index cfcb876..97c03f4 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -61,6 +61,12 @@
>   */
>  #define MCL_CURRENT	1		/* lock all current mappings */
>  #define MCL_FUTURE	2		/* lock all future mappings */
> +#define MCL_ONFAULT	4		/* lock all pages that are faulted in */
> +
> +/*
> + * Flags for mlock
> + */
> +#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>  
>  #define MADV_NORMAL	0		/* no further special treatment */
>  #define MADV_RANDOM	1		/* expect random page references */
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index 294d251..ecc3ae1 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -31,6 +31,9 @@
>  
>  #define MCL_CURRENT	1		/* lock all current mappings */
>  #define MCL_FUTURE	2		/* lock all future mappings */
> +#define MCL_ONFAULT	4		/* lock all pages that are faulted in */
> +
> +#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>  
>  #define MADV_NORMAL     0               /* no further special treatment */
>  #define MADV_RANDOM     1               /* expect random page references */
> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index 6ea26df..03c06ba 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -22,6 +22,7 @@
>  
>  #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
>  #define MCL_FUTURE      0x4000          /* lock all additions to address space */
> +#define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
>  
>  #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
> diff --git a/arch/sparc/include/uapi/asm/mman.h b/arch/sparc/include/uapi/asm/mman.h
> index 0b14df3..9765896 100644
> --- a/arch/sparc/include/uapi/asm/mman.h
> +++ b/arch/sparc/include/uapi/asm/mman.h
> @@ -17,6 +17,7 @@
>  
>  #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
>  #define MCL_FUTURE      0x4000          /* lock all additions to address space */
> +#define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
>  
>  #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
> diff --git a/arch/tile/include/uapi/asm/mman.h b/arch/tile/include/uapi/asm/mman.h
> index 81b8fc3..63ee13f 100644
> --- a/arch/tile/include/uapi/asm/mman.h
> +++ b/arch/tile/include/uapi/asm/mman.h
> @@ -36,6 +36,7 @@
>   */
>  #define MCL_CURRENT	1		/* lock all current mappings */
>  #define MCL_FUTURE	2		/* lock all future mappings */
> +#define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>  
>  
>  #endif /* _ASM_TILE_MMAN_H */
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index 201aec0..360944e 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -74,6 +74,12 @@
>   */
>  #define MCL_CURRENT	1		/* lock all current mappings */
>  #define MCL_FUTURE	2		/* lock all future mappings */
> +#define MCL_ONFAULT	4		/* lock all pages that are faulted in */
> +
> +/*
> + * Flags for mlock
> + */
> +#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>  
>  #define MADV_NORMAL	0		/* no further special treatment */
>  #define MADV_RANDOM	1		/* expect random page references */
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index ddc3b36..a74dd84 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -25,6 +25,11 @@
>  # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
>  #endif
>  
> +/*
> + * Flags for mlock
> + */
> +#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
> +
>  #define MS_ASYNC	1		/* sync memory asynchronously */
>  #define MS_INVALIDATE	2		/* invalidate the caches */
>  #define MS_SYNC		4		/* synchronous memory sync */
> diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
> index e9fe6fd..7162cd4 100644
> --- a/include/uapi/asm-generic/mman.h
> +++ b/include/uapi/asm-generic/mman.h
> @@ -17,5 +17,6 @@
>  
>  #define MCL_CURRENT	1		/* lock all current mappings */
>  #define MCL_FUTURE	2		/* lock all future mappings */
> +#define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>  
>  #endif /* __ASM_GENERIC_MMAN_H */
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 7efe27d..0747663 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -506,7 +506,8 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  
>  	if (newflags == vma->vm_flags || (vma->vm_flags & VM_SPECIAL) ||
>  	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm))
> -		goto out;	/* don't set VM_LOCKED,  don't count */
> +		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
> +		goto out;
>  
>  	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
> @@ -576,7 +577,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  		prev = vma;
>  
>  	for (nstart = start ; ; ) {
> -		vm_flags_t newflags = vma->vm_flags & ~VM_LOCKED;
> +		vm_flags_t newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
>  
>  		newflags |= flags;
>  
> @@ -645,10 +646,15 @@ SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
>  
>  SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
>  {
> -	if (flags)
> +	vm_flags_t vm_flags = VM_LOCKED;
> +
> +	if (flags & ~MLOCK_ONFAULT)
>  		return -EINVAL;
>  
> -	return do_mlock(start, len, VM_LOCKED);
> +	if (flags & MLOCK_ONFAULT)
> +		vm_flags |= VM_LOCKONFAULT;
> +
> +	return do_mlock(start, len, vm_flags);
>  }
>  
>  SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
> @@ -665,24 +671,43 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
>  	return ret;
>  }
>  
> +/*
> + * Take the MCL_* flags passed into mlockall (or 0 if called from munlockall)
> + * and translate into the appropriate modifications to mm->def_flags and/or the
> + * flags for all current VMAs.
> + *
> + * There are a couple of subtleties with this.  If mlockall() is called multiple
> + * times with different flags, the values do not necessarily stack.  If mlockall
> + * is called once including the MCL_FUTURE flag and then a second time without
> + * it, VM_LOCKED and VM_LOCKONFAULT will be cleared from mm->def_flags.
> + */
>  static int apply_mlockall_flags(int flags)
>  {
>  	struct vm_area_struct * vma, * prev = NULL;
> +	vm_flags_t to_add = 0;
>  
> -	if (flags & MCL_FUTURE)
> +	current->mm->def_flags &= VM_LOCKED_CLEAR_MASK;
> +	if (flags & MCL_FUTURE) {
>  		current->mm->def_flags |= VM_LOCKED;
> -	else
> -		current->mm->def_flags &= ~VM_LOCKED;
>  
> -	if (flags == MCL_FUTURE)
> -		goto out;
> +		if (flags & MCL_ONFAULT)
> +			current->mm->def_flags |= VM_LOCKONFAULT;
> +
> +		if (!(flags & MCL_CURRENT))
> +			goto out;
> +	}
> +
> +	if (flags & MCL_CURRENT) {
> +		to_add |= VM_LOCKED;
> +		if (flags & MCL_ONFAULT)
> +			to_add |= VM_LOCKONFAULT;
> +	}
>  
>  	for (vma = current->mm->mmap; vma ; vma = prev->vm_next) {
>  		vm_flags_t newflags;
>  
> -		newflags = vma->vm_flags & ~VM_LOCKED;
> -		if (flags & MCL_CURRENT)
> -			newflags |= VM_LOCKED;
> +		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
> +		newflags |= to_add;
>  
>  		/* Ignore errors */
>  		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
> @@ -697,7 +722,8 @@ SYSCALL_DEFINE1(mlockall, int, flags)
>  	unsigned long lock_limit;
>  	int ret = -EINVAL;
>  
> -	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
> +	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT)) ||
> +	    flags == MCL_ONFAULT)
>  		goto out;
>  
>  	ret = -EPERM;
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
