Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2013 17:10:17 +0100 (CET)
Received: from mail-ea0-f177.google.com ([209.85.215.177]:64218 "EHLO
        mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867275Ab3K2QKKHoqce (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Nov 2013 17:10:10 +0100
Received: by mail-ea0-f177.google.com with SMTP id n15so6868478ead.22
        for <multiple recipients>; Fri, 29 Nov 2013 08:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=UVQJ7ePWvZAr3VoASfsRZAYnsYT5M9l9VGVIc3p9HiA=;
        b=BqtoZq5vtLp1zBl5Bn5ULFhRbVmiz04eUMaMmCKZyNOuIKLrIJm1cxmOR9gjX28O4A
         e5FKG9NTh4UKDyN3G0OJA0LmRMqg+qdFGpEniX622lH0OWxb1OqHnQN6sk5nSnwDMhwo
         Kq6o1Zi0yTAT5JV13QrowmsAr/3qRPFG2Gnqk164pudzVmNXKYsJaHtw11YW5ZuZfJj0
         WdgDEp7Nf2kMIaB4JHou0NVpmQt8xh6AazPSxZKsOeIfgayOgJdO3Rdrz5x0OwcTqXXo
         Kz/UgWHanObyTKKyUoFJe9+rnJ0o8rbD1+i0P0YMQ5jz9N8CEzhHZ4lybpI/o+V4+wD+
         o6Ig==
X-Received: by 10.15.33.73 with SMTP id b49mr2697343eev.68.1385741404771;
        Fri, 29 Nov 2013 08:10:04 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id m1sm36346284eeg.0.2013.11.29.08.10.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2013 08:10:04 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2 1/2] bcma: gpio: add own IRQ domain
Date:   Fri, 29 Nov 2013 17:09:56 +0100
Message-Id: <1385741397-32740-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38600
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

Input GPIO changes can generate interrupts, but we need kind of ACK for
them by changing IRQ polarity. This is required to stop hardware from
keep generating interrupts and generate another one on the next GPIO
state change.
This code allows using GPIOs with standard interrupts and add for
example GPIO buttons support.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/bcma/Kconfig                        |    1 +
 drivers/bcma/driver_gpio.c                  |   92 ++++++++++++++++++++++++++-
 include/linux/bcma/bcma_driver_chipcommon.h |    1 +
 3 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index 7c081b3..649568e 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -75,6 +75,7 @@ config BCMA_DRIVER_GMAC_CMN
 config BCMA_DRIVER_GPIO
 	bool "BCMA GPIO driver"
 	depends on BCMA && GPIOLIB
+	select IRQ_DOMAIN
 	help
 	  Driver to provide access to the GPIO pins of the bcma bus.
 
diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 45f0996..0abf09a 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -9,6 +9,9 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/export.h>
 #include <linux/bcma/bcma.h>
 
@@ -78,15 +81,60 @@ static int bcma_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
 	struct bcma_drv_cc *cc = bcma_gpio_get_cc(chip);
 
 	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
-		return bcma_core_irq(cc->core);
+		return irq_find_mapping(cc->irq_domain, gpio);
 	else
 		return -EINVAL;
 }
 
+static void bcma_gpio_irq_unmask(struct irq_data *d)
+{
+	struct bcma_drv_cc *cc = irq_data_get_irq_chip_data(d);
+	int gpio = irqd_to_hwirq(d);
+
+	bcma_chipco_gpio_intmask(cc, BIT(gpio), BIT(gpio));
+}
+
+static void bcma_gpio_irq_mask(struct irq_data *d)
+{
+	struct bcma_drv_cc *cc = irq_data_get_irq_chip_data(d);
+	int gpio = irqd_to_hwirq(d);
+
+	bcma_chipco_gpio_intmask(cc, BIT(gpio), 0);
+}
+
+static struct irq_chip bcma_gpio_irq_chip = {
+	.name		= "BCMA-GPIO",
+	.irq_mask	= bcma_gpio_irq_mask,
+	.irq_unmask	= bcma_gpio_irq_unmask,
+};
+
+static irqreturn_t bcma_gpio_irq_handler(int irq, void *dev_id)
+{
+	struct bcma_drv_cc *cc = dev_id;
+	u32 val = bcma_cc_read32(cc, BCMA_CC_GPIOIN);
+	u32 mask = bcma_cc_read32(cc, BCMA_CC_GPIOIRQ);
+	u32 pol = bcma_cc_read32(cc, BCMA_CC_GPIOPOL);
+	u32 irqs = (val ^ pol) & mask;
+	int gpio;
+
+	for_each_set_bit(gpio, (unsigned long *)&irqs, cc->gpio.ngpio) {
+		generic_handle_irq(bcma_gpio_to_irq(&cc->gpio, gpio));
+		bcma_chipco_gpio_polarity(cc, BIT(gpio),
+					  (val & BIT(gpio)) ? BIT(gpio) : 0);
+	}
+
+	return irqs ? IRQ_HANDLED : IRQ_NONE;
+}
+
 int bcma_gpio_init(struct bcma_drv_cc *cc)
 {
 	struct gpio_chip *chip = &cc->gpio;
+	unsigned int hwirq, gpio;
+	int err;
 
+	/*
+	 * GPIO chip
+	 */
 	chip->label		= "bcma_gpio";
 	chip->owner		= THIS_MODULE;
 	chip->request		= bcma_gpio_request;
@@ -104,8 +152,48 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 		chip->base		= 0;
 	else
 		chip->base		= -1;
+	err = gpiochip_add(chip);
+	if (err)
+		goto err_gpiochip_add;
+
+	/*
+	 * IRQ domain
+	 */
+	cc->irq_domain = irq_domain_add_linear(NULL, chip->ngpio,
+					       &irq_domain_simple_ops, cc);
+	if (!cc->irq_domain) {
+		err = -ENODEV;
+		goto err_irq_domain;
+	}
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_create_mapping(cc->irq_domain, gpio);
+
+		irq_set_chip_data(irq, cc);
+		irq_set_chip_and_handler(irq, &bcma_gpio_irq_chip,
+					 handle_simple_irq);
+	}
+
+	/*
+	 * IRQ handler
+	 */
+	hwirq = bcma_core_irq(cc->core);
+	err = request_irq(hwirq, bcma_gpio_irq_handler, IRQF_SHARED, "gpio",
+			  cc);
+	if (err)
+		goto err_req_irq;
+
+	bcma_cc_set32(cc, BCMA_CC_IRQMASK, BCMA_CC_IRQ_GPIO);
+
+	return 0;
 
-	return gpiochip_add(chip);
+err_req_irq:
+	irq_domain_remove(cc->irq_domain);
+err_irq_domain:
+	err = gpiochip_remove(&cc->gpio);
+	if (err)
+		pr_err("Failed to remove GPIO chip: %d\n", err);
+err_gpiochip_add:
+	return err;
 }
 
 int bcma_gpio_unregister(struct bcma_drv_cc *cc)
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index c49e1a1..63d105c 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -640,6 +640,7 @@ struct bcma_drv_cc {
 	spinlock_t gpio_lock;
 #ifdef CONFIG_BCMA_DRIVER_GPIO
 	struct gpio_chip gpio;
+	struct irq_domain *irq_domain;
 #endif
 };
 
-- 
1.7.10.4
