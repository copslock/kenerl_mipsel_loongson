Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2011 08:19:07 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:46094 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491105Ab1JAGS4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2011 08:18:56 +0200
Received: by gyg13 with SMTP id 13so2546058gyg.36
        for <multiple recipients>; Fri, 30 Sep 2011 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=klyWNYQfqadrFJIISmSM/yAJlwgQy/oJz70EOEwGPjo=;
        b=aUAWCGs4hwYTs0E98FClDAbz3h+RBQvwnyNPzK3qIWdvi6+kB2ZWpMjiw2r/yDMWEa
         Tr3tRV95uWeVp8uxNzhyj6J2u36oVor52iu/0iCXLcAqNNi/2E0VrcpcZBPwdyI00/kH
         vVuTtDBhG6AvY7tQVyS/c8MS1ETk/GQXSDK9c=
MIME-Version: 1.0
Received: by 10.236.175.98 with SMTP id y62mr40047732yhl.78.1317449929361;
 Fri, 30 Sep 2011 23:18:49 -0700 (PDT)
Received: by 10.236.109.38 with HTTP; Fri, 30 Sep 2011 23:18:49 -0700 (PDT)
Date:   Sat, 1 Oct 2011 14:18:49 +0800
Message-ID: <CAJd=RBAkhesOGZiDEkQzzhGLmXVTV3=CrN9Bk9iwJULSnAT8sw@mail.gmail.com>
Subject: [RFC] activate performance counter registers on Netlogic XLR chip
From:   Hillf Danton <dhillf@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 119

On Netlogic XLR chip two pairs of performance counter registers,

   perf_ctrl0: c0 reg 25 sel 0, perf_cntr0: c0 reg 25 sel 1
   perf_ctrl1: c0 reg 25 sel 2, perf_cntr0: c0 reg 25 sel 3

provide a means for software to count processor events.

At most 64 events can be counted, such as,
   Instruction fetched and retired, branch instructions
   Instruction and Data Cache Unit statistics
   Instruction and Data TLB statistics
   Instruction Fetch Unit statistics
   Instruction Execution Unit statistics
   Load/store Unit statistics
   Cycle Count

They are activated based on the model of mips/74k, and
any comment is appreciated.

Thanks

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/oprofile/Makefile	Tue Jul 12 21:50:26 2011
+++ b/arch/mips/oprofile/Makefile	Sat Oct  1 13:44:28 2011
@@ -16,3 +16,4 @@ oprofile-$(CONFIG_CPU_R10000)		+= op_mod
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
 oprofile-$(CONFIG_CPU_LOONGSON2)	+= op_model_loongson2.o
+oprofile-$(CONFIG_CPU_XLR)		+= op_model_mipsxx.o
--- a/arch/mips/oprofile/common.c	Tue Jul 12 21:50:26 2011
+++ b/arch/mips/oprofile/common.c	Sat Oct  1 13:45:23 2011
@@ -89,6 +89,7 @@ int __init oprofile_arch_init(struct opr
 	case CPU_R10000:
 	case CPU_R12000:
 	case CPU_R14000:
+	case CPU_XLR:
 		lmodel = &op_model_mipsxx_ops;
 		break;

--- a/arch/mips/oprofile/op_model_mipsxx.c	Sat May 14 15:21:02 2011
+++ b/arch/mips/oprofile/op_model_mipsxx.c	Sat Oct  1 13:50:26 2011
@@ -19,7 +19,11 @@
 #define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
 #define M_PERFCTL_USER			(1UL      <<  3)
 #define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
+#ifdef CONFIG_CPU_XLR
+#define M_PERFCTL_EVENT(event)		((((event) & 0x3f)  << 5) | 0x2001)
+#else
 #define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
+#endif
 #define M_PERFCTL_VPEID(vpe)		((vpe)    << 16)
 #define M_PERFCTL_MT_EN(filter)		((filter) << 20)
 #define    M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
@@ -264,6 +268,7 @@ static inline int n_counters(void)

 	switch (current_cpu_type()) {
 	case CPU_R10000:
+	case CPU_XLR:
 		counters = 2;
 		break;

@@ -365,6 +370,9 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/sb1";
 		break;

+	case CPU_XLR:
+		op_model_mipsxx_ops.cpu_type = "mips/xlr";
+		break;
 	default:
 		printk(KERN_ERR "Profiling unsupported for this CPU\n");
