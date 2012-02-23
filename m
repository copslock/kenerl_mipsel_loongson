Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:07:53 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47368 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903755Ab2BWQDe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:03:34 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 07/14] MIPS: lantiq: convert gpio_stp driver to clkdev api
Date:   Thu, 23 Feb 2012 17:03:06 +0100
Message-Id: <1330012993-13510-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Update from old pmu_{dis,en}able() to ckldev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/gpio_stp.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index e6b4809..8e07958 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/clk.h>
 
 #include <lantiq_soc.h>
 
@@ -78,8 +79,10 @@ static struct gpio_chip ltq_stp_chip = {
 	.owner = THIS_MODULE,
 };
 
-static int ltq_stp_hw_init(void)
+static int ltq_stp_hw_init(struct device *dev)
 {
+	struct clk *clk;
+
 	/* sane defaults */
 	ltq_stp_w32(0, LTQ_STP_AR);
 	ltq_stp_w32(0, LTQ_STP_CPU0);
@@ -105,7 +108,9 @@ static int ltq_stp_hw_init(void)
 	 */
 	ltq_stp_w32_mask(0, LTQ_STP_ADSL_SRC, LTQ_STP_CON0);
 
-	ltq_pmu_enable(PMU_LED);
+	clk = clk_get(dev, NULL);
+	WARN_ON(!clk);
+	clk_enable(clk);
 	return 0;
 }
 
@@ -138,7 +143,7 @@ static int __devinit ltq_stp_probe(struct platform_device *pdev)
 	}
 	ret = gpiochip_add(&ltq_stp_chip);
 	if (!ret)
-		ret = ltq_stp_hw_init();
+		ret = ltq_stp_hw_init(&pdev->dev);
 
 	return ret;
 }
-- 
1.7.7.1
