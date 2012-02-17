Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:41:04 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36982 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901169Ab2BQKeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:34:07 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/3] MIPS: lantiq: make use of module_platform_driver()
Date:   Fri, 17 Feb 2012 11:33:52 +0100
Message-Id: <1329474832-21095-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474832-21095-1-git-send-email-blogic@openwrt.org>
References: <1329474832-21095-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Reduce boilerplate code.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/mtd/maps/lantiq-flash.c    |   20 ++------------------
 drivers/net/ethernet/lantiq_etop.c |   20 ++------------------
 drivers/watchdog/lantiq_wdt.c      |   17 ++---------------
 3 files changed, 6 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index 7b889de..e22436d 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -203,6 +203,7 @@ ltq_mtd_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver ltq_mtd_driver = {
+	.probe = ltq_mtd_probe,
 	.remove = __devexit_p(ltq_mtd_remove),
 	.driver = {
 		.name = "ltq_nor",
@@ -210,24 +211,7 @@ static struct platform_driver ltq_mtd_driver = {
 	},
 };
 
-static int __init
-init_ltq_mtd(void)
-{
-	int ret = platform_driver_probe(&ltq_mtd_driver, ltq_mtd_probe);
-
-	if (ret)
-		pr_err("ltq_nor: error registering platform driver");
-	return ret;
-}
-
-static void __exit
-exit_ltq_mtd(void)
-{
-	platform_driver_unregister(&ltq_mtd_driver);
-}
-
-module_init(init_ltq_mtd);
-module_exit(exit_ltq_mtd);
+module_platform_driver(ltq_mtd_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index fa2580b..4cfc314 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -943,6 +943,7 @@ ltq_etop_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver ltq_mii_driver = {
+	.probe = ltq_etop_probe,
 	.remove = __devexit_p(ltq_etop_remove),
 	.driver = {
 		.name = "ltq_etop",
@@ -950,24 +951,7 @@ static struct platform_driver ltq_mii_driver = {
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
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 05646b8..572ac60 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -227,6 +227,7 @@ ltq_wdt_remove(struct platform_device *pdev)
 
 
 static struct platform_driver ltq_wdt_driver = {
+	.probe = ltq_wdt_probe,
 	.remove = __devexit_p(ltq_wdt_remove),
 	.driver = {
 		.name = "ltq_wdt",
@@ -234,21 +235,7 @@ static struct platform_driver ltq_wdt_driver = {
 	},
 };
 
-static int __init
-init_ltq_wdt(void)
-{
-	return platform_driver_probe(&ltq_wdt_driver, ltq_wdt_probe);
-}
-
-static void __exit
-exit_ltq_wdt(void)
-{
-	return platform_driver_unregister(&ltq_wdt_driver);
-}
-
-module_init(init_ltq_wdt);
-module_exit(exit_ltq_wdt);
-
+module_platform_driver(ltq_wdt_driver);
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 
-- 
1.7.7.1
