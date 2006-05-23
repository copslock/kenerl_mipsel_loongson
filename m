Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 09:42:57 +0200 (CEST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:43146 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133404AbWEWHms (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 May 2006 09:42:48 +0200
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 23 May 2006 16:42:46 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 244BE2054E;
	Tue, 23 May 2006 16:42:39 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 11E15204EF;
	Tue, 23 May 2006 16:42:39 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k4N7gciX007260;
	Tue, 23 May 2006 16:42:39 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 23 May 2006 16:42:38 +0900 (JST)
Message-Id: <20060523.164238.118967808.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rename op_model_xxx to op_model_xxx_ops
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Addpoint-Spam: 0.00
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The modpost uses a whitelist for commonly used suffix on checking the
section mismatch.  Adding "_ops" suffix to op_modex_xxx get rid of
this modpost warning.

WARNING: arch/mips/oprofile/oprofile.o - Section mismatch: reference to .init.text: from .data after 'op_model_mipsxx' (at offset 0x528)


Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 91b799d..c31e4cf 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -14,8 +14,8 @@ #include <asm/cpu-info.h>
 
 #include "op_impl.h"
 
-extern struct op_mips_model op_model_mipsxx __attribute__((weak));
-extern struct op_mips_model op_model_rm9000 __attribute__((weak));
+extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
+extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
 
 static struct op_mips_model *model;
 
@@ -83,11 +83,11 @@ int __init oprofile_arch_init(struct opr
 	case CPU_74K:
 	case CPU_SB1:
 	case CPU_SB1A:
-		lmodel = &op_model_mipsxx;
+		lmodel = &op_model_mipsxx_ops;
 		break;
 
 	case CPU_RM9000:
-		lmodel = &op_model_rm9000;
+		lmodel = &op_model_rm9000_ops;
 		break;
 	};
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index e7ce923..f26a00e 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -23,7 +23,7 @@ #define M_PERFCTL_MORE			(1UL    << 31)
 
 #define M_COUNTER_OVERFLOW		(1UL    << 31)
 
-struct op_mips_model op_model_mipsxx;
+struct op_mips_model op_model_mipsxx_ops;
 
 static struct mipsxx_register_config {
 	unsigned int control[4];
@@ -34,7 +34,7 @@ static struct mipsxx_register_config {
 
 static void mipsxx_reg_setup(struct op_counter_config *ctr)
 {
-	unsigned int counters = op_model_mipsxx.num_counters;
+	unsigned int counters = op_model_mipsxx_ops.num_counters;
 	int i;
 
 	/* Compute the performance counter control word.  */
@@ -62,7 +62,7 @@ static void mipsxx_reg_setup(struct op_c
 
 static void mipsxx_cpu_setup (void *args)
 {
-	unsigned int counters = op_model_mipsxx.num_counters;
+	unsigned int counters = op_model_mipsxx_ops.num_counters;
 
 	switch (counters) {
 	case 4:
@@ -83,7 +83,7 @@ static void mipsxx_cpu_setup (void *args
 /* Start all counters on current CPU */
 static void mipsxx_cpu_start(void *args)
 {
-	unsigned int counters = op_model_mipsxx.num_counters;
+	unsigned int counters = op_model_mipsxx_ops.num_counters;
 
 	switch (counters) {
 	case 4:
@@ -100,7 +100,7 @@ static void mipsxx_cpu_start(void *args)
 /* Stop all counters on current CPU */
 static void mipsxx_cpu_stop(void *args)
 {
-	unsigned int counters = op_model_mipsxx.num_counters;
+	unsigned int counters = op_model_mipsxx_ops.num_counters;
 
 	switch (counters) {
 	case 4:
@@ -116,7 +116,7 @@ static void mipsxx_cpu_stop(void *args)
 
 static int mipsxx_perfcount_handler(struct pt_regs *regs)
 {
-	unsigned int counters = op_model_mipsxx.num_counters;
+	unsigned int counters = op_model_mipsxx_ops.num_counters;
 	unsigned int control;
 	unsigned int counter;
 	int handled = 0;
@@ -187,37 +187,37 @@ static int __init mipsxx_init(void)
 
 	reset_counters(counters);
 
-	op_model_mipsxx.num_counters = counters;
+	op_model_mipsxx_ops.num_counters = counters;
 	switch (current_cpu_data.cputype) {
 	case CPU_20KC:
-		op_model_mipsxx.cpu_type = "mips/20K";
+		op_model_mipsxx_ops.cpu_type = "mips/20K";
 		break;
 
 	case CPU_24K:
-		op_model_mipsxx.cpu_type = "mips/24K";
+		op_model_mipsxx_ops.cpu_type = "mips/24K";
 		break;
 
 	case CPU_25KF:
-		op_model_mipsxx.cpu_type = "mips/25K";
+		op_model_mipsxx_ops.cpu_type = "mips/25K";
 		break;
 
 #ifndef CONFIG_SMP
 	case CPU_34K:
-		op_model_mipsxx.cpu_type = "mips/34K";
+		op_model_mipsxx_ops.cpu_type = "mips/34K";
 		break;
 
 	case CPU_74K:
-		op_model_mipsxx.cpu_type = "mips/74K";
+		op_model_mipsxx_ops.cpu_type = "mips/74K";
 		break;
 #endif
 
 	case CPU_5KC:
-		op_model_mipsxx.cpu_type = "mips/5K";
+		op_model_mipsxx_ops.cpu_type = "mips/5K";
 		break;
 
 	case CPU_SB1:
 	case CPU_SB1A:
-		op_model_mipsxx.cpu_type = "mips/sb1";
+		op_model_mipsxx_ops.cpu_type = "mips/sb1";
 		break;
 
 	default:
@@ -233,12 +233,12 @@ #endif
 
 static void mipsxx_exit(void)
 {
-	reset_counters(op_model_mipsxx.num_counters);
+	reset_counters(op_model_mipsxx_ops.num_counters);
 
 	perf_irq = null_perf_irq;
 }
 
-struct op_mips_model op_model_mipsxx = {
+struct op_mips_model op_model_mipsxx_ops = {
 	.reg_setup	= mipsxx_reg_setup,
 	.cpu_setup	= mipsxx_cpu_setup,
 	.init		= mipsxx_init,
diff --git a/arch/mips/oprofile/op_model_rm9000.c b/arch/mips/oprofile/op_model_rm9000.c
index 9b75e41..b7063fe 100644
--- a/arch/mips/oprofile/op_model_rm9000.c
+++ b/arch/mips/oprofile/op_model_rm9000.c
@@ -126,7 +126,7 @@ static void rm9000_exit(void)
 	free_irq(rm9000_perfcount_irq, NULL);
 }
 
-struct op_mips_model op_model_rm9000 = {
+struct op_mips_model op_model_rm9000_ops = {
 	.reg_setup	= rm9000_reg_setup,
 	.cpu_setup	= rm9000_cpu_setup,
 	.init		= rm9000_init,
