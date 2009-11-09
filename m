Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:08:43 +0100 (CET)
Received: from gv-out-0910.google.com ([216.239.58.186]:61341 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493243AbZKIQHC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 17:07:02 +0100
Received: by gv-out-0910.google.com with SMTP id e6so241978gvc.2
        for <multiple recipients>; Mon, 09 Nov 2009 08:06:59 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=IEMdhj2ccJSGYm30WjF96Ov7uPmteGixK7ldnh1szBU=;
        b=aZEAtn7omElu1UDGArLRvJp/v4ECWaF5D+y4lekNa+slM0iYYPwOsnd1MkZMMMFOmP
         3wkiFtELtayFDn6k5Fm2mLpRhKc4eLlDFwirZ2fyC94f9TILbJ+Im926h19rY98SyCth
         g3Vrg/ydH9HPvrwPRbyr1lT+GyendzlBtf0M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kQMPiKR0sAwhHZD+RmjXPVoEVP4RQudCyyMBgpqq0jdaB2PU7EqxQXhA39MybWJQLu
         wgpfY59WOb0HinEyK7pyXS6OyHuLglaZ060eEuY1D7W0gRmERz1JtHYDKL5Dd7Drl4Uc
         Hh74qQ8WcRTXoWvBE+iO1k4H1A0BpXKBuxpzs=
Received: by 10.216.90.133 with SMTP id e5mr747704wef.23.1257782818750;
        Mon, 09 Nov 2009 08:06:58 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id p37sm9150866gvf.24.2009.11.09.08.06.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 08:06:57 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org
Subject: [PATCH v2 6/7] [loongson] lemote-2f: add reset support
Date:	Tue, 10 Nov 2009 00:06:15 +0800
Message-Id: <12ea5b9f763ec127de9e5c1f66b7c828cf18f497.1257781987.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1d0296297adcbb33efe9e46488866e9f897faec3.1257781987.git.wuzhangjin@gmail.com>
References: <3154ef478a3a08f808e3a4b9c9cab9f4e263a8a2.1257781987.git.wuzhangjin@gmail.com>
 <4c3b69663760b00d39e09c3682a55ee7cf4b84c7.1257781987.git.wuzhangjin@gmail.com>
 <969a9b991c745c3ff7ee1c47ac240499af629f27.1257781987.git.wuzhangjin@gmail.com>
 <791c33dbd40b62f7341a545390db70731b85ce22.1257781987.git.wuzhangjin@gmail.com>
 <1d0296297adcbb33efe9e46488866e9f897faec3.1257781987.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257781987.git.wuzhangjin@gmail.com>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24796
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
 arch/mips/loongson/lemote-2f/reset.c           |  172 ++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 1 deletions(-)
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
index 0000000..0458a1c
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -0,0 +1,172 @@
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
+void mach_prepare_reboot(void)
+{
+	switch (mips_machtype) {
+	case MACH_LEMOTE_FL2F:
+		fl2f_reboot();
+		break;
+	case MACH_LEMOTE_ML2F7:
+		ml2f_reboot();
+		break;
+	case MACH_LEMOTE_YL2F89:
+		yl2f89_reboot();
+		break;
+	default:
+		break;
+	}
+}
+
+void mach_prepare_shutdown(void)
+{
+	switch (mips_machtype) {
+	case MACH_LEMOTE_FL2F:
+		fl2f_shutdown();
+		break;
+	case MACH_LEMOTE_ML2F7:
+		ml2f_shutdown();
+		break;
+	case MACH_LEMOTE_YL2F89:
+		yl2f89_shutdown();
+		break;
+	default:
+		break;
+	}
+}
-- 
1.6.2.1
