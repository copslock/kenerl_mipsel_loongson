Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 19:24:22 +0200 (CEST)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:40014
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993890AbeC0RYQMezQy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 19:24:16 +0200
Received: by mail-pl0-x243.google.com with SMTP id x4-v6so14504992pln.7;
        Tue, 27 Mar 2018 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XNZFDPdvREU2dPTcWHhHDmf8mdY6X8hKx7eDh1RVjDM=;
        b=gujp8rckL49S4k+NXoWWYYPqphhdpcwZdTfu9gqkPAzHgcpc9LSfbzCHNxIvxkWHID
         YUada6S0im6LOWsCvf/81gAzUzWI4VvWnC/MMVeAYWJhal/Rd1p4MKwcainOGc18ZMEJ
         1R4N+LzMmQVocYJo5riT7pr/v3KKVbLKHq1yvaYKgtYpYOQm/YaLU3YAiyMo64/hAFLI
         Lxf6nOgrIfD3+o5AKv3cvlFKfLlGpw1945xtofnfQNSa56m+a4p5SCtCHY8vEF2sAMMH
         deeB1grgqCPF6F6aY94ON+D3sZs94mGSsZh68LG7+dUwQyYWjj5mAS+H7d+iWum/nezE
         lMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XNZFDPdvREU2dPTcWHhHDmf8mdY6X8hKx7eDh1RVjDM=;
        b=p3HPF5yVtwdfTVJcmLjXCnbw5wAxj+AMczfjQOckkh5q/oLbwwrrFnV0ZlS270W1Nt
         agdnEVMdpnapo/dYUhNgiM+UiL3GrlcyyTIR8M/VBYfkSz9lGooipQXND+to7fDlwzb3
         LfYlm+WHPs9arLgCNQmNd65JQh0WvktD5S6wgK9AM1eVfbdBcquoG1diQONJRzfh+EIl
         39qmXP/bADaNM7dICvFqyrZNfaFjDpPYcL7V3CGxLW7b5yU9ixfPJqWiHYpN8+ePKcyC
         nkzJNsqW9sAIe56eKkFwKvYe2QGu1y+l8qR9XS4Airs2C/ISfnLplLgf7ixgDOcCdote
         a49A==
X-Gm-Message-State: AElRT7EzTG/hTeix6uLAZVG7LAts8XOUi4KANKsZgosTSnEM1w7hwJLS
        m5mkc1mLQHmd9+DqOd6L0C3OGJ5+
X-Google-Smtp-Source: AIpwx4+h6XeDDaUP9PaA3r7KdUJX2yXq25VMnmXDw5Rfn4uWywCQCriXMm9S2FnBaopMl0dVmi3mOg==
X-Received: by 2002:a17:902:9686:: with SMTP id n6-v6mr163530plp.331.1522171449431;
        Tue, 27 Mar 2018 10:24:09 -0700 (PDT)
Received: from localhost.localdomain ([67.139.187.132])
        by smtp.gmail.com with ESMTPSA id s4sm3464624pgp.29.2018.03.27.10.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Mar 2018 10:24:08 -0700 (PDT)
From:   Dan Haab <riproute@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Dan Haab <dan.haab@luxul.com>
Subject: [PATCH V2] MIPS: BCM47XX: Add Luxul XAP1500/XWR1750 WiFi LEDs
Date:   Tue, 27 Mar 2018 11:24:34 -0600
Message-Id: <1522171474-3651-1-git-send-email-riproute@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519767173-8918-1-git-send-email-riproute@gmail.com>
References: <1519767173-8918-1-git-send-email-riproute@gmail.com>
Return-Path: <riproute@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63264
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
available as early as possible (e.g. system status LED). This patch will
allow registering available LEDs while deffering these PCIe GPIO
connected 'extra' LEDs until they become available.

Signed-off-by: Dan Haab <dan.haab@luxul.com>
---
 arch/mips/bcm47xx/leds.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 8307a8a..34a7b3f 100644
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
 
+static struct gpio_led_platform_data bcm47xx_leds_pdata_extra __initdata = {};
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
-- 
1.9.1
