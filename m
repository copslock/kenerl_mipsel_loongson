Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2008 14:44:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:27103 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20035948AbYIBNoj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2008 14:44:39 +0100
Received: from localhost.localdomain (p4152-ipad313funabasi.chiba.ocn.ne.jp [123.217.230.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C2A96B523; Tue,  2 Sep 2008 22:44:32 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] RBTX4927: Add gpio-led support
Date:	Tue,  2 Sep 2008 22:44:38 +0900
Message-Id: <1220363078-4716-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/rbtx4927/setup.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 4a74423..01129a9 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -49,6 +49,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/leds.h>
 #include <asm/io.h>
 #include <asm/reboot.h>
 #include <asm/txx9/generic.h>
@@ -210,10 +211,6 @@ static void __init rbtx4927_mem_setup(void)
 	/* TX4927-SIO DTR on (PIO[15]) */
 	gpio_request(15, "sio-dtr");
 	gpio_direction_output(15, 1);
-	gpio_request(0, "led");
-	gpio_direction_output(0, 1);
-	gpio_request(1, "led");
-	gpio_direction_output(1, 1);
 
 	tx4927_sio_init(0, 0);
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
@@ -315,6 +312,25 @@ static void __init rbtx4927_mtd_init(void)
 		tx4927_mtd_init(i);
 }
 
+static void __init rbtx4927_gpioled_init(void)
+{
+	static struct gpio_led leds[] = {
+		{ .name = "gpioled:green:0", .gpio = 0, .active_low = 1, },
+		{ .name = "gpioled:green:1", .gpio = 1, .active_low = 1, },
+	};
+	static struct gpio_led_platform_data pdata = {
+		.num_leds = ARRAY_SIZE(leds),
+		.leds = leds,
+	};
+	struct platform_device *pdev = platform_device_alloc("leds-gpio", 0);
+
+	if (!pdev)
+		return;
+	pdev->dev.platform_data = &pdata;
+	if (platform_device_add(pdev))
+		platform_device_put(pdev);
+}
+
 static void __init rbtx4927_device_init(void)
 {
 	toshiba_rbtx4927_rtc_init();
@@ -322,6 +338,7 @@ static void __init rbtx4927_device_init(void)
 	tx4927_wdt_init();
 	rbtx4927_mtd_init();
 	txx9_iocled_init(RBTX4927_LED_ADDR - IO_BASE, -1, 3, 1, "green", NULL);
+	rbtx4927_gpioled_init();
 }
 
 struct txx9_board_vec rbtx4927_vec __initdata = {
-- 
1.5.6.3
