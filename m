Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 16:09:26 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:61231 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026189AbXHFPJX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 16:09:23 +0100
Received: by mo.po.2iij.net (mo30) id l76F9Kg9091654; Tue, 7 Aug 2007 00:09:20 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox302) id l76F9H3K008801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Aug 2007 00:09:18 +0900
Date:	Tue, 7 Aug 2007 00:09:17 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] vr41xx: add cpu_wait
Message-Id: <20070807000917.6bbd2c19.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add cpu_wait for NEC VR41xx

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/pmu.c mips/arch/mips/vr41xx/common/pmu.c
--- mips-orig/arch/mips/vr41xx/common/pmu.c	2007-08-06 10:26:26.176510250 +0900
+++ mips/arch/mips/vr41xx/common/pmu.c	2007-08-06 11:02:24.472787000 +0900
@@ -1,7 +1,7 @@
 /*
  *  pmu.c, Power Management Unit routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2003-2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -22,11 +22,12 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/pm.h>
-#include <linux/smp.h>
+#include <linux/sched.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
+#include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/system.h>
 
@@ -44,6 +45,18 @@ static void __iomem *pmu_base;
 #define pmu_read(offset)		readw(pmu_base + (offset))
 #define pmu_write(offset, value)	writew((value), pmu_base + (offset))
 
+static void vr41xx_cpu_wait(void)
+{
+	local_irq_disable();
+	if (!need_resched())
+		/*
+		 * "standby" sets IE bit of the CP0_STATUS to 1.
+		 */
+		__asm__("standby;\n");
+	else
+		local_irq_enable();
+}
+
 static inline void software_reset(void)
 {
 	uint16_t pmucnt2;
@@ -113,6 +126,7 @@ static int __init vr41xx_pmu_init(void)
 		return -EBUSY;
 	}
 
+	cpu_wait = vr41xx_cpu_wait;
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
 	pm_power_off = vr41xx_power_off;
