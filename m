Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:19:42 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:31248
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133380AbVJTGTX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:19:23 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9K6JMUI001320
	for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:19:22 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9K6JMTk001317;
	Wed, 19 Oct 2005 23:19:22 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.14058.40973.453640@dl2.hq2.avtrex.com>
Date:	Wed, 19 Oct 2005 23:19:22 -0700
To:	linux-mips@linux-mips.org
Subject: Patch: ATI Xilleon port 8/11 Integrate Xilleon port into build system
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the eighth part of my Xilleon port.

This patch adds the port into the kernel build system.

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Integrate xilleon port into build system.

---
commit dfc1311ed49b37741dc67cfcf3efcbf74f7e9165
tree 6b6460dd607e23874ec30e27b4163260f1e31ecb
parent 6b5bd66439cc3ba00c02e9bb4a97ce635d723459
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:54:17 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:54:17 -0700

 arch/mips/Kconfig      |   17 +++++++++++++++++
 arch/mips/Makefile     |   10 ++++++++++
 arch/mips/pci/Makefile |    1 +
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -14,6 +14,19 @@ choice
 	prompt "System type"
 	default SGI_IP22
 
+config ATI_XILLEON
+	bool "Support for ATI Xilleon"
+	select BOOT_ELF32
+	select DMA_NONCOHERENT
+	select GENERIC_ISA_DMA
+	select HW_HAS_PCI
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select PCIBIOS_OVERRIDE_RESOURCE
+	help
+	  This enables support for the ATI Xilleon processor.
+
 config MIPS_MTX1
 	bool "Support for 4G Systems MTX-1 board"
 	select DMA_NONCOHERENT
@@ -697,6 +710,7 @@ config TOSHIBA_RBTX4938
 
 endchoice
 
+source "arch/mips/ati/xilleon/Kconfig"
 source "arch/mips/ddb5xxx/Kconfig"
 source "arch/mips/gt64120/ev64120/Kconfig"
 source "arch/mips/jazz/Kconfig"
@@ -881,6 +895,9 @@ config SOC_PNX8550
 config SWAP_IO_SPACE
 	bool
 
+config PCIBIOS_OVERRIDE_RESOURCE
+	bool
+
 #
 # Unfortunately not all GT64120 systems run the chip at the same clock.
 # As the user for the clock rate and try to minimize the available options.
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -254,6 +254,16 @@ libs-$(CONFIG_SIBYTE_CFE)	+= arch/mips/s
 #
 
 #
+# ATI Xilleon
+#
+core-$(CONFIG_ATI_XILLEON)	+= arch/mips/ati/xilleon/
+ifdef CONFIG_LINUX_RAM_START
+load-$(CONFIG_ATI_XILLEON)	+= $(CONFIG_LINUX_RAM_START)
+else
+load-$(CONFIG_ATI_XILLEON)	+= 0xffffffff80100000
+endif
+
+#
 # Acer PICA 61, Mips Magnum 4000 and Olivetti M700.
 #
 core-$(CONFIG_MACH_JAZZ)	+= arch/mips/jazz/
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-tx4938.o ops-tx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
+obj-$(CONFIG_ATI_XILLEON)	+= ops-xilleon.o pci-xilleon.o
