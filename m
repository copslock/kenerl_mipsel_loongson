Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:18:45 +0100 (CET)
Received: from woodpecker.gentoo.org ([IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4]:36209
        "EHLO smtp.gentoo.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbdBGGOSWtqzr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 07:14:18 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 47A093416AA;
        Tue,  7 Feb 2017 06:14:11 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 11/12] MIPS: IP27: Update IRQ code to work with the new BRIDGE code
Date:   Tue,  7 Feb 2017 01:13:55 -0500
Message-Id: <20170207061356.8270-12-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56685
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

From: Joshua Kinard <kumba@gentoo.org>

Sparsely update just enough of the existing IP27 code so that the
machine will boot against the newer Xtalk/BRIDGE code.   A future
patch series will completely rewrite a majority of the existing IP27
code.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/pci/pci-bridge.c        | 11 +++++
 arch/mips/sgi-ip27/ip27-irq-pci.c | 72 +++++++++++++++++------------
 arch/mips/sgi-ip27/ip27-irq.c     |  5 ++
 3 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/arch/mips/pci/pci-bridge.c b/arch/mips/pci/pci-bridge.c
index 28b0eb5b844e..9df13ce313b5 100644
--- a/arch/mips/pci/pci-bridge.c
+++ b/arch/mips/pci/pci-bridge.c
@@ -274,6 +274,17 @@ bridge_disable_swapping_dma(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
 			bridge_disable_swapping_dma);
 
+#if 0
+/*
+ * XXX: Onyx2 systems have a RAD1 on their IO6-G board, but the RAD1 driver
+ * and corresponding defines are part of the IP30 patchset, so we need to
+ * make this part conditional for now until the IP30 patches are merged
+ * upstream.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_RAD1,
+			bridge_disable_swapping_dma);
+#endif
+
 /* XXX: Temporarily defined here until the IP27 "mega update". */
 #ifdef CONFIG_NUMA
 /**
diff --git a/arch/mips/sgi-ip27/ip27-irq-pci.c b/arch/mips/sgi-ip27/ip27-irq-pci.c
index 2a1c40784bd9..957b689b35f4 100644
--- a/arch/mips/sgi-ip27/ip27-irq-pci.c
+++ b/arch/mips/sgi-ip27/ip27-irq-pci.c
@@ -134,45 +134,56 @@ static int intr_disconnect_level(int cpu, int bit)
 /* Startup one of the (PCI ...) IRQs routes over a bridge.  */
 static unsigned int startup_bridge_irq(struct irq_data *d)
 {
+	u32 slot, reg;
 	struct bridge_controller *bc;
-	bridgereg_t device;
-	bridge_t *bridge;
-	int pin, swlevel;
+	int swlevel;
 	cpuid_t cpu;
 
-	pin = SLOT_FROM_PCI_IRQ(d->irq);
+	slot = SLOT_FROM_PCI_IRQ(d->irq);
 	bc = IRQ_TO_BRIDGE(d->irq);
-	bridge = bc->base;
 
-	pr_debug("bridge_startup(): irq= 0x%x  pin=%d\n", d->irq, pin);
+	pr_debug("bridge_startup(): irq= 0x%x  pin=%d\n", d->irq, slot);
 	/*
 	 * "map" irq to a swlevel greater than 6 since the first 6 bits
 	 * of INT_PEND0 are taken
 	 */
 	swlevel = find_level(&cpu, d->irq);
-	bridge->b_int_addr[pin].addr = (0x20000 | swlevel | (bc->nasid << 8));
-	bridge->b_int_enable |= (1 << pin);
-	bridge->b_int_enable |= 0x7ffffe00;	/* more stuff in int_enable */
 
 	/*
-	 * Enable sending of an interrupt clear packt to the hub on a high to
-	 * low transition of the interrupt pin.
+	 * Handle BRIDGE IRQs.
 	 *
-	 * IRIX sets additional bits in the address which are documented as
-	 * reserved in the bridge docs.
-	 */
-	bridge->b_int_mode |= (1UL << pin);
-
-	/*
-	 * We assume the bridge to have a 1:1 mapping between devices
-	 * (slots) and intr pins.
+	 * b_int_addr(slot) - Points to the HUB that this BRIDGE
+	 *	is assigned to, so that BRIDGE can frob the PI_INT_PEND_MOD
+	 *	register directly, without having to know which nasid the
+	 *	specific HUB is on.
+	 *
+	 * b_int_mode - Enable the sending of an interrupt clear
+	 *	packet to the HUB on a high-to-low transition of the
+	 *	interrupt pin.
+	 *
+	 * b_int_device - We assume the bridge to have a 1:1 mapping
+	 *	between devices (slots) and interrupt numbers.
+	 *
+	 * XXX: Replace the magic values with readable macros at some point.
 	 */
-	device = bridge->b_int_device;
-	device &= ~(7 << (pin*3));
-	device |= (pin << (pin*3));
-	bridge->b_int_device = device;
-
-	bridge->b_wid_tflush;
+	/* b_int_addr */
+	bridge_write_reg((0x20000 | swlevel | (bc->nasid << 8)), bc,
+			 b_int_addr(slot));
+	/* b_int_enable */
+	reg = bridge_read_reg(bc, b_int_enable);
+	bridge_write_reg((reg | BIT(slot) | 0x7ffffe00), bc, b_int_enable);
+
+	/* b_int_mode */
+	reg = bridge_read_reg(bc, b_int_mode);
+	bridge_write_reg((reg | BIT(slot)), bc, b_int_mode);
+
+	/* b_int_device */
+	reg = bridge_read_reg(bc, b_int_device);
+	reg &= ~BRIDGE_INT_DEV_MASK(slot);
+	reg |= BRIDGE_INT_DEV_SET(slot, slot);
+	bridge_write_reg(reg, bc, b_int_device);
+	/* flush */
+	BRIDGE_FLUSH(bc);
 
 	intr_connect_level(cpu, swlevel);
 
@@ -182,13 +193,13 @@ static unsigned int startup_bridge_irq(struct irq_data *d)
 /* Shutdown one of the (PCI ...) IRQs routes over a bridge.  */
 static void shutdown_bridge_irq(struct irq_data *d)
 {
+	u32 slot, reg;
 	struct bridge_controller *bc = IRQ_TO_BRIDGE(d->irq);
-	bridge_t *bridge = bc->base;
-	int pin, swlevel;
+	int swlevel;
 	cpuid_t cpu;
 
 	pr_debug("bridge_shutdown: irq 0x%x\n", d->irq);
-	pin = SLOT_FROM_PCI_IRQ(d->irq);
+	slot = SLOT_FROM_PCI_IRQ(d->irq);
 
 	/*
 	 * map irq to a swlevel greater than 6 since the first 6 bits
@@ -197,8 +208,9 @@ static void shutdown_bridge_irq(struct irq_data *d)
 	swlevel = find_level(&cpu, d->irq);
 	intr_disconnect_level(cpu, swlevel);
 
-	bridge->b_int_enable &= ~(1 << pin);
-	bridge->b_wid_tflush;
+	reg = bridge_read_reg(bc, b_int_enable);
+	bridge_write_reg((reg & ~(BIT(slot))), bc, b_int_enable);
+	BRIDGE_FLUSH(bc);
 }
 
 static inline void enable_bridge_irq(struct irq_data *d)
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 16ec4e12daa3..812b23c126ef 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -35,6 +35,11 @@
 #include <asm/sn/hub.h>
 #include <asm/sn/intr.h>
 
+/* XXX: Part of the IP27 "mega update" */
+#include <asm/mach-ip27/pcibr.h>
+struct bridge_controller *irq_to_bridge[PCIBR_MAX_BUS_X_DEV];
+u32 irq_to_slot[PCIBR_MAX_BUS_X_DEV];
+
 /*
  * Linux has a controller-independent x86 interrupt architecture.
  * every controller has a 'controller-template', that is used
-- 
2.11.1
