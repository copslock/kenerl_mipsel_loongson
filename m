Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 14:14:35 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:39281 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492770AbZKFNM3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 14:12:29 +0100
Received: by mail-px0-f188.google.com with SMTP id 26so367498pxi.21
        for <multiple recipients>; Fri, 06 Nov 2009 05:12:28 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=JCYDZGjkpspjE36H5CPPrT09PFzL1y1hw/crXGzEy/M=;
        b=LJxvtaru8A/AdbVqoqb+9+njG3jcuJJ6jdDcWZfLwB9B8ZsjHdedhFR4Itmt1qCpvg
         P32AEnDf09WfcT2ciJxuGRbyWnCXp4cWRlTX8M29MzhLUINTXO7+of8mwLjh8K8+CMEf
         i1pdG8bDzobpGjbPepTc+ACmgpq+pbfprrwIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hk3lO21uvR4sTI6+pNliS4OkYS78HbFhVf5opsmTMcf/L/2eWKc14ew0In0vbhvM7D
         Uk4STWcqa255ddLNo6vMyYxEneICTZQrZ2Pr/quMJIEGUa0FCaigZiSQu7NooV/WUtIo
         qzxjsXmuchxdRiBrlc2L6geu//zOLG1bQIFaI=
Received: by 10.114.187.3 with SMTP id k3mr6715999waf.82.1257513148686;
        Fri, 06 Nov 2009 05:12:28 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm26431pxi.7.2009.11.06.05.12.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 05:12:28 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, zhangfx@lemote.com,
	yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH -queue v1 6/7] [loongson] lemote-2f: add reset and shutdown support
Date:	Fri,  6 Nov 2009 21:11:31 +0800
Message-Id: <eda10072015359ae0f3f36ea81ec1281602091a8.1257510612.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <96301eaeffac1ae45d7529760eb961a04356dfca.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
 <17e5d58a0cd7273b81c7151b7f7f2096c9694b59.1257510612.git.wuzhangjin@gmail.com>
 <588574ed5910292f2728072ca147add2ae342778.1257510612.git.wuzhangjin@gmail.com>
 <7affa8fce1f55b817aff1c64f823824f6809dd85.1257510612.git.wuzhangjin@gmail.com>
 <84e7310659ae445b3b3dc68aadc8f27648c709f6.1257510612.git.wuzhangjin@gmail.com>
 <96301eaeffac1ae45d7529760eb961a04356dfca.1257510612.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

fuloong2f, yeeloong2f and menglong2f have different reset/shutdown
logic, this patch add respective support for them.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    7 +
 arch/mips/loongson/lemote-2f/Makefile          |    2 +-
 arch/mips/loongson/lemote-2f/reset.c           |  163 ++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/reset.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index e7e7a08..5b83bea 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -42,6 +42,13 @@ extern void __init set_irq_trigger_mode(void);
 extern void __init mach_init_irq(void);
 extern void mach_irq_dispatch(unsigned int pending);
 
+/* We need this in some places... */
+#define delay()	({		\
+	int x;				\
+	for (x = 0; x < 100000; x++)	\
+		__asm__ __volatile__(""); \
+})
+
 #define LOONGSON_REG(x) \
 	(*(volatile u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
 
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 2e18897..da543b1 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -2,4 +2,4 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += irq.o
+obj-y += irq.o reset.o
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
new file mode 100644
index 0000000..0459493
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -0,0 +1,163 @@
+/* Board-specific reboot/shutdown routines
+ *
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+
+#include <cs5536/cs5536.h>
+
+static void reset_cpu(void)
+{
+	/*
+	 * reset cpu to full speed, this is needed when enabling cpu frequency
+	 * scalling
+	 */
+	LOONGSON_CHIPCFG0 |= 0x7;
+}
+
+/* reset support for fuloong2f */
+
+static void fl2f_reboot(void)
+{
+	reset_cpu();
+
+	/* send a reset signal to south bridge.
+	 *
+	 * NOTE: if enable "Power Management" in kernel, rtl8169 will not reset
+	 * normally with this reset operation and it will not work in PMON, but
+	 * you can type halt command and then reboot, seems the hardware reset
+	 * logic not work normally.
+	 */
+	{
+		u32 hi, lo;
+		_rdmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), &hi, &lo);
+		lo |= 0x00000001;
+		_wrmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), hi, lo);
+	}
+}
+
+static void fl2f_shutdown(void)
+{
+	u32 hi, lo, val;
+	int gpio_base;
+
+	/* get gpio base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	gpio_base = lo & 0xff00;
+
+	/* make cs5536 gpio13 output enable */
+	val = inl(gpio_base + GPIOL_OUT_EN);
+	val &= ~(1 << (16 + 13));
+	val |= (1 << 13);
+	outl(val, gpio_base + GPIOL_OUT_EN);
+	mmiowb();
+	/* make cs5536 gpio13 output low level voltage. */
+	val = inl(gpio_base + GPIOL_OUT_VAL) & ~(1 << (13));
+	val |= (1 << (16 + 13));
+	outl(val, gpio_base + GPIOL_OUT_VAL);
+	mmiowb();
+}
+
+/* reset support for yeeloong2f and mengloong2f notebook */
+
+/*
+ * The following registers are determined by the EC index configuration.
+ * 1. fill the PORT_HIGH as EC register high part.
+ * 2. fill the PORT_LOW as EC register low part.
+ * 3. fill the PORT_DATA as EC register write data or get the data from it.
+ */
+
+#define	EC_IO_PORT_HIGH	0x0381
+#define	EC_IO_PORT_LOW	0x0382
+#define	EC_IO_PORT_DATA	0x0383
+#define	REG_RESET_HIGH	0xF4	/* reset the machine auto-clear : rd/wr */
+#define REG_RESET_LOW	0xEC
+#define	BIT_RESET_ON	(1 << 0)
+
+void ml2f_reboot(void)
+{
+	reset_cpu();
+
+	/* sending an reset signal to EC(embedded controller) */
+	outb(REG_RESET_HIGH, EC_IO_PORT_HIGH);
+	outb(REG_RESET_LOW, EC_IO_PORT_LOW);
+	mmiowb();
+	outb(BIT_RESET_ON, EC_IO_PORT_DATA);
+	mmiowb();
+}
+
+#define yl2f89_reboot ml2f_reboot
+
+/* menglong(7inches) laptop has different shutdown logic from 8.9inches */
+#define EC_SHUTDOWN_IO_PORT_HIGH 0xff2d
+#define EC_SHUTDOWN_IO_PORT_LOW	 0xff2e
+#define EC_SHUTDOWN_IO_PORT_DATA 0xff2f
+#define REG_SHUTDOWN_HIGH        0xFC
+#define REG_SHUTDOWN_LOW         0x29
+#define BIT_SHUTDOWN_ON          (1 << 1)
+
+static void ml2f_shutdown(void)
+{
+	u8 val;
+	u64 i;
+
+	outb(REG_SHUTDOWN_HIGH, EC_SHUTDOWN_IO_PORT_HIGH);
+	outb(REG_SHUTDOWN_LOW, EC_SHUTDOWN_IO_PORT_LOW);
+	mmiowb();
+	val = inb(EC_SHUTDOWN_IO_PORT_DATA);
+	outb(val & (~BIT_SHUTDOWN_ON), EC_SHUTDOWN_IO_PORT_DATA);
+	mmiowb();
+	/* need enough wait here... how many microseconds needs? */
+	for (i = 0; i < 0x10000; i++)
+		delay();
+	outb(val | BIT_SHUTDOWN_ON, EC_SHUTDOWN_IO_PORT_DATA);
+	mmiowb();
+}
+
+static void yl2f89_shutdown(void)
+{
+	/* cpu-gpio0 output low */
+	LOONGSON_GPIODATA &= ~0x00000001;
+	/* cpu-gpio0 as output */
+	LOONGSON_GPIOIE &= ~0x00000001;
+}
+
+
+/* we only cope with the lemote 2f series */
+typedef void (*mach_reset_func)(void);
+static mach_reset_func mach_reset[][2] = {
+	[MACH_LOONGSON_UNKNOWN]	{NULL, NULL},
+	[MACH_LEMOTE_FL2E]	{NULL, NULL},
+	[MACH_LEMOTE_FL2F]	{fl2f_reboot, fl2f_shutdown},
+	[MACH_LEMOTE_ML2F7]	{ml2f_reboot, ml2f_shutdown},
+	[MACH_LEMOTE_YL2F89]	{yl2f89_reboot, yl2f89_shutdown},
+	[MACH_DEXXON_GDIUM2F10]	{NULL, NULL},
+	[MACH_LOONGSON_END] {NULL, NULL},
+};
+
+void mach_prepare_reboot(void)
+{
+	if (mach_reset[mips_machtype][0])
+		mach_reset[mips_machtype][0]();
+}
+
+void mach_prepare_shutdown(void)
+{
+	if (mach_reset[mips_machtype][1])
+		mach_reset[mips_machtype][1]();
+}
-- 
1.6.2.1
