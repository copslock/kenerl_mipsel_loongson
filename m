Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:22:02 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:61112 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022894AbZEOWVz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:21:55 +0100
Received: by pxi17 with SMTP id 17so1370556pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:21:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=NXzblTi3uT26sxTCqyUnmZdcOzGcjw6RYBNVNkZq9SM=;
        b=E68fK8KN+C4ZYGHUYu8T85UrvNCZYdlL1BIb22Nvj0mLP13+lPu6fZTiW4s4yKXzQT
         qxGtmlrsVc/OhP55kS1fSyp91UEORSOftE7cfkORLUQutrk4g4lZ1mwwabJTGRFURE1C
         waHVeEuE2M2Ir+1dNDLPjGlUGA3xxqnv66Gaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=wonGGvrCCCx9hZPwCymgOKF4v94gaoi78xnoFzSrh6ybyrtCKtc/bCoSQa+WvqXEEF
         /1hEQUs1xnR79rOBHLcLX00OGSPTrJ7oVzlTkMaPJXPtrhhculuYJ9f6xDCtR15TLsNL
         xZT4vqoCTRpvQrFOh8JDnGhGYFAUrbNGUw648=
Received: by 10.115.110.6 with SMTP id n6mr5615516wam.227.1242426108618;
        Fri, 15 May 2009 15:21:48 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id j39sm1961426waf.10.2009.05.15.15.21.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:21:48 -0700 (PDT)
Subject: [PATCH 22/30] loongson: Loongson2 specific OProfile driver
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:21:42 +0800
Message-Id: <1242426102.10164.166.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 2f7d1f4ed962d5edcd63254f1a5d3913d6634c82 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:39:56 +0800
Subject: [PATCH 22/30] loongson: Loongson2 specific OProfile driver

Note: there are some conflicts between performance counters and CPU
count timers, so use a different system timer if you want to use
OProfile on loongson2 systems
---
 arch/mips/oprofile/Makefile             |    1 +
 arch/mips/oprofile/common.c             |    5 +
 arch/mips/oprofile/op_model_loongson2.c |  191
+++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/oprofile/op_model_loongson2.c

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
index 3bf3354..f0e79e3 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -16,6 +16,7 @@
 
 extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
 extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
+extern struct op_mips_model op_model_loongson2_ops
__attribute__((weak));
 
 static struct op_mips_model *model;
 
@@ -93,6 +94,10 @@ int __init oprofile_arch_init(struct
oprofile_operations *ops)
 	case CPU_RM9000:
 		lmodel = &op_model_rm9000_ops;
 		break;
+	
+	case CPU_LOONGSON2:
+		lmodel = &op_model_loongson2_ops;
+		break;
 	};
 
 	if (!lmodel)
diff --git a/arch/mips/oprofile/op_model_loongson2.c
b/arch/mips/oprofile/op_model_loongson2.c
new file mode 100644
index 0000000..d8ab47e
--- /dev/null
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -0,0 +1,191 @@
+/*
+ * Loongson2 performance counter driver for oprofile
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Yanhua <yanh@lemote.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
+ * for more details.
+ *
+ */
+#include <linux/init.h>
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+#include <irq.h>
+#include "op_impl.h"
+
+#define PERF_IRQ (MIPS_CPU_IRQ_BASE + 6 )
+
+#define LOONGSON_COUNTER1_EVENT(event)	((event&0x0f) << 5)
+#define LOONGSON_COUNTER1_SUPERVISOR	(1UL    <<  2)
+#define LOONGSON_COUNTER1_KERNEL	(1UL    <<  1)
+#define LOONGSON_COUNTER1_USER		(1UL    <<  3)
+#define LOONGSON_COUNTER1_ENABLE	(1UL    <<  4)
+#define LOONGSON_COUNTER1_OVERFLOW	(1ULL   << 31)
+#define LOONGSON_COUNTER1_EXL		(1UL	<<  0)
+
+#define LOONGSON_COUNTER2_EVENT(event)	((event&0x0f) << 9)
+#define LOONGSON_COUNTER2_SUPERVISOR	LOONGSON_COUNTER1_SUPERVISOR
+#define LOONGSON_COUNTER2_KERNEL	LOONGSON_COUNTER1_KERNEL
+#define LOONGSON_COUNTER2_USER		LOONGSON_COUNTER1_USER
+#define LOONGSON_COUNTER2_ENABLE	LOONGSON_COUNTER1_ENABLE
+#define LOONGSON_COUNTER2_OVERFLOW	LOONGSON_COUNTER1_OVERFLOW
+#define LOONGSON_COUNTER2_EXL		LOONGSON_COUNTER1_EXL
+#define LOONGSON_COUNTER_EXL		LOONGSON_COUNTER1_EXL
+
+/* Loongson2 PerfCount performance counter register */
+#define read_c0_perflo() __read_64bit_c0_register($24, 0)
+#define write_c0_perflo(val) __write_64bit_c0_register($24, 0, val)
+#define read_c0_perfhi() __read_64bit_c0_register($25, 0)
+#define write_c0_perfhi(val) __write_64bit_c0_register($25, 0, val)
+
+extern unsigned int loongson2_perfcount_irq;
+
+static struct loongson2_register_config {
+	unsigned int control;
+	unsigned long long reset_counter1;
+	unsigned long long reset_counter2;
+	int ctr1_enable, ctr2_enable;
+} reg;
+
+DEFINE_SPINLOCK(sample_lock);
+
+static char *oprofid = "LoongsonPerf";
+static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id);
+/* Compute all of the registers in preparation for enabling profiling.
*/
+
+static void loongson2_reg_setup(struct op_counter_config *ctr)
+{
+	unsigned int control = 0;
+
+	reg.reset_counter1 = 0;
+	reg.reset_counter2 = 0;
+	/* Compute the performance counter control word.  */
+	/* For now count kernel and user mode */
+	if (ctr[0].enabled) {
+		control |= LOONGSON_COUNTER1_EVENT(ctr[0].event) |
+		    LOONGSON_COUNTER1_ENABLE;
+		if (ctr[0].kernel)
+			control |= LOONGSON_COUNTER1_KERNEL;
+		if (ctr[0].user)
+			control |= LOONGSON_COUNTER1_USER;
+		reg.reset_counter1 = 0x80000000ULL - ctr[0].count;
+	}
+
+	if (ctr[1].enabled) {
+		control |= LOONGSON_COUNTER2_EVENT(ctr[1].event) |
+		    LOONGSON_COUNTER2_ENABLE;
+		if (ctr[1].kernel)
+			control |= LOONGSON_COUNTER2_KERNEL;
+		if (ctr[1].user)
+			control |= LOONGSON_COUNTER2_USER;
+		reg.reset_counter2 = (0x80000000ULL - ctr[1].count);
+	}
+
+	if (ctr[0].enabled || ctr[1].enabled)
+		control |= LOONGSON_COUNTER_EXL;
+
+	reg.control = control;
+
+	reg.ctr1_enable = ctr[0].enabled;
+	reg.ctr2_enable = ctr[1].enabled;
+
+}
+
+/* Program all of the registers in preparation for enabling profiling.
*/
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
+	if (reg.ctr1_enable || reg.ctr2_enable) {
+		write_c0_perflo(reg.control);
+	}
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
+	 * To avoid a race updating the registers we need to stop the
counters 
+	 * while we're messing with
+	 * them ...
+	 */
+
+	/* Check whether the irq belongs to me */
+	enabled = reg.ctr1_enable | reg.ctr2_enable;
+	if (!enabled) {
+		return IRQ_NONE;
+	}
+
+	counter = read_c0_perfhi();
+	counter1 = counter & 0xffffffff;
+	counter2 = counter >> 32;
+
+	spin_lock_irqsave(&sample_lock, flags);
+
+	if (counter1 & LOONGSON_COUNTER1_OVERFLOW) {
+		if (reg.ctr1_enable)
+			oprofile_add_sample(regs, 0);
+		counter1 = reg.reset_counter1;
+	}
+	if (counter2 & LOONGSON_COUNTER2_OVERFLOW) {
+		if (reg.ctr2_enable)
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
+	return request_irq(PERF_IRQ, loongson2_perfcount_handler,
+			   IRQF_SHARED, "Perfcounter", oprofid);
+}
+
+static void loongson2_exit(void)
+{
+	write_c0_perflo(0);
+	free_irq(PERF_IRQ, oprofid);
+}
+
+struct op_mips_model op_model_loongson2_ops = {
+	.reg_setup = loongson2_reg_setup,
+	.cpu_setup = loongson2_cpu_setup,
+	.init = loongson2_init,
+	.exit = loongson2_exit,
+	.cpu_start = loongson2_cpu_start,
+	.cpu_stop = loongson2_cpu_stop,
+	.cpu_type = "mips/loongson2",
+	.num_counters = 2
+};
-- 
1.6.2.1
