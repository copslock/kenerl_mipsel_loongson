Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 12:38:06 +0100 (CET)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:32958 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011973AbbAULiEZ3q15 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 12:38:04 +0100
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id ibdx1p00326dK1R01bdx9K; Wed, 21 Jan 2015 11:37:57 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id ibdw1p00K0uk1nt01bdwAs; Wed, 21 Jan 2015 11:37:57 +0000
Message-ID: <54BF8F8C.4090209@gentoo.org>
Date:   Wed, 21 Jan 2015 06:37:48 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: R10000: Split R10000 definitions from R12000 and
 up
References: <54BCC6CB.7020804@gentoo.org>
In-Reply-To: <54BCC6CB.7020804@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421840277;
        bh=lv2fZmQFijdCYLJ69qXE2gF1Ta1JuSnXwzNAUSgxZbQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=UyNMscRMS49leVsG5xPDT7GRcSvrVUoUEsZ6h2FkH3KKS/bJgHFgKY71NOoqjPAGW
         cD2ZBDxpJ0rts1X2e/JpHXT44KrqACBIfatw/ZAJnsESa1afcmb5Venny/0mxX82Qi
         TFe3InoLynZ92YLHTT4oDijoDUYv4YQC1H2G6jSO7wftM057S+kBvjGjkO7IVXOD1C
         C3IRh7P4XfgyuHft98nF2+RrzFMX0UMd6xZUdB4zzYr6nLzPzxu0+mLG6dQZ0M9XaJ
         Fc5JQZXduy2n0F1dmPjef8N2Wgdwy5q8zpml3LJW50NOQGEAP4SV6MrERwNJGkdq6e
         YaphZMnBVrTxg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 01/19/2015 03:56, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
> 
> This patch splits the old R10000 definitions so that the R10000_LLSC_WAR can be
> disabled and -mno-fix-r10000 passed to CFLAGS for systems running R12000 CPUs
> and greater.  This allows the kernel to build without branch-likely
> instructions, which are considered deprecated in current MIPS implementations.
>  Only R10000 systems with R2.6 and lower CPUs require branch-likely to work
> around a known hardware errata item.

From the R16000 discussion, it appears I missed the bits in __get_cpu_type, so
ignore this patch for now.  I'll send another when I account for that function,
and double check I didn't miss any other R10K areas.

--J



> Verified on both an SGI Onyx2 and an SGI Octane.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/Kconfig                     |   18 +++++++++++++++++-
>  arch/mips/Makefile                    |    3 +++
>  arch/mips/include/asm/hazards.h       |    3 ++-
>  arch/mips/include/asm/mach-ip27/war.h |    7 ++++++-
>  arch/mips/include/asm/module.h        |    2 ++
>  arch/mips/sgi-ip27/Platform           |   15 ++++++++-------
>  arch/mips/sgi-ip32/Platform           |    2 ++
>  drivers/video/fbdev/gbefb.c           |    2 +-
>  8 files changed, 41 insertions(+), 11 deletions(-)
> 
> linux-mips-split-r10k-family.patch
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 73983e1..b526133 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -551,6 +551,7 @@ config SGI_IP27
>  	select HW_HAS_PCI
>  	select NR_CPUS_DEFAULT_64
>  	select SYS_HAS_CPU_R10000
> +	select SYS_HAS_CPU_R12K_R14K_R16K
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select SYS_SUPPORTS_NUMA
> @@ -612,6 +613,7 @@ config SGI_IP32
>  	select RM7000_CPU_SCACHE
>  	select SYS_HAS_CPU_R5000
>  	select SYS_HAS_CPU_R10000 if BROKEN
> +	select SYS_HAS_CPU_R12K_R14K_R16K if BROKEN
>  	select SYS_HAS_CPU_RM7000
>  	select SYS_HAS_CPU_NEVADA
>  	select SYS_SUPPORTS_64BIT_KERNEL
> @@ -1456,7 +1458,18 @@ config CPU_R10000
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_HUGEPAGES
>  	help
> -	  MIPS Technologies R10000-series processors.
> +	  MIPS Technologies R10000 processor.
> +
> +config CPU_R12K_R14K_R16K
> +	bool "R12k/R14k/R16k"
> +	depends on SYS_HAS_CPU_R12K_R14K_R16K
> +	select CPU_HAS_PREFETCH
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select CPU_SUPPORTS_64BIT_KERNEL
> +	select CPU_SUPPORTS_HIGHMEM
> +	select CPU_SUPPORTS_HUGEPAGES
> +	help
> +	  MIPS Technologies R12k/R14k/R16k-series processors.
>  
>  config CPU_RM7000
>  	bool "RM7000"
> @@ -1704,6 +1717,9 @@ config SYS_HAS_CPU_R8000
>  config SYS_HAS_CPU_R10000
>  	bool
>  
> +config SYS_HAS_CPU_R12K_R14K_R16K
> +	bool
> +
>  config SYS_HAS_CPU_RM7000
>  	bool
>  
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 37fce70..abccbb2 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -176,6 +176,9 @@ cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mips3d)
>  cflags-$(CONFIG_CPU_R8000)	+= -march=r8000 -Wa,--trap
>  cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
>  			-Wa,--trap
> +cflags-$(CONFIG_CPU_R12K_R14K_R16K)	+= $(call cc-option,-march=r12000,-march=r8000) \
> +			$(call cc-option,-mno-fix-r10000,) \
> +			-Wa,--trap
>  cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += $(call cc-option,-march=octeon) -Wa,--trap
>  ifeq (,$(findstring march=octeon, $(cflags-$(CONFIG_CPU_CAVIUM_OCTEON))))
>  cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
> diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
> index e3ee92d..0b565e5 100644
> --- a/arch/mips/include/asm/hazards.h
> +++ b/arch/mips/include/asm/hazards.h
> @@ -138,7 +138,8 @@ do {									\
>  
>  #elif defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
>  	defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
> -	defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_XLR)
> +	defined(CONFIG_CPU_R12K_R14K_R16K) || defined(CONFIG_CPU_R5500) || \
> +	defined(CONFIG_CPU_XLR)
>  
>  /*
>   * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
> diff --git a/arch/mips/include/asm/mach-ip27/war.h b/arch/mips/include/asm/mach-ip27/war.h
> index 4ee0e4b..e901a81 100644
> --- a/arch/mips/include/asm/mach-ip27/war.h
> +++ b/arch/mips/include/asm/mach-ip27/war.h
> @@ -18,7 +18,12 @@
>  #define MIPS_CACHE_SYNC_WAR		0
>  #define TX49XX_ICACHE_INDEX_INV_WAR	0
>  #define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			1
>  #define MIPS34K_MISSED_ITLB_WAR		0
>  
> +#ifdef CONFIG_CPU_R10000
> +#define R10000_LLSC_WAR			1
> +#else
> +#define R10000_LLSC_WAR			0
> +#endif
> +
>  #endif /* __ASM_MIPS_MACH_IP27_WAR_H */
> diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
> index 800fe57..394dee4 100644
> --- a/arch/mips/include/asm/module.h
> +++ b/arch/mips/include/asm/module.h
> @@ -118,6 +118,8 @@ search_module_dbetables(unsigned long addr)
>  #define MODULE_PROC_FAMILY "R8000 "
>  #elif defined CONFIG_CPU_R10000
>  #define MODULE_PROC_FAMILY "R10000 "
> +#elif defined CONFIG_CPU_R12K_R14K_R16K
> +#define MODULE_PROC_FAMILY "R12K/R14K/R16K "
>  #elif defined CONFIG_CPU_RM7000
>  #define MODULE_PROC_FAMILY "RM7000 "
>  #elif defined CONFIG_CPU_SB1
> diff --git a/arch/mips/sgi-ip27/Platform b/arch/mips/sgi-ip27/Platform
> index 1fb9c2e..4ad7060 100644
> --- a/arch/mips/sgi-ip27/Platform
> +++ b/arch/mips/sgi-ip27/Platform
> @@ -6,14 +6,15 @@
>  # be 16kb aligned or the handling of the current variable will break.
>  #
>  ifdef CONFIG_SGI_IP27
> -platform-$(CONFIG_SGI_IP27)	+= sgi-ip27/
> -cflags-$(CONFIG_SGI_IP27)	+= -I$(srctree)/arch/mips/include/asm/mach-ip27
> +platform-$(CONFIG_SGI_IP27)		+= sgi-ip27/
> +cflags-$(CONFIG_SGI_IP27)		+= -I$(srctree)/arch/mips/include/asm/mach-ip27
> +cflags-$(CONFIG_CPU_R12K_R14K_R16K)	+= -mno-fix-r10000
>  ifdef CONFIG_MAPPED_KERNEL
> -load-$(CONFIG_SGI_IP27)		+= 0xc00000004001c000
> -OBJCOPYFLAGS			:= --change-addresses=0x3fffffff80000000
> -dataoffset-$(CONFIG_SGI_IP27)	+= 0x01000000
> +load-$(CONFIG_SGI_IP27)			+= 0xc00000004001c000
> +OBJCOPYFLAGS				:= --change-addresses=0x3fffffff80000000
> +dataoffset-$(CONFIG_SGI_IP27)		+= 0x01000000
>  else
> -load-$(CONFIG_SGI_IP27)		+= 0xa80000000001c000
> -OBJCOPYFLAGS			:= --change-addresses=0x57ffffff80000000
> +load-$(CONFIG_SGI_IP27)			+= 0xa80000000001c000
> +OBJCOPYFLAGS				:= --change-addresses=0x57ffffff80000000
>  endif
>  endif
> diff --git a/arch/mips/sgi-ip32/Platform b/arch/mips/sgi-ip32/Platform
> index 0fea556..5899305 100644
> --- a/arch/mips/sgi-ip32/Platform
> +++ b/arch/mips/sgi-ip32/Platform
> @@ -8,4 +8,6 @@
>  #
>  platform-$(CONFIG_SGI_IP32)	+= sgi-ip32/
>  cflags-$(CONFIG_SGI_IP32)	+= -I$(srctree)/arch/mips/include/asm/mach-ip32
> +cflags-$(CONFIG_CPU_R10000)		+= -mr10k-cache-barrier=load-store
> +cflags-$(CONFIG_CPU_R12K_R14K_R16K)	+= -mno-fix-r10000 -mr10k-cache-barrier=load-store
>  load-$(CONFIG_SGI_IP32)		+= 0xffffffff80004000
> diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
> index 6d9ef39..c5dc991 100644
> --- a/drivers/video/fbdev/gbefb.c
> +++ b/drivers/video/fbdev/gbefb.c
> @@ -47,7 +47,7 @@ struct gbefb_par {
>  
>  /* macro for fastest write-though access to the framebuffer */
>  #ifdef CONFIG_MIPS
> -#ifdef CONFIG_CPU_R10000
> +#if defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_R12K_R14K_R16K)
>  #define pgprot_fb(_prot) (((_prot) & (~_CACHE_MASK)) | _CACHE_UNCACHED_ACCELERATED)
>  #else
>  #define pgprot_fb(_prot) (((_prot) & (~_CACHE_MASK)) | _CACHE_CACHABLE_NO_WA)
