Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 15:22:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:8935 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022330AbXFVOWi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2007 15:22:38 +0100
Received: from localhost (p1126-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.126])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 57190969E; Fri, 22 Jun 2007 23:21:14 +0900 (JST)
Date:	Fri, 22 Jun 2007 23:21:55 +0900 (JST)
Message-Id: <20070622.232155.122616682.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/4] rbtx4938: Add generic GPIO support
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
X-archive-position: 15514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

GPIO 0..15 are for TX4938 PIO pins, GPIO 16..18 are for FPGA-driven
chipselect signals for SPI devices.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on:
[PATCH] Add MIPS generic GPIO support (by Yoichi Yuasa, already queued)
[PATCH] Create fallback gpio.h

 arch/mips/Kconfig                         |    1 +
 arch/mips/configs/rbhma4500_defconfig     |    1 +
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |  100 +++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 24661d6..823a628 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -660,6 +660,7 @@ config TOSHIBA_RBTX4938
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_KGDB
 	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_GPIO
 	help
 	  This Toshiba board is based on the TX4938 processor. Say Y here to
 	  support this machine type
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index b0abd16..6e10c15 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -80,6 +80,7 @@ CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_I8259=y
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index f5d1ce7..9f83844 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -29,6 +29,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/bootinfo.h>
+#include <asm/gpio.h>
 #include <asm/tx4938/rbtx4938.h>
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/tty.h>
@@ -1057,3 +1058,102 @@ static int __init rbtx4938_ne_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 device_initcall(rbtx4938_ne_init);
+
+/* GPIO support */
+
+static DEFINE_SPINLOCK(rbtx4938_spi_gpio_lock);
+
+static void rbtx4938_spi_gpio_set(unsigned gpio, int value)
+{
+	u8 val;
+	unsigned long flags;
+	gpio -= 16;
+	spin_lock_irqsave(&rbtx4938_spi_gpio_lock, flags);
+	val = *rbtx4938_spics_ptr;
+	if (value)
+		val |= 1 << gpio;
+	else
+		val &= ~(1 << gpio);
+	*rbtx4938_spics_ptr = val;
+	spin_unlock_irqrestore(&rbtx4938_spi_gpio_lock, flags);
+}
+
+static int rbtx4938_spi_gpio_dir_out(unsigned gpio, int value)
+{
+	rbtx4938_spi_gpio_set(gpio, value);
+	return 0;
+}
+
+static DEFINE_SPINLOCK(tx4938_gpio_lock);
+
+static int tx4938_gpio_get(unsigned gpio)
+{
+	return tx4938_pioptr->din & (1 << gpio);
+}
+
+static void tx4938_gpio_set_raw(unsigned gpio, int value)
+{
+	u32 val;
+	val = tx4938_pioptr->dout;
+	if (value)
+		val |= 1 << gpio;
+	else
+		val &= ~(1 << gpio);
+	tx4938_pioptr->dout = val;
+}
+
+static void tx4938_gpio_set(unsigned gpio, int value)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&tx4938_gpio_lock, flags);
+	tx4938_gpio_set_raw(gpio, value);
+	spin_unlock_irqrestore(&tx4938_gpio_lock, flags);
+}
+
+static int tx4938_gpio_dir_in(unsigned gpio)
+{
+	spin_lock_irq(&tx4938_gpio_lock);
+	tx4938_pioptr->dir &= ~(1 << gpio);
+	spin_unlock_irq(&tx4938_gpio_lock);
+	return 0;
+}
+
+static int tx4938_gpio_dir_out(unsigned int gpio, int value)
+{
+	spin_lock_irq(&tx4938_gpio_lock);
+	tx4938_gpio_set_raw(gpio, value);
+	tx4938_pioptr->dir |= 1 << gpio;
+	spin_unlock_irq(&tx4938_gpio_lock);
+	return 0;
+}
+
+int gpio_direction_input(unsigned gpio)
+{
+	if (gpio < 16)
+		return tx4938_gpio_dir_in(gpio);
+	return -EINVAL;
+}
+
+int gpio_direction_output(unsigned gpio, int value)
+{
+	if (gpio < 16)
+		return tx4938_gpio_dir_out(gpio, value);
+	if (gpio < 16 + 3)
+		return rbtx4938_spi_gpio_dir_out(gpio, value);
+	return -EINVAL;
+}
+
+int gpio_get_value(unsigned gpio)
+{
+	if (gpio < 16)
+		return tx4938_gpio_get(gpio);
+	return 0;
+}
+
+void gpio_set_value(unsigned gpio, int value)
+{
+	if (gpio < 16)
+		tx4938_gpio_set(gpio, value);
+	else
+		rbtx4938_spi_gpio_set(gpio, value);
+}
