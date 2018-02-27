Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2018 22:33:25 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:34440
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeB0VdM7eOeZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2018 22:33:12 +0100
Received: by mail-pf0-x242.google.com with SMTP id j20so121431pfi.1;
        Tue, 27 Feb 2018 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vs8gOP8sc9ZMl4HVa8o6L+mffwGFEwFJ+pdLw8weh1g=;
        b=MbWh3c2t1smBsFbR4bfl4SfwMvDLTABxh0Od5kdnZSqcCAWQpQcHUg9wDo0k5h6C4/
         X2wfujJZmuSE6ZMT+UU/4iAvZDVSiQ2kn3su60HgcgqDGyLcR8sj+EbRxc4rLNZzuRmp
         FgWPXBnH/jHmyjrJe1bAqy1svAXk2AEopTeSihDQWG0luJZ9Ry9P6l/w5jN8Feb/hlo9
         1MX2qkczlWlawqPUIUMt0g5hTf8lCKJmrSMdeUZjHJhwGgyawStk5uvJy6WoOsnmLn5n
         WiTxu2aEc+5WD0nkzI8m1c0T3Q6QkFPoGgMuBWHjHpbWpmCr0iak2NZdUPF3vBJqGCVy
         4viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vs8gOP8sc9ZMl4HVa8o6L+mffwGFEwFJ+pdLw8weh1g=;
        b=CFtDSxMDY5yK/SyyiWzc5cVJEhooKafLj1lh2Mr/F0hULFWBBTONU6NwyqKuNrsBb3
         7KXWdTT8YpBSFBH0U3ZRDOJQ+AzI7ZTbQokFEl2Lnr2/XSum1YxEzKSxKBl/obknpB+N
         3vQv/DpbZElfY9IHfrce+MYL+6Gfvl6VpZe0aKVe3eaeABp+CB4oDYj7Tl8Qbk0R/GKb
         +onQC9nyMvp+o+8oWVvxstDP4MHeuxk6lF4OqnXT6greDx/6HqcTnWzJxKny1VTyH4Qw
         CRQe2G/Hz+UGif6ZOkShetDZgkvq/YJTebbo+akcOqfazNBIT8Rp2XShe14t7HFXk6JC
         clng==
X-Gm-Message-State: APf1xPDsffW5+6jLRAVHMMxFCNQEYIL2QYkd8K5qKEEkL0vxdC/iIU8U
        48ea6Zlfb6eTRIfKsCMCFJa8jxNl
X-Google-Smtp-Source: AH8x227TNot7cIC0QnEAyYZ4fgyKZvQWrX7AXxddUl/GD1nmUPe0u2gBrAIZhxNzGKl1lrpjfFcARw==
X-Received: by 10.99.134.65 with SMTP id x62mr12006267pgd.291.1519767186208;
        Tue, 27 Feb 2018 13:33:06 -0800 (PST)
Received: from localhost.localdomain ([67.139.187.132])
        by smtp.gmail.com with ESMTPSA id 202sm83820pgd.32.2018.02.27.13.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 13:33:05 -0800 (PST)
From:   Dan Haab <riproute@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Dan Haab <dan.haab@luxul.com>
Subject: [PATCH] MIPS: BCM47XX: Add Luxul XAP1500/XWR1750 WiFi LEDs
Date:   Tue, 27 Feb 2018 14:32:53 -0700
Message-Id: <1519767173-8918-1-git-send-email-riproute@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <riproute@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riproute@gmail.com
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

From: Dan Haab <dan.haab@luxul.com>

Some Luxul devices use PCIe connected GPIO LEDs that are not available
until the PCI subsytem and its drivers load. Using the same array for 
these LEDs would block registering any LEDs until all GPIOs become 
available. This may be undesired behavior as some LEDs should be 
available as early as possible (e.g. system status LED). This patch
will allow registering available LEDs while deffering these PCIe GPIO
connected 'extra' LEDs until they become available. 

Signed-off-by: Dan Haab <dan.haab@luxul.com>
---

diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 8307a8a..643a2bb 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -409,6 +409,12 @@
 };
 
 static const struct gpio_led
+bcm47xx_leds_luxul_xap1500_v1_extra[] __initconst = {
+	BCM47XX_GPIO_LED(44, "green", "5ghz", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(76, "green", "2ghz", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
 bcm47xx_leds_luxul_xbr_4400_v1[] __initconst = {
 	BCM47XX_GPIO_LED(12, "green", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED_TRIGGER(15, "green", "status", 0, "timer"),
@@ -435,6 +441,11 @@
 	BCM47XX_GPIO_LED(15, "green", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+static const struct gpio_led
+bcm47xx_leds_luxul_xwr1750_v1_extra[] __initconst = {
+	BCM47XX_GPIO_LED(76, "green", "2ghz", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 /* Microsoft */
 
 static const struct gpio_led
@@ -528,6 +539,12 @@
 	bcm47xx_leds_pdata.num_leds = ARRAY_SIZE(dev_leds);		\
 } while (0)
 
+static struct gpio_led_platform_data bcm47xx_leds_pdata_extra = {};
+#define bcm47xx_set_pdata_extra(dev_leds) do {				\
+	bcm47xx_leds_pdata_extra.leds = dev_leds;			\
+	bcm47xx_leds_pdata_extra.num_leds = ARRAY_SIZE(dev_leds);	\
+} while (0)
+
 void __init bcm47xx_leds_register(void)
 {
 	enum bcm47xx_board board = bcm47xx_board_get();
@@ -705,6 +722,7 @@ void __init bcm47xx_leds_register(void)
 		break;
 	case BCM47XX_BOARD_LUXUL_XAP_1500_V1:
 		bcm47xx_set_pdata(bcm47xx_leds_luxul_xap_1500_v1);
+		bcm47xx_set_pdata_extra(bcm47xx_leds_luxul_xap1500_v1_extra);
 		break;
 	case BCM47XX_BOARD_LUXUL_XBR_4400_V1:
 		bcm47xx_set_pdata(bcm47xx_leds_luxul_xbr_4400_v1);
@@ -717,6 +735,7 @@ void __init bcm47xx_leds_register(void)
 		break;
 	case BCM47XX_BOARD_LUXUL_XWR_1750_V1:
 		bcm47xx_set_pdata(bcm47xx_leds_luxul_xwr_1750_v1);
+		bcm47xx_set_pdata_extra(bcm47xx_leds_luxul_xwr1750_v1_extra);
 		break;
 
 	case BCM47XX_BOARD_MICROSOFT_MN700:
@@ -760,4 +779,6 @@ void __init bcm47xx_leds_register(void)
 	}
 
 	gpio_led_register_device(-1, &bcm47xx_leds_pdata);
+	if (bcm47xx_leds_pdata_extra.num_leds)
+		gpio_led_register_device(0, &bcm47xx_leds_pdata_extra);
 }
