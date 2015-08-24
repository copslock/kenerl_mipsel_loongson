Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 03:26:50 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.138]:43610 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007033AbbHXB0krnqZ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 03:26:40 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.140])
        by regular1.263xmail.com (Postfix) with SMTP id AE2E34FDC;
        Mon, 24 Aug 2015 09:26:35 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id B8449448;
        Mon, 24 Aug 2015 09:26:30 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <6e17f652e63631a8f0e4785e79c73e31>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 28138XSROJ4;
        Mon, 24 Aug 2015 09:26:33 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        dianders@chromium.org, linux-samsung-soc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v7 02/10] mmc: dw_mmc: use macro for HCON register operations
Date:   Mon, 24 Aug 2015 09:25:54 +0800
Message-Id: <1440379554-24444-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48985
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
---

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
index 9c91983..0a3c63c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2678,7 +2678,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 		* Check ADDR_CONFIG bit in HCON to find
 		* IDMAC address bus width
 		*/
-		addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
+		addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
 
 		if (addr_config == 1) {
 			/* host supports IDMAC in 64-bit address mode */
@@ -3060,7 +3060,7 @@ int dw_mci_probe(struct dw_mci *host)
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
 	 */
-	i = (mci_readl(host, HCON) >> 7) & 0x7;
+	i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
 	if (!i) {
 		host->push_data = dw_mci_push_data16;
 		host->pull_data = dw_mci_pull_data16;
@@ -3142,7 +3142,7 @@ int dw_mci_probe(struct dw_mci *host)
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
