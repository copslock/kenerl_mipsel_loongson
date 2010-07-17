Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jul 2010 14:11:42 +0200 (CEST)
Received: from smtp-out-005.synserver.de ([212.40.180.5]:1047 "HELO
        smtp-out-003.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491957Ab0GQMLh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jul 2010 14:11:37 +0200
Received: (qmail 11031 invoked by uid 0); 17 Jul 2010 12:11:36 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 10827
Received: from d077015.adsl.hansenet.de (HELO localhost.localdomain) [80.171.77.15]
  by 217.119.54.81 with SMTP; 17 Jul 2010 12:11:35 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3] MIPS: JZ4740: Add gpio support
Date:   Sat, 17 Jul 2010 14:11:19 +0200
Message-Id: <1279368679-20740-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1276924111-11158-9-git-send-email-lars@metafoo.de>
References: <1276924111-11158-9-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

This patch adds gpiolib support for JZ4740 SoCs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1
- Fix possible irq setup race

Changes since v2
- Use __fls instead of ffs in the interupt demuxer
- Fix LCD pins wrongly labeld as MEM pins
---
 arch/mips/include/asm/mach-jz4740/gpio.h |  398 ++++++++++++++++++++
 arch/mips/jz4740/gpio.c                  |  604 ++++++++++++++++++++++++++++++
 2 files changed, 1002 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-jz4740/gpio.h
 create mode 100644 arch/mips/jz4740/gpio.c

diff --git a/arch/mips/include/asm/mach-jz4740/gpio.h b/arch/mips/include/asm/mach-jz4740/gpio.h
new file mode 100644
index 0000000..7b74703
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4740/gpio.h
@@ -0,0 +1,398 @@
+/*
+ *  Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 GPIO pin definitions
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef _JZ_GPIO_H
+#define _JZ_GPIO_H
+
+#include <linux/types.h>
+
+enum jz_gpio_function {
+    JZ_GPIO_FUNC_NONE,
+    JZ_GPIO_FUNC1,
+    JZ_GPIO_FUNC2,
+    JZ_GPIO_FUNC3,
+};
+
+
+/*
+ Usually a driver for a SoC component has to request several gpio pins and
+ configure them as funcion pins.
+ jz_gpio_bulk_request can be used to ease this process.
+ Usually one would do something like:
+
+ const static struct jz_gpio_bulk_request i2c_pins[] = {
+	JZ_GPIO_BULK_PIN(I2C_SDA),
+	JZ_GPIO_BULK_PIN(I2C_SCK),
+ };
+
+ inside the probe function:
+
+    ret = jz_gpio_bulk_request(i2c_pins, ARRAY_SIZE(i2c_pins));
+    if (ret) {
+	...
+
+ inside the remove function:
+
+    jz_gpio_bulk_free(i2c_pins, ARRAY_SIZE(i2c_pins));
+
+
+*/
+struct jz_gpio_bulk_request {
+	int gpio;
+	const char *name;
+	enum jz_gpio_function function;
+};
+
+#define JZ_GPIO_BULK_PIN(pin) { \
+    .gpio = JZ_GPIO_ ## pin, \
+    .name = #pin, \
+    .function = JZ_GPIO_FUNC_ ## pin \
+}
+
+int jz_gpio_bulk_request(const struct jz_gpio_bulk_request *request, size_t num);
+void jz_gpio_bulk_free(const struct jz_gpio_bulk_request *request, size_t num);
+void jz_gpio_bulk_suspend(const struct jz_gpio_bulk_request *request, size_t num);
+void jz_gpio_bulk_resume(const struct jz_gpio_bulk_request *request, size_t num);
+void jz_gpio_enable_pullup(unsigned gpio);
+void jz_gpio_disable_pullup(unsigned gpio);
+int jz_gpio_set_function(int gpio, enum jz_gpio_function function);
+
+int jz_gpio_port_direction_input(int port, uint32_t mask);
+int jz_gpio_port_direction_output(int port, uint32_t mask);
+void jz_gpio_port_set_value(int port, uint32_t value, uint32_t mask);
+uint32_t jz_gpio_port_get_value(int port, uint32_t mask);
+
+#include <asm/mach-generic/gpio.h>
+
+#define JZ_GPIO_PORTA(x) ((x) + 32 * 0)
+#define JZ_GPIO_PORTB(x) ((x) + 32 * 1)
+#define JZ_GPIO_PORTC(x) ((x) + 32 * 2)
+#define JZ_GPIO_PORTD(x) ((x) + 32 * 3)
+
+/* Port A function pins */
+#define JZ_GPIO_MEM_DATA0		JZ_GPIO_PORTA(0)
+#define JZ_GPIO_MEM_DATA1		JZ_GPIO_PORTA(1)
+#define JZ_GPIO_MEM_DATA2		JZ_GPIO_PORTA(2)
+#define JZ_GPIO_MEM_DATA3		JZ_GPIO_PORTA(3)
+#define JZ_GPIO_MEM_DATA4		JZ_GPIO_PORTA(4)
+#define JZ_GPIO_MEM_DATA5		JZ_GPIO_PORTA(5)
+#define JZ_GPIO_MEM_DATA6		JZ_GPIO_PORTA(6)
+#define JZ_GPIO_MEM_DATA7		JZ_GPIO_PORTA(7)
+#define JZ_GPIO_MEM_DATA8		JZ_GPIO_PORTA(8)
+#define JZ_GPIO_MEM_DATA9		JZ_GPIO_PORTA(9)
+#define JZ_GPIO_MEM_DATA10		JZ_GPIO_PORTA(10)
+#define JZ_GPIO_MEM_DATA11		JZ_GPIO_PORTA(11)
+#define JZ_GPIO_MEM_DATA12		JZ_GPIO_PORTA(12)
+#define JZ_GPIO_MEM_DATA13		JZ_GPIO_PORTA(13)
+#define JZ_GPIO_MEM_DATA14		JZ_GPIO_PORTA(14)
+#define JZ_GPIO_MEM_DATA15		JZ_GPIO_PORTA(15)
+#define JZ_GPIO_MEM_DATA16		JZ_GPIO_PORTA(16)
+#define JZ_GPIO_MEM_DATA17		JZ_GPIO_PORTA(17)
+#define JZ_GPIO_MEM_DATA18		JZ_GPIO_PORTA(18)
+#define JZ_GPIO_MEM_DATA19		JZ_GPIO_PORTA(19)
+#define JZ_GPIO_MEM_DATA20		JZ_GPIO_PORTA(20)
+#define JZ_GPIO_MEM_DATA21		JZ_GPIO_PORTA(21)
+#define JZ_GPIO_MEM_DATA22		JZ_GPIO_PORTA(22)
+#define JZ_GPIO_MEM_DATA23		JZ_GPIO_PORTA(23)
+#define JZ_GPIO_MEM_DATA24		JZ_GPIO_PORTA(24)
+#define JZ_GPIO_MEM_DATA25		JZ_GPIO_PORTA(25)
+#define JZ_GPIO_MEM_DATA26		JZ_GPIO_PORTA(26)
+#define JZ_GPIO_MEM_DATA27		JZ_GPIO_PORTA(27)
+#define JZ_GPIO_MEM_DATA28		JZ_GPIO_PORTA(28)
+#define JZ_GPIO_MEM_DATA29		JZ_GPIO_PORTA(29)
+#define JZ_GPIO_MEM_DATA30		JZ_GPIO_PORTA(30)
+#define JZ_GPIO_MEM_DATA31		JZ_GPIO_PORTA(31)
+
+#define JZ_GPIO_FUNC_MEM_DATA0		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA1		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA2		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA3		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA4		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA5		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA6		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA7		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA8		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA9		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA10		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA11		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA12		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA13		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA14		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA15		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA16		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA17		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA18		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA19		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA20		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA21		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA22		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA23		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA24		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA25		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA26		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA27		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA28		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA29		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA30		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DATA31		JZ_GPIO_FUNC1
+
+/* Port B function pins */
+#define JZ_GPIO_MEM_ADDR0		JZ_GPIO_PORTB(0)
+#define JZ_GPIO_MEM_ADDR1		JZ_GPIO_PORTB(1)
+#define JZ_GPIO_MEM_ADDR2		JZ_GPIO_PORTB(2)
+#define JZ_GPIO_MEM_ADDR3		JZ_GPIO_PORTB(3)
+#define JZ_GPIO_MEM_ADDR4		JZ_GPIO_PORTB(4)
+#define JZ_GPIO_MEM_ADDR5		JZ_GPIO_PORTB(5)
+#define JZ_GPIO_MEM_ADDR6		JZ_GPIO_PORTB(6)
+#define JZ_GPIO_MEM_ADDR7		JZ_GPIO_PORTB(7)
+#define JZ_GPIO_MEM_ADDR8		JZ_GPIO_PORTB(8)
+#define JZ_GPIO_MEM_ADDR9		JZ_GPIO_PORTB(9)
+#define JZ_GPIO_MEM_ADDR10		JZ_GPIO_PORTB(10)
+#define JZ_GPIO_MEM_ADDR11		JZ_GPIO_PORTB(11)
+#define JZ_GPIO_MEM_ADDR12		JZ_GPIO_PORTB(12)
+#define JZ_GPIO_MEM_ADDR13		JZ_GPIO_PORTB(13)
+#define JZ_GPIO_MEM_ADDR14		JZ_GPIO_PORTB(14)
+#define JZ_GPIO_MEM_ADDR15		JZ_GPIO_PORTB(15)
+#define JZ_GPIO_MEM_ADDR16		JZ_GPIO_PORTB(16)
+#define JZ_GPIO_LCD_CLS			JZ_GPIO_PORTB(17)
+#define JZ_GPIO_LCD_SPL			JZ_GPIO_PORTB(18)
+#define JZ_GPIO_MEM_DCS			JZ_GPIO_PORTB(19)
+#define JZ_GPIO_MEM_RAS			JZ_GPIO_PORTB(20)
+#define JZ_GPIO_MEM_CAS			JZ_GPIO_PORTB(21)
+#define JZ_GPIO_MEM_SDWE		JZ_GPIO_PORTB(22)
+#define JZ_GPIO_MEM_CKE			JZ_GPIO_PORTB(23)
+#define JZ_GPIO_MEM_CKO			JZ_GPIO_PORTB(24)
+#define JZ_GPIO_MEM_CS0			JZ_GPIO_PORTB(25)
+#define JZ_GPIO_MEM_CS1			JZ_GPIO_PORTB(26)
+#define JZ_GPIO_MEM_CS2			JZ_GPIO_PORTB(27)
+#define JZ_GPIO_MEM_CS3			JZ_GPIO_PORTB(28)
+#define JZ_GPIO_MEM_RD			JZ_GPIO_PORTB(29)
+#define JZ_GPIO_MEM_WR			JZ_GPIO_PORTB(30)
+#define JZ_GPIO_MEM_WE0			JZ_GPIO_PORTB(31)
+
+#define JZ_GPIO_FUNC_MEM_ADDR0		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR1		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR2		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR3		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR4		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR5		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR6		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR7		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR8		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR9		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR10		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR11		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR12		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR13		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR14		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR15		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_ADDR16		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_CLS	        JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_SPL		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_DCS		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_RAS		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_CAS		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_SDWE		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_CKE		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_CKO		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_CS0		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_CS1		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_CS2		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_CS3		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_RD		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_WR		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_WE0		JZ_GPIO_FUNC1
+
+
+#define JZ_GPIO_MEM_ADDR21		JZ_GPIO_PORTB(17)
+#define JZ_GPIO_MEM_ADDR22		JZ_GPIO_PORTB(18)
+
+#define JZ_GPIO_FUNC_MEM_ADDR21		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_ADDR22		JZ_GPIO_FUNC2
+
+/* Port C function pins */
+#define JZ_GPIO_LCD_DATA0		JZ_GPIO_PORTC(0)
+#define JZ_GPIO_LCD_DATA1		JZ_GPIO_PORTC(1)
+#define JZ_GPIO_LCD_DATA2		JZ_GPIO_PORTC(2)
+#define JZ_GPIO_LCD_DATA3		JZ_GPIO_PORTC(3)
+#define JZ_GPIO_LCD_DATA4		JZ_GPIO_PORTC(4)
+#define JZ_GPIO_LCD_DATA5		JZ_GPIO_PORTC(5)
+#define JZ_GPIO_LCD_DATA6		JZ_GPIO_PORTC(6)
+#define JZ_GPIO_LCD_DATA7		JZ_GPIO_PORTC(7)
+#define JZ_GPIO_LCD_DATA8		JZ_GPIO_PORTC(8)
+#define JZ_GPIO_LCD_DATA9		JZ_GPIO_PORTC(9)
+#define JZ_GPIO_LCD_DATA10		JZ_GPIO_PORTC(10)
+#define JZ_GPIO_LCD_DATA11		JZ_GPIO_PORTC(11)
+#define JZ_GPIO_LCD_DATA12		JZ_GPIO_PORTC(12)
+#define JZ_GPIO_LCD_DATA13		JZ_GPIO_PORTC(13)
+#define JZ_GPIO_LCD_DATA14		JZ_GPIO_PORTC(14)
+#define JZ_GPIO_LCD_DATA15		JZ_GPIO_PORTC(15)
+#define JZ_GPIO_LCD_DATA16		JZ_GPIO_PORTC(16)
+#define JZ_GPIO_LCD_DATA17		JZ_GPIO_PORTC(17)
+#define JZ_GPIO_LCD_PCLK		JZ_GPIO_PORTC(18)
+#define JZ_GPIO_LCD_HSYNC		JZ_GPIO_PORTC(19)
+#define JZ_GPIO_LCD_VSYNC		JZ_GPIO_PORTC(20)
+#define JZ_GPIO_LCD_DE			JZ_GPIO_PORTC(21)
+#define JZ_GPIO_LCD_PS			JZ_GPIO_PORTC(22)
+#define JZ_GPIO_LCD_REV			JZ_GPIO_PORTC(23)
+#define JZ_GPIO_MEM_WE1			JZ_GPIO_PORTC(24)
+#define JZ_GPIO_MEM_WE2			JZ_GPIO_PORTC(25)
+#define JZ_GPIO_MEM_WE3			JZ_GPIO_PORTC(26)
+#define JZ_GPIO_MEM_WAIT		JZ_GPIO_PORTC(27)
+#define JZ_GPIO_MEM_FRE			JZ_GPIO_PORTC(28)
+#define JZ_GPIO_MEM_FWE			JZ_GPIO_PORTC(29)
+
+#define JZ_GPIO_FUNC_LCD_DATA0		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA1		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA2		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA3		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA4		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA5		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA6		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA7		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA8		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA9		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA10		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA11		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA12		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA13		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA14		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA15		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA16		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DATA17		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_PCLK		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_VSYNC		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_HSYNC		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_DE		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_PS		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_LCD_REV		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_WE1		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_WE2		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_WE3		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_WAIT		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_FRE		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MEM_FWE		JZ_GPIO_FUNC1
+
+
+#define JZ_GPIO_MEM_ADDR19		JZ_GPIO_PORTB(22)
+#define JZ_GPIO_MEM_ADDR20		JZ_GPIO_PORTB(23)
+
+#define JZ_GPIO_FUNC_MEM_ADDR19		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_ADDR20		JZ_GPIO_FUNC2
+
+/* Port D function pins */
+#define JZ_GPIO_CIM_DATA0		JZ_GPIO_PORTD(0)
+#define JZ_GPIO_CIM_DATA1		JZ_GPIO_PORTD(1)
+#define JZ_GPIO_CIM_DATA2		JZ_GPIO_PORTD(2)
+#define JZ_GPIO_CIM_DATA3		JZ_GPIO_PORTD(3)
+#define JZ_GPIO_CIM_DATA4		JZ_GPIO_PORTD(4)
+#define JZ_GPIO_CIM_DATA5		JZ_GPIO_PORTD(5)
+#define JZ_GPIO_CIM_DATA6		JZ_GPIO_PORTD(6)
+#define JZ_GPIO_CIM_DATA7		JZ_GPIO_PORTD(7)
+#define JZ_GPIO_MSC_CMD			JZ_GPIO_PORTD(8)
+#define JZ_GPIO_MSC_CLK			JZ_GPIO_PORTD(9)
+#define JZ_GPIO_MSC_DATA0		JZ_GPIO_PORTD(10)
+#define JZ_GPIO_MSC_DATA1		JZ_GPIO_PORTD(11)
+#define JZ_GPIO_MSC_DATA2		JZ_GPIO_PORTD(12)
+#define JZ_GPIO_MSC_DATA3		JZ_GPIO_PORTD(13)
+#define JZ_GPIO_CIM_MCLK		JZ_GPIO_PORTD(14)
+#define JZ_GPIO_CIM_PCLK		JZ_GPIO_PORTD(15)
+#define JZ_GPIO_CIM_VSYNC		JZ_GPIO_PORTD(16)
+#define JZ_GPIO_CIM_HSYNC		JZ_GPIO_PORTD(17)
+#define JZ_GPIO_SPI_CLK			JZ_GPIO_PORTD(18)
+#define JZ_GPIO_SPI_CE0			JZ_GPIO_PORTD(19)
+#define JZ_GPIO_SPI_DT			JZ_GPIO_PORTD(20)
+#define JZ_GPIO_SPI_DR			JZ_GPIO_PORTD(21)
+#define JZ_GPIO_SPI_CE1			JZ_GPIO_PORTD(22)
+#define JZ_GPIO_PWM0			JZ_GPIO_PORTD(23)
+#define JZ_GPIO_PWM1			JZ_GPIO_PORTD(24)
+#define JZ_GPIO_PWM2			JZ_GPIO_PORTD(25)
+#define JZ_GPIO_PWM3			JZ_GPIO_PORTD(26)
+#define JZ_GPIO_PWM4			JZ_GPIO_PORTD(27)
+#define JZ_GPIO_PWM5			JZ_GPIO_PORTD(28)
+#define JZ_GPIO_PWM6			JZ_GPIO_PORTD(30)
+#define JZ_GPIO_PWM7			JZ_GPIO_PORTD(31)
+
+#define JZ_GPIO_FUNC_CIM_DATA		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_CIM_DATA0		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_CIM_DATA1		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_CIM_DATA2		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_CIM_DATA3		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_CIM_DATA4		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_CIM_DATA5		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_CIM_DATA6		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_CIM_DATA7		JZ_GPIO_FUNC_CIM_DATA
+#define JZ_GPIO_FUNC_MSC_CMD		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MSC_CLK		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MSC_DATA		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_MSC_DATA0		JZ_GPIO_FUNC_MSC_DATA
+#define JZ_GPIO_FUNC_MSC_DATA1		JZ_GPIO_FUNC_MSC_DATA
+#define JZ_GPIO_FUNC_MSC_DATA2		JZ_GPIO_FUNC_MSC_DATA
+#define JZ_GPIO_FUNC_MSC_DATA3		JZ_GPIO_FUNC_MSC_DATA
+#define JZ_GPIO_FUNC_CIM_MCLK		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_CIM_PCLK		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_CIM_VSYNC		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_CIM_HSYNC		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_SPI_CLK		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_SPI_CE0		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_SPI_DT		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_SPI_DR		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_SPI_CE1		JZ_GPIO_FUNC1
+
+#define JZ_GPIO_FUNC_PWM		JZ_GPIO_FUNC1
+#define JZ_GPIO_FUNC_PWM0		JZ_GPIO_FUNC_PWM
+#define JZ_GPIO_FUNC_PWM1		JZ_GPIO_FUNC_PWM
+#define JZ_GPIO_FUNC_PWM2		JZ_GPIO_FUNC_PWM
+#define JZ_GPIO_FUNC_PWM3		JZ_GPIO_FUNC_PWM
+#define JZ_GPIO_FUNC_PWM4		JZ_GPIO_FUNC_PWM
+#define JZ_GPIO_FUNC_PWM5		JZ_GPIO_FUNC_PWM
+#define JZ_GPIO_FUNC_PWM6		JZ_GPIO_FUNC_PWM
+#define JZ_GPIO_FUNC_PWM7		JZ_GPIO_FUNC_PWM
+
+#define JZ_GPIO_MEM_SCLK_RSTN		JZ_GPIO_PORTD(18)
+#define JZ_GPIO_MEM_BCLK		JZ_GPIO_PORTD(19)
+#define JZ_GPIO_MEM_SDATO		JZ_GPIO_PORTD(20)
+#define JZ_GPIO_MEM_SDATI		JZ_GPIO_PORTD(21)
+#define JZ_GPIO_MEM_SYNC		JZ_GPIO_PORTD(22)
+#define JZ_GPIO_I2C_SDA			JZ_GPIO_PORTD(23)
+#define JZ_GPIO_I2C_SCK			JZ_GPIO_PORTD(24)
+#define JZ_GPIO_UART0_TXD		JZ_GPIO_PORTD(25)
+#define JZ_GPIO_UART0_RXD		JZ_GPIO_PORTD(26)
+#define JZ_GPIO_MEM_ADDR17		JZ_GPIO_PORTD(27)
+#define JZ_GPIO_MEM_ADDR18		JZ_GPIO_PORTD(28)
+#define JZ_GPIO_UART0_CTS		JZ_GPIO_PORTD(30)
+#define JZ_GPIO_UART0_RTS		JZ_GPIO_PORTD(31)
+
+#define JZ_GPIO_FUNC_MEM_SCLK_RSTN	JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_BCLK		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_SDATO		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_SDATI		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_SYNC		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_I2C_SDA		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_I2C_SCK		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_UART0_TXD		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_UART0_RXD		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_ADDR17		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_MEM_ADDR18		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_UART0_CTS		JZ_GPIO_FUNC2
+#define JZ_GPIO_FUNC_UART0_RTS		JZ_GPIO_FUNC2
+
+#define JZ_GPIO_UART1_RXD		JZ_GPIO_PORTD(30)
+#define JZ_GPIO_UART1_TXD		JZ_GPIO_PORTD(31)
+
+#define JZ_GPIO_FUNC_UART1_RXD		JZ_GPIO_FUNC3
+#define JZ_GPIO_FUNC_UART1_TXD		JZ_GPIO_FUNC3
+
+#endif
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
new file mode 100644
index 0000000..38f60f3
--- /dev/null
+++ b/arch/mips/jz4740/gpio.c
@@ -0,0 +1,604 @@
+/*
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 platform GPIO support
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/spinlock.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/bitops.h>
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include <asm/mach-jz4740/base.h>
+
+#define JZ4740_GPIO_BASE_A (32*0)
+#define JZ4740_GPIO_BASE_B (32*1)
+#define JZ4740_GPIO_BASE_C (32*2)
+#define JZ4740_GPIO_BASE_D (32*3)
+
+#define JZ4740_GPIO_NUM_A 32
+#define JZ4740_GPIO_NUM_B 32
+#define JZ4740_GPIO_NUM_C 31
+#define JZ4740_GPIO_NUM_D 32
+
+#define JZ4740_IRQ_GPIO_BASE_A (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_A)
+#define JZ4740_IRQ_GPIO_BASE_B (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_B)
+#define JZ4740_IRQ_GPIO_BASE_C (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_C)
+#define JZ4740_IRQ_GPIO_BASE_D (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_D)
+
+#define JZ_REG_GPIO_PIN			0x00
+#define JZ_REG_GPIO_DATA		0x10
+#define JZ_REG_GPIO_DATA_SET		0x14
+#define JZ_REG_GPIO_DATA_CLEAR		0x18
+#define JZ_REG_GPIO_MASK		0x20
+#define JZ_REG_GPIO_MASK_SET		0x24
+#define JZ_REG_GPIO_MASK_CLEAR		0x28
+#define JZ_REG_GPIO_PULL		0x30
+#define JZ_REG_GPIO_PULL_SET		0x34
+#define JZ_REG_GPIO_PULL_CLEAR		0x38
+#define JZ_REG_GPIO_FUNC		0x40
+#define JZ_REG_GPIO_FUNC_SET		0x44
+#define JZ_REG_GPIO_FUNC_CLEAR		0x48
+#define JZ_REG_GPIO_SELECT		0x50
+#define JZ_REG_GPIO_SELECT_SET		0x54
+#define JZ_REG_GPIO_SELECT_CLEAR	0x58
+#define JZ_REG_GPIO_DIRECTION		0x60
+#define JZ_REG_GPIO_DIRECTION_SET	0x64
+#define JZ_REG_GPIO_DIRECTION_CLEAR	0x68
+#define JZ_REG_GPIO_TRIGGER		0x70
+#define JZ_REG_GPIO_TRIGGER_SET		0x74
+#define JZ_REG_GPIO_TRIGGER_CLEAR	0x78
+#define JZ_REG_GPIO_FLAG		0x80
+#define JZ_REG_GPIO_FLAG_CLEAR		0x14
+
+#define GPIO_TO_BIT(gpio) BIT(gpio & 0x1f)
+#define GPIO_TO_REG(gpio, reg) (gpio_to_jz_gpio_chip(gpio)->base + (reg))
+#define CHIP_TO_REG(chip, reg) (gpio_chip_to_jz_gpio_chip(chip)->base + (reg))
+
+struct jz_gpio_chip {
+	unsigned int irq;
+	unsigned int irq_base;
+	uint32_t wakeup;
+	uint32_t suspend_mask;
+	uint32_t edge_trigger_both;
+
+	void __iomem *base;
+
+	spinlock_t lock;
+
+	struct gpio_chip gpio_chip;
+	struct irq_chip irq_chip;
+	struct sys_device sysdev;
+};
+
+static struct jz_gpio_chip jz4740_gpio_chips[];
+
+static inline struct jz_gpio_chip *gpio_to_jz_gpio_chip(unsigned int gpio)
+{
+	return &jz4740_gpio_chips[gpio >> 5];
+}
+
+static inline struct jz_gpio_chip *gpio_chip_to_jz_gpio_chip(struct gpio_chip *gpio_chip)
+{
+	return container_of(gpio_chip, struct jz_gpio_chip, gpio_chip);
+}
+
+static inline struct jz_gpio_chip *irq_to_jz_gpio_chip(unsigned int irq)
+{
+	return get_irq_chip_data(irq);
+}
+
+static inline void jz_gpio_write_bit(unsigned int gpio, unsigned int reg)
+{
+	writel(GPIO_TO_BIT(gpio), GPIO_TO_REG(gpio, reg));
+}
+
+int jz_gpio_set_function(int gpio, enum jz_gpio_function function)
+{
+	if (function == JZ_GPIO_FUNC_NONE) {
+		jz_gpio_write_bit(gpio, JZ_REG_GPIO_FUNC_CLEAR);
+		jz_gpio_write_bit(gpio, JZ_REG_GPIO_SELECT_CLEAR);
+		jz_gpio_write_bit(gpio, JZ_REG_GPIO_TRIGGER_CLEAR);
+	} else {
+		jz_gpio_write_bit(gpio, JZ_REG_GPIO_FUNC_SET);
+		jz_gpio_write_bit(gpio, JZ_REG_GPIO_TRIGGER_CLEAR);
+		switch (function) {
+		case JZ_GPIO_FUNC1:
+			jz_gpio_write_bit(gpio, JZ_REG_GPIO_SELECT_CLEAR);
+			break;
+		case JZ_GPIO_FUNC3:
+			jz_gpio_write_bit(gpio, JZ_REG_GPIO_TRIGGER_SET);
+		case JZ_GPIO_FUNC2: /* Falltrough */
+			jz_gpio_write_bit(gpio, JZ_REG_GPIO_SELECT_SET);
+			break;
+		default:
+			BUG();
+			break;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(jz_gpio_set_function);
+
+int jz_gpio_bulk_request(const struct jz_gpio_bulk_request *request, size_t num)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < num; ++i, ++request) {
+		ret = gpio_request(request->gpio, request->name);
+		if (ret)
+			goto err;
+		jz_gpio_set_function(request->gpio, request->function);
+	}
+
+	return 0;
+
+err:
+	for (--request; i > 0; --i, --request) {
+		gpio_free(request->gpio);
+		jz_gpio_set_function(request->gpio, JZ_GPIO_FUNC_NONE);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(jz_gpio_bulk_request);
+
+void jz_gpio_bulk_free(const struct jz_gpio_bulk_request *request, size_t num)
+{
+	size_t i;
+
+	for (i = 0; i < num; ++i, ++request) {
+		gpio_free(request->gpio);
+		jz_gpio_set_function(request->gpio, JZ_GPIO_FUNC_NONE);
+	}
+
+}
+EXPORT_SYMBOL_GPL(jz_gpio_bulk_free);
+
+void jz_gpio_bulk_suspend(const struct jz_gpio_bulk_request *request, size_t num)
+{
+	size_t i;
+
+	for (i = 0; i < num; ++i, ++request) {
+		jz_gpio_set_function(request->gpio, JZ_GPIO_FUNC_NONE);
+		jz_gpio_write_bit(request->gpio, JZ_REG_GPIO_DIRECTION_CLEAR);
+		jz_gpio_write_bit(request->gpio, JZ_REG_GPIO_PULL_SET);
+	}
+}
+EXPORT_SYMBOL_GPL(jz_gpio_bulk_suspend);
+
+void jz_gpio_bulk_resume(const struct jz_gpio_bulk_request *request, size_t num)
+{
+	size_t i;
+
+	for (i = 0; i < num; ++i, ++request)
+		jz_gpio_set_function(request->gpio, request->function);
+}
+EXPORT_SYMBOL_GPL(jz_gpio_bulk_resume);
+
+void jz_gpio_enable_pullup(unsigned gpio)
+{
+	jz_gpio_write_bit(gpio, JZ_REG_GPIO_PULL_CLEAR);
+}
+EXPORT_SYMBOL_GPL(jz_gpio_enable_pullup);
+
+void jz_gpio_disable_pullup(unsigned gpio)
+{
+	jz_gpio_write_bit(gpio, JZ_REG_GPIO_PULL_SET);
+}
+EXPORT_SYMBOL_GPL(jz_gpio_disable_pullup);
+
+static int jz_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+{
+	return !!(readl(CHIP_TO_REG(chip, JZ_REG_GPIO_PIN)) & BIT(gpio));
+}
+
+static void jz_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
+{
+	uint32_t __iomem *reg = CHIP_TO_REG(chip, JZ_REG_GPIO_DATA_SET);
+	reg += !value;
+	writel(BIT(gpio), reg);
+}
+
+static int jz_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
+	int value)
+{
+	writel(BIT(gpio), CHIP_TO_REG(chip, JZ_REG_GPIO_DIRECTION_SET));
+	jz_gpio_set_value(chip, gpio, value);
+
+	return 0;
+}
+
+static int jz_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	writel(BIT(gpio), CHIP_TO_REG(chip, JZ_REG_GPIO_DIRECTION_CLEAR));
+
+	return 0;
+}
+
+int jz_gpio_port_direction_input(int port, uint32_t mask)
+{
+	writel(mask, GPIO_TO_REG(port, JZ_REG_GPIO_DIRECTION_CLEAR));
+
+	return 0;
+}
+EXPORT_SYMBOL(jz_gpio_port_direction_input);
+
+int jz_gpio_port_direction_output(int port, uint32_t mask)
+{
+	writel(mask, GPIO_TO_REG(port, JZ_REG_GPIO_DIRECTION_SET));
+
+	return 0;
+}
+EXPORT_SYMBOL(jz_gpio_port_direction_output);
+
+void jz_gpio_port_set_value(int port, uint32_t value, uint32_t mask)
+{
+	writel(~value & mask, GPIO_TO_REG(port, JZ_REG_GPIO_DATA_CLEAR));
+	writel(value & mask, GPIO_TO_REG(port, JZ_REG_GPIO_DATA_SET));
+}
+EXPORT_SYMBOL(jz_gpio_port_set_value);
+
+uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
+{
+	uint32_t value = readl(GPIO_TO_REG(port, JZ_REG_GPIO_PIN));
+
+	return value & mask;
+}
+EXPORT_SYMBOL(jz_gpio_port_get_value);
+
+int gpio_to_irq(unsigned gpio)
+{
+	return JZ4740_IRQ_GPIO(0) + gpio;
+}
+EXPORT_SYMBOL_GPL(gpio_to_irq);
+
+int irq_to_gpio(unsigned irq)
+{
+	return irq - JZ4740_IRQ_GPIO(0);
+}
+EXPORT_SYMBOL_GPL(irq_to_gpio);
+
+#define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
+
+static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
+{
+	uint32_t value;
+	void __iomem *reg;
+	uint32_t mask = IRQ_TO_BIT(irq);
+
+	if (!(chip->edge_trigger_both & mask))
+		return;
+
+	reg = chip->base;
+
+	value = readl(chip->base + JZ_REG_GPIO_PIN);
+	if (value & mask)
+		reg += JZ_REG_GPIO_DIRECTION_CLEAR;
+	else
+		reg += JZ_REG_GPIO_DIRECTION_SET;
+
+	writel(mask, reg);
+}
+
+static void jz_gpio_irq_demux_handler(unsigned int irq, struct irq_desc *desc)
+{
+	uint32_t flag;
+	unsigned int gpio_irq;
+	unsigned int gpio_bank;
+	struct jz_gpio_chip *chip = get_irq_desc_data(desc);
+
+	gpio_bank = JZ4740_IRQ_GPIO0 - irq;
+
+	flag = readl(chip->base + JZ_REG_GPIO_FLAG);
+
+	if (!flag)
+		return;
+
+	gpio_irq = __fls(flag);
+
+	jz_gpio_check_trigger_both(chip, irq);
+
+	gpio_irq += (gpio_bank << 5) + JZ4740_IRQ_GPIO(0);
+
+	generic_handle_irq(gpio_irq);
+};
+
+static inline void jz_gpio_set_irq_bit(unsigned int irq, unsigned int reg)
+{
+	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(irq);
+	writel(IRQ_TO_BIT(irq), chip->base + reg);
+}
+
+static void jz_gpio_irq_mask(unsigned int irq)
+{
+	jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_MASK_SET);
+};
+
+static void jz_gpio_irq_unmask(unsigned int irq)
+{
+	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(irq);
+
+	jz_gpio_check_trigger_both(chip, irq);
+
+	jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_MASK_CLEAR);
+};
+
+/* TODO: Check if function is gpio */
+static unsigned int jz_gpio_irq_startup(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_SELECT_SET);
+
+	desc->status &= ~IRQ_MASKED;
+	jz_gpio_irq_unmask(irq);
+
+	return 0;
+}
+
+static void jz_gpio_irq_shutdown(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	jz_gpio_irq_mask(irq);
+	desc->status |= IRQ_MASKED;
+
+	/* Set direction to input */
+	jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_DIRECTION_CLEAR);
+	jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_SELECT_CLEAR);
+}
+
+static void jz_gpio_irq_ack(unsigned int irq)
+{
+	jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_FLAG_CLEAR);
+};
+
+static int jz_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
+{
+	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(irq);
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	jz_gpio_irq_mask(irq);
+
+	if (flow_type == IRQ_TYPE_EDGE_BOTH) {
+		uint32_t value = readl(chip->base + JZ_REG_GPIO_PIN);
+		if (value & IRQ_TO_BIT(irq))
+			flow_type = IRQ_TYPE_EDGE_FALLING;
+		else
+			flow_type = IRQ_TYPE_EDGE_RISING;
+		chip->edge_trigger_both |= IRQ_TO_BIT(irq);
+	} else {
+		chip->edge_trigger_both &= ~IRQ_TO_BIT(irq);
+	}
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_RISING:
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_DIRECTION_SET);
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_TRIGGER_SET);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_DIRECTION_CLEAR);
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_TRIGGER_SET);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_DIRECTION_SET);
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_TRIGGER_CLEAR);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_DIRECTION_CLEAR);
+		jz_gpio_set_irq_bit(irq, JZ_REG_GPIO_TRIGGER_CLEAR);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!(desc->status & IRQ_MASKED))
+		jz_gpio_irq_unmask(irq);
+
+	return 0;
+}
+
+static int jz_gpio_irq_set_wake(unsigned int irq, unsigned int on)
+{
+	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(irq);
+	spin_lock(&chip->lock);
+	if (on)
+		chip->wakeup |= IRQ_TO_BIT(irq);
+	else
+		chip->wakeup &= ~IRQ_TO_BIT(irq);
+	spin_unlock(&chip->lock);
+
+	set_irq_wake(chip->irq, on);
+	return 0;
+}
+
+/*
+ * This lock class tells lockdep that GPIO irqs are in a different
+ * category than their parents, so it won't report false recursion.
+ */
+static struct lock_class_key gpio_lock_class;
+
+#define JZ4740_GPIO_CHIP(_bank) { \
+	.irq_base = JZ4740_IRQ_GPIO_BASE_ ## _bank, \
+	.gpio_chip = { \
+		.label = "Bank " # _bank, \
+		.owner = THIS_MODULE, \
+		.set = jz_gpio_set_value, \
+		.get = jz_gpio_get_value, \
+		.direction_output = jz_gpio_direction_output, \
+		.direction_input = jz_gpio_direction_input, \
+		.base = JZ4740_GPIO_BASE_ ## _bank, \
+		.ngpio = JZ4740_GPIO_NUM_ ## _bank, \
+	}, \
+	.irq_chip =  { \
+		.name = "GPIO Bank " # _bank, \
+		.mask = jz_gpio_irq_mask, \
+		.unmask = jz_gpio_irq_unmask, \
+		.ack = jz_gpio_irq_ack, \
+		.startup = jz_gpio_irq_startup, \
+		.shutdown = jz_gpio_irq_shutdown, \
+		.set_type = jz_gpio_irq_set_type, \
+		.set_wake = jz_gpio_irq_set_wake, \
+	}, \
+}
+
+static struct jz_gpio_chip jz4740_gpio_chips[] = {
+	JZ4740_GPIO_CHIP(A),
+	JZ4740_GPIO_CHIP(B),
+	JZ4740_GPIO_CHIP(C),
+	JZ4740_GPIO_CHIP(D),
+};
+
+static inline struct jz_gpio_chip *sysdev_to_chip(struct sys_device *dev)
+{
+	return container_of(dev, struct jz_gpio_chip, sysdev);
+}
+
+static int jz4740_gpio_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct jz_gpio_chip *chip = sysdev_to_chip(dev);
+
+	chip->suspend_mask = readl(chip->base + JZ_REG_GPIO_MASK);
+	writel(~(chip->wakeup), chip->base + JZ_REG_GPIO_MASK_SET);
+	writel(chip->wakeup, chip->base + JZ_REG_GPIO_MASK_CLEAR);
+
+	return 0;
+}
+
+static int jz4740_gpio_resume(struct sys_device *dev)
+{
+	struct jz_gpio_chip *chip = sysdev_to_chip(dev);
+	uint32_t mask = chip->suspend_mask;
+
+	writel(~mask, chip->base + JZ_REG_GPIO_MASK_CLEAR);
+	writel(mask, chip->base + JZ_REG_GPIO_MASK_SET);
+
+	return 0;
+}
+
+static struct sysdev_class jz4740_gpio_sysdev_class = {
+	.name = "gpio",
+	.suspend = jz4740_gpio_suspend,
+	.resume = jz4740_gpio_resume,
+};
+
+static int jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
+{
+	int ret, irq;
+
+	chip->sysdev.id = id;
+	chip->sysdev.cls = &jz4740_gpio_sysdev_class;
+	ret = sysdev_register(&chip->sysdev);
+
+	if (ret)
+		return ret;
+
+	spin_lock_init(&chip->lock);
+
+	chip->base = ioremap(JZ4740_GPIO_BASE_ADDR + (id * 0x100), 0x100);
+
+	gpiochip_add(&chip->gpio_chip);
+
+	chip->irq = JZ4740_IRQ_INTC_GPIO(id);
+	set_irq_data(chip->irq, chip);
+	set_irq_chained_handler(chip->irq, jz_gpio_irq_demux_handler);
+
+	for (irq = chip->irq_base; irq < chip->irq_base + chip->gpio_chip.ngpio; ++irq) {
+		lockdep_set_class(&irq_desc[irq].lock, &gpio_lock_class);
+		set_irq_chip_data(irq, chip);
+		set_irq_chip_and_handler(irq, &chip->irq_chip, handle_level_irq);
+	}
+
+	return 0;
+}
+
+static int __init jz4740_gpio_init(void)
+{
+	unsigned int i;
+	int ret;
+
+	ret = sysdev_class_register(&jz4740_gpio_sysdev_class);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(jz4740_gpio_chips); ++i)
+		jz4740_gpio_chip_init(&jz4740_gpio_chips[i], i);
+
+	printk(KERN_INFO "JZ4740 GPIO initalized\n");
+
+	return 0;
+}
+arch_initcall(jz4740_gpio_init);
+
+#ifdef CONFIG_DEBUG_FS
+
+static inline void gpio_seq_reg(struct seq_file *s, struct jz_gpio_chip *chip,
+	const char *name, unsigned int reg)
+{
+	seq_printf(s, "\t%s: %08x\n", name, readl(chip->base + reg));
+}
+
+static int gpio_regs_show(struct seq_file *s, void *unused)
+{
+	struct jz_gpio_chip *chip = jz4740_gpio_chips;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(jz4740_gpio_chips); ++i, ++chip) {
+		seq_printf(s, "==GPIO %d==\n", i);
+		gpio_seq_reg(s, chip, "Pin", JZ_REG_GPIO_PIN);
+		gpio_seq_reg(s, chip, "Data", JZ_REG_GPIO_DATA);
+		gpio_seq_reg(s, chip, "Mask", JZ_REG_GPIO_MASK);
+		gpio_seq_reg(s, chip, "Pull", JZ_REG_GPIO_PULL);
+		gpio_seq_reg(s, chip, "Func", JZ_REG_GPIO_FUNC);
+		gpio_seq_reg(s, chip, "Select", JZ_REG_GPIO_SELECT);
+		gpio_seq_reg(s, chip, "Direction", JZ_REG_GPIO_DIRECTION);
+		gpio_seq_reg(s, chip, "Trigger", JZ_REG_GPIO_TRIGGER);
+		gpio_seq_reg(s, chip, "Flag", JZ_REG_GPIO_FLAG);
+	}
+
+	return 0;
+}
+
+static int gpio_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, gpio_regs_show, NULL);
+}
+
+static const struct file_operations gpio_regs_operations = {
+	.open		= gpio_regs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init gpio_debugfs_init(void)
+{
+	(void) debugfs_create_file("jz_regs_gpio", S_IFREG | S_IRUGO,
+				NULL, NULL, &gpio_regs_operations);
+	return 0;
+}
+subsys_initcall(gpio_debugfs_init);
+
+#endif
-- 
1.5.6.5
