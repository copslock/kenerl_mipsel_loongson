Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2016 14:16:49 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35918 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007557AbcFYMQrgCvc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Jun 2016 14:16:47 +0200
Received: by mail-pf0-f196.google.com with SMTP id i123so11572770pfg.3;
        Sat, 25 Jun 2016 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gF1Di9A7eEpDL3fBYVerL/wH5VpYp2Tok2HW7AW4uLw=;
        b=VbzAlUxccGl220aftQg3lFZP5EOkBmQL7E7tVCz+vglkYuqAYiHpwMiG9phDamGADw
         fG1TiBzIH1w6X3plCb/WCDtrGY2V6ldNujNvSgauxExrBLJugN2aQVPhEz/4X+IXM1sX
         MMMhZMYai4vQ7kKGR1eX14RITgL7vICt16Tt04J1MMCH3KGvn0mEqnoZ8w7b1iDXahgK
         sjxK+naqV90G513jZoyYUGMNNQIF9hxjzeVwU/tjKWcpHJvPPKHBN9TV/0PLW2j2DBoQ
         u9iEamxuytKwa4LcS6efKh//CEXhQ2h+6w/PH0LZcrdTUw297G+TDKFr7YTZaMJ9TMy6
         S/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gF1Di9A7eEpDL3fBYVerL/wH5VpYp2Tok2HW7AW4uLw=;
        b=RKzh6XjtykqOQAqi/9VuKJsT1x5piiZU/ommgjOCsL85vvm+M3hWIEeUAt/hUCkBf2
         9wUc2r24EFv68CDjJIMx9zaZaik3R3apNbQpmK0juqlyiwxDC95dFddj8P+1TfoHi9Ll
         wYkN+3S9qnP4d4PQ38D2Gk/7bpNK4LR5axYCRc8GjOIMngZ+af/A78DxHJZxda/dVgBK
         p8TZRwIHFWWwimcV1X1kVl81ZifYensOf2EegMVs332oILNnctJLerRub0fxqPsuxYo4
         s1/6pmAhRgBtmUykcajNxDPvvy978V2NYDjJSCL1e/wGbDFvEIWHVHWeoy2zf76NRoaF
         VGrQ==
X-Gm-Message-State: ALyK8tLGUNBS0JgdsYhs4hAVwaHy+Vb14JfK8zZa6Gd4Nl+bizL/BePQaippuu02oJNCmA==
X-Received: by 10.98.107.129 with SMTP id g123mr16117190pfc.62.1466857001215;
        Sat, 25 Jun 2016 05:16:41 -0700 (PDT)
Received: from localhost.localdomain ([1.23.11.214])
        by smtp.googlemail.com with ESMTPSA id ab6sm7066546pad.44.2016.06.25.05.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 05:16:40 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
X-Google-Original-From: PrasannaKumar Muralidharan
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        john.stultz@linaro.org, mguzik@redhat.com, athorlton@sgi.com,
        mhocko@suse.com, ebiederm@xmission.com, gorcunov@openvz.org,
        luto@kernel.org, cl@linux.com, serge.hallyn@ubuntu.com,
        keescook@chromium.org, jslaby@suse.cz, akpm@linux-foundation.org,
        macro@imgtec.com, f.fainelli@gmail.com, mingo@kernel.org,
        alex.smith@imgtec.com, markos.chandras@imgtec.com,
        Leonid.Yegoshin@imgtec.com, david.daney@cavium.com,
        zhaoxiu.zeng@gmail.com, chenhc@lemote.com,
        Zubair.Kakakhel@imgtec.com, james.hogan@imgtec.com,
        paul.burton@imgtec.com, ralf@linux-mips.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [RFC] mips: Add MXU context switching support
Date:   Sat, 25 Jun 2016 17:44:30 +0530
Message-Id: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.5.0
Return-Path: <>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This patch adds support for context switching Xburst MXU registers. The
registers are named xr0 to xr16. xr16 is the control register that can
be used to enable and disable MXU instruction set. Read and write to
these registers can be done without enabling MXU instruction set by user
space. Only when MXU instruction set is enabled any MXU instruction
(other than read or write to xr registers) can be done. xr0 is always 0.

Kernel does not know when MXU instruction is enabled or disabled. So
during context switch if MXU is enabled in xr16 register then MXU
registers are saved, restored when the task is run. When user space
application enables MXU, it is not reflected in other threads
immediately. So for convenience the applications can use prctl syscall
to let the MXU state propagate across threads running in different CPUs.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/include/asm/cpu-features.h |   4 +
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/mxu.h          | 157 +++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/processor.h    |  19 +++++
 arch/mips/include/asm/switch_to.h    |  40 +++++++++
 arch/mips/kernel/cpu-probe.c         |   1 +
 arch/mips/kernel/process.c           |  48 +++++++++++
 include/uapi/linux/prctl.h           |   3 +
 kernel/sys.c                         |   6 ++
 9 files changed, 279 insertions(+)
 create mode 100644 arch/mips/include/asm/mxu.h

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e961c8a..c6270b0 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -345,6 +345,10 @@
 #define cpu_has_dsp3		(cpu_data[0].ases & MIPS_ASE_DSP3)
 #endif
 
+#ifndef cpu_has_mxu
+#define cpu_has_mxu		(cpu_data[0].ases & MIPS_ASE_MXU)
+#endif
+
 #ifndef cpu_has_mipsmt
 #define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index f672df8..77ab797 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -428,5 +428,6 @@ enum cpu_type_enum {
 #define MIPS_ASE_VZ		0x00000080 /* Virtualization ASE */
 #define MIPS_ASE_MSA		0x00000100 /* MIPS SIMD Architecture */
 #define MIPS_ASE_DSP3		0x00000200 /* Signal Processing ASE Rev 3*/
+#define MIPS_ASE_MXU		0x00000400 /* Xburst MXU instruction set */
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/mips/include/asm/mxu.h b/arch/mips/include/asm/mxu.h
new file mode 100644
index 0000000..cf77cbd
--- /dev/null
+++ b/arch/mips/include/asm/mxu.h
@@ -0,0 +1,157 @@
+/*
+ * Copyright (C) Ingenic Semiconductor
+ * File taken from Ingenic Semiconductor's linux repo available in github
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _ASM_MXU_H
+#define _ASM_MXU_H
+
+#include <asm/cpu.h>
+#include <asm/cpu-features.h>
+#include <asm/hazards.h>
+#include <asm/mipsregs.h>
+
+static inline void __enable_mxu(void)
+{
+	unsigned int register val asm("t0");
+	val = 3;
+	asm volatile(".word	0x7008042f\n\t"::"r"(val));
+}
+
+static inline void enable_mxu(void)
+{
+	if (cpu_has_mxu)
+		__enable_mxu();
+}
+
+static inline void disable_mxu(void)
+{
+	unsigned int register val asm("t0");
+	val = 0;
+	asm volatile(".word	0x7008042f\n\t"::"r"(val));
+	asm("nop\n\t");
+	asm("nop\n\t");
+	asm("nop\n\t");
+}
+
+static inline int mxu_used(void)
+{
+	unsigned int register reg_val asm("t0");
+	asm volatile(".word	0x7008042f\n\t"::"r"(reg_val));
+	return reg_val &0x01;
+}
+
+static inline void __save_mxu(void *tsk_void)
+{
+	struct task_struct *tsk = tsk_void;
+
+	register unsigned int reg_val asm("t0");
+
+	asm volatile(".word	0x7008042e\n\t");
+	tsk->thread.mxu.xr[0] = reg_val;
+	asm volatile(".word	0x7008006e\n\t");
+	tsk->thread.mxu.xr[1] = reg_val;
+	asm volatile(".word	0x700800ae\n\t");
+	tsk->thread.mxu.xr[2] = reg_val;
+	asm volatile(".word	0x700800ee\n\t");
+	tsk->thread.mxu.xr[3] = reg_val;
+	asm volatile(".word	0x7008012e\n\t");
+	tsk->thread.mxu.xr[4] = reg_val;
+	asm volatile(".word	0x7008016e\n\t");
+	tsk->thread.mxu.xr[5] = reg_val;
+	asm volatile(".word	0x700801ae\n\t");
+	tsk->thread.mxu.xr[6] = reg_val;
+	asm volatile(".word	0x700801ee\n\t");
+	tsk->thread.mxu.xr[7] = reg_val;
+	asm volatile(".word	0x7008022e\n\t");
+	tsk->thread.mxu.xr[8] = reg_val;
+	asm volatile(".word	0x7008026e\n\t");
+	tsk->thread.mxu.xr[9] = reg_val;
+	asm volatile(".word	0x700802ae\n\t");
+	tsk->thread.mxu.xr[10] = reg_val;
+	asm volatile(".word	0x700802ee\n\t");
+	tsk->thread.mxu.xr[11] = reg_val;
+	asm volatile(".word	0x7008032e\n\t");
+	tsk->thread.mxu.xr[12] = reg_val;
+	asm volatile(".word	0x7008036e\n\t");
+	tsk->thread.mxu.xr[13] = reg_val;
+	asm volatile(".word	0x700803ae\n\t");
+	tsk->thread.mxu.xr[14] = reg_val;
+	asm volatile(".word	0x700803ee\n\t");
+	tsk->thread.mxu.xr[15] = reg_val;
+}
+
+static inline void __restore_mxu(void *tsk_void)
+{
+	struct task_struct *tsk = tsk_void;
+
+	register unsigned int reg_val asm("t0");
+
+	reg_val = tsk->thread.mxu.xr[0];
+	asm volatile(".word	0x7008042f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[1];
+	asm volatile(".word	0x7008006f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[2];
+	asm volatile(".word	0x700800af\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[3];
+	asm volatile(".word	0x700800ef\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[4];
+	asm volatile(".word	0x7008012f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[5];
+	asm volatile(".word	0x7008016f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[6];
+	asm volatile(".word	0x700801af\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[7];
+	asm volatile(".word	0x700801ef\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[8];
+	asm volatile(".word	0x7008022f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[9];
+	asm volatile(".word	0x7008026f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[10];
+	asm volatile(".word	0x700802af\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[11];
+	asm volatile(".word	0x700802ef\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[12];
+	asm volatile(".word	0x7008032f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[13];
+	asm volatile(".word	0x7008036f\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[14];
+	asm volatile(".word	0x700803af\n\t"::"r"(reg_val));
+	reg_val = tsk->thread.mxu.xr[15];
+	asm volatile(".word	0x700803ef\n\t"::"r"(reg_val));
+}
+
+#define save_mxu(tsk)						\
+	do {							\
+		if (cpu_has_mxu)				\
+			__save_mxu(tsk);			\
+	} while (0)
+
+#define restore_mxu(tsk)					\
+	do {							\
+		if (cpu_has_mxu)				\
+			__restore_mxu(tsk);			\
+	} while (0)
+
+#define __get_mxu_regs(tsk)					\
+	({							\
+		if (tsk == current)				\
+			__save_mxu(current);			\
+								\
+		tsk->thread.mxu.xr;				\
+	})
+
+#define __let_mxu_regs(tsk, regs)				\
+	do {							\
+		int i;						\
+		for (i = 0; i < NUM_MXU_REGS; i++)		\
+			tsk->thread.mxu.xr[i] = regs[i];	\
+		if (tsk == current)				\
+			__save_mxu(current);			\
+	} while (0)
+
+#endif /* _ASM_MXU_H */
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 7e78b62..a4def30 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -142,6 +142,11 @@ struct mips_dsp_state {
 	unsigned int	dspcontrol;
 };
 
+#define NUM_MXU_REGS 16
+struct xburst_mxu_state {
+	unsigned int xr[NUM_MXU_REGS];
+};
+
 #define INIT_CPUMASK { \
 	{0,} \
 }
@@ -266,6 +271,10 @@ struct thread_struct {
 	/* Saved state of the DSP ASE, if available. */
 	struct mips_dsp_state dsp;
 
+	unsigned int mxu_used;
+	/* Saved registers of Xburst MXU, if available. */
+	struct xburst_mxu_state mxu;
+
 	/* Saved watch register state, if available. */
 	union mips_watch_reg_state watch;
 
@@ -330,6 +339,10 @@ struct thread_struct {
 		.dspr		= {0, },			\
 		.dspcontrol	= 0,				\
 	},							\
+	.mxu_used		= 0,				\
+	.mxu			= {				\
+		.xr		= {0, },			\
+	},							\
 	/*							\
 	 * saved watch register stuff				\
 	 */							\
@@ -410,4 +423,10 @@ extern int mips_set_process_fp_mode(struct task_struct *task,
 #define GET_FP_MODE(task)		mips_get_process_fp_mode(task)
 #define SET_FP_MODE(task,value)		mips_set_process_fp_mode(task, value)
 
+extern int mips_enable_mxu_other_cpus(void);
+extern int mips_disable_mxu_other_cpus(void);
+
+#define ENABLE_MXU_OTHER_CPUS()         mips_enable_mxu_other_cpus()
+#define DISABLE_MXU_OTHER_CPUS()        mips_disable_mxu_other_cpus()
+
 #endif /* _ASM_PROCESSOR_H */
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index ebb5c0f..112aff5 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -75,6 +75,43 @@ do {	if (cpu_has_rw_llb) {						\
 	}								\
 } while (0)
 
+static inline void handle_mxu_state(struct task_struct *prev,
+		struct task_struct *next)
+{
+	struct task_struct *thread = NULL;
+
+	if (prev->thread.mxu_used) {
+		if (mxu_used() == 1) {
+			__save_mxu(prev);
+		} else {
+			prev->thread.mxu_used = 0;
+			thread = prev;
+			rcu_read_lock();
+			while_each_thread(prev, thread) {
+				thread->thread.mxu_used = 0;
+			};
+			rcu_read_unlock();
+		}
+	} else {
+		if (mxu_used() == 1) {
+			__save_mxu(prev);
+			prev->thread.mxu_used = 1;
+			thread = prev;
+			rcu_read_lock();
+			while_each_thread(prev, thread) {
+				thread->thread.mxu_used = 1;
+			};
+			rcu_read_unlock();
+		}
+	}
+	disable_mxu();
+
+	if (next->thread.mxu_used) {
+		__restore_mxu(next);
+		enable_mxu();
+	}
+}
+
 /*
  * For newly created kernel threads switch_to() will return to
  * ret_from_kernel_thread, newly created user threads to ret_from_fork.
@@ -89,6 +126,9 @@ do {									\
 		__save_dsp(prev);					\
 		__restore_dsp(next);					\
 	}								\
+	if (cpu_has_mxu) {						\
+		handle_mxu_state(prev, next);				\
+	}								\
 	if (cop2_present) {						\
 		set_c0_status(ST0_CU2);					\
 		if ((KSTK_STATUS(prev) & ST0_CU2)) {			\
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a88d442..90ffc40 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1836,6 +1836,7 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_JZRISC:
 		c->cputype = CPU_JZRISC;
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
+		c->ases |= MIPS_ASE_MXU;
 		__cpu_name[cpu] = "Ingenic JZRISC";
 		break;
 	default:
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 813ed78..6310092 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -31,6 +31,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/dsp.h>
+#include <asm/mxu.h>
 #include <asm/fpu.h>
 #include <asm/msa.h>
 #include <asm/pgtable.h>
@@ -90,6 +91,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 		_save_fp(current);
 
 	save_dsp(current);
+	if (src->thread.mxu_used) {
+		save_mxu(src);
+		/* Disable mxu usage for new process */
+		dst->thread.mxu_used = 0;
+	}
 
 	preempt_enable();
 
@@ -162,6 +168,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	if (clone_flags & CLONE_SETTLS)
 		ti->tp_value = regs->regs[7];
 
+	if (clone_flags & CLONE_THREAD)
+		p->thread.mxu_used = current->thread.mxu_used;
+
 	return 0;
 }
 
@@ -652,3 +661,42 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 
 	return 0;
 }
+
+int mips_change_mxu_state_other_cpus(int mxu_enable_state)
+{
+	if (!cpu_has_mxu)
+		return 0;
+
+	/*
+	 * Deschedule tasks from same thread group running in other CPUs. When
+	 * they are scheduled back they will have MXU enabled.
+	 */
+	if ((mxu_used() == mxu_enable_state) && (num_online_cpus() > 1)) {
+		struct task_struct *thread = current;
+		int this_cpu = task_cpu(current);
+		int cpu;
+
+		while_each_thread(current, thread) {
+			if (current != thread &&
+					thread->state == TASK_RUNNING) {
+				cpu = task_cpu(thread);
+				if (this_cpu != cpu && cpu_online(cpu))
+					smp_send_reschedule(task_cpu(thread));
+			}
+		};
+
+		schedule();
+	}
+
+	return 0;
+}
+
+int mips_enable_mxu_other_cpus(void)
+{
+	return mips_change_mxu_state_other_cpus(1);
+}
+
+int mips_disable_mxu_other_cpus(void)
+{
+	return mips_change_mxu_state_other_cpus(0);
+}
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a8d0759..b193d91 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -197,4 +197,7 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+#define PR_ENABLE_MXU_OTHER_CPUS        48
+#define PR_DISABLE_MXU_OTHER_CPUS       49
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 89d5be4..fbbc7b2 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2270,6 +2270,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
+	case PR_ENABLE_MXU_OTHER_CPUS:
+		error = ENABLE_MXU_OTHER_CPUS();
+		break;
+	case PR_DISABLE_MXU_OTHER_CPUS:
+		error = DISABLE_MXU_OTHER_CPUS();
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.5.0
