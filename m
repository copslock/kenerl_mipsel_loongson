Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2015 08:44:32 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.131]:60904 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006636AbbIPGo1lo1pJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2015 08:44:27 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.229])
        by lucky1.263xmail.com (Postfix) with SMTP id 5B28486BB0;
        Wed, 16 Sep 2015 14:44:16 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 16DD5473;
        Wed, 16 Sep 2015 14:44:05 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <4c64aec9ea39ab5146c17a4007cfc1d6>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 4758IC75U2;
        Wed, 16 Sep 2015 14:44:10 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        dianders@chromium.org, linux-samsung-soc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v8 02/10] mmc: dw_mmc: use macro for HCON register operations
Date:   Wed, 16 Sep 2015 14:41:37 +0800
Message-Id: <1442385697-28036-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

This patch add some macros for HCON register operations
to make code more readable.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 6 +++---
 drivers/mmc/host/dw_mmc.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5d7a8729..100f56e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2674,7 +2674,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 		* Check ADDR_CONFIG bit in HCON to find
 		* IDMAC address bus width
 		*/
-		addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
+		addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
 
 		if (addr_config == 1) {
 			/* host supports IDMAC in 64-bit address mode */
@@ -3051,7 +3051,7 @@ int dw_mci_probe(struct dw_mci *host)
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
 	 */
-	i = (mci_readl(host, HCON) >> 7) & 0x7;
+	i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
 	if (!i) {
 		host->push_data = dw_mci_push_data16;
 		host->pull_data = dw_mci_pull_data16;
@@ -3133,7 +3133,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->pdata->num_slots)
 		host->num_slots = host->pdata->num_slots;
 	else
-		host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
+		host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
 
 	/*
 	 * Enable interrupts for command done, data over, data empty,
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 811d467..f2a88d4 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -154,6 +154,9 @@
 #define DMA_INTERFACE_GDMA		(0x2)
 #define DMA_INTERFACE_NODMA		(0x3)
 #define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
+#define SDMMC_GET_SLOT_NUM(x)		((((x)>>1) & 0x1F) + 1)
+#define SDMMC_GET_HDATA_WIDTH(x)	(((x)>>7) & 0x7)
+#define SDMMC_GET_ADDR_CONFIG(x)	(((x)>>27) & 0x1)
 /* Internal DMAC interrupt defines */
 #define SDMMC_IDMAC_INT_AI		BIT(9)
 #define SDMMC_IDMAC_INT_NI		BIT(8)
-- 
2.3.7
