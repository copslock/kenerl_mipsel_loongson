Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:11:17 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:49590 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022601AbZFDNKK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:10:10 +0100
Received: by pxi16 with SMTP id 16so751437pxi.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:10:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fVxbXj36Bub+fUMpkoZXZrKmaByd9PyLPFLxTeP/ze8=;
        b=RBY+IxUbxhA7LEqAdMnW/uz5h9kDP7GsTaBw/tBCTU+ufxSPmzXIHM7lUupOxK+n/l
         IcxNDCkPk/cMvvCAw0YwH5Pe1jcnord2IVk+Zlzflcv7b00mvkrb4uSI3FK6yjSuh8zH
         RFpMAo/vJRstiEOowIv2DDEz3T2/kUffObqXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LNV77BYef9BX0Z0I6YhfJfHbsGD8fNUDBco7VDZMNYCAVNjU/0otFB64FJQIjg7IPd
         3giONRpxIn+/POHKjYfTsJXC4BchSfgqs772beRFFg05GQBnjsWFs2LRMacAC9HAPUgB
         tVHy4grRToekcf2/OoPVfOwGPWJ8LvW694jzU=
Received: by 10.115.73.13 with SMTP id a13mr3381338wal.198.1244121003508;
        Thu, 04 Jun 2009 06:10:03 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id j31sm3218299waf.33.2009.06.04.06.09.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:10:02 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 20/25] Loongson2 specific OProfile driver
Date:	Thu,  4 Jun 2009 21:09:49 +0800
Message-Id: <e73c5bf93f0cd400d306fc34c93dc58ff68ec7a1.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

this driver is used by the user-space tool:oprofile to profile linux
kernel or applications via loongson2 performance counters. you can
enable this driver via CONFIG_OPROFILE = y or m.

In loongson2, there are two performance counters, each one can count 16
events respectively. when anyone of the performance counter overflows,
an interrupt will generate and goes to the interrupt line:
MIPS_CPU_IRQ_BASE + 6, in fuloong2e, this interrupt line is exclusivly
used by perf counter, but in fuloong2f & yeeloong2f, this interrupt line
is shared by perf counter and the CPU internal north bridge(bonito64
compatiable).

NOTE: a patch should be sent to oprofile with the loongson-specific
support.  otherwise, the oprofile tool will not recognize this and
complain about "cpu_type 'unset' is not valid". currently, the cpu_type
is hard-coded in arch/mips/oprofile/op_model_loongson2.c as
'mips/loongson2'

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Yan Hua <yanh@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    2 +
 arch/mips/include/asm/mach-loongson/machine.h  |    1 -
 arch/mips/loongson/common/irq.c                |   25 +++-
 arch/mips/loongson/fuloong-2e/irq.c            |    2 +
 arch/mips/loongson/fuloong-2f/irq.c            |    6 +-
 arch/mips/loongson/yeeloong-2f/irq.c           |    6 +-
 arch/mips/oprofile/Makefile                    |    1 +
 arch/mips/oprofile/common.c                    |    5 +
 arch/mips/oprofile/op_model_loongson2.c        |  186 ++++++++++++++++++++++++
 9 files changed, 226 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/oprofile/op_model_loongson2.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index ea99209..b458a1e 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -53,7 +53,9 @@ extern void mach_prepare_shutdown(void);
 
 #define LOONGSON_REG(x) \
 	(*(u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
+
 #define LOONGSON_IRQ_BASE	32
+#define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
 
 #define LOONGSON_FLASH_BASE	0x1c000000
 #define LOONGSON_FLASH_SIZE	0x02000000	/* 32M */
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 9f8a607..8109a9e 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -51,7 +51,6 @@
 #if defined(CONFIG_LEMOTE_FULOONG2F) || defined(CONFIG_LEMOTE_YEELOONG2F)
 
 #define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
-#define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
 #define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
 #define LOONGSON_UART_IRQ	(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port */
 #define LOONGSON_SOUTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)	/* i8259 */
diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
index 5834f35..37bf722 100644
--- a/arch/mips/loongson/common/irq.c
+++ b/arch/mips/loongson/common/irq.c
@@ -70,6 +70,29 @@ static struct irqaction cascade_irqaction = {
 	.name = "cascade",
 };
 
+/*
+ * fuloong2f and yeeloong2f share the cpu perf counter interrupt and the north
+ * bridge interrupt in IP6, so, the ip6_irqaction should be sharable.
+ * otherwise, we will can not request the perf counter irq(setup the perf
+ * counter irq handler) in op_model_loongson2.c.
+ */
+
+#if defined(CONFIG_OPROFILE) && \
+	(defined(CONFIG_LEMOTE_FULOONG2F) || defined(CONFIG_LEMOTE_YEELOONG2F))
+irqreturn_t ip6_action(int cpl, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+static struct irqaction ip6_irqaction = {
+	.handler = ip6_action,
+	.name = "cascade",
+	.flags = IRQF_SHARED,
+};
+#else
+#define	ip6_irqaction	cascade_irqaction
+#endif
+
 void __init arch_init_irq(void)
 {
 	/*
@@ -103,7 +126,7 @@ void __init arch_init_irq(void)
 	bonito_irq_init();
 
 	/* setup north bridge irq (bonito) */
-	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &cascade_irqaction);
+	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &ip6_irqaction);
 	/* setup source bridge irq (i8259) */
 	setup_irq(LOONGSON_SOUTH_BRIDGE_IRQ, &cascade_irqaction);
 }
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index 9057709..e4da30c 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -40,6 +40,8 @@ void mach_irq_dispatch(unsigned int pending)
 {
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
+	else if (pending & CAUSEF_IP6)	/* perf counter loverflow */
+		do_IRQ(LOONGSON_PERFCNT_IRQ);
 	else if (pending & CAUSEF_IP5)
 		i8259_irqdispatch();
 	else if (pending & CAUSEF_IP2)
diff --git a/arch/mips/loongson/fuloong-2f/irq.c b/arch/mips/loongson/fuloong-2f/irq.c
index 4e4112a..d7a60fe 100644
--- a/arch/mips/loongson/fuloong-2f/irq.c
+++ b/arch/mips/loongson/fuloong-2f/irq.c
@@ -34,9 +34,9 @@ void mach_irq_dispatch(unsigned int pending)
 {
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
-	else if (pending & CAUSEF_IP6) {	/* North Bridge, Perf counter */
-		do_IRQ(LOONGSON_PERFCNT_IRQ);
-		bonito_irqdispatch();
+	else if (pending & CAUSEF_IP6) {
+		do_IRQ(LOONGSON_PERFCNT_IRQ);	/* Perf counter overflow */
+		bonito_irqdispatch();		/* North Bridge */
 	} else if (pending & CAUSEF_IP3)	/* CPU UART */
 		do_IRQ(LOONGSON_UART_IRQ);
 	else if (pending & CAUSEF_IP2)	/* South Bridge */
diff --git a/arch/mips/loongson/yeeloong-2f/irq.c b/arch/mips/loongson/yeeloong-2f/irq.c
index 4e4112a..d7a60fe 100644
--- a/arch/mips/loongson/yeeloong-2f/irq.c
+++ b/arch/mips/loongson/yeeloong-2f/irq.c
@@ -34,9 +34,9 @@ void mach_irq_dispatch(unsigned int pending)
 {
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
-	else if (pending & CAUSEF_IP6) {	/* North Bridge, Perf counter */
-		do_IRQ(LOONGSON_PERFCNT_IRQ);
-		bonito_irqdispatch();
+	else if (pending & CAUSEF_IP6) {
+		do_IRQ(LOONGSON_PERFCNT_IRQ);	/* Perf counter overflow */
+		bonito_irqdispatch();		/* North Bridge */
 	} else if (pending & CAUSEF_IP3)	/* CPU UART */
 		do_IRQ(LOONGSON_UART_IRQ);
 	else if (pending & CAUSEF_IP2)	/* South Bridge */
diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index bf3be6f..d039d6b 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -15,3 +15,4 @@ oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
+oprofile-$(CONFIG_CPU_LOONGSON2)  	+= op_model_loongson2.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 3bf3354..fd52bf6 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -16,6 +16,7 @@
 
 extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
 extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
+extern struct op_mips_model op_model_loongson2_ops __attribute__((weak));
 
 static struct op_mips_model *model;
 
@@ -93,6 +94,10 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_RM9000:
 		lmodel = &op_model_rm9000_ops;
 		break;
+
+	case CPU_LOONGSON2:
+		lmodel = &op_model_loongson2_ops;
+		break;
 	};
 
 	if (!lmodel)
diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
new file mode 100644
index 0000000..876674f
--- /dev/null
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -0,0 +1,186 @@
+/*
+ * Loongson2 performance counter driver for oprofile
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Yanhua <yanh@lemote.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+#include <linux/init.h>
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+
+#include <irq.h>
+#include <loongson.h>			/* LOONGSON_PERFCNT_IRQ */
+#include "op_impl.h"
+
+/*
+ * a patch should be sent to oprofile with the loongson-specific support.
+ * otherwise, the oprofile tool will not recognize this and complain about
+ * "cpu_type 'unset' is not valid".
+ */
+#define LOONGSON_CPU_TYPE	"mips/loongson2"
+
+#define LOONGSON_COUNTER1_EVENT(event)	((event & 0x0f) << 5)
+#define LOONGSON_COUNTER2_EVENT(event)	((event & 0x0f) << 9)
+
+#define LOONGSON_PERFCNT_EXL		(1UL	<<  0)
+#define LOONGSON_PERFCNT_KERNEL		(1UL    <<  1)
+#define LOONGSON_PERFCNT_SUPERVISOR	(1UL    <<  2)
+#define LOONGSON_PERFCNT_USER		(1UL    <<  3)
+#define LOONGSON_PERFCNT_INT_EN		(1UL    <<  4)
+#define LOONGSON_PERFCNT_OVERFLOW	(1ULL   << 31)
+
+/* Loongson2 performance counter register */
+#define read_c0_perflo() __read_64bit_c0_register($24, 0)
+#define write_c0_perflo(val) __write_64bit_c0_register($24, 0, val)
+#define read_c0_perfhi() __read_64bit_c0_register($25, 0)
+#define write_c0_perfhi(val) __write_64bit_c0_register($25, 0, val)
+
+static struct loongson2_register_config {
+	unsigned int ctrl;
+	unsigned long long reset_counter1;
+	unsigned long long reset_counter2;
+	int cnt1_enable, cnt2_enable;
+} reg;
+
+DEFINE_SPINLOCK(sample_lock);
+
+static char *oprofid = "LoongsonPerf";
+static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id);
+/* Compute all of the registers in preparation for enabling profiling.  */
+
+static void loongson2_reg_setup(struct op_counter_config *cfg)
+{
+	unsigned int ctrl = 0;
+
+	reg.reset_counter1 = 0;
+	reg.reset_counter2 = 0;
+	/* Compute the performance counter ctrl word.  */
+	/* For now count kernel and user mode */
+	if (cfg[0].enabled) {
+		ctrl |= LOONGSON_COUNTER1_EVENT(cfg[0].event) |
+		    LOONGSON_PERFCNT_INT_EN;
+		if (cfg[0].kernel)
+			ctrl |= LOONGSON_PERFCNT_KERNEL;
+		if (cfg[0].user)
+			ctrl |= LOONGSON_PERFCNT_USER;
+		reg.reset_counter1 = 0x80000000ULL - cfg[0].count;
+	}
+
+	if (cfg[1].enabled) {
+		ctrl |= LOONGSON_COUNTER2_EVENT(cfg[1].event) |
+		    LOONGSON_PERFCNT_INT_EN;
+		if (cfg[1].kernel)
+			ctrl |= LOONGSON_PERFCNT_KERNEL;
+		if (cfg[1].user)
+			ctrl |= LOONGSON_PERFCNT_USER;
+		reg.reset_counter2 = (0x80000000ULL - cfg[1].count);
+	}
+
+	if (cfg[0].enabled || cfg[1].enabled)
+		ctrl |= LOONGSON_PERFCNT_EXL;
+
+	reg.ctrl = ctrl;
+
+	reg.cnt1_enable = cfg[0].enabled;
+	reg.cnt2_enable = cfg[1].enabled;
+
+}
+
+/* Program all of the registers in preparation for enabling profiling.  */
+
+static void loongson2_cpu_setup(void *args)
+{
+	uint64_t perfcount;
+
+	perfcount = (reg.reset_counter2 << 32) | reg.reset_counter1;
+	write_c0_perfhi(perfcount);
+}
+
+static void loongson2_cpu_start(void *args)
+{
+	/* Start all counters on current CPU */
+	if (reg.cnt1_enable || reg.cnt2_enable)
+		write_c0_perflo(reg.ctrl);
+}
+
+static void loongson2_cpu_stop(void *args)
+{
+	/* Stop all counters on current CPU */
+	write_c0_perflo(0);
+	memset(&reg, 0, sizeof(reg));
+}
+
+static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
+{
+	uint64_t counter, counter1, counter2;
+	struct pt_regs *regs = get_irq_regs();
+	int enabled;
+	unsigned long flags;
+
+	/*
+	 * LOONGSON2 defines two 32-bit performance counters.
+	 * To avoid a race updating the registers we need to stop the counters
+	 * while we're messing with
+	 * them ...
+	 */
+
+	/* Check whether the irq belongs to me */
+	enabled = reg.cnt1_enable | reg.cnt2_enable;
+	if (!enabled)
+		return IRQ_NONE;
+
+	counter = read_c0_perfhi();
+	counter1 = counter & 0xffffffff;
+	counter2 = counter >> 32;
+
+	spin_lock_irqsave(&sample_lock, flags);
+
+	if (counter1 & LOONGSON_PERFCNT_OVERFLOW) {
+		if (reg.cnt1_enable)
+			oprofile_add_sample(regs, 0);
+		counter1 = reg.reset_counter1;
+	}
+	if (counter2 & LOONGSON_PERFCNT_OVERFLOW) {
+		if (reg.cnt2_enable)
+			oprofile_add_sample(regs, 1);
+		counter2 = reg.reset_counter2;
+	}
+
+	spin_unlock_irqrestore(&sample_lock, flags);
+
+	write_c0_perfhi((counter2 << 32) | counter1);
+
+	return IRQ_HANDLED;
+}
+
+static int __init loongson2_init(void)
+{
+	return request_irq(LOONGSON_PERFCNT_IRQ, loongson2_perfcount_handler,
+			   IRQF_SHARED, "Perfcounter", oprofid);
+}
+
+static void loongson2_exit(void)
+{
+	write_c0_perflo(0);
+	free_irq(LOONGSON_PERFCNT_IRQ, oprofid);
+}
+
+struct op_mips_model op_model_loongson2_ops = {
+	.reg_setup = loongson2_reg_setup,
+	.cpu_setup = loongson2_cpu_setup,
+	.init = loongson2_init,
+	.exit = loongson2_exit,
+	.cpu_start = loongson2_cpu_start,
+	.cpu_stop = loongson2_cpu_stop,
+	.cpu_type = LOONGSON_CPU_TYPE,
+	.num_counters = 2
+};
-- 
1.6.0.4
