Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2014 14:09:02 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:56128 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817664AbaAINI61S8Ag (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jan 2014 14:08:58 +0100
Message-ID: <52CE9F12.3080205@imgtec.com>
Date:   Thu, 9 Jan 2014 13:07:30 +0000
From:   Alex Smith <alex.smith@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 09/12] MIPS: Loongson: Add Loongson-3 Kconfig options
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com> <1389149068-24376-10-git-send-email-chenhc@lemote.com>
In-Reply-To: <1389149068-24376-10-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.62]
X-SEF-Processed: 7_3_0_01192__2014_01_09_13_08_52
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

On 08/01/14 02:44, Huacai Chen wrote:
> Added Kconfig options include: Loongson-3 CPU and machine definition,
> CPU cache features, UEFI-like firmware interface (LEFI), HT-linked PCI,
> and big memory support.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>   arch/mips/Kconfig           |   29 +++++++++++++++++++++++++++-
>   arch/mips/loongson/Kconfig  |   44 +++++++++++++++++++++++++++++++++++++++++++
>   arch/mips/loongson/Platform |    1 +
>   3 files changed, 73 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 17cc7ff..513e941 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1487,6 +1487,18 @@ config CPU_LOONGSON2
>   	select CPU_SUPPORTS_HIGHMEM
>   	select CPU_SUPPORTS_HUGEPAGES
>
> +config CPU_LOONGSON3
> +	bool "Loongson 3 CPU"
> +	depends on SYS_HAS_CPU_LOONGSON3
> +	select CPU_SUPPORTS_64BIT_KERNEL
> +	select CPU_SUPPORTS_HIGHMEM
> +	select CPU_SUPPORTS_HUGEPAGES
> +	select WEAK_ORDERING
> +	select WEAK_REORDERING_BEYOND_LLSC
> +	help
> +		The Loongson 3 processor implements the MIPS III instruction set
> +		with many extensions.
> +

This should be moved into the "CPU type" choice block. Currently this 
appears as an option outside of that choice, and so it is possible to 
build a kernel without any CPU type selected.

Also, as Aurelien said on the previous version, shouldn't the comment be 
changed to MIPS64R2 rather than MIPS III even if you aren't selecting 
the MIPS64 CPU types for the time being? Note, if you replied to that 
comment I may not have seen it - I think the list is filtering your 
replies because they're HTML emails.

>   config CPU_LOONGSON1
>   	bool
>   	select CPU_MIPS32
> @@ -1513,6 +1526,10 @@ config SYS_HAS_CPU_LOONGSON2F
>   	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
>   	select CPU_SUPPORTS_UNCACHED_ACCELERATED
>
> +config SYS_HAS_CPU_LOONGSON3
> +	bool
> +	select CPU_SUPPORTS_CPUFREQ
> +
>   config SYS_HAS_CPU_LOONGSON1B
>   	bool
>
> @@ -1703,7 +1720,7 @@ choice
>
>   config PAGE_SIZE_4KB
>   	bool "4kB"
> -	depends on !CPU_LOONGSON2
> +	depends on !CPU_LOONGSON2 && !CPU_LOONGSON3
>   	help
>   	 This option select the standard 4kB Linux page size.  On some
>   	 R3000-family processors this is the only available page size.  Using
> @@ -2373,6 +2390,16 @@ config PCI
>   	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
>   	  say Y, otherwise N.
>
> +config HT_PCI
> +	bool "Support for HT-linked PCI"
> +	depends on CPU_LOONGSON3
> +	select PCI_DOMAINS
> +	help
> +	  Loongson family machines use Hyper-Transport bus for inter-core
> +	  connection and device connection. The PCI bus is a subordinate
> +	  linked at HT. Choose Y unless you are using Loongson 2E/2F based
> +	  machines.
> +

Should this default to y, given that it is selected in the defconfig? 
Also, the comment referring to 2E/2F is redundant given that it depends 
on CPU_LOONGSON3 and cannot be selected on those machines.

>   config PCI_DOMAINS
>   	bool
>
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index 263beb9..4f3967c 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -59,6 +59,33 @@ config LEMOTE_MACH2F
>
>   	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
>   	  LingLoong allinone PC and so forth.
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
> +	select SYS_SUPPORTS_64BIT_KERNEL
> +	select SYS_SUPPORTS_HIGHMEM
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select LOONGSON_MC146818
> +	select ZONE_DMA32 if 64BIT
> +	select LEFI_FIRMWARE_INTERFACE
> +	help
> +		Lemote Loongson 3A family machines utilize the 3A revision of
> +		Loongson processor and RS780/SBX00 chipset.
>   endchoice

Add "select NR_CPUS_DEFAULT_4" on here? Currently creating a 
configuration without using the loongson3_defconfig will default to 2, 
but unless I'm mistaken, all 3A machines are quad core?

>
>   config CS5536
> @@ -86,8 +114,24 @@ config LOONGSON_UART_BASE
>   	default y
>   	depends on EARLY_PRINTK || SERIAL_8250
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

Again, default to y?

Thanks,
Alex

>   config LOONGSON_MC146818
>   	bool
>   	default n
>
> +config LEFI_FIRMWARE_INTERFACE
> +	bool
> +
>   endif # MACH_LOONGSON
> diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
> index 29692e5..6205372 100644
> --- a/arch/mips/loongson/Platform
> +++ b/arch/mips/loongson/Platform
> @@ -30,3 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
>   cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
>   load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
>   load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
> +load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
>
