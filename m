Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 14:27:27 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:41700 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992960AbeGYM1S5YEq8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 14:27:18 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 070222091A; Wed, 25 Jul 2018 14:27:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id BE297207B3;
        Wed, 25 Jul 2018 14:26:51 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linus.walleij@linaro.org
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 2/2] pinctrl: ocelot: add support for interrupt controller
Date:   Wed, 25 Jul 2018 14:26:21 +0200
Message-Id: <20180725122621.31713-2-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180725122621.31713-1-quentin.schulz@bootlin.com>
References: <20180725122621.31713-1-quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

This GPIO controller can serve as an interrupt controller as well on the
GPIOs it handles.

An interrupt is generated whenever a GPIO line changes and the
interrupt for this GPIO line is enabled. This means that both the
changes from low to high and high to low generate an interrupt.

For some use cases, it makes sense to ignore the high to low change and
not generate an interrupt. Such a use case is a line that is hold in a
level high/low manner until the event holding the line gets acked.
This can be achieved by making sure the interrupt on the GPIO controller
side gets acked and masked only after the line gets hold in its default
state, this is what's done with the fasteoi functions.

Only IRQ_TYPE_EDGE_BOTH and IRQ_TYPE_LEVEL_HIGH are supported for now.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/pinctrl/Kconfig          |   1 +
 drivers/pinctrl/pinctrl-ocelot.c | 102 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index dd50371225bc..891d80ef038a 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -332,6 +332,7 @@ config PINCTRL_OCELOT
 	depends on OF
 	depends on MSCC_OCELOT || COMPILE_TEST
 	select GPIOLIB
+	select GPIOLIB_IRQCHIP
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 15bb1cb8729b..d80b32413b09 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
@@ -427,11 +428,98 @@ static const struct gpio_chip ocelot_gpiolib_chip = {
 	.owner = THIS_MODULE,
 };
 
+static void ocelot_irq_mask(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int gpio = irqd_to_hwirq(data);
+
+	regmap_update_bits(info->map, OCELOT_GPIO_INTR_ENA, BIT(gpio), 0);
+}
+
+static void ocelot_irq_unmask(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int gpio = irqd_to_hwirq(data);
+
+	regmap_update_bits(info->map, OCELOT_GPIO_INTR_ENA, BIT(gpio),
+			   BIT(gpio));
+}
+
+static void ocelot_irq_ack(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int gpio = irqd_to_hwirq(data);
+
+	regmap_write_bits(info->map, OCELOT_GPIO_INTR, BIT(gpio), BIT(gpio));
+}
+
+static int ocelot_irq_set_type(struct irq_data *data, unsigned int type);
+
+static struct irq_chip ocelot_eoi_irqchip = {
+	.name		= "gpio",
+	.irq_mask	= ocelot_irq_mask,
+	.irq_eoi	= ocelot_irq_ack,
+	.irq_unmask	= ocelot_irq_unmask,
+	.flags          = IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED,
+	.irq_set_type	= ocelot_irq_set_type,
+};
+
+static struct irq_chip ocelot_irqchip = {
+	.name		= "gpio",
+	.irq_mask	= ocelot_irq_mask,
+	.irq_ack	= ocelot_irq_ack,
+	.irq_unmask	= ocelot_irq_unmask,
+	.irq_set_type	= ocelot_irq_set_type,
+};
+
+static int ocelot_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	type &= IRQ_TYPE_SENSE_MASK;
+
+	if (!(type & (IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH)))
+		return -EINVAL;
+
+	if (type & IRQ_TYPE_LEVEL_HIGH)
+		irq_set_chip_handler_name_locked(data, &ocelot_eoi_irqchip,
+						 handle_fasteoi_irq, NULL);
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		irq_set_chip_handler_name_locked(data, &ocelot_irqchip,
+						 handle_edge_irq, NULL);
+
+	return 0;
+}
+
+static void ocelot_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *parent_chip = irq_desc_get_chip(desc);
+	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
+	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int reg = 0, irq;
+	unsigned long irqs;
+
+	regmap_read(info->map, OCELOT_GPIO_INTR_IDENT, &reg);
+	if (!reg)
+		return;
+
+	chained_irq_enter(parent_chip, desc);
+
+	irqs = reg;
+
+	for_each_set_bit(irq, &irqs, OCELOT_PINS) {
+		generic_handle_irq(irq_linear_revmap(chip->irq.domain, irq));
+	}
+
+	chained_irq_exit(parent_chip, desc);
+}
+
 static int ocelot_gpiochip_register(struct platform_device *pdev,
 				    struct ocelot_pinctrl *info)
 {
 	struct gpio_chip *gc;
-	int ret;
+	int ret, irq;
 
 	info->gpio_chip = ocelot_gpiolib_chip;
 
@@ -446,7 +534,17 @@ static int ocelot_gpiochip_register(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	/* TODO: this can be used as an irqchip but no board is using that */
+	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (irq <= 0)
+		return irq;
+
+	ret = gpiochip_irqchip_add(gc, &ocelot_irqchip, 0, handle_edge_irq,
+				   IRQ_TYPE_NONE);
+	if (ret)
+		return ret;
+
+	gpiochip_set_chained_irqchip(gc, &ocelot_irqchip, irq,
+				     ocelot_irq_handler);
 
 	return 0;
 }
-- 
2.14.1
