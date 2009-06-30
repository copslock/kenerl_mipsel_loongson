Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 02:24:56 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:47196 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492093AbZF3AYr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jun 2009 02:24:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a495a130000>; Mon, 29 Jun 2009 20:19:31 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Jun 2009 17:18:55 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Jun 2009 17:18:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n5U0IqDX017745;
	Mon, 29 Jun 2009 17:18:52 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n5U0Ipu5017743;
	Mon, 29 Jun 2009 17:18:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Reorganize Cavium OCTEON PCI support.
Date:	Mon, 29 Jun 2009 17:18:51 -0700
Message-Id: <1246321131-17719-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 30 Jun 2009 00:18:54.0970 (UTC) FILETIME=[5A80EDA0:01C9F918]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Move the cavium PCI files to the arch/mips/pci directory.  Also
cleanup comment formatting and code layout.  Code from pci-common.c,
was moved into other files.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/Makefile                   |    4 -
 arch/mips/cavium-octeon/dma-octeon.c               |    2 +-
 arch/mips/cavium-octeon/pci-common.c               |  137 ------------------
 .../asm/octeon/pci-octeon.h}                       |   30 +++--
 arch/mips/pci/Makefile                             |    5 +
 .../mips/{cavium-octeon/msi.c => pci/msi-octeon.c} |   56 ++++----
 .../mips/{cavium-octeon/pci.c => pci/pci-octeon.c} |  147 +++++++++++++++++---
 .../{cavium-octeon/pcie.c => pci/pcie-octeon.c}    |   37 +++---
 8 files changed, 197 insertions(+), 221 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/pci-common.c
 rename arch/mips/{cavium-octeon/pci-common.h => include/asm/octeon/pci-octeon.h} (52%)
 rename arch/mips/{cavium-octeon/msi.c => pci/msi-octeon.c} (88%)
 rename arch/mips/{cavium-octeon/pci.c => pci/pci-octeon.c} (78%)
 rename arch/mips/{cavium-octeon/pcie.c => pci/pcie-octeon.c} (98%)

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 7c0528b..d6903c3 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -14,9 +14,5 @@ obj-y += dma-octeon.o flash_setup.o
 obj-y += octeon-memcpy.o
 
 obj-$(CONFIG_SMP)                     += smp.o
-obj-$(CONFIG_PCI)                     += pci-common.o
-obj-$(CONFIG_PCI)                     += pci.o
-obj-$(CONFIG_PCI)                     += pcie.o
-obj-$(CONFIG_PCI_MSI)                 += msi.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 627c162..4b92bfc 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -29,7 +29,7 @@
 #include <dma-coherence.h>
 
 #ifdef CONFIG_PCI
-#include "pci-common.h"
+#include <asm/octeon/pci-octeon.h>
 #endif
 
 #define BAR2_PCI_ADDRESS 0x8000000000ul
diff --git a/arch/mips/cavium-octeon/pci-common.c b/arch/mips/cavium-octeon/pci-common.c
deleted file mode 100644
index cd029f8..0000000
--- a/arch/mips/cavium-octeon/pci-common.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2005-2007 Cavium Networks
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/time.h>
-#include <linux/delay.h>
-#include "pci-common.h"
-
-typeof(pcibios_map_irq) *octeon_pcibios_map_irq;
-enum octeon_dma_bar_type octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_INVALID;
-
-/**
- * Map a PCI device to the appropriate interrupt line
- *
- * @param dev    The Linux PCI device structure for the device to map
- * @param slot   The slot number for this device on __BUS 0__. Linux
- *               enumerates through all the bridges and figures out the
- *               slot on Bus 0 where this device eventually hooks to.
- * @param pin    The PCI interrupt pin read from the device, then swizzled
- *               as it goes through each bridge.
- * @return Interrupt number for the device
- */
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (octeon_pcibios_map_irq)
-		return octeon_pcibios_map_irq(dev, slot, pin);
-	else
-		panic("octeon_pcibios_map_irq doesn't point to a "
-		      "pcibios_map_irq() function");
-}
-
-
-/**
- * Called to perform platform specific PCI setup
- *
- * @param dev
- * @return
- */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	uint16_t config;
-	uint32_t dconfig;
-	int pos;
-	/*
-	 * Force the Cache line setting to 64 bytes. The standard
-	 * Linux bus scan doesn't seem to set it. Octeon really has
-	 * 128 byte lines, but Intel bridges get really upset if you
-	 * try and set values above 64 bytes. Value is specified in
-	 * 32bit words.
-	 */
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 64 / 4);
-	/* Set latency timers for all devices */
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 48);
-
-	/* Enable reporting System errors and parity errors on all devices */
-	/* Enable parity checking and error reporting */
-	pci_read_config_word(dev, PCI_COMMAND, &config);
-	config |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-	pci_write_config_word(dev, PCI_COMMAND, config);
-
-	if (dev->subordinate) {
-		/* Set latency timers on sub bridges */
-		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 48);
-		/* More bridge error detection */
-		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &config);
-		config |= PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR;
-		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, config);
-	}
-
-	/* Enable the PCIe normal error reporting */
-	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (pos) {
-		/* Update Device Control */
-		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &config);
-		/* Correctable Error Reporting */
-		config |= PCI_EXP_DEVCTL_CERE;
-		/* Non-Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_NFERE;
-		/* Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_FERE;
-		/* Unsupported Request */
-		config |= PCI_EXP_DEVCTL_URRE;
-		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
-	}
-
-	/* Find the Advanced Error Reporting capability */
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-	if (pos) {
-		/* Clear Uncorrectable Error Status */
-		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
-				      &dconfig);
-		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
-				       dconfig);
-		/* Enable reporting of all uncorrectable errors */
-		/* Uncorrectable Error Mask - turned on bits disable errors */
-		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 0);
-		/*
-		 * Leave severity at HW default. This only controls if
-		 * errors are reported as uncorrectable or
-		 * correctable, not if the error is reported.
-		 */
-		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
-		/* Clear Correctable Error Status */
-		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &dconfig);
-		pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, dconfig);
-		/* Enable reporting of all correctable errors */
-		/* Correctable Error Mask - turned on bits disable errors */
-		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, 0);
-		/* Advanced Error Capabilities */
-		pci_read_config_dword(dev, pos + PCI_ERR_CAP, &dconfig);
-		/* ECRC Generation Enable */
-		if (config & PCI_ERR_CAP_ECRC_GENC)
-			config |= PCI_ERR_CAP_ECRC_GENE;
-		/* ECRC Check Enable */
-		if (config & PCI_ERR_CAP_ECRC_CHKC)
-			config |= PCI_ERR_CAP_ECRC_CHKE;
-		pci_write_config_dword(dev, pos + PCI_ERR_CAP, dconfig);
-		/* PCI_ERR_HEADER_LOG - Header Log Register (16 bytes) */
-		/* Report all errors to the root complex */
-		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND,
-				       PCI_ERR_ROOT_CMD_COR_EN |
-				       PCI_ERR_ROOT_CMD_NONFATAL_EN |
-				       PCI_ERR_ROOT_CMD_FATAL_EN);
-		/* Clear the Root status register */
-		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &dconfig);
-		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
-	}
-
-	return 0;
-}
diff --git a/arch/mips/cavium-octeon/pci-common.h b/arch/mips/include/asm/octeon/pci-octeon.h
similarity index 52%
rename from arch/mips/cavium-octeon/pci-common.h
rename to arch/mips/include/asm/octeon/pci-octeon.h
index 74ae799..6ac5d3e 100644
--- a/arch/mips/cavium-octeon/pci-common.h
+++ b/arch/mips/include/asm/octeon/pci-octeon.h
@@ -3,23 +3,29 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2007 Cavium Networks
+ * Copyright (C) 2005-2009 Cavium Networks
  */
-#ifndef __OCTEON_PCI_COMMON_H__
-#define __OCTEON_PCI_COMMON_H__
+
+#ifndef __PCI_OCTEON_H__
+#define __PCI_OCTEON_H__
 
 #include <linux/pci.h>
 
 /* Some PCI cards require delays when accessing config space. */
 #define PCI_CONFIG_SPACE_DELAY 10000
 
-/* pcibios_map_irq() is defined inside pci-common.c. All it does is call the
-   Octeon specific version pointed to by this variable. This function needs to
-   change for PCI or PCIe based hosts */
-extern typeof(pcibios_map_irq) *octeon_pcibios_map_irq;
+/*
+ * pcibios_map_irq() is defined inside pci-octeon.c. All it does is
+ * call the Octeon specific version pointed to by this variable. This
+ * function needs to change for PCI or PCIe based hosts.
+ */
+extern int (*octeon_pcibios_map_irq)(const struct pci_dev *dev,
+				     u8 slot, u8 pin);
 
-/* The following defines are only used when octeon_dma_bar_type =
-   OCTEON_DMA_BAR_TYPE_BIG */
+/*
+ * The following defines are used when octeon_dma_bar_type =
+ * OCTEON_DMA_BAR_TYPE_BIG
+ */
 #define OCTEON_PCI_BAR1_HOLE_BITS 5
 #define OCTEON_PCI_BAR1_HOLE_SIZE (1ul<<(OCTEON_PCI_BAR1_HOLE_BITS+3))
 
@@ -30,9 +36,9 @@ enum octeon_dma_bar_type {
 	OCTEON_DMA_BAR_TYPE_PCIE
 };
 
-/**
- * This is a variable to tell the DMA mapping system in dma-octeon.c
- * how to map PCI DMA addresses.
+/*
+ * This tells the DMA mapping system in dma-octeon.c how to map PCI
+ * DMA addresses.
  */
 extern enum octeon_dma_bar_type octeon_dma_bar_type;
 
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index e8a97f5..63d8a29 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -52,3 +52,8 @@ obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= pci-octeon.o pcie-octeon.o
+
+ifdef CONFIG_PCI_MSI
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= msi-octeon.o
+endif
diff --git a/arch/mips/cavium-octeon/msi.c b/arch/mips/pci/msi-octeon.c
similarity index 88%
rename from arch/mips/cavium-octeon/msi.c
rename to arch/mips/pci/msi-octeon.c
index 964b03b..03742e6 100644
--- a/arch/mips/cavium-octeon/msi.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2007 Cavium Networks
+ * Copyright (C) 2005-2009 Cavium Networks
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -16,8 +16,7 @@
 #include <asm/octeon/cvmx-pci-defs.h>
 #include <asm/octeon/cvmx-npei-defs.h>
 #include <asm/octeon/cvmx-pexp-defs.h>
-
-#include "pci-common.h"
+#include <asm/octeon/pci-octeon.h>
 
 /*
  * Each bit in msi_free_irq_bitmask represents a MSI interrupt that is
@@ -47,8 +46,8 @@ static DEFINE_SPINLOCK(msi_free_irq_bitmask_lock);
  * programming the MSI control bits [6:4] before calling
  * pci_enable_msi().
  *
- * @param dev    Device requesting MSI interrupts
- * @param desc   MSI descriptor
+ * @dev:    Device requesting MSI interrupts
+ * @desc:   MSI descriptor
  *
  * Returns 0 on success.
  */
@@ -213,14 +212,9 @@ void arch_teardown_msi_irq(unsigned int irq)
 }
 
 
-/**
+/*
  * Called by the interrupt handling code when an MSI interrupt
  * occurs.
- *
- * @param cpl
- * @param dev_id
- *
- * @return
  */
 static irqreturn_t octeon_msi_interrupt(int cpl, void *dev_id)
 {
@@ -256,31 +250,37 @@ static irqreturn_t octeon_msi_interrupt(int cpl, void *dev_id)
 }
 
 
-/**
+/*
  * Initializes the MSI interrupt handling code
- *
- * @return
  */
 int octeon_msi_initialize(void)
 {
-	int r;
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
-		r = request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
+		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
 				IRQF_SHARED,
-				"MSI[0:63]", octeon_msi_interrupt);
+				"MSI[0:63]", octeon_msi_interrupt))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
 	} else if (octeon_is_pci_host()) {
-		r = request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
+		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
 				IRQF_SHARED,
-				"MSI[0:15]", octeon_msi_interrupt);
-		r += request_irq(OCTEON_IRQ_PCI_MSI1, octeon_msi_interrupt,
-				 IRQF_SHARED,
-				 "MSI[16:31]", octeon_msi_interrupt);
-		r += request_irq(OCTEON_IRQ_PCI_MSI2, octeon_msi_interrupt,
-				 IRQF_SHARED,
-				 "MSI[32:47]", octeon_msi_interrupt);
-		r += request_irq(OCTEON_IRQ_PCI_MSI3, octeon_msi_interrupt,
-				 IRQF_SHARED,
-				 "MSI[48:63]", octeon_msi_interrupt);
+				"MSI[0:15]", octeon_msi_interrupt))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
+
+		if (request_irq(OCTEON_IRQ_PCI_MSI1, octeon_msi_interrupt,
+				IRQF_SHARED,
+				"MSI[16:31]", octeon_msi_interrupt))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI1) failed");
+
+		if (request_irq(OCTEON_IRQ_PCI_MSI2, octeon_msi_interrupt,
+				IRQF_SHARED,
+				"MSI[32:47]", octeon_msi_interrupt))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI2) failed");
+
+		if (request_irq(OCTEON_IRQ_PCI_MSI3, octeon_msi_interrupt,
+				IRQF_SHARED,
+				"MSI[48:63]", octeon_msi_interrupt))
+			panic("request_irq(OCTEON_IRQ_PCI_MSI3) failed");
+
 	}
 	return 0;
 }
diff --git a/arch/mips/cavium-octeon/pci.c b/arch/mips/pci/pci-octeon.c
similarity index 78%
rename from arch/mips/cavium-octeon/pci.c
rename to arch/mips/pci/pci-octeon.c
index 67c0ff5..9cb0c80 100644
--- a/arch/mips/cavium-octeon/pci.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2007 Cavium Networks
+ * Copyright (C) 2005-2009 Cavium Networks
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -17,8 +17,7 @@
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-npi-defs.h>
 #include <asm/octeon/cvmx-pci-defs.h>
-
-#include "pci-common.h"
+#include <asm/octeon/pci-octeon.h>
 
 #define USE_OCTEON_INTERNAL_ARBITER
 
@@ -54,6 +53,126 @@ union octeon_pci_address {
 	} s;
 };
 
+int __initdata (*octeon_pcibios_map_irq)(const struct pci_dev *dev,
+					 u8 slot, u8 pin);
+enum octeon_dma_bar_type octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_INVALID;
+
+/**
+ * Map a PCI device to the appropriate interrupt line
+ *
+ * @dev:    The Linux PCI device structure for the device to map
+ * @slot:   The slot number for this device on __BUS 0__. Linux
+ *               enumerates through all the bridges and figures out the
+ *               slot on Bus 0 where this device eventually hooks to.
+ * @pin:    The PCI interrupt pin read from the device, then swizzled
+ *               as it goes through each bridge.
+ * Returns Interrupt number for the device
+ */
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (octeon_pcibios_map_irq)
+		return octeon_pcibios_map_irq(dev, slot, pin);
+	else
+		panic("octeon_pcibios_map_irq not set.");
+}
+
+
+/*
+ * Called to perform platform specific PCI setup
+ */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	uint16_t config;
+	uint32_t dconfig;
+	int pos;
+	/*
+	 * Force the Cache line setting to 64 bytes. The standard
+	 * Linux bus scan doesn't seem to set it. Octeon really has
+	 * 128 byte lines, but Intel bridges get really upset if you
+	 * try and set values above 64 bytes. Value is specified in
+	 * 32bit words.
+	 */
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 64 / 4);
+	/* Set latency timers for all devices */
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 48);
+
+	/* Enable reporting System errors and parity errors on all devices */
+	/* Enable parity checking and error reporting */
+	pci_read_config_word(dev, PCI_COMMAND, &config);
+	config |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	pci_write_config_word(dev, PCI_COMMAND, config);
+
+	if (dev->subordinate) {
+		/* Set latency timers on sub bridges */
+		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 48);
+		/* More bridge error detection */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &config);
+		config |= PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, config);
+	}
+
+	/* Enable the PCIe normal error reporting */
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (pos) {
+		/* Update Device Control */
+		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &config);
+		/* Correctable Error Reporting */
+		config |= PCI_EXP_DEVCTL_CERE;
+		/* Non-Fatal Error Reporting */
+		config |= PCI_EXP_DEVCTL_NFERE;
+		/* Fatal Error Reporting */
+		config |= PCI_EXP_DEVCTL_FERE;
+		/* Unsupported Request */
+		config |= PCI_EXP_DEVCTL_URRE;
+		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
+	}
+
+	/* Find the Advanced Error Reporting capability */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (pos) {
+		/* Clear Uncorrectable Error Status */
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
+				      &dconfig);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
+				       dconfig);
+		/* Enable reporting of all uncorrectable errors */
+		/* Uncorrectable Error Mask - turned on bits disable errors */
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 0);
+		/*
+		 * Leave severity at HW default. This only controls if
+		 * errors are reported as uncorrectable or
+		 * correctable, not if the error is reported.
+		 */
+		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
+		/* Clear Correctable Error Status */
+		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &dconfig);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, dconfig);
+		/* Enable reporting of all correctable errors */
+		/* Correctable Error Mask - turned on bits disable errors */
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, 0);
+		/* Advanced Error Capabilities */
+		pci_read_config_dword(dev, pos + PCI_ERR_CAP, &dconfig);
+		/* ECRC Generation Enable */
+		if (config & PCI_ERR_CAP_ECRC_GENC)
+			config |= PCI_ERR_CAP_ECRC_GENE;
+		/* ECRC Check Enable */
+		if (config & PCI_ERR_CAP_ECRC_CHKC)
+			config |= PCI_ERR_CAP_ECRC_CHKE;
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, dconfig);
+		/* PCI_ERR_HEADER_LOG - Header Log Register (16 bytes) */
+		/* Report all errors to the root complex */
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND,
+				       PCI_ERR_ROOT_CMD_COR_EN |
+				       PCI_ERR_ROOT_CMD_NONFATAL_EN |
+				       PCI_ERR_ROOT_CMD_FATAL_EN);
+		/* Clear the Root status register */
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &dconfig);
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
+	}
+
+	return 0;
+}
+
 /**
  * Return the mapping of PCI device number to IRQ line. Each
  * character in the return string represents the interrupt
@@ -136,9 +255,8 @@ int __init octeon_pci_pcibios_map_irq(const struct pci_dev *dev,
 }
 
 
-/**
+/*
  * Read a value from configuration space
- *
  */
 static int octeon_read_config(struct pci_bus *bus, unsigned int devfn,
 			      int reg, int size, u32 *val)
@@ -174,15 +292,8 @@ static int octeon_read_config(struct pci_bus *bus, unsigned int devfn,
 }
 
 
-/**
+/*
  * Write a value to PCI configuration space
- *
- * @bus:
- * @devfn:
- * @reg:
- * @size:
- * @val:
- * Returns
  */
 static int octeon_write_config(struct pci_bus *bus, unsigned int devfn,
 			       int reg, int size, u32 val)
@@ -251,10 +362,8 @@ static struct pci_controller octeon_pci_controller = {
 };
 
 
-/**
+/*
  * Low level initialize the Octeon PCI controller
- *
- * Returns
  */
 static void octeon_pci_initialize(void)
 {
@@ -398,7 +507,7 @@ static void octeon_pci_initialize(void)
 		pci_int_arb_cfg.s.en = 1;	/* Internal arbiter enable */
 		cvmx_write_csr(CVMX_NPI_PCI_INT_ARB_CFG, pci_int_arb_cfg.u64);
 	}
-#endif				/* USE_OCTEON_INTERNAL_ARBITER */
+#endif	/* USE_OCTEON_INTERNAL_ARBITER */
 
 	/*
 	 * Preferrably written to 1 to set MLTD. [RDSATI,TRTAE,
@@ -457,10 +566,8 @@ static void octeon_pci_initialize(void)
 }
 
 
-/**
+/*
  * Initialize the Octeon PCI controller
- *
- * Returns
  */
 static int __init octeon_pci_setup(void)
 {
diff --git a/arch/mips/cavium-octeon/pcie.c b/arch/mips/pci/pcie-octeon.c
similarity index 98%
rename from arch/mips/cavium-octeon/pcie.c
rename to arch/mips/pci/pcie-octeon.c
index 49d1408..7526224 100644
--- a/arch/mips/cavium-octeon/pcie.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -18,8 +18,7 @@
 #include <asm/octeon/cvmx-pescx-defs.h>
 #include <asm/octeon/cvmx-pexp-defs.h>
 #include <asm/octeon/cvmx-helper-errata.h>
-
-#include "pci-common.h"
+#include <asm/octeon/pci-octeon.h>
 
 union cvmx_pcie_address {
 	uint64_t u64;
@@ -976,13 +975,13 @@ static int cvmx_pcie_rc_initialize(int pcie_port)
 /**
  * Map a PCI device to the appropriate interrupt line
  *
- * @param dev    The Linux PCI device structure for the device to map
- * @param slot   The slot number for this device on __BUS 0__. Linux
+ * @dev:    The Linux PCI device structure for the device to map
+ * @slot:   The slot number for this device on __BUS 0__. Linux
  *               enumerates through all the bridges and figures out the
  *               slot on Bus 0 where this device eventually hooks to.
- * @param pin    The PCI interrupt pin read from the device, then swizzled
+ * @pin:    The PCI interrupt pin read from the device, then swizzled
  *               as it goes through each bridge.
- * @return Interrupt number for the device
+ * Returns Interrupt number for the device
  */
 int __init octeon_pcie_pcibios_map_irq(const struct pci_dev *dev,
 				       u8 slot, u8 pin)
@@ -1025,12 +1024,12 @@ int __init octeon_pcie_pcibios_map_irq(const struct pci_dev *dev,
 /**
  * Read a value from configuration space
  *
- * @param bus
- * @param devfn
- * @param reg
- * @param size
- * @param val
- * @return
+ * @bus:
+ * @devfn:
+ * @reg:
+ * @size:
+ * @val:
+ * Returns
  */
 static inline int octeon_pcie_read_config(int pcie_port, struct pci_bus *bus,
 					  unsigned int devfn, int reg, int size,
@@ -1156,12 +1155,12 @@ static int octeon_pcie1_read_config(struct pci_bus *bus, unsigned int devfn,
 /**
  * Write a value to PCI configuration space
  *
- * @param bus
- * @param devfn
- * @param reg
- * @param size
- * @param val
- * @return
+ * @bus:
+ * @devfn:
+ * @reg:
+ * @size:
+ * @val:
+ * Returns
  */
 static inline int octeon_pcie_write_config(int pcie_port, struct pci_bus *bus,
 					   unsigned int devfn, int reg,
@@ -1254,7 +1253,7 @@ static struct pci_controller octeon_pcie1_controller = {
 /**
  * Initialize the Octeon PCIe controllers
  *
- * @return
+ * Returns
  */
 static int __init octeon_pcie_setup(void)
 {
-- 
1.6.0.6
