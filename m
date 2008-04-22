Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 00:53:17 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:35605 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28581543AbYDVXxP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2008 00:53:15 +0100
Received: by mo.po.2iij.net (mo31) id m3MNrA9G081994; Wed, 23 Apr 2008 08:53:10 +0900 (JST)
Received: from rally.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox304) id m3MNr76b023230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Apr 2008 08:53:08 +0900
Date:	Wed, 23 Apr 2008 08:51:40 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] [MIPS] add DECstation I/O ASIC clocksource
Message-Id: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

add DECstation I/O ASIC clocksource

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff mips-queue-orig/arch/mips/Kconfig mips-queue/arch/mips/Kconfig
--- mips-queue-orig/arch/mips/Kconfig	2008-04-22 23:13:37.099040014 +0900
+++ mips-queue/arch/mips/Kconfig	2008-04-22 23:13:21.770166469 +0900
@@ -82,6 +82,7 @@ config MACH_DECSTATION
 	bool "DECstations"
 	select BOOT_ELF32
 	select CEVT_R4K
+	select CSRC_IOASIC
 	select CSRC_R4K
 	select CPU_DADDI_WORKAROUNDS if 64BIT
 	select CPU_R4000_WORKAROUNDS if 64BIT
@@ -783,6 +784,9 @@ config CEVT_TXX9
 config CSRC_BCM1480
 	bool
 
+config CSRC_IOASIC
+	bool
+
 config CSRC_R4K
 	bool
 
diff -pruN -X /home/yuasa/Memo/dontdiff mips-queue-orig/arch/mips/dec/time.c mips-queue/arch/mips/dec/time.c
--- mips-queue-orig/arch/mips/dec/time.c	2008-04-22 23:13:37.231047535 +0900
+++ mips-queue/arch/mips/dec/time.c	2008-04-22 23:13:21.770166469 +0900
@@ -165,7 +165,7 @@ void __init plat_time_init(void)
 
 	if (!cpu_has_counter && IOASIC)
 		/* For pre-R4k systems we use the I/O ASIC's counter.  */
-		clocksource_mips.read = dec_ioasic_hpt_read;
+		dec_ioasic_clocksource_init();
 
 	/* Set up the rate of periodic DS1287 interrupts.  */
 	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - __ffs(HZ)), RTC_REG_A);
diff -pruN -X /home/yuasa/Memo/dontdiff mips-queue-orig/arch/mips/kernel/Makefile mips-queue/arch/mips/kernel/Makefile
--- mips-queue-orig/arch/mips/kernel/Makefile	2008-04-22 23:13:37.239047990 +0900
+++ mips-queue/arch/mips/kernel/Makefile	2008-04-22 23:13:21.774166698 +0900
@@ -14,6 +14,7 @@ obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641
 obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
 obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
 obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
+obj-$(CONFIG_CSRC_IOASIC)	+= csrc-ioasic.o
 obj-$(CONFIG_CSRC_R4K)		+= csrc-r4k.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
diff -pruN -X /home/yuasa/Memo/dontdiff mips-queue-orig/arch/mips/kernel/csrc-ioasic.c mips-queue/arch/mips/kernel/csrc-ioasic.c
--- mips-queue-orig/arch/mips/kernel/csrc-ioasic.c	1970-01-01 09:00:00.000000000 +0900
+++ mips-queue/arch/mips/kernel/csrc-ioasic.c	2008-04-22 23:13:21.774166698 +0900
@@ -0,0 +1,45 @@
+/*
+ *  DEC I/O ASIC's counter clocksource
+ *
+ *  Copyright (C) 2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#include <linux/clocksource.h>
+#include <linux/init.h>
+
+#include <asm/time.h>
+#include <asm/dec/ioasic.h>
+#include <asm/dec/ioasic_addrs.h>
+
+static cycle_t dec_ioasic_hpt_read(void)
+{
+	return ioasic_read(IO_REG_FCTR);
+}
+
+static struct clocksource clocksource_dec = {
+	.name		= "dec-ioasic",
+	.read		= dec_ioasic_hpt_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init dec_ioasic_clocksource_init(void)
+{
+	clocksource_dec.rating = 200;
+	clocksource_set_clock(&clocksource_dec, 25000000);
+
+	clocksource_register(&clocksource_dec);
+}
diff -pruN -X /home/yuasa/Memo/dontdiff mips-queue-orig/include/asm-mips/dec/ioasic.h mips-queue/include/asm-mips/dec/ioasic.h
--- mips-queue-orig/include/asm-mips/dec/ioasic.h	2008-04-22 23:13:58.672269400 +0900
+++ mips-queue/include/asm-mips/dec/ioasic.h	2008-04-22 23:13:21.774166698 +0900
@@ -33,4 +33,6 @@ static inline u32 ioasic_read(unsigned i
 
 extern void init_ioasic_irqs(int base);
 
+extern void dec_ioasic_clocksource_init(void);
+
 #endif /* __ASM_DEC_IOASIC_H */
