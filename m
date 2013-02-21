Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Feb 2013 02:12:36 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:50917 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827529Ab3BUBMdqexdp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Feb 2013 02:12:33 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1U8Khy-0001fs-IQ; Wed, 20 Feb 2013 19:12:22 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] MIPS: sead3: Use generic suspend/resume for LEDs.
Date:   Wed, 20 Feb 2013 19:12:17 -0600
Message-Id: <1361409137-2123-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Lars-Peter Clausen <lars@metafoo.de>

Setting the LED_CORE_SUSPENDRESUME flag causes the LED driver core to call
led_classdev_suspend/led_classdev_resume during suspend/resume. Since this is
exactly what the driver's custom suspend/resume callbacks do we can replace them
by setting the LED_CORE_SUSPENDRESUME flag.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mti-sead3/leds-sead3.c |   24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/mips/mti-sead3/leds-sead3.c b/arch/mips/mti-sead3/leds-sead3.c
index a95ac59..47e3c0d 100644
--- a/arch/mips/mti-sead3/leds-sead3.c
+++ b/arch/mips/mti-sead3/leds-sead3.c
@@ -34,33 +34,15 @@ static void sead3_fled_set(struct led_classdev *led_cdev,
 static struct led_classdev sead3_pled = {
 	.name		= "sead3::pled",
 	.brightness_set	= sead3_pled_set,
+	.flags		= LED_CORE_SUSPENDRESUME,
 };
 
 static struct led_classdev sead3_fled = {
 	.name		= "sead3::fled",
 	.brightness_set	= sead3_fled_set,
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
1.7.9.5
