Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:37:00 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:30646 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843095AbaD2OcNJaG67 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:13 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="27211055"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 29 Apr 2014 08:42:38 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:32:10 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:32:11 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 03FE151E7D;    Tue, 29 Apr 2014 07:32:09 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 17/17] MIPS: Netlogic: XLP9XX on-chip SATA support
Date:   Tue, 29 Apr 2014 20:07:56 +0530
Message-ID: <064ee7509119f3a7a76410a7d72281b41798b888.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39982
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

The XLP9XX SoC has an on-chip SATA controller with two ports. Add
ahci-init-xlp2.c to initialize the controller, setup the glue logic
registers, fixup PCI quirks and setup interrupt ack logic.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/Makefile         |    1 +
 arch/mips/netlogic/xlp/ahci-init-xlp2.c |  378 +++++++++++++++++++++++++++++++
 2 files changed, 379 insertions(+)
 create mode 100644 arch/mips/netlogic/xlp/ahci-init-xlp2.c

diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index 0cb53af..be358a8 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_SMP)		+= wakeup.o
 obj-$(CONFIG_USB)		+= usb-init.o
 obj-$(CONFIG_USB)		+= usb-init-xlp2.o
 obj-$(CONFIG_SATA_AHCI)		+= ahci-init.o
+obj-$(CONFIG_SATA_AHCI)		+= ahci-init-xlp2.o
diff --git a/arch/mips/netlogic/xlp/ahci-init-xlp2.c b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
new file mode 100644
index 0000000..a55e111
--- /dev/null
+++ b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
@@ -0,0 +1,378 @@
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
+#include <linux/pci_ids.h>
+#include <linux/nodemask.h>
+
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/mips-extns.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+
+#define SATA_CTL		0x0
+#define SATA_STATUS		0x1 /* Status Reg */
+#define SATA_INT		0x2 /* Interrupt Reg */
+#define SATA_INT_MASK		0x3 /* Interrupt Mask Reg */
+#define SATA_BIU_TIMEOUT	0x4
+#define AXIWRSPERRLOG		0x5
+#define AXIRDSPERRLOG		0x6
+#define BiuTimeoutLow		0x7
+#define BiuTimeoutHi		0x8
+#define BiuSlvErLow		0x9
+#define BiuSlvErHi		0xa
+#define IO_CONFIG_SWAP_DIS	0xb
+#define CR_REG_TIMER		0xc
+#define CORE_ID			0xd
+#define AXI_SLAVE_OPT1		0xe
+#define PHY_MEM_ACCESS		0xf
+#define PHY0_CNTRL		0x10
+#define PHY0_STAT		0x11
+#define PHY0_RX_ALIGN		0x12
+#define PHY0_RX_EQ_LO		0x13
+#define PHY0_RX_EQ_HI		0x14
+#define PHY0_BIST_LOOP		0x15
+#define PHY1_CNTRL		0x16
+#define PHY1_STAT		0x17
+#define PHY1_RX_ALIGN		0x18
+#define PHY1_RX_EQ_LO		0x19
+#define PHY1_RX_EQ_HI		0x1a
+#define PHY1_BIST_LOOP		0x1b
+#define RdExBase		0x1c
+#define RdExLimit		0x1d
+#define CacheAllocBase		0x1e
+#define CacheAllocLimit		0x1f
+#define BiuSlaveCmdGstNum	0x20
+
+/*SATA_CTL Bits */
+#define SATA_RST_N		BIT(0)  /* Active low reset sata_core phy */
+#define SataCtlReserve0		BIT(1)
+#define M_CSYSREQ		BIT(2)  /* AXI master low power, not used */
+#define S_CSYSREQ		BIT(3)  /* AXI slave low power, not used */
+#define P0_CP_DET		BIT(8)  /* Reserved, bring in from pad */
+#define P0_MP_SW		BIT(9)  /* Mech Switch */
+#define P0_DISABLE		BIT(10) /* disable p0 */
+#define P0_ACT_LED_EN		BIT(11) /* Active LED enable */
+#define P0_IRST_HARD_SYNTH	BIT(12) /* PHY hard synth reset */
+#define P0_IRST_HARD_TXRX	BIT(13) /* PHY lane hard reset */
+#define P0_IRST_POR		BIT(14) /* PHY power on reset*/
+#define P0_IPDTXL		BIT(15) /* PHY Tx lane dis/power down */
+#define P0_IPDRXL		BIT(16) /* PHY Rx lane dis/power down */
+#define P0_IPDIPDMSYNTH		BIT(17) /* PHY synthesizer dis/porwer down */
+#define P0_CP_POD_EN		BIT(18) /* CP_POD enable */
+#define P0_AT_BYPASS		BIT(19) /* P0 address translation by pass */
+#define P1_CP_DET		BIT(20) /* Reserved,Cold Detect */
+#define P1_MP_SW		BIT(21) /* Mech Switch */
+#define P1_DISABLE		BIT(22) /* disable p1 */
+#define P1_ACT_LED_EN		BIT(23) /* Active LED enable */
+#define P1_IRST_HARD_SYNTH	BIT(24) /* PHY hard synth reset */
+#define P1_IRST_HARD_TXRX	BIT(25) /* PHY lane hard reset */
+#define P1_IRST_POR		BIT(26) /* PHY power on reset*/
+#define P1_IPDTXL		BIT(27) /* PHY Tx lane dis/porwer down */
+#define P1_IPDRXL		BIT(28) /* PHY Rx lane dis/porwer down */
+#define P1_IPDIPDMSYNTH		BIT(29) /* PHY synthesizer dis/porwer down */
+#define P1_CP_POD_EN		BIT(30)
+#define P1_AT_BYPASS		BIT(31) /* P1 address translation by pass */
+
+/* Status register */
+#define M_CACTIVE		BIT(0)  /* m_cactive, not used */
+#define S_CACTIVE		BIT(1)  /* s_cactive, not used */
+#define P0_PHY_READY		BIT(8)  /* phy is ready */
+#define P0_CP_POD		BIT(9)  /* Cold PowerOn */
+#define P0_SLUMBER		BIT(10) /* power mode slumber */
+#define P0_PATIAL		BIT(11) /* power mode patial */
+#define P0_PHY_SIG_DET		BIT(12) /* phy dignal detect */
+#define P0_PHY_CALI		BIT(13) /* phy calibration done */
+#define P1_PHY_READY		BIT(16) /* phy is ready */
+#define P1_CP_POD		BIT(17) /* Cold PowerOn */
+#define P1_SLUMBER		BIT(18) /* power mode slumber */
+#define P1_PATIAL		BIT(19) /* power mode patial */
+#define P1_PHY_SIG_DET		BIT(20) /* phy dignal detect */
+#define P1_PHY_CALI		BIT(21) /* phy calibration done */
+
+/* SATA CR_REG_TIMER bits */
+#define CR_TIME_SCALE		(0x1000 << 0)
+
+/* SATA PHY specific registers start and end address */
+#define RXCDRCALFOSC0		0x0065
+#define CALDUTY			0x006e
+#define RXDPIF			0x8065
+#define PPMDRIFTMAX_HI		0x80A4
+
+#define nlm_read_sata_reg(b, r)		nlm_read_reg(b, r)
+#define nlm_write_sata_reg(b, r, v)	nlm_write_reg(b, r, v)
+#define nlm_get_sata_pcibase(node)	\
+		nlm_pcicfg_base(XLP9XX_IO_SATA_OFFSET(node))
+#define nlm_get_sata_regbase(node)	\
+		(nlm_get_sata_pcibase(node) + 0x100)
+
+/* SATA PHY config for register block 1 0x0065 .. 0x006e */
+static const u8 sata_phy_config1[]  = {
+	0xC9, 0xC9, 0x07, 0x07, 0x18, 0x18, 0x01, 0x01, 0x22, 0x00
+};
+
+/* SATA PHY config for register block 2 0x0x8065 .. 0x0x80A4 */
+static const u8 sata_phy_config2[]  = {
+	0xAA, 0x00, 0x4C, 0xC9, 0xC9, 0x07, 0x07, 0x18,
+	0x18, 0x05, 0x0C, 0x10, 0x00, 0x10, 0x00, 0xFF,
+	0xCF, 0xF7, 0xE1, 0xF5, 0xFD, 0xFD, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xE3, 0xE7, 0xDB, 0xF5, 0xFD, 0xFD,
+	0xF5, 0xF5, 0xFF, 0xFF, 0xE3, 0xE7, 0xDB, 0xF5,
+	0xFD, 0xFD, 0xF5, 0xF5, 0xFF, 0xFF, 0xFF, 0xF5,
+	0x3F, 0x00, 0x32, 0x00, 0x03, 0x01, 0x05, 0x05,
+	0x04, 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x04,
+};
+
+static void sata_clear_glue_reg(u64 regbase, u32 off, u32 bit)
+{
+	u32 reg_val;
+
+	reg_val = nlm_read_sata_reg(regbase, off);
+	nlm_write_sata_reg(regbase, off, (reg_val & ~bit));
+}
+
+static void sata_set_glue_reg(u64 regbase, u32 off, u32 bit)
+{
+	u32 reg_val;
+
+	reg_val = nlm_read_sata_reg(regbase, off);
+	nlm_write_sata_reg(regbase, off, (reg_val | bit));
+}
+
+static void write_phy_reg(u64 regbase, u32 addr, u32 physel, u8 data)
+{
+	nlm_write_sata_reg(regbase, PHY_MEM_ACCESS,
+		(1u << 31) | (physel << 24) | (data << 16) | addr);
+	udelay(850);
+}
+
+static void config_sata_phy(u64 regbase, u32 node)
+{
+	u32 port, i, reg;
+
+	for (port = 0; port < 2; port++) {
+		for (i = 0, reg = RXCDRCALFOSC0; reg <= CALDUTY; reg++, i++)
+			write_phy_reg(regbase, reg, port, sata_phy_config1[i]);
+
+		for (i = 0, reg = RXDPIF; reg <= PPMDRIFTMAX_HI; reg++, i++)
+			write_phy_reg(regbase, reg, port, sata_phy_config2[i]);
+	}
+}
+
+#if 0	/* DEBUG */
+static u8 read_phy_reg(u64 regbase, u32 addr, u32 physel)
+{
+	u32 val;
+
+	nlm_write_sata_reg(regbase, PHY_MEM_ACCESS,
+		(0 << 31) | (physel << 24) | (data << 16) | addr);
+	udelay(850);
+	val = nlm_read_sata_reg(regbase, PHY_MEM_ACCESS);
+	return (val >> 16) & 0xff;
+}
+
+static void check_phy_register(u63 regbase, u32 addr, u32 physel, u8 xdata)
+{
+	u64 regbase;
+	u8 data;
+
+	data = read_phy_reg(regbase, addr, physel);
+	pr_info("PHY read addr = 0x%x physel = %d data = 0x%x %s\n",
+		addr, physel, data, data == xdata ? "TRUE" : "FALSE");
+}
+
+static void verify_sata_phy_config(u64 regbase, u32 node)
+{
+	u32 port, i, reg;
+
+	for (port = 0; port < 2; port++) {
+		for (i = 0, reg = RXCDRCALFOSC0; reg <= CALDUTY; reg++, i++)
+			check_phy_register(regbase, node, reg, port,
+					sata_phy_config1[i]);
+
+		for (i = 0, reg = RXDPIF; reg <= PPMDRIFTMAX_HI; reg++, i++)
+			check_phy_register(regbase, node, reg, port,
+					sata_phy_config2[i]);
+	}
+}
+#endif
+
+static void nlm_sata_firmware_init(int node)
+{
+	u32 reg_val;
+	u64 regbase;
+	int n;
+
+	pr_info("Initializing XLP9XX On-chip AHCI...\n");
+	regbase = nlm_get_sata_regbase(node);
+
+	/* Reset port0 */
+	sata_clear_glue_reg(regbase, SATA_CTL, P0_IRST_POR);
+	sata_clear_glue_reg(regbase, SATA_CTL, P0_IRST_HARD_TXRX);
+	sata_clear_glue_reg(regbase, SATA_CTL, P0_IRST_HARD_SYNTH);
+	sata_clear_glue_reg(regbase, SATA_CTL, P0_IPDTXL);
+	sata_clear_glue_reg(regbase, SATA_CTL, P0_IPDRXL);
+	sata_clear_glue_reg(regbase, SATA_CTL, P0_IPDIPDMSYNTH);
+
+	/* port1 */
+	sata_clear_glue_reg(regbase, SATA_CTL, P1_IRST_POR);
+	sata_clear_glue_reg(regbase, SATA_CTL, P1_IRST_HARD_TXRX);
+	sata_clear_glue_reg(regbase, SATA_CTL, P1_IRST_HARD_SYNTH);
+	sata_clear_glue_reg(regbase, SATA_CTL, P1_IPDTXL);
+	sata_clear_glue_reg(regbase, SATA_CTL, P1_IPDRXL);
+	sata_clear_glue_reg(regbase, SATA_CTL, P1_IPDIPDMSYNTH);
+	udelay(300);
+
+	/* Set PHY */
+	sata_set_glue_reg(regbase, SATA_CTL, P0_IPDTXL);
+	sata_set_glue_reg(regbase, SATA_CTL, P0_IPDRXL);
+	sata_set_glue_reg(regbase, SATA_CTL, P0_IPDIPDMSYNTH);
+	sata_set_glue_reg(regbase, SATA_CTL, P1_IPDTXL);
+	sata_set_glue_reg(regbase, SATA_CTL, P1_IPDRXL);
+	sata_set_glue_reg(regbase, SATA_CTL, P1_IPDIPDMSYNTH);
+
+	udelay(1000);
+	sata_set_glue_reg(regbase, SATA_CTL, P0_IRST_POR);
+	udelay(1000);
+	sata_set_glue_reg(regbase, SATA_CTL, P1_IRST_POR);
+	udelay(1000);
+
+	/* setup PHY */
+	config_sata_phy(regbase, node);
+#if 0	/* For debug */
+	verify_sata_phy_config(regbase, node);
+#endif
+	udelay(1000);
+	sata_set_glue_reg(regbase, SATA_CTL, P0_IRST_HARD_TXRX);
+	sata_set_glue_reg(regbase, SATA_CTL, P0_IRST_HARD_SYNTH);
+	sata_set_glue_reg(regbase, SATA_CTL, P1_IRST_HARD_TXRX);
+	sata_set_glue_reg(regbase, SATA_CTL, P1_IRST_HARD_SYNTH);
+	udelay(300);
+
+	/* Override reset in serial PHY mode */
+	sata_set_glue_reg(regbase, CR_REG_TIMER, CR_TIME_SCALE);
+	/* Set reset SATA */
+	sata_set_glue_reg(regbase, SATA_CTL, SATA_RST_N);
+	sata_set_glue_reg(regbase, SATA_CTL, M_CSYSREQ);
+	sata_set_glue_reg(regbase, SATA_CTL, S_CSYSREQ);
+
+	pr_debug("Waiting for PHYs to come up.\n");
+	n = 10000;
+	do {
+		reg_val = nlm_read_sata_reg(regbase, SATA_STATUS);
+		if ((reg_val & P1_PHY_READY) && (reg_val & P0_PHY_READY))
+			break;
+		udelay(10);
+	} while (--n > 0);
+
+	if (reg_val  & P0_PHY_READY)
+		pr_info("PHY0 is up.\n");
+	else
+		pr_info("PHY0 is down.\n");
+	if (reg_val  & P1_PHY_READY)
+		pr_info("PHY1 is up.\n");
+	else
+		pr_info("PHY1 is down.\n");
+
+	pr_info("XLP AHCI Init Done.\n");
+}
+
+static int __init nlm_ahci_init(void)
+{
+	int node;
+
+	if (!cpu_is_xlp9xx())
+		return 0;
+	for (node = 0; node < NLM_NR_NODES; node++)
+		if (nlm_node_present(node))
+			nlm_sata_firmware_init(node);
+	return 0;
+}
+
+static void nlm_sata_intr_ack(struct irq_data *data)
+{
+	u64 regbase;
+	u32 val;
+	int node;
+
+	node = data->irq / NLM_IRQS_PER_NODE;
+	regbase = nlm_get_sata_regbase(node);
+	val = nlm_read_sata_reg(regbase, SATA_INT);
+	sata_set_glue_reg(regbase, SATA_INT, val);
+}
+
+static void nlm_sata_fixup_bar(struct pci_dev *dev)
+{
+	dev->resource[5] = dev->resource[0];
+	memset(&dev->resource[0], 0, sizeof(dev->resource[0]));
+}
+
+static void nlm_sata_fixup_final(struct pci_dev *dev)
+{
+	u32 val;
+	u64 regbase;
+	int node;
+
+	/* Find end bridge function to find node */
+	node = xlp_socdev_to_node(dev);
+	regbase = nlm_get_sata_regbase(node);
+
+	/* clear pending interrupts and then enable them */
+	val = nlm_read_sata_reg(regbase, SATA_INT);
+	sata_set_glue_reg(regbase, SATA_INT, val);
+
+	/* Enable only the core interrupt */
+	sata_set_glue_reg(regbase, SATA_INT_MASK, 0x1);
+
+	dev->irq = nlm_irq_to_xirq(node, PIC_SATA_IRQ);
+	nlm_set_pic_extra_ack(node, PIC_SATA_IRQ, nlm_sata_intr_ack);
+}
+
+arch_initcall(nlm_ahci_init);
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_XLP9XX_SATA,
+		nlm_sata_fixup_bar);
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_XLP9XX_SATA,
+		nlm_sata_fixup_final);
-- 
1.7.9.5
