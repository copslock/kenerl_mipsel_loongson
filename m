Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2018 22:57:54 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:39849
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeDHU5sD0JOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2018 22:57:48 +0200
Received: by mail-wr0-x242.google.com with SMTP id c24so6746496wrc.6;
        Sun, 08 Apr 2018 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6RQ0lsmitRDGAR+onL5dSs9M5RvRAZ3MT5fHWhMlY4=;
        b=bKYXGlFcQcL4ivZdhQXKZ215ew8IlmZliy2eavWQFFI4P5SmGAXdWM74khfAIf98b4
         D1h7IOE6znh0LIS7TgLXIBGGacJfSyCwnDwdW1SuU4qikO/qlTvbq58W/keniYujKRCK
         lxjSlKBdksvVvPyR4CqovgCarXQ3MER8zj5BhCRQo7KufFYaTPTDMMhADuKX2g4ZNGDS
         zvk10LmWQPXos3hlVs9mIRfErv4rq3E4VQ2W5qa6C10FvbqZI/3lqKxTaSkGqmkHmlry
         efshuQPYWGHsrXm8O36orgCZHxP3DPB9OEZhAcxNOwkv1DzzRfojluTzozrPqC/QeOrN
         dqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6RQ0lsmitRDGAR+onL5dSs9M5RvRAZ3MT5fHWhMlY4=;
        b=q19FcRvVsTZA47MOQMtG8RlPf3uNJWTrM/Y9WXo1/UU4v8tcN1ct2tPyjYzIQP4vv2
         9xwFBxFNE1IteaY5FGnIZr+/+LFn0XZeSZWnZHqJdErV73+JOpk+7gqpku3b0S3nak18
         l7ir2OkRWZ8eZmTLkX2TNrquOWqywOWhhrlSkbT6cOkxjinT4OOgpIsxYlhDPKzBluuq
         AcmpI5qfid28gQ4IMPIwTLXazQ4g4wgNT3BoC8drkNXK/r5OxiSwn3iz2S6fVQXoOU7z
         X/VpURbpYto/W/txAHN6oLE91eaGRmXAkT+928YnEPjm23aWlOnx6Z9II1/gy+Kebuqr
         XSEw==
X-Gm-Message-State: ALQs6tB6KMIp5u0QrvCy88C4RBByItS45nFGcvjrPdxaApeV2WoVX02G
        DPIktox/qRs1vpC86p4xY18=
X-Google-Smtp-Source: AIpwx49KR/iQtG39PFoB1BmEO6F8hpFMoS4j8He6JyVc6NhmBopLLjhHOF9DXhSDInupxgdBe3j7NQ==
X-Received: by 2002:a19:59d1:: with SMTP id n200-v6mr20235768lfb.84.1523221062521;
        Sun, 08 Apr 2018 13:57:42 -0700 (PDT)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o2sm2558271lja.86.2018.04.08.13.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 13:57:41 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] MIPS: BCM47XX: Add support for Netgear WNR1000 V3
Date:   Sun,  8 Apr 2018 22:57:32 +0200
Message-Id: <20180408205733.9026-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63429
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

From: Rafał Miłecki <rafal@milecki.pl>

This adds support for detecting this model board and registers some LEDs
and buttons.

There are two uncommon things regarding this device:
1) It can use two different "board_id" ID values.
   Unit I have uses "U12H139T00_NETGEAR" value. This magic is also used
   in firmware file header. There are two reports (one from an OpenWrt
   user) of a different "U12H139T50_NETGEAR" magic though.
2) Power LEDs share GPIOs with buttons.
   Amber one seems to share GPIO 2 with WPS button and green one seems
   to share GPIO 3 with reset button. It remains unknown how to support
   them and handle buttons at the same time. For that reason they aren't
   added to the list of supported LEDs.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/mips/bcm47xx/board.c                          | 2 ++
 arch/mips/bcm47xx/buttons.c                        | 9 +++++++++
 arch/mips/bcm47xx/leds.c                           | 9 +++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h | 1 +
 4 files changed, 21 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index edfaef0d73a4..a80910d2738c 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -172,6 +172,8 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
 	{{BCM47XX_BOARD_NETGEAR_WNDR4000, "Netgear WNDR4000"}, "U12H181T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR4500V1, "Netgear WNDR4500 V1"}, "U12H189T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR4500V2, "Netgear WNDR4500 V2"}, "U12H224T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR1000_V3, "Netgear WNR1000 V3"}, "U12H139T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR1000_V3, "Netgear WNR1000 V3"}, "U12H139T50_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR2000, "Netgear WNR2000"}, "U12H114T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "U12H136T99_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500U, "Netgear WNR3500U"}, "U12H136T00_NETGEAR"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 88d400d256c4..977990a609ba 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -412,6 +412,12 @@ bcm47xx_buttons_netgear_wndr4500v1[] __initconst = {
 };
 
 static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wnr1000_v3[] __initconst = {
+	BCM47XX_GPIO_KEY(2, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(3, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
 bcm47xx_buttons_netgear_wnr3500lv1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
@@ -670,6 +676,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR1000_V3:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr1000_v3);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr3500lv1);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 34a7b3fbdfd9..3fe015602945 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -498,6 +498,12 @@ bcm47xx_leds_netgear_wndr4500v1[] __initconst = {
 };
 
 static const struct gpio_led
+bcm47xx_leds_netgear_wnr1000_v3[] __initconst = {
+	BCM47XX_GPIO_LED(0, "blue", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "green", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
 bcm47xx_leds_netgear_wnr3500lv1[] __initconst = {
 	BCM47XX_GPIO_LED(0, "blue", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(1, "green", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
@@ -758,6 +764,9 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr4500v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR1000_V3:
+		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr1000_v3);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr3500lv1);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index cbf9da7f2f94..0ef8893e07f8 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -110,6 +110,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_NETGEAR_WNDR4000,
 	BCM47XX_BOARD_NETGEAR_WNDR4500V1,
 	BCM47XX_BOARD_NETGEAR_WNDR4500V2,
+	BCM47XX_BOARD_NETGEAR_WNR1000_V3,
 	BCM47XX_BOARD_NETGEAR_WNR2000,
 	BCM47XX_BOARD_NETGEAR_WNR3500L,
 	BCM47XX_BOARD_NETGEAR_WNR3500U,
-- 
2.11.0
