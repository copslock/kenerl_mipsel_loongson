Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 17:23:46 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33780 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225218AbVAVRXk>; Sat, 22 Jan 2005 17:23:40 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id j0MHNcdh023556;
	Sat, 22 Jan 2005 09:23:38 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id j0MHNcsB023554;
	Sat, 22 Jan 2005 09:23:38 -0800
Date:	Sat, 22 Jan 2005 09:23:38 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Support for backplane on TX4927 based board
Message-ID: <20050122172338.GA23536@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Attached patch implements support for backplane on TX4927 based board. Please review and/or apply

Thanks
Manish Lachwani

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_tx4927_backplane.patch"

Source: MontaVista Software, Inc. | URL | Manish Lachwani <mlachwani@mvista.com>
MR: 9894
Type: Defect Fix 
Disposition: Submitted to Linux-MIPS
Keywords:
Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
Description:
	Backplane support for TX4927 based board in 2.6.10

Index: linux-2.6.10/arch/mips/tx4927/common/smsc_fdc37m81x.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/tx4927/common/smsc_fdc37m81x.c
@@ -0,0 +1,194 @@
+/*
+ * linux/arch/mips/tx4927/common/smsc_fdc37m81x.c
+ *
+ * Interface for smsc fdc48m81x Super IO chip
+ *
+ * Author: MontaVista Software, Inc. source@mvista.com
+ *
+ * 2001-2003 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Copyright 2004 (c) MontaVista Software, Inc.
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/config.h>
+#include <asm/io.h>
+#include <asm/tx4927/smsc_fdc37m81x.h>
+
+#define DEBUG
+
+/* Common Registers */
+#define SMSC_FDC37M81X_CONFIG_INDEX  0x00
+#define SMSC_FDC37M81X_CONFIG_DATA   0x01
+#define SMSC_FDC37M81X_CONF          0x02
+#define SMSC_FDC37M81X_INDEX         0x03
+#define SMSC_FDC37M81X_DNUM          0x07
+#define SMSC_FDC37M81X_DID           0x20
+#define SMSC_FDC37M81X_DREV          0x21
+#define SMSC_FDC37M81X_PCNT          0x22
+#define SMSC_FDC37M81X_PMGT          0x23
+#define SMSC_FDC37M81X_OSC           0x24
+#define SMSC_FDC37M81X_CONFPA0       0x26
+#define SMSC_FDC37M81X_CONFPA1       0x27
+#define SMSC_FDC37M81X_TEST4         0x2B
+#define SMSC_FDC37M81X_TEST5         0x2C
+#define SMSC_FDC37M81X_TEST1         0x2D
+#define SMSC_FDC37M81X_TEST2         0x2E
+#define SMSC_FDC37M81X_TEST3         0x2F
+
+/* Logical device numbers */
+#define SMSC_FDC37M81X_FDD           0x00
+#define SMSC_FDC37M81X_SERIAL1       0x04
+#define SMSC_FDC37M81X_SERIAL2       0x05
+#define SMSC_FDC37M81X_KBD           0x07
+
+/* Logical device Config Registers */
+#define SMSC_FDC37M81X_ACTIVE        0x30
+#define SMSC_FDC37M81X_BASEADDR0     0x60
+#define SMSC_FDC37M81X_BASEADDR1     0x61
+#define SMSC_FDC37M81X_INT           0x70
+#define SMSC_FDC37M81X_INT2          0x72
+#define SMSC_FDC37M81X_MODE          0xF0
+
+/* Chip Config Values */
+#define SMSC_FDC37M81X_CONFIG_ENTER  0x55
+#define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
+#define SMSC_FDC37M81X_CHIP_ID       0x4d
+
+static unsigned long g_smsc_fdc37m81x_base = 0;
+
+static inline unsigned char
+smsc_fdc37m81x_rd(unsigned char index)
+{
+	outb(index, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+	return inb(g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_DATA);
+}
+
+static inline void
+smsc_dc37m81x_wr(unsigned char index, unsigned char data)
+{
+	outb(index, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+	outb(data, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_DATA);
+	return;
+}
+
+void
+smsc_fdc37m81x_config_beg(void)
+{
+	if (g_smsc_fdc37m81x_base) {
+		outb(SMSC_FDC37M81X_CONFIG_ENTER,
+		     g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+	}
+	return;
+}
+
+void
+smsc_fdc37m81x_config_end(void)
+{
+	if (g_smsc_fdc37m81x_base) {
+		outb(SMSC_FDC37M81X_CONFIG_EXIT,
+		     g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+	}
+	return;
+}
+
+u8
+smsc_fdc37m81x_config_get(u8 reg)
+{
+	u8 val = 0;
+	if (g_smsc_fdc37m81x_base) {
+		val = smsc_fdc37m81x_rd(reg);
+	}
+	return (val);
+}
+
+void
+smsc_fdc37m81x_config_set(u8 reg, u8 val)
+{
+	if (g_smsc_fdc37m81x_base) {
+		smsc_dc37m81x_wr(reg, val);
+	}
+	return;
+}
+
+unsigned long __init
+smsc_fdc37m81x_init(unsigned long port)
+{
+	u8 chip_id;
+
+	if (g_smsc_fdc37m81x_base) {
+		printk("smsc_fdc37m81x_init() stepping on old base=0x%08x\n",
+		       g_smsc_fdc37m81x_base);
+	}
+
+	g_smsc_fdc37m81x_base = port;
+
+	smsc_fdc37m81x_config_beg();
+
+	chip_id = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DID);
+	if (chip_id == SMSC_FDC37M81X_CHIP_ID) {
+		smsc_fdc37m81x_config_end();
+	} else {
+		printk("smsc_fdc37m81x_init() unknow chip id 0x%02x\n",
+		       chip_id);
+		g_smsc_fdc37m81x_base = 0;
+	}
+
+	return (g_smsc_fdc37m81x_base);
+}
+
+#ifdef DEBUG
+void
+smsc_fdc37m81x_config_dump_one(char *key, u8 dev, u8 reg)
+{
+	printk("%s: dev=0x%02x reg=0x%02x val=0x%02x\n", key, dev, reg,
+	       smsc_fdc37m81x_rd(reg));
+	return;
+}
+#endif
+
+#ifdef DEBUG
+void
+smsc_fdc37m81x_config_dump(void)
+{
+	u8 orig;
+	char *fname = "smsc_fdc37m81x_config_dump()";
+
+	smsc_fdc37m81x_config_beg();
+
+	orig = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DNUM);
+
+	printk("%s: common\n", fname);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_DNUM);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_DID);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_DREV);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_PCNT);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_PMGT);
+
+	printk("%s: keyboard\n", fname);
+	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, SMSC_FDC37M81X_KBD);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_ACTIVE);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_INT);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_INT2);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_LDCR_F0);
+
+	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, orig);
+
+	smsc_fdc37m81x_config_end();
+
+	return;
+}
+#endif
Index: linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
===================================================================
--- linux-2.6.10.orig/arch/mips/tx4927/common/tx4927_setup.c
+++ linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
@@ -129,8 +129,6 @@
 	return;
 }
 
-indent: Standard input:25: Error:Unexpected end of file
-
 void
 dump_cp0(char *key)
 {

--KsGdsel6WgEHnImy--
