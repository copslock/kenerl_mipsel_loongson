Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 15:21:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:32464 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022320AbXFVOVa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2007 15:21:30 +0100
Received: from localhost (p1126-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.126])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B64C28642; Fri, 22 Jun 2007 23:21:25 +0900 (JST)
Date:	Fri, 22 Jun 2007 23:22:06 +0900 (JST)
Message-Id: <20070622.232206.88704003.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com, mlachwani@mvista.com
Subject: [PATCH 2/4] rbtx4938: Convert SPI codes to use generic SPI drivers
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
X-archive-position: 15511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use rtc-rs5c348 and at25 spi protocol driver and spi_txx9 spi
controller driver instead of platform dependent codes.

This patch also removes dependencies to old RTC interfaces such as
rtc_mips_get_time, etc.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on:
[PATCH] TXx9 SPI controller driver
[PATCH 1/4] rbtx4938: Add generic GPIO support

 arch/mips/configs/rbhma4500_defconfig          |   54 +++++-
 arch/mips/tx4938/common/Makefile               |    2 +-
 arch/mips/tx4938/common/rtc_rx5c348.c          |  192 -----------------
 arch/mips/tx4938/toshiba_rbtx4938/Makefile     |    2 +-
 arch/mips/tx4938/toshiba_rbtx4938/irq.c        |    6 -
 arch/mips/tx4938/toshiba_rbtx4938/setup.c      |  142 ++++++-------
 arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c |  261 +++++++-----------------
 arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c   |  164 ---------------
 include/asm-mips/tx4938/rbtx4938.h             |    6 -
 include/asm-mips/tx4938/spi.h                  |   56 +-----
 10 files changed, 190 insertions(+), 695 deletions(-)

diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 6e10c15..6b9beba 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -966,8 +966,20 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # SPI support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+CONFIG_SPI_TXX9=y
+
+#
+# SPI Protocol Masters
+#
+CONFIG_SPI_AT25=y
+# CONFIG_SPI_SPIDEV is not set
 
 #
 # Dallas's 1-wire bus
@@ -1207,7 +1219,43 @@ CONFIG_USB_MON=y
 #
 # Real Time Clock
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+
+#
+# SPI RTC drivers
+#
+CONFIG_RTC_DRV_RS5C348=y
+# CONFIG_RTC_DRV_MAX6902 is not set
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
 
 #
 # DMA Engine support
diff --git a/arch/mips/tx4938/common/Makefile b/arch/mips/tx4938/common/Makefile
index 2033ae7..83cda51 100644
--- a/arch/mips/tx4938/common/Makefile
+++ b/arch/mips/tx4938/common/Makefile
@@ -6,6 +6,6 @@
 # unless it's something special (ie not a .c file).
 #
 
-obj-y	+= prom.o setup.o irq.o rtc_rx5c348.o
+obj-y	+= prom.o setup.o irq.o
 obj-$(CONFIG_KGDB) += dbgio.o
 
diff --git a/arch/mips/tx4938/common/rtc_rx5c348.c b/arch/mips/tx4938/common/rtc_rx5c348.c
deleted file mode 100644
index 07f782f..0000000
--- a/arch/mips/tx4938/common/rtc_rx5c348.c
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * RTC routines for RICOH Rx5C348 SPI chip.
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
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/rtc.h>
-#include <linux/time.h>
-#include <linux/bcd.h>
-#include <asm/time.h>
-#include <asm/tx4938/spi.h>
-
-#define	EPOCH		2000
-
-/* registers */
-#define Rx5C348_REG_SECOND	0
-#define Rx5C348_REG_MINUTE	1
-#define Rx5C348_REG_HOUR	2
-#define Rx5C348_REG_WEEK	3
-#define Rx5C348_REG_DAY	4
-#define Rx5C348_REG_MONTH	5
-#define Rx5C348_REG_YEAR	6
-#define Rx5C348_REG_ADJUST	7
-#define Rx5C348_REG_ALARM_W_MIN	8
-#define Rx5C348_REG_ALARM_W_HOUR	9
-#define Rx5C348_REG_ALARM_W_WEEK	10
-#define Rx5C348_REG_ALARM_D_MIN	11
-#define Rx5C348_REG_ALARM_D_HOUR	12
-#define Rx5C348_REG_CTL1	14
-#define Rx5C348_REG_CTL2	15
-
-/* register bits */
-#define Rx5C348_BIT_PM	0x20	/* REG_HOUR */
-#define Rx5C348_BIT_Y2K	0x80	/* REG_MONTH */
-#define Rx5C348_BIT_24H	0x20	/* REG_CTL1 */
-#define Rx5C348_BIT_XSTP	0x10	/* REG_CTL2 */
-
-/* commands */
-#define Rx5C348_CMD_W(addr)	(((addr) << 4) | 0x08)	/* single write */
-#define Rx5C348_CMD_R(addr)	(((addr) << 4) | 0x0c)	/* single read */
-#define Rx5C348_CMD_MW(addr)	(((addr) << 4) | 0x00)	/* burst write */
-#define Rx5C348_CMD_MR(addr)	(((addr) << 4) | 0x04)	/* burst read */
-
-static struct spi_dev_desc srtc_dev_desc = {
-	.baud 		= 1000000,	/* 1.0Mbps @ Vdd 2.0V */
-	.tcss		= 31,
-	.tcsh		= 1,
-	.tcsr		= 62,
-	/* 31us for Tcss (62us for Tcsr) is required for carry operation) */
-	.byteorder	= 1,		/* MSB-First */
-	.polarity	= 0,		/* High-Active */
-	.phase		= 1,		/* Shift-Then-Sample */
-
-};
-static int srtc_chipid;
-static int srtc_24h;
-
-static inline int
-spi_rtc_io(unsigned char *inbuf, unsigned char *outbuf, unsigned int count)
-{
-	unsigned char *inbufs[1], *outbufs[1];
-	unsigned int incounts[2], outcounts[2];
-	inbufs[0] = inbuf;
-	incounts[0] = count;
-	incounts[1] = 0;
-	outbufs[0] = outbuf;
-	outcounts[0] = count;
-	outcounts[1] = 0;
-	return txx9_spi_io(srtc_chipid, &srtc_dev_desc,
-			   inbufs, incounts, outbufs, outcounts, 0);
-}
-
-/* RTC-dependent code for time.c */
-
-static int
-rtc_rx5c348_set_time(unsigned long t)
-{
-	unsigned char inbuf[8];
-	struct rtc_time tm;
-	u8 year, month, day, hour, minute, second, century;
-
-	/* convert */
-	to_tm(t, &tm);
-
-	year = tm.tm_year % 100;
-	month = tm.tm_mon+1;	/* tm_mon starts from 0 to 11 */
-	day = tm.tm_mday;
-	hour = tm.tm_hour;
-	minute = tm.tm_min;
-	second = tm.tm_sec;
-	century = tm.tm_year / 100;
-
-	inbuf[0] = Rx5C348_CMD_MW(Rx5C348_REG_SECOND);
-	BIN_TO_BCD(second);
-	inbuf[1] = second;
-	BIN_TO_BCD(minute);
-	inbuf[2] = minute;
-
-	if (srtc_24h) {
-		BIN_TO_BCD(hour);
-		inbuf[3] = hour;
-	} else {
-		/* hour 0 is AM12, noon is PM12 */
-		inbuf[3] = 0;
-		if (hour >= 12)
-			inbuf[3] = Rx5C348_BIT_PM;
-		hour = (hour + 11) % 12 + 1;
-		BIN_TO_BCD(hour);
-		inbuf[3] |= hour;
-	}
-	inbuf[4] = 0;	/* ignore week */
-	BIN_TO_BCD(day);
-	inbuf[5] = day;
-	BIN_TO_BCD(month);
-	inbuf[6] = month;
-	if (century >= 20)
-		inbuf[6] |= Rx5C348_BIT_Y2K;
-	BIN_TO_BCD(year);
-	inbuf[7] = year;
-	/* write in one transfer to avoid data inconsistency */
-	return spi_rtc_io(inbuf, NULL, 8);
-}
-
-static unsigned long
-rtc_rx5c348_get_time(void)
-{
-	unsigned char inbuf[8], outbuf[8];
-	unsigned int year, month, day, hour, minute, second;
-
-	inbuf[0] = Rx5C348_CMD_MR(Rx5C348_REG_SECOND);
-	memset(inbuf + 1, 0, 7);
-	/* read in one transfer to avoid data inconsistency */
-	if (spi_rtc_io(inbuf, outbuf, 8))
-		return 0;
-	second = outbuf[1];
-	BCD_TO_BIN(second);
-	minute = outbuf[2];
-	BCD_TO_BIN(minute);
-	if (srtc_24h) {
-		hour = outbuf[3];
-		BCD_TO_BIN(hour);
-	} else {
-		hour = outbuf[3] & ~Rx5C348_BIT_PM;
-		BCD_TO_BIN(hour);
-		hour %= 12;
-		if (outbuf[3] & Rx5C348_BIT_PM)
-			hour += 12;
-	}
-	day = outbuf[5];
-	BCD_TO_BIN(day);
-	month = outbuf[6] & ~Rx5C348_BIT_Y2K;
-	BCD_TO_BIN(month);
-	year = outbuf[7];
-	BCD_TO_BIN(year);
-	year += EPOCH;
-
-	return mktime(year, month, day, hour, minute, second);
-}
-
-void __init
-rtc_rx5c348_init(int chipid)
-{
-	unsigned char inbuf[2], outbuf[2];
-	srtc_chipid = chipid;
-	/* turn on RTC if it is not on */
-	inbuf[0] = Rx5C348_CMD_R(Rx5C348_REG_CTL2);
-	inbuf[1] = 0;
-	spi_rtc_io(inbuf, outbuf, 2);
-	if (outbuf[1] & Rx5C348_BIT_XSTP) {
-		inbuf[0] = Rx5C348_CMD_W(Rx5C348_REG_CTL2);
-		inbuf[1] = 0;
-		spi_rtc_io(inbuf, NULL, 2);
-	}
-
-	inbuf[0] = Rx5C348_CMD_R(Rx5C348_REG_CTL1);
-	inbuf[1] = 0;
-	spi_rtc_io(inbuf, outbuf, 2);
-	if (outbuf[1] & Rx5C348_BIT_24H)
-		srtc_24h = 1;
-
-	/* set the function pointers */
-	rtc_mips_get_time = rtc_rx5c348_get_time;
-	rtc_mips_set_time = rtc_rx5c348_set_time;
-}
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/Makefile b/arch/mips/tx4938/toshiba_rbtx4938/Makefile
index 2269412..10c94e6 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/Makefile
+++ b/arch/mips/tx4938/toshiba_rbtx4938/Makefile
@@ -6,4 +6,4 @@
 # unless it's something special (ie not a .c file).
 #
 
-obj-y	+= prom.o setup.o irq.o spi_eeprom.o spi_txx9.o
+obj-y	+= prom.o setup.o irq.o spi_eeprom.o
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index 2e96dbb..91aea7a 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -165,8 +165,6 @@ toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
 	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
 }
 
-extern void __init txx9_spi_irqinit(int irc_irq);
-
 void __init arch_init_irq(void)
 {
 	extern void tx4938_irq_init(void);
@@ -185,9 +183,5 @@ void __init arch_init_irq(void)
 	/* Onboard 10M Ether: High Active */
 	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM0), 0x00000040);
 
-	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_SPI_SEL) {
-		txx9_spi_irqinit(RBTX4938_IRQ_IRC_SPI);
-        }
-
 	wbflush();
 }
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 9f83844..a835870 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
-#include <linux/proc_fs.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/console.h>
@@ -29,13 +28,15 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/bootinfo.h>
-#include <asm/gpio.h>
 #include <asm/tx4938/rbtx4938.h>
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #endif
+#include <linux/spi/spi.h>
+#include <asm/tx4938/spi.h>
+#include <asm/gpio.h>
 
 extern void rbtx4938_time_init(void) __init;
 extern char * __init prom_getcmdline(void);
@@ -575,44 +576,33 @@ arch_initcall(tx4938_pcibios_init);
 #define	SEEPROM3_CS	1	/* IOC */
 #define	SRTC_CS	2	/* IOC */
 
-static int rbtx4938_spi_cs_func(int chipid, int on)
+#ifdef CONFIG_PCI
+static unsigned char rbtx4938_ethaddr[17];
+static int __init rbtx4938_ethaddr_init(void)
 {
-	unsigned char bit;
-	switch (chipid) {
-	case RBTX4938_SEEPROM1_CHIPID:
-		if (on)
-			tx4938_pioptr->dout &= ~(1 << SEEPROM1_CS);
-		else
-			tx4938_pioptr->dout |= (1 << SEEPROM1_CS);
-		return 0;
-		break;
-	case RBTX4938_SEEPROM2_CHIPID:
-		bit = (1 << SEEPROM2_CS);
-		break;
-	case RBTX4938_SEEPROM3_CHIPID:
-		bit = (1 << SEEPROM3_CS);
-		break;
-	case RBTX4938_SRTC_CHIPID:
-		bit = (1 << SRTC_CS);
-		break;
-	default:
-		return -ENODEV;
+	unsigned char sum;
+	int i;
+
+	/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
+	if (spi_eeprom_read(SEEPROM1_CS, 0,
+			    rbtx4938_ethaddr, sizeof(rbtx4938_ethaddr)))
+		printk(KERN_ERR "seeprom: read error.\n");
+	else {
+		unsigned char *dat = rbtx4938_ethaddr;
+		if (strcmp(dat, "MAC") != 0)
+			printk(KERN_WARNING "seeprom: bad signature.\n");
+		for (i = 0, sum = 0; i < sizeof(dat); i++)
+			sum += dat[i];
+		if (sum)
+			printk(KERN_WARNING "seeprom: bad checksum.\n");
 	}
-	/* bit1,2,4 are low active, bit3 is high active */
-	*rbtx4938_spics_ptr =
-		(*rbtx4938_spics_ptr & ~bit) |
-		((on ? (bit ^ 0x0b) : ~(bit ^ 0x0b)) & bit);
 	return 0;
 }
-
-#ifdef CONFIG_PCI
-extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
+device_initcall(rbtx4938_ethaddr_init);
 
 int rbtx4938_get_tx4938_ethaddr(struct pci_dev *dev, unsigned char *addr)
 {
 	struct pci_controller *channel = (struct pci_controller *)dev->bus->sysdata;
-	static unsigned char dat[17];
-	static int read_dat = 0;
 	int ch = 0;
 
 	if (channel != &tx4938_pci_controller[1])
@@ -628,29 +618,11 @@ int rbtx4938_get_tx4938_ethaddr(struct pci_dev *dev, unsigned char *addr)
 	default:
 		return -ENODEV;
 	}
-	if (!read_dat) {
-		unsigned char sum;
-		int i;
-		read_dat = 1;
-		/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
-		if (spi_eeprom_read(RBTX4938_SEEPROM1_CHIPID,
-				    0, dat, sizeof(dat))) {
-			printk(KERN_ERR "seeprom: read error.\n");
-		} else {
-			if (strcmp(dat, "MAC") != 0)
-				printk(KERN_WARNING "seeprom: bad signature.\n");
-			for (i = 0, sum = 0; i < sizeof(dat); i++)
-				sum += dat[i];
-			if (sum)
-				printk(KERN_WARNING "seeprom: bad checksum.\n");
-		}
-	}
-	memcpy(addr, &dat[4 + 6 * ch], 6);
+	memcpy(addr, &rbtx4938_ethaddr[4 + 6 * ch], 6);
 	return 0;
 }
 #endif /* CONFIG_PCI */
 
-extern void __init txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on));
 static void __init rbtx4938_spi_setup(void)
 {
 	/* set SPI_SEL */
@@ -658,7 +630,6 @@ static void __init rbtx4938_spi_setup(void)
 	/* chip selects for SPI devices */
 	tx4938_pioptr->dout |= (1 << SEEPROM1_CS);
 	tx4938_pioptr->dir |= (1 << SEEPROM1_CS);
-	txx9_spi_init(TX4938_SPI_REG, rbtx4938_spi_cs_func);
 }
 
 static struct resource rbtx4938_fpga_resource;
@@ -897,10 +868,8 @@ void tx4938_report_pcic_status(void)
 /* We use onchip r4k counter or TMR timer as our system wide timer
  * interrupt running at 100HZ. */
 
-extern void __init rtc_rx5c348_init(int chipid);
 void __init rbtx4938_time_init(void)
 {
-	rtc_rx5c348_init(RBTX4938_SRTC_CHIPID);
 	mips_hpt_frequency = txx9_cpu_clock / 2;
 }
 
@@ -1017,29 +986,6 @@ void __init toshiba_rbtx4938_setup(void)
 	       *rbtx4938_dipsw_ptr, *rbtx4938_bdipsw_ptr);
 }
 
-#ifdef CONFIG_PROC_FS
-extern void spi_eeprom_proc_create(struct proc_dir_entry *dir, int chipid);
-static int __init tx4938_spi_proc_setup(void)
-{
-	struct proc_dir_entry *tx4938_spi_eeprom_dir;
-
-	tx4938_spi_eeprom_dir = proc_mkdir("spi_eeprom", 0);
-
-	if (!tx4938_spi_eeprom_dir)
-		return -ENOMEM;
-
-	/* don't allow user access to RBTX4938_SEEPROM1_CHIPID
-	 * as it contains eth0 and eth1 MAC addresses
-	 */
-	spi_eeprom_proc_create(tx4938_spi_eeprom_dir, RBTX4938_SEEPROM2_CHIPID);
-	spi_eeprom_proc_create(tx4938_spi_eeprom_dir, RBTX4938_SEEPROM3_CHIPID);
-
-	return 0;
-}
-
-__initcall(tx4938_spi_proc_setup);
-#endif
-
 static int __init rbtx4938_ne_init(void)
 {
 	struct resource res[] = {
@@ -1157,3 +1103,45 @@ void gpio_set_value(unsigned gpio, int value)
 	else
 		rbtx4938_spi_gpio_set(gpio, value);
 }
+
+/* SPI support */
+
+static void __init txx9_spi_init(unsigned long base, int irq)
+{
+	struct resource res[] = {
+		{
+			.start	= base,
+			.end	= base + 0x20 - 1,
+			.flags	= IORESOURCE_MEM,
+			.parent	= &tx4938_reg_resource,
+		}, {
+			.start	= irq,
+			.flags	= IORESOURCE_IRQ,
+		}, {
+			.name	= "baseclk",
+			.start	= txx9_gbus_clock / 2 / 4,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+	platform_device_register_simple("txx9spi", 0,
+					res, ARRAY_SIZE(res));
+}
+
+static int __init rbtx4938_spi_init(void)
+{
+	struct spi_board_info srtc_info = {
+		.modalias = "rs5c348",
+		.max_speed_hz = 1000000, /* 1.0Mbps @ Vdd 2.0V */
+		.bus_num = 0,
+		.chip_select = 16 + SRTC_CS,
+		/* Mode 1 (High-Active, Shift-Then-Sample), High Avtive CS  */
+		.mode = SPI_MODE_1 | SPI_CS_HIGH,
+	};
+	spi_register_board_info(&srtc_info, 1);
+	spi_eeprom_register(SEEPROM1_CS);
+	spi_eeprom_register(16 + SEEPROM2_CS);
+	spi_eeprom_register(16 + SEEPROM3_CS);
+	txx9_spi_init(TX4938_SPI_REG & 0xfffffffffULL, RBTX4938_IRQ_IRC_SPI);
+	return 0;
+}
+arch_initcall(rbtx4938_spi_init);
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c b/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
index 89596e6..4d6b4ad 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
@@ -10,209 +10,90 @@
  * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
  */
 #include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/proc_fs.h>
-#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/eeprom.h>
 #include <asm/tx4938/spi.h>
-#include <asm/tx4938/tx4938.h>
 
-/* ATMEL 250x0 instructions */
-#define	ATMEL_WREN	0x06
-#define	ATMEL_WRDI	0x04
-#define ATMEL_RDSR	0x05
-#define ATMEL_WRSR	0x01
-#define	ATMEL_READ	0x03
-#define	ATMEL_WRITE	0x02
+#define AT250X0_PAGE_SIZE	8
 
-#define ATMEL_SR_BSY	0x01
-#define ATMEL_SR_WEN	0x02
-#define ATMEL_SR_BP0	0x04
-#define ATMEL_SR_BP1	0x08
-
-DEFINE_SPINLOCK(spi_eeprom_lock);
-
-static struct spi_dev_desc seeprom_dev_desc = {
-	.baud 		= 1500000,	/* 1.5Mbps */
-	.tcss		= 1,
-	.tcsh		= 1,
-	.tcsr		= 1,
-	.byteorder	= 1,		/* MSB-First */
-	.polarity	= 0,		/* High-Active */
-	.phase		= 0,		/* Sample-Then-Shift */
-
-};
-static inline int
-spi_eeprom_io(int chipid,
-	      unsigned char **inbufs, unsigned int *incounts,
-	      unsigned char **outbufs, unsigned int *outcounts)
-{
-	return txx9_spi_io(chipid, &seeprom_dev_desc,
-			   inbufs, incounts, outbufs, outcounts, 0);
-}
-
-int spi_eeprom_write_enable(int chipid, int enable)
+/* register board information for at25 driver */
+int __init spi_eeprom_register(int chipid)
 {
-	unsigned char inbuf[1];
-	unsigned char *inbufs[1];
-	unsigned int incounts[2];
-	unsigned long flags;
-	int stat;
-	inbuf[0] = enable ? ATMEL_WREN : ATMEL_WRDI;
-	inbufs[0] = inbuf;
-	incounts[0] = sizeof(inbuf);
-	incounts[1] = 0;
-	spin_lock_irqsave(&spi_eeprom_lock, flags);
-	stat = spi_eeprom_io(chipid, inbufs, incounts, NULL, NULL);
-	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
-	return stat;
-}
-
-static int spi_eeprom_read_status_nolock(int chipid)
-{
-	unsigned char inbuf[2], outbuf[2];
-	unsigned char *inbufs[1], *outbufs[1];
-	unsigned int incounts[2], outcounts[2];
-	int stat;
-	inbuf[0] = ATMEL_RDSR;
-	inbuf[1] = 0;
-	inbufs[0] = inbuf;
-	incounts[0] = sizeof(inbuf);
-	incounts[1] = 0;
-	outbufs[0] = outbuf;
-	outcounts[0] = sizeof(outbuf);
-	outcounts[1] = 0;
-	stat = spi_eeprom_io(chipid, inbufs, incounts, outbufs, outcounts);
-	if (stat < 0)
-		return stat;
-	return outbuf[1];
+	static struct spi_eeprom eeprom = {
+		.name = "at250x0",
+		.byte_len = 128,
+		.page_size = AT250X0_PAGE_SIZE,
+		.flags = EE_ADDR1,
+	};
+	struct spi_board_info info = {
+		.modalias = "at25",
+		.max_speed_hz = 1500000,	/* 1.5Mbps */
+		.bus_num = 0,
+		.chip_select = chipid,
+		.platform_data = &eeprom,
+		/* Mode 0: High-Active, Sample-Then-Shift */
+	};
+
+	return spi_register_board_info(&info, 1);
 }
 
-int spi_eeprom_read_status(int chipid)
-{
-	unsigned long flags;
-	int stat;
-	spin_lock_irqsave(&spi_eeprom_lock, flags);
-	stat = spi_eeprom_read_status_nolock(chipid);
-	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
-	return stat;
-}
+/* simple temporary spi driver to provide early access to seeprom. */
 
-int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len)
-{
-	unsigned char inbuf[2];
-	unsigned char *inbufs[2], *outbufs[2];
-	unsigned int incounts[2], outcounts[3];
-	unsigned long flags;
-	int stat;
-	inbuf[0] = ATMEL_READ;
-	inbuf[1] = address;
-	inbufs[0] = inbuf;
-	inbufs[1] = NULL;
-	incounts[0] = sizeof(inbuf);
-	incounts[1] = 0;
-	outbufs[0] = NULL;
-	outbufs[1] = buf;
-	outcounts[0] = 2;
-	outcounts[1] = len;
-	outcounts[2] = 0;
-	spin_lock_irqsave(&spi_eeprom_lock, flags);
-	stat = spi_eeprom_io(chipid, inbufs, incounts, outbufs, outcounts);
-	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
-	return stat;
-}
+static struct read_param {
+	int chipid;
+	int address;
+	unsigned char *buf;
+	int len;
+} *read_param;
 
-int spi_eeprom_write(int chipid, int address, unsigned char *buf, int len)
+static int __init early_seeprom_probe(struct spi_device *spi)
 {
-	unsigned char inbuf[2];
-	unsigned char *inbufs[2];
-	unsigned int incounts[3];
-	unsigned long flags;
-	int i, stat;
-
-	if (address / 8 != (address + len - 1) / 8)
-		return -EINVAL;
-	stat = spi_eeprom_write_enable(chipid, 1);
-	if (stat < 0)
-		return stat;
-	stat = spi_eeprom_read_status(chipid);
-	if (stat < 0)
-		return stat;
-	if (!(stat & ATMEL_SR_WEN))
-		return -EPERM;
-
-	inbuf[0] = ATMEL_WRITE;
-	inbuf[1] = address;
-	inbufs[0] = inbuf;
-	inbufs[1] = buf;
-	incounts[0] = sizeof(inbuf);
-	incounts[1] = len;
-	incounts[2] = 0;
-	spin_lock_irqsave(&spi_eeprom_lock, flags);
-	stat = spi_eeprom_io(chipid, inbufs, incounts, NULL, NULL);
-	if (stat < 0)
-		goto unlock_return;
-
-	/* write start.  max 10ms */
-	for (i = 10; i > 0; i--) {
-		int stat = spi_eeprom_read_status_nolock(chipid);
-		if (stat < 0)
-			goto unlock_return;
-		if (!(stat & ATMEL_SR_BSY))
-			break;
-		mdelay(1);
+	int stat = 0;
+	u8 cmd[2];
+	int len = read_param->len;
+	char *buf = read_param->buf;
+	int address = read_param->address;
+
+	dev_info(&spi->dev, "spiclk %u KHz.\n",
+		 (spi->max_speed_hz + 500) / 1000);
+	if (read_param->chipid != spi->chip_select)
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
 	}
-	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
-	if (i == 0)
-		return -EIO;
-	return len;
- unlock_return:
-	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
 	return stat;
 }
 
-#ifdef CONFIG_PROC_FS
-#define MAX_SIZE	0x80	/* for ATMEL 25010 */
-static int spi_eeprom_read_proc(char *page, char **start, off_t off,
-				int count, int *eof, void *data)
-{
-	unsigned int size = MAX_SIZE;
-	if (spi_eeprom_read((int)data, 0, (unsigned char *)page, size) < 0)
-		size = 0;
-	return size;
-}
-
-static int spi_eeprom_write_proc(struct file *file, const char *buffer,
-				 unsigned long count, void *data)
-{
-	unsigned int size = MAX_SIZE;
-	int i;
-	if (file->f_pos >= size)
-		return -EIO;
-	if (file->f_pos + count > size)
-		count = size - file->f_pos;
-	for (i = 0; i < count; i += 8) {
-		int len = count - i < 8 ? count - i : 8;
-		if (spi_eeprom_write((int)data, file->f_pos,
-				     (unsigned char *)buffer, len) < 0) {
-			count = -EIO;
-			break;
-		}
-		buffer += len;
-		file->f_pos += len;
-	}
-	return count;
-}
+static struct spi_driver early_seeprom_driver __initdata = {
+	.driver = {
+		.name	= "at25",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= early_seeprom_probe,
+};
 
-__init void spi_eeprom_proc_create(struct proc_dir_entry *dir, int chipid)
+int __init spi_eeprom_read(int chipid, int address,
+			   unsigned char *buf, int len)
 {
-	struct proc_dir_entry *entry;
-	char name[128];
-	sprintf(name, "seeprom-%d", chipid);
-	entry = create_proc_entry(name, 0600, dir);
-	if (entry) {
-		entry->read_proc = spi_eeprom_read_proc;
-		entry->write_proc = spi_eeprom_write_proc;
-		entry->data = (void *)chipid;
-	}
+	int ret;
+	struct read_param param = {
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
 }
-#endif /* CONFIG_PROC_FS */
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c b/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
deleted file mode 100644
index 08b20cd..0000000
--- a/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
+++ /dev/null
@@ -1,164 +0,0 @@
-/*
- * linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
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
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
-#include <asm/tx4938/spi.h>
-#include <asm/tx4938/tx4938.h>
-
-static int (*txx9_spi_cs_func)(int chipid, int on);
-static DEFINE_SPINLOCK(txx9_spi_lock);
-
-extern unsigned int txx9_gbus_clock;
-
-#define SPI_FIFO_SIZE	4
-
-void __init txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on))
-{
-	txx9_spi_cs_func = cs_func;
-	/* enter config mode */
-	tx4938_spiptr->mcr = TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR;
-}
-
-static DECLARE_WAIT_QUEUE_HEAD(txx9_spi_wait);
-
-static irqreturn_t txx9_spi_interrupt(int irq, void *dev_id)
-{
-	/* disable rx intr */
-	tx4938_spiptr->cr0 &= ~TXx9_SPCR0_RBSIE;
-	wake_up(&txx9_spi_wait);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction txx9_spi_action = {
-	.handler	= txx9_spi_interrupt,
-	.name		= "spi",
-};
-
-void __init txx9_spi_irqinit(int irc_irq)
-{
-	setup_irq(irc_irq, &txx9_spi_action);
-}
-
-int txx9_spi_io(int chipid, struct spi_dev_desc *desc,
-		unsigned char **inbufs, unsigned int *incounts,
-		unsigned char **outbufs, unsigned int *outcounts,
-		int cansleep)
-{
-	unsigned int incount, outcount;
-	unsigned char *inp, *outp;
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&txx9_spi_lock, flags);
-	if ((tx4938_spiptr->mcr & TXx9_SPMCR_OPMODE) == TXx9_SPMCR_ACTIVE) {
-		spin_unlock_irqrestore(&txx9_spi_lock, flags);
-		return -EBUSY;
-	}
-	/* enter config mode */
-	tx4938_spiptr->mcr = TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR;
-	tx4938_spiptr->cr0 =
-		(desc->byteorder ? TXx9_SPCR0_SBOS : 0) |
-		(desc->polarity ? TXx9_SPCR0_SPOL : 0) |
-		(desc->phase ? TXx9_SPCR0_SPHA : 0) |
-		0x08;
-	tx4938_spiptr->cr1 =
-		(((TXX9_IMCLK + desc->baud) / (2 * desc->baud) - 1) << 8) |
-		0x08 /* 8 bit only */;
-	/* enter active mode */
-	tx4938_spiptr->mcr = TXx9_SPMCR_ACTIVE;
-	spin_unlock_irqrestore(&txx9_spi_lock, flags);
-
-	/* CS ON */
-	if ((ret = txx9_spi_cs_func(chipid, 1)) < 0) {
-		spin_unlock_irqrestore(&txx9_spi_lock, flags);
-		return ret;
-	}
-	udelay(desc->tcss);
-
-	/* do scatter IO */
-	inp = inbufs ? *inbufs : NULL;
-	outp = outbufs ? *outbufs : NULL;
-	incount = 0;
-	outcount = 0;
-	while (1) {
-		unsigned char data;
-		unsigned int count;
-		int i;
-		if (!incount) {
-			incount = incounts ? *incounts++ : 0;
-			inp = (incount && inbufs) ? *inbufs++ : NULL;
-		}
-		if (!outcount) {
-			outcount = outcounts ? *outcounts++ : 0;
-			outp = (outcount && outbufs) ? *outbufs++ : NULL;
-		}
-		if (!inp && !outp)
-			break;
-		count = SPI_FIFO_SIZE;
-		if (incount)
-			count = min(count, incount);
-		if (outcount)
-			count = min(count, outcount);
-
-		/* now tx must be idle... */
-		while (!(tx4938_spiptr->sr & TXx9_SPSR_SIDLE))
-			;
-
-		tx4938_spiptr->cr0 =
-			(tx4938_spiptr->cr0 & ~TXx9_SPCR0_RXIFL_MASK) |
-			((count - 1) << 12);
-		if (cansleep) {
-			/* enable rx intr */
-			tx4938_spiptr->cr0 |= TXx9_SPCR0_RBSIE;
-		}
-		/* send */
-		for (i = 0; i < count; i++)
-			tx4938_spiptr->dr = inp ? *inp++ : 0;
-		/* wait all rx data */
-		if (cansleep) {
-			wait_event(txx9_spi_wait,
-				   tx4938_spiptr->sr & TXx9_SPSR_SRRDY);
-		} else {
-			while (!(tx4938_spiptr->sr & TXx9_SPSR_RBSI))
-				;
-		}
-		/* receive */
-		for (i = 0; i < count; i++) {
-			data = tx4938_spiptr->dr;
-			if (outp)
-				*outp++ = data;
-		}
-		if (incount)
-			incount -= count;
-		if (outcount)
-			outcount -= count;
-	}
-
-	/* CS OFF */
-	udelay(desc->tcsh);
-	txx9_spi_cs_func(chipid, 0);
-	udelay(desc->tcsr);
-
-	spin_lock_irqsave(&txx9_spi_lock, flags);
-	/* enter config mode */
-	tx4938_spiptr->mcr = TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR;
-	spin_unlock_irqrestore(&txx9_spi_lock, flags);
-
-	return 0;
-}
diff --git a/include/asm-mips/tx4938/rbtx4938.h b/include/asm-mips/tx4938/rbtx4938.h
index 0fbedaf..74e7d80 100644
--- a/include/asm-mips/tx4938/rbtx4938.h
+++ b/include/asm-mips/tx4938/rbtx4938.h
@@ -105,12 +105,6 @@
 #define rbtx4938_pcireset_ptr	\
 	((volatile unsigned char *)RBTX4938_PCIRESET_ADDR)
 
-/* SPI */
-#define RBTX4938_SEEPROM1_CHIPID	0
-#define RBTX4938_SEEPROM2_CHIPID	1
-#define RBTX4938_SEEPROM3_CHIPID	2
-#define RBTX4938_SRTC_CHIPID	3
-
 /*
  * IRQ mappings
  */
diff --git a/include/asm-mips/tx4938/spi.h b/include/asm-mips/tx4938/spi.h
index 0dbbab8..6a60c83 100644
--- a/include/asm-mips/tx4938/spi.h
+++ b/include/asm-mips/tx4938/spi.h
@@ -14,61 +14,7 @@
 #ifndef __ASM_TX_BOARDS_TX4938_SPI_H
 #define __ASM_TX_BOARDS_TX4938_SPI_H
 
-/* SPI */
-struct spi_dev_desc {
-	unsigned int baud;
-	unsigned short tcss, tcsh, tcsr; /* CS setup/hold/recovery time */
-	unsigned int byteorder:1;	/* 0:LSB-First, 1:MSB-First */
-	unsigned int polarity:1;	/* 0:High-Active */
-	unsigned int phase:1;		/* 0:Sample-Then-Shift */
-};
-
-extern void txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on)) __init;
-extern void txx9_spi_irqinit(int irc_irq) __init;
-extern int txx9_spi_io(int chipid, struct spi_dev_desc *desc,
-		       unsigned char **inbufs, unsigned int *incounts,
-		       unsigned char **outbufs, unsigned int *outcounts,
-		       int cansleep);
-extern int spi_eeprom_write_enable(int chipid, int enable);
-extern int spi_eeprom_read_status(int chipid);
+extern int spi_eeprom_register(int chipid);
 extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
-extern int spi_eeprom_write(int chipid, int address, unsigned char *buf, int len);
-extern void spi_eeprom_proc_create(struct proc_dir_entry *dir, int chipid) __init;
-
-#define TXX9_IMCLK     (txx9_gbus_clock / 2)
-
-/*
-* SPI
-*/
-
-/* SPMCR : SPI Master Control */
-#define TXx9_SPMCR_OPMODE	0xc0
-#define TXx9_SPMCR_CONFIG	0x40
-#define TXx9_SPMCR_ACTIVE	0x80
-#define TXx9_SPMCR_SPSTP	0x02
-#define TXx9_SPMCR_BCLR	0x01
-
-/* SPCR0 : SPI Status */
-#define TXx9_SPCR0_TXIFL_MASK	0xc000
-#define TXx9_SPCR0_RXIFL_MASK	0x3000
-#define TXx9_SPCR0_SIDIE	0x0800
-#define TXx9_SPCR0_SOEIE	0x0400
-#define TXx9_SPCR0_RBSIE	0x0200
-#define TXx9_SPCR0_TBSIE	0x0100
-#define TXx9_SPCR0_IFSPSE	0x0010
-#define TXx9_SPCR0_SBOS	0x0004
-#define TXx9_SPCR0_SPHA	0x0002
-#define TXx9_SPCR0_SPOL	0x0001
-
-/* SPSR : SPI Status */
-#define TXx9_SPSR_TBSI	0x8000
-#define TXx9_SPSR_RBSI	0x4000
-#define TXx9_SPSR_TBS_MASK	0x3800
-#define TXx9_SPSR_RBS_MASK	0x0700
-#define TXx9_SPSR_SPOE	0x0080
-#define TXx9_SPSR_IFSD	0x0008
-#define TXx9_SPSR_SIDLE	0x0004
-#define TXx9_SPSR_STRDY	0x0002
-#define TXx9_SPSR_SRRDY	0x0001
 
 #endif /* __ASM_TX_BOARDS_TX4938_SPI_H */
