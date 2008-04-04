Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 17:57:27 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:32489 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S529355AbYDDP4l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 17:56:41 +0200
Received: from localhost (p2014-ipad306funabasi.chiba.ocn.ne.jp [123.217.172.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A43D3AB7C; Sat,  5 Apr 2008 00:55:21 +0900 (JST)
Date:	Sat, 05 Apr 2008 00:56:09 +0900 (JST)
Message-Id: <20080405.005609.104641118.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/4] rbhma4500: use generic txx9 gpio
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use generic txx9 gpio (and gpiolib) for RBHMA4500 board.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                         |    2 +-
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |  133 ++++++++++-------------------
 include/asm-mips/tx4938/tx4938.h          |   14 +---
 3 files changed, 46 insertions(+), 103 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d06e204..340a31d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -653,7 +653,7 @@ config TOSHIBA_RBTX4938
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_KGDB
 	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select GENERIC_GPIO
+	select GPIO_TXX9
 	help
 	  This Toshiba board is based on the TX4938 processor. Say Y here to
 	  support this machine type
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 61249f0..b38ea5a 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -21,6 +21,7 @@
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 
 #include <asm/wbflush.h>
 #include <asm/reboot.h>
@@ -34,7 +35,7 @@
 #endif
 #include <linux/spi/spi.h>
 #include <asm/tx4938/spi.h>
-#include <asm/gpio.h>
+#include <asm/txx9pio.h>
 
 extern char * __init prom_getcmdline(void);
 static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr);
@@ -615,9 +616,6 @@ static void __init rbtx4938_spi_setup(void)
 {
 	/* set SPI_SEL */
 	tx4938_ccfgptr->pcfg |= TX4938_PCFG_SPI_SEL;
-	/* chip selects for SPI devices */
-	tx4938_pioptr->dout |= (1 << SEEPROM1_CS);
-	tx4938_pioptr->dir |= (1 << SEEPROM1_CS);
 }
 
 static struct resource rbtx4938_fpga_resource;
@@ -780,8 +778,8 @@ void __init tx4938_board_setup(void)
 	TX4938_WR64(0xff1fb950, TX4938_DMA_MCR_MSTEN);
 
 	/* PIO */
-	tx4938_pioptr->maskcpu = 0;
-	tx4938_pioptr->maskext = 0;
+	__raw_writel(0, &tx4938_pioptr->maskcpu);
+	__raw_writel(0, &tx4938_pioptr->maskext);
 
 	/* TX4938 internal registers */
 	if (request_resource(&iomem_resource, &tx4938_reg_resource))
@@ -984,106 +982,48 @@ device_initcall(rbtx4938_ne_init);
 
 /* GPIO support */
 
+int gpio_to_irq(unsigned gpio)
+{
+	return -EINVAL;
+}
+
+int irq_to_gpio(unsigned irq)
+{
+	return -EINVAL;
+}
+
 static DEFINE_SPINLOCK(rbtx4938_spi_gpio_lock);
 
-static void rbtx4938_spi_gpio_set(unsigned gpio, int value)
+static void rbtx4938_spi_gpio_set(struct gpio_chip *chip, unsigned int offset,
+				  int value)
 {
 	u8 val;
 	unsigned long flags;
-	gpio -= 16;
 	spin_lock_irqsave(&rbtx4938_spi_gpio_lock, flags);
 	val = *rbtx4938_spics_ptr;
 	if (value)
-		val |= 1 << gpio;
+		val |= 1 << offset;
 	else
-		val &= ~(1 << gpio);
+		val &= ~(1 << offset);
 	*rbtx4938_spics_ptr = val;
 	mmiowb();
 	spin_unlock_irqrestore(&rbtx4938_spi_gpio_lock, flags);
 }
 
-static int rbtx4938_spi_gpio_dir_out(unsigned gpio, int value)
+static int rbtx4938_spi_gpio_dir_out(struct gpio_chip *chip,
+				     unsigned int offset, int value)
 {
-	rbtx4938_spi_gpio_set(gpio, value);
+	rbtx4938_spi_gpio_set(chip, offset, value);
 	return 0;
 }
 
-static DEFINE_SPINLOCK(tx4938_gpio_lock);
-
-static int tx4938_gpio_get(unsigned gpio)
-{
-	return tx4938_pioptr->din & (1 << gpio);
-}
-
-static void tx4938_gpio_set_raw(unsigned gpio, int value)
-{
-	u32 val;
-	val = tx4938_pioptr->dout;
-	if (value)
-		val |= 1 << gpio;
-	else
-		val &= ~(1 << gpio);
-	tx4938_pioptr->dout = val;
-}
-
-static void tx4938_gpio_set(unsigned gpio, int value)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&tx4938_gpio_lock, flags);
-	tx4938_gpio_set_raw(gpio, value);
-	mmiowb();
-	spin_unlock_irqrestore(&tx4938_gpio_lock, flags);
-}
-
-static int tx4938_gpio_dir_in(unsigned gpio)
-{
-	spin_lock_irq(&tx4938_gpio_lock);
-	tx4938_pioptr->dir &= ~(1 << gpio);
-	mmiowb();
-	spin_unlock_irq(&tx4938_gpio_lock);
-	return 0;
-}
-
-static int tx4938_gpio_dir_out(unsigned int gpio, int value)
-{
-	spin_lock_irq(&tx4938_gpio_lock);
-	tx4938_gpio_set_raw(gpio, value);
-	tx4938_pioptr->dir |= 1 << gpio;
-	mmiowb();
-	spin_unlock_irq(&tx4938_gpio_lock);
-	return 0;
-}
-
-int gpio_direction_input(unsigned gpio)
-{
-	if (gpio < 16)
-		return tx4938_gpio_dir_in(gpio);
-	return -EINVAL;
-}
-
-int gpio_direction_output(unsigned gpio, int value)
-{
-	if (gpio < 16)
-		return tx4938_gpio_dir_out(gpio, value);
-	if (gpio < 16 + 3)
-		return rbtx4938_spi_gpio_dir_out(gpio, value);
-	return -EINVAL;
-}
-
-int gpio_get_value(unsigned gpio)
-{
-	if (gpio < 16)
-		return tx4938_gpio_get(gpio);
-	return 0;
-}
-
-void gpio_set_value(unsigned gpio, int value)
-{
-	if (gpio < 16)
-		tx4938_gpio_set(gpio, value);
-	else
-		rbtx4938_spi_gpio_set(gpio, value);
-}
+static struct gpio_chip rbtx4938_spi_gpio_chip = {
+	.set = rbtx4938_spi_gpio_set,
+	.direction_output = rbtx4938_spi_gpio_dir_out,
+	.label = "RBTX4938-SPICS",
+	.base = 16,
+	.ngpio = 3,
+};
 
 /* SPI support */
 
@@ -1118,10 +1058,25 @@ static int __init rbtx4938_spi_init(void)
 	spi_eeprom_register(SEEPROM1_CS);
 	spi_eeprom_register(16 + SEEPROM2_CS);
 	spi_eeprom_register(16 + SEEPROM3_CS);
+	gpio_request(16 + SRTC_CS, "rtc-rs5c348");
+	gpio_direction_output(16 + SRTC_CS, 0);
+	gpio_request(SEEPROM1_CS, "seeprom1");
+	gpio_direction_output(SEEPROM1_CS, 1);
+	gpio_request(16 + SEEPROM2_CS, "seeprom2");
+	gpio_direction_output(16 + SEEPROM2_CS, 1);
+	gpio_request(16 + SEEPROM3_CS, "seeprom3");
+	gpio_direction_output(16 + SEEPROM3_CS, 1);
 	txx9_spi_init(TX4938_SPI_REG & 0xfffffffffULL, RBTX4938_IRQ_IRC_SPI);
 	return 0;
 }
-arch_initcall(rbtx4938_spi_init);
+
+static int __init rbtx4938_arch_init(void)
+{
+	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, 16);
+	gpiochip_add(&rbtx4938_spi_gpio_chip);
+	return rbtx4938_spi_init();
+}
+arch_initcall(rbtx4938_arch_init);
 
 /* Watchdog support */
 
diff --git a/include/asm-mips/tx4938/tx4938.h b/include/asm-mips/tx4938/tx4938.h
index f7c448b..a05f031 100644
--- a/include/asm-mips/tx4938/tx4938.h
+++ b/include/asm-mips/tx4938/tx4938.h
@@ -261,18 +261,6 @@ struct tx4938_sio_reg {
 	volatile unsigned long rfifo;
 };
 
-struct tx4938_pio_reg {
-	volatile unsigned long dout;
-	volatile unsigned long din;
-	volatile unsigned long dir;
-	volatile unsigned long od;
-	volatile unsigned long flag[2];
-	volatile unsigned long pol;
-	volatile unsigned long intc;
-	volatile unsigned long maskcpu;
-	volatile unsigned long maskext;
-};
-
 struct tx4938_ndfmc_reg {
 	endian_def_l2(unused0, dtr);
 	endian_def_l2(unused1, mcr);
@@ -642,7 +630,7 @@ struct tx4938_ccfg_reg {
 #define tx4938_pcic1ptr		((struct tx4938_pcic_reg *)TX4938_PCIC1_REG)
 #define tx4938_ccfgptr		((struct tx4938_ccfg_reg *)TX4938_CCFG_REG)
 #define tx4938_sioptr(ch)	((struct tx4938_sio_reg *)TX4938_SIO_REG(ch))
-#define tx4938_pioptr		((struct tx4938_pio_reg *)TX4938_PIO_REG)
+#define tx4938_pioptr		((struct txx9_pio_reg __iomem *)TX4938_PIO_REG)
 #define tx4938_aclcptr		((struct tx4938_aclc_reg *)TX4938_ACLC_REG)
 #define tx4938_spiptr		((struct tx4938_spi_reg *)TX4938_SPI_REG)
 #define tx4938_sramcptr		((struct tx4938_sramc_reg *)TX4938_SRAMC_REG)
