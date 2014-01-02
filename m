Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 13:31:51 +0100 (CET)
Received: from mail-ea0-f172.google.com ([209.85.215.172]:53017 "EHLO
        mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824805AbaABMbsCSNJ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 13:31:48 +0100
Received: by mail-ea0-f172.google.com with SMTP id q10so5369625ead.31
        for <multiple recipients>; Thu, 02 Jan 2014 04:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IMpRO2L+KSyXOxOifEyK0BHm2qqTzfAPTClXyOqocC0=;
        b=i4BLvrECYTkfrqygdbU6jksYUVy7oe4pzQgDvSmeoJUdbHvTzqp+Lv4l9oFaOMH5hA
         YSm/k5ifxEt6TNMKE2I2dKPwwyD27RBQ8sTv5zbeczVe/niEnBjYU4sF3/L+o2INB/Mg
         2bMRS4F8p3vMGhxiH9veMvnnbQbX1pCJynKV0GdmXk/XdAUK2/nBCqXYSIqiuMEQKFRT
         nyh46rbco47kWekDfd5HJC1ApLxRb2TpEXb6VjyZlWishv7KuNfg1m0I5r4ZDuORVwFx
         JYMd/YKu0SYJGNAhZcLS+VgBPbZulGAQR6oUY1on72I9JV6aYczV/Zhorh/DWeUGd7I2
         DH+A==
X-Received: by 10.15.54.72 with SMTP id s48mr67376348eew.3.1388665902780;
        Thu, 02 Jan 2014 04:31:42 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id g47sm135651717eeo.19.2014.01.02.04.31.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2014 04:31:42 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V4] MIPS: BCM47XX: Prepare support for GPIO buttons
Date:   Thu,  2 Jan 2014 13:31:32 +0100
Message-Id: <1388665892-12864-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1386689071-13170-1-git-send-email-zajec5@gmail.com>
References: <1386689071-13170-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38833
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

So far this adds support for one Netgear model only, but it's designed
and ready to add many more device. We could hopefully import database
from OpenWrt.
Support for SSB is currently disabled, because SSB doesn't implement IRQ
domain yet.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
V3: Use __initconst and copy data for detected device. This will allow
    us to free some memory after init.
V4: Use const for bcm47xx_buttons_netgear_wndr4500_v1
    Rebase on top of linux-john.git mips-next-3.14
---
 arch/mips/bcm47xx/Makefile          |    2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |    3 ++
 arch/mips/bcm47xx/buttons.c         |   95 +++++++++++++++++++++++++++++++++++
 arch/mips/bcm47xx/setup.c           |    1 +
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm47xx/buttons.c

diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 84e9aed..006a05e 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -4,5 +4,5 @@
 #
 
 obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
-obj-y				+= board.o leds.o
+obj-y				+= board.o buttons.o leds.o
 obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index 1a1e600..5c94ace 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -3,6 +3,9 @@
 
 #include <linux/kernel.h>
 
+/* buttons.c */
+int __init bcm47xx_buttons_register(void);
+
 /* leds.c */
 void __init bcm47xx_leds_register(void);
 
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
new file mode 100644
index 0000000..d93711b
--- /dev/null
+++ b/arch/mips/bcm47xx/buttons.c
@@ -0,0 +1,95 @@
+#include "bcm47xx_private.h"
+
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/interrupt.h>
+#include <linux/ssb/ssb_embedded.h>
+#include <bcm47xx_board.h>
+#include <bcm47xx.h>
+
+/**************************************************
+ * Database
+ **************************************************/
+
+static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wndr4500_v1[] __initconst = {
+	{
+		.code		= KEY_WPS_BUTTON,
+		.gpio		= 4,
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_RFKILL,
+		.gpio		= 5,
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_RESTART,
+		.gpio		= 6,
+		.active_low	= 1,
+	},
+};
+
+/**************************************************
+ * Init
+ **************************************************/
+
+static struct gpio_keys_platform_data bcm47xx_button_pdata;
+
+static struct platform_device bcm47xx_buttons_gpio_keys = {
+	.name = "gpio-keys",
+	.dev = {
+		.platform_data = &bcm47xx_button_pdata,
+	}
+};
+
+/* Copy data from __initconst */
+static int __init bcm47xx_buttons_copy(const struct gpio_keys_button *buttons,
+				       size_t nbuttons)
+{
+	size_t size = nbuttons * sizeof(*buttons);
+
+	bcm47xx_button_pdata.buttons = kmalloc(size, GFP_KERNEL);
+	if (!bcm47xx_button_pdata.buttons)
+		return -ENOMEM;
+	memcpy(bcm47xx_button_pdata.buttons, buttons, size);
+	bcm47xx_button_pdata.nbuttons = nbuttons;
+
+	return 0;
+}
+
+#define bcm47xx_copy_bdata(dev_buttons)					\
+	bcm47xx_buttons_copy(dev_buttons, ARRAY_SIZE(dev_buttons));
+
+int __init bcm47xx_buttons_register(void)
+{
+	enum bcm47xx_board board = bcm47xx_board_get();
+	int err;
+
+#ifdef CONFIG_BCM47XX_SSB
+	if (bcm47xx_bus_type == BCM47XX_BUS_TYPE_SSB) {
+		pr_debug("Buttons on SSB are not supported yet.\n");
+		return -ENOTSUPP;
+	}
+#endif
+
+	switch (board) {
+	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500_v1);
+		break;
+	default:
+		pr_debug("No buttons configuration found for this device\n");
+		return -ENOTSUPP;
+	}
+
+	if (err)
+		return -ENOMEM;
+
+	err = platform_device_register(&bcm47xx_buttons_gpio_keys);
+	if (err) {
+		pr_err("Failed to register platform device: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index bd84473..0bd4702 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -265,6 +265,7 @@ static int __init bcm47xx_register_bus_complete(void)
 #endif
 	}
 
+	bcm47xx_buttons_register();
 	bcm47xx_leds_register();
 
 	fixed_phy_add(PHY_POLL, 0, &bcm47xx_fixed_phy_status);
-- 
1.7.10.4
