Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 16:43:42 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:55997 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492871AbZKKPnf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 16:43:35 +0100
Received: by fxm3 with SMTP id 3so1139359fxm.24
        for <multiple recipients>; Wed, 11 Nov 2009 07:43:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=T7ZI8Wxf2ekm4MaD4CTShbJZxFjosv1LfFi6lgei/mw=;
        b=wL79VnczCHPSGuHLIsxDI5OdsmOJ7APYJB0wIqRBbqLpYy12dgKtOKPV5Nh2oIneGU
         BrJfHh5QxZrhbu737qbSSANc3Tq5FC7KWIulzTl46JYFGXX5A2lPrVhFC8lNmi9+rScK
         Qvjex0yNz4jPOVxKnRFkBDNUDzNCPBDqGwpRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=l/QEuKkt7PIs2aI32bXd1W7mZOVp2zwo1NiyYc9JrB43m+oc8/hyDgjtsfIiZWFUP6
         uU6VqjlCLWv/6QIGZ27hd9YCrEen0Bve1l3sg8WVEacuaOshKIG37kyNRoKDiETtwzt2
         TcFHb7ieRnemG0AznRSJCnK3NfDh5L+9TJf8U=
Received: by 10.216.86.206 with SMTP id w56mr547780wee.1.1257954209236;
        Wed, 11 Nov 2009 07:43:29 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id u14sm5412579gvf.18.2009.11.11.07.43.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 07:43:27 -0800 (PST)
Subject: Re: [PATCH -queue 2/2] [loongson] 2f: Cleanups of the #if clauses
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <367b02daf305474f0bf59b995c27d6a5aaa2e962.1257917611.git.wuzhangjin@gmail.com>
References: <cover.1257917611.git.wuzhangjin@gmail.com>
	 <1cb2ae6fba2acd5e5d276f49f5b734876859e589.1257917611.git.wuzhangjin@gmail.com>
	 <367b02daf305474f0bf59b995c27d6a5aaa2e962.1257917611.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 23:43:23 +0800
Message-ID: <1257954203.7308.35.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Could you please apply this one?

This is needed by the coming CPUFreq and Suspend patchset, I plan to
resend them respectively after incorporating their feedbacks.

Thanks & Regards,
	Wu Zhangjin

On Wed, 2009-11-11 at 13:39 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds two new kernel options: CPU_SUPPORT_CPUFREQ and
> CPU_SUPPORT_ADDRWINCFG to describe the new features of loongons2f, and
> replaces the several ugly #if clauses by them.
> 
> These two options will be utilized by the future loongson revisions
> and/or by the relative drivers, such as the coming Loongson2F CPUFreq
> driver.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Kconfig                              |    8 ++++++++
>  arch/mips/include/asm/mach-loongson/loongson.h |    6 +++---
>  arch/mips/include/asm/mach-loongson/pci.h      |    4 ++--
>  arch/mips/loongson/common/init.c               |    2 +-
>  arch/mips/loongson/common/mem.c                |    8 ++++----
>  arch/mips/loongson/common/pci.c                |    2 +-
>  6 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 240a3ca..539c384 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1318,8 +1318,16 @@ config CPU_LOONGSON2
>  config SYS_HAS_CPU_LOONGSON2E
>  	bool
>  
> +config CPU_SUPPORT_CPUFREQ
> +	bool
> +
> +config CPU_SUPPORT_ADDRWINCFG
> +	bool
> +
>  config SYS_HAS_CPU_LOONGSON2F
>  	bool
> +	select CPU_SUPPORT_CPUFREQ
> +	select CPU_SUPPORT_ADDRWINCFG if 64BIT
>  
>  config SYS_HAS_CPU_MIPS32_R1
>  	bool
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
> index 5b83bea..008c768 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -227,7 +227,7 @@ extern void mach_irq_dispatch(unsigned int pending);
>  	((((ADDR)>>26) & LOONGSON_PCIMAP_PCIMAP_LO0) << ((WIN)*6))
>  
>  /* Chip Config */
> -#ifdef CONFIG_CPU_LOONGSON2F
> +#ifdef CONFIG_CPU_SUPPORT_CPUFREQ
>  #define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
>  #endif
>  
> @@ -236,7 +236,7 @@ extern void mach_irq_dispatch(unsigned int pending);
>   *
>   * loongson2e do not have this module
>   */
> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> +#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
>  
>  /* address window config module base address */
>  #define LOONGSON_ADDRWINCFG_BASE		0x3ff00000ul
> @@ -306,6 +306,6 @@ extern unsigned long _loongson_addrwincfg_base;
>  #define LOONGSON_ADDRWIN_PCITODDR(win, src, dst, size) \
>  	LOONGSON_ADDRWIN_CFG(PCIDMA, DDR, win, src, dst, size)
>  
> -#endif	/* ! CONFIG_CPU_LOONGSON2F && CONFIG_64BIT */
> +#endif	/* ! CONFIG_CPU_SUPPORT_ADDRWINCFG */
>  
>  #endif /* __ASM_MACH_LOONGSON_LOONGSON_H */
> diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
> index 31ba908..a2b78fa 100644
> --- a/arch/mips/include/asm/mach-loongson/pci.h
> +++ b/arch/mips/include/asm/mach-loongson/pci.h
> @@ -28,7 +28,7 @@ extern struct pci_ops loongson_pci_ops;
>  /* this is an offset from mips_io_port_base */
>  #define LOONGSON_PCI_IO_START	0x00004000UL
>  
> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> +#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
>  
>  /*
>   * we use address window2 to map cpu address space to pci space
> @@ -56,6 +56,6 @@ extern struct pci_ops loongson_pci_ops;
>  /* this is an offset from mips_io_port_base */
>  #define LOONGSON_PCI_IO_START	0x00004000UL
>  
> -#endif	/* !(defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT))*/
> +#endif	/* !CONFIG_CPU_SUPPORT_ADDRWINCFG */
>  
>  #endif /* !__ASM_MACH_LOONGSON_PCI_H_ */
> diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
> index 743d357..000bebd 100644
> --- a/arch/mips/loongson/common/init.c
> +++ b/arch/mips/loongson/common/init.c
> @@ -21,7 +21,7 @@ void __init prom_init(void)
>  	set_io_port_base((unsigned long)
>  		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
>  
> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> +#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
>  	_loongson_addrwincfg_base = (unsigned long)
>  		ioremap(LOONGSON_ADDRWINCFG_BASE, LOONGSON_ADDRWINCFG_SIZE);
>  #endif
> diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
> index 312c765..467a91e 100644
> --- a/arch/mips/loongson/common/mem.c
> +++ b/arch/mips/loongson/common/mem.c
> @@ -21,8 +21,7 @@ void __init prom_init_memory(void)
>  	add_memory_region(memsize << 20,
>  			LOONGSON_PCI_MEM_START - (memsize << 20),
>  			  BOOT_MEM_RESERVED);
> -#ifdef CONFIG_64BIT
> -#ifdef CONFIG_CPU_LOONGSON2F
> +#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
>  	{
>  		int bit;
>  
> @@ -37,8 +36,9 @@ void __init prom_init_memory(void)
>  					  0x80000000ul, (1 << bit));
>  		mmiowb();
>  	}
> -#endif				/* CONFIG_CPU_LOONGSON2F */
> +#endif				/* !CONFIG_CPU_SUPPORT_ADDRWINCFG */
>  
> +#ifdef CONFIG_64BIT
>  	if (highmemsize > 0)
>  		add_memory_region(LOONGSON_HIGHMEM_START,
>  				  highmemsize << 20, BOOT_MEM_RAM);
> @@ -46,7 +46,7 @@ void __init prom_init_memory(void)
>  	add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START -
>  			  LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
>  
> -#endif				/* CONFIG_64BIT */
> +#endif				/* !CONFIG_64BIT */
>  }
>  
>  /* override of arch/mips/mm/cache.c: __uncached_access */
> diff --git a/arch/mips/loongson/common/pci.c b/arch/mips/loongson/common/pci.c
> index eac43b8..cc3fa17 100644
> --- a/arch/mips/loongson/common/pci.c
> +++ b/arch/mips/loongson/common/pci.c
> @@ -68,7 +68,7 @@ static void __init setup_pcimap(void)
>  	deassert for some broken device */
>  	LOONGSON_PXARB_CFG = 0x00fe0105ul;
>  
> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> +#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
>  	/*
>  	 * set cpu addr window2 to map CPU address space to PCI address space
>  	 */
