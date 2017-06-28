Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 02:14:34 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:36570
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993947AbdF1AO2BfQfX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 02:14:28 +0200
Received: by mail-pf0-x244.google.com with SMTP id z6so6654897pfk.3
        for <linux-mips@linux-mips.org>; Tue, 27 Jun 2017 17:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc
         :cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:subject:in-reply-to:message-id
         :mime-version;
        bh=81+rX+b5jlEfgCMuB00n/GFgeLAD5qGkCOkRvDsFQMs=;
        b=isuH1kCFIsgJg37yOimtQlckKGKKOa9NOeWv2FEjYf6WqqFI5zbD78xZXp6ka5O8mS
         N8OTYKhtYeHH53yNEslwOln07nFhWZD9OQTUNU7Pz+23BG+FGrm+ia3pF87Xp+elKt+i
         WUjm0gzNxy+wpnkAcIDootNUfgKQoX4jXPgg5NYzoa2C3xNGt1fJVK6pit0//b4NikwJ
         CbwCZhazf9d4iCEq+3twxAmFikU09pJAR9VRNqbSjnF8NNgF0CZKfXW6JQpgKoFlIDaI
         /mNn+RLQVOSOfx+OLuqqLjHs38GAaFDVR2TEdeRc+arZ7TaNd5hdTc8JGScI8K9ZNNq0
         rbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc
         :cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:subject:in-reply-to
         :message-id:mime-version;
        bh=81+rX+b5jlEfgCMuB00n/GFgeLAD5qGkCOkRvDsFQMs=;
        b=qh2Rnc6RAciLEXP73RMtMhMz43RSuZDaJEwSV86dXqrvgWcSslIx+uTHJevIFjs95E
         SiwlWlsky+ICcWOguxIOiqKiGMlnMCiMB9SjoSc0t8iqcbUCuEnpFJbxGDf2WRT3QYzL
         P0bfEIGURdWX8TA2Wi0sk1j77KoI5nTab6sZo5DeOtHk72Asn/jLsSOTUSnlGDuzrkFn
         SzKpizbxqiwKoiINAPdBkgNH0taBci27n/L+x6/+VjOAfJDtCmYtM6Zt2IL2HWGItJAO
         qSLHy3xOTv73ummL2i2SLj+EWOkaz6YwYPeFx74A/WutqK8iIEjrcXjhoXqUj5L5j8PW
         8slg==
X-Gm-Message-State: AKS2vOztAikF/fr2NQyHu4egzNlF1j6Phkc8qbuec0ZR5E0jlUOL1wEq
        4rDnmZdIcrQhmqNH
X-Received: by 10.98.16.12 with SMTP id y12mr7586546pfi.85.1498608861165;
        Tue, 27 Jun 2017 17:14:21 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id t23sm631725pgb.25.2017.06.27.17.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 17:14:20 -0700 (PDT)
Date:   Tue, 27 Jun 2017 17:14:20 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Jun 2017 17:14:16 PDT (-0700)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     helgaas@kernel.org
CC:     rth@twiddle.net
CC:     ink@jurassic.park.msu.ru
CC:     mattst88@gmail.com
CC:     vgupta@synopsys.com
CC:     linux@armlinux.org.uk
CC:     catalin.marinas@arm.com
CC:     will.deacon@arm.com
CC:     geert@linux-m68k.org
CC:     ralf@linux-mips.org
CC:     ysato@users.sourceforge.jp
CC:     dalias@libc.org
CC:     davem@davemloft.net
CC:     cmetcalf@mellanox.com
CC:     gxt@mprc.pku.edu.cn
CC:     bhelgaas@google.com
CC:     viro@zeniv.linux.org.uk
CC:     akpm@linux-foundation.org
CC:     linux-alpha@vger.kernel.org
CC:     linux-kernel@vger.kernel.org
CC:     linux-snps-arc@lists.infradead.org
CC:     linux-arm-kernel@lists.infradead.org
CC:     linux-m68k@lists.linux-m68k.org
CC:     linux-mips@linux-mips.org
CC:     linux-sh@vger.kernel.org
CC:     sparclinux@vger.kernel.org
CC:     linux-pci@vger.kernel.org
CC:     hch@infradead.org
CC:     lorenzo.pieralisi@arm.com
Subject:     Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
In-Reply-To: <20170627233740.GN17844@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <mhng-6085a11b-60d7-4b83-a40c-ee395a951e53@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

On Tue, 27 Jun 2017 16:37:40 PDT (-0700), helgaas@kernel.org wrote:
> [+cc Lorenzo]
>
> Hi Palmer,
>
> On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
>> We wanted to add RISC-V to the list of architectures that used the
>> generic PCI setup-irq.o inside the Makefile and it was suggested that
>> instead we define a Kconfig entry and use that.
>>
>> I've done very minimal testing on this: I just checked to see that
>> an aarch64 defconfig still build setup-irq.o with the patch applied.
>> The intention is that this patch doesn't change the behavior of any
>> build.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>
> Lorenzo Pieralisi's "ARM/ARM64: remove pci_fixup_irqs() usage" series
> overlaps with this quite a bit, and includes this patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/enumeration&id=5b64036feff4
>
> which makes it so we build setup-irq.o on *all* arches.  Can you check
> out the pci/enumeration branch and see whether it accomplishes what
> you need?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/enumeration

Great, that's even better for me, as I don't have to go touch a bunch of
different arch code :).  We'll use that instead when it lands.

Thanks!

>
>> ---
>>  arch/alpha/Kconfig     |  1 +
>>  arch/arc/Kconfig       |  1 +
>>  arch/arm/Kconfig       |  1 +
>>  arch/arm64/Kconfig     |  1 +
>>  arch/m68k/Kconfig      |  1 +
>>  arch/mips/Kconfig      |  1 +
>>  arch/sh/Kconfig        |  1 +
>>  arch/sparc/Kconfig     |  1 +
>>  arch/tile/Kconfig      |  1 +
>>  arch/unicore32/Kconfig |  1 +
>>  drivers/pci/Kconfig    |  3 +++
>>  drivers/pci/Makefile   | 11 +----------
>>  12 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
>> index 0e49d39ea74a..30f4e711f681 100644
>> --- a/arch/alpha/Kconfig
>> +++ b/arch/alpha/Kconfig
>> @@ -26,6 +26,7 @@ config ALPHA
>>  	select ODD_RT_SIGACTION
>>  	select OLD_SIGSUSPEND
>>  	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
>> +	select PCI_GENERIC_SETUP
>>  	help
>>  	  The Alpha is a 64-bit general-purpose processor designed and
>>  	  marketed by the Digital Equipment Corporation of blessed memory,
>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>> index a5459698f0ee..dd1f64858118 100644
>> --- a/arch/arc/Kconfig
>> +++ b/arch/arc/Kconfig
>> @@ -44,6 +44,7 @@ config ARC
>>  	select HAVE_GENERIC_DMA_COHERENT
>>  	select HAVE_KERNEL_GZIP
>>  	select HAVE_KERNEL_LZMA
>> +	select PCI_GENERIC_SETUP
>>
>>  config MIGHT_HAVE_PCI
>>  	bool
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 4c1a35f15838..86872246951c 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -96,6 +96,7 @@ config ARM
>>  	select PERF_USE_VMALLOC
>>  	select RTC_LIB
>>  	select SYS_SUPPORTS_APM_EMULATION
>> +	select PCI_GENERIC_SETUP
>>  	# Above selects are sorted alphabetically; please add new ones
>>  	# according to that.  Thanks.
>>  	help
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b2024db225a9..6c684d8c8816 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -115,6 +115,7 @@ config ARM64
>>  	select SPARSE_IRQ
>>  	select SYSCTL_EXCEPTION_TRACE
>>  	select THREAD_INFO_IN_TASK
>> +	select PCI_GENERIC_SETUP
>>  	help
>>  	  ARM 64-bit (AArch64) Linux support.
>>
>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>> index d140206d5d29..c16214344f1c 100644
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -22,6 +22,7 @@ config M68K
>>  	select MODULES_USE_ELF_RELA
>>  	select OLD_SIGSUSPEND3
>>  	select OLD_SIGACTION
>> +	select PCI_GENERIC_SETUP
>>
>>  config RWSEM_GENERIC_SPINLOCK
>>  	bool
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 2828ecde133d..474a7c710686 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -70,6 +70,7 @@ config MIPS
>>  	select HAVE_EXIT_THREAD
>>  	select HAVE_REGS_AND_STACK_ACCESS_API
>>  	select HAVE_COPY_THREAD_TLS
>> +	select PCI_GENERIC_SETUP
>>
>>  menu "Machine selection"
>>
>> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
>> index ee086958b2b2..90a98ac526fb 100644
>> --- a/arch/sh/Kconfig
>> +++ b/arch/sh/Kconfig
>> @@ -48,6 +48,7 @@ config SUPERH
>>  	select HAVE_ARCH_AUDITSYSCALL
>>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>>  	select HAVE_NMI
>> +	select PCI_GENERIC_SETUP
>>  	help
>>  	  The SuperH is a RISC processor targeted for use in embedded systems
>>  	  and consumer electronics; it was also used in the Sega Dreamcast
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 5639c9fe5b55..24cea64104bd 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -424,6 +424,7 @@ config SPARC_LEON
>>  	depends on SPARC32
>>  	select USB_EHCI_BIG_ENDIAN_MMIO
>>  	select USB_EHCI_BIG_ENDIAN_DESC
>> +	select PCI_GENERIC_SETUP
>>  	---help---
>>  	  If you say Y here if you are running on a SPARC-LEON processor.
>>  	  The LEON processor is a synthesizable VHDL model of the
>> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
>> index 4583c0320059..6679af85a882 100644
>> --- a/arch/tile/Kconfig
>> +++ b/arch/tile/Kconfig
>> @@ -33,6 +33,7 @@ config TILE
>>  	select USER_STACKTRACE_SUPPORT
>>  	select USE_PMC if PERF_EVENTS
>>  	select VIRT_TO_BUS
>> +	select PCI_GENERIC_SETUP
>>
>>  config MMU
>>  	def_bool y
>> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
>> index 0769066929c6..162a7d3def0c 100644
>> --- a/arch/unicore32/Kconfig
>> +++ b/arch/unicore32/Kconfig
>> @@ -18,6 +18,7 @@ config UNICORE32
>>  	select ARCH_WANT_FRAME_POINTERS
>>  	select GENERIC_IOMAP
>>  	select MODULES_USE_ELF_REL
>> +	select PCI_GENERIC_SETUP
>>  	help
>>  	  UniCore-32 is 32-bit Instruction Set Architecture,
>>  	  including a series of low-power-consumption RISC chip
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index e0cacb7b8563..658c9f95ab3f 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -131,6 +131,9 @@ config PCI_HYPERV
>>            The PCI device frontend driver allows the kernel to import arbitrary
>>            PCI devices from a PCI backend to support PCI driver domains.
>>
>> +config PCI_GENERIC_SETUP
>> +	def_bool n
>> +
>>  source "drivers/pci/hotplug/Kconfig"
>>  source "drivers/pci/dwc/Kconfig"
>>  source "drivers/pci/host/Kconfig"
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 462c1f5f5546..26f4710c88ec 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -31,16 +31,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
>>  #
>>  # Some architectures use the generic PCI setup functions
>>  #
>> -obj-$(CONFIG_ALPHA) += setup-irq.o
>> -obj-$(CONFIG_ARC) += setup-irq.o
>> -obj-$(CONFIG_ARM) += setup-irq.o
>> -obj-$(CONFIG_ARM64) += setup-irq.o
>> -obj-$(CONFIG_UNICORE32) += setup-irq.o
>> -obj-$(CONFIG_SUPERH) += setup-irq.o
>> -obj-$(CONFIG_MIPS) += setup-irq.o
>> -obj-$(CONFIG_TILE) += setup-irq.o
>> -obj-$(CONFIG_SPARC_LEON) += setup-irq.o
>> -obj-$(CONFIG_M68K) += setup-irq.o
>> +obj-$(CONFIG_PCI_GENERIC_SETUP) += setup-irq.o
>>
>>  #
>>  # ACPI Related PCI FW Functions
>> --
>> 2.13.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
