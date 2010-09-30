Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 11:09:49 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:49126 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491151Ab0I3JJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 11:09:06 +0200
Received: by mail-pw0-f49.google.com with SMTP id 5so597054pwi.36
        for <multiple recipients>; Thu, 30 Sep 2010 02:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FGrEz097UCw+ocGwOJbmEgAD58v2meXw+e+N5hzyQ9E=;
        b=bU0qzC3PQsf7kgiDTHL4VljrPo7gfBZZgsAwZFhFTBxolpzFubqvxLyZW4TsYZK3CP
         M+OPXldiVxdBIOtrdBRQpLB04D+cNAD4q7NFZJUrWrBq7bcHZ/DJt6yvNCKfD1/A918o
         npVYmXdQDa5wN1VErHTacB8B/x+fiAXO+M0BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TgAkY0SPxsqu7lN0dqoNivKU6wBeRNqbhIqEuk4L2YJUKhnjujPUwFi9Gr35JNvm+I
         Zkhmyt1nWiNeFqBDCfMCQd7O+6pg35wyy2Fi5tEHy5PlDMrCK4AeX10GDVYqX1WErFx3
         +wTU4ujFdPslOhla5Wpbl2O3xAWTCEcNZMAKg=
Received: by 10.114.109.9 with SMTP id h9mr3710493wac.211.1285837745604;
        Thu, 30 Sep 2010 02:09:05 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id c10sm16210348wam.1.2010.09.30.02.08.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 02:09:01 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, dengcheng.zhu@gmail.com
Subject: [PATCH v7 2/6] MIPS/Oprofile: extract PMU defines for sharing
Date:   Thu, 30 Sep 2010 17:09:16 +0800
Message-Id: <1285837760-10362-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24019

Moving performance counter/control defines into a single header file, so
that software using the MIPS PMU can share the code.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/pmu.h             |   78 +++++++++++++++++++++++++++++++
 arch/mips/oprofile/op_model_loongson2.c |   18 +-------
 arch/mips/oprofile/op_model_mipsxx.c    |   21 +--------
 arch/mips/oprofile/op_model_rm9000.c    |   16 +------
 4 files changed, 82 insertions(+), 51 deletions(-)
 create mode 100644 arch/mips/include/asm/pmu.h

diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
new file mode 100644
index 0000000..8d39c90
--- /dev/null
+++ b/arch/mips/include/asm/pmu.h
@@ -0,0 +1,78 @@
+/*
+ * linux/arch/mips/include/asm/pmu.h
+ *
+ * Copyright (C) 2004, 05, 06 by Ralf Baechle
+ * Copyright (C) 2005 by MIPS Technologies, Inc.
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Yanhua <yanh@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
+ * Copyright (C) 2010 MIPS Technologies, Inc.
+ * Author: Deng-Cheng Zhu (move things from Oprofile to common place)
+ *
+ * This file is shared by Oprofile and Perf. It is also shared across the
+ * Oprofile implementation for different MIPS CPUs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MIPS_PMU_H__
+#define __MIPS_PMU_H__
+
+/* mipsxx */
+#define M_CONFIG1_PC	(1 << 4)
+
+#define M_PERFCTL_EXL			(1UL      <<  0)
+#define M_PERFCTL_KERNEL		(1UL      <<  1)
+#define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
+#define M_PERFCTL_USER			(1UL      <<  3)
+#define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
+#define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
+#define M_PERFCTL_VPEID(vpe)		((vpe)    << 16)
+#define M_PERFCTL_MT_EN(filter)		((filter) << 20)
+#define    M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
+#define    M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
+#define    M_TC_EN_TC			M_PERFCTL_MT_EN(2)
+#define M_PERFCTL_TCID(tcid)		((tcid)   << 22)
+#define M_PERFCTL_WIDE			(1UL      << 30)
+#define M_PERFCTL_MORE			(1UL      << 31)
+
+#define M_COUNTER_OVERFLOW		(1UL      << 31)
+
+/* rm9000 */
+#define RM9K_COUNTER1_EVENT(event)	((event) << 0)
+#define RM9K_COUNTER1_SUPERVISOR	(1ULL    <<  7)
+#define RM9K_COUNTER1_KERNEL		(1ULL    <<  8)
+#define RM9K_COUNTER1_USER		(1ULL    <<  9)
+#define RM9K_COUNTER1_ENABLE		(1ULL    << 10)
+#define RM9K_COUNTER1_OVERFLOW		(1ULL    << 15)
+
+#define RM9K_COUNTER2_EVENT(event)	((event) << 16)
+#define RM9K_COUNTER2_SUPERVISOR	(1ULL    << 23)
+#define RM9K_COUNTER2_KERNEL		(1ULL    << 24)
+#define RM9K_COUNTER2_USER		(1ULL    << 25)
+#define RM9K_COUNTER2_ENABLE		(1ULL    << 26)
+#define RM9K_COUNTER2_OVERFLOW		(1ULL    << 31)
+
+extern unsigned int rm9000_perfcount_irq;
+
+/* loongson2 */
+#define LOONGSON2_CPU_TYPE	"mips/loongson2"
+
+#define LOONGSON2_PERFCNT_OVERFLOW		(1ULL   << 31)
+
+#define LOONGSON2_PERFCTRL_EXL			(1UL	<<  0)
+#define LOONGSON2_PERFCTRL_KERNEL		(1UL    <<  1)
+#define LOONGSON2_PERFCTRL_SUPERVISOR		(1UL    <<  2)
+#define LOONGSON2_PERFCTRL_USER			(1UL    <<  3)
+#define LOONGSON2_PERFCTRL_ENABLE		(1UL    <<  4)
+#define LOONGSON2_PERFCTRL_EVENT(idx, event) \
+	(((event) & 0x0f) << ((idx) ? 9 : 5))
+
+#define read_c0_perfctrl() __read_64bit_c0_register($24, 0)
+#define write_c0_perfctrl(val) __write_64bit_c0_register($24, 0, val)
+#define read_c0_perfcnt() __read_64bit_c0_register($25, 0)
+#define write_c0_perfcnt(val) __write_64bit_c0_register($25, 0, val)
+
+#endif /* __MIPS_PMU_H__ */
diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 60d3ea6..665e994 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -12,27 +12,11 @@
 #include <linux/init.h>
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
+#include <asm/pmu.h>
 
 #include <loongson.h>			/* LOONGSON2_PERFCNT_IRQ */
 #include "op_impl.h"
 
-#define LOONGSON2_CPU_TYPE	"mips/loongson2"
-
-#define LOONGSON2_PERFCNT_OVERFLOW		(1ULL   << 31)
-
-#define LOONGSON2_PERFCTRL_EXL			(1UL	<<  0)
-#define LOONGSON2_PERFCTRL_KERNEL		(1UL    <<  1)
-#define LOONGSON2_PERFCTRL_SUPERVISOR		(1UL    <<  2)
-#define LOONGSON2_PERFCTRL_USER			(1UL    <<  3)
-#define LOONGSON2_PERFCTRL_ENABLE		(1UL    <<  4)
-#define LOONGSON2_PERFCTRL_EVENT(idx, event) \
-	(((event) & 0x0f) << ((idx) ? 9 : 5))
-
-#define read_c0_perfctrl() __read_64bit_c0_register($24, 0)
-#define write_c0_perfctrl(val) __write_64bit_c0_register($24, 0, val)
-#define read_c0_perfcnt() __read_64bit_c0_register($25, 0)
-#define write_c0_perfcnt(val) __write_64bit_c0_register($25, 0, val)
-
 static struct loongson2_register_config {
 	unsigned int ctrl;
 	unsigned long long reset_counter1;
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..3c7c5e9 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -11,29 +11,14 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <asm/irq_regs.h>
+#include <asm/pmu.h>
 
 #include "op_impl.h"
 
-#define M_PERFCTL_EXL			(1UL      <<  0)
-#define M_PERFCTL_KERNEL		(1UL      <<  1)
-#define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
-#define M_PERFCTL_USER			(1UL      <<  3)
-#define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
-#define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
-#define M_PERFCTL_VPEID(vpe)		((vpe)    << 16)
-#define M_PERFCTL_MT_EN(filter)		((filter) << 20)
-#define    M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
-#define    M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
-#define    M_TC_EN_TC			M_PERFCTL_MT_EN(2)
-#define M_PERFCTL_TCID(tcid)		((tcid)   << 22)
-#define M_PERFCTL_WIDE			(1UL      << 30)
-#define M_PERFCTL_MORE			(1UL      << 31)
-
-#define M_COUNTER_OVERFLOW		(1UL      << 31)
-
 static int (*save_perf_irq)(void);
 
 #ifdef CONFIG_MIPS_MT_SMP
+
 static int cpu_has_mipsmt_pertccounters;
 #define WHAT		(M_TC_EN_VPE | \
 			 M_PERFCTL_VPEID(cpu_data[smp_processor_id()].vpe_id))
@@ -242,8 +227,6 @@ static int mipsxx_perfcount_handler(void)
 	return handled;
 }
 
-#define M_CONFIG1_PC	(1 << 4)
-
 static inline int __n_counters(void)
 {
 	if (!(read_c0_config1() & M_CONFIG1_PC))
diff --git a/arch/mips/oprofile/op_model_rm9000.c b/arch/mips/oprofile/op_model_rm9000.c
index 3aa8138..48e7487 100644
--- a/arch/mips/oprofile/op_model_rm9000.c
+++ b/arch/mips/oprofile/op_model_rm9000.c
@@ -9,24 +9,10 @@
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <asm/pmu.h>
 
 #include "op_impl.h"
 
-#define RM9K_COUNTER1_EVENT(event)	((event) << 0)
-#define RM9K_COUNTER1_SUPERVISOR	(1ULL    <<  7)
-#define RM9K_COUNTER1_KERNEL		(1ULL    <<  8)
-#define RM9K_COUNTER1_USER		(1ULL    <<  9)
-#define RM9K_COUNTER1_ENABLE		(1ULL    << 10)
-#define RM9K_COUNTER1_OVERFLOW		(1ULL    << 15)
-
-#define RM9K_COUNTER2_EVENT(event)	((event) << 16)
-#define RM9K_COUNTER2_SUPERVISOR	(1ULL    << 23)
-#define RM9K_COUNTER2_KERNEL		(1ULL    << 24)
-#define RM9K_COUNTER2_USER		(1ULL    << 25)
-#define RM9K_COUNTER2_ENABLE		(1ULL    << 26)
-#define RM9K_COUNTER2_OVERFLOW		(1ULL    << 31)
-
-extern unsigned int rm9000_perfcount_irq;
 
 static struct rm9k_register_config {
 	unsigned int control;
-- 
1.7.0.4
