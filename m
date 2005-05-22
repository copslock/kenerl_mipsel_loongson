Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 May 2005 03:14:40 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:3282 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225227AbVEVCOW>;
	Sun, 22 May 2005 03:14:22 +0100
Received: MO(mo00)id j4M2EH1C016842; Sun, 22 May 2005 11:14:17 +0900 (JST)
Received: MDO(mdo01) id j4M2EHsf014623; Sun, 22 May 2005 11:14:17 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j4M2EETW009206
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sun, 22 May 2005 11:14:16 +0900 (JST)
Date:	Sun, 22 May 2005 11:14:13 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: add resource management to pmu
Message-Id: <20050522111413.2ad36681.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch had added resource management to vr41xx's pmu.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc4-orig/arch/mips/vr41xx/common/pmu.c rc4/arch/mips/vr41xx/common/pmu.c
--- rc4-orig/arch/mips/vr41xx/common/pmu.c	Sat May  7 14:20:31 2005
+++ rc4/arch/mips/vr41xx/common/pmu.c	Sun May 15 18:14:50 2005
@@ -1,7 +1,7 @@
 /*
  *  pmu.c, Power Management Unit routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,7 +17,9 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/types.h>
@@ -27,20 +29,31 @@
 #include <asm/reboot.h>
 #include <asm/system.h>
 
-#define PMUCNT2REG	KSEG1ADDR(0x0f0000c6)
+#define PMU_TYPE1_BASE	0x0b0000a0UL
+#define PMU_TYPE1_SIZE	0x0eUL
+
+#define PMU_TYPE2_BASE	0x0f0000c0UL
+#define PMU_TYPE2_SIZE	0x10UL
+
+#define PMUCNT2REG	0x06
  #define SOFTRST	0x0010
 
+static void __iomem *pmu_base;
+
+#define pmu_read(offset)		readw(pmu_base + (offset))
+#define pmu_write(offset, value)	writew((value), pmu_base + (offset))
+
 static inline void software_reset(void)
 {
-	uint16_t val;
+	uint16_t pmucnt2;
 
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		val = readw(PMUCNT2REG);
-		val |= SOFTRST;
-		writew(val, PMUCNT2REG);
+		pmucnt2 = pmu_read(PMUCNT2REG);
+		pmucnt2 |= SOFTRST;
+		pmu_write(PMUCNT2REG, pmucnt2);
 		break;
 	default:
 		break;
@@ -71,6 +84,34 @@
 
 static int __init vr41xx_pmu_init(void)
 {
+	unsigned long start, size;
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		start = PMU_TYPE1_BASE;
+		size = PMU_TYPE1_SIZE;
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		start = PMU_TYPE2_BASE;
+		size = PMU_TYPE2_SIZE;
+		break;
+	default:
+		printk("Unexpected CPU of NEC VR4100 series\n");
+		return -ENODEV;
+	}
+
+	if (request_mem_region(start, size, "PMU") == NULL)
+		return -EBUSY;
+
+	pmu_base = ioremap(start, size);
+	if (pmu_base == NULL) {
+		release_mem_region(start, size);
+		return -EBUSY;
+	}
+
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
 	_machine_power_off = vr41xx_power_off;
@@ -78,4 +119,4 @@
 	return 0;
 }
 
-early_initcall(vr41xx_pmu_init);
+core_initcall(vr41xx_pmu_init);
