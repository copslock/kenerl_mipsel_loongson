Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 22:11:47 +0200 (CEST)
Received: from aserp2120.oracle.com ([141.146.126.78]:33888 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993588AbeDWULkANf4w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 22:11:40 +0200
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w3NKAwca142692;
        Mon, 23 Apr 2018 20:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=h8+gRPswEzHWO6iOV3W8nSxIgJN1mRDUM4l0c2VSnjU=;
 b=Naxc6Fo0OHIycPkI461YrD5Gp0RZI6LOOcuQOvbUvTfw0zT8PbzCSyOv17gFcesjKdWN
 bTQLaizHuUfowbs9X+VrJv861snkngm+Xw50qAAl0woZqtNz788eYSv9GYsQjKs/jiOL
 /sT6jeoh/kroPhT+B1qSSn/O+T1t2XVhMY3gSvmvjS+3aOjEFwPklor0RCRi8Eorg3yt
 r/bkhGMAFyL5vFXUnO0po93jhCoyiakqtzO8xnSZfC58DZXLUDgbyKeGDRI2TXOBQqun
 iMuaJHFLU3vyc22p0hqdYWXoYf8i02Nd5E2uY/wkMUraRbQNAjYAQN/X7lYVY1F8SjgI mA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2hfw9a723n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Apr 2018 20:11:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w3NKBUQR009575
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Apr 2018 20:11:30 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w3NKBTbR030840;
        Mon, 23 Apr 2018 20:11:29 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Apr 2018 13:11:29 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 085746A0057; Mon, 23 Apr 2018 16:11:27 -0400 (EDT)
Date:   Mon, 23 Apr 2018 16:11:27 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, sstabellini@kernel.org
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
 lib/Kconfig
Message-ID: <20180423201127.GC5215@char.us.oracle.com>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423170419.20330-12-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=821
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230201
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Mon, Apr 23, 2018 at 07:04:18PM +0200, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> indicate the architecture supports swiotlb at all, so that we can still
> make the usage optional for a few architectures that want this feature
> to be user selectable.

If I follow this select business this will enable it on ARM and x86 by default.

As such:
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig                |  4 +---
>  arch/arm64/Kconfig              |  5 ++---
>  arch/ia64/Kconfig               |  9 +--------
>  arch/mips/Kconfig               |  3 +++
>  arch/mips/cavium-octeon/Kconfig |  5 -----
>  arch/mips/loongson64/Kconfig    |  8 --------
>  arch/powerpc/Kconfig            |  9 ---------
>  arch/unicore32/mm/Kconfig       |  5 -----
>  arch/x86/Kconfig                | 14 +++-----------
>  lib/Kconfig                     | 15 +++++++++++++++
>  10 files changed, 25 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 90b81a3a28a7..f91f69174630 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -106,6 +106,7 @@ config ARM
>  	select REFCOUNT_FULL
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> +	select ARCH_HAS_SWIOTLB
>  	# Above selects are sorted alphabetically; please add new ones
>  	# according to that.  Thanks.
>  	help
> @@ -1773,9 +1774,6 @@ config SECCOMP
>  	  and the task is only allowed to execute a few safe syscalls
>  	  defined by each seccomp mode.
>  
> -config SWIOTLB
> -	bool
> -
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
>  	help
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4d924eb32e7f..056bc7365adf 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -21,6 +21,7 @@ config ARM64
>  	select ARCH_HAS_SG_CHAIN
>  	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_HAS_STRICT_MODULE_RWX
> +	select ARCH_HAS_SWIOTLB
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_INLINE_READ_LOCK if !PREEMPT
> @@ -144,6 +145,7 @@ config ARM64
>  	select POWER_SUPPLY
>  	select REFCOUNT_FULL
>  	select SPARSE_IRQ
> +	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
>  	help
> @@ -239,9 +241,6 @@ config HAVE_GENERIC_GUP
>  config SMP
>  	def_bool y
>  
> -config SWIOTLB
> -	def_bool y
> -
>  config KERNEL_MODE_NEON
>  	def_bool y
>  
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 685d557eea48..d396230913e6 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -56,6 +56,7 @@ config IA64
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select NEED_DMA_MAP_STATE
>  	select NEED_SG_DMA_LENGTH
> +	select ARCH_HAS_SWIOTLB
>  	default y
>  	help
>  	  The Itanium Processor Family is Intel's 64-bit successor to
> @@ -80,9 +81,6 @@ config MMU
>  	bool
>  	default y
>  
> -config SWIOTLB
> -       bool
> -
>  config STACKTRACE_SUPPORT
>  	def_bool y
>  
> @@ -139,7 +137,6 @@ config IA64_GENERIC
>  	bool "generic"
>  	select NUMA
>  	select ACPI_NUMA
> -	select DMA_DIRECT_OPS
>  	select SWIOTLB
>  	select PCI_MSI
>  	help
> @@ -160,7 +157,6 @@ config IA64_GENERIC
>  
>  config IA64_DIG
>  	bool "DIG-compliant"
> -	select DMA_DIRECT_OPS
>  	select SWIOTLB
>  
>  config IA64_DIG_VTD
> @@ -176,7 +172,6 @@ config IA64_HP_ZX1
>  
>  config IA64_HP_ZX1_SWIOTLB
>  	bool "HP-zx1/sx1000 with software I/O TLB"
> -	select DMA_DIRECT_OPS
>  	select SWIOTLB
>  	help
>  	  Build a kernel that runs on HP zx1 and sx1000 systems even when they
> @@ -200,7 +195,6 @@ config IA64_SGI_UV
>  	bool "SGI-UV"
>  	select NUMA
>  	select ACPI_NUMA
> -	select DMA_DIRECT_OPS
>  	select SWIOTLB
>  	help
>  	  Selecting this option will optimize the kernel for use on UV based
> @@ -211,7 +205,6 @@ config IA64_SGI_UV
>  
>  config IA64_HP_SIM
>  	bool "Ski-simulator"
> -	select DMA_DIRECT_OPS
>  	select SWIOTLB
>  	depends on !PM
>  
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e10cc5c7be69..b6b4c1e154f8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -912,6 +912,8 @@ config CAVIUM_OCTEON_SOC
>  	select MIPS_NR_CPU_NR_MAP_1024
>  	select BUILTIN_DTB
>  	select MTD_COMPLEX_MAPPINGS
> +	select ARCH_HAS_SWIOTLB
> +	select SWIOTLB
>  	select SYS_SUPPORTS_RELOCATABLE
>  	help
>  	  This option supports all of the Octeon reference boards from Cavium
> @@ -1367,6 +1369,7 @@ config CPU_LOONGSON3
>  	select MIPS_PGD_C0_CONTEXT
>  	select MIPS_L1_CACHE_SHIFT_6
>  	select GPIOLIB
> +	select ARCH_HAS_SWIOTLB
>  	help
>  		The Loongson 3 processor implements the MIPS64R2 instruction
>  		set with many extensions.
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index 5d73041547a7..4984e462be30 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -67,11 +67,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
>  	help
>  	  Lock the kernel's implementation of memcpy() into L2.
>  
> -config SWIOTLB
> -	def_bool y
> -	select DMA_DIRECT_OPS
> -	select NEED_SG_DMA_LENGTH
> -
>  config OCTEON_ILM
>  	tristate "Module to measure interrupt latency using Octeon CIU Timer"
>  	help
> diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> index 641a1477031e..c79e6a565572 100644
> --- a/arch/mips/loongson64/Kconfig
> +++ b/arch/mips/loongson64/Kconfig
> @@ -130,14 +130,6 @@ config LOONGSON_UART_BASE
>  	default y
>  	depends on EARLY_PRINTK || SERIAL_8250
>  
> -config SWIOTLB
> -	bool "Soft IOMMU Support for All-Memory DMA"
> -	default y
> -	depends on CPU_LOONGSON3
> -	select DMA_DIRECT_OPS
> -	select NEED_SG_DMA_LENGTH
> -	select NEED_DMA_MAP_STATE
> -
>  config PHYS48_TO_HT40
>  	bool
>  	default y if CPU_LOONGSON3
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a4b2ac7c3d2e..1887f8f86a77 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -474,15 +474,6 @@ config MPROFILE_KERNEL
>  	depends on PPC64 && CPU_LITTLE_ENDIAN
>  	def_bool !DISABLE_MPROFILE_KERNEL
>  
> -config SWIOTLB
> -	bool "SWIOTLB support"
> -	default n
> -	---help---
> -	  Support for IO bounce buffering for systems without an IOMMU.
> -	  This allows us to DMA to the full physical address space on
> -	  platforms where the size of a physical address is larger
> -	  than the bus address.  Not all platforms support this.
> -
>  config HOTPLUG_CPU
>  	bool "Support for enabling/disabling CPUs"
>  	depends on SMP && (PPC_PSERIES || \
> diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
> index 1d9fed0ada71..82759b6aba67 100644
> --- a/arch/unicore32/mm/Kconfig
> +++ b/arch/unicore32/mm/Kconfig
> @@ -39,8 +39,3 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
>  	default y
>  	help
>  	  Say Y here to disable the TLB single entry operations.
> -
> -config SWIOTLB
> -	def_bool y
> -	select DMA_DIRECT_OPS
> -	select NEED_SG_DMA_LENGTH
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 07b031f99eb1..7a5fec800992 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -24,6 +24,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
> +	select ARCH_HAS_SWIOTLB
>  	select ARCH_SUPPORTS_INT128
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select HAVE_ARCH_SOFT_DIRTY
> @@ -677,6 +678,7 @@ config STA2X11
>  	bool "STA2X11 Companion Chip Support"
>  	depends on X86_32_NON_STANDARD && PCI
>  	select ARCH_HAS_PHYS_TO_DMA
> +	select ARCH_HAS_SWIOTLB
>  	select X86_DEV_DMA_OPS
>  	select X86_DMA_REMAP
>  	select SWIOTLB
> @@ -916,17 +918,6 @@ config CALGARY_IOMMU_ENABLED_BY_DEFAULT
>  	  Calgary anyway, pass 'iommu=calgary' on the kernel command line.
>  	  If unsure, say Y.
>  
> -# need this always selected by IOMMU for the VIA workaround
> -config SWIOTLB
> -	def_bool y if X86_64
> -	select NEED_DMA_MAP_STATE
> -	---help---
> -	  Support for software bounce buffers used on x86-64 systems
> -	  which don't have a hardware IOMMU. Using this PCI devices
> -	  which can only access 32-bits of memory can be used on systems
> -	  with more than 3 GB of memory.
> -	  If unsure, say Y.
> -
>  config MAXSMP
>  	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
>  	depends on X86_64 && SMP && DEBUG_KERNEL
> @@ -1448,6 +1439,7 @@ config HIGHMEM
>  config X86_PAE
>  	bool "PAE (Physical Address Extension) Support"
>  	depends on X86_32 && !HIGHMEM4G
> +	select ARCH_HAS_SWIOTLB
>  	select PHYS_ADDR_T_64BIT
>  	select SWIOTLB
>  	---help---
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1f12faf03819..01a37920949c 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -451,6 +451,21 @@ config DMA_VIRT_OPS
>  	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
>  	default n
>  
> +config ARCH_HAS_SWIOTLB
> +	bool
> +
> +config SWIOTLB
> +	bool "SWIOTLB support"
> +	default ARCH_HAS_SWIOTLB
> +	select DMA_DIRECT_OPS
> +	select NEED_DMA_MAP_STATE
> +	select NEED_SG_DMA_LENGTH
> +	---help---
> +	  Support for IO bounce buffering for systems without an IOMMU.
> +	  This allows us to DMA to the full physical address space on
> +	  platforms where the size of a physical address is larger
> +	  than the bus address.  If unsure, say Y.
> +
>  config CHECK_SIGNATURE
>  	bool
>  
> -- 
> 2.17.0
> 
