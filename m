Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Feb 2013 13:27:35 +0100 (CET)
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1067 "EHLO
        smtp-out-012.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817667Ab3BQM0rd7dSo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Feb 2013 13:26:47 +0100
Received: (qmail 16600 invoked by uid 0); 17 Feb 2013 12:26:43 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 16552
Received: from ppp-188-174-132-198.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [188.174.132.198]
  by 217.119.54.81 with SMTP; 17 Feb 2013 12:26:42 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Kristian Kielhofner <kris@krisk.org>,
        linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: sead3_led: Use LED_CORE_SUSPENDRESUME
Date:   Sun, 17 Feb 2013 13:28:22 +0100
Message-Id: <1361104102-13294-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 35783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Setting the LED_CORE_SUSPENDRESUME flag causes the LED driver core to call
led_classdev_suspend/led_classdev_resume during suspend/resume. Since this is
exactly what the driver's custom suspend/resume callbacks do we can replace them
by setting the LED_CORE_SUSPENDRESUME flag.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/mti-sead3/leds-sead3.c |   24 ++----------------------
 1 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/mips/mti-sead3/leds-sead3.c b/arch/mips/mti-sead3/leds-sead3.c
index 322148c..0a168c9 100644
--- a/arch/mips/mti-sead3/leds-sead3.c
+++ b/arch/mips/mti-sead3/leds-sead3.c
@@ -34,33 +34,15 @@ static void sead3_fled_set(struct led_classdev *led_cdev,
 static struct led_classdev sead3_pled = {
 	.name		= "sead3::pled",
 	.brightness_set = sead3_pled_set,
+	.flags		= LED_CORE_SUSPENDRESUME,
 };
 
 static struct led_classdev sead3_fled = {
 	.name		= "sead3::fled",
 	.brightness_set = sead3_fled_set,
+	.flags		= LED_CORE_SUSPENDRESUME,
 };
 
-#ifdef CONFIG_PM
-static int sead3_led_suspend(struct platform_device *dev,
-		pm_message_t state)
-{
-	led_classdev_suspend(&sead3_pled);
-	led_classdev_suspend(&sead3_fled);
-	return 0;
-}
-
-static int sead3_led_resume(struct platform_device *dev)
-{
-	led_classdev_resume(&sead3_pled);
-	led_classdev_resume(&sead3_fled);
-	return 0;
-}
-#else
-#define sead3_led_suspend NULL
-#define sead3_led_resume NULL
-#endif
-
 static int sead3_led_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -86,8 +68,6 @@ static int sead3_led_remove(struct platform_device *pdev)
 static struct platform_driver sead3_led_driver = {
 	.probe		= sead3_led_probe,
 	.remove		= sead3_led_remove,
-	.suspend	= sead3_led_suspend,
-	.resume		= sead3_led_resume,
 	.driver		= {
 		.name		= DRVNAME,
 		.owner		= THIS_MODULE,
-- 
1.7.2.5
