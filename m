Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 11:48:41 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:46286 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861363AbaCUKquGjiY5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2014 11:46:50 +0100
Received: by mail-pa0-f51.google.com with SMTP id kq14so2227902pab.24
        for <multiple recipients>; Fri, 21 Mar 2014 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XERuHiKhSI2BigZSX4gAopFHu3VjmGxaYmKPl/4NM4M=;
        b=KkELi7v+XpLTREDf/mVil5DueSuGxPVMwYAHHAdTkJ22q0P5mygD0DllNc3NayIXPE
         WWqaxpwKdJHJ7+IfwGczI4cLDn8i3wiLLUespuymJkneEDi4Vjl9TJkLkC/D274xljlc
         bn6ghsaFgNkDzm57dyrWG6YKGuz9W+IJNcI+5lBsAOthb4fh8lN1vSw9eDVaFlLM4QzP
         zqgSBCekA+1jwHhK0Z+im0K+4GPDsXIM+xW/D5F3/GEy7ItpPJsLiHkiatywvyg2EEGg
         DrNTWXmS8hHuni78Ldiht5lJQ5xV3Efd4lfacluZRcKtWZx/ORdKlt0A2zw3fm9j+g4g
         Qd6g==
X-Received: by 10.66.136.131 with SMTP id qa3mr52367919pab.77.1395398800359;
        Fri, 21 Mar 2014 03:46:40 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ac5sm9144592pbc.37.2014.03.21.03.46.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 03:46:39 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V20 10/12] MIPS: Loongson 3: Add Loongson-3 SMP support
Date:   Fri, 21 Mar 2014 18:44:08 +0800
Message-Id: <1395398650-19292-11-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
References: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

IPI registers of Loongson-3 include IPI_SET, IPI_CLEAR, IPI_STATUS,
IPI_EN and IPI_MAILBOX_BUF. Each bit of IPI_STATUS indicate a type of
IPI and IPI_EN indicate whether the IPI is enabled. The sender write 1
to IPI_SET bits generate IPIs in IPI_STATUS, and receiver write 1 to
bits of IPI_CLEAR to clear IPIs. IPI_MAILBOX_BUF are used to deliver
more information about IPIs.

Why we change code in arch/mips/loongson/common/setup.c?

If without this change, when SMP configured, system cannot boot since
it hang at printk() in cgroup_init_early(). The root cause is:

console_trylock()
  \-->down_trylock(&console_sem)
    \-->raw_spin_unlock_irqrestore(&sem->lock, flags)
      \-->_raw_spin_unlock_irqrestore()(SMP/UP have different versions)
        \-->__raw_spin_unlock_irqrestore()  (following is the SMP case)
          \-->do_raw_spin_unlock()
            \-->arch_spin_unlock()
              \-->nudge_writes()
                \-->mb()
                  \-->wbflush()
                    \-->__wbflush()

In previous code __wbflush() is initialized in plat_mem_setup(), but
cgroup_init_early() is called before plat_mem_setup(). Therefore, In
this patch we make changes to avoid boot failure.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Tested-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/include/asm/mach-loongson/irq.h      |    2 +
 arch/mips/include/asm/mach-loongson/loongson.h |    1 +
 arch/mips/loongson/common/init.c               |    1 +
 arch/mips/loongson/common/setup.c              |    8 +-
 arch/mips/loongson/loongson-3/Makefile         |    2 +
 arch/mips/loongson/loongson-3/irq.c            |   20 ++
 arch/mips/loongson/loongson-3/smp.c            |  267 ++++++++++++++++++++++++
 arch/mips/loongson/loongson-3/smp.h            |   29 +++
 8 files changed, 325 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/loongson/loongson-3/smp.c
 create mode 100644 arch/mips/loongson/loongson-3/smp.h

diff --git a/arch/mips/include/asm/mach-loongson/irq.h b/arch/mips/include/asm/mach-loongson/irq.h
index 29c2dff..0c77b22 100644
--- a/arch/mips/include/asm/mach-loongson/irq.h
+++ b/arch/mips/include/asm/mach-loongson/irq.h
@@ -37,5 +37,7 @@
 
 #endif
 
+extern void loongson3_ipi_interrupt(struct pt_regs *regs);
+
 #include_next <irq.h>
 #endif /* __ASM_MACH_LOONGSON_IRQ_H_ */
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 69e9d9e..f185907 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -27,6 +27,7 @@ extern void mach_prepare_shutdown(void);
 /* environment arguments from bootloader */
 extern u32 cpu_clock_freq;
 extern u32 memsize, highmemsize;
+extern struct plat_smp_ops loongson3_smp_ops;
 
 /* loongson-specific command line, env and memory initialization */
 extern void __init prom_init_memory(void);
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index 81ba3b4..c0a0b15 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -33,6 +33,7 @@ void __init prom_init(void)
 
 	/*init the uart base address */
 	prom_init_uart_base();
+	register_smp_ops(&loongson3_smp_ops);
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/loongson/common/setup.c b/arch/mips/loongson/common/setup.c
index 8223f8a..bb4ac92 100644
--- a/arch/mips/loongson/common/setup.c
+++ b/arch/mips/loongson/common/setup.c
@@ -18,9 +18,6 @@
 #include <linux/screen_info.h>
 #endif
 
-void (*__wbflush)(void);
-EXPORT_SYMBOL(__wbflush);
-
 static void wbflush_loongson(void)
 {
 	asm(".set\tpush\n\t"
@@ -32,10 +29,11 @@ static void wbflush_loongson(void)
 	    ".set mips0\n\t");
 }
 
+void (*__wbflush)(void) = wbflush_loongson;
+EXPORT_SYMBOL(__wbflush);
+
 void __init plat_mem_setup(void)
 {
-	__wbflush = wbflush_loongson;
-
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
index b9968cd..70152b2 100644
--- a/arch/mips/loongson/loongson-3/Makefile
+++ b/arch/mips/loongson/loongson-3/Makefile
@@ -2,3 +2,5 @@
 # Makefile for Loongson-3 family machines
 #
 obj-y			+= irq.o
+
+obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index b2dc62b..088fd5e 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -26,6 +26,10 @@ void mach_irq_dispatch(unsigned int pending)
 {
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
+#if defined(CONFIG_SMP)
+	else if (pending & CAUSEF_IP6)
+		loongson3_ipi_interrupt(NULL);
+#endif
 	else if (pending & CAUSEF_IP3)
 		ht_irqdispatch();
 	else if (pending & CAUSEF_IP2)
@@ -45,10 +49,26 @@ static inline void mask_loongson_irq(struct irq_data *d)
 {
 	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_disable_hazard();
+
+	/* Workaround: UART IRQ may deliver to any core */
+	if (d->irq == LOONGSON_UART_IRQ) {
+		int cpu = smp_processor_id();
+
+		LOONGSON_INT_ROUTER_INTENCLR = 1 << 10;
+		LOONGSON_INT_ROUTER_LPC = 0x10 + (1<<cpu);
+	}
 }
 
 static inline void unmask_loongson_irq(struct irq_data *d)
 {
+	/* Workaround: UART IRQ may deliver to any core */
+	if (d->irq == LOONGSON_UART_IRQ) {
+		int cpu = smp_processor_id();
+
+		LOONGSON_INT_ROUTER_INTENSET = 1 << 10;
+		LOONGSON_INT_ROUTER_LPC = 0x10 + (1<<cpu);
+	}
+
 	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_enable_hazard();
 }
diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
new file mode 100644
index 0000000..93483c2
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -0,0 +1,267 @@
+/*
+ * Copyright (C) 2010, 2011, 2012, Lemote, Inc.
+ * Author: Chen Huacai, chenhc@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/cpufreq.h>
+#include <asm/processor.h>
+#include <asm/time.h>
+#include <asm/clock.h>
+#include <asm/tlbflush.h>
+#include <loongson.h>
+
+#include "smp.h"
+
+/* read a 32bit value from ipi register */
+#define loongson3_ipi_read32(addr) readl(addr)
+/* read a 64bit value from ipi register */
+#define loongson3_ipi_read64(addr) readq(addr)
+/* write a 32bit value to ipi register */
+#define loongson3_ipi_write32(action, addr)	\
+	do {					\
+		writel(action, addr);		\
+		__wbflush();			\
+	} while (0)
+/* write a 64bit value to ipi register */
+#define loongson3_ipi_write64(action, addr)	\
+	do {					\
+		writeq(action, addr);		\
+		__wbflush();			\
+	} while (0)
+
+static void *ipi_set0_regs[] = {
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + SET0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + SET0),
+};
+
+static void *ipi_clear0_regs[] = {
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + CLEAR0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + CLEAR0),
+};
+
+static void *ipi_status0_regs[] = {
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + STATUS0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + STATUS0),
+};
+
+static void *ipi_en0_regs[] = {
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + EN0),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + EN0),
+};
+
+static void *ipi_mailbox_buf[] = {
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + BUF),
+	(void *)(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + BUF),
+};
+
+/*
+ * Simple enough, just poke the appropriate ipi register
+ */
+static void loongson3_send_ipi_single(int cpu, unsigned int action)
+{
+	loongson3_ipi_write32((u32)action, ipi_set0_regs[cpu]);
+}
+
+static void
+loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu(i, mask)
+		loongson3_ipi_write32((u32)action, ipi_set0_regs[i]);
+}
+
+void loongson3_ipi_interrupt(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	unsigned int action;
+
+	/* Load the ipi register to figure out what we're supposed to do */
+	action = loongson3_ipi_read32(ipi_status0_regs[cpu]);
+
+	/* Clear the ipi register to clear the interrupt */
+	loongson3_ipi_write32((u32)action, ipi_clear0_regs[cpu]);
+
+	if (action & SMP_RESCHEDULE_YOURSELF)
+		scheduler_ipi();
+
+	if (action & SMP_CALL_FUNCTION)
+		smp_call_function_interrupt();
+}
+
+/*
+ * SMP init and finish on secondary CPUs
+ */
+static void loongson3_init_secondary(void)
+{
+	int i;
+	unsigned int imask = STATUSF_IP7 | STATUSF_IP6 |
+			     STATUSF_IP3 | STATUSF_IP2;
+
+	/* Set interrupt mask, but don't enable */
+	change_c0_status(ST0_IM, imask);
+
+	for (i = 0; i < loongson_sysconf.nr_cpus; i++)
+		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
+}
+
+static void loongson3_smp_finish(void)
+{
+	write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
+	local_irq_enable();
+	loongson3_ipi_write64(0,
+			(void *)(ipi_mailbox_buf[smp_processor_id()]+0x0));
+	pr_info("CPU#%d finished, CP0_ST=%x\n",
+			smp_processor_id(), read_c0_status());
+}
+
+static void __init loongson3_smp_setup(void)
+{
+	int i, num;
+
+	init_cpu_possible(cpu_none_mask);
+	set_cpu_possible(0, true);
+
+	__cpu_number_map[0] = 0;
+	__cpu_logical_map[0] = 0;
+
+	/* For unified kernel, NR_CPUS is the maximum possible value,
+	 * loongson_sysconf.nr_cpus is the really present value */
+	for (i = 1, num = 0; i < loongson_sysconf.nr_cpus; i++) {
+		set_cpu_possible(i, true);
+		__cpu_number_map[i] = ++num;
+		__cpu_logical_map[num] = i;
+	}
+	pr_info("Detected %i available secondary CPU(s)\n", num);
+}
+
+static void __init loongson3_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+/*
+ * Setup the PC, SP, and GP of a secondary processor and start it runing!
+ */
+static void loongson3_boot_secondary(int cpu, struct task_struct *idle)
+{
+	unsigned long startargs[4];
+
+	pr_info("Booting CPU#%d...\n", cpu);
+
+	/* startargs[] are initial PC, SP and GP for secondary CPU */
+	startargs[0] = (unsigned long)&smp_bootstrap;
+	startargs[1] = (unsigned long)__KSTK_TOS(idle);
+	startargs[2] = (unsigned long)task_thread_info(idle);
+	startargs[3] = 0;
+
+	pr_debug("CPU#%d, func_pc=%lx, sp=%lx, gp=%lx\n",
+			cpu, startargs[0], startargs[1], startargs[2]);
+
+	loongson3_ipi_write64(startargs[3], (void *)(ipi_mailbox_buf[cpu]+0x18));
+	loongson3_ipi_write64(startargs[2], (void *)(ipi_mailbox_buf[cpu]+0x10));
+	loongson3_ipi_write64(startargs[1], (void *)(ipi_mailbox_buf[cpu]+0x8));
+	loongson3_ipi_write64(startargs[0], (void *)(ipi_mailbox_buf[cpu]+0x0));
+}
+
+/*
+ * Final cleanup after all secondaries booted
+ */
+static void __init loongson3_cpus_done(void)
+{
+}
+
+struct plat_smp_ops loongson3_smp_ops = {
+	.send_ipi_single = loongson3_send_ipi_single,
+	.send_ipi_mask = loongson3_send_ipi_mask,
+	.init_secondary = loongson3_init_secondary,
+	.smp_finish = loongson3_smp_finish,
+	.cpus_done = loongson3_cpus_done,
+	.boot_secondary = loongson3_boot_secondary,
+	.smp_setup = loongson3_smp_setup,
+	.prepare_cpus = loongson3_prepare_cpus,
+};
diff --git a/arch/mips/loongson/loongson-3/smp.h b/arch/mips/loongson/loongson-3/smp.h
new file mode 100644
index 0000000..3453e8c
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/smp.h
@@ -0,0 +1,29 @@
+#ifndef __LOONGSON_SMP_H_
+#define __LOONGSON_SMP_H_
+
+/* for Loongson-3A smp support */
+
+/* 4 groups(nodes) in maximum in numa case */
+#define  SMP_CORE_GROUP0_BASE    0x900000003ff01000
+#define  SMP_CORE_GROUP1_BASE    0x900010003ff01000
+#define  SMP_CORE_GROUP2_BASE    0x900020003ff01000
+#define  SMP_CORE_GROUP3_BASE    0x900030003ff01000
+
+/* 4 cores in each group(node) */
+#define  SMP_CORE0_OFFSET  0x000
+#define  SMP_CORE1_OFFSET  0x100
+#define  SMP_CORE2_OFFSET  0x200
+#define  SMP_CORE3_OFFSET  0x300
+
+/* ipi registers offsets */
+#define  STATUS0  0x00
+#define  EN0      0x04
+#define  SET0     0x08
+#define  CLEAR0   0x0c
+#define  STATUS1  0x10
+#define  MASK1    0x14
+#define  SET1     0x18
+#define  CLEAR1   0x1c
+#define  BUF      0x20
+
+#endif
-- 
1.7.7.3
