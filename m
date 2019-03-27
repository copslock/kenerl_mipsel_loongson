Return-Path: <SRS0=CBLp=R6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003EEC43381
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 21:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B5520700
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 21:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfC0VLw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:11:52 -0400
Received: from mars.blocktrron.ovh ([51.254.112.43]:40549 "EHLO
        mail.blocktrron.ovh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0VLw (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 27 Mar 2019 17:11:52 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 17:11:50 EDT
Received: from localhost.localdomain (p200300E53F05A6005088A270B90FE34A.dip0.t-ipconnect.de [IPv6:2003:e5:3f05:a600:5088:a270:b90f:e34a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id DCA151FF17
        for <linux-mips@vger.kernel.org>; Wed, 27 Mar 2019 22:03:55 +0100 (CET)
From:   David Bauer <mail@david-bauer.net>
To:     linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: ath79: add missing QCA955x GMAC registers
Date:   Wed, 27 Mar 2019 22:03:43 +0100
Message-Id: <20190327210343.11336-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This adds missing GMAC register definitions for the Qualcomm Atheros
QCA955x series MIPS SoCs.

They originate from the platforms U-Boot code and the AVM FRITZ!WLAN
Repeater 450E's GPL tarball.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 .../mips/include/asm/mach-ath79/ar71xx_regs.h | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 284b4fa23e03..e3b2484ce83f 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -1245,7 +1245,12 @@
  */
 
 #define QCA955X_GMAC_REG_ETH_CFG	0x00
+#define QCA955X_GMAC_REG_SGMII_RESET	0x14
 #define QCA955X_GMAC_REG_SGMII_SERDES	0x18
+#define QCA955X_GMAC_REG_MR_AN_CONTROL	0x1c
+#define QCA955X_GMAC_REG_MR_AN_STATUS	0x20
+#define QCA955X_GMAC_REG_SGMII_CONFIG	0x34
+#define QCA955X_GMAC_REG_SGMII_DEBUG	0x58
 
 #define QCA955X_ETH_CFG_RGMII_EN	BIT(0)
 #define QCA955X_ETH_CFG_MII_GE0		BIT(1)
@@ -1267,9 +1272,58 @@
 #define QCA955X_ETH_CFG_TXE_DELAY_MASK	0x3
 #define QCA955X_ETH_CFG_TXE_DELAY_SHIFT	20
 
+#define QCA955X_SGMII_RESET_RX_CLK_N_RESET	0
+#define QCA955X_SGMII_RESET_RX_CLK_N		BIT(0)
+#define QCA955X_SGMII_RESET_TX_CLK_N		BIT(1)
+#define QCA955X_SGMII_RESET_RX_125M_N		BIT(2)
+#define QCA955X_SGMII_RESET_TX_125M_N		BIT(3)
+#define QCA955X_SGMII_RESET_HW_RX_125M_N	BIT(4)
+
 #define QCA955X_SGMII_SERDES_LOCK_DETECT_STATUS	BIT(15)
 #define QCA955X_SGMII_SERDES_RES_CALIBRATION_SHIFT 23
 #define QCA955X_SGMII_SERDES_RES_CALIBRATION_MASK 0xf
+
+#define QCA955X_MR_AN_CONTROL_SPEED_SEL1	BIT(6)
+#define QCA955X_MR_AN_CONTROL_DUPLEX_MODE	BIT(8)
+#define QCA955X_MR_AN_CONTROL_RESTART_AN	BIT(9)
+#define QCA955X_MR_AN_CONTROL_POWER_DOWN	BIT(11)
+#define QCA955X_MR_AN_CONTROL_AN_ENABLE		BIT(12)
+#define QCA955X_MR_AN_CONTROL_SPEED_SEL0	BIT(13)
+#define QCA955X_MR_AN_CONTROL_LOOPBACK		BIT(14)
+#define QCA955X_MR_AN_CONTROL_PHY_RESET		BIT(15)
+
+#define QCA955X_MR_AN_STATUS_EXT_CAP		BIT(0)
+#define QCA955X_MR_AN_STATUS_LINK_UP		BIT(2)
+#define QCA955X_MR_AN_STATUS_AN_ABILITY		BIT(3)
+#define QCA955X_MR_AN_STATUS_REMOTE_FAULT	BIT(4)
+#define QCA955X_MR_AN_STATUS_AN_COMPLETE	BIT(5)
+#define QCA955X_MR_AN_STATUS_NO_PREAMBLE	BIT(6)
+#define QCA955X_MR_AN_STATUS_BASE_PAGE		BIT(7)
+
+#define QCA955X_SGMII_CONFIG_MODE_CTRL_SHIFT		0
+#define QCA955X_SGMII_CONFIG_MODE_CTRL_MASK		0x7
+#define QCA955X_SGMII_CONFIG_ENABLE_SGMII_TX_PAUSE	BIT(3)
+#define QCA955X_SGMII_CONFIG_MR_REG4_CHANGED		BIT(4)
+#define QCA955X_SGMII_CONFIG_FORCE_SPEED		BIT(5)
+#define QCA955X_SGMII_CONFIG_SPEED_SHIFT		6
+#define QCA955X_SGMII_CONFIG_SPEED_MASK			0xc0
+#define QCA955X_SGMII_CONFIG_REMOTE_PHY_LOOPBACK	BIT(8)
+#define QCA955X_SGMII_CONFIG_NEXT_PAGE_LOADED		BIT(9)
+#define QCA955X_SGMII_CONFIG_MDIO_ENABLE		BIT(10)
+#define QCA955X_SGMII_CONFIG_MDIO_PULSE			BIT(11)
+#define QCA955X_SGMII_CONFIG_MDIO_COMPLETE		BIT(12)
+#define QCA955X_SGMII_CONFIG_PRBS_ENABLE		BIT(13)
+#define QCA955X_SGMII_CONFIG_BERT_ENABLE		BIT(14)
+
+#define QCA955X_SGMII_DEBUG_TX_STATE_MASK	0xff
+#define QCA955X_SGMII_DEBUG_TX_STATE_SHIFT	0
+#define QCA955X_SGMII_DEBUG_RX_STATE_MASK	0xff00
+#define QCA955X_SGMII_DEBUG_RX_STATE_SHIFT	8
+#define QCA955X_SGMII_DEBUG_RX_SYNC_STATE_MASK	0xff0000
+#define QCA955X_SGMII_DEBUG_RX_SYNC_STATE_SHIFT	16
+#define QCA955X_SGMII_DEBUG_ARB_STATE_MASK	0xf000000
+#define QCA955X_SGMII_DEBUG_ARB_STATE_SHIFT	24
+
 /*
  * QCA956X GMAC Interface
  */
-- 
2.21.0

