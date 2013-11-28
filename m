Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2013 11:32:57 +0100 (CET)
Received: from mail-ea0-f182.google.com ([209.85.215.182]:46461 "EHLO
        mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817037Ab3K1KcwUiqk4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Nov 2013 11:32:52 +0100
Received: by mail-ea0-f182.google.com with SMTP id o10so7805447eaj.27
        for <multiple recipients>; Thu, 28 Nov 2013 02:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=CFMlqpic8q+E9y1l6dmM8+HBtJE8RYRw84MVQ6ucg4A=;
        b=OemEvpLfTWSvzZqdXfesm/btYu1pTlBo0qhyjJXvBORf4OyElLANgTbsTCDD8PJjNo
         9HFEgkaxXqWO5QZx8dS8M+z8W/Uw4rF7DavKQbYKfpRS09GHeY2v6f0sKlLq6tGLxdgS
         VhEf3+mEO3WhoWPUZKDP/6wnAtLWVW/TfTPls4hVZOMbET+K8elNcqRcRBsbaeOBwQVJ
         V5h4k7O+gVqfLRvVC8LZRib+XRKmQMKeazUkYrKrjPOOYk56bVHJW+i8YMBGXNY+ZppI
         3jJwhUVogglVM8VF4IEYF1ihM24X0Uhf26e2jrktKZrOFKZUUMooXsO03VlODBk2/ewN
         9jqw==
X-Received: by 10.15.77.134 with SMTP id p6mr23314516eey.0.1385634766787;
        Thu, 28 Nov 2013 02:32:46 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id 1sm28395841eeg.4.2013.11.28.02.32.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 02:32:45 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Prepare support for GPIO buttons
Date:   Thu, 28 Nov 2013 11:32:38 +0100
Message-Id: <1385634758-22723-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38594
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
This should apply cleanly on top of (still not pushed):
MIPS: BCM47XX: Prepare support for LEDs
---
 arch/mips/bcm47xx/Kconfig           |    2 +
 arch/mips/bcm47xx/Makefile          |    2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |    3 +
 arch/mips/bcm47xx/buttons.c         |  225 +++++++++++++++++++++++++++++++++++
 arch/mips/bcm47xx/setup.c           |    1 +
 5 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm47xx/buttons.c

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index 09fc922..f3e9684 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -11,6 +11,7 @@ config BCM47XX_SSB
 	select SSB_PCICORE_HOSTMODE if PCI
 	select SSB_DRIVER_GPIO
 	select GPIOLIB
+	select INPUT
 	select LEDS_GPIO_REGISTER
 	default y
 	help
@@ -28,6 +29,7 @@ config BCM47XX_BCMA
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	select BCMA_DRIVER_GPIO
 	select GPIOLIB
+	select INPUT
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
index 0000000..058cb64
--- /dev/null
+++ b/arch/mips/bcm47xx/buttons.c
@@ -0,0 +1,225 @@
+#include "bcm47xx_private.h"
+
+#include <linux/interrupt.h>
+#include <linux/input.h>
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
+struct bcm47xx_button {
+	unsigned int code;
+	int gpio;
+	bool active_low;
+	bool last_value;
+	struct work_struct work;
+};
+
+static struct bcm47xx_button
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
+static void bcm47xx_buttons_work(struct work_struct *work)
+{
+	struct bcm47xx_button *button =
+		container_of(work, struct bcm47xx_button, work);
+
+	input_event(input, EV_KEY, button->code, button->last_value ^ 1);
+	input_sync(input);
+}
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
+static irqreturn_t bcm47xx_buttons_irq(int irq, void *dev_id)
+{
+	struct bcm47xx_button *button = dev_id;
+	int gpio = button->gpio;
+	u32 val = __gpio_get_value(gpio);
+
+	if (val != button->last_value) {
+		button->last_value = val;
+
+		/*
+		 * As soon as button state changes, adjust interrupt polarity.
+		 * This prevents hardware from keep generating interrupts for
+		 * the current state.
+		 */
+		bcm47xx_buttons_gpio_polarity(BIT(gpio), val ? BIT(gpio) : 0);
+
+		schedule_work(&button->work);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/**************************************************
+ * Init
+ **************************************************/
+
+struct {
+	struct bcm47xx_button	*buttons;
+	int			num_buttons;
+} bcm47xx_buttons_bdata;
+
+#define bcm47xx_set_bdata(dev_buttons) do {				\
+	bcm47xx_buttons_bdata.buttons = dev_buttons;			\
+	bcm47xx_buttons_bdata.num_buttons = ARRAY_SIZE(dev_buttons);	\
+} while (0)
+
+static int __init bcm47xx_button_setup(struct bcm47xx_button *button)
+{
+	int gpio = button->gpio;
+	int val, err;
+
+	err = gpio_request_one(gpio, GPIOF_IN, "button");
+	if (err) {
+		pr_err("Failed to request GPIO %d, error %d\n", gpio, err);
+		return err;
+	}
+
+	gpio_direction_input(gpio);
+	val = __gpio_get_value(gpio);
+	bcm47xx_buttons_gpio_polarity(BIT(gpio), val ? BIT(gpio) : 0);
+	button->last_value = val;
+
+	val = gpio_to_irq(button->gpio);
+	err = request_irq(val, bcm47xx_buttons_irq, IRQF_SHARED, "gpio",
+			  button);
+	if (err) {
+		pr_err("Failed to reqeust irq %d\n", val);
+		gpio_free(gpio);
+		return err;
+	}
+
+	INIT_WORK(&button->work, bcm47xx_buttons_work);
+
+	return 0;
+}
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
+	input = input_allocate_device();
+	if (!input) {
+		err = -ENOMEM;
+		goto err_input_alloc;
+	}
+
+	input->name = "bcm47xx_buttons";
+
+	for (i = 0; i < bcm47xx_buttons_bdata.num_buttons; i++) {
+		struct bcm47xx_button *button;
+
+		button = &bcm47xx_buttons_bdata.buttons[i];
+		gpio_mask |= BIT(button->gpio);
+		err = bcm47xx_button_setup(button);
+		if (err)
+			goto err_buttons_setup;
+		input_set_capability(input, EV_KEY, button->code);
+	}
+
+	err = input_register_device(input);
+	if (err) {
+		pr_err("Unable to register input device, error: %d\n", err);
+		goto err_input_reg;
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
+
+err_input_reg:
+err_buttons_setup:
+	for (i = i - 1; i >= 0; i--) {
+		struct bcm47xx_button *button;
+
+		button = &bcm47xx_buttons_bdata.buttons[i];
+		free_irq(gpio_to_irq(button->gpio), button);
+		gpio_free(button->gpio);
+	}
+	input_free_device(input);
+err_input_alloc:
+	pr_err("Failed to register bcm47xx buttons, error: %d\n", err);
+	return err;
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
