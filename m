Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:16:44 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52076 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011073AbaKDGP2pmS8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:15:28 +0100
Received: by mail-pa0-f47.google.com with SMTP id kx10so13765566pab.20
        for <multiple recipients>; Mon, 03 Nov 2014 22:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LJpqLrWmsnkjsHZLNKTu8dEqBW+8jSY3FxjVtlJZJkI=;
        b=DD/PW1Cyhyq8s1MSed57r37QGPtMOocxf5beOHob/tktx78wZH6igok/TLFrt4Bjp2
         BXPtT/f1acpeT0Njh+GSXpWSc6EeES0aW4vMK0IktNhLbijTqMa6iKrClB81qhHjLDnj
         crjZ5tIhlco6JpbSTST9ViNz7pT4ajR+pxbEXvytUdyAb23skZLWfUzZUS5571QWzIfU
         Xeh4ZDFBMezMScDMZR3hcfI+5LSZGf3YxcKf0q9ECRNwZIlt3Q21wb7LiyYdHbGvyLiM
         HMEoCtSM5KPI7Su3QM7b/MJVGFaMv9olSQArejOQTE04eWpEriCv1U9/ffqBjgAC6wnv
         DXBA==
X-Received: by 10.68.211.193 with SMTP id ne1mr27363681pbc.49.1415081722480;
        Mon, 03 Nov 2014 22:15:22 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id bz3sm3423506pab.41.2014.11.03.22.15.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:15:22 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 10/12] MIPS: Loongson-3: Add oprofile support
Date:   Tue,  4 Nov 2014 14:15:07 +0800
Message-Id: <1415081707-25753-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43859
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

Loongson-3 has two groups of performance counters, they are 4 sub-
registers of CP0's REG25. This patch add oprofile support.

REG25, sel 0: Perf Control of group 0;
REG25, sel 1: Perf Counter of group 0;
REG25, sel 2: Perf Control of group 1;
REG25, sel 3: Perf Counter of group 1.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/oprofile/Makefile             |    1 +
 arch/mips/oprofile/common.c             |    4 +
 arch/mips/oprofile/op_model_loongson3.c |  220 +++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/oprofile/op_model_loongson3.c

diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index 9c0a678..070afdb 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -14,3 +14,4 @@ oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_XLR)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_LOONGSON2)	+= op_model_loongson2.o
+oprofile-$(CONFIG_CPU_LOONGSON3)	+= op_model_loongson3.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index e747324..feb9879 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -18,6 +18,7 @@
 
 extern struct op_mips_model op_model_mipsxx_ops __weak;
 extern struct op_mips_model op_model_loongson2_ops __weak;
+extern struct op_mips_model op_model_loongson3_ops __weak;
 
 static struct op_mips_model *model;
 
@@ -104,6 +105,9 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_LOONGSON2:
 		lmodel = &op_model_loongson2_ops;
 		break;
+	case CPU_LOONGSON3:
+		lmodel = &op_model_loongson3_ops;
+		break;
 	};
 
 	if (!lmodel)
diff --git a/arch/mips/oprofile/op_model_loongson3.c b/arch/mips/oprofile/op_model_loongson3.c
new file mode 100644
index 0000000..8bcf7fc
--- /dev/null
+++ b/arch/mips/oprofile/op_model_loongson3.c
@@ -0,0 +1,220 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/proc_fs.h>
+#include <linux/oprofile.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <asm/uaccess.h>
+#include <irq.h>
+#include <loongson.h>
+#include "op_impl.h"
+
+#define LOONGSON3_PERFCNT_OVERFLOW	(1ULL << 63)
+
+#define LOONGSON3_PERFCTRL_EXL		(1UL << 0)
+#define LOONGSON3_PERFCTRL_KERNEL	(1UL << 1)
+#define LOONGSON3_PERFCTRL_SUPERVISOR	(1UL << 2)
+#define LOONGSON3_PERFCTRL_USER		(1UL << 3)
+#define LOONGSON3_PERFCTRL_ENABLE	(1UL << 4)
+#define LOONGSON3_PERFCTRL_W		(1UL << 30)
+#define LOONGSON3_PERFCTRL_M		(1UL << 31)
+#define LOONGSON3_PERFCTRL_EVENT(idx, event) \
+	(((event) & (idx ? 0x0f : 0x3f)) << 5)
+
+/* Loongson-3 PerfCount performance counter1 register */
+#define read_c0_perflo1() __read_64bit_c0_register($25, 0)
+#define write_c0_perflo1(val) __write_64bit_c0_register($25, 0, val)
+#define read_c0_perfhi1() __read_64bit_c0_register($25, 1)
+#define write_c0_perfhi1(val) __write_64bit_c0_register($25, 1, val)
+
+/* Loongson-3 PerfCount performance counter2 register */
+#define read_c0_perflo2() __read_64bit_c0_register($25, 2)
+#define write_c0_perflo2(val) __write_64bit_c0_register($25, 2, val)
+#define read_c0_perfhi2() __read_64bit_c0_register($25, 3)
+#define write_c0_perfhi2(val) __write_64bit_c0_register($25, 3, val)
+
+static int (*save_perf_irq)(void);
+
+static struct loongson3_register_config {
+	unsigned int control1;
+	unsigned int control2;
+	unsigned long long reset_counter1;
+	unsigned long long reset_counter2;
+	int ctr1_enable, ctr2_enable;
+} reg;
+
+static void reset_counters(void *arg)
+{
+	write_c0_perfhi1(0);
+	write_c0_perfhi2(0);
+	write_c0_perflo1(0xc0000000);
+	write_c0_perflo2(0x40000000);
+}
+
+/* Compute all of the registers in preparation for enabling profiling. */
+static void loongson3_reg_setup(struct op_counter_config *ctr)
+{
+	unsigned int control1 = 0;
+	unsigned int control2 = 0;
+
+	reg.reset_counter1 = 0;
+	reg.reset_counter2 = 0;
+	/* Compute the performance counter control word. */
+	/* For now count kernel and user mode */
+	if (ctr[0].enabled) {
+		control1 |= LOONGSON3_PERFCTRL_EVENT(0, ctr[0].event) |
+					LOONGSON3_PERFCTRL_ENABLE;
+		if (ctr[0].kernel)
+			control1 |= LOONGSON3_PERFCTRL_KERNEL;
+		if (ctr[0].user)
+			control1 |= LOONGSON3_PERFCTRL_USER;
+		reg.reset_counter1 = 0x8000000000000000ULL - ctr[0].count;
+	}
+
+	if (ctr[1].enabled) {
+		control2 |= LOONGSON3_PERFCTRL_EVENT(1, ctr[1].event) |
+					LOONGSON3_PERFCTRL_ENABLE;
+		if (ctr[1].kernel)
+			control2 |= LOONGSON3_PERFCTRL_KERNEL;
+		if (ctr[1].user)
+			control2 |= LOONGSON3_PERFCTRL_USER;
+		reg.reset_counter2 = 0x8000000000000000ULL - ctr[1].count;
+	}
+
+	if (ctr[0].enabled)
+		control1 |= LOONGSON3_PERFCTRL_EXL;
+	if (ctr[1].enabled)
+		control2 |= LOONGSON3_PERFCTRL_EXL;
+
+	reg.control1 = control1;
+	reg.control2 = control2;
+	reg.ctr1_enable = ctr[0].enabled;
+	reg.ctr2_enable = ctr[1].enabled;
+}
+
+/* Program all of the registers in preparation for enabling profiling. */
+static void loongson3_cpu_setup(void *args)
+{
+	uint64_t perfcount1, perfcount2;
+
+	perfcount1 = reg.reset_counter1;
+	perfcount2 = reg.reset_counter2;
+	write_c0_perfhi1(perfcount1);
+	write_c0_perfhi2(perfcount2);
+}
+
+static void loongson3_cpu_start(void *args)
+{
+	/* Start all counters on current CPU */
+	reg.control1 |= (LOONGSON3_PERFCTRL_W|LOONGSON3_PERFCTRL_M);
+	reg.control2 |= (LOONGSON3_PERFCTRL_W|LOONGSON3_PERFCTRL_M);
+
+	if (reg.ctr1_enable)
+		write_c0_perflo1(reg.control1);
+	if (reg.ctr2_enable)
+		write_c0_perflo2(reg.control2);
+}
+
+static void loongson3_cpu_stop(void *args)
+{
+	/* Stop all counters on current CPU */
+	write_c0_perflo1(0xc0000000);
+	write_c0_perflo2(0x40000000);
+	memset(&reg, 0, sizeof(reg));
+}
+
+static int loongson3_perfcount_handler(void)
+{
+	unsigned long flags;
+	uint64_t counter1, counter2;
+	uint32_t cause, handled = IRQ_NONE;
+	struct pt_regs *regs = get_irq_regs();
+
+	cause = read_c0_cause();
+	if (!(cause & CAUSEF_PCI))
+		return handled;
+
+	counter1 = read_c0_perfhi1();
+	counter2 = read_c0_perfhi2();
+
+	local_irq_save(flags);
+
+	if (counter1 & LOONGSON3_PERFCNT_OVERFLOW) {
+		if (reg.ctr1_enable)
+			oprofile_add_sample(regs, 0);
+		counter1 = reg.reset_counter1;
+	}
+	if (counter2 & LOONGSON3_PERFCNT_OVERFLOW) {
+		if (reg.ctr2_enable)
+			oprofile_add_sample(regs, 1);
+		counter2 = reg.reset_counter2;
+	}
+
+	local_irq_restore(flags);
+
+	write_c0_perfhi1(counter1);
+	write_c0_perfhi2(counter2);
+
+	if (!(cause & CAUSEF_TI))
+		handled = IRQ_HANDLED;
+
+	return handled;
+}
+
+static int loongson3_cpu_callback(struct notifier_block *nfb,
+	unsigned long action, void *hcpu)
+{
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		write_c0_perflo1(reg.control1);
+		write_c0_perflo2(reg.control2);
+		break;
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		write_c0_perflo1(0xc0000000);
+		write_c0_perflo2(0x40000000);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block loongson3_notifier_block = {
+	.notifier_call = loongson3_cpu_callback
+};
+
+static int __init loongson3_init(void)
+{
+	on_each_cpu(reset_counters, NULL, 1);
+	register_hotcpu_notifier(&loongson3_notifier_block);
+	save_perf_irq = perf_irq;
+	perf_irq = loongson3_perfcount_handler;
+
+	return 0;
+}
+
+static void loongson3_exit(void)
+{
+	on_each_cpu(reset_counters, NULL, 1);
+	unregister_hotcpu_notifier(&loongson3_notifier_block);
+	perf_irq = save_perf_irq;
+}
+
+struct op_mips_model op_model_loongson3_ops = {
+	.reg_setup	= loongson3_reg_setup,
+	.cpu_setup	= loongson3_cpu_setup,
+	.init		= loongson3_init,
+	.exit		= loongson3_exit,
+	.cpu_start	= loongson3_cpu_start,
+	.cpu_stop	= loongson3_cpu_stop,
+	.cpu_type	= "mips/loongson3",
+	.num_counters	= 2
+};
-- 
1.7.7.3
