Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:55:30 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:62054 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491853Ab0EDJzE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:04 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119599qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.66.211 with SMTP id o19mr4144594qai.112.1272966903253; 
        Tue, 04 May 2010 02:55:03 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:03 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:03 +0800
Message-ID: <r2y180e2c241005040255l8b43dc20t6402eadc4b567987@mail.gmail.com>
Subject: [PATCH 2/12] add basic gdium support
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Gdium is same to most of the loongson2f based machines except that it
does NOT use the cs5536 south bridge.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 arch/mips/Makefile                            |    1 +
 arch/mips/include/asm/mach-loongson/machine.h |    7 +++
 arch/mips/loongson/Kconfig                    |   25 +++++++++
 arch/mips/loongson/Makefile                   |    6 ++
 arch/mips/loongson/gdium/Makefile             |    3 +
 arch/mips/loongson/gdium/irq.c                |   66 +++++++++++++++++++++++++
 arch/mips/loongson/gdium/reset.c              |   25 +++++++++
 7 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/gdium/Makefile
 create mode 100644 arch/mips/loongson/gdium/irq.c
 create mode 100644 arch/mips/loongson/gdium/reset.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0b9c01a..c1470af 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -359,6 +359,7 @@ cflags-$(CONFIG_MACH_LOONGSON) +=
-I$(srctree)/arch/mips/include/asm/mach-loongs
                     -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
+load-$(CONFIG_DEXXON_GDIUM) += 0xffffffff80200000

 #
 # MIPS Malta board
diff --git a/arch/mips/include/asm/mach-loongson/machine.h
b/arch/mips/include/asm/mach-loongson/machine.h
index 4321338..fb9554c 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -24,4 +24,11 @@

 #endif

+/* use gdium as the default machine of LEMOTE_MACH2F */
+#ifdef CONFIG_DEXXON_GDIUM
+
+#define LOONGSON_MACHTYPE MACH_DEXXON_GDIUM2F10
+
+#endif
+
 #endif /* __ASM_MACH_LOONGSON_MACHINE_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 3df1967..90a02b4 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -57,6 +57,31 @@ config LEMOTE_MACH2F

 	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
 	  LingLoong allinone PC and so forth.
+
+config DEXXON_GDIUM
+        bool "Dexxon Gdium Netbook"
+        select ARCH_SPARSEMEM_ENABLE
+        select BOARD_SCACHE
+        select BOOT_ELF32
+        select CEVT_R4K
+        select CPU_HAS_WB
+        select CSRC_R4K
+        select DMA_NONCOHERENT
+        select GENERIC_HARDIRQS_NO__DO_IRQ
+        select GENERIC_ISA_DMA_SUPPORT_BROKEN
+        select HW_HAS_PCI
+        select I8259
+        select IRQ_CPU
+        select ISA
+        select SYS_HAS_CPU_LOONGSON2F
+        select SYS_HAS_EARLY_PRINTK
+        select SYS_SUPPORTS_32BIT_KERNEL
+        select SYS_SUPPORTS_64BIT_KERNEL
+        select SYS_SUPPORTS_HIGHMEM
+        select SYS_SUPPORTS_LITTLE_ENDIAN
+        select ARCH_REQUIRE_GPIOLIB
+        help
+          Dexxon gdium netbook based on Loongson 2F and SM502.
 endchoice

 config CS5536
diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
index 2b76cb0..6002109 100644
--- a/arch/mips/loongson/Makefile
+++ b/arch/mips/loongson/Makefile
@@ -15,3 +15,9 @@ obj-$(CONFIG_LEMOTE_FULOONG2E)  += fuloong-2e/
 #

 obj-$(CONFIG_LEMOTE_MACH2F)  += lemote-2f/
+
+#
+# gdium
+#
+
+obj-$(CONFIG_DEXXON_GDIUM)  += gdium/
diff --git a/arch/mips/loongson/gdium/Makefile
b/arch/mips/loongson/gdium/Makefile
new file mode 100644
index 0000000..31a8e57
--- /dev/null
+++ b/arch/mips/loongson/gdium/Makefile
@@ -0,0 +1,3 @@
+# Makefile for gdium
+
+obj-y += irq.o reset.o
diff --git a/arch/mips/loongson/gdium/irq.c b/arch/mips/loongson/gdium/irq.c
new file mode 100644
index 0000000..b0679eb
--- /dev/null
+++ b/arch/mips/loongson/gdium/irq.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2007 Lemote Inc.
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * Copyright (c) 2010 yajin <yajin@vm-kernel.org>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+#define LOONGSON_TIMER_IRQ      (MIPS_CPU_IRQ_BASE + 7) /* cpu timer */
+#define LOONGSON_PERFCNT_IRQ    (MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
+#define LOONGSON_NORTH_BRIDGE_IRQ       (MIPS_CPU_IRQ_BASE + 6) /* bonito */
+#define LOONGSON_UART_IRQ       (MIPS_CPU_IRQ_BASE + 3) /* cpu serial port */
+
+void mach_irq_dispatch(unsigned int pending)
+{
+	if (pending & CAUSEF_IP7)
+		do_IRQ(LOONGSON_TIMER_IRQ);
+	else if (pending & CAUSEF_IP6) {        /* North Bridge, Perf counter */
+#ifdef CONFIG_OPROFILE
+		do_IRQ(LOONGSON2_PERFCNT_IRQ);
+#endif
+		bonito_irqdispatch();
+	} else if (pending & CAUSEF_IP3)        /* CPU UART */
+		do_IRQ(LOONGSON_UART_IRQ);
+	else
+		spurious_interrupt();
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
+void __init mach_init_irq(void)
+{
+	/* init all controller
+	*   16-23        ------> mips cpu interrupt
+	*   32-63        ------> bonito irq
+	*/
+
+	/* Sets the first-level interrupt dispatcher. */
+	mips_cpu_irq_init();
+	bonito_irq_init();
+
+	/* setup north bridge irq (bonito) */
+	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &ip6_irqaction);
+}
diff --git a/arch/mips/loongson/gdium/reset.c b/arch/mips/loongson/gdium/reset.c
new file mode 100644
index 0000000..da7752d
--- /dev/null
+++ b/arch/mips/loongson/gdium/reset.c
@@ -0,0 +1,25 @@
+/* Board-specific reboot/shutdown routines
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * Copyright (C) 2010 yajin <yajin@vm-kernel.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <loongson.h>
+
+void mach_prepare_shutdown(void)
+{
+	LOONGSON_GPIOIE &= ~(1<<1);
+	LOONGSON_GPIODATA |= (1<<1);
+}
+
+void mach_prepare_reboot(void)
+{
+	LOONGSON_GPIOIE &= ~(1<<2);
+	LOONGSON_GPIODATA &= ~(1<<2);
+}
-- 
1.5.6.5
