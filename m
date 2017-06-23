Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 23:47:47 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:36476
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993873AbdFWVrkK-eO- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 23:47:40 +0200
Received: by mail-pg0-x242.google.com with SMTP id e187so7567690pgc.3
        for <linux-mips@linux-mips.org>; Fri, 23 Jun 2017 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to
         :to:to:to:to:to:to:cc:subject:date:message-id;
        bh=ewzEJ1yh7IdsCyDP2RA8CWywzoEhVRtuOj6TXJEvVHE=;
        b=FwAxMlYafd1iLUxQqwpyZuOqD4q9cDLU4zy0MXgUSCdX1Vgy+lUdwX37nlEh4ANpO+
         isAODflz0oUQMUscjM8nmXnqybMOVvpcA2rllez9fzL8jH6E2I0p4nVDpW2bqlcQXBr3
         0hoMrAnteR68H6+nZz0xyQLGRsg70n7MlOfTxUsAdIWsWfN7KXyundL2KmiAUhwZ6t8s
         8bdT/Jsq3F9Ydgi5irk1aHatbjgI+Bs/KUUxbmk2vkYaMBpy+p/Cl8VdJX4j4EGwIl8p
         p/OtGOr98URgaePHoR9An6EdoEKnHNMu0AO32XIShQ/9BMXTNJ7dnJcBztA3PYRndK8E
         hOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:to
         :to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date:message-id;
        bh=ewzEJ1yh7IdsCyDP2RA8CWywzoEhVRtuOj6TXJEvVHE=;
        b=eiSGYvhKIwSWtHGkvAntcDbqn1Cvrbh5KncRZN6wkq/mVVAP+EzDj3sG8lnxDk7aon
         yvfsA7R4U1a6V4jGV6w5UCzTZmNFIMj4/4l8bPANg7YoWmdwTD5dlmpNdR5LmRodPmDz
         NAht0bRa+4nK+s7DGwPdmcLVYAk4keYyDkiMr9/fiIfqcRnE6gUrJ0S0E/X5T7kjfnMO
         /nDLa8BdvlkKeNLxD9EGVnRuCwO+hDUF9rMUTg1pFcsxelOaawC+7z/ouwc2inKjAeB0
         izwoDK31ASGou/E/03yVuA5eVgQTsh4uiOEraaiiEMn1S/5CtaViXWkJiNePkKnfoQGo
         7mVA==
X-Gm-Message-State: AKS2vOy+yZ0JPDAwVRc94peQknpkHXMLpdwsuU4LeFjUXRsqhMlh7dh2
        naF5lG2GQln/DzlG
X-Received: by 10.98.35.148 with SMTP id q20mr10063014pfj.237.1498254453932;
        Fri, 23 Jun 2017 14:47:33 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id g86sm12464361pfk.101.2017.06.23.14.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 14:47:33 -0700 (PDT)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rth@twiddle.net
To:     ink@jurassic.park.msu.ru
To:     mattst88@gmail.com
To:     vgupta@synopsys.com
To:     linux@armlinux.org.uk
To:     catalin.marinas@arm.com
To:     will.deacon@arm.com
To:     geert@linux-m68k.org
To:     ralf@linux-mips.org
To:     ysato@users.sourceforge.jp
To:     dalias@libc.org
To:     davem@davemloft.net
To:     cmetcalf@mellanox.com
To:     gxt@mprc.pku.edu.cn
To:     bhelgaas@google.com
To:     viro@zeniv.linux.org.uk
To:     akpm@linux-foundation.org
To:     linux-alpha@vger.kernel.org
To:     linux-kernel@vger.kernel.org
To:     linux-snps-arc@lists.infradead.org
To:     linux-arm-kernel@lists.infradead.org
To:     linux-m68k@lists.linux-m68k.org
To:     linux-mips@linux-mips.org
To:     linux-sh@vger.kernel.org
To:     sparclinux@vger.kernel.org
To:     linux-pci@vger.kernel.org
To:     hch@infradead.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Date:   Fri, 23 Jun 2017 14:45:38 -0700
Message-Id: <20170623214538.25967-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58771
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

We wanted to add RISC-V to the list of architectures that used the
generic PCI setup-irq.o inside the Makefile and it was suggested that
instead we define a Kconfig entry and use that.

I've done very minimal testing on this: I just checked to see that
an aarch64 defconfig still build setup-irq.o with the patch applied.
The intention is that this patch doesn't change the behavior of any
build.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/alpha/Kconfig     |  1 +
 arch/arc/Kconfig       |  1 +
 arch/arm/Kconfig       |  1 +
 arch/arm64/Kconfig     |  1 +
 arch/m68k/Kconfig      |  1 +
 arch/mips/Kconfig      |  1 +
 arch/sh/Kconfig        |  1 +
 arch/sparc/Kconfig     |  1 +
 arch/tile/Kconfig      |  1 +
 arch/unicore32/Kconfig |  1 +
 drivers/pci/Kconfig    |  3 +++
 drivers/pci/Makefile   | 11 +----------
 12 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 0e49d39ea74a..30f4e711f681 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -26,6 +26,7 @@ config ALPHA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
+	select PCI_GENERIC_SETUP
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index a5459698f0ee..dd1f64858118 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -44,6 +44,7 @@ config ARC
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
+	select PCI_GENERIC_SETUP
 
 config MIGHT_HAVE_PCI
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f15838..86872246951c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -96,6 +96,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select PCI_GENERIC_SETUP
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b2024db225a9..6c684d8c8816 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -115,6 +115,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select PCI_GENERIC_SETUP
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index d140206d5d29..c16214344f1c 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -22,6 +22,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select PCI_GENERIC_SETUP
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..474a7c710686 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,7 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_COPY_THREAD_TLS
+	select PCI_GENERIC_SETUP
 
 menu "Machine selection"
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ee086958b2b2..90a98ac526fb 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -48,6 +48,7 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select PCI_GENERIC_SETUP
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5639c9fe5b55..24cea64104bd 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -424,6 +424,7 @@ config SPARC_LEON
 	depends on SPARC32
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_DESC
+	select PCI_GENERIC_SETUP
 	---help---
 	  If you say Y here if you are running on a SPARC-LEON processor.
 	  The LEON processor is a synthesizable VHDL model of the
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 4583c0320059..6679af85a882 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -33,6 +33,7 @@ config TILE
 	select USER_STACKTRACE_SUPPORT
 	select USE_PMC if PERF_EVENTS
 	select VIRT_TO_BUS
+	select PCI_GENERIC_SETUP
 
 config MMU
 	def_bool y
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 0769066929c6..162a7d3def0c 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -18,6 +18,7 @@ config UNICORE32
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
+	select PCI_GENERIC_SETUP
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e0cacb7b8563..658c9f95ab3f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -131,6 +131,9 @@ config PCI_HYPERV
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_GENERIC_SETUP
+	def_bool n
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/dwc/Kconfig"
 source "drivers/pci/host/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 462c1f5f5546..26f4710c88ec 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -31,16 +31,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
 #
 # Some architectures use the generic PCI setup functions
 #
-obj-$(CONFIG_ALPHA) += setup-irq.o
-obj-$(CONFIG_ARC) += setup-irq.o
-obj-$(CONFIG_ARM) += setup-irq.o
-obj-$(CONFIG_ARM64) += setup-irq.o
-obj-$(CONFIG_UNICORE32) += setup-irq.o
-obj-$(CONFIG_SUPERH) += setup-irq.o
-obj-$(CONFIG_MIPS) += setup-irq.o
-obj-$(CONFIG_TILE) += setup-irq.o
-obj-$(CONFIG_SPARC_LEON) += setup-irq.o
-obj-$(CONFIG_M68K) += setup-irq.o
+obj-$(CONFIG_PCI_GENERIC_SETUP) += setup-irq.o
 
 #
 # ACPI Related PCI FW Functions
-- 
2.13.0
