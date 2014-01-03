Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 09:05:41 +0100 (CET)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:60289 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825707AbaACIEv6wf0w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 09:04:51 +0100
Received: by mail-ee0-f51.google.com with SMTP id b15so6576114eek.24
        for <multiple recipients>; Fri, 03 Jan 2014 00:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=XF3hg4lMHv6usbq/9SUwYPr6QwEsUXNWvdmhEBvtfd8=;
        b=mXzfO2vXrL8TqNZzOmv4yrF5HdWtq/oQu4Yz29Rv0kOqC9wEkjoFCxOWT32YyOYIHG
         wK/2mplflp4xkEC51rjQeTRCKAGg+SQ0NY5JzttGiHcc6Q8I8w0Zq+okPXPu/lAviJPs
         48jVO34oUU2OOZa9fKVIor8NX3egO1wj5pf6uXPXzsjGYztXsbpb+XN9GaXYmsjU+gLa
         gd6ZzXYxg5qpaLFc1oxFvZnkS4rjRNrTPCAHfo4bUbXcsLG175RoSX7/BqqO+fyz85x9
         s1X/rk/ycUkdIqwlHeeU6qK/f/2zab7DmNkskK27mw/wRBdyWPOj5oqt8yH18G8iENBi
         7S7g==
X-Received: by 10.15.77.134 with SMTP id p6mr73622363eey.0.1388736286091;
        Fri, 03 Jan 2014 00:04:46 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id e43sm142783146eep.7.2014.01.03.00.04.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2014 00:04:45 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Use "timer" trigger for status LEDs
Date:   Fri,  3 Jan 2014 09:04:39 +0100
Message-Id: <1388736279-18229-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Some devices have power LED as well as status LED. The second one is
used to show the firmware is up and running. Set "timer" trigger for
such LEDs.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/leds.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index cc141c1..28d281c 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -16,6 +16,16 @@
 		.default_state	= _default_state,			\
 	}
 
+#define BCM47XX_GPIO_LED_TRIGGER(_gpio, _color, _function, _active_low,	\
+				 _default_trigger)			\
+	{								\
+		.name		= "bcm47xx:" _color ":" _function,	\
+		.gpio		= _gpio,				\
+		.active_low	= _active_low,				\
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,		\
+		.default_trigger	= _default_trigger,		\
+	}
+
 /* Asus */
 
 static const struct gpio_led
@@ -176,13 +186,13 @@ bcm47xx_leds_dell_tm2300[] __initconst = {
 
 static const struct gpio_led
 bcm47xx_leds_dlink_dir130[] __initconst = {
-	BCM47XX_GPIO_LED(0, "green", "status", 1, LEDS_GPIO_DEFSTATE_OFF), /* Originally blinking when device is ready, separated from "power" LED */
+	BCM47XX_GPIO_LED_TRIGGER(0, "green", "status", 1, "timer"), /* Originally blinking when device is ready, separated from "power" LED */
 	BCM47XX_GPIO_LED(6, "blue", "unk", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
 static const struct gpio_led
 bcm47xx_leds_dlink_dir330[] __initconst = {
-	BCM47XX_GPIO_LED(0, "green", "status", 1, LEDS_GPIO_DEFSTATE_OFF), /* Originally blinking when device is ready, separated from "power" LED */
+	BCM47XX_GPIO_LED_TRIGGER(0, "green", "status", 1, "timer"), /* Originally blinking when device is ready, separated from "power" LED */
 	BCM47XX_GPIO_LED(4, "unk", "usb", 1, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(6, "blue", "unk", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
-- 
1.7.10.4
