Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 20:54:46 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:55425 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827653Ab3BOTyprJSjP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 20:54:45 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3VcDa7HpeQ7A; Fri, 15 Feb 2013 20:54:34 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 586CF280213;
        Fri, 15 Feb 2013 20:54:32 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH v2 08/11] MIPS: ath79: add WMAC registration code for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 20:54:33 +0100
Message-Id: <1360958073-19474-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The SoC has a built-in wireless MAC. Register a platform
device for that to make it usable with the ath9k driver.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v2: fix IRQ resource assignment
---
 arch/mips/ath79/Kconfig                        |    2 +-
 arch/mips/ath79/dev-wmac.c                     |   20 ++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 +++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index cffdc8e..77926e3 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -108,7 +108,7 @@ config ATH79_DEV_USB
 	def_bool n
 
 config ATH79_DEV_WMAC
-	depends on (SOC_AR913X || SOC_AR933X || SOC_AR934X)
+	depends on (SOC_AR913X || SOC_AR933X || SOC_AR934X || SOC_QCA955X)
 	def_bool n
 
 endif
diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
index d71d745..da190b1 100644
--- a/arch/mips/ath79/dev-wmac.c
+++ b/arch/mips/ath79/dev-wmac.c
@@ -116,6 +116,24 @@ static void ar934x_wmac_setup(void)
 		ath79_wmac_data.is_clk_25mhz = true;
 }
 
+static void qca955x_wmac_setup(void)
+{
+	u32 t;
+
+	ath79_wmac_device.name = "qca955x_wmac";
+
+	ath79_wmac_resources[0].start = QCA955X_WMAC_BASE;
+	ath79_wmac_resources[0].end = QCA955X_WMAC_BASE + QCA955X_WMAC_SIZE - 1;
+	ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
+	ath79_wmac_resources[1].end = ATH79_IP2_IRQ(1);
+
+	t = ath79_reset_rr(QCA955X_RESET_REG_BOOTSTRAP);
+	if (t & QCA955X_BOOTSTRAP_REF_CLK_40)
+		ath79_wmac_data.is_clk_25mhz = false;
+	else
+		ath79_wmac_data.is_clk_25mhz = true;
+}
+
 void __init ath79_register_wmac(u8 *cal_data)
 {
 	if (soc_is_ar913x())
@@ -124,6 +142,8 @@ void __init ath79_register_wmac(u8 *cal_data)
 		ar933x_wmac_setup();
 	else if (soc_is_ar934x())
 		ar934x_wmac_setup();
+	else if (soc_is_qca955x())
+		qca955x_wmac_setup();
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index bf50ddf..4728212 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -94,6 +94,9 @@
 #define AR934X_SRIF_BASE	(AR71XX_APB_BASE + 0x00116000)
 #define AR934X_SRIF_SIZE	0x1000
 
+#define QCA955X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
+#define QCA955X_WMAC_SIZE	0x20000
+
 /*
  * DDR_CTRL block
  */
-- 
1.7.10
