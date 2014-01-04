Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jan 2014 00:07:55 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:39979 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825865AbaADXHx3oK2N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Jan 2014 00:07:53 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1VzaJq-0000pO-SA; Sun, 05 Jan 2014 00:07:50 +0100
Date:   Sun, 5 Jan 2014 00:07:50 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 09/12] MIPS: Loongson: Add Loongson-3 Kconfig options
Message-ID: <20140104230750.GA20976@hall.aurel32.net>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-10-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1387109676-540-10-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Dec 15, 2013 at 08:14:33PM +0800, Huacai Chen wrote:
> Added Kconfig options include: Loongson-3 CPU and machine definition,
> CPU cache features, UEFI-like firmware interface, HT-linked PCI, and
> big memory support.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/Kconfig           |   29 ++++++++++++++++++++++++++++
>  arch/mips/loongson/Kconfig  |   44 +++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/loongson/Platform |    1 +
>  3 files changed, 74 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 17cc7ff..2c447a7 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1487,6 +1487,19 @@ config CPU_LOONGSON2
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_HUGEPAGES
>  
> +config CPU_LOONGSON3
> +	bool "Loongson 3 CPU"
> +	depends on SYS_HAS_CPU_LOONGSON3
> +	select CPU_SUPPORTS_32BIT_KERNEL

As said in patch 6, this doesn't seems to be correct, I think
CPU_SUPPORTS_32BIT_KERNEL should be removed.

> +	select CPU_SUPPORTS_64BIT_KERNEL
> +	select CPU_SUPPORTS_HIGHMEM
> +	select CPU_SUPPORTS_HUGEPAGES
> +	select WEAK_ORDERING
> +	select WEAK_REORDERING_BEYOND_LLSC
> +	help
> +		The Loongson 3 processor implements the MIPS III instruction set
> +		with many extensions.
> +

The Loongson 3A user's manual define this CPU as a MIPS64R2 instruction
set, and I have actually verified that all the MIPS64R2 instructions are
indeed listed in the manual. You should probably fix the description and
select the following options:

        select SYS_HAS_CPU_MIPS64_R1
        select SYS_HAS_CPU_MIPS64_R2

That way it's possible to enable the CPU_MIPS64_R1/2 options, compiling
the kernel with the corresponding instruction set. This should improve
the performances a bit.

>  config CPU_LOONGSON1
>  	bool
>  	select CPU_MIPS32
> @@ -1513,6 +1526,11 @@ config SYS_HAS_CPU_LOONGSON2F
>  	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
>  	select CPU_SUPPORTS_UNCACHED_ACCELERATED
>  
> +config SYS_HAS_CPU_LOONGSON3
> +	bool
> +	select CPU_SUPPORTS_CPUFREQ
> +	select CPU_SUPPORTS_COHERENT_CACHE
> +
>  config SYS_HAS_CPU_LOONGSON1B
>  	bool
>  
> @@ -1647,6 +1665,8 @@ config CPU_SUPPORTS_HUGEPAGES
>  	bool
>  config CPU_SUPPORTS_UNCACHED_ACCELERATED
>  	bool
> +config CPU_SUPPORTS_COHERENT_CACHE
> +	bool

What is this option about, it doesn't seems to be used in any of the
other patches of this serie.

>  config MIPS_PGD_C0_CONTEXT
>  	bool
>  	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
> @@ -2373,6 +2393,15 @@ config PCI
>  	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
>  	  say Y, otherwise N.
>  
> +config HT_PCI
> +	bool "Support for HT-linked PCI"
> +	select PCI_DOMAINS
> +	help
> +	  Loongson family machines use Hyper-Transport bus for inter-core
> +	  connection and device connection. The PCI bus is a subordinate
> +	  linked at HT. Choose Y unless you are using Loongson 2E/2F based
> +	  machines.
> +

This option is only useful on Loongson 3 machine. Right now it is
possible to select it for any machine, which is not correct. It should
be selectable only on Loongson 3 based CPU instead of adding that to the
description.

Actually it seems that this option is only used in
arch/mips/include/asm/mach-loongson/loongson.h, and should probably
simply be replaced by CONFIG_CPU_LOONGSON3 and this option dropped.

>  config PCI_DOMAINS
>  	bool
>  
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index 263beb9..91fa7cf 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -59,6 +59,34 @@ config LEMOTE_MACH2F
>  
>  	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
>  	  LingLoong allinone PC and so forth.
> +
> +config LEMOTE_MACH3A
> +	bool "Lemote Loongson 3A family machines"
> +	select ARCH_SPARSEMEM_ENABLE
> +	select GENERIC_ISA_DMA_SUPPORT_BROKEN
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
> +	select BOOT_ELF32
> +	select BOARD_SCACHE
> +	select CSRC_R4K
> +	select CEVT_R4K
> +	select CPU_HAS_WB
> +	select HW_HAS_PCI
> +	select ISA
> +	select I8259
> +	select IRQ_CPU
> +	select SYS_HAS_CPU_LOONGSON3
> +	select SYS_HAS_EARLY_PRINTK
> +	select SYS_SUPPORTS_SMP
> +	select SYS_SUPPORTS_32BIT_KERNEL

As said above, this is likely wrong.

> +	select SYS_SUPPORTS_64BIT_KERNEL
> +	select SYS_SUPPORTS_HIGHMEM
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select LOONGSON_MC146818
> +	select ZONE_DMA32 if 64BIT

The if 64BIT should probably be dropped.

> +	select UEFI_FIRMWARE_INTERFACE
> +	help
> +		Lemote Loongson 3A family machines utilize the 3A revision of
> +		Loongson processor and RS780/SBX00 chipset.

As said in patch 4, the name is likely incorrect and should be replaced
by something like PMON_FIRMWARE_INTERFACE.

>  endchoice
>  
>  config CS5536
> @@ -86,8 +114,24 @@ config LOONGSON_UART_BASE
>  	default y
>  	depends on EARLY_PRINTK || SERIAL_8250
>  
> +config IOMMU_HELPER
> +	bool
> +
> +config NEED_SG_DMA_LENGTH
> +	bool
> +
> +config SWIOTLB
> +	bool "Soft IOMMU Support for Big Memory (>4GB)"
> +	depends on CPU_LOONGSON3
> +	select IOMMU_HELPER
> +	select NEED_SG_DMA_LENGTH
> +	select NEED_DMA_MAP_STATE
> +
>  config LOONGSON_MC146818
>  	bool
>  	default n
>  
> +config UEFI_FIRMWARE_INTERFACE
> +	bool
> +
>  endif # MACH_LOONGSON
> diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
> index 29692e5..6205372 100644
> --- a/arch/mips/loongson/Platform
> +++ b/arch/mips/loongson/Platform
> @@ -30,3 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
>  cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
>  load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
>  load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
> +load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
> -- 
> 1.7.7.3
> 
> 
> 

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
