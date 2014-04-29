Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:36:38 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:29457 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843092AbaD2OcLZ65e1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:11 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26850068"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw2-out.broadcom.com with ESMTP; 29 Apr 2014 07:57:19 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:32:08 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:32:09 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 618A051E7D;    Tue, 29 Apr 2014 07:32:08 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 16/17] MIPS: Netlogic: Support for XLP3XX on-chip SATA
Date:   Tue, 29 Apr 2014 20:07:55 +0530
Message-ID: <9b507742d1b581a1bc9210df1fb3931ec02cdde9.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

XLP3XX includes an on-chip SATA controller with 4 ports. The
controller needs glue logic initialization and PCI fixup before
it can be used with the standard AHCI driver.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/Makefile    |    1 +
 arch/mips/netlogic/xlp/ahci-init.c |  209 ++++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 arch/mips/netlogic/xlp/ahci-init.c

diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index ed9a93c..0cb53af 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -2,3 +2,4 @@ obj-y				+= setup.o nlm_hal.o cop2-ex.o dt.o
 obj-$(CONFIG_SMP)		+= wakeup.o
 obj-$(CONFIG_USB)		+= usb-init.o
 obj-$(CONFIG_USB)		+= usb-init-xlp2.o
+obj-$(CONFIG_SATA_AHCI)		+= ahci-init.o
diff --git a/arch/mips/netlogic/xlp/ahci-init.c b/arch/mips/netlogic/xlp/ahci-init.c
new file mode 100644
index 0000000..a9d0fae
--- /dev/null
+++ b/arch/mips/netlogic/xlp/ahci-init.c
@@ -0,0 +1,209 @@
+/*
+ * Copyright (c) 2003-2014 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/bitops.h>
+
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/mips-extns.h>
+
+#define SATA_CTL		0x0
+#define SATA_STATUS		0x1	/* Status Reg */
+#define SATA_INT		0x2	/* Interrupt Reg */
+#define SATA_INT_MASK		0x3	/* Interrupt Mask Reg */
+#define SATA_CR_REG_TIMER	0x4	/* PHY Conrol Timer Reg */
+#define SATA_CORE_ID		0x5	/* Core ID Reg */
+#define SATA_AXI_SLAVE_OPT1	0x6	/* AXI Slave Options Reg */
+#define SATA_PHY_LOS_LEV	0x7	/* PHY LOS Level Reg */
+#define SATA_PHY_MULTI		0x8	/* PHY Multiplier Reg */
+#define SATA_PHY_CLK_SEL	0x9	/* Clock Select Reg */
+#define SATA_PHY_AMP1_GEN1	0xa	/* PHY Transmit Amplitude Reg 1 */
+#define SATA_PHY_AMP1_GEN2	0xb	/* PHY Transmit Amplitude Reg 2 */
+#define SATA_PHY_AMP1_GEN3	0xc	/* PHY Transmit Amplitude Reg 3 */
+#define SATA_PHY_PRE1		0xd	/* PHY Transmit Preemphasis Reg 1 */
+#define SATA_PHY_PRE2		0xe	/* PHY Transmit Preemphasis Reg 2 */
+#define SATA_PHY_PRE3		0xf	/* PHY Transmit Preemphasis Reg 3 */
+#define SATA_SPDMODE		0x10	/* Speed Mode Reg */
+#define SATA_REFCLK		0x11	/* Reference Clock Control Reg */
+#define SATA_BYTE_SWAP_DIS	0x12	/* byte swap disable */
+
+/*SATA_CTL Bits */
+#define SATA_RST_N		BIT(0)
+#define PHY0_RESET_N		BIT(16)
+#define PHY1_RESET_N		BIT(17)
+#define PHY2_RESET_N		BIT(18)
+#define PHY3_RESET_N		BIT(19)
+#define M_CSYSREQ		BIT(2)
+#define S_CSYSREQ		BIT(3)
+
+/*SATA_STATUS Bits */
+#define P0_PHY_READY		BIT(4)
+#define P1_PHY_READY		BIT(5)
+#define P2_PHY_READY		BIT(6)
+#define P3_PHY_READY		BIT(7)
+
+#define nlm_read_sata_reg(b, r)		nlm_read_reg(b, r)
+#define nlm_write_sata_reg(b, r, v)	nlm_write_reg(b, r, v)
+#define nlm_get_sata_pcibase(node)	\
+		nlm_pcicfg_base(XLP_IO_SATA_OFFSET(node))
+/* SATA device specific configuration registers are starts at 0x900 offset */
+#define nlm_get_sata_regbase(node)	\
+		(nlm_get_sata_pcibase(node) + 0x900)
+
+static void sata_clear_glue_reg(uint64_t regbase, uint32_t off, uint32_t bit)
+{
+	uint32_t reg_val;
+
+	reg_val = nlm_read_sata_reg(regbase, off);
+	nlm_write_sata_reg(regbase, off, (reg_val & ~bit));
+}
+
+static void sata_set_glue_reg(uint64_t regbase, uint32_t off, uint32_t bit)
+{
+	uint32_t reg_val;
+
+	reg_val = nlm_read_sata_reg(regbase, off);
+	nlm_write_sata_reg(regbase, off, (reg_val | bit));
+}
+
+static void nlm_sata_firmware_init(int node)
+{
+	uint32_t reg_val;
+	uint64_t regbase;
+	int i;
+
+	pr_info("XLP AHCI Initialization started.\n");
+	regbase = nlm_get_sata_regbase(node);
+
+	/* Reset SATA */
+	sata_clear_glue_reg(regbase, SATA_CTL, SATA_RST_N);
+	/* Reset PHY */
+	sata_clear_glue_reg(regbase, SATA_CTL,
+			(PHY3_RESET_N | PHY2_RESET_N
+			 | PHY1_RESET_N | PHY0_RESET_N));
+
+	/* Set SATA */
+	sata_set_glue_reg(regbase, SATA_CTL, SATA_RST_N);
+	/* Set PHY */
+	sata_set_glue_reg(regbase, SATA_CTL,
+			(PHY3_RESET_N | PHY2_RESET_N
+			 | PHY1_RESET_N | PHY0_RESET_N));
+
+	pr_debug("Waiting for PHYs to come up.\n");
+	i = 0;
+	do {
+		reg_val = nlm_read_sata_reg(regbase, SATA_STATUS);
+		i++;
+	} while (((reg_val & 0xF0) != 0xF0) && (i < 10000));
+
+	for (i = 0; i < 4; i++) {
+		if (reg_val  & (P0_PHY_READY << i))
+			pr_info("PHY%d is up.\n", i);
+		else
+			pr_info("PHY%d is down.\n", i);
+	}
+
+	pr_info("XLP AHCI init done.\n");
+}
+
+static int __init nlm_ahci_init(void)
+{
+	int node = 0;
+	int chip = read_c0_prid() & PRID_REV_MASK;
+
+	if (chip == PRID_IMP_NETLOGIC_XLP3XX)
+		nlm_sata_firmware_init(node);
+	return 0;
+}
+
+static void nlm_sata_intr_ack(struct irq_data *data)
+{
+	uint32_t val = 0;
+	uint64_t regbase;
+
+	regbase = nlm_get_sata_regbase(nlm_nodeid());
+	val = nlm_read_sata_reg(regbase, SATA_INT);
+	sata_set_glue_reg(regbase, SATA_INT, val);
+}
+
+static void nlm_sata_fixup_bar(struct pci_dev *dev)
+{
+	/*
+	 * The AHCI resource is in BAR 0, move it to
+	 * BAR 5, where it is expected
+	 */
+	dev->resource[5] = dev->resource[0];
+	memset(&dev->resource[0], 0, sizeof(dev->resource[0]));
+}
+
+static void nlm_sata_fixup_final(struct pci_dev *dev)
+{
+	uint32_t val;
+	uint64_t regbase;
+	int node = 0; /* XLP3XX does not support multi-node */
+
+	regbase = nlm_get_sata_regbase(node);
+
+	/* clear pending interrupts and then enable them */
+	val = nlm_read_sata_reg(regbase, SATA_INT);
+	sata_set_glue_reg(regbase, SATA_INT, val);
+
+	/* Mask the core interrupt. If all the interrupts
+	 * are enabled there are spurious interrupt flow
+	 * happening, to avoid only enable core interrupt
+	 * mask.
+	 */
+	sata_set_glue_reg(regbase, SATA_INT_MASK, 0x1);
+
+	dev->irq = PIC_SATA_IRQ;
+	nlm_set_pic_extra_ack(node, PIC_SATA_IRQ, nlm_sata_intr_ack);
+}
+
+arch_initcall(nlm_ahci_init);
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_NETLOGIC, PCI_DEVICE_ID_NLM_SATA,
+		nlm_sata_fixup_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_NETLOGIC, PCI_DEVICE_ID_NLM_SATA,
+		nlm_sata_fixup_final);
-- 
1.7.9.5
