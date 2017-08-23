Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 19:30:00 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:34858
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992864AbdHWR3yMwzGI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 19:29:54 +0200
Received: by mail-qt0-x242.google.com with SMTP id r28so159220qte.2;
        Wed, 23 Aug 2017 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5Lzvg0M7RqwtYCW/urj81aRS1zmGEZ+2ZqN6zyJ/2c=;
        b=bTBT25FwWYyiWVC7P4rIj6Kd8tbOb7L5S5H5AcRb/0XxG06fUZ/aay1crIzJNju5PU
         isP+/njJEdRdbZ2JcyNw9TjQal0278JHdh26vJA9raKPvWtXaneS4erwg1J9rNx3lUnt
         gnPHRteRNsHYrOD90jN0ubfq+OR+0qPyaEOX+/QF6jPuoiXWHmROYDssvw0z0MyQpmxU
         6W2V9JPYDv+XXB662ZoPa3bJUDH/9MiJcJ7alHN+sK5kRIprd5Kql1lHGcCrz93gPRPB
         +ousXVHXnQv28dH2kRPFQSrpBsqbFtxqD7ou1tr1Ml2LjL4ZvHGCeoPgB/Y8tCjEw5bE
         vEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5Lzvg0M7RqwtYCW/urj81aRS1zmGEZ+2ZqN6zyJ/2c=;
        b=MbpARWYyVFVSaZFHSlU5AsGRHRdfqWlCypXwZtZqmGkE8V3I2IRmUBAokxbyin2DtG
         jqu6a17XbUy9rIbAPar7mUySiC0mJCnYehTCUspLoV43oBT/NODK19fq+d8Jm7zP2+43
         wf/u5KZkCLiWYW0WeRKonhrNFuIlEKEEdlToSbjwB7OrKwje8CPZrqSQ20/G5RuNVts5
         YOtngxM7nnYmdU8rKmGrUIXrJte1KtwGCKS6mVxX9KRiCMv95RQRb3nNYozcvd1AbIpD
         vOMYj+eDdXbXBajToC0A1T5PKXrLRbXsVVxJzx59GfRFDUU82RyXINzfub/nt5NoWe8L
         GH9A==
X-Gm-Message-State: AHYfb5hS2I7QPAsVJQthvCe1lpyNysk2cxyymV+2IYRh2owSwbjCRpAp
        +D5qCslkmS22Kw==
X-Received: by 10.200.47.71 with SMTP id k7mr4726736qta.319.1503509388397;
        Wed, 23 Aug 2017 10:29:48 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id n196sm1159256qkn.83.2017.08.23.10.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 10:29:47 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Add support for CONFIG_DEBUG_VIRTUAL
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     david.daney@cavium.com, paul.burton@imgtec.com,
        james.hogan@imgtec.com
References: <20170328175718.28629-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <580194d9-593d-33ed-2871-3703ca39e566@gmail.com>
Date:   Wed, 23 Aug 2017 10:29:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170328175718.28629-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 03/28/2017 10:57 AM, Florian Fainelli wrote:
> Provide hooks to intercept bad usages of virt_to_phys() and
> __pa_symbol() throughout the kernel. To make this possible, we need to
> rename the current implement of virt_to_phys() into
> __virt_to_phys_nodebug() and wrap it around depending on
> CONFIG_DEBUG_VIRTUAL.
> 
> A similar thing is needed for __pa_symbol() which is now aliased to
> __phys_addr_symbol() whose implementation is either the direct return of
> RELOC_HIDE or goes through the debug version.

Ping? This may not longer apply cleanly against arch/mips/Kconfig, but
the conflicts should be trivial to resolve.

Thanks.

> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/Kconfig            |  1 +
>  arch/mips/include/asm/io.h   | 14 +++++++++++++-
>  arch/mips/include/asm/page.h |  9 ++++++++-
>  arch/mips/mm/Makefile        |  2 ++
>  arch/mips/mm/physaddr.c      | 40 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 arch/mips/mm/physaddr.c
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2afb41c52ba0..724457b5a7eb 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -70,6 +70,7 @@ config MIPS
>  	select HAVE_EXIT_THREAD
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_ARCH_HARDENED_USERCOPY
> +	select ARCH_HAS_DEBUG_VIRTUAL
>  
>  menu "Machine selection"
>  
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index ecabc00c1e66..016e12161c9d 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -116,11 +116,23 @@ static inline void set_io_port_base(unsigned long base)
>   *     almost all conceivable cases a device driver should not be using
>   *     this function
>   */
> -static inline unsigned long virt_to_phys(volatile const void *address)
> +static inline unsigned long __virt_to_phys_nodebug(volatile const void *address)
>  {
>  	return __pa(address);
>  }
>  
> +#ifdef CONFIG_DEBUG_VIRTUAL
> +extern phys_addr_t __virt_to_phys(volatile const void *x);
> +#else
> +#define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
> +#endif
> +
> +#define virt_to_phys virt_to_phys
> +static inline phys_addr_t virt_to_phys(const volatile void *x)
> +{
> +	return __virt_to_phys(x);
> +}
> +
>  /*
>   *     phys_to_virt    -       map physical address to virtual
>   *     @address: address to remap
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 5f987598054f..bf8bd7d77fce 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -205,9 +205,16 @@ static inline unsigned long ___pa(unsigned long x)
>   * until GCC 3.x has been retired before we can apply
>   * https://patchwork.linux-mips.org/patch/1541/
>   */
> +#define __pa_symbol_nodebug(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
> +
> +#ifdef CONFIG_DEBUG_VIRTUAL
> +extern phys_addr_t __phys_addr_symbol(unsigned long x);
> +#else
> +#define __phys_addr_symbol(x)	__pa_symbol_nodebug(x)
> +#endif
>  
>  #ifndef __pa_symbol
> -#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
> +#define __pa_symbol(x)		__phys_addr_symbol((unsigned long)(x))
>  #endif
>  
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
> index b4cc8811a664..0a1d241c50fb 100644
> --- a/arch/mips/mm/Makefile
> +++ b/arch/mips/mm/Makefile
> @@ -29,3 +29,5 @@ obj-$(CONFIG_R5000_CPU_SCACHE)	+= sc-r5k.o
>  obj-$(CONFIG_RM7000_CPU_SCACHE) += sc-rm7k.o
>  obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
>  obj-$(CONFIG_SCACHE_DEBUGFS)	+= sc-debugfs.o
> +
> +obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
> diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> new file mode 100644
> index 000000000000..6123a9b3b3c0
> --- /dev/null
> +++ b/arch/mips/mm/physaddr.c
> @@ -0,0 +1,40 @@
> +#include <linux/bug.h>
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <linux/mmdebug.h>
> +#include <linux/mm.h>
> +
> +#include <asm/sections.h>
> +#include <asm/io.h>
> +#include <asm/page.h>
> +#include <asm/dma.h>
> +
> +static inline bool __debug_virt_addr_valid(unsigned long x)
> +{
> +	if (x >= PAGE_OFFSET && x < (unsigned long)high_memory)
> +		return true;
> +
> +	return false;
> +}
> +
> +phys_addr_t __virt_to_phys(volatile const void *x)
> +{
> +	WARN(!__debug_virt_addr_valid((unsigned long)x),
> +	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
> +	     x, x);
> +
> +	return __virt_to_phys_nodebug(x);
> +}
> +EXPORT_SYMBOL(__virt_to_phys);
> +
> +phys_addr_t __phys_addr_symbol(unsigned long x)
> +{
> +	/* This is bounds checking against the kernel image only.
> +	 * __pa_symbol should only be used on kernel symbol addresses.
> +	 */
> +	VIRTUAL_BUG_ON(x < (unsigned long)_text ||
> +		       x > (unsigned long)_end);
> +
> +	return __pa_symbol_nodebug(x);
> +}
> +EXPORT_SYMBOL(__phys_addr_symbol);
> 


-- 
Florian
