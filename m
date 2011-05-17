Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 02:12:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10598 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491068Ab1EQAMi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2011 02:12:38 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dd1bdb10000>; Mon, 16 May 2011 17:13:37 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 16 May 2011 17:12:35 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 16 May 2011 17:12:34 -0700
Message-ID: <4DD1BD72.2000408@caviumnetworks.com>
Date:   Mon, 16 May 2011 17:12:34 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jian Peng <jipeng@broadcom.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: patch to support topdown mmap allocation in MIPS
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2011 00:12:34.0956 (UTC) FILETIME=[1F5FE4C0:01CC1427]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/16/2011 02:09 PM, Jian Peng wrote:
>> From cda3f14f0201342db9649376e9124167b42bbeba Mon Sep 17 00:00:00 2001
> From: Jian Peng<jipeng2005@gmail.com>
> Date: Mon, 16 May 2011 12:07:37 -0700
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
[...]
> +
> +/* add COLOUR_ALIGN_DOWN */

That is not a good comment.  We know you are adding it by all the '+' 
characters in the patch.

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
>   #define COLOUR_ALIGN(addr,pgoff)				\
>   	((((addr) + shm_align_mask)&  ~shm_align_mask) +	\
>   	 (((pgoff)<<  PAGE_SHIFT)&  shm_align_mask))
> @@ -136,6 +185,125 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
>   	}
>   }
>
> +/* add  arch_get_unmapped_area_topdown */

Another bad comment.

> +unsigned long
> +arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
> +			  const unsigned long len, const unsigned long pgoff,
> +			  const unsigned long flags)
> +{
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr = addr0;
> +	int do_colour_align;
> +	unsigned long task_size;
> +
> +#ifdef CONFIG_32BIT
> +	task_size = TASK_SIZE;
> +#else /* Must be CONFIG_64BIT*/
> +	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
> +#endif
> +
> +	if (flags&  MAP_FIXED) {
> +		/* We do not accept a shared mapping if it would violate
> +		 * cache aliasing constraints.
> +		 */
> +		if ((flags&  MAP_SHARED)&&
> +		    ((addr - (pgoff<<  PAGE_SHIFT))&  shm_align_mask))
> +			return -EINVAL;
> +		return addr;
> +	}
> +
> +	if (unlikely(len>  task_size))
> +		return -ENOMEM;
> +


All this code you are duplicating from arch_get_unmapped_area(), but you 
introduce subtle bugs by removing some needed checks.

Why duplicate the code?

Why remove the checks?


David Daney
