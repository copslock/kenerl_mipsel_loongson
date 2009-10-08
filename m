Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 11:58:52 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:24986 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492536AbZJHJ6o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 11:58:44 +0200
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 128053EC9; Thu,  8 Oct 2009 02:58:40 -0700 (PDT)
Message-ID: <4ACDB7CB.4030209@ru.mvista.com>
Date:	Thu, 08 Oct 2009 13:58:35 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Wu Zhangjin wrote:

> When CONFIG_FLAGMEM enabled, STD/Hiberation will fail on YeeLoong
>   

   You surely meant FLATMEM here and the subject.

> laptop, This patch fix it:
>   

   Fixes.

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>   
[...]
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index f266295..16903a6 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -168,13 +168,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>  
>  #ifdef CONFIG_FLATMEM
>  
> -#define pfn_valid(pfn)							\
> -({									\
> -	unsigned long __pfn = (pfn);					\
> -	/* avoid <linux/bootmem.h> include hell */			\
> -	extern unsigned long min_low_pfn;				\
> -									\
> -	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> +#define pfn_valid(pfn)				\
> +({						\
> +	extern int is_pfn_valid(unsigned long); \
> +	is_pfn_valid(pfn);			\
>   

   Why not just define pfn_valid() as *extern* function in this case?

> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index f5c7375..48a4d2a 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -689,3 +689,20 @@ void copy_page(void *to, void *from)
>  }
>  
>  #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
> +
> +#ifdef CONFIG_FLATMEM
> +int is_pfn_valid(unsigned long pfn)
> +{
> +	int i;
> +
> +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> +		if (boot_mem_map.map[i].type == BOOT_MEM_RAM) {
> +			if ((pfn >= PFN_DOWN(boot_mem_map.map[i].addr)) &&
> +				((pfn) <= (PFN_UP(boot_mem_map.map[i].addr +
>   

   Not <?

> +					boot_mem_map.map[i].size))))
> +				return 1;
> +		}
> +	}
> +	return 0;
> +}
> +#endif
>   

WBR, Sergei
