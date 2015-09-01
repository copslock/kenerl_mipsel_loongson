Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Sep 2015 11:38:29 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:64514 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006771AbbIAJi1y0bIL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Sep 2015 11:38:27 +0200
Received: from tock.adnet.avionic-design.de (unknown [78.54.126.133])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 7EE9A4B000C;
        Tue,  1 Sep 2015 11:38:18 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH] gpio: ath79: Convert to the state container design pattern
Date:   Tue,  1 Sep 2015 11:38:02 +0200
Message-Id: <1441100282-13584-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Turn the ath79 driver into a true driver supporting multiple
instances. While at it also removed unneed includes and make use of
the BIT() macro.

Signed-off-by: Alban Bedel <albeu@free.fr>
---

This patch apply on top of my previous MIPS GPIO patches that are pending
for 4.3, so it might be better to take it thru the MIPS tree.

Alban

---
 drivers/gpio/gpio-ath79.c | 129 +++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 64 deletions(-)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 03b9953..e5827a5 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -12,61 +12,51 @@
  *  by the Free Software Foundation.
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/platform_data/gpio-ath79.h>
 #include <linux/of_device.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
 
-static void __iomem *ath79_gpio_base;
-static u32 ath79_gpio_count;
-static DEFINE_SPINLOCK(ath79_gpio_lock);
+struct ath79_gpio_ctrl {
+	struct gpio_chip chip;
+	void __iomem *base;
+	spinlock_t lock;
+};
 
-static void __ath79_gpio_set_value(unsigned gpio, int value)
-{
-	void __iomem *base = ath79_gpio_base;
-
-	if (value)
-		__raw_writel(1 << gpio, base + AR71XX_GPIO_REG_SET);
-	else
-		__raw_writel(1 << gpio, base + AR71XX_GPIO_REG_CLEAR);
-}
-
-static int __ath79_gpio_get_value(unsigned gpio)
-{
-	return (__raw_readl(ath79_gpio_base + AR71XX_GPIO_REG_IN) >> gpio) & 1;
-}
-
-static int ath79_gpio_get_value(struct gpio_chip *chip, unsigned offset)
-{
-	return __ath79_gpio_get_value(offset);
-}
+#define to_ath79_gpio_ctrl(c) container_of(c, struct ath79_gpio_ctrl, chip)
 
 static void ath79_gpio_set_value(struct gpio_chip *chip,
-				  unsigned offset, int value)
+				unsigned gpio, int value)
 {
-	__ath79_gpio_set_value(offset, value);
+	struct ath79_gpio_ctrl *ctrl = to_ath79_gpio_ctrl(chip);
+
+	if (value)
+		__raw_writel(BIT(gpio), ctrl->base + AR71XX_GPIO_REG_SET);
+	else
+		__raw_writel(BIT(gpio), ctrl->base + AR71XX_GPIO_REG_CLEAR);
+}
+
+static int ath79_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ath79_gpio_ctrl *ctrl = to_ath79_gpio_ctrl(chip);
+
+	return (__raw_readl(ctrl->base + AR71XX_GPIO_REG_IN) >> gpio) & 1;
 }
 
 static int ath79_gpio_direction_input(struct gpio_chip *chip,
 				       unsigned offset)
 {
-	void __iomem *base = ath79_gpio_base;
+	struct ath79_gpio_ctrl *ctrl = to_ath79_gpio_ctrl(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
+	spin_lock_irqsave(&ctrl->lock, flags);
 
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) & ~(1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
+	__raw_writel(
+		__raw_readl(ctrl->base + AR71XX_GPIO_REG_OE) & ~BIT(offset),
+		ctrl->base + AR71XX_GPIO_REG_OE);
 
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return 0;
 }
@@ -74,35 +64,37 @@ static int ath79_gpio_direction_input(struct gpio_chip *chip,
 static int ath79_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
-	void __iomem *base = ath79_gpio_base;
+	struct ath79_gpio_ctrl *ctrl = to_ath79_gpio_ctrl(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
+	spin_lock_irqsave(&ctrl->lock, flags);
 
 	if (value)
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_SET);
+		__raw_writel(BIT(offset), ctrl->base + AR71XX_GPIO_REG_SET);
 	else
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_CLEAR);
+		__raw_writel(BIT(offset), ctrl->base + AR71XX_GPIO_REG_CLEAR);
 
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
+	__raw_writel(
+		__raw_readl(ctrl->base + AR71XX_GPIO_REG_OE) | BIT(offset),
+		ctrl->base + AR71XX_GPIO_REG_OE);
 
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return 0;
 }
 
 static int ar934x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	void __iomem *base = ath79_gpio_base;
+	struct ath79_gpio_ctrl *ctrl = to_ath79_gpio_ctrl(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
+	spin_lock_irqsave(&ctrl->lock, flags);
 
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
+	__raw_writel(
+		__raw_readl(ctrl->base + AR71XX_GPIO_REG_OE) | BIT(offset),
+		ctrl->base + AR71XX_GPIO_REG_OE);
 
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return 0;
 }
@@ -110,25 +102,26 @@ static int ar934x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 static int ar934x_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 					int value)
 {
-	void __iomem *base = ath79_gpio_base;
+	struct ath79_gpio_ctrl *ctrl = to_ath79_gpio_ctrl(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
+	spin_lock_irqsave(&ctrl->lock, flags);
 
 	if (value)
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_SET);
+		__raw_writel(BIT(offset), ctrl->base + AR71XX_GPIO_REG_SET);
 	else
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_CLEAR);
+		__raw_writel(BIT(offset), ctrl->base + AR71XX_GPIO_REG_CLEAR);
 
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) & ~(1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
+	__raw_writel(
+		__raw_readl(ctrl->base + AR71XX_GPIO_REG_OE) & BIT(offset),
+		ctrl->base + AR71XX_GPIO_REG_OE);
 
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return 0;
 }
 
-static struct gpio_chip ath79_gpio_chip = {
+static const struct gpio_chip ath79_gpio_chip = {
 	.label			= "ath79",
 	.get			= ath79_gpio_get_value,
 	.set			= ath79_gpio_set_value,
@@ -147,10 +140,16 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 {
 	struct ath79_gpio_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
+	struct ath79_gpio_ctrl *ctrl;
 	struct resource *res;
+	u32 ath79_gpio_count;
 	bool oe_inverted;
 	int err;
 
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
 	if (np) {
 		err = of_property_read_u32(np, "ngpios", &ath79_gpio_count);
 		if (err) {
@@ -171,19 +170,21 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ath79_gpio_base = devm_ioremap_nocache(
+	ctrl->base = devm_ioremap_nocache(
 		&pdev->dev, res->start, resource_size(res));
-	if (!ath79_gpio_base)
+	if (!ctrl->base)
 		return -ENOMEM;
 
-	ath79_gpio_chip.dev = &pdev->dev;
-	ath79_gpio_chip.ngpio = ath79_gpio_count;
+	spin_lock_init(&ctrl->lock);
+	memcpy(&ctrl->chip, &ath79_gpio_chip, sizeof(ctrl->chip));
+	ctrl->chip.dev = &pdev->dev;
+	ctrl->chip.ngpio = ath79_gpio_count;
 	if (oe_inverted) {
-		ath79_gpio_chip.direction_input = ar934x_gpio_direction_input;
-		ath79_gpio_chip.direction_output = ar934x_gpio_direction_output;
+		ctrl->chip.direction_input = ar934x_gpio_direction_input;
+		ctrl->chip.direction_output = ar934x_gpio_direction_output;
 	}
 
-	err = gpiochip_add(&ath79_gpio_chip);
+	err = gpiochip_add(&ctrl->chip);
 	if (err) {
 		dev_err(&pdev->dev,
 			"cannot add AR71xx GPIO chip, error=%d", err);
-- 
2.0.0
