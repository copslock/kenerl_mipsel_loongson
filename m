Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Mar 2013 19:37:01 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:4777 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820116Ab3CBSg6wKWUG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Mar 2013 19:36:58 +0100
Received: from [10.9.208.53] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 02 Mar 2013 10:33:11 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 2 Mar 2013 10:36:39 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 2 Mar 2013 10:36:39 -0800
Received: from lc-blr-152.ban.broadcom.com (lc-blr-152.ban.broadcom.com
 [10.132.129.187]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 2BC8A40FE3; Sat, 2 Mar 2013 10:36:37 -0800 (PST)
From:   ganesanr@broadcom.com
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org,
        "Ganesan Ramalingam" <ganesanr@broadcom.com>
Subject: [PATCH 2/2] MIPS: Netlogic: Platform changes for XLR/XLS gmac
Date:   Sun, 3 Mar 2013 00:06:14 +0530
Message-ID: <1362249374-25556-2-git-send-email-ganesanr@broadcom.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1362249374-25556-1-git-send-email-ganesanr@broadcom.com>
References: <1362249374-25556-1-git-send-email-ganesanr@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D2C9A6D3S46228180-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ganesanr@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Add platform code to create network interface (xlr-net) for XLR/XLS
boards.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
---
 This patch has be merged via linux-mips tree.

 This patch depends on [PATCH 1/2] Staging: Netlogic XLR/XLS GMAC driver.

 arch/mips/include/asm/netlogic/xlr/platform_net.h |   46 +++++
 arch/mips/netlogic/xlr/Makefile                   |    3 +-
 arch/mips/netlogic/xlr/fmn.c                      |    2 +
 arch/mips/netlogic/xlr/platform_net.c             |  222 +++++++++++++++++++++
 4 files changed, 272 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlr/platform_net.h
 create mode 100644 arch/mips/netlogic/xlr/platform_net.c

diff --git a/arch/mips/include/asm/netlogic/xlr/platform_net.h b/arch/mips/include/asm/netlogic/xlr/platform_net.h
new file mode 100644
index 0000000..29deeea
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/platform_net.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
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
+struct xlr_net_data {
+	int cpu_mask;
+	u32 __iomem *mii_addr;
+	u32 __iomem *serdes_addr;
+	u32 __iomem *pcs_addr;
+	u32 __iomem *gpio_addr;
+	int phy_interface;
+	int rfr_station;
+	int tx_stnid;
+	int *bucket_size;
+	int phy_addr;
+	struct xlr_fmn_info *gmac_fmn_info;
+};
diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
index 05902bc..ff7ed2e 100644
--- a/arch/mips/netlogic/xlr/Makefile
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -1,2 +1,3 @@
-obj-y			+=  fmn.o fmn-config.o setup.o platform.o platform-flash.o
+obj-y			+=  fmn.o fmn-config.o setup.o platform.o \
+				 platform-flash.o platform_net.o
 obj-$(CONFIG_SMP)	+= wakeup.o
diff --git a/arch/mips/netlogic/xlr/fmn.c b/arch/mips/netlogic/xlr/fmn.c
index 4d74f03..d93e11a 100644
--- a/arch/mips/netlogic/xlr/fmn.c
+++ b/arch/mips/netlogic/xlr/fmn.c
@@ -33,6 +33,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/irqreturn.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -190,6 +191,7 @@ int nlm_register_fmn_handler(int start_stnid, int end_stnid,
 			start_stnid, end_stnid);
 	return 0;
 }
+EXPORT_SYMBOL(nlm_register_fmn_handler);
 
 void nlm_setup_fmn_irq(void)
 {
diff --git a/arch/mips/netlogic/xlr/platform_net.c b/arch/mips/netlogic/xlr/platform_net.c
new file mode 100644
index 0000000..f6626a3
--- /dev/null
+++ b/arch/mips/netlogic/xlr/platform_net.c
@@ -0,0 +1,222 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * 1. Redistributions of source code must retain the above copyright
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
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/resource.h>
+#include <linux/phy.h>
+
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/xlr/fmn.h>
+#include <asm/netlogic/xlr/xlr.h>
+#include <asm/netlogic/psb-bootinfo.h>
+#include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/platform_net.h>
+
+/* Linux Net */
+#define MAX_NUM_GMAC		8
+#define MAX_NUM_XLS_GMAC	8
+#define MAX_NUM_XLR_GMAC	4
+
+
+static u32 xlr_gmac_offsets[] = {
+	NETLOGIC_IO_GMAC_0_OFFSET, NETLOGIC_IO_GMAC_1_OFFSET,
+	NETLOGIC_IO_GMAC_2_OFFSET, NETLOGIC_IO_GMAC_3_OFFSET,
+	NETLOGIC_IO_GMAC_4_OFFSET, NETLOGIC_IO_GMAC_5_OFFSET,
+	NETLOGIC_IO_GMAC_6_OFFSET, NETLOGIC_IO_GMAC_7_OFFSET
+};
+
+static u32 xlr_gmac_irqs[] = { PIC_GMAC_0_IRQ, PIC_GMAC_1_IRQ,
+	PIC_GMAC_2_IRQ, PIC_GMAC_3_IRQ,
+	PIC_GMAC_4_IRQ, PIC_GMAC_5_IRQ,
+	PIC_GMAC_6_IRQ, PIC_GMAC_7_IRQ
+};
+
+static struct xlr_net_data ndata[MAX_NUM_GMAC];
+static struct resource xlr_net_res[8][2];
+static struct platform_device xlr_net_dev[8];
+static u32 __iomem *gmac0_addr;
+static u32 __iomem *gmac4_addr;
+static u32 __iomem *gpio_addr;
+
+static void config_mac(struct xlr_net_data *nd, int phy, u32 __iomem *serdes,
+		u32 __iomem *pcs, int rfr, int tx, int *bkt_size,
+		struct xlr_fmn_info *gmac_fmn_info, int phy_addr)
+{
+	nd->cpu_mask = nlm_current_node()->coremask;
+	nd->phy_interface = phy;
+	nd->rfr_station = rfr;
+	nd->tx_stnid = tx;
+	nd->mii_addr = gmac0_addr;
+	nd->serdes_addr = serdes;
+	nd->pcs_addr = pcs;
+	nd->gpio_addr = gpio_addr;
+
+	nd->bucket_size = bkt_size;
+	nd->gmac_fmn_info = gmac_fmn_info;
+	nd->phy_addr = phy_addr;
+}
+
+static void net_device_init(int id, struct resource *res, int offset, int irq)
+{
+	res[0].name = "gmac";
+	res[0].start = CPHYSADDR(nlm_mmio_base(offset));
+	res[0].end = res[0].start + 0xfff;
+	res[0].flags = IORESOURCE_MEM;
+
+	res[1].name = "gmac";
+	res[1].start = irq;
+	res[1].end = irq;
+	res[1].flags = IORESOURCE_IRQ;
+
+	xlr_net_dev[id].name = "xlr-net";
+	xlr_net_dev[id].id = id;
+	xlr_net_dev[id].num_resources = 2;
+	xlr_net_dev[id].resource = res;
+	xlr_net_dev[id].dev.platform_data = &ndata[id];
+}
+
+static void xls_gmac_init(void)
+{
+	int mac;
+
+	gmac4_addr = ioremap(CPHYSADDR(
+		nlm_mmio_base(NETLOGIC_IO_GMAC_4_OFFSET)), 0xfff);
+	/* Passing GPIO base for serdes init. Only needed on sgmii ports*/
+	gpio_addr = ioremap(CPHYSADDR(
+		nlm_mmio_base(NETLOGIC_IO_GPIO_OFFSET)), 0xfff);
+
+	switch (nlm_prom_info.board_major_version) {
+	case 12:
+		/* first block RGMII or XAUI, use RGMII */
+		config_mac(&ndata[0],
+			PHY_INTERFACE_MODE_RGMII,
+			gmac0_addr,	/* serdes */
+			gmac0_addr,	/* pcs */
+			FMN_STNID_GMACRFR_0,
+			FMN_STNID_GMAC0_TX0,
+			xlr_board_fmn_config.bucket_size,
+			&xlr_board_fmn_config.gmac[0],
+			0);
+
+		net_device_init(0, xlr_net_res[0], xlr_gmac_offsets[0],
+				xlr_gmac_irqs[0]);
+		platform_device_register(&xlr_net_dev[0]);
+
+		/* second block is XAUI, not supported yet */
+		break;
+	default:
+		/* default XLS config, all ports SGMII */
+		for (mac = 0; mac < 4; mac++) {
+			config_mac(&ndata[mac],
+				PHY_INTERFACE_MODE_SGMII,
+				gmac0_addr,	/* serdes */
+				gmac0_addr,	/* pcs */
+				FMN_STNID_GMACRFR_0,
+				FMN_STNID_GMAC0_TX0 + mac,
+				xlr_board_fmn_config.bucket_size,
+				&xlr_board_fmn_config.gmac[0],
+				/* PHY address according to chip/board */
+				mac + 0x10);
+
+			net_device_init(mac, xlr_net_res[mac],
+					xlr_gmac_offsets[mac],
+					xlr_gmac_irqs[mac]);
+			platform_device_register(&xlr_net_dev[mac]);
+		}
+
+		for (mac = 4; mac < MAX_NUM_XLS_GMAC; mac++) {
+			config_mac(&ndata[mac],
+				PHY_INTERFACE_MODE_SGMII,
+				gmac4_addr,	/* serdes */
+				gmac4_addr,	/* pcs */
+				FMN_STNID_GMAC1_FR_0,
+				FMN_STNID_GMAC1_TX0 + mac - 4,
+				xlr_board_fmn_config.bucket_size,
+				&xlr_board_fmn_config.gmac[1],
+				/* PHY address according to chip/board */
+				mac + 0x10);
+
+			net_device_init(mac, xlr_net_res[mac],
+					xlr_gmac_offsets[mac],
+					xlr_gmac_irqs[mac]);
+			platform_device_register(&xlr_net_dev[mac]);
+		}
+	}
+}
+
+static void xlr_gmac_init(void)
+{
+	int mac;
+
+	/* assume all GMACs for now */
+	for (mac = 0; mac < MAX_NUM_XLR_GMAC; mac++) {
+		config_mac(&ndata[mac],
+			PHY_INTERFACE_MODE_RGMII,
+			0,
+			0,
+			FMN_STNID_GMACRFR_0,
+			FMN_STNID_GMAC0_TX0,
+			xlr_board_fmn_config.bucket_size,
+			&xlr_board_fmn_config.gmac[0],
+			mac);
+
+		net_device_init(mac, xlr_net_res[mac], xlr_gmac_offsets[mac],
+				xlr_gmac_irqs[mac]);
+		platform_device_register(&xlr_net_dev[mac]);
+	}
+}
+
+static int __init xlr_net_init(void)
+{
+	gmac0_addr = ioremap(CPHYSADDR(
+		nlm_mmio_base(NETLOGIC_IO_GMAC_0_OFFSET)), 0xfff);
+
+	if (nlm_chip_is_xls())
+		xls_gmac_init();
+	else
+		xlr_gmac_init();
+
+	return 0;
+}
+
+arch_initcall(xlr_net_init);
-- 
1.7.6
