Return-Path: <SRS0=9u5Z=PZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852ACC43387
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F8320657
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfAQKFJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:05:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60548 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfAQKFF (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 17 Jan 2019 05:05:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 174E720A2E; Thu, 17 Jan 2019 11:05:03 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id D7A81206DC;
        Thu, 17 Jan 2019 11:05:02 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: [PATCH net-next 5/8] net: mscc: describe the VCAP and PTP register ranges
Date:   Thu, 17 Jan 2019 11:02:09 +0100
Message-Id: <20190117100212.2336-6-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117100212.2336-1-antoine.tenart@bootlin.com>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds support for using the VCAP and PTP register ranges, and
adds a description of their registers. Those banks are used when
configuring PTP.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.h       |  18 ++++
 drivers/net/ethernet/mscc/ocelot_board.c |  21 +++--
 drivers/net/ethernet/mscc/ocelot_ptp.h   |  41 +++++++++
 drivers/net/ethernet/mscc/ocelot_regs.c  |  22 +++++
 drivers/net/ethernet/mscc/ocelot_vcap.h  | 104 +++++++++++++++++++++++
 5 files changed, 200 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/mscc/ocelot_ptp.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_vcap.h

diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 086775f7b52f..4b1b180884ad 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -22,6 +22,8 @@
 #include "ocelot_rew.h"
 #include "ocelot_sys.h"
 #include "ocelot_qs.h"
+#include "ocelot_ptp.h"
+#include "ocelot_vcap.h"
 
 #define PGID_AGGR    64
 #define PGID_SRC     80
@@ -69,6 +71,8 @@ enum ocelot_target {
 	REW,
 	SYS,
 	HSIO,
+	PTP,
+	VCAP,
 	TARGET_MAX,
 };
 
@@ -334,6 +338,20 @@ enum ocelot_reg {
 	SYS_CM_DATA_RD,
 	SYS_CM_OP,
 	SYS_CM_DATA,
+	PTP_PIN_CFG = PTP << TARGET_OFFSET,
+	PTP_PIN_TOD_SEC_MSB,
+	PTP_PIN_TOD_SEC_LSB,
+	PTP_PIN_TOD_NSEC,
+	PTP_CFG_MISC,
+	PTP_CLK_CFG_ADJ_CFG,
+	PTP_CLK_CFG_ADJ_FREQ,
+	VCAP_UPDATE_CTRL = VCAP << TARGET_OFFSET,
+	VCAP_UPDATE_CTRL_MV_CFG,
+	VCAP_UPDATE_CTRL_ENTRY_DATA,
+	VCAP_UPDATE_CTRL_MASK_DATA,
+	VCAP_UPDATE_CTRL_ACTION_DATA,
+	VCAP_UPDATE_CTRL_COUNTER_DATA,
+	VCAP_CACHE_DATA_TYPE,
 };
 
 enum ocelot_regfield {
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index ca3ea2fbfcd0..ba7c93c4318a 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -182,12 +182,15 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	struct {
 		enum ocelot_target id;
 		char *name;
+		u8 optional:1;
 	} res[] = {
-		{ SYS, "sys" },
-		{ REW, "rew" },
-		{ QSYS, "qsys" },
-		{ ANA, "ana" },
-		{ QS, "qs" },
+		{ SYS, "sys", 0 },
+		{ REW, "rew", 0 },
+		{ QSYS, "qsys", 0 },
+		{ ANA, "ana", 0 },
+		{ QS, "qs", 0 },
+		{ PTP, "ptp", 1 },
+		{ VCAP, "vcap", 1 },
 	};
 
 	if (!np && !pdev->dev.platform_data)
@@ -204,8 +207,14 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 		struct regmap *target;
 
 		target = ocelot_io_platform_init(ocelot, pdev, res[i].name);
-		if (IS_ERR(target))
+		if (IS_ERR(target)) {
+			if (res[i].optional) {
+				ocelot->targets[res[i].id] = NULL;
+				continue;
+			}
+
 			return PTR_ERR(target);
+		}
 
 		ocelot->targets[res[i].id] = target;
 	}
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.h b/drivers/net/ethernet/mscc/ocelot_ptp.h
new file mode 100644
index 000000000000..9ede14a12573
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * License: Dual MIT/GPL
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_PTP_H_
+#define _MSCC_OCELOT_PTP_H_
+
+#define PTP_PIN_CFG_RSZ			0x20
+#define PTP_PIN_TOD_SEC_MSB_RSZ		PTP_PIN_CFG_RSZ
+#define PTP_PIN_TOD_SEC_LSB_RSZ		PTP_PIN_CFG_RSZ
+#define PTP_PIN_TOD_NSEC_RSZ		PTP_PIN_CFG_RSZ
+
+#define PTP_PIN_CFG_DOM			BIT(0)
+#define PTP_PIN_CFG_SYNC		BIT(2)
+#define PTP_PIN_CFG_ACTION(x)		((x) << 3)
+#define PTP_PIN_CFG_ACTION_MASK		PTP_PIN_CFG_ACTION(0x7)
+
+enum {
+	PTP_PIN_ACTION_IDLE = 0,
+	PTP_PIN_ACTION_LOAD,
+	PTP_PIN_ACTION_SAVE,
+	PTP_PIN_ACTION_CLOCK,
+	PTP_PIN_ACTION_DELTA,
+	PTP_PIN_ACTION_NOSYNC,
+	PTP_PIN_ACTION_SYNC,
+};
+
+#define PTP_CFG_MISC_PTP_EN		BIT(2)
+
+#define PSEC_PER_SEC			1000000000000LL
+
+#define PTP_CFG_CLK_ADJ_CFG_ENA		BIT(0)
+#define PTP_CFG_CLK_ADJ_CFG_DIR		BIT(1)
+
+#define PTP_CFG_CLK_ADJ_FREQ_NS		BIT(30)
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_regs.c b/drivers/net/ethernet/mscc/ocelot_regs.c
index 9271af18b93b..bbba0f7a6962 100644
--- a/drivers/net/ethernet/mscc/ocelot_regs.c
+++ b/drivers/net/ethernet/mscc/ocelot_regs.c
@@ -224,12 +224,34 @@ static const u32 ocelot_sys_regmap[] = {
 	REG(SYS_PTP_CFG,                   0x0006c4),
 };
 
+static const u32 ocelot_ptp_regmap[] = {
+	REG(PTP_PIN_CFG,                   0x000000),
+	REG(PTP_PIN_TOD_SEC_MSB,           0x000004),
+	REG(PTP_PIN_TOD_SEC_LSB,           0x000008),
+	REG(PTP_PIN_TOD_NSEC,              0x00000c),
+	REG(PTP_CFG_MISC,                  0x0000a0),
+	REG(PTP_CLK_CFG_ADJ_CFG,           0x0000a4),
+	REG(PTP_CLK_CFG_ADJ_FREQ,          0x0000a8),
+};
+
+static const u32 ocelot_vcap_regmap[] = {
+	REG(VCAP_UPDATE_CTRL,              0x000000),
+	REG(VCAP_UPDATE_CTRL_MV_CFG,       0x000004),
+	REG(VCAP_UPDATE_CTRL_ENTRY_DATA,   0x000008),
+	REG(VCAP_UPDATE_CTRL_MASK_DATA,    0x000108),
+	REG(VCAP_UPDATE_CTRL_ACTION_DATA,  0x000208),
+	REG(VCAP_UPDATE_CTRL_COUNTER_DATA, 0x000308),
+	REG(VCAP_CACHE_DATA_TYPE,          0x000388),
+};
+
 static const u32 *ocelot_regmap[] = {
 	[ANA] = ocelot_ana_regmap,
 	[QS] = ocelot_qs_regmap,
 	[QSYS] = ocelot_qsys_regmap,
 	[REW] = ocelot_rew_regmap,
 	[SYS] = ocelot_sys_regmap,
+	[PTP] = ocelot_ptp_regmap,
+	[VCAP] = ocelot_vcap_regmap,
 };
 
 static const struct reg_field ocelot_regfields[] = {
diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.h b/drivers/net/ethernet/mscc/ocelot_vcap.h
new file mode 100644
index 000000000000..836bf0a96a73
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2018 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_VCAP_H_
+#define _MSCC_OCELOT_VCAP_H_
+
+/* Three PTP entries per port:
+ * - PTP ver Ethernet
+ * - PTP dst port 319
+ * - PTP dst port 320
+ */
+#define VCAP_IS2_N_PTP_ENTRIES			3
+
+/* VCAP */
+
+#define VCAP_UPDATE_CTRL_UPDATE_SHOT		BIT(2)
+#define VCAP_UPDATE_CTRL_UPDATE_ADDR(x)		(((x) & 0x3) << 16)
+#define VCAP_UPDATE_CTRL_UPDATE_COUNTER_DIS	BIT(19)
+#define VCAP_UPDATE_CTRL_UPDATE_ACTION_DIS	BIT(20)
+#define VCAP_UPDATE_CTRL_UPDATE_ENTRY_DIS	BIT(21)
+#define VCAP_UPDATE_CTRL_UPDATE_CMD(x)		(((x) & 0x3) << 22)
+
+enum vcap_cmds {
+	VCAP_CMD_WRITE = 0,
+	VCAP_CMD_READ,
+	VCAP_CMD_MOVE_UP,
+	VCAP_CMD_MOVE_DOWN,
+	VCAP_CMD_INIT,
+};
+
+enum vcap_selector {
+	VCAP_SEL_COUNTER = BIT(0),
+	VCAP_SEL_ACTION  = BIT(1),
+	VCAP_SEL_ENTRY   = BIT(2),
+};
+
+struct vcap_data {
+	u32 entry[12];
+	u32 mask[12];
+	u32 action[4];
+	u32 counter;
+	u32 type_group;
+};
+
+/* VCAP IS2 lookup */
+
+#define VCAP_IS2_LKP_TYPE			0
+#define VCAP_IS2_LKP_INGRESS_PORT_MASK		13
+#define VCAP_IS2_LKP_MC				27
+#define VCAP_IS2_LKP_BC				28
+#define VCAP_IS2_LKP_VLAN			29
+#define VCAP_IS2_LKP_VID			30
+#define VCAP_IS2_LKP_IP4			46
+#define VCAP_IS2_LKP_DST_IP4			59
+#define VCAP_IS2_LKP_SRC_IP4			91
+#define VCAP_IS2_LKP_TCP			124
+#define VCAP_IS2_LKP_DPORT			125
+#define VCAP_IS2_LKP_SPORT			141
+#define VCAP_IS2_LKP_ETYPE			142
+
+/* Masks */
+#define VCAP_IS2_LKP_TYPE_M			0xf
+#define VCAP_IS2_LKP_INGRESS_PORT_MASK_M	0xfff
+#define VCAP_IS2_LKP_VID_M			0xfff
+#define VCAP_IS2_LKP_DST_IP4_M			0xffffffff
+#define VCAP_IS2_LKP_SRC_IP4_M			0xffffffff
+#define VCAP_IS2_LKP_DPORT_M			0xffff
+#define VCAP_IS2_LKP_SPORT_M			0xffff
+#define VCAP_IS2_LKP_ETYPE_M			0xffff
+
+/* IS2 lookup types */
+#define VCAP_IS2_LKP_TYPE_MAC_ETYPE		0
+#define VCAP_IS2_LKP_TYPE_TCP_UDP		4
+
+/* VCAP IS2 action */
+
+#define VCAP_IS2_ACT_MASK_MODE			5
+#define VCAP_IS2_ACT_PORT_MASK			20
+#define VCAP_IS2_ACT_REW_OP			31
+
+/* Masks */
+#define VCAP_IS2_ACT_PORT_MASK_M		0x7ff
+#define VCAP_IS2_ACT_REW_OP_M			0x1ff
+
+/* IS2 mask modes */
+#define VCAP_IS2_ACT_MASK_MODE_NOOP		0x0
+#define VCAP_IS2_ACT_MASK_MODE_FILTER		0x1
+
+/* IS2 REW OPS */
+#define VCAP_IS2_ACT_REW_OP_NOOP		0x0
+#define VCAP_IS2_ACT_REW_OP_PTP_ONE		0x2
+#define VCAP_IS2_ACT_REW_OP_PTP_TWO		0x3
+
+/* In addition to VCAP_IS2_REW_OP_PTP_ONE */
+#define VCAP_IS2_ACT_REW_OP_SUB_DELAY_1		(0x1 << 3)
+#define VCAP_IS2_ACT_REW_OP_SUB_DELAY_2		(0x2 << 3)
+#define VCAP_IS2_ACT_REW_OP_ADD_DELAY		(0x1 << 5)
+#define VCAP_IS2_ACT_REW_OP_ADD_SUB		(0x1 << 7)
+
+#endif
-- 
2.20.1

