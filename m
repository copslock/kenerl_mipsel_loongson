Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2013 12:56:22 +0100 (CET)
Received: from mail-ee0-f41.google.com ([74.125.83.41]:45890 "EHLO
        mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826484Ab3LJL4TB32ia (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Dec 2013 12:56:19 +0100
Received: by mail-ee0-f41.google.com with SMTP id t10so2192969eei.0
        for <multiple recipients>; Tue, 10 Dec 2013 03:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z7ZrrcXDuXnvYdEkPS1FvL6cdCxKN4EMVq6cfqq46ss=;
        b=GGDvRD6jO0EiEQ1qSklvJaEKuZSLlIwUnagHCCIHhCADAwrJo8gWAciC7e6ZRIVVrB
         cxmSd48iB64ILZqnOt8s++bh4tmqxGX43Ytbn9/wijpaLkQDevNiQcBajvuZXS0Ok1O2
         FyZ8ajwRJCW9D8XN5Jjezl7IWg2g+udmIODJmKsL/CQ2F2wtGhUpfrzlm4Xyh4d6pHdc
         oGDDH6AMd9HiXmwg5MRqVfQwvq9qcjCwKx79TjyExcWFLSq6lsog8jaVQJj/VWvttrm7
         cOnxezF+5Zg01Sqg2mU554KVuIlV2ht4LxrdSEwJS1VJgc+3U1+iHNNfJVb+C+ThqiDS
         atJQ==
X-Received: by 10.15.41.140 with SMTP id s12mr17673877eev.50.1386676573626;
        Tue, 10 Dec 2013 03:56:13 -0800 (PST)
Received: from linux-t0zw.lan (static-91-227-21-4.devs.futuro.pl. [91.227.21.4])
        by mx.google.com with ESMTPSA id m1sm40320279eeg.0.2013.12.10.03.56.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2013 03:56:12 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V5 1/2] bcma: gpio: add own IRQ domain
Date:   Tue, 10 Dec 2013 12:56:00 +0100
Message-Id: <1386676560-10932-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1385752379-19540-1-git-send-email-zajec5@gmail.com>
References: <1385752379-19540-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38690
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
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
V3: Apply Hauke's comments.
1) Use IRQ domain for CONFIG_BCMA_HOST_SOC only
2) Optimize bcma_gpio_irq_handler
3) Register GPIO chip after doing everything else
4) Improve cleaning paths

V4: More fixes from Hauke's comments:
1) Less #ifdef CONFIG_BCMA_HOST_SOC
2) Move BCMA_CC_IRQMASK op (and unset on exit)
3) Optimize bcma_gpio_irq_handler

V5: Use IS_BUILTIN 
---
 drivers/bcma/Kconfig                        |    1 +
 drivers/bcma/driver_gpio.c                  |  129 ++++++++++++++++++++++++++-
 include/linux/bcma/bcma_driver_chipcommon.h |    1 +
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index 7c081b3..0ee48be 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -75,6 +75,7 @@ config BCMA_DRIVER_GMAC_CMN
 config BCMA_DRIVER_GPIO
 	bool "BCMA GPIO driver"
 	depends on BCMA && GPIOLIB
+	select IRQ_DOMAIN if BCMA_HOST_SOC
 	help
 	  Driver to provide access to the GPIO pins of the bcma bus.
 
diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 45f0996..d5b02d2 100644
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
 
@@ -73,19 +76,127 @@ static void bcma_gpio_free(struct gpio_chip *chip, unsigned gpio)
 	bcma_chipco_gpio_pullup(cc, 1 << gpio, 0);
 }
 
+#if IS_BUILTIN(CONFIG_BCMA_HOST_SOC)
 static int bcma_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
 {
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
+	if (!irqs)
+		return IRQ_NONE;
+
+	for_each_set_bit(gpio, (unsigned long *)&irqs, cc->gpio.ngpio)
+		generic_handle_irq(bcma_gpio_to_irq(&cc->gpio, gpio));
+	bcma_chipco_gpio_polarity(cc, irqs, val & irqs);
+
+	return IRQ_HANDLED;
+}
+
+static int bcma_gpio_irq_domain_init(struct bcma_drv_cc *cc)
+{
+	struct gpio_chip *chip = &cc->gpio;
+	int gpio, hwirq, err;
+
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
+	hwirq = bcma_core_irq(cc->core);
+	err = request_irq(hwirq, bcma_gpio_irq_handler, IRQF_SHARED, "gpio",
+			  cc);
+	if (err)
+		goto err_req_irq;
+
+	bcma_cc_set32(cc, BCMA_CC_IRQMASK, BCMA_CC_IRQ_GPIO);
+
+	return 0;
+
+err_req_irq:
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_find_mapping(cc->irq_domain, gpio);
+
+		irq_dispose_mapping(irq);
+	}
+	irq_domain_remove(cc->irq_domain);
+err_irq_domain:
+	return err;
+}
+
+static void bcma_gpio_irq_domain_exit(struct bcma_drv_cc *cc)
+{
+	struct gpio_chip *chip = &cc->gpio;
+	int gpio;
+
+	bcma_cc_mask32(cc, BCMA_CC_IRQMASK, ~BCMA_CC_IRQ_GPIO);
+	free_irq(bcma_core_irq(cc->core), cc);
+	for (gpio = 0; gpio < chip->ngpio; gpio++) {
+		int irq = irq_find_mapping(cc->irq_domain, gpio);
+
+		irq_dispose_mapping(irq);
+	}
+	irq_domain_remove(cc->irq_domain);
+}
+#else
+static int bcma_gpio_irq_domain_init(struct bcma_drv_cc *cc)
+{
+	return 0;
+}
+
+static void bcma_gpio_irq_domain_exit(struct bcma_drv_cc *cc)
+{
+}
+#endif
+
 int bcma_gpio_init(struct bcma_drv_cc *cc)
 {
 	struct gpio_chip *chip = &cc->gpio;
+	int err;
 
 	chip->label		= "bcma_gpio";
 	chip->owner		= THIS_MODULE;
@@ -95,7 +206,8 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	chip->set		= bcma_gpio_set_value;
 	chip->direction_input	= bcma_gpio_direction_input;
 	chip->direction_output	= bcma_gpio_direction_output;
-	chip->to_irq		= bcma_gpio_to_irq;
+	if (IS_BUILTIN(CONFIG_BCMA_HOST_SOC))
+		chip->to_irq		= bcma_gpio_to_irq;
 	chip->ngpio		= 16;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
@@ -105,10 +217,21 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	else
 		chip->base		= -1;
 
-	return gpiochip_add(chip);
+	err = bcma_gpio_irq_domain_init(cc);
+	if (err)
+		return err;
+
+	err = gpiochip_add(chip);
+	if (err) {
+		bcma_gpio_irq_domain_exit(cc);
+		return err;
+	}
+
+	return 0;
 }
 
 int bcma_gpio_unregister(struct bcma_drv_cc *cc)
 {
+	bcma_gpio_irq_domain_exit(cc);
 	return gpiochip_remove(&cc->gpio);
 }
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
