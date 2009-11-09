Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:08:18 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61196 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493251AbZKIQGx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 17:06:53 +0100
Received: by mail-ew0-f216.google.com with SMTP id 12so3402282ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 08:06:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=SmthfTTmCccT5cEK7SBFhzTZ4oNKbiW0KELe58SDjgc=;
        b=Sn3dbr5rqRdUw+eE4z4Q/FS17fMfQ4gYfoFU+htvnXGQ0UJ22gpinFvuGRWU2GKTDK
         oqR+kBQ8HeASwUDokHZxaxTO4bo0QhVo5XZ9jU15avyojJTXZr5GqdHMNX31qx3bTFa0
         WrcHH9Fu8Pz71gAXLCWscajCEw2VR0n0iYPmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g0yGJlzeIwIopBEKAbHS2ZPm22LqleiWedOFaHqFZ3rTGLGSM+ADLsDoezeHSLNgE1
         DT1nEuKScmbCQ8zYTRDJk6hEMUHifpR984+itlif9y64A0uvGXHviY7Azm03Ah+yzqN6
         eVHqS6gvrkh4SYEW3adExNJa0Cx3//MgxcNIw=
Received: by 10.216.85.197 with SMTP id u47mr756722wee.133.1257782813158;
        Mon, 09 Nov 2009 08:06:53 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id p37sm9150866gvf.24.2009.11.09.08.06.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 08:06:52 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org
Subject: [PATCH v2 5/7] [loongson] lemote-2f: add irq support
Date:	Tue, 10 Nov 2009 00:06:14 +0800
Message-Id: <1d0296297adcbb33efe9e46488866e9f897faec3.1257781987.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <791c33dbd40b62f7341a545390db70731b85ce22.1257781987.git.wuzhangjin@gmail.com>
References: <3154ef478a3a08f808e3a4b9c9cab9f4e263a8a2.1257781987.git.wuzhangjin@gmail.com>
 <4c3b69663760b00d39e09c3682a55ee7cf4b84c7.1257781987.git.wuzhangjin@gmail.com>
 <969a9b991c745c3ff7ee1c47ac240499af629f27.1257781987.git.wuzhangjin@gmail.com>
 <791c33dbd40b62f7341a545390db70731b85ce22.1257781987.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257781987.git.wuzhangjin@gmail.com>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The common i8259_irq() will make kernel hang on booting, herein, we
write our own instead.

The IP6 is shared by the bonito interrupt and the perfcounter interrupt.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Makefile           |    6 ++
 arch/mips/loongson/lemote-2f/Makefile |    5 +
 arch/mips/loongson/lemote-2f/irq.c    |  130 +++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/Makefile
 create mode 100644 arch/mips/loongson/lemote-2f/irq.c

diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
index 39048c4..2b76cb0 100644
--- a/arch/mips/loongson/Makefile
+++ b/arch/mips/loongson/Makefile
@@ -9,3 +9,9 @@ obj-$(CONFIG_MACH_LOONGSON) += common/
 #
 
 obj-$(CONFIG_LEMOTE_FULOONG2E)  += fuloong-2e/
+
+#
+# Lemote loongson2f family machines
+#
+
+obj-$(CONFIG_LEMOTE_MACH2F)  += lemote-2f/
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
new file mode 100644
index 0000000..2e18897
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for lemote loongson2f family machines
+#
+
+obj-y += irq.o
diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
new file mode 100644
index 0000000..98f6984
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -0,0 +1,130 @@
+/*
+ * Copyright (C) 2007 Lemote Inc.
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/interrupt.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+#define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
+#define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* cpu perf counter */
+#define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
+#define LOONGSON_UART_IRQ	(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port */
+#define LOONGSON_SOUTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)	/* i8259 */
+
+#define LOONGSON_INT_BIT_INT0		(1 << 11)
+#define LOONGSON_INT_BIT_INT1		(1 << 12)
+
+/* The common i8259_irq() make the kernel hang on booting, Seems we can not get
+ * the irq via the IRR directly, herein, we access the ISR instead. */
+static inline int mach_i8259_irq(void)
+{
+	int irq, isr;
+
+	irq = -1;
+
+	if ((LOONGSON_INTISR & LOONGSON_INTEN) & LOONGSON_INT_BIT_INT0) {
+		spin_lock(&i8259A_lock);
+		isr = inb(PIC_MASTER_CMD) &
+			~inb(PIC_MASTER_IMR) & ~(1 << PIC_CASCADE_IR);
+		if (!isr)
+			isr = (inb(PIC_SLAVE_CMD) & ~inb(PIC_SLAVE_IMR)) << 8;
+		irq = ffs(isr) - 1;
+		if (unlikely(irq == 7)) {
+			/*
+			 * This may be a spurious interrupt.
+			 *
+			 * Read the interrupt status register (ISR). If the most
+			 * significant bit is not set then there is no valid
+			 * interrupt.
+			 */
+			outb(0x0B, PIC_MASTER_ISR);	/* ISR register */
+			if (~inb(PIC_MASTER_ISR) & 0x80)
+				irq = -1;
+		}
+		spin_unlock(&i8259A_lock);
+	}
+
+	return irq;
+}
+
+static void i8259_irqdispatch(void)
+{
+	int irq;
+
+	irq = mach_i8259_irq();
+	if (irq >= 0)
+		do_IRQ(irq);
+	else
+		spurious_interrupt();
+}
+
+void mach_irq_dispatch(unsigned int pending)
+{
+	if (pending & CAUSEF_IP7)
+		do_IRQ(LOONGSON_TIMER_IRQ);
+	else if (pending & CAUSEF_IP6) {	/* North Bridge, Perf counter */
+#ifdef CONFIG_OPROFILE
+		do_IRQ(LOONGSON2_PERFCNT_IRQ);
+#endif
+		bonito_irqdispatch();
+	} else if (pending & CAUSEF_IP3)	/* CPU UART */
+		do_IRQ(LOONGSON_UART_IRQ);
+	else if (pending & CAUSEF_IP2)	/* South Bridge */
+		i8259_irqdispatch();
+	else
+		spurious_interrupt();
+}
+
+void __init set_irq_trigger_mode(void)
+{
+	/* setup cs5536 as high level trigger */
+	LOONGSON_INTPOL = LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1;
+	LOONGSON_INTEDGE &= ~(LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1);
+}
+
+static irqreturn_t ip6_action(int cpl, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+struct irqaction ip6_irqaction = {
+	.handler = ip6_action,
+	.name = "cascade",
+	.flags = IRQF_SHARED,
+};
+
+struct irqaction cascade_irqaction = {
+	.handler = no_action,
+	.name = "cascade",
+};
+
+void __init mach_init_irq(void)
+{
+	/* init all controller
+	 *   0-15         ------> i8259 interrupt
+	 *   16-23        ------> mips cpu interrupt
+	 *   32-63        ------> bonito irq
+	 */
+
+	/* Sets the first-level interrupt dispatcher. */
+	mips_cpu_irq_init();
+	init_i8259_irqs();
+	bonito_irq_init();
+
+	/* setup north bridge irq (bonito) */
+	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &ip6_irqaction);
+	/* setup source bridge irq (i8259) */
+	setup_irq(LOONGSON_SOUTH_BRIDGE_IRQ, &cascade_irqaction);
+}
-- 
1.6.2.1
