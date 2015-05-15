Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 18:28:47 +0200 (CEST)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34057 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009768AbbEOQ2pkW8YW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 18:28:45 +0200
Received: by ieczm2 with SMTP id zm2so46900859iec.1;
        Fri, 15 May 2015 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=w+1/nJhQtUAQ8b/w+b7KZ9Ph7OJKhGVpKvIlkMsQ7C8=;
        b=zr53G5djMIvjLmQgR/TVOi6cyxiG6T7kJjZs3juYHGM3S7m2djUoMoxzAlqvwALoH/
         ZaL0t6eCGEk/IvqmvASo39bKxwkJgVvGvnJXbBeYxCPCdWyfWrPqgzKwx4cgGBr1Wnfw
         01/9vxqz9V4TG+swtZhbond4vJbacnCw95Npb859GFbiRL36McV8ev2DivSBOw+5HwUy
         KP0NzbOUQIo/RFJdjpOAcbnQm/4UVShTbmYrTHpA9JF1l61WiY3sr3aJ1Hm436Xq7MNt
         hL6X+4jPUqLVYmiV1ZykTNyI3E6F/p2v5ZPjovFuH7Exp0sCNxGobtHlpLU6X4HRvYST
         wRUQ==
X-Received: by 10.107.9.67 with SMTP id j64mr14380827ioi.39.1431707321697;
        Fri, 15 May 2015 09:28:41 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id i80sm1431567iod.6.2015.05.15.09.28.39
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 09:28:40 -0700 (PDT)
Message-ID: <55561EB6.4020009@gmail.com>
Date:   Fri, 15 May 2015 09:28:38 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     aleksey.makarov@auriga.com, james.hogan@imgtec.com,
        paul.burton@imgtec.com, david.daney@cavium.com,
        peterz@infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        davidlohr@hp.com, kirill@shutemov.name, akpm@linux-foundation.org,
        mingo@kernel.org
Subject: Re: [PATCH v2] MIPS64: Support of at least 48 bits of SEGBITS
References: <20150515013351.7450.12130.stgit@ubuntu-yegoshin>
In-Reply-To: <20150515013351.7450.12130.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47411
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

On 05/14/2015 06:34 PM, Leonid Yegoshin wrote:
> SEGBITS default is 40 bits or less, depending from CPU type.
> This patch introduces 48bits of application virtual address (SEGBITS) support.
> It is defined only for 16K and 64K pages and is optional (configurable).
>
> Penalty - a small number of additional pages for generic (small) applications.
> But for 64K pages it adds 3rd level of PTE structure, which has a little
> impact during software TLB refill.
>
> This patch is needed because MIPS I6XXX and P6XXX cores have 48 bit of
> virtual address in each segment (SEGBITS).
>

I'm concerned that the change log doesn't convey the true reason for the 
patch.

Many processors support larger VA space than is utilized by the kernel. 
  A choice was made to reduce the size of the VA space in order to 
reduce TLB handling overhead.

If the true reason for the patch is to enable larger VA space, say that. 
  But is it really required by those processors you mention?  I doubt it.

David Daney


> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
> V2: Added correction for defintion of TASK_SIZE64
> ---
>   arch/mips/Kconfig                  |   11 +++++++++++
>   arch/mips/include/asm/pgtable-64.h |   18 +++++++++++-------
>   arch/mips/include/asm/processor.h  |    6 +++++-
>   3 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 76efb02ae99f..3acff2f065e9 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2032,6 +2032,17 @@ config PAGE_SIZE_64KB
>
>   endchoice
>
> +config 48VMBITS
> +	bool "48 bits virtual memory"
> +	depends on PAGE_SIZE_16KB || PAGE_SIZE_64KB
> +	depends on 64BIT
> +	help
> +	  Define a maximum at least 48 bits of application virtual memory.
> +	  Default is 40 bits or less, depending from CPU.
> +	  In generic (small) application it is a small set of pages increase
> +	  in page tables.
> +	  If unsure, say N.
> +
>   config FORCE_MAX_ZONEORDER
>   	int "Maximum zone order"
>   	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index cf661a2fb141..c6b5473440e6 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -17,7 +17,7 @@
>   #include <asm/cachectl.h>
>   #include <asm/fixmap.h>
>
> -#ifdef CONFIG_PAGE_SIZE_64KB
> +#if defined(CONFIG_PAGE_SIZE_64KB) && !defined(CONFIG_48VMBITS)
>   #include <asm-generic/pgtable-nopmd.h>
>   #else
>   #include <asm-generic/pgtable-nopud.h>
> @@ -90,7 +90,11 @@
>   #define PTE_ORDER		0
>   #endif
>   #ifdef CONFIG_PAGE_SIZE_16KB
> -#define PGD_ORDER		0
> +#ifdef CONFIG_48VMBITS
> +#define PGD_ORDER               1
> +#else
> +#define PGD_ORDER               0
> +#endif
>   #define PUD_ORDER		aieeee_attempt_to_allocate_pud
>   #define PMD_ORDER		0
>   #define PTE_ORDER		0
> @@ -104,7 +108,11 @@
>   #ifdef CONFIG_PAGE_SIZE_64KB
>   #define PGD_ORDER		0
>   #define PUD_ORDER		aieeee_attempt_to_allocate_pud
> +#ifdef CONFIG_48VMBITS
> +#define PMD_ORDER		0
> +#else
>   #define PMD_ORDER		aieeee_attempt_to_allocate_pmd
> +#endif
>   #define PTE_ORDER		0
>   #endif
>
> @@ -114,11 +122,7 @@
>   #endif
>   #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
>
> -#if PGDIR_SIZE >= TASK_SIZE64
> -#define USER_PTRS_PER_PGD	(1)
> -#else
> -#define USER_PTRS_PER_PGD	(TASK_SIZE64 / PGDIR_SIZE)
> -#endif
> +#define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
>   #define FIRST_USER_ADDRESS	0UL
>
>   /*
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index 9b3b48e21c22..bd2030f32ea4 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -69,7 +69,11 @@ extern unsigned int vced_count, vcei_count;
>    * 8192EB ...
>    */
>   #define TASK_SIZE32	0x7fff8000UL
> -#define TASK_SIZE64	0x10000000000UL
> +#ifdef CONFIG_48VMBITS
> +#define TASK_SIZE64     (0x1UL << ((cpu_data[0].vmbits>48)?48:cpu_data[0].vmbits))
> +#else
> +#define TASK_SIZE64     (0x10000000000UL)
> +#endif
>   #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
>   #define STACK_TOP_MAX	TASK_SIZE64
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
