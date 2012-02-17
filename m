Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:35:47 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36893 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903688Ab2BQKdU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:20 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 6/6] MIPS: lantiq: convert gpio_stp to managed gpio
Date:   Fri, 17 Feb 2012 11:32:51 +0100
Message-Id: <1329474771-20874-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474771-20874-1-git-send-email-blogic@openwrt.org>
References: <1329474771-20874-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

ltq_gpio_request() now uses devres to manage the gpios. We need to pass a
struct device pointer to make it work.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/gpio_stp.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index cb6f170..e6b4809 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -80,11 +80,6 @@ static struct gpio_chip ltq_stp_chip = {
 
 static int ltq_stp_hw_init(void)
 {
-	/* the 3 pins used to control the external stp */
-	ltq_gpio_request(4, 2, 1, "stp-st");
-	ltq_gpio_request(5, 2, 1, "stp-d");
-	ltq_gpio_request(6, 2, 1, "stp-sh");
-
 	/* sane defaults */
 	ltq_stp_w32(0, LTQ_STP_AR);
 	ltq_stp_w32(0, LTQ_STP_CPU0);
@@ -133,6 +128,14 @@ static int __devinit ltq_stp_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to remap STP memory\n");
 		return -ENOMEM;
 	}
+
+	/* the 3 pins used to control the external stp */
+	if (ltq_gpio_request(&pdev->dev, 4, 2, 1, "stp-st") ||
+			ltq_gpio_request(&pdev->dev, 5, 2, 1, "stp-d") ||
+			ltq_gpio_request(&pdev->dev, 6, 2, 1, "stp-sh")) {
+		dev_err(&pdev->dev, "failed to request needed gpios\n");
+		return -EBUSY;
+	}
 	ret = gpiochip_add(&ltq_stp_chip);
 	if (!ret)
 		ret = ltq_stp_hw_init();
-- 
1.7.7.1
