Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:59:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:16593 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580946AbYHSNz0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:26 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C59EDB7D7; Tue, 19 Aug 2008 22:55:19 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 10/14] TXx9: Make spi_eeprom.c more generic
Date:	Tue, 19 Aug 2008 22:55:14 +0900
Message-Id: <1219154118-21193-10-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Helper routines in txx9/rbtx4938/spi_eeprom.c is not TX4938 specific.
Move it to txx9/generic/ directory and make it works with SPI bus
number other than 0.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/Makefile      |    1 +
 arch/mips/txx9/generic/spi_eeprom.c  |  103 ++++++++++++++++++++++++++++++++++
 arch/mips/txx9/rbtx4938/Makefile     |    2 +-
 arch/mips/txx9/rbtx4938/setup.c      |   11 ++--
 arch/mips/txx9/rbtx4938/spi_eeprom.c |   99 --------------------------------
 include/asm-mips/txx9/spi.h          |   19 ++++++-
 6 files changed, 128 insertions(+), 107 deletions(-)
 create mode 100644 arch/mips/txx9/generic/spi_eeprom.c
 delete mode 100644 arch/mips/txx9/rbtx4938/spi_eeprom.c

diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 9bb34af..986852c 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_SOC_TX3927)	+= setup_tx3927.o irq_tx3927.o
 obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
+obj-$(CONFIG_SPI)		+= spi_eeprom.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/generic/spi_eeprom.c b/arch/mips/txx9/generic/spi_eeprom.c
new file mode 100644
index 0000000..75c3472
--- /dev/null
+++ b/arch/mips/txx9/generic/spi_eeprom.c
@@ -0,0 +1,103 @@
+/*
+ * spi_eeprom.c
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/eeprom.h>
+#include <asm/txx9/spi.h>
+
+#define AT250X0_PAGE_SIZE	8
+
+/* register board information for at25 driver */
+int __init spi_eeprom_register(int busid, int chipid, int size)
+{
+	struct spi_board_info info = {
+		.modalias = "at25",
+		.max_speed_hz = 1500000,	/* 1.5Mbps */
+		.bus_num = busid,
+		.chip_select = chipid,
+		/* Mode 0: High-Active, Sample-Then-Shift */
+	};
+	struct spi_eeprom *eeprom;
+	eeprom = kzalloc(sizeof(*eeprom), GFP_KERNEL);
+	if (!eeprom)
+		return -ENOMEM;
+	strcpy(eeprom->name, "at250x0");
+	eeprom->byte_len = size;
+	eeprom->page_size = AT250X0_PAGE_SIZE;
+	eeprom->flags = EE_ADDR1;
+	info.platform_data = eeprom;
+	return spi_register_board_info(&info, 1);
+}
+
+/* simple temporary spi driver to provide early access to seeprom. */
+
+static struct read_param {
+	int busid;
+	int chipid;
+	int address;
+	unsigned char *buf;
+	int len;
+} *read_param;
+
+static int __init early_seeprom_probe(struct spi_device *spi)
+{
+	int stat = 0;
+	u8 cmd[2];
+	int len = read_param->len;
+	char *buf = read_param->buf;
+	int address = read_param->address;
+
+	dev_info(&spi->dev, "spiclk %u KHz.\n",
+		 (spi->max_speed_hz + 500) / 1000);
+	if (read_param->busid != spi->master->bus_num ||
+	    read_param->chipid != spi->chip_select)
+		return -ENODEV;
+	while (len > 0) {
+		/* spi_write_then_read can only work with small chunk */
+		int c = len < AT250X0_PAGE_SIZE ? len : AT250X0_PAGE_SIZE;
+		cmd[0] = 0x03;	/* AT25_READ */
+		cmd[1] = address;
+		stat = spi_write_then_read(spi, cmd, sizeof(cmd), buf, c);
+		buf += c;
+		len -= c;
+		address += c;
+	}
+	return stat;
+}
+
+static struct spi_driver early_seeprom_driver __initdata = {
+	.driver = {
+		.name	= "at25",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= early_seeprom_probe,
+};
+
+int __init spi_eeprom_read(int busid, int chipid, int address,
+			   unsigned char *buf, int len)
+{
+	int ret;
+	struct read_param param = {
+		.busid = busid,
+		.chipid = chipid,
+		.address = address,
+		.buf = buf,
+		.len = len
+	};
+
+	read_param = &param;
+	ret = spi_register_driver(&early_seeprom_driver);
+	if (!ret)
+		spi_unregister_driver(&early_seeprom_driver);
+	return ret;
+}
diff --git a/arch/mips/txx9/rbtx4938/Makefile b/arch/mips/txx9/rbtx4938/Makefile
index 9dcc52a..f3e1f59 100644
--- a/arch/mips/txx9/rbtx4938/Makefile
+++ b/arch/mips/txx9/rbtx4938/Makefile
@@ -1,3 +1,3 @@
-obj-y	+= prom.o setup.o irq.o spi_eeprom.o
+obj-y	+= prom.o setup.o irq.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 7aba92a..ec6e812 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -111,6 +111,7 @@ static void __init rbtx4938_pci_setup(void)
 #define	SEEPROM2_CS	0	/* IOC */
 #define	SEEPROM3_CS	1	/* IOC */
 #define	SRTC_CS	2	/* IOC */
+#define SPI_BUSNO	0
 
 static int __init rbtx4938_ethaddr_init(void)
 {
@@ -120,7 +121,7 @@ static int __init rbtx4938_ethaddr_init(void)
 	int i;
 
 	/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
-	if (spi_eeprom_read(SEEPROM1_CS, 0, dat, sizeof(dat))) {
+	if (spi_eeprom_read(SPI_BUSNO, SEEPROM1_CS, 0, dat, sizeof(dat))) {
 		printk(KERN_ERR "seeprom: read error.\n");
 		return -ENODEV;
 	} else {
@@ -287,9 +288,9 @@ static int __init rbtx4938_spi_init(void)
 		.mode = SPI_MODE_1 | SPI_CS_HIGH,
 	};
 	spi_register_board_info(&srtc_info, 1);
-	spi_eeprom_register(SEEPROM1_CS);
-	spi_eeprom_register(16 + SEEPROM2_CS);
-	spi_eeprom_register(16 + SEEPROM3_CS);
+	spi_eeprom_register(SPI_BUSNO, SEEPROM1_CS, 128);
+	spi_eeprom_register(SPI_BUSNO, 16 + SEEPROM2_CS, 128);
+	spi_eeprom_register(SPI_BUSNO, 16 + SEEPROM3_CS, 128);
 	gpio_request(16 + SRTC_CS, "rtc-rs5c348");
 	gpio_direction_output(16 + SRTC_CS, 0);
 	gpio_request(SEEPROM1_CS, "seeprom1");
@@ -298,7 +299,7 @@ static int __init rbtx4938_spi_init(void)
 	gpio_direction_output(16 + SEEPROM2_CS, 1);
 	gpio_request(16 + SEEPROM3_CS, "seeprom3");
 	gpio_direction_output(16 + SEEPROM3_CS, 1);
-	tx4938_spi_init(0);
+	tx4938_spi_init(SPI_BUSNO);
 	return 0;
 }
 
diff --git a/arch/mips/txx9/rbtx4938/spi_eeprom.c b/arch/mips/txx9/rbtx4938/spi_eeprom.c
deleted file mode 100644
index a7ea8b0..0000000
--- a/arch/mips/txx9/rbtx4938/spi_eeprom.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * spi_eeprom.c
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/eeprom.h>
-#include <asm/txx9/spi.h>
-
-#define AT250X0_PAGE_SIZE	8
-
-/* register board information for at25 driver */
-int __init spi_eeprom_register(int chipid)
-{
-	static struct spi_eeprom eeprom = {
-		.name = "at250x0",
-		.byte_len = 128,
-		.page_size = AT250X0_PAGE_SIZE,
-		.flags = EE_ADDR1,
-	};
-	struct spi_board_info info = {
-		.modalias = "at25",
-		.max_speed_hz = 1500000,	/* 1.5Mbps */
-		.bus_num = 0,
-		.chip_select = chipid,
-		.platform_data = &eeprom,
-		/* Mode 0: High-Active, Sample-Then-Shift */
-	};
-
-	return spi_register_board_info(&info, 1);
-}
-
-/* simple temporary spi driver to provide early access to seeprom. */
-
-static struct read_param {
-	int chipid;
-	int address;
-	unsigned char *buf;
-	int len;
-} *read_param;
-
-static int __init early_seeprom_probe(struct spi_device *spi)
-{
-	int stat = 0;
-	u8 cmd[2];
-	int len = read_param->len;
-	char *buf = read_param->buf;
-	int address = read_param->address;
-
-	dev_info(&spi->dev, "spiclk %u KHz.\n",
-		 (spi->max_speed_hz + 500) / 1000);
-	if (read_param->chipid != spi->chip_select)
-		return -ENODEV;
-	while (len > 0) {
-		/* spi_write_then_read can only work with small chunk */
-		int c = len < AT250X0_PAGE_SIZE ? len : AT250X0_PAGE_SIZE;
-		cmd[0] = 0x03;	/* AT25_READ */
-		cmd[1] = address;
-		stat = spi_write_then_read(spi, cmd, sizeof(cmd), buf, c);
-		buf += c;
-		len -= c;
-		address += c;
-	}
-	return stat;
-}
-
-static struct spi_driver early_seeprom_driver __initdata = {
-	.driver = {
-		.name	= "at25",
-		.owner	= THIS_MODULE,
-	},
-	.probe	= early_seeprom_probe,
-};
-
-int __init spi_eeprom_read(int chipid, int address,
-			   unsigned char *buf, int len)
-{
-	int ret;
-	struct read_param param = {
-		.chipid = chipid,
-		.address = address,
-		.buf = buf,
-		.len = len
-	};
-
-	read_param = &param;
-	ret = spi_register_driver(&early_seeprom_driver);
-	if (!ret)
-		spi_unregister_driver(&early_seeprom_driver);
-	return ret;
-}
diff --git a/include/asm-mips/txx9/spi.h b/include/asm-mips/txx9/spi.h
index ddfb2a0..0d727f3 100644
--- a/include/asm-mips/txx9/spi.h
+++ b/include/asm-mips/txx9/spi.h
@@ -13,7 +13,22 @@
 #ifndef __ASM_TXX9_SPI_H
 #define __ASM_TXX9_SPI_H
 
-extern int spi_eeprom_register(int chipid);
-extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
+#include <linux/errno.h>
+
+#ifdef CONFIG_SPI
+int spi_eeprom_register(int busid, int chipid, int size);
+int spi_eeprom_read(int busid, int chipid,
+		    int address, unsigned char *buf, int len);
+#else
+static inline int spi_eeprom_register(int busid, int chipid, int size)
+{
+	return -ENODEV;
+}
+static inline int spi_eeprom_read(int busid, int chipid,
+				  int address, unsigned char *buf, int len)
+{
+	return -ENODEV;
+}
+#endif
 
 #endif /* __ASM_TXX9_SPI_H */
-- 
1.5.6.3
