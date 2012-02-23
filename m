Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:04:14 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47251 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903633Ab2BWQCQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:02:16 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        netdev@vger.kernel.org
Subject: [PATCH V2 4/6] NET: MIPS: lantiq: convert etop to managed gpio
Date:   Thu, 23 Feb 2012 17:01:51 +0100
Message-Id: <1330012913-13293-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012913-13293-1-git-send-email-blogic@openwrt.org>
References: <1330012913-13293-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32505
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
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/lantiq_etop.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 66ec54a..e5ec8b1 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -292,9 +292,6 @@ ltq_etop_gbit_init(void)
 {
 	ltq_pmu_enable(PMU_SWITCH);
 
-	ltq_gpio_request(42, 2, 1, "MDIO");
-	ltq_gpio_request(43, 2, 1, "MDC");
-
 	ltq_gbit_w32_mask(0, GCTL0_SE, LTQ_GBIT_GCTL0);
 	/** Disable MDIO auto polling mode */
 	ltq_gbit_w32_mask(0, PX_CTL_DMDIO, LTQ_GBIT_P0_CTL);
@@ -873,6 +870,12 @@ ltq_etop_probe(struct platform_device *pdev)
 			err = -ENOMEM;
 			goto err_out;
 		}
+		if (ltq_gpio_request(&pdev->dev, 42, 2, 1, "MDIO") ||
+				ltq_gpio_request(&pdev->dev, 43, 2, 1, "MDC")) {
+			dev_err(&pdev->dev, "failed to request MDIO gpios\n");
+			err = -EBUSY;
+			goto err_out;
+		}
 	}
 
 	dev = alloc_etherdev_mq(sizeof(struct ltq_etop_priv), 4);
-- 
1.7.7.1
