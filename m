Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:10:07 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47420 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903765Ab2BWQEE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:04:04 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        netdev@vger.kernel.org
Subject: [PATCH V2 2/3] NET: MIPS: lantiq: use module_platform_driver inside lantiq ethernet driver
Date:   Thu, 23 Feb 2012 17:03:43 +0100
Message-Id: <1330013024-13622-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330013024-13622-1-git-send-email-blogic@openwrt.org>
References: <1330013024-13622-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Reduce boilerplate code by converting driver to module_platform_driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/lantiq_etop.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 6b2e4b4..584794f 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -839,7 +839,7 @@ static const struct net_device_ops ltq_eth_netdev_ops = {
 	.ndo_tx_timeout = ltq_etop_tx_timeout,
 };
 
-static int __init
+static int __devinit
 ltq_etop_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
@@ -959,6 +959,7 @@ ltq_etop_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver ltq_mii_driver = {
+	.probe = ltq_etop_probe,
 	.remove = __devexit_p(ltq_etop_remove),
 	.driver = {
 		.name = "ltq_etop",
@@ -966,24 +967,7 @@ static struct platform_driver ltq_mii_driver = {
 	},
 };
 
-int __init
-init_ltq_etop(void)
-{
-	int ret = platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
-
-	if (ret)
-		pr_err("ltq_etop: Error registering platfom driver!");
-	return ret;
-}
-
-static void __exit
-exit_ltq_etop(void)
-{
-	platform_driver_unregister(&ltq_mii_driver);
-}
-
-module_init(init_ltq_etop);
-module_exit(exit_ltq_etop);
+module_platform_driver(ltq_mii_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
 MODULE_DESCRIPTION("Lantiq SoC ETOP");
-- 
1.7.7.1
