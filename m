Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 09:30:57 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:54767 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133374AbWGEIao (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Jul 2006 09:30:44 +0100
Received: by ug-out-1314.google.com with SMTP id u2so2078044uge
        for <linux-mips@linux-mips.org>; Wed, 05 Jul 2006 01:30:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=lUwJRy4pwVDF/ZfwbLc/rRsccudIePGwy9q7xIJQat+LUxNIDOQRLPrTWY0gUnIJpBI2UC/YFLpAzTjj6+gypIf/wxJvNe3H+hludbjEaNW5FZVZM4nLd4fbQw37kWR7noYA59TbNvPIFw+2aqZcpvHQPjw3KQVlAv8g8BuYSRw=
Received: by 10.78.165.16 with SMTP id n16mr1882713hue;
        Wed, 05 Jul 2006 01:30:42 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 4sm1955406hud.2006.07.05.01.30.41;
        Wed, 05 Jul 2006 01:30:42 -0700 (PDT)
Message-ID: <44AB79D0.90002@innova-card.com>
Date:	Wed, 05 Jul 2006 10:35:28 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> 1. MIPS should select SPARSEMEM_STATIC since allocating bootmem in
>    memory_present() will corrupt bootmap area.
> 2. pfn_valid() for SPARSEMEM is defined in linux/mmzone.h
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index f151a7e..879a19c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1690,6 +1690,7 @@ config ARCH_DISCONTIGMEM_ENABLE
>  
>  config ARCH_SPARSEMEM_ENABLE
>  	bool
> +	select SPARSEMEM_STATIC
>  
>  config NUMA
>  	bool "NUMA Support"
> diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
> index 6b97744..6ed1151 100644
> --- a/include/asm-mips/page.h
> +++ b/include/asm-mips/page.h
> @@ -138,16 +138,14 @@ #define __va(x)			((void *)((unsigned lo
>  
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>  
> -#ifndef CONFIG_SPARSEMEM
> -#ifndef CONFIG_NEED_MULTIPLE_NODES
> -#define pfn_valid(pfn)		((pfn) < max_mapnr)
> -#endif
> -#endif
> -
>  #ifdef CONFIG_FLATMEM
>  
>  #define pfn_valid(pfn)		((pfn) < max_mapnr)
>  

In flatmem case, I would define pfn_valid like:

#define pfn_valid(pfn)          ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)

> +#elif defined(CONFIG_SPARSEMEM)
> +
> +/* pfn_valid is defined in linux/mmzone.h */
> +
>  #elif defined(CONFIG_NEED_MULTIPLE_NODES)

why not using:

#elif defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)

hence, we would have all memory model cases.

For now it seems to be implemented only in sgi-ip27 machine. Maybe we should
make things clear by adding:

#ifdef CONFIG_SGI_IP27
#define pfn_valid	[...]
#else
#error discontigmem model is only supported by sgi-ip27 platforms.
#error Please try to implement a generic solution if you plan to
#error use this memory model. Good luck ;)
#endif /* CONFIG_SGI_IP27 */

>  
>  #define pfn_valid(pfn)							\
> @@ -159,8 +157,6 @@ ({									\
>  	            : 0);						\
>  })
>  
> -#else
> -#error Provide a definition of pfn_valid
>  #endif

maybe this would be better too ?

#else

#error Unknow memory model, provide a definition of pfn_valid

#endif

>  
>  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> 
> 
