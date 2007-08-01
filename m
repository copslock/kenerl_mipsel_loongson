Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 10:01:42 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:62474 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021708AbXHAJBh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 10:01:37 +0100
Received: by wa-out-1112.google.com with SMTP id m16so139163waf
        for <linux-mips@linux-mips.org>; Wed, 01 Aug 2007 02:01:18 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=galvjmnljIffu3acc7ZiJOqnSdj2K4cyoB3bi/jgAMxog2TceL2faHs1STze2XHm6qN5v7pEBfz0Uzt1FaCOrlRcKRteRfOY8OOfCPGohADRiRiB2qmwdoXv/aLEJqa9BEsaKToy3NTqCcHPj0cTM4UehdoQOVHNQk0MUoXOrkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=RZpciKJ31JyQI8RNYUE2FCNcZO2BZX7ThINJQy+Hoii8+E96+U/YVgSoq7GIC8HQ+d37He0SsvHRRT69mFJi5tJXyTCVkdApwE4xmK/QR5dqpDriYO40zeZ/aWZ7LXpxuZW1uY2fr+Uk1BRQEurVh6H2e4UfxTzQgs/X/8Vqhjo=
Received: by 10.115.107.1 with SMTP id j1mr509496wam.1185958877896;
        Wed, 01 Aug 2007 02:01:17 -0700 (PDT)
Received: from dajietan.caozhai.com ( [58.213.112.151])
        by mx.google.com with ESMTPS id v39sm557866wah.2007.08.01.02.01.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 02:01:17 -0700 (PDT)
Received: from comcat by dajietan.caozhai.com with local (Exim 4.54)
	id 1IGDp8-0001Lz-0w; Wed, 01 Aug 2007 17:01:10 +0400
Date:	Wed, 1 Aug 2007 17:01:09 +0400
From:	Dajie Tan <jiankemeng@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	oprofile-list@lists.sourceforge.net
Subject: [PATCH][resend] add support for profiling loongson2e
Message-ID: <20070801130109.GA5170@sw-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

Using mutt resend it. Wish it would be sended ok.

Tan.


Signed-off-by: Dajie Tan <jiankemeng@gmail.com>
---
 arch/mips/lemote/lm2e/irq.c              |    2 +
 arch/mips/oprofile/Makefile              |    1 +
 arch/mips/oprofile/common.c              |    6 +
 arch/mips/oprofile/op_model_loongson2e.c |  170 ++++++++++++++++++++++++++++++
 drivers/oprofile/cpu_buffer.c            |    4 +
 include/asm-mips/mipsregs.h              |   60 +++++++++++
 6 files changed, 243 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lemote/lm2e/irq.c b/arch/mips/lemote/lm2e/irq.c
index 3e0b7be..62f6822 100644
--- a/arch/mips/lemote/lm2e/irq.c
+++ b/arch/mips/lemote/lm2e/irq.c
@@ -81,6 +81,8 @@ asmlinkage void plat_irq_dispatch(void)
 
 	if (pending & CAUSEF_IP7) {
 		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+ 	} else if (pending & CAUSEF_IP6) { 	/* performance counter overflowe at IP6 */
+ 		do_IRQ(MIPS_CPU_IRQ_BASE + 6);
 	} else if (pending & CAUSEF_IP5) {
 		i8259_irqdispatch();
 	} else if (pending & CAUSEF_IP2) {
diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index bf3be6f..9148850 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -15,3 +15,4 @@ oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
+oprofile-$(CONFIG_CPU_LOONGSON2)		+= op_model_loongson2e.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 4e0a90b..50a0531 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -16,6 +16,7 @@
 
 extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
 extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
+extern struct op_mips_model op_model_loongson2e_ops __attribute__((weak));
 
 static struct op_mips_model *model;
 
@@ -92,6 +93,11 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_RM9000:
 		lmodel = &op_model_rm9000_ops;
 		break;
+
+ 	case CPU_LOONGSON2:
+ 		lmodel = &op_model_loongson2e_ops;
+ 		break;
+ 
 	};
 
 	if (!lmodel)
diff --git a/arch/mips/oprofile/op_model_loongson2e.c b/arch/mips/oprofile/op_model_loongson2e.c
new file mode 100644
index 0000000..f7c2a84
--- /dev/null
+++ b/arch/mips/oprofile/op_model_loongson2e.c
@@ -0,0 +1,170 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 by Dajie Tan <jiankemeng@gmail.com>
+ */
+
+#include <linux/init.h>
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+
+#include "op_impl.h"
+
+#define GODSON2E_PERFCTL_EXL			(1UL    <<  0)
+#define GODSON2E_PERFCTL_KERNEL			(1UL    <<  1)
+#define GODSON2E_PERFCTL_SUPERVISOR		(1UL    <<  2)
+#define GODSON2E_PERFCTL_USER			(1UL    <<  3)
+#define GODSON2E_PERFCTL_INTERRUPT_ENABLE	(1UL    <<  4)
+#define GODSON2E_PERFCTL_OVERFLOW		(1ULL	<< 31)
+
+#define GODSON2E_COUNTER1_EVENT(event)	((event) << 5)
+#define GODSON2E_COUNTER2_EVENT(event)	((event) << 9)
+
+
+/* IP6 --- performance counter overflow */
+static int loongson2e_pmc_irq = MIPS_CPU_IRQ_BASE + 6;
+
+
+static struct loongson2e_register_config {
+	unsigned int control;
+	unsigned int reset_counter1;
+	unsigned int reset_counter2;
+	int c1_enabled;
+	int c2_enabled;
+} reg;
+
+/* Compute all of the registers in preparation for enabling profiling.  */
+
+static void loongson2e_reg_setup(struct op_counter_config *ctr)
+{
+	unsigned int control = 0;
+
+	/* Compute the performance counter control word.  */
+	/* For now count kernel and user mode */
+	if (ctr[0].enabled)
+		control |= GODSON2E_COUNTER1_EVENT(ctr[0].event) |
+		           GODSON2E_PERFCTL_INTERRUPT_ENABLE;
+	else
+		control |= GODSON2E_COUNTER1_EVENT(0xe);
+
+	if (ctr[1].enabled)
+		control |= GODSON2E_COUNTER2_EVENT(ctr[1].event) |
+		           GODSON2E_PERFCTL_INTERRUPT_ENABLE;
+	else
+		control |= GODSON2E_COUNTER2_EVENT(0x3);
+
+	if (ctr[0].kernel || ctr[1].kernel)
+		control |= GODSON2E_PERFCTL_KERNEL;
+	else
+		control &= ~GODSON2E_PERFCTL_KERNEL;
+
+	if (ctr[0].user || ctr[1].user)
+		control |= GODSON2E_PERFCTL_USER;
+	else
+		control &= ~GODSON2E_PERFCTL_USER;
+
+	if (ctr[0].exl || ctr[1].exl)
+		control |= GODSON2E_PERFCTL_EXL;
+	else
+		control &= ~GODSON2E_PERFCTL_EXL;
+
+	reg.control = control;
+
+	reg.c1_enabled = ctr[0].enabled;
+	reg.c2_enabled = ctr[1].enabled;
+	reg.reset_counter1 = ctr[0].count ? 0x80000000 - ctr[0].count : 0;
+	reg.reset_counter2 = ctr[1].count ? 0x80000000 - ctr[1].count : 0;
+}
+
+static void loongson2e_cpu_setup (void *args)
+{
+	uint64_t perfcount;
+	perfcount = ((uint64_t) reg.reset_counter2 << 32) | reg.reset_counter1;
+	write_c0_pmc_count(perfcount);
+}
+
+static void loongson2e_cpu_start(void *args)
+{
+	/* Start all counters */
+	write_c0_pmc_control(reg.control);
+}
+
+static void loongson2e_cpu_stop(void *args)
+{
+	/* Stop all counters */
+	write_c0_pmc_control(0);
+}
+
+
+static irqreturn_t loongson2e_pmc_handler(int irq, void * dev_id)
+{
+	uint32_t counter1, counter2;
+	uint64_t counters;
+	uint64_t tmp = 0x0;
+	struct pt_regs *regs = get_irq_regs();
+
+	/*
+	 * Godson2e combines two 32-bit performance counters into a single
+	 * 64-bit coprocessor zero register.  To avoid a race updating the
+	 * registers we need to stop the counters while we're messing with
+	 * them ...
+	 */
+
+	write_c0_pmc_control(tmp);
+
+	counters = read_c0_pmc_count();
+	counter1 = counters;
+	counter2 = counters >> 32;
+
+	if (reg.c2_enabled && counter2 & GODSON2E_PERFCTL_OVERFLOW) {
+		oprofile_add_sample(regs, 1);
+		counter2 = reg.reset_counter2;
+	}
+
+	if (reg.c1_enabled && counter1 & GODSON2E_PERFCTL_OVERFLOW) {
+		oprofile_add_sample(regs, 0);
+		counter1 = reg.reset_counter1;
+	}
+
+	counters = ((uint64_t)counter2 << 32) | counter1;
+
+	write_c0_pmc_count(counters);
+	write_c0_pmc_control(reg.control);
+
+	return IRQ_HANDLED;
+}
+
+static int __init loongson2e_init(void)
+{
+	uint64_t tmp = 0;
+	write_c0_pmc_control(0);
+	write_c0_pmc_count(tmp);
+
+	return request_irq(loongson2e_pmc_irq, loongson2e_pmc_handler,
+	                   IRQF_DISABLED, "Perfcounter", NULL);
+}
+
+static void loongson2e_exit(void)
+{
+	uint64_t tmp = 0;
+	write_c0_pmc_control(0);
+	write_c0_pmc_count(tmp);
+
+	free_irq(loongson2e_pmc_irq, NULL);
+}
+
+struct op_mips_model op_model_loongson2e_ops = {
+	.reg_setup	= loongson2e_reg_setup,
+	.cpu_setup	= loongson2e_cpu_setup,
+	.init		= loongson2e_init,
+	.exit		= loongson2e_exit,
+	.cpu_start	= loongson2e_cpu_start,
+	.cpu_stop	= loongson2e_cpu_stop,
+	.cpu_type	= "mips/loongson2e",
+	.num_counters	= 2
+};
+
+
diff --git a/drivers/oprofile/cpu_buffer.c b/drivers/oprofile/cpu_buffer.c
index a83c3db..fde9819 100644
--- a/drivers/oprofile/cpu_buffer.c
+++ b/drivers/oprofile/cpu_buffer.c
@@ -148,6 +148,10 @@ add_sample(struct oprofile_cpu_buffer * cpu_buf,
            unsigned long pc, unsigned long event)
 {
 	struct op_sample * entry = &cpu_buf->buffer[cpu_buf->head_pos];
+
+	if(!entry)
+		return;
+
 	entry->eip = pc;
 	entry->event = event;
 	increment_head(cpu_buf);
diff --git a/include/asm-mips/mipsregs.h b/include/asm-mips/mipsregs.h
index 18f47f1..8a00c20 100644
--- a/include/asm-mips/mipsregs.h
+++ b/include/asm-mips/mipsregs.h
@@ -600,6 +600,58 @@ do {								\
 } while (0)
 
 
+
+/*
+ * Macros to access the loongson2e system control coprocessor
+ */
+#define __read_64bit_c0_pmc_split(source, sel)				\
+({									\
+	unsigned long long val;						\
+	unsigned long flags;						\
+									\
+	local_irq_save(flags);						\
+	if (sel == 0)							\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc0\t%M0, " #source "\n\t"			\
+			"dsll\t%L0, %M0, 32\n\t"			\
+			"dsra\t%M0, %M0, 32\n\t"			\
+			"dsra\t%L0, %L0, 32\n\t"			\
+			".set\tmips0"					\
+			: "=r" (val));					\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc0\t%M0, " #source ", " #sel "\n\t"		\
+			"dsll\t%L0, %M0, 32\n\t"			\
+			"dsra\t%M0, %M0, 32\n\t"			\
+			"dsra\t%L0, %L0, 32\n\t"			\
+			".set\tmips0"					\
+			: "=r" (val));					\
+	local_irq_restore(flags);					\
+									\
+	val;								\
+})
+
+#define __read_64bit_c0_pmc(source, sel)				\
+({ unsigned long long __res;						\
+	if (sizeof(unsigned long) == 4)					\
+		__res = __read_64bit_c0_pmc_split(source, sel);		\
+	else if (sel == 0)						\
+		__asm__ __volatile__(					\
+			".set\tmips3\n\t"				\
+			"dmfc0\t%0, " #source "\n\t"			\
+			".set\tmips0"					\
+			: "=r" (__res));				\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc0\t%0, " #source ", " #sel "\n\t"		\
+			".set\tmips0"					\
+			: "=r" (__res));				\
+	__res;								\
+})
+
 /*
  * Macros to access the system control coprocessor
  */
@@ -905,6 +957,14 @@ do {									\
 #define read_c0_framemask()	__read_32bit_c0_register($21, 0)
 #define write_c0_framemask(val)	__write_32bit_c0_register($21, 0, val)
 
+/* Loongson2e PMC control register */
+#define read_c0_pmc_control()	__read_32bit_c0_register($24, 0)
+#define write_c0_pmc_control(val) __write_32bit_c0_register($24, 0, val)
+
+/* Loongson2e PMC counter register */
+#define read_c0_pmc_count()	__read_64bit_c0_pmc($25, 0)
+#define write_c0_pmc_count(val)	__write_64bit_c0_register($25, 0, val)
+
 /* RM9000 PerfControl performance counter control register */
 #define read_c0_perfcontrol()	__read_32bit_c0_register($22, 0)
 #define write_c0_perfcontrol(val) __write_32bit_c0_register($22, 0, val)
