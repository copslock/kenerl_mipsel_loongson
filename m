Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2017 15:56:17 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:53272 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993897AbdAVOvTzyDxb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2017 15:51:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 14/14] MIPS: jz4740: Remove custom GPIO code
Date:   Sun, 22 Jan 2017 15:49:47 +0100
Message-Id: <20170122144947.16158-15-paul@crapouillou.net>
In-Reply-To: <20170122144947.16158-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485096649; bh=OV3LRmJ+ZwaDdzvIPWm15/DkuUpdCJEITG/Vjn91Q7I=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mL3FJ29//E+jTqkYVs8+x6vzQM2YmUR/Oq8ZpaqOcokLZ37v5WrvgdlzqE5Hz35AtwtAAnMfF4iOyqR5cwgxOXHKu1Xm/FUD+uOzGl5s/WoWwYLFSs6P1rxVx4o2/qq3o4TFGrPaXNbtJ2ain7vrjmkl7sovgHx/q++dBjc/0aM=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

All the drivers for the various hardware elements of the jz4740 SoC have
been modified to use the pinctrl framework for their pin configuration
needs.
As such, this platform code is now unused and can be deleted.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/include/asm/mach-jz4740/gpio.h | 371 ----------------------
 arch/mips/jz4740/Makefile                |   2 -
 arch/mips/jz4740/gpio.c                  | 519 -------------------------------
 3 files changed, 892 deletions(-)
 delete mode 100644 arch/mips/jz4740/gpio.c

v2: No changes

diff --git a/arch/mips/include/asm/mach-jz4740/gpio.h b/arch/mips/include/asm/mach-jz4740/gpio.h
index 7c7708a23baa..fd847c984701 100644
--- a/arch/mips/include/asm/mach-jz4740/gpio.h
+++ b/arch/mips/include/asm/mach-jz4740/gpio.h
@@ -16,380 +16,9 @@
 #ifndef _JZ_GPIO_H
 #define _JZ_GPIO_H
 
-#include <linux/types.h>
-
-enum jz_gpio_function {
-    JZ_GPIO_FUNC_NONE,
-    JZ_GPIO_FUNC1,
-    JZ_GPIO_FUNC2,
-    JZ_GPIO_FUNC3,
-};
-
-/*
- Usually a driver for a SoC component has to request several gpio pins and
- configure them as function pins.
- jz_gpio_bulk_request can be used to ease this process.
- Usually one would do something like:
-
- static const struct jz_gpio_bulk_request i2c_pins[] = {
-	JZ_GPIO_BULK_PIN(I2C_SDA),
-	JZ_GPIO_BULK_PIN(I2C_SCK),
- };
-
- inside the probe function:
-
-    ret = jz_gpio_bulk_request(i2c_pins, ARRAY_SIZE(i2c_pins));
-    if (ret) {
-	...
-
- inside the remove function:
-
-    jz_gpio_bulk_free(i2c_pins, ARRAY_SIZE(i2c_pins));
-
-*/
-
-struct jz_gpio_bulk_request {
-	int gpio;
-	const char *name;
-	enum jz_gpio_function function;
-};
-
-#define JZ_GPIO_BULK_PIN(pin) { \
-    .gpio = JZ_GPIO_ ## pin, \
-    .name = #pin, \
-    .function = JZ_GPIO_FUNC_ ## pin \
-}
-
-int jz_gpio_bulk_request(const struct jz_gpio_bulk_request *request, size_t num);
-void jz_gpio_bulk_free(const struct jz_gpio_bulk_request *request, size_t num);
-void jz_gpio_bulk_suspend(const struct jz_gpio_bulk_request *request, size_t num);
-void jz_gpio_bulk_resume(const struct jz_gpio_bulk_request *request, size_t num);
-void jz_gpio_enable_pullup(unsigned gpio);
-void jz_gpio_disable_pullup(unsigned gpio);
-int jz_gpio_set_function(int gpio, enum jz_gpio_function function);
-
-int jz_gpio_port_direction_input(int port, uint32_t mask);
-int jz_gpio_port_direction_output(int port, uint32_t mask);
-void jz_gpio_port_set_value(int port, uint32_t value, uint32_t mask);
-uint32_t jz_gpio_port_get_value(int port, uint32_t mask);
-
 #define JZ_GPIO_PORTA(x) ((x) + 32 * 0)
 #define JZ_GPIO_PORTB(x) ((x) + 32 * 1)
 #define JZ_GPIO_PORTC(x) ((x) + 32 * 2)
 #define JZ_GPIO_PORTD(x) ((x) + 32 * 3)
 
-/* Port A function pins */
-#define JZ_GPIO_MEM_DATA0		JZ_GPIO_PORTA(0)
-#define JZ_GPIO_MEM_DATA1		JZ_GPIO_PORTA(1)
-#define JZ_GPIO_MEM_DATA2		JZ_GPIO_PORTA(2)
-#define JZ_GPIO_MEM_DATA3		JZ_GPIO_PORTA(3)
-#define JZ_GPIO_MEM_DATA4		JZ_GPIO_PORTA(4)
-#define JZ_GPIO_MEM_DATA5		JZ_GPIO_PORTA(5)
-#define JZ_GPIO_MEM_DATA6		JZ_GPIO_PORTA(6)
-#define JZ_GPIO_MEM_DATA7		JZ_GPIO_PORTA(7)
-#define JZ_GPIO_MEM_DATA8		JZ_GPIO_PORTA(8)
-#define JZ_GPIO_MEM_DATA9		JZ_GPIO_PORTA(9)
-#define JZ_GPIO_MEM_DATA10		JZ_GPIO_PORTA(10)
-#define JZ_GPIO_MEM_DATA11		JZ_GPIO_PORTA(11)
-#define JZ_GPIO_MEM_DATA12		JZ_GPIO_PORTA(12)
-#define JZ_GPIO_MEM_DATA13		JZ_GPIO_PORTA(13)
-#define JZ_GPIO_MEM_DATA14		JZ_GPIO_PORTA(14)
-#define JZ_GPIO_MEM_DATA15		JZ_GPIO_PORTA(15)
-#define JZ_GPIO_MEM_DATA16		JZ_GPIO_PORTA(16)
-#define JZ_GPIO_MEM_DATA17		JZ_GPIO_PORTA(17)
-#define JZ_GPIO_MEM_DATA18		JZ_GPIO_PORTA(18)
-#define JZ_GPIO_MEM_DATA19		JZ_GPIO_PORTA(19)
-#define JZ_GPIO_MEM_DATA20		JZ_GPIO_PORTA(20)
-#define JZ_GPIO_MEM_DATA21		JZ_GPIO_PORTA(21)
-#define JZ_GPIO_MEM_DATA22		JZ_GPIO_PORTA(22)
-#define JZ_GPIO_MEM_DATA23		JZ_GPIO_PORTA(23)
-#define JZ_GPIO_MEM_DATA24		JZ_GPIO_PORTA(24)
-#define JZ_GPIO_MEM_DATA25		JZ_GPIO_PORTA(25)
-#define JZ_GPIO_MEM_DATA26		JZ_GPIO_PORTA(26)
-#define JZ_GPIO_MEM_DATA27		JZ_GPIO_PORTA(27)
-#define JZ_GPIO_MEM_DATA28		JZ_GPIO_PORTA(28)
-#define JZ_GPIO_MEM_DATA29		JZ_GPIO_PORTA(29)
-#define JZ_GPIO_MEM_DATA30		JZ_GPIO_PORTA(30)
-#define JZ_GPIO_MEM_DATA31		JZ_GPIO_PORTA(31)
-
-#define JZ_GPIO_FUNC_MEM_DATA0		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA1		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA2		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA3		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA4		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA5		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA6		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA7		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA8		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA9		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA10		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA11		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA12		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA13		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA14		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA15		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA16		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA17		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA18		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA19		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA20		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA21		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA22		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA23		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA24		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA25		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA26		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA27		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA28		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA29		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA30		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DATA31		JZ_GPIO_FUNC1
-
-/* Port B function pins */
-#define JZ_GPIO_MEM_ADDR0		JZ_GPIO_PORTB(0)
-#define JZ_GPIO_MEM_ADDR1		JZ_GPIO_PORTB(1)
-#define JZ_GPIO_MEM_ADDR2		JZ_GPIO_PORTB(2)
-#define JZ_GPIO_MEM_ADDR3		JZ_GPIO_PORTB(3)
-#define JZ_GPIO_MEM_ADDR4		JZ_GPIO_PORTB(4)
-#define JZ_GPIO_MEM_ADDR5		JZ_GPIO_PORTB(5)
-#define JZ_GPIO_MEM_ADDR6		JZ_GPIO_PORTB(6)
-#define JZ_GPIO_MEM_ADDR7		JZ_GPIO_PORTB(7)
-#define JZ_GPIO_MEM_ADDR8		JZ_GPIO_PORTB(8)
-#define JZ_GPIO_MEM_ADDR9		JZ_GPIO_PORTB(9)
-#define JZ_GPIO_MEM_ADDR10		JZ_GPIO_PORTB(10)
-#define JZ_GPIO_MEM_ADDR11		JZ_GPIO_PORTB(11)
-#define JZ_GPIO_MEM_ADDR12		JZ_GPIO_PORTB(12)
-#define JZ_GPIO_MEM_ADDR13		JZ_GPIO_PORTB(13)
-#define JZ_GPIO_MEM_ADDR14		JZ_GPIO_PORTB(14)
-#define JZ_GPIO_MEM_ADDR15		JZ_GPIO_PORTB(15)
-#define JZ_GPIO_MEM_ADDR16		JZ_GPIO_PORTB(16)
-#define JZ_GPIO_LCD_CLS			JZ_GPIO_PORTB(17)
-#define JZ_GPIO_LCD_SPL			JZ_GPIO_PORTB(18)
-#define JZ_GPIO_MEM_DCS			JZ_GPIO_PORTB(19)
-#define JZ_GPIO_MEM_RAS			JZ_GPIO_PORTB(20)
-#define JZ_GPIO_MEM_CAS			JZ_GPIO_PORTB(21)
-#define JZ_GPIO_MEM_SDWE		JZ_GPIO_PORTB(22)
-#define JZ_GPIO_MEM_CKE			JZ_GPIO_PORTB(23)
-#define JZ_GPIO_MEM_CKO			JZ_GPIO_PORTB(24)
-#define JZ_GPIO_MEM_CS0			JZ_GPIO_PORTB(25)
-#define JZ_GPIO_MEM_CS1			JZ_GPIO_PORTB(26)
-#define JZ_GPIO_MEM_CS2			JZ_GPIO_PORTB(27)
-#define JZ_GPIO_MEM_CS3			JZ_GPIO_PORTB(28)
-#define JZ_GPIO_MEM_RD			JZ_GPIO_PORTB(29)
-#define JZ_GPIO_MEM_WR			JZ_GPIO_PORTB(30)
-#define JZ_GPIO_MEM_WE0			JZ_GPIO_PORTB(31)
-
-#define JZ_GPIO_FUNC_MEM_ADDR0		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR1		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR2		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR3		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR4		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR5		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR6		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR7		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR8		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR9		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR10		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR11		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR12		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR13		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR14		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR15		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_ADDR16		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_CLS		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_SPL		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_DCS		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_RAS		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_CAS		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_SDWE		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_CKE		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_CKO		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_CS0		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_CS1		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_CS2		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_CS3		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_RD		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_WR		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_WE0		JZ_GPIO_FUNC1
-
-
-#define JZ_GPIO_MEM_ADDR21		JZ_GPIO_PORTB(17)
-#define JZ_GPIO_MEM_ADDR22		JZ_GPIO_PORTB(18)
-
-#define JZ_GPIO_FUNC_MEM_ADDR21		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_ADDR22		JZ_GPIO_FUNC2
-
-/* Port C function pins */
-#define JZ_GPIO_LCD_DATA0		JZ_GPIO_PORTC(0)
-#define JZ_GPIO_LCD_DATA1		JZ_GPIO_PORTC(1)
-#define JZ_GPIO_LCD_DATA2		JZ_GPIO_PORTC(2)
-#define JZ_GPIO_LCD_DATA3		JZ_GPIO_PORTC(3)
-#define JZ_GPIO_LCD_DATA4		JZ_GPIO_PORTC(4)
-#define JZ_GPIO_LCD_DATA5		JZ_GPIO_PORTC(5)
-#define JZ_GPIO_LCD_DATA6		JZ_GPIO_PORTC(6)
-#define JZ_GPIO_LCD_DATA7		JZ_GPIO_PORTC(7)
-#define JZ_GPIO_LCD_DATA8		JZ_GPIO_PORTC(8)
-#define JZ_GPIO_LCD_DATA9		JZ_GPIO_PORTC(9)
-#define JZ_GPIO_LCD_DATA10		JZ_GPIO_PORTC(10)
-#define JZ_GPIO_LCD_DATA11		JZ_GPIO_PORTC(11)
-#define JZ_GPIO_LCD_DATA12		JZ_GPIO_PORTC(12)
-#define JZ_GPIO_LCD_DATA13		JZ_GPIO_PORTC(13)
-#define JZ_GPIO_LCD_DATA14		JZ_GPIO_PORTC(14)
-#define JZ_GPIO_LCD_DATA15		JZ_GPIO_PORTC(15)
-#define JZ_GPIO_LCD_DATA16		JZ_GPIO_PORTC(16)
-#define JZ_GPIO_LCD_DATA17		JZ_GPIO_PORTC(17)
-#define JZ_GPIO_LCD_PCLK		JZ_GPIO_PORTC(18)
-#define JZ_GPIO_LCD_HSYNC		JZ_GPIO_PORTC(19)
-#define JZ_GPIO_LCD_VSYNC		JZ_GPIO_PORTC(20)
-#define JZ_GPIO_LCD_DE			JZ_GPIO_PORTC(21)
-#define JZ_GPIO_LCD_PS			JZ_GPIO_PORTC(22)
-#define JZ_GPIO_LCD_REV			JZ_GPIO_PORTC(23)
-#define JZ_GPIO_MEM_WE1			JZ_GPIO_PORTC(24)
-#define JZ_GPIO_MEM_WE2			JZ_GPIO_PORTC(25)
-#define JZ_GPIO_MEM_WE3			JZ_GPIO_PORTC(26)
-#define JZ_GPIO_MEM_WAIT		JZ_GPIO_PORTC(27)
-#define JZ_GPIO_MEM_FRE			JZ_GPIO_PORTC(28)
-#define JZ_GPIO_MEM_FWE			JZ_GPIO_PORTC(29)
-
-#define JZ_GPIO_FUNC_LCD_DATA0		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA1		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA2		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA3		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA4		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA5		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA6		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA7		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA8		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA9		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA10		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA11		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA12		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA13		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA14		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA15		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA16		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DATA17		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_PCLK		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_VSYNC		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_HSYNC		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_DE		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_PS		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_LCD_REV		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_WE1		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_WE2		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_WE3		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_WAIT		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_FRE		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MEM_FWE		JZ_GPIO_FUNC1
-
-
-#define JZ_GPIO_MEM_ADDR19		JZ_GPIO_PORTB(22)
-#define JZ_GPIO_MEM_ADDR20		JZ_GPIO_PORTB(23)
-
-#define JZ_GPIO_FUNC_MEM_ADDR19		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_ADDR20		JZ_GPIO_FUNC2
-
-/* Port D function pins */
-#define JZ_GPIO_CIM_DATA0		JZ_GPIO_PORTD(0)
-#define JZ_GPIO_CIM_DATA1		JZ_GPIO_PORTD(1)
-#define JZ_GPIO_CIM_DATA2		JZ_GPIO_PORTD(2)
-#define JZ_GPIO_CIM_DATA3		JZ_GPIO_PORTD(3)
-#define JZ_GPIO_CIM_DATA4		JZ_GPIO_PORTD(4)
-#define JZ_GPIO_CIM_DATA5		JZ_GPIO_PORTD(5)
-#define JZ_GPIO_CIM_DATA6		JZ_GPIO_PORTD(6)
-#define JZ_GPIO_CIM_DATA7		JZ_GPIO_PORTD(7)
-#define JZ_GPIO_MSC_CMD			JZ_GPIO_PORTD(8)
-#define JZ_GPIO_MSC_CLK			JZ_GPIO_PORTD(9)
-#define JZ_GPIO_MSC_DATA0		JZ_GPIO_PORTD(10)
-#define JZ_GPIO_MSC_DATA1		JZ_GPIO_PORTD(11)
-#define JZ_GPIO_MSC_DATA2		JZ_GPIO_PORTD(12)
-#define JZ_GPIO_MSC_DATA3		JZ_GPIO_PORTD(13)
-#define JZ_GPIO_CIM_MCLK		JZ_GPIO_PORTD(14)
-#define JZ_GPIO_CIM_PCLK		JZ_GPIO_PORTD(15)
-#define JZ_GPIO_CIM_VSYNC		JZ_GPIO_PORTD(16)
-#define JZ_GPIO_CIM_HSYNC		JZ_GPIO_PORTD(17)
-#define JZ_GPIO_SPI_CLK			JZ_GPIO_PORTD(18)
-#define JZ_GPIO_SPI_CE0			JZ_GPIO_PORTD(19)
-#define JZ_GPIO_SPI_DT			JZ_GPIO_PORTD(20)
-#define JZ_GPIO_SPI_DR			JZ_GPIO_PORTD(21)
-#define JZ_GPIO_SPI_CE1			JZ_GPIO_PORTD(22)
-#define JZ_GPIO_PWM0			JZ_GPIO_PORTD(23)
-#define JZ_GPIO_PWM1			JZ_GPIO_PORTD(24)
-#define JZ_GPIO_PWM2			JZ_GPIO_PORTD(25)
-#define JZ_GPIO_PWM3			JZ_GPIO_PORTD(26)
-#define JZ_GPIO_PWM4			JZ_GPIO_PORTD(27)
-#define JZ_GPIO_PWM5			JZ_GPIO_PORTD(28)
-#define JZ_GPIO_PWM6			JZ_GPIO_PORTD(30)
-#define JZ_GPIO_PWM7			JZ_GPIO_PORTD(31)
-
-#define JZ_GPIO_FUNC_CIM_DATA		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_CIM_DATA0		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_CIM_DATA1		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_CIM_DATA2		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_CIM_DATA3		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_CIM_DATA4		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_CIM_DATA5		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_CIM_DATA6		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_CIM_DATA7		JZ_GPIO_FUNC_CIM_DATA
-#define JZ_GPIO_FUNC_MSC_CMD		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MSC_CLK		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MSC_DATA		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_MSC_DATA0		JZ_GPIO_FUNC_MSC_DATA
-#define JZ_GPIO_FUNC_MSC_DATA1		JZ_GPIO_FUNC_MSC_DATA
-#define JZ_GPIO_FUNC_MSC_DATA2		JZ_GPIO_FUNC_MSC_DATA
-#define JZ_GPIO_FUNC_MSC_DATA3		JZ_GPIO_FUNC_MSC_DATA
-#define JZ_GPIO_FUNC_CIM_MCLK		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_CIM_PCLK		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_CIM_VSYNC		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_CIM_HSYNC		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_SPI_CLK		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_SPI_CE0		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_SPI_DT		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_SPI_DR		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_SPI_CE1		JZ_GPIO_FUNC1
-
-#define JZ_GPIO_FUNC_PWM		JZ_GPIO_FUNC1
-#define JZ_GPIO_FUNC_PWM0		JZ_GPIO_FUNC_PWM
-#define JZ_GPIO_FUNC_PWM1		JZ_GPIO_FUNC_PWM
-#define JZ_GPIO_FUNC_PWM2		JZ_GPIO_FUNC_PWM
-#define JZ_GPIO_FUNC_PWM3		JZ_GPIO_FUNC_PWM
-#define JZ_GPIO_FUNC_PWM4		JZ_GPIO_FUNC_PWM
-#define JZ_GPIO_FUNC_PWM5		JZ_GPIO_FUNC_PWM
-#define JZ_GPIO_FUNC_PWM6		JZ_GPIO_FUNC_PWM
-#define JZ_GPIO_FUNC_PWM7		JZ_GPIO_FUNC_PWM
-
-#define JZ_GPIO_MEM_SCLK_RSTN		JZ_GPIO_PORTD(18)
-#define JZ_GPIO_MEM_BCLK		JZ_GPIO_PORTD(19)
-#define JZ_GPIO_MEM_SDATO		JZ_GPIO_PORTD(20)
-#define JZ_GPIO_MEM_SDATI		JZ_GPIO_PORTD(21)
-#define JZ_GPIO_MEM_SYNC		JZ_GPIO_PORTD(22)
-#define JZ_GPIO_I2C_SDA			JZ_GPIO_PORTD(23)
-#define JZ_GPIO_I2C_SCK			JZ_GPIO_PORTD(24)
-#define JZ_GPIO_UART0_TXD		JZ_GPIO_PORTD(25)
-#define JZ_GPIO_UART0_RXD		JZ_GPIO_PORTD(26)
-#define JZ_GPIO_MEM_ADDR17		JZ_GPIO_PORTD(27)
-#define JZ_GPIO_MEM_ADDR18		JZ_GPIO_PORTD(28)
-#define JZ_GPIO_UART0_CTS		JZ_GPIO_PORTD(30)
-#define JZ_GPIO_UART0_RTS		JZ_GPIO_PORTD(31)
-
-#define JZ_GPIO_FUNC_MEM_SCLK_RSTN	JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_BCLK		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_SDATO		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_SDATI		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_SYNC		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_I2C_SDA		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_I2C_SCK		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_UART0_TXD		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_UART0_RXD		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_ADDR17		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_MEM_ADDR18		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_UART0_CTS		JZ_GPIO_FUNC2
-#define JZ_GPIO_FUNC_UART0_RTS		JZ_GPIO_FUNC2
-
-#define JZ_GPIO_UART1_RXD		JZ_GPIO_PORTD(30)
-#define JZ_GPIO_UART1_TXD		JZ_GPIO_PORTD(31)
-
-#define JZ_GPIO_FUNC_UART1_RXD		JZ_GPIO_FUNC3
-#define JZ_GPIO_FUNC_UART1_TXD		JZ_GPIO_FUNC3
-
 #endif
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 39d70bde8cfe..6b9c1f7c31c9 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -7,8 +7,6 @@
 obj-y += prom.o time.o reset.o setup.o \
 	platform.o timer.o
 
-obj-$(CONFIG_MACH_JZ4740) += gpio.o
-
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
 # board specific support
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
deleted file mode 100644
index b765773ab8aa..000000000000
--- a/arch/mips/jz4740/gpio.c
+++ /dev/null
@@ -1,519 +0,0 @@
-/*
- *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform GPIO support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <linux/io.h>
-#include <linux/gpio/driver.h>
-/* FIXME: needed for gpio_request(), try to remove consumer API from driver */
-#include <linux/gpio.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/irqchip/ingenic.h>
-#include <linux/bitops.h>
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-
-#include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/gpio.h>
-
-#define JZ4740_GPIO_BASE_A (32*0)
-#define JZ4740_GPIO_BASE_B (32*1)
-#define JZ4740_GPIO_BASE_C (32*2)
-#define JZ4740_GPIO_BASE_D (32*3)
-
-#define JZ4740_GPIO_NUM_A 32
-#define JZ4740_GPIO_NUM_B 32
-#define JZ4740_GPIO_NUM_C 31
-#define JZ4740_GPIO_NUM_D 32
-
-#define JZ4740_IRQ_GPIO_BASE_A (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_A)
-#define JZ4740_IRQ_GPIO_BASE_B (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_B)
-#define JZ4740_IRQ_GPIO_BASE_C (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_C)
-#define JZ4740_IRQ_GPIO_BASE_D (JZ4740_IRQ_GPIO(0) + JZ4740_GPIO_BASE_D)
-
-#define JZ_REG_GPIO_PIN			0x00
-#define JZ_REG_GPIO_DATA		0x10
-#define JZ_REG_GPIO_DATA_SET		0x14
-#define JZ_REG_GPIO_DATA_CLEAR		0x18
-#define JZ_REG_GPIO_MASK		0x20
-#define JZ_REG_GPIO_MASK_SET		0x24
-#define JZ_REG_GPIO_MASK_CLEAR		0x28
-#define JZ_REG_GPIO_PULL		0x30
-#define JZ_REG_GPIO_PULL_SET		0x34
-#define JZ_REG_GPIO_PULL_CLEAR		0x38
-#define JZ_REG_GPIO_FUNC		0x40
-#define JZ_REG_GPIO_FUNC_SET		0x44
-#define JZ_REG_GPIO_FUNC_CLEAR		0x48
-#define JZ_REG_GPIO_SELECT		0x50
-#define JZ_REG_GPIO_SELECT_SET		0x54
-#define JZ_REG_GPIO_SELECT_CLEAR	0x58
-#define JZ_REG_GPIO_DIRECTION		0x60
-#define JZ_REG_GPIO_DIRECTION_SET	0x64
-#define JZ_REG_GPIO_DIRECTION_CLEAR	0x68
-#define JZ_REG_GPIO_TRIGGER		0x70
-#define JZ_REG_GPIO_TRIGGER_SET		0x74
-#define JZ_REG_GPIO_TRIGGER_CLEAR	0x78
-#define JZ_REG_GPIO_FLAG		0x80
-#define JZ_REG_GPIO_FLAG_CLEAR		0x14
-
-#define GPIO_TO_BIT(gpio) BIT(gpio & 0x1f)
-#define GPIO_TO_REG(gpio, reg) (gpio_to_jz_gpio_chip(gpio)->base + (reg))
-#define CHIP_TO_REG(chip, reg) (gpio_chip_to_jz_gpio_chip(chip)->base + (reg))
-
-struct jz_gpio_chip {
-	unsigned int irq;
-	unsigned int irq_base;
-	uint32_t edge_trigger_both;
-
-	void __iomem *base;
-
-	struct gpio_chip gpio_chip;
-};
-
-static struct jz_gpio_chip jz4740_gpio_chips[];
-
-static inline struct jz_gpio_chip *gpio_to_jz_gpio_chip(unsigned int gpio)
-{
-	return &jz4740_gpio_chips[gpio >> 5];
-}
-
-static inline struct jz_gpio_chip *gpio_chip_to_jz_gpio_chip(struct gpio_chip *gc)
-{
-	return gpiochip_get_data(gc);
-}
-
-static inline struct jz_gpio_chip *irq_to_jz_gpio_chip(struct irq_data *data)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	return gc->private;
-}
-
-static inline void jz_gpio_write_bit(unsigned int gpio, unsigned int reg)
-{
-	writel(GPIO_TO_BIT(gpio), GPIO_TO_REG(gpio, reg));
-}
-
-int jz_gpio_set_function(int gpio, enum jz_gpio_function function)
-{
-	if (function == JZ_GPIO_FUNC_NONE) {
-		jz_gpio_write_bit(gpio, JZ_REG_GPIO_FUNC_CLEAR);
-		jz_gpio_write_bit(gpio, JZ_REG_GPIO_SELECT_CLEAR);
-		jz_gpio_write_bit(gpio, JZ_REG_GPIO_TRIGGER_CLEAR);
-	} else {
-		jz_gpio_write_bit(gpio, JZ_REG_GPIO_FUNC_SET);
-		jz_gpio_write_bit(gpio, JZ_REG_GPIO_TRIGGER_CLEAR);
-		switch (function) {
-		case JZ_GPIO_FUNC1:
-			jz_gpio_write_bit(gpio, JZ_REG_GPIO_SELECT_CLEAR);
-			break;
-		case JZ_GPIO_FUNC3:
-			jz_gpio_write_bit(gpio, JZ_REG_GPIO_TRIGGER_SET);
-		case JZ_GPIO_FUNC2: /* Falltrough */
-			jz_gpio_write_bit(gpio, JZ_REG_GPIO_SELECT_SET);
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(jz_gpio_set_function);
-
-int jz_gpio_bulk_request(const struct jz_gpio_bulk_request *request, size_t num)
-{
-	size_t i;
-	int ret;
-
-	for (i = 0; i < num; ++i, ++request) {
-		ret = gpio_request(request->gpio, request->name);
-		if (ret)
-			goto err;
-		jz_gpio_set_function(request->gpio, request->function);
-	}
-
-	return 0;
-
-err:
-	for (--request; i > 0; --i, --request) {
-		gpio_free(request->gpio);
-		jz_gpio_set_function(request->gpio, JZ_GPIO_FUNC_NONE);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(jz_gpio_bulk_request);
-
-void jz_gpio_bulk_free(const struct jz_gpio_bulk_request *request, size_t num)
-{
-	size_t i;
-
-	for (i = 0; i < num; ++i, ++request) {
-		gpio_free(request->gpio);
-		jz_gpio_set_function(request->gpio, JZ_GPIO_FUNC_NONE);
-	}
-
-}
-EXPORT_SYMBOL_GPL(jz_gpio_bulk_free);
-
-void jz_gpio_bulk_suspend(const struct jz_gpio_bulk_request *request, size_t num)
-{
-	size_t i;
-
-	for (i = 0; i < num; ++i, ++request) {
-		jz_gpio_set_function(request->gpio, JZ_GPIO_FUNC_NONE);
-		jz_gpio_write_bit(request->gpio, JZ_REG_GPIO_DIRECTION_CLEAR);
-		jz_gpio_write_bit(request->gpio, JZ_REG_GPIO_PULL_SET);
-	}
-}
-EXPORT_SYMBOL_GPL(jz_gpio_bulk_suspend);
-
-void jz_gpio_bulk_resume(const struct jz_gpio_bulk_request *request, size_t num)
-{
-	size_t i;
-
-	for (i = 0; i < num; ++i, ++request)
-		jz_gpio_set_function(request->gpio, request->function);
-}
-EXPORT_SYMBOL_GPL(jz_gpio_bulk_resume);
-
-void jz_gpio_enable_pullup(unsigned gpio)
-{
-	jz_gpio_write_bit(gpio, JZ_REG_GPIO_PULL_CLEAR);
-}
-EXPORT_SYMBOL_GPL(jz_gpio_enable_pullup);
-
-void jz_gpio_disable_pullup(unsigned gpio)
-{
-	jz_gpio_write_bit(gpio, JZ_REG_GPIO_PULL_SET);
-}
-EXPORT_SYMBOL_GPL(jz_gpio_disable_pullup);
-
-static int jz_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
-{
-	return !!(readl(CHIP_TO_REG(chip, JZ_REG_GPIO_PIN)) & BIT(gpio));
-}
-
-static void jz_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
-{
-	uint32_t __iomem *reg = CHIP_TO_REG(chip, JZ_REG_GPIO_DATA_SET);
-	reg += !value;
-	writel(BIT(gpio), reg);
-}
-
-static int jz_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
-	int value)
-{
-	writel(BIT(gpio), CHIP_TO_REG(chip, JZ_REG_GPIO_DIRECTION_SET));
-	jz_gpio_set_value(chip, gpio, value);
-
-	return 0;
-}
-
-static int jz_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
-{
-	writel(BIT(gpio), CHIP_TO_REG(chip, JZ_REG_GPIO_DIRECTION_CLEAR));
-
-	return 0;
-}
-
-static int jz_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
-{
-	struct jz_gpio_chip *jz_gpio = gpiochip_get_data(chip);
-
-	return jz_gpio->irq_base + gpio;
-}
-
-int jz_gpio_port_direction_input(int port, uint32_t mask)
-{
-	writel(mask, GPIO_TO_REG(port, JZ_REG_GPIO_DIRECTION_CLEAR));
-
-	return 0;
-}
-EXPORT_SYMBOL(jz_gpio_port_direction_input);
-
-int jz_gpio_port_direction_output(int port, uint32_t mask)
-{
-	writel(mask, GPIO_TO_REG(port, JZ_REG_GPIO_DIRECTION_SET));
-
-	return 0;
-}
-EXPORT_SYMBOL(jz_gpio_port_direction_output);
-
-void jz_gpio_port_set_value(int port, uint32_t value, uint32_t mask)
-{
-	writel(~value & mask, GPIO_TO_REG(port, JZ_REG_GPIO_DATA_CLEAR));
-	writel(value & mask, GPIO_TO_REG(port, JZ_REG_GPIO_DATA_SET));
-}
-EXPORT_SYMBOL(jz_gpio_port_set_value);
-
-uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
-{
-	uint32_t value = readl(GPIO_TO_REG(port, JZ_REG_GPIO_PIN));
-
-	return value & mask;
-}
-EXPORT_SYMBOL(jz_gpio_port_get_value);
-
-#define IRQ_TO_BIT(irq) BIT((irq - JZ4740_IRQ_GPIO(0)) & 0x1f)
-
-static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
-{
-	uint32_t value;
-	void __iomem *reg;
-	uint32_t mask = IRQ_TO_BIT(irq);
-
-	if (!(chip->edge_trigger_both & mask))
-		return;
-
-	reg = chip->base;
-
-	value = readl(chip->base + JZ_REG_GPIO_PIN);
-	if (value & mask)
-		reg += JZ_REG_GPIO_DIRECTION_CLEAR;
-	else
-		reg += JZ_REG_GPIO_DIRECTION_SET;
-
-	writel(mask, reg);
-}
-
-static void jz_gpio_irq_demux_handler(struct irq_desc *desc)
-{
-	uint32_t flag;
-	unsigned int gpio_irq;
-	struct jz_gpio_chip *chip = irq_desc_get_handler_data(desc);
-
-	flag = readl(chip->base + JZ_REG_GPIO_FLAG);
-	if (!flag)
-		return;
-
-	gpio_irq = chip->irq_base + __fls(flag);
-
-	jz_gpio_check_trigger_both(chip, gpio_irq);
-
-	generic_handle_irq(gpio_irq);
-};
-
-static inline void jz_gpio_set_irq_bit(struct irq_data *data, unsigned int reg)
-{
-	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(data);
-	writel(IRQ_TO_BIT(data->irq), chip->base + reg);
-}
-
-static void jz_gpio_irq_unmask(struct irq_data *data)
-{
-	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(data);
-
-	jz_gpio_check_trigger_both(chip, data->irq);
-	irq_gc_unmask_enable_reg(data);
-};
-
-/* TODO: Check if function is gpio */
-static unsigned int jz_gpio_irq_startup(struct irq_data *data)
-{
-	jz_gpio_set_irq_bit(data, JZ_REG_GPIO_SELECT_SET);
-	jz_gpio_irq_unmask(data);
-	return 0;
-}
-
-static void jz_gpio_irq_shutdown(struct irq_data *data)
-{
-	irq_gc_mask_disable_reg(data);
-
-	/* Set direction to input */
-	jz_gpio_set_irq_bit(data, JZ_REG_GPIO_DIRECTION_CLEAR);
-	jz_gpio_set_irq_bit(data, JZ_REG_GPIO_SELECT_CLEAR);
-}
-
-static int jz_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
-{
-	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(data);
-	unsigned int irq = data->irq;
-
-	if (flow_type == IRQ_TYPE_EDGE_BOTH) {
-		uint32_t value = readl(chip->base + JZ_REG_GPIO_PIN);
-		if (value & IRQ_TO_BIT(irq))
-			flow_type = IRQ_TYPE_EDGE_FALLING;
-		else
-			flow_type = IRQ_TYPE_EDGE_RISING;
-		chip->edge_trigger_both |= IRQ_TO_BIT(irq);
-	} else {
-		chip->edge_trigger_both &= ~IRQ_TO_BIT(irq);
-	}
-
-	switch (flow_type) {
-	case IRQ_TYPE_EDGE_RISING:
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_DIRECTION_SET);
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_TRIGGER_SET);
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_DIRECTION_CLEAR);
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_TRIGGER_SET);
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_DIRECTION_SET);
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_TRIGGER_CLEAR);
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_DIRECTION_CLEAR);
-		jz_gpio_set_irq_bit(data, JZ_REG_GPIO_TRIGGER_CLEAR);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int jz_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
-{
-	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(data);
-
-	irq_gc_set_wake(data, on);
-	irq_set_irq_wake(chip->irq, on);
-
-	return 0;
-}
-
-#define JZ4740_GPIO_CHIP(_bank) { \
-	.irq_base = JZ4740_IRQ_GPIO_BASE_ ## _bank, \
-	.gpio_chip = { \
-		.label = "Bank " # _bank, \
-		.owner = THIS_MODULE, \
-		.set = jz_gpio_set_value, \
-		.get = jz_gpio_get_value, \
-		.direction_output = jz_gpio_direction_output, \
-		.direction_input = jz_gpio_direction_input, \
-		.to_irq = jz_gpio_to_irq, \
-		.base = JZ4740_GPIO_BASE_ ## _bank, \
-		.ngpio = JZ4740_GPIO_NUM_ ## _bank, \
-	}, \
-}
-
-static struct jz_gpio_chip jz4740_gpio_chips[] = {
-	JZ4740_GPIO_CHIP(A),
-	JZ4740_GPIO_CHIP(B),
-	JZ4740_GPIO_CHIP(C),
-	JZ4740_GPIO_CHIP(D),
-};
-
-static void jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
-{
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-
-	chip->base = ioremap(JZ4740_GPIO_BASE_ADDR + (id * 0x100), 0x100);
-
-	chip->irq = JZ4740_IRQ_INTC_GPIO(id);
-	irq_set_chained_handler_and_data(chip->irq,
-					 jz_gpio_irq_demux_handler, chip);
-
-	gc = irq_alloc_generic_chip(chip->gpio_chip.label, 1, chip->irq_base,
-		chip->base, handle_level_irq);
-
-	gc->wake_enabled = IRQ_MSK(chip->gpio_chip.ngpio);
-	gc->private = chip;
-
-	ct = gc->chip_types;
-	ct->regs.enable = JZ_REG_GPIO_MASK_CLEAR;
-	ct->regs.disable = JZ_REG_GPIO_MASK_SET;
-	ct->regs.ack = JZ_REG_GPIO_FLAG_CLEAR;
-
-	ct->chip.name = "GPIO";
-	ct->chip.irq_mask = irq_gc_mask_disable_reg;
-	ct->chip.irq_unmask = jz_gpio_irq_unmask;
-	ct->chip.irq_ack = irq_gc_ack_set_bit;
-	ct->chip.irq_suspend = ingenic_intc_irq_suspend;
-	ct->chip.irq_resume = ingenic_intc_irq_resume;
-	ct->chip.irq_startup = jz_gpio_irq_startup;
-	ct->chip.irq_shutdown = jz_gpio_irq_shutdown;
-	ct->chip.irq_set_type = jz_gpio_irq_set_type;
-	ct->chip.irq_set_wake = jz_gpio_irq_set_wake;
-	ct->chip.flags = IRQCHIP_SET_TYPE_MASKED;
-
-	irq_setup_generic_chip(gc, IRQ_MSK(chip->gpio_chip.ngpio),
-		IRQ_GC_INIT_NESTED_LOCK, 0, IRQ_NOPROBE | IRQ_LEVEL);
-
-	gpiochip_add_data(&chip->gpio_chip, chip);
-}
-
-static int __init jz4740_gpio_init(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(jz4740_gpio_chips); ++i)
-		jz4740_gpio_chip_init(&jz4740_gpio_chips[i], i);
-
-	printk(KERN_INFO "JZ4740 GPIO initialized\n");
-
-	return 0;
-}
-arch_initcall(jz4740_gpio_init);
-
-#ifdef CONFIG_DEBUG_FS
-
-static inline void gpio_seq_reg(struct seq_file *s, struct jz_gpio_chip *chip,
-	const char *name, unsigned int reg)
-{
-	seq_printf(s, "\t%s: %08x\n", name, readl(chip->base + reg));
-}
-
-static int gpio_regs_show(struct seq_file *s, void *unused)
-{
-	struct jz_gpio_chip *chip = jz4740_gpio_chips;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(jz4740_gpio_chips); ++i, ++chip) {
-		seq_printf(s, "==GPIO %d==\n", i);
-		gpio_seq_reg(s, chip, "Pin", JZ_REG_GPIO_PIN);
-		gpio_seq_reg(s, chip, "Data", JZ_REG_GPIO_DATA);
-		gpio_seq_reg(s, chip, "Mask", JZ_REG_GPIO_MASK);
-		gpio_seq_reg(s, chip, "Pull", JZ_REG_GPIO_PULL);
-		gpio_seq_reg(s, chip, "Func", JZ_REG_GPIO_FUNC);
-		gpio_seq_reg(s, chip, "Select", JZ_REG_GPIO_SELECT);
-		gpio_seq_reg(s, chip, "Direction", JZ_REG_GPIO_DIRECTION);
-		gpio_seq_reg(s, chip, "Trigger", JZ_REG_GPIO_TRIGGER);
-		gpio_seq_reg(s, chip, "Flag", JZ_REG_GPIO_FLAG);
-	}
-
-	return 0;
-}
-
-static int gpio_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, gpio_regs_show, NULL);
-}
-
-static const struct file_operations gpio_regs_operations = {
-	.open		= gpio_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init gpio_debugfs_init(void)
-{
-	(void) debugfs_create_file("jz_regs_gpio", S_IFREG | S_IRUGO,
-				NULL, NULL, &gpio_regs_operations);
-	return 0;
-}
-subsys_initcall(gpio_debugfs_init);
-
-#endif
-- 
2.11.0
