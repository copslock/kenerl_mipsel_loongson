Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2009 16:39:05 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:46338 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492786AbZJJOi6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2009 16:38:58 +0200
Received: by pzk35 with SMTP id 35so2606617pzk.22
        for <multiple recipients>; Sat, 10 Oct 2009 07:38:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=lrVpR3MMyt5/WeSUikMFTRWxe4t8H6hs7wHx8FS1H2o=;
        b=MdvyPLr7bvMULdPjf+o9E8dS2f5fo2TvA73ajsQtP/OUUjbUon1ongrgZcNdVGqaGD
         fiYtlSN784w6Sy1v8N36FoePlLfqJeUw9XVsKIWbiujcoJXvEWiBY5LhRkDqwCWWZzKR
         ZgMe0inoV2L6PgVojheaGPOZuUNsgogff99yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=gKc4YV+Phz3q+fcU90yMg02xtYhr4bPw5fk7XMm3p9rLzU7A8bViY0O4nY54ybEE3C
         Y31sVWGCPNiWinVq7+SXOu7p6Ts0rVSqmnA7O87aJFnhoQdbiu3kjfqJbhkE3dWfMp+d
         Wu4lVGtblObbok3eZp5a2yuEIlUrXG9UWN9wE=
Received: by 10.115.103.23 with SMTP id f23mr5465257wam.226.1255185530617;
        Sat, 10 Oct 2009 07:38:50 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm600836pxi.7.2009.10.10.07.38.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 07:38:49 -0700 (PDT)
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	rjw@sisk.pl, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1255104936-14921-1-git-send-email-wuzhangjin@gmail.com>
References: <1255104936-14921-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 10 Oct 2009 22:38:40 +0800
Message-Id: <1255185520.6883.28.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hello, all

Please ignore This Patch, And I have tried to register_nosave_region
from 20000000 to 7fffffff(include the reserved page and pci memory
space), it will make the wifi driver not work(read/write_nic_word fail,
DMA relative, something bad with pci memory space), So I choose the last
choice, come back to the oldest patch I have sent: "Hibernation: only
save pages in system ram".

Regards,
	Wu Zhangjin

On Sat, 2009-10-10 at 00:15 +0800, Wu Zhangjin wrote:
> When CONFIG_FLATMEM enabled, STD/Hiberation will fail on YeeLoong
> laptop, This patch fixes it:
> 
> if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
> return TRUE, but if the memory is not continuous, for example:
> 
> $ cat /proc/iomem | grep "System RAM"
> 00000000-0fffffff : System RAM
> 90000000-bfffffff : System RAM
> 
> as we can see, it is not continuous, so, some of the memory is not
> valid, and at last make STD/Hibernate fail when shrinking a too large
> number of invalid memory.
> 
> the "invalid" memory here include the memory space we never used.
> 
> 10000000-3fffffff
> 80000000-8fffffff
> 
> and also include the meory space we have mapped into pci space.
> 
> 40000000-7fffffff : pci memory space
> 
> Here, we fix it via checking pfn is in the "System RAM" or not. and
> Seems pfn_valid() is not called in assembly code, we move it to
> "!__ASSEMBLY__" to ensure we can simply declare it via "extern int
> pfn_valid(unsigned long)" without Compiling Error.
> 
> (This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
>  and Sergei Shtylyov <sshtylyov@ru.mvista.com> and Ralf)
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/include/asm/page.h |   50 ++++++++++++++++++-----------------------
>  arch/mips/mm/page.c          |   18 +++++++++++++++
>  2 files changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index f266295..dc28d0a 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -146,36 +146,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>   */
>  #define ptep_buddy(x)	((pte_t *)((unsigned long)(x) ^ sizeof(pte_t)))
>  
> -#endif /* !__ASSEMBLY__ */
> -
> -/*
> - * __pa()/__va() should be used only during mem init.
> - */
> -#ifdef CONFIG_64BIT
> -#define __pa(x)								\
> -({									\
> -    unsigned long __x = (unsigned long)(x);				\
> -    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
> -})
> -#else
> -#define __pa(x)								\
> -    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
> -#endif
> -#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
> -#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
> -
> -#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> -
>  #ifdef CONFIG_FLATMEM
>  
> -#define pfn_valid(pfn)							\
> -({									\
> -	unsigned long __pfn = (pfn);					\
> -	/* avoid <linux/bootmem.h> include hell */			\
> -	extern unsigned long min_low_pfn;				\
> -									\
> -	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> -})
> +extern int pfn_valid(unsigned long);
>  
>  #elif defined(CONFIG_SPARSEMEM)
>  
> @@ -194,6 +167,27 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>  
>  #endif
>  
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +/*
> + * __pa()/__va() should be used only during mem init.
> + */
> +#ifdef CONFIG_64BIT
> +#define __pa(x)								\
> +({									\
> +    unsigned long __x = (unsigned long)(x);				\
> +    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
> +})
> +#else
> +#define __pa(x)								\
> +    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
> +#endif
> +#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
> +#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
> +
> +#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> +
>  #define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
>  #define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
>  
> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index f5c7375..203d805 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -689,3 +689,21 @@ void copy_page(void *to, void *from)
>  }
>  
>  #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
> +
> +#ifdef CONFIG_FLATMEM
> +int pfn_valid(unsigned long pfn)
> +{
> +	int i;
> +
> +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> +		if ((boot_mem_map.map[i].type == BOOT_MEM_RAM) ||
> +			(boot_mem_map.map[i].type == BOOT_MEM_ROM_DATA)) {
> +			if ((pfn >= PFN_DOWN(boot_mem_map.map[i].addr)) &&
> +				(pfn < PFN_UP(boot_mem_map.map[i].addr +
> +					boot_mem_map.map[i].size)))
> +				return 1;
> +		}
> +	}
> +	return 0;
> +}
> +#endif
