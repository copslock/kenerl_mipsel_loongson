Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Dec 2013 13:18:25 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44155 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818020Ab3LOMQ2LySGT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Dec 2013 13:16:28 +0100
Received: by mail-pa0-f43.google.com with SMTP id bj1so1796608pad.16
        for <multiple recipients>; Sun, 15 Dec 2013 04:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udRYT1TN4mqlL6wvHjpFlya0w++GujI9zy2WCFHKt1k=;
        b=HNypPheh9bedqEvMVNIwNOHdNy5CWCeqYyu+Uf0CitlRMrPotWDsJ72h6RYL4wlAPF
         AKnz69jwxpTIwkbUY8o6YS0XXXsjyOpZBaCwDsfNDuk+NazT8VKU6puIkLwjsoFD862D
         TS5VXUJst81PNM5Ne7vjmG54H9wMf7QMn8aTVYQ0Aa1i27a1GsvaYiY6YZK99lpzxBID
         aqfIEmTxAOSFo4f3tsTpj+OsKOypoz86hP8jHME33vpAY98WbjjOPzZHofHiBmv+WXS1
         YaD5zQ4tbpNH+wcbOYZUVAeav/nWQ5uODA+xEyfDpm+t66ZdCsCdCHcPlwpznhUB23IO
         7C7A==
X-Received: by 10.66.157.167 with SMTP id wn7mr14048982pab.93.1387109781694;
        Sun, 15 Dec 2013 04:16:21 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id iu7sm18648601pbc.45.2013.12.15.04.16.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 04:16:20 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V15 10/12] MIPS: Loongson 3: Add Loongson-3 SMP support
Date:   Sun, 15 Dec 2013 20:14:34 +0800
Message-Id: <1387109676-540-11-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1387109676-540-1-git-send-email-chenhc@lemote.com>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38714
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
---
 arch/mips/loongson/common/init.c       |    5 +
 arch/mips/loongson/common/setup.c      |    8 +-
 arch/mips/loongson/loongson-3/Makefile |    2 +
 arch/mips/loongson/loongson-3/irq.c    |   16 ++
 arch/mips/loongson/loongson-3/smp.c    |  280 ++++++++++++++++++++++++++++++++
 arch/mips/loongson/loongson-3/smp.h    |   24 +++
 6 files changed, 330 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/loongson/loongson-3/smp.c
 create mode 100644 arch/mips/loongson/loongson-3/smp.h

diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index 81ba3b4..d6c501b 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -12,6 +12,8 @@
 
 #include <loongson.h>
 
+extern struct plat_smp_ops loongson3_smp_ops;
+
 /* Loongson CPU address windows config space base address */
 unsigned long __maybe_unused _loongson_addrwincfg_base;
 
@@ -33,6 +35,9 @@ void __init prom_init(void)
 
 	/*init the uart base address */
 	prom_init_uart_base();
+#if defined(CONFIG_SMP)
+	register_smp_ops(&loongson3_smp_ops);
+#endif
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
index aaf18c2..11467ca 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -61,10 +61,26 @@ static inline void mask_loongson_irq(struct irq_data *d)
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
index 0000000..3c52565
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -0,0 +1,280 @@
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
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
+/* read a 64bit value from ipi register */
+uint64_t loongson3_ipi_read64(void * addr)
+{
+	return *((volatile uint64_t *)addr);
+};
+
+/* write a 64bit value to ipi register */
+void loongson3_ipi_write64(uint64_t action, void * addr)
+{
+	*((volatile uint64_t *)addr) = action;
+	__wbflush();
+};
+
+/* read a 32bit value from ipi register */
+uint32_t loongson3_ipi_read32(void * addr)
+{
+	return *((volatile uint32_t *)addr);
+};
+
+/* write a 32bit value to ipi register */
+void loongson3_ipi_write32(uint32_t action, void * addr)
+{
+	*((volatile uint32_t *)addr) = action;
+	__wbflush();
+};
+
+static void *ipi_set0_regs[] = {
+	(void *)(smp_core_group0_base + smp_core0_offset + SET0),
+	(void *)(smp_core_group0_base + smp_core1_offset + SET0),
+	(void *)(smp_core_group0_base + smp_core2_offset + SET0),
+	(void *)(smp_core_group0_base + smp_core3_offset + SET0),
+	(void *)(smp_core_group1_base + smp_core0_offset + SET0),
+	(void *)(smp_core_group1_base + smp_core1_offset + SET0),
+	(void *)(smp_core_group1_base + smp_core2_offset + SET0),
+	(void *)(smp_core_group1_base + smp_core3_offset + SET0),
+	(void *)(smp_core_group2_base + smp_core0_offset + SET0),
+	(void *)(smp_core_group2_base + smp_core1_offset + SET0),
+	(void *)(smp_core_group2_base + smp_core2_offset + SET0),
+	(void *)(smp_core_group2_base + smp_core3_offset + SET0),
+	(void *)(smp_core_group3_base + smp_core0_offset + SET0),
+	(void *)(smp_core_group3_base + smp_core1_offset + SET0),
+	(void *)(smp_core_group3_base + smp_core2_offset + SET0),
+	(void *)(smp_core_group3_base + smp_core3_offset + SET0),
+};
+
+static void *ipi_clear0_regs[] = {
+	(void *)(smp_core_group0_base + smp_core0_offset + CLEAR0),
+	(void *)(smp_core_group0_base + smp_core1_offset + CLEAR0),
+	(void *)(smp_core_group0_base + smp_core2_offset + CLEAR0),
+	(void *)(smp_core_group0_base + smp_core3_offset + CLEAR0),
+	(void *)(smp_core_group1_base + smp_core0_offset + CLEAR0),
+	(void *)(smp_core_group1_base + smp_core1_offset + CLEAR0),
+	(void *)(smp_core_group1_base + smp_core2_offset + CLEAR0),
+	(void *)(smp_core_group1_base + smp_core3_offset + CLEAR0),
+	(void *)(smp_core_group2_base + smp_core0_offset + CLEAR0),
+	(void *)(smp_core_group2_base + smp_core1_offset + CLEAR0),
+	(void *)(smp_core_group2_base + smp_core2_offset + CLEAR0),
+	(void *)(smp_core_group2_base + smp_core3_offset + CLEAR0),
+	(void *)(smp_core_group3_base + smp_core0_offset + CLEAR0),
+	(void *)(smp_core_group3_base + smp_core1_offset + CLEAR0),
+	(void *)(smp_core_group3_base + smp_core2_offset + CLEAR0),
+	(void *)(smp_core_group3_base + smp_core3_offset + CLEAR0),
+};
+
+static void *ipi_status0_regs[] = {
+	(void *)(smp_core_group0_base + smp_core0_offset + STATUS0),
+	(void *)(smp_core_group0_base + smp_core1_offset + STATUS0),
+	(void *)(smp_core_group0_base + smp_core2_offset + STATUS0),
+	(void *)(smp_core_group0_base + smp_core3_offset + STATUS0),
+	(void *)(smp_core_group1_base + smp_core0_offset + STATUS0),
+	(void *)(smp_core_group1_base + smp_core1_offset + STATUS0),
+	(void *)(smp_core_group1_base + smp_core2_offset + STATUS0),
+	(void *)(smp_core_group1_base + smp_core3_offset + STATUS0),
+	(void *)(smp_core_group2_base + smp_core0_offset + STATUS0),
+	(void *)(smp_core_group2_base + smp_core1_offset + STATUS0),
+	(void *)(smp_core_group2_base + smp_core2_offset + STATUS0),
+	(void *)(smp_core_group2_base + smp_core3_offset + STATUS0),
+	(void *)(smp_core_group3_base + smp_core0_offset + STATUS0),
+	(void *)(smp_core_group3_base + smp_core1_offset + STATUS0),
+	(void *)(smp_core_group3_base + smp_core2_offset + STATUS0),
+	(void *)(smp_core_group3_base + smp_core3_offset + STATUS0),
+};
+
+static void *ipi_en0_regs[] = {
+	(void *)(smp_core_group0_base + smp_core0_offset + EN0),
+	(void *)(smp_core_group0_base + smp_core1_offset + EN0),
+	(void *)(smp_core_group0_base + smp_core2_offset + EN0),
+	(void *)(smp_core_group0_base + smp_core3_offset + EN0),
+	(void *)(smp_core_group1_base + smp_core0_offset + EN0),
+	(void *)(smp_core_group1_base + smp_core1_offset + EN0),
+	(void *)(smp_core_group1_base + smp_core2_offset + EN0),
+	(void *)(smp_core_group1_base + smp_core3_offset + EN0),
+	(void *)(smp_core_group2_base + smp_core0_offset + EN0),
+	(void *)(smp_core_group2_base + smp_core1_offset + EN0),
+	(void *)(smp_core_group2_base + smp_core2_offset + EN0),
+	(void *)(smp_core_group2_base + smp_core3_offset + EN0),
+	(void *)(smp_core_group3_base + smp_core0_offset + EN0),
+	(void *)(smp_core_group3_base + smp_core1_offset + EN0),
+	(void *)(smp_core_group3_base + smp_core2_offset + EN0),
+	(void *)(smp_core_group3_base + smp_core3_offset + EN0),
+};
+
+static volatile void *ipi_mailbox_buf[] = {
+	(void *)(smp_core_group0_base + smp_core0_offset + BUF),
+	(void *)(smp_core_group0_base + smp_core1_offset + BUF),
+	(void *)(smp_core_group0_base + smp_core2_offset + BUF),
+	(void *)(smp_core_group0_base + smp_core3_offset + BUF),
+	(void *)(smp_core_group1_base + smp_core0_offset + BUF),
+	(void *)(smp_core_group1_base + smp_core1_offset + BUF),
+	(void *)(smp_core_group1_base + smp_core2_offset + BUF),
+	(void *)(smp_core_group1_base + smp_core3_offset + BUF),
+	(void *)(smp_core_group2_base + smp_core0_offset + BUF),
+	(void *)(smp_core_group2_base + smp_core1_offset + BUF),
+	(void *)(smp_core_group2_base + smp_core2_offset + BUF),
+	(void *)(smp_core_group2_base + smp_core3_offset + BUF),
+	(void *)(smp_core_group3_base + smp_core0_offset + BUF),
+	(void *)(smp_core_group3_base + smp_core1_offset + BUF),
+	(void *)(smp_core_group3_base + smp_core2_offset + BUF),
+	(void *)(smp_core_group3_base + smp_core3_offset + BUF),
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
+static void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
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
+	if (action & SMP_RESCHEDULE_YOURSELF) {
+		scheduler_ipi();
+	}
+
+	if (action & SMP_CALL_FUNCTION) {
+		smp_call_function_interrupt();
+	}
+}
+
+/*
+ * SMP init and finish on secondary CPUs
+ */
+void loongson3_init_secondary(void)
+{
+	int i;
+	unsigned int imask = STATUSF_IP7 | STATUSF_IP6 |
+			     STATUSF_IP3 | STATUSF_IP2;
+
+	/* Set interrupt mask, but don't enable */
+	change_c0_status(ST0_IM, imask);
+
+	for (i = 0; i < nr_cpus_loongson; i++) {
+		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
+	}
+}
+
+void loongson3_smp_finish(void)
+{
+	write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
+	local_irq_enable();
+	loongson3_ipi_write64(0, (void *)(ipi_mailbox_buf[smp_processor_id()]+0x0));
+	printk(KERN_INFO "CPU#%d finished, CP0_ST=%x\n",
+			smp_processor_id(), read_c0_status());
+}
+
+void __init loongson3_smp_setup(void)
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
+	 * nr_cpus_loongson is the really present value */
+	for (i = 1, num = 0; i < nr_cpus_loongson; i++) {
+		set_cpu_possible(i, true);
+		__cpu_number_map[i] = ++num;
+		__cpu_logical_map[num] = i;
+	}
+	printk(KERN_INFO "Detected %i available secondary CPU(s)\n", num);
+}
+
+void __init loongson3_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+/*
+ * Setup the PC, SP, and GP of a secondary processor and start it runing!
+ */
+void loongson3_boot_secondary(int cpu, struct task_struct *idle)
+{
+	volatile unsigned long startargs[4];
+
+	printk(KERN_INFO "Booting CPU#%d...\n", cpu);
+
+	/* startargs[] are initial PC, SP and GP for secondary CPU */
+	startargs[0] = (unsigned long)&smp_bootstrap;
+	startargs[1] = (unsigned long)__KSTK_TOS(idle);
+	startargs[2] = (unsigned long)task_thread_info(idle);
+	startargs[3] = 0;
+
+	printk(KERN_DEBUG "CPU#%d, func_pc=%lx, sp=%lx, gp=%lx\n",
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
+void __init loongson3_cpus_done(void)
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
index 0000000..dc9ce69
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/smp.h
@@ -0,0 +1,24 @@
+/* for Loongson-3A smp support */
+
+/* 4 groups(nodes) in maximum in numa case */
+#define  smp_core_group0_base    0x900000003ff01000
+#define  smp_core_group1_base    0x900010003ff01000
+#define  smp_core_group2_base    0x900020003ff01000
+#define  smp_core_group3_base    0x900030003ff01000
+
+/* 4 cores in each group(node) */
+#define  smp_core0_offset  0x000
+#define  smp_core1_offset  0x100
+#define  smp_core2_offset  0x200
+#define  smp_core3_offset  0x300
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
-- 
1.7.7.3
