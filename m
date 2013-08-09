Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 22:28:12 +0200 (CEST)
Received: from top.free-electrons.com ([176.31.233.9]:58101 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6865320Ab3HIU1eWWcJS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 22:27:34 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 0EA666CE7; Fri,  9 Aug 2013 22:27:39 +0200 (CEST)
Received: from localhost (unknown [37.161.232.130])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 34F996555;
        Fri,  9 Aug 2013 22:27:38 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>
Cc:     Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Maen Suleiman <maen@marvell.com>,
        Lior Amsalem <alior@marvell.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCHv9 02/10] PCI: remove ARCH_SUPPORTS_MSI kconfig option
Date:   Fri,  9 Aug 2013 22:27:07 +0200
Message-Id: <1376080035-29344-3-git-send-email-thomas.petazzoni@free-electrons.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Now that we have weak versions for each of the PCI MSI architecture
functions, we can actually build the MSI support for all platforms,
regardless of whether they provide or not architecture-specific
versions of those functions. For this reason, the ARCH_SUPPORTS_MSI
hidden kconfig boolean becomes useless, and this patch gets rid of it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tested-by: Daniel Price <daniel.price@gmail.com>
Tested-by: Thierry Reding <thierry.reding@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/arm/Kconfig     | 1 -
 arch/ia64/Kconfig    | 1 -
 arch/mips/Kconfig    | 2 --
 arch/powerpc/Kconfig | 1 -
 arch/s390/Kconfig    | 1 -
 arch/sparc/Kconfig   | 1 -
 arch/tile/Kconfig    | 1 -
 arch/x86/Kconfig     | 1 -
 drivers/pci/Kconfig  | 4 ----
 9 files changed, 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 37c0f4e..41b6c96 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -441,7 +441,6 @@ config ARCH_NETX
 config ARCH_IOP13XX
 	bool "IOP13xx-based"
 	depends on MMU
-	select ARCH_SUPPORTS_MSI
 	select CPU_XSC3
 	select NEED_MACH_MEMORY_H
 	select NEED_RET_TO_USER
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 5a768ad..098602b 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -9,7 +9,6 @@ config IA64
 	select PCI if (!IA64_HP_SIM)
 	select ACPI if (!IA64_HP_SIM)
 	select PM if (!IA64_HP_SIM)
-	select ARCH_SUPPORTS_MSI
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_IDE
 	select HAVE_OPROFILE
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c3abed3..01b5f5a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -726,7 +726,6 @@ config CAVIUM_OCTEON_SOC
 	select SYS_HAS_CPU_CAVIUM_OCTEON
 	select SWAP_IO_SPACE
 	select HW_HAS_PCI
-	select ARCH_SUPPORTS_MSI
 	select ZONE_DMA32
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
@@ -762,7 +761,6 @@ config NLM_XLR_BOARD
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_CPU
-	select ARCH_SUPPORTS_MSI
 	select ZONE_DMA32 if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3bf72cd..183a165 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -727,7 +727,6 @@ config PCI
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
-	select ARCH_SUPPORTS_MSI
 	select GENERIC_PCI_IOMAP
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 22f75b5..e9982a3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -428,7 +428,6 @@ menuconfig PCI
 	bool "PCI support"
 	default n
 	depends on 64BIT
-	select ARCH_SUPPORTS_MSI
 	select PCI_MSI
 	help
 	  Enable PCI support.
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a00cbd3..1570ad2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -52,7 +52,6 @@ config SPARC32
 
 config SPARC64
 	def_bool 64BIT
-	select ARCH_SUPPORTS_MSI
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_FP_TEST
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 24565a7..74dff90 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -380,7 +380,6 @@ config PCI
 	select PCI_DOMAINS
 	select GENERIC_PCI_IOMAP
 	select TILE_GXIO_TRIO if TILEGX
-	select ARCH_SUPPORTS_MSI if TILEGX
 	select PCI_MSI if TILEGX
 	---help---
 	  Enable PCI root complex support, so PCIe endpoint devices can
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b32ebf9..5db62ef 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2014,7 +2014,6 @@ menu "Bus options (PCI etc.)"
 config PCI
 	bool "PCI support"
 	default y
-	select ARCH_SUPPORTS_MSI if (X86_LOCAL_APIC && X86_IO_APIC)
 	---help---
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 81944fb..b6a99f7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -1,13 +1,9 @@
 #
 # PCI configuration
 #
-config ARCH_SUPPORTS_MSI
-	bool
-
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
-	depends on ARCH_SUPPORTS_MSI
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
-- 
1.8.1.2
