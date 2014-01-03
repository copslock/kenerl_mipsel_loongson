Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 09:55:45 +0100 (CET)
Received: from mail-ee0-f43.google.com ([74.125.83.43]:41618 "EHLO
        mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825707AbaACIzmIQsvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 09:55:42 +0100
Received: by mail-ee0-f43.google.com with SMTP id c13so6553658eek.2
        for <multiple recipients>; Fri, 03 Jan 2014 00:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=F2QyBIM2PFUvxA6u9Duc7y3Mr2gvjWg2RGMTqXHDSvA=;
        b=aMR1X2keFi20FEHXM2cFb5qmA5LR45rspMUygZdbr7xnYMwS6AHJHwSNb4jql2gr7v
         IWyAmOK2/ee/pF/AwSlvwjxirOaMgvNPBCy6xJUxE0uKOLF1+hTCYqln9hyhs+Cm6iH7
         uV5v86d65iqrlnFLF2SU3TFeCWYbdFDXaEffQ2KxglRCn28qUw5XE4h+zSwlygSRIusv
         lAi80tBDqDoy6H32xZ8nbUJUA+gcT5YOvt6ca03X9t8/t8DC2rr+KbxFCpXfEbJRpMtv
         NHbbnWPMDpP4596dZ2KJXMYkCjPTFOS07AAipnu3lSOGvWwlxhPyYsV+eunME9EKFeQR
         ptDg==
X-Received: by 10.15.48.70 with SMTP id g46mr85844eew.116.1388739336788;
        Fri, 03 Jan 2014 00:55:36 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id o1sm143102647eea.10.2014.01.03.00.55.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2014 00:55:35 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] ssb: gpio: add own IRQ domain
Date:   Fri,  3 Jan 2014 09:55:29 +0100
Message-Id: <1388739330-420-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38860
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


Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/Kconfig       |    1 +
 drivers/ssb/driver_gpio.c |  304 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/ssb/main.c        |   12 +-
 include/linux/ssb/ssb.h   |    1 +
 4 files changed, 297 insertions(+), 21 deletions(-)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 2cd9b0e..75b3603 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -168,6 +168,7 @@ config SSB_DRIVER_GIGE
 config SSB_DRIVER_GPIO
 	bool "SSB GPIO driver"
 	depends on SSB && GPIOLIB
+	select IRQ_DOMAIN if SSB_EMBEDDED
 	help
 	  Driver to provide access to the GPIO pins on the bus.
 
diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index dc109de..e7230fe 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -9,16 +9,40 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/export.h>
 #include <linux/ssb/ssb.h>
 
 #include "ssb_private.h"
 
+
+/**************************************************
+ * Shared
+ **************************************************/
+
 static struct ssb_bus *ssb_gpio_get_bus(struct gpio_chip *chip)
 {
 	return container_of(chip, struct ssb_bus, gpio);
 }
 
+#if IS_BUILTIN(CONFIG_SSB_EMBEDDED)
+static int ssb_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ssb_bus *bus = ssb_gpio_get_bus(chip);
+
+	if (bus->bustype == SSB_BUSTYPE_SSB)
+		return irq_find_mapping(bus->irq_domain, gpio);
+	else
+		return -EINVAL;
+}
+#endif
+
+/**************************************************
+ * ChipCommon
+ **************************************************/
+
 static int ssb_gpio_chipco_get_value(struct gpio_chip *chip, unsigned gpio)
 {
 	struct ssb_bus *bus = ssb_gpio_get_bus(chip);
@@ -74,19 +98,129 @@ static void ssb_gpio_chipco_free(struct gpio_chip *chip, unsigned gpio)
 	ssb_chipco_gpio_pullup(&bus->chipco, 1 << gpio, 0);
 }
 
-static int ssb_gpio_chipco_to_irq(struct gpio_chip *chip, unsigned gpio)
+#if IS_BUILTIN(CONFIG_SSB_EMBEDDED)
+static void ssb_gpio_irq_chipco_mask(struct irq_data *d)
 {
-	struct ssb_bus *bus = ssb_gpio_get_bus(chip);
+	struct ssb_bus *bus = irq_data_get_irq_chip_data(d);
+	int gpio = irqd_to_hwirq(d);
 
-	if (bus->bustype == SSB_BUSTYPE_SSB)
-		return ssb_mips_irq(bus->chipco.dev) + 2;
-	else
-		return -EINVAL;
+	ssb_chipco_gpio_intmask(&bus->chipco, BIT(gpio), 0);
+}
+
+static void ssb_gpio_irq_chipco_unmask(struct irq_data *d)
+{
+	struct ssb_bus *bus = irq_data_get_irq_chip_data(d);
+	int gpio = irqd_to_hwirq(d);
+	u32 val = ssb_chipco_gpio_in(&bus->chipco, BIT(gpio));
+
+	ssb_chipco_gpio_polarity(&bus->chipco, BIT(gpio), val);
+	ssb_chipco_gpio_intmask(&bus->chipco, BIT(gpio), BIT(gpio));
+}
+
+static struct irq_chip ssb_gpio_irq_chipco_chip = {
+	.name		= "SSB-GPIO-CC",
+	.irq_mask	= ssb_gpio_irq_chipco_mask,
+	.irq_unmask	= ssb_gpio_irq_chipco_unmask,
+};
+
+static irqreturn_t ssb_gpio_irq_chipco_handler(int irq, void *dev_id)
+{
+	struct ssb_bus *bus = dev_id;
+	struct ssb_chipcommon *chipco = &bus->chipco;
+	u32 val = chipco_read32(chipco, SSB_CHIPCO_GPIOIN);
+	u32 mask = chipco_read32(chipco, SSB_CHIPCO_GPIOIRQ);
+	u32 pol = chipco_read32(chipco, SSB_CHIPCO_GPIOPOL);
+	u32 irqs = (val ^ pol) & mask;
+	int gpio;
+
+	if (!irqs)
+		return IRQ_NONE;
+
+	for_each_set_bit(gpio, (unsigned long *)&irqs, bus->gpio.ngpio)
+		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+	ssb_chipco_gpio_polarity(chipco, irqs, val & irqs);
+
+	return IRQ_HANDLED;
+}
+
+static int ssb_gpio_irq_chipco_domain_init(struct ssb_bus *bus)
+{
+	struct ssb_chipcommon *chipco = &bus->chipco;
+	struct gpio_chip *chip = &bus->gpio;
+	int gpio, hwirq, err;
+
+	if (bus->bustype != SSB_BUSTYPE_SSB)
+		return 0;
+
+	bus->irq_domain = irq_domain_add_linear(NULL, chip->ngpio,
+						&irq_domain_simple_ops, chipco);
+	if (!bus->irq_domain) {
+		err = -ENODEV;
+		goto err_irq_domain;
+	}
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_create_mapping(bus->irq_domain, gpio);
+
+		irq_set_chip_data(irq, bus);
+		irq_set_chip_and_handler(irq, &ssb_gpio_irq_chipco_chip,
+					 handle_simple_irq);
+	}
+
+	hwirq = ssb_mips_irq(bus->chipco.dev) + 2;
+	err = request_irq(hwirq, ssb_gpio_irq_chipco_handler, IRQF_SHARED,
+			  "gpio", bus);
+	if (err)
+		goto err_req_irq;
+
+	ssb_chipco_gpio_intmask(&bus->chipco, ~0, 0);
+	chipco_set32(chipco, SSB_CHIPCO_IRQMASK, SSB_CHIPCO_IRQ_GPIO);
+
+	return 0;
+
+err_req_irq:
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_find_mapping(bus->irq_domain, gpio);
+
+		irq_dispose_mapping(irq);
+	}
+	irq_domain_remove(bus->irq_domain);
+err_irq_domain:
+	return err;
+}
+
+static void ssb_gpio_irq_chipco_domain_exit(struct ssb_bus *bus)
+{
+	struct ssb_chipcommon *chipco = &bus->chipco;
+	struct gpio_chip *chip = &bus->gpio;
+	int gpio;
+
+	if (bus->bustype != SSB_BUSTYPE_SSB)
+		return;
+
+	chipco_mask32(chipco, SSB_CHIPCO_IRQMASK, ~SSB_CHIPCO_IRQ_GPIO);
+	free_irq(ssb_mips_irq(bus->chipco.dev) + 2, chipco);
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_find_mapping(bus->irq_domain, gpio);
+
+		irq_dispose_mapping(irq);
+	}
+	irq_domain_remove(bus->irq_domain);
+}
+#else
+static int ssb_gpio_irq_chipco_domain_init(struct ssb_bus *bus)
+{
+	return 0;
+}
+
+static void ssb_gpio_irq_chipco_domain_exit(struct ssb_bus *bus)
+{
 }
+#endif
 
 static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 {
 	struct gpio_chip *chip = &bus->gpio;
+	int err;
 
 	chip->label		= "ssb_chipco_gpio";
 	chip->owner		= THIS_MODULE;
@@ -96,7 +230,8 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	chip->set		= ssb_gpio_chipco_set_value;
 	chip->direction_input	= ssb_gpio_chipco_direction_input;
 	chip->direction_output	= ssb_gpio_chipco_direction_output;
-	chip->to_irq		= ssb_gpio_chipco_to_irq;
+	if (IS_BUILTIN(CONFIG_SSB_EMBEDDED))
+		chip->to_irq	= ssb_gpio_to_irq;
 	chip->ngpio		= 16;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
@@ -106,9 +241,23 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	else
 		chip->base		= -1;
 
-	return gpiochip_add(chip);
+	err = ssb_gpio_irq_chipco_domain_init(bus);
+	if (err)
+		return err;
+
+	err = gpiochip_add(chip);
+	if (err) {
+		ssb_gpio_irq_chipco_domain_exit(bus);
+		return err;
+	}
+
+	return 0;
 }
 
+/**************************************************
+ * EXTIF
+ **************************************************/
+
 #ifdef CONFIG_SSB_DRIVER_EXTIF
 
 static int ssb_gpio_extif_get_value(struct gpio_chip *chip, unsigned gpio)
@@ -145,19 +294,127 @@ static int ssb_gpio_extif_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int ssb_gpio_extif_to_irq(struct gpio_chip *chip, unsigned gpio)
+#if IS_BUILTIN(CONFIG_SSB_EMBEDDED)
+static void ssb_gpio_irq_extif_mask(struct irq_data *d)
 {
-	struct ssb_bus *bus = ssb_gpio_get_bus(chip);
+	struct ssb_bus *bus = irq_data_get_irq_chip_data(d);
+	int gpio = irqd_to_hwirq(d);
 
-	if (bus->bustype == SSB_BUSTYPE_SSB)
-		return ssb_mips_irq(bus->extif.dev) + 2;
-	else
-		return -EINVAL;
+	ssb_extif_gpio_intmask(&bus->extif, BIT(gpio), 0);
+}
+
+static void ssb_gpio_irq_extif_unmask(struct irq_data *d)
+{
+	struct ssb_bus *bus = irq_data_get_irq_chip_data(d);
+	int gpio = irqd_to_hwirq(d);
+	u32 val = ssb_extif_gpio_in(&bus->extif, BIT(gpio));
+
+	ssb_extif_gpio_polarity(&bus->extif, BIT(gpio), val);
+	ssb_extif_gpio_intmask(&bus->extif, BIT(gpio), BIT(gpio));
 }
 
+static struct irq_chip ssb_gpio_irq_extif_chip = {
+	.name		= "SSB-GPIO-EXTIF",
+	.irq_mask	= ssb_gpio_irq_extif_mask,
+	.irq_unmask	= ssb_gpio_irq_extif_unmask,
+};
+
+static irqreturn_t ssb_gpio_irq_extif_handler(int irq, void *dev_id)
+{
+	struct ssb_bus *bus = dev_id;
+	struct ssb_extif *extif = &bus->extif;
+	u32 val = ssb_read32(extif->dev, SSB_EXTIF_GPIO_IN);
+	u32 mask = ssb_read32(extif->dev, SSB_EXTIF_GPIO_INTMASK);
+	u32 pol = ssb_read32(extif->dev, SSB_EXTIF_GPIO_INTPOL);
+	u32 irqs = (val ^ pol) & mask;
+	int gpio;
+
+	if (!irqs)
+		return IRQ_NONE;
+
+	for_each_set_bit(gpio, (unsigned long *)&irqs, bus->gpio.ngpio)
+		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+	ssb_extif_gpio_polarity(extif, irqs, val & irqs);
+
+	return IRQ_HANDLED;
+}
+
+static int ssb_gpio_irq_extif_domain_init(struct ssb_bus *bus)
+{
+	struct ssb_extif *extif = &bus->extif;
+	struct gpio_chip *chip = &bus->gpio;
+	int gpio, hwirq, err;
+
+	if (bus->bustype != SSB_BUSTYPE_SSB)
+		return 0;
+
+	bus->irq_domain = irq_domain_add_linear(NULL, chip->ngpio,
+						&irq_domain_simple_ops, extif);
+	if (!bus->irq_domain) {
+		err = -ENODEV;
+		goto err_irq_domain;
+	}
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_create_mapping(bus->irq_domain, gpio);
+
+		irq_set_chip_data(irq, bus);
+		irq_set_chip_and_handler(irq, &ssb_gpio_irq_extif_chip,
+					 handle_simple_irq);
+	}
+
+	hwirq = ssb_mips_irq(bus->extif.dev) + 2;
+	err = request_irq(hwirq, ssb_gpio_irq_extif_handler, IRQF_SHARED,
+			  "gpio", bus);
+	if (err)
+		goto err_req_irq;
+
+	ssb_extif_gpio_intmask(&bus->extif, ~0, 0);
+
+	return 0;
+
+err_req_irq:
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_find_mapping(bus->irq_domain, gpio);
+
+		irq_dispose_mapping(irq);
+	}
+	irq_domain_remove(bus->irq_domain);
+err_irq_domain:
+	return err;
+}
+
+static void ssb_gpio_irq_extif_domain_exit(struct ssb_bus *bus)
+{
+	struct ssb_extif *extif = &bus->extif;
+	struct gpio_chip *chip = &bus->gpio;
+	int gpio;
+
+	if (bus->bustype != SSB_BUSTYPE_SSB)
+		return;
+
+	free_irq(ssb_mips_irq(bus->extif.dev) + 2, extif);
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_find_mapping(bus->irq_domain, gpio);
+
+		irq_dispose_mapping(irq);
+	}
+	irq_domain_remove(bus->irq_domain);
+}
+#else
+static int ssb_gpio_irq_extif_domain_init(struct ssb_bus *bus)
+{
+	return 0;
+}
+
+static void ssb_gpio_irq_extif_domain_exit(struct ssb_bus *bus)
+{
+}
+#endif
+
 static int ssb_gpio_extif_init(struct ssb_bus *bus)
 {
 	struct gpio_chip *chip = &bus->gpio;
+	int err;
 
 	chip->label		= "ssb_extif_gpio";
 	chip->owner		= THIS_MODULE;
@@ -165,7 +422,8 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	chip->set		= ssb_gpio_extif_set_value;
 	chip->direction_input	= ssb_gpio_extif_direction_input;
 	chip->direction_output	= ssb_gpio_extif_direction_output;
-	chip->to_irq		= ssb_gpio_extif_to_irq;
+	if (IS_BUILTIN(CONFIG_SSB_EMBEDDED))
+		chip->to_irq	= ssb_gpio_to_irq;
 	chip->ngpio		= 5;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
@@ -175,7 +433,17 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	else
 		chip->base		= -1;
 
-	return gpiochip_add(chip);
+	err = ssb_gpio_irq_extif_domain_init(bus);
+	if (err)
+		return err;
+
+	err = gpiochip_add(chip);
+	if (err) {
+		ssb_gpio_irq_extif_domain_exit(bus);
+		return err;
+	}
+
+	return 0;
 }
 
 #else
@@ -185,6 +453,10 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 }
 #endif
 
+/**************************************************
+ * Init
+ **************************************************/
+
 int ssb_gpio_init(struct ssb_bus *bus)
 {
 	if (ssb_chipco_available(&bus->chipco))
diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 32a811d..2fead38 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -593,6 +593,13 @@ static int ssb_attach_queued_buses(void)
 		ssb_pcicore_init(&bus->pcicore);
 		if (bus->bustype == SSB_BUSTYPE_SSB)
 			ssb_watchdog_register(bus);
+
+		err = ssb_gpio_init(bus);
+		if (err == -ENOTSUPP)
+			ssb_dbg("GPIO driver not activated\n");
+		else if (err)
+			ssb_dbg("Error registering GPIO driver: %i\n", err);
+
 		ssb_bus_may_powerdown(bus);
 
 		err = ssb_devices_register(bus);
@@ -830,11 +837,6 @@ static int ssb_bus_register(struct ssb_bus *bus,
 	ssb_chipcommon_init(&bus->chipco);
 	ssb_extif_init(&bus->extif);
 	ssb_mipscore_init(&bus->mipscore);
-	err = ssb_gpio_init(bus);
-	if (err == -ENOTSUPP)
-		ssb_dbg("GPIO driver not activated\n");
-	else if (err)
-		ssb_dbg("Error registering GPIO driver: %i\n", err);
 	err = ssb_fetch_invariants(bus, get_invariants);
 	if (err) {
 		ssb_bus_may_powerdown(bus);
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index c64999f..07ef9b8 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -486,6 +486,7 @@ struct ssb_bus {
 #endif /* EMBEDDED */
 #ifdef CONFIG_SSB_DRIVER_GPIO
 	struct gpio_chip gpio;
+	struct irq_domain *irq_domain;
 #endif /* DRIVER_GPIO */
 
 	/* Internal-only stuff follows. Do not touch. */
-- 
1.7.10.4
