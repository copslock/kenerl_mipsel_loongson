Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:40:19 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58595 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827513Ab3BOOicgQuUB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:32 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GkwtkL3vTB7U; Fri, 15 Feb 2013 15:38:21 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5414C2802DD;
        Fri, 15 Feb 2013 15:38:21 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 05/11] MIPS: ath79: add GPIO setup code for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:19 +0100
Message-Id: <1360939105-23591-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35758
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

The existing code can handle the GPIO controller of
the QCA955x SoCs. Add a minimal glue code to make it
working.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/gpio.c                         |    4 +++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index b7ed207..8d025b0 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -194,12 +194,14 @@ void __init ath79_gpio_init(void)
 		ath79_gpio_count = AR933X_GPIO_COUNT;
 	else if (soc_is_ar934x())
 		ath79_gpio_count = AR934X_GPIO_COUNT;
+	else if (soc_is_qca955x())
+		ath79_gpio_count = QCA955X_GPIO_COUNT;
 	else
 		BUG();
 
 	ath79_gpio_base = ioremap_nocache(AR71XX_GPIO_BASE, AR71XX_GPIO_SIZE);
 	ath79_gpio_chip.ngpio = ath79_gpio_count;
-	if (soc_is_ar934x()) {
+	if (soc_is_ar934x() || soc_is_qca955x()) {
 		ath79_gpio_chip.direction_input = ar934x_gpio_direction_input;
 		ath79_gpio_chip.direction_output = ar934x_gpio_direction_output;
 	}
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 8782d8b..4868ed5 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -510,6 +510,7 @@
 #define AR913X_GPIO_COUNT		22
 #define AR933X_GPIO_COUNT		30
 #define AR934X_GPIO_COUNT		23
+#define QCA955X_GPIO_COUNT		24
 
 /*
  * SRIF block
-- 
1.7.10
