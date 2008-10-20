Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 15:28:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:44513 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21920535AbYJTO2n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 15:28:43 +0100
Received: from localhost.localdomain (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D8CC6AA0C; Mon, 20 Oct 2008 23:28:37 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: 7 segment LED support
Date:	Mon, 20 Oct 2008 23:28:50 +0900
Message-Id: <1224512930-15075-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add sysfs interface for 7 segment LED and implement access routine for
RBTX4939.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/txx9/generic.h |    5 ++
 arch/mips/txx9/Kconfig               |    4 +
 arch/mips/txx9/generic/7segled.c     |  112 ++++++++++++++++++++++++++++++++++
 arch/mips/txx9/generic/Makefile      |    1 +
 arch/mips/txx9/rbtx4939/setup.c      |   31 +++++++++
 5 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/txx9/generic/7segled.c

diff --git a/arch/mips/include/asm/txx9/generic.h b/arch/mips/include/asm/txx9/generic.h
index 4316a3e..9cde009 100644
--- a/arch/mips/include/asm/txx9/generic.h
+++ b/arch/mips/include/asm/txx9/generic.h
@@ -86,4 +86,9 @@ void txx9_iocled_init(unsigned long baseaddr,
 		      int basenum, unsigned int num, int lowactive,
 		      const char *color, char **deftriggers);
 
+/* 7SEG LED */
+void txx9_7segled_init(unsigned int num,
+		       void (*putc)(unsigned int pos, unsigned char val));
+int txx9_7segled_putc(unsigned int pos, char c);
+
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 17052db..5a176ea 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -49,6 +49,7 @@ config TOSHIBA_RBTX4939
 	bool "Toshiba RBTX4939 bobard"
 	depends on MACH_TX49XX
 	select SOC_TX4939
+	select TXX9_7SEGLED
 	help
 	  This Toshiba board is based on the TX4939 processor. Say Y here to
 	  support this machine type
@@ -86,6 +87,9 @@ config SOC_TX4939
 	select HW_HAS_PCI
 	select PCI_TX4927
 
+config TXX9_7SEGLED
+	bool
+
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
 	depends on PCI && MACH_TXX9
diff --git a/arch/mips/txx9/generic/7segled.c b/arch/mips/txx9/generic/7segled.c
new file mode 100644
index 0000000..727ab21
--- /dev/null
+++ b/arch/mips/txx9/generic/7segled.c
@@ -0,0 +1,112 @@
+/*
+ * 7 Segment LED routines
+ * Based on RBTX49xx patch from CELF patch archive.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * (C) Copyright TOSHIBA CORPORATION 2005-2007
+ * All Rights Reserved.
+ */
+#include <linux/sysdev.h>
+#include <linux/slab.h>
+#include <linux/map_to_7segment.h>
+#include <asm/txx9/generic.h>
+
+static unsigned int tx_7segled_num;
+static void (*tx_7segled_putc)(unsigned int pos, unsigned char val);
+
+void __init txx9_7segled_init(unsigned int num,
+			      void (*putc)(unsigned int pos, unsigned char val))
+{
+	tx_7segled_num = num;
+	tx_7segled_putc = putc;
+}
+
+static SEG7_CONVERSION_MAP(txx9_seg7map, MAP_ASCII7SEG_ALPHANUM_LC);
+
+int txx9_7segled_putc(unsigned int pos, char c)
+{
+	if (pos >= tx_7segled_num)
+		return -EINVAL;
+	c = map_to_seg7(&txx9_seg7map, c);
+	if (c < 0)
+		return c;
+	tx_7segled_putc(pos, c);
+	return 0;
+}
+
+static ssize_t ascii_store(struct sys_device *dev,
+			   struct sysdev_attribute *attr,
+			   const char *buf, size_t size)
+{
+	unsigned int ch = dev->id;
+	txx9_7segled_putc(ch, buf[0]);
+	return size;
+}
+
+static ssize_t raw_store(struct sys_device *dev,
+			 struct sysdev_attribute *attr,
+			 const char *buf, size_t size)
+{
+	unsigned int ch = dev->id;
+	tx_7segled_putc(ch, buf[0]);
+	return size;
+}
+
+static SYSDEV_ATTR(ascii, 0200, NULL, ascii_store);
+static SYSDEV_ATTR(raw, 0200, NULL, raw_store);
+
+static ssize_t map_seg7_show(struct sysdev_class *class, char *buf)
+{
+	memcpy(buf, &txx9_seg7map, sizeof(txx9_seg7map));
+	return sizeof(txx9_seg7map);
+}
+
+static ssize_t map_seg7_store(struct sysdev_class *class,
+			      const char *buf, size_t size)
+{
+	if (size != sizeof(txx9_seg7map))
+		return -EINVAL;
+	memcpy(&txx9_seg7map, buf, size);
+	return size;
+}
+
+static SYSDEV_CLASS_ATTR(map_seg7, 0600, map_seg7_show, map_seg7_store);
+
+static struct sysdev_class tx_7segled_sysdev_class = {
+	.name	= "7segled",
+};
+
+static int __init tx_7segled_init_sysfs(void)
+{
+	int error, i;
+	if (!tx_7segled_num)
+		return -ENODEV;
+	error = sysdev_class_register(&tx_7segled_sysdev_class);
+	if (error)
+		return error;
+	error = sysdev_class_create_file(&tx_7segled_sysdev_class,
+					 &attr_map_seg7);
+	if (error)
+		return error;
+	for (i = 0; i < tx_7segled_num; i++) {
+		struct sys_device *dev;
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev) {
+			error = -ENODEV;
+			break;
+		}
+		dev->id = i;
+		dev->cls = &tx_7segled_sysdev_class;
+		error = sysdev_register(dev);
+		if (!error) {
+			sysdev_create_file(dev, &attr_ascii);
+			sysdev_create_file(dev, &attr_raw);
+		}
+	}
+	return error;
+}
+
+device_initcall(tx_7segled_init_sysfs);
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 0030d23..f2579ce 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
 obj-$(CONFIG_SOC_TX4939)	+= setup_tx4939.o irq_tx4939.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
 obj-$(CONFIG_SPI)		+= spi_eeprom.o
+obj-$(CONFIG_TXX9_7SEGLED)	+= 7segled.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index d564fb1..27d13ee 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -239,6 +239,32 @@ static inline void rbtx4939_led_setup(void)
 }
 #endif
 
+static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
+{
+#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+	unsigned long flags;
+	local_irq_save(flags);
+	/* bit7: reserved for LED class */
+	led_val[pos] = (led_val[pos] & 0x80) | (val & 0x7f);
+	val = led_val[pos];
+	local_irq_restore(flags);
+#endif
+	writeb(val, rbtx4939_7seg_addr(pos / 4, pos % 4));
+}
+
+static void rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
+{
+	/* convert from map_to_seg7() notation */
+	val = (val & 0x88) |
+		((val & 0x40) >> 6) |
+		((val & 0x20) >> 4) |
+		((val & 0x10) >> 2) |
+		((val & 0x04) << 2) |
+		((val & 0x02) << 4) |
+		((val & 0x01) << 6);
+	__rbtx4939_7segled_putc(pos, val);
+}
+
 static void __init rbtx4939_arch_init(void)
 {
 	rbtx4939_pci_setup();
@@ -274,6 +300,8 @@ static void __init rbtx4939_device_init(void)
 
 static void __init rbtx4939_setup(void)
 {
+	int i;
+
 	rbtx4939_ebusc_setup();
 	/* always enable ATA0 */
 	txx9_set64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_ATA0MODE);
@@ -284,6 +312,9 @@ static void __init rbtx4939_setup(void)
 
 	_machine_restart = rbtx4939_machine_restart;
 
+	txx9_7segled_init(RBTX4939_MAX_7SEGLEDS, rbtx4939_7segled_putc);
+	for (i = 0; i < RBTX4939_MAX_7SEGLEDS; i++)
+		txx9_7segled_putc(i, '-');
 	pr_info("RBTX4939 (Rev %02x) --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
 		readb(rbtx4939_board_rev_addr), readb(rbtx4939_ioc_rev_addr),
 		readb(rbtx4939_udipsw_addr), readb(rbtx4939_bdipsw_addr));
-- 
1.5.6.3
