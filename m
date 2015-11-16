Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 15:35:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48045 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012751AbbKPOf0Bh6rR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 15:35:26 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 8BD1F79264D34;
        Mon, 16 Nov 2015 14:35:16 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Mon, 16 Nov 2015
 14:35:18 +0000
Date:   Mon, 16 Nov 2015 14:35:17 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/4] prctl: Add MIPS IEEE Std 754 compliance mode
 switching
In-Reply-To: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511161413370.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Implement the prctl(2) interface for IEEE Std 754 NaN interlinking, as 
per "MIPS ABI Extension for IEEE Std 754 Non-Compliant Interlinking" 
<https://dmz-portal.mips.com/wiki/MIPS_ABI_-_NaN_Interlinking>:

* interpret the PR_SET_IEEE754_MODE request,

* accept or reject the new mode requested according to FP hardware or
  emulator capabilities and any `ieee754=' kernel parameter in effect,

* set the values of the FCSR ABS2008 and NAN2008 bits according to the
  NaN encoding requested, either PR_IEEE754_MODE_NAN_LEGACY or 
  PR_IEEE754_MODE_NAN_2008, if writable,

* on success return bits 31:24 of the auxiliary vector's AT_FLAGS value 
  corresponding to the new mode in effect, in bits 7:0 of the result.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-nan-interlink-prctl.diff
Index: linux-sfr-test/arch/mips/include/asm/processor.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/processor.h	2015-11-11 12:34:46.131650000 +0000
+++ linux-sfr-test/arch/mips/include/asm/processor.h	2015-11-11 13:14:09.208745000 +0000
@@ -402,4 +402,13 @@ extern int mips_set_process_fp_mode(stru
 #define GET_FP_MODE(task)		mips_get_process_fp_mode(task)
 #define SET_FP_MODE(task,value)		mips_set_process_fp_mode(task, value)
 
+/*
+ * Likewise the PR_SET_IEEE754_MODE option.
+ */
+extern int mips_set_process_ieee754_mode(struct task_struct *task,
+					 unsigned int mode, unsigned int what);
+
+#define SET_IEEE754_MODE(task, mode, what) \
+	mips_set_process_ieee754_mode((task), (mode), (what))
+
 #endif /* _ASM_PROCESSOR_H */
Index: linux-sfr-test/arch/mips/kernel/process.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/process.c	2015-11-11 12:34:46.154646000 +0000
+++ linux-sfr-test/arch/mips/kernel/process.c	2015-11-11 13:17:14.564231000 +0000
@@ -9,6 +9,7 @@
  * Copyright (C) 2004 Thiemo Seufer
  * Copyright (C) 2013  Imagination Technologies Ltd.
  */
+#include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/tick.h>
@@ -39,7 +40,6 @@
 #include <asm/reg.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/elf.h>
 #include <asm/isadep.h>
 #include <asm/inst.h>
 #include <asm/stacktrace.h>
@@ -682,3 +682,76 @@ int mips_set_process_fp_mode(struct task
 
 	return 0;
 }
+
+/*
+ * Set the process's IEEE 754 compliance mode according to MODE, either
+ * strict or relaxed, affecting WHAT, either legacy or 2008 NaN.  On
+ * success return an updated bit pattern as in bits 31:24 of the value
+ * of of of the AT_FLAGS auxiliary vector entry upon program startup,
+ * shifted into bits 7:0 of the result.
+ */
+int mips_set_process_ieee754_mode(struct task_struct *task,
+				  unsigned int mode, unsigned int what)
+{
+	struct cpuinfo_mips *c = &boot_cpu_data;
+	struct task_struct *t;
+	bool nan_2008;
+	bool relaxed;
+
+	switch (mode) {
+	case PR_IEEE754_MODE_LEGACY:
+		relaxed = mips_default_ieee754_relaxed;
+		break;
+	case PR_IEEE754_MODE_STRICT:
+		relaxed = false;
+		break;
+	case PR_IEEE754_MODE_RELAXED:
+		if (mips_accept_ieee754_relaxed)
+			relaxed = true;
+		else
+			return -EOPNOTSUPP;
+		break;
+	default:
+		return -EINVAL;
+	}
+	switch (what) {
+	case PR_IEEE754_MODE_NAN_LEGACY:
+		if (relaxed || mips_use_nan_legacy)
+			nan_2008 = false;
+		else
+			return -ENXIO;
+		break;
+	case PR_IEEE754_MODE_NAN_2008:
+		if (relaxed || mips_use_nan_2008)
+			nan_2008 = true;
+		else
+			return -ENXIO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mips_get_fp_context(task);
+
+	for_each_thread(task, t) {
+		if (relaxed)
+			set_thread_flag(TIF_IEEE754_RELAXED);
+		else
+			clear_thread_flag(TIF_IEEE754_RELAXED);
+		if (nan_2008) {
+			if (!(c->fpu_msk31 & FPU_CSR_NAN2008))
+				t->thread.fpu.fcr31 |= FPU_CSR_NAN2008;
+			if (!(c->fpu_msk31 & FPU_CSR_ABS2008))
+				t->thread.fpu.fcr31 |= FPU_CSR_ABS2008;
+		} else {
+			if (!(c->fpu_msk31 & FPU_CSR_NAN2008))
+				t->thread.fpu.fcr31 &= ~FPU_CSR_NAN2008;
+			if (!(c->fpu_msk31 & FPU_CSR_ABS2008))
+				t->thread.fpu.fcr31 &= ~FPU_CSR_ABS2008;
+		}
+	}
+
+	mips_put_fp_context(task);
+
+	return ELF_FLAGS >> AV_FLAGS_SYSTEM_SHIFT;
+}
Index: linux-sfr-test/include/uapi/linux/prctl.h
===================================================================
--- linux-sfr-test.orig/include/uapi/linux/prctl.h	2015-11-11 12:34:46.157647000 +0000
+++ linux-sfr-test/include/uapi/linux/prctl.h	2015-11-11 13:14:09.286746000 +0000
@@ -197,4 +197,16 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+/*
+ * Control MIPS IEEE 754 compliance modes.
+ */
+#define PR_SET_IEEE754_MODE	48
+
+# define PR_IEEE754_MODE_LEGACY		0	/* Legacy mode.  */
+# define PR_IEEE754_MODE_STRICT		1	/* Strict mode.  */
+# define PR_IEEE754_MODE_RELAXED	2	/* Relaxed mode.  */
+
+# define PR_IEEE754_MODE_NAN_LEGACY	0	/* Set legacy NaN encoding.  */
+# define PR_IEEE754_MODE_NAN_2008	1	/* Set 2008 NaN encoding.  */
+
 #endif /* _LINUX_PRCTL_H */
Index: linux-sfr-test/kernel/sys.c
===================================================================
--- linux-sfr-test.orig/kernel/sys.c	2015-11-11 12:34:46.159650000 +0000
+++ linux-sfr-test/kernel/sys.c	2015-11-11 13:14:09.342744000 +0000
@@ -103,6 +103,9 @@
 #ifndef SET_FP_MODE
 # define SET_FP_MODE(a,b)	(-EINVAL)
 #endif
+#ifndef SET_IEEE754_MODE
+# define SET_IEEE754_MODE(a, b, c)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2266,6 +2269,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
+	case PR_SET_IEEE754_MODE:
+		error = SET_IEEE754_MODE(me, arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;
