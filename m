Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:42:51 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.133]:57980 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012842AbcBPPmF2WQXn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:42:05 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPA (Nemesis) id 0Lpis6-1a1c8V1D9y-00fO76; Tue, 16 Feb
 2016 16:41:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 4/5] gpio: ep93xx: remove private irq_to_gpio function
Date:   Tue, 16 Feb 2016 16:40:37 +0100
Message-Id: <1455637261-2920972-4-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
X-Provags-ID: V03:K0:j9cyZI0vRxWKbLcNM0OuDEZkwDwLKPWFjYn6eTNbF2sa+PRfHO1
 KyEVbzz2jKzisg/tmyv/VJoiL2oYVemdsH2cMRNC6l3dYPBsvGyL5GA/uK4gzGJ306ym3VU
 sPgONX5QJQ9wvBxqYhP3y9/nq/FJ3FbU7tF4LeG2z6wrXIfNDgFm9LOqbaqR83srqcaqwhD
 kk/A84+jeNmH0Detue0UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m+GRaYezSaE=:qASBZG7Rgy8opG1PGhBZpd
 cSUfbzzoXB/rVb3BN3nanwlSqxIDXuFOWUfOg/WHE7SbAMj8bj4ympVH9IxSogIHCcnU165sq
 UQryuLY7u59qWM2pTQ6Rlb9rnoeVuVKyo3pcw5AlBQjYIZxpXJayfpyGCucvQ/8Y3PZYoomiG
 LQ/FgkYwf8oKfZwPTKO8ZlwMFw3gnG9UHwsFDNktI09KnSSAS8ciKYL0/+Qx6La+P7xl8HXuh
 RvwNnkCF8mNCjd4c2jKHlA3aGO2PUxSsXN9R9c0trPZahGnhVjYKe7U0/5EZz5Cp2yvE8zsUL
 56ILbcK38+8fHHjhAX+s2LDdTyyqUxjcaV3manrSAiTs1vx3n2nvBsqdQ5TxCiZQ/mQXQJGb3
 Yd9pTeQpSE+4yOXA3REttkO1YroEnH6uAz9SNp9Q8+TXRj37+ayuhlIyxzWdSsnfgDjj+brIc
 F27QeFeGZAbrfra4cb6eRzgy1Zx+NMHGf8hIV7tQsq5ir6tC6rvchLcVdEISB/YuU9AbYobYD
 e4l8WfkUiqvynocX2u+Hk70miHz+jqmOwu5Rn79cA1M87hGFO3XvtlglxA3Tje2w9RUgnHvLp
 pzik4Zftftu7Q7WbWAuQydQ1vHk95E1ClxSBTEghYOsiTYKwoSGB7x0SA4FSwNN658JAs8OPC
 GyMjzaCTL1smanb2V6KK0dCEfETEUsGt7MPgxknh3rxP+WuNKqQjhi5MGCoBBK5JyOq0=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The ep93xx goes through its own back-and-forth dance every time
it wants to know the gpio number for an irq line, when it really
just hardcodes a fixed offset in ep93xx_gpio_to_irq().

This removes the pointless macro and replaces the conversion inside
of the driver with simple add/subtract operations, using an
explicit macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-ep93xx.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 20e5846bda28..cd83d30e8ff7 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -18,12 +18,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-#include <linux/gpio/driver.h>
-/* FIXME: this is here for gpio_to_irq() - get rid of this! */
 #include <linux/gpio.h>
 
-#define irq_to_gpio(irq)	((irq) - gpio_to_irq(0))
-
 void __iomem *ep93xx_gpio_base; /* FIXME: put this into irq_data */
 
 #define EP93XX_GPIO_REG(x)		(ep93xx_gpio_base + (x))
@@ -35,6 +31,7 @@ void __iomem *ep93xx_gpio_base; /* FIXME: put this into irq_data */
 #define EP93XX_GPIO_LINE_MAX		63
 
 /* maximum value for irq capable line identifiers */
+#define EP93XX_GPIO_IRQ_BASE		64
 #define EP93XX_GPIO_LINE_MAX_IRQ	23
 
 
@@ -77,7 +74,7 @@ static void ep93xx_gpio_update_int_params(unsigned port)
 
 static void ep93xx_gpio_int_debounce(unsigned int irq, bool enable)
 {
-	int line = irq_to_gpio(irq);
+	int line = irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
@@ -98,7 +95,7 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 	status = readb(EP93XX_GPIO_A_INT_STATUS);
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i)) {
-			int gpio_irq = gpio_to_irq(0) + i;
+			int gpio_irq = EP93XX_GPIO_IRQ_BASE + i;
 			generic_handle_irq(gpio_irq);
 		}
 	}
@@ -106,7 +103,7 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 	status = readb(EP93XX_GPIO_B_INT_STATUS);
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i)) {
-			int gpio_irq = gpio_to_irq(8) + i;
+			int gpio_irq = EP93XX_GPIO_IRQ_BASE + 8 + i;
 			generic_handle_irq(gpio_irq);
 		}
 	}
@@ -121,14 +118,14 @@ static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 	 */
 	unsigned int irq = irq_desc_get_irq(desc);
 	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
-	int gpio_irq = gpio_to_irq(16) + port_f_idx;
+	int gpio_irq = EP93XX_GPIO_IRQ_BASE + 16 + port_f_idx;
 
 	generic_handle_irq(gpio_irq);
 }
 
 static void ep93xx_gpio_irq_ack(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
@@ -142,7 +139,7 @@ static void ep93xx_gpio_irq_ack(struct irq_data *d)
 
 static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
@@ -157,7 +154,7 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 
 static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] &= ~(1 << (line & 7));
@@ -166,7 +163,7 @@ static void ep93xx_gpio_irq_mask(struct irq_data *d)
 
 static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] |= 1 << (line & 7);
@@ -180,7 +177,7 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
  */
 static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
-	const int gpio = irq_to_gpio(d->irq);
+	const int gpio = d->irq - EP93XX_GPIO_IRQ_BASE;
 	const int port = gpio >> 3;
 	const int port_mask = 1 << (gpio & 7);
 	irq_flow_handler_t handler;
@@ -241,14 +238,14 @@ static struct irq_chip ep93xx_gpio_irq_chip = {
 
 static void ep93xx_gpio_init_irq(struct platform_device *pdev)
 {
-	int gpio_irq;
+	int gpio;
 	int i;
 
-	for (gpio_irq = gpio_to_irq(0);
-	     gpio_irq <= gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ); ++gpio_irq) {
-		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
+	for (gpio = 0; gpio <= EP93XX_GPIO_LINE_MAX_IRQ; ++gpio) {
+		irq_set_chip_and_handler(EP93XX_GPIO_IRQ_BASE + gpio,
+					 &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
-		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
+		irq_clear_status_flags(EP93XX_GPIO_IRQ_BASE + gpio, IRQ_NOREQUEST);
 	}
 
 	irq_set_chained_handler(platform_get_irq(pdev, 0),
@@ -294,7 +291,7 @@ static int ep93xx_gpio_set_debounce(struct gpio_chip *chip,
 				    unsigned offset, unsigned debounce)
 {
 	int gpio = chip->base + offset;
-	int irq = gpio_to_irq(gpio);
+	int irq = EP93XX_GPIO_IRQ_BASE + gpio;
 
 	if (irq < 0)
 		return -EINVAL;
@@ -316,7 +313,7 @@ static int ep93xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	if (gpio > EP93XX_GPIO_LINE_MAX_IRQ)
 		return -EINVAL;
 
-	return 64 + gpio;
+	return EP93XX_GPIO_IRQ_BASE + gpio;
 }
 
 static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
-- 
2.7.0
