Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2013 16:14:51 +0100 (CET)
Received: from mail-ea0-f180.google.com ([209.85.215.180]:43973 "EHLO
        mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820493Ab3K1POf18O4F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Nov 2013 16:14:35 +0100
Received: by mail-ea0-f180.google.com with SMTP id f15so5879220eak.39
        for <multiple recipients>; Thu, 28 Nov 2013 07:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=FcwWZgA+LMk/wf5Ykzx01oYDVBvEnRxjs6US+38xALc=;
        b=ndfXFX1CCjjvvzdQwnEKVZeDgivIsWDWTzKWXlBmfGJ1yInIATp7xePzjmo9xE5YPv
         OwETi6OLNhMnHFUAqZz9DEg/traD9r3S5TJTaF+CBx5V6oGWTkyVtsgqkulDIADzpLEy
         cHOzSkpvOiPzNZRUgKvM+E/GIYiwT4AYFum6mWISyK7Ucci9sD/a/d/j7S6h+O9bZ7QL
         eBQo6EelOwKSWhCJ42sWSkebhu7i2vd6fKayw5oJG1/Tu/jzXsP6vukdrfEl84jRcqau
         5v33bqD4Ps4i8H+klgjlpAGoLpTDMiX+3VlzCv5klgcag3YlMgdQPg1V7WjstqP+Hlld
         9kGA==
X-Received: by 10.15.110.75 with SMTP id cg51mr5933395eeb.42.1385651670083;
        Thu, 28 Nov 2013 07:14:30 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id o1sm30831439eea.10.2013.11.28.07.14.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 07:14:28 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [RFC][PATCH another try] MIPS: BCM47XX: Prepare support for GPIO buttons
Date:   Thu, 28 Nov 2013 16:14:24 +0100
Message-Id: <1385651664-17551-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38597
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

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
This is another try to implement GPIO buttons support. Instead of
re-implementing most of the gpio_keys code, I decided to modify
gpio_keys a bit. A proper patch was posted to the linux-input:
[PATCH] Input: gpio_keys - add ack_irq callback for HW that needs ACK
http://www.mail-archive.com/linux-input@vger.kernel.org/msg07071.html

This is just a RFC, we have to see if the above patch will be accepted
by linux-input guys first.
---
 arch/mips/bcm47xx/Kconfig           |    6 ++
 arch/mips/bcm47xx/Makefile          |    2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |    3 +
 arch/mips/bcm47xx/buttons.c         |  152 +++++++++++++++++++++++++++++++++++
 arch/mips/bcm47xx/setup.c           |    1 +
 5 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm47xx/buttons.c

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index 09fc922..28b7d4b 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -11,6 +11,9 @@ config BCM47XX_SSB
 	select SSB_PCICORE_HOSTMODE if PCI
 	select SSB_DRIVER_GPIO
 	select GPIOLIB
+	select INPUT
+	select INPUT_KEYBOARD
+	select KEYBOARD_GPIO
 	select LEDS_GPIO_REGISTER
 	default y
 	help
@@ -28,6 +31,9 @@ config BCM47XX_BCMA
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	select BCMA_DRIVER_GPIO
 	select GPIOLIB
+	select INPUT
+	select INPUT_KEYBOARD
+	select KEYBOARD_GPIO
 	select LEDS_GPIO_REGISTER
 	default y
 	help
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
index 0000000..bec9f61
--- /dev/null
+++ b/arch/mips/bcm47xx/buttons.c
@@ -0,0 +1,152 @@
+#include "bcm47xx_private.h"
+
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/interrupt.h>
+#include <linux/ssb/ssb_embedded.h>
+#include <bcm47xx_board.h>
+#include <bcm47xx.h>
+
+struct input_dev *input;
+
+/**************************************************
+ * Database
+ **************************************************/
+
+static struct gpio_keys_button
+bcm47xx_buttons_netgear_wndr4500_v1[] = {
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
+ * Handlers
+ **************************************************/
+
+static void bcm47xx_buttons_gpio_polarity(u32 mask, u32 value)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		ssb_gpio_polarity(&bcm47xx_bus.ssb, mask, value);
+		return;
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		bcma_chipco_gpio_polarity(&bcm47xx_bus.bcma.bus.drv_cc, mask,
+					  value);
+		return;
+#endif
+	}
+	WARN_ON(1);
+}
+
+static void bcm47xx_buttons_irq(const struct gpio_keys_button *button)
+{
+	int gpio = button->gpio;
+	u32 val = __gpio_get_value(gpio);
+
+	/*
+	 * As soon as button state changes, adjust interrupt polarity.
+	 * This prevents hardware from keep generating interrupts for
+	 * the current state.
+	 */
+	bcm47xx_buttons_gpio_polarity(BIT(gpio), val ? BIT(gpio) : 0);
+}
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
+#define bcm47xx_set_bdata(dev_buttons) do {				\
+	bcm47xx_button_pdata.buttons = dev_buttons;			\
+	bcm47xx_button_pdata.nbuttons = ARRAY_SIZE(dev_buttons);	\
+} while (0)
+
+int __init bcm47xx_buttons_register(void)
+{
+#ifdef CONFIG_BCM47XX_SSB
+	struct ssb_bus *ssb;
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	struct bcma_drv_cc *bcma_cc;
+#endif
+	enum bcm47xx_board board = bcm47xx_board_get();
+	u32 gpio_mask = 0;
+	int i, err;
+
+	switch (board) {
+	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
+		bcm47xx_set_bdata(bcm47xx_buttons_netgear_wndr4500_v1);
+		break;
+	default:
+		pr_debug("No buttons configuration found for this device\n");
+		return -ENOTSUPP;
+	}
+
+	for (i = 0; i < bcm47xx_button_pdata.nbuttons; i++)
+		bcm47xx_button_pdata.buttons[i].ack_irq = bcm47xx_buttons_irq;
+
+	err = platform_device_register(&bcm47xx_buttons_gpio_keys);
+	if (err) {
+		pr_err("Failed to register platform device: %d\n", err);
+		return err;
+	}
+
+	for (i = 0; i < bcm47xx_button_pdata.nbuttons; i++) {
+		struct gpio_keys_button *button =
+			&bcm47xx_button_pdata.buttons[i];
+		int gpio = button->gpio;
+		int val = __gpio_get_value(gpio);
+
+		bcm47xx_buttons_gpio_polarity(BIT(gpio), val ? BIT(gpio) : 0);
+		gpio_mask |= BIT(gpio);
+	}
+
+	/*
+	 * Set a list of GPIOs that should generate interrupts and enable GPIO
+	 * interrupts in the ChipCommon core.
+	 */
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		ssb = &bcm47xx_bus.ssb;
+		ssb_gpio_intmask(ssb, gpio_mask, gpio_mask);
+		if (&ssb->chipco)
+			chipco_set32(&ssb->chipco, SSB_CHIPCO_IRQMASK,
+				     SSB_CHIPCO_IRQ_GPIO);
+		break;
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		bcma_cc = &bcm47xx_bus.bcma.bus.drv_cc;
+		bcma_chipco_gpio_intmask(bcma_cc, gpio_mask, gpio_mask);
+		bcma_cc_set32(bcma_cc, BCMA_CC_IRQMASK, BCMA_CC_IRQ_GPIO);
+		break;
+#endif
+	}
+
+	return 0;
+}
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 7e61c0b..a791124 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -242,6 +242,7 @@ static int __init bcm47xx_register_bus_complete(void)
 #endif
 	}
 
+	bcm47xx_buttons_register();
 	bcm47xx_leds_register();
 
 	return 0;
-- 
1.7.10.4
