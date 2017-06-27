Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 01:37:54 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993945AbdF0Xhoy500X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 01:37:44 +0200
Received: from localhost (unknown [69.71.4.159])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E42217C3;
        Tue, 27 Jun 2017 23:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E42217C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date:   Tue, 27 Jun 2017 18:37:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, geert@linux-m68k.org,
        ralf@linux-mips.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, cmetcalf@mellanox.com, gxt@mprc.pku.edu.cn,
        bhelgaas@google.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-ID: <20170627233740.GN17844@bhelgaas-glaptop.roam.corp.google.com>
References: <20170623214538.25967-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623214538.25967-1-palmer@dabbelt.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

[+cc Lorenzo]

Hi Palmer,

On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> We wanted to add RISC-V to the list of architectures that used the
> generic PCI setup-irq.o inside the Makefile and it was suggested that
> instead we define a Kconfig entry and use that.
> 
> I've done very minimal testing on this: I just checked to see that
> an aarch64 defconfig still build setup-irq.o with the patch applied.
> The intention is that this patch doesn't change the behavior of any
> build.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Lorenzo Pieralisi's "ARM/ARM64: remove pci_fixup_irqs() usage" series
overlaps with this quite a bit, and includes this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/enumeration&id=5b64036feff4

which makes it so we build setup-irq.o on *all* arches.  Can you check
out the pci/enumeration branch and see whether it accomplishes what
you need?

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/enumeration

> ---
>  arch/alpha/Kconfig     |  1 +
>  arch/arc/Kconfig       |  1 +
>  arch/arm/Kconfig       |  1 +
>  arch/arm64/Kconfig     |  1 +
>  arch/m68k/Kconfig      |  1 +
>  arch/mips/Kconfig      |  1 +
>  arch/sh/Kconfig        |  1 +
>  arch/sparc/Kconfig     |  1 +
>  arch/tile/Kconfig      |  1 +
>  arch/unicore32/Kconfig |  1 +
>  drivers/pci/Kconfig    |  3 +++
>  drivers/pci/Makefile   | 11 +----------
>  12 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 0e49d39ea74a..30f4e711f681 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -26,6 +26,7 @@ config ALPHA
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
>  	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
> +	select PCI_GENERIC_SETUP
>  	help
>  	  The Alpha is a 64-bit general-purpose processor designed and
>  	  marketed by the Digital Equipment Corporation of blessed memory,
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index a5459698f0ee..dd1f64858118 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -44,6 +44,7 @@ config ARC
>  	select HAVE_GENERIC_DMA_COHERENT
>  	select HAVE_KERNEL_GZIP
>  	select HAVE_KERNEL_LZMA
> +	select PCI_GENERIC_SETUP
>  
>  config MIGHT_HAVE_PCI
>  	bool
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4c1a35f15838..86872246951c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -96,6 +96,7 @@ config ARM
>  	select PERF_USE_VMALLOC
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> +	select PCI_GENERIC_SETUP
>  	# Above selects are sorted alphabetically; please add new ones
>  	# according to that.  Thanks.
>  	help
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b2024db225a9..6c684d8c8816 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -115,6 +115,7 @@ config ARM64
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select PCI_GENERIC_SETUP
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index d140206d5d29..c16214344f1c 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -22,6 +22,7 @@ config M68K
>  	select MODULES_USE_ELF_RELA
>  	select OLD_SIGSUSPEND3
>  	select OLD_SIGACTION
> +	select PCI_GENERIC_SETUP
>  
>  config RWSEM_GENERIC_SPINLOCK
>  	bool
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2828ecde133d..474a7c710686 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -70,6 +70,7 @@ config MIPS
>  	select HAVE_EXIT_THREAD
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_COPY_THREAD_TLS
> +	select PCI_GENERIC_SETUP
>  
>  menu "Machine selection"
>  
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index ee086958b2b2..90a98ac526fb 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -48,6 +48,7 @@ config SUPERH
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_NMI
> +	select PCI_GENERIC_SETUP
>  	help
>  	  The SuperH is a RISC processor targeted for use in embedded systems
>  	  and consumer electronics; it was also used in the Sega Dreamcast
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 5639c9fe5b55..24cea64104bd 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -424,6 +424,7 @@ config SPARC_LEON
>  	depends on SPARC32
>  	select USB_EHCI_BIG_ENDIAN_MMIO
>  	select USB_EHCI_BIG_ENDIAN_DESC
> +	select PCI_GENERIC_SETUP
>  	---help---
>  	  If you say Y here if you are running on a SPARC-LEON processor.
>  	  The LEON processor is a synthesizable VHDL model of the
> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 4583c0320059..6679af85a882 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -33,6 +33,7 @@ config TILE
>  	select USER_STACKTRACE_SUPPORT
>  	select USE_PMC if PERF_EVENTS
>  	select VIRT_TO_BUS
> +	select PCI_GENERIC_SETUP
>  
>  config MMU
>  	def_bool y
> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index 0769066929c6..162a7d3def0c 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -18,6 +18,7 @@ config UNICORE32
>  	select ARCH_WANT_FRAME_POINTERS
>  	select GENERIC_IOMAP
>  	select MODULES_USE_ELF_REL
> +	select PCI_GENERIC_SETUP
>  	help
>  	  UniCore-32 is 32-bit Instruction Set Architecture,
>  	  including a series of low-power-consumption RISC chip
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e0cacb7b8563..658c9f95ab3f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -131,6 +131,9 @@ config PCI_HYPERV
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
>  
> +config PCI_GENERIC_SETUP
> +	def_bool n
> +
>  source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/dwc/Kconfig"
>  source "drivers/pci/host/Kconfig"
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 462c1f5f5546..26f4710c88ec 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -31,16 +31,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
>  #
>  # Some architectures use the generic PCI setup functions
>  #
> -obj-$(CONFIG_ALPHA) += setup-irq.o
> -obj-$(CONFIG_ARC) += setup-irq.o
> -obj-$(CONFIG_ARM) += setup-irq.o
> -obj-$(CONFIG_ARM64) += setup-irq.o
> -obj-$(CONFIG_UNICORE32) += setup-irq.o
> -obj-$(CONFIG_SUPERH) += setup-irq.o
> -obj-$(CONFIG_MIPS) += setup-irq.o
> -obj-$(CONFIG_TILE) += setup-irq.o
> -obj-$(CONFIG_SPARC_LEON) += setup-irq.o
> -obj-$(CONFIG_M68K) += setup-irq.o
> +obj-$(CONFIG_PCI_GENERIC_SETUP) += setup-irq.o
>  
>  #
>  # ACPI Related PCI FW Functions
> -- 
> 2.13.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
