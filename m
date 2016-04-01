Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 11:51:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42368 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025966AbcDAJtyKO6Ma (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Apr 2016 11:49:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u319netr023041;
        Fri, 1 Apr 2016 11:49:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u319nexU023040;
        Fri, 1 Apr 2016 11:49:40 +0200
Message-Id: <479a407d65aad6b0bf21e7ce686afb876b7ebe07.1459501014.git.ralf@linux-mips.org>
In-Reply-To: <cover.1459501014.git.ralf@linux-mips.org>
References: <cover.1459501014.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Fri, 1 Apr 2016 10:56:55 +0200
Subject: [PATCH v3 1/3] MIPS: Add user stack and registers to perf.
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

From: David Daney <david.daney@cavium.com>

This allows for extracting off-line stack traces from user-space code
in the perf tool.

[ralf@linux-mips.org: Add perf_get_regs_user() which is required after
88a7c26af8da (perf: >> Move task_pt_regs sampling into arch code).]

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/Kconfig                      |  2 +
 arch/mips/include/uapi/asm/perf_regs.h | 41 +++++++++++++++++++++
 arch/mips/kernel/Makefile              |  2 +-
 arch/mips/kernel/perf_regs.c           | 67 ++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/uapi/asm/perf_regs.h
 create mode 100644 arch/mips/kernel/perf_regs.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35d92a1..6051f58 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -11,6 +11,8 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/mips/include/uapi/asm/perf_regs.h b/arch/mips/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..9577af5
--- /dev/null
+++ b/arch/mips/include/uapi/asm/perf_regs.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_MIPS_PERF_REGS_H
+#define _ASM_MIPS_PERF_REGS_H
+
+enum perf_event_mips_regs {
+	PERF_REG_MIPS_PC,
+	PERF_REG_MIPS_R1,
+	PERF_REG_MIPS_R2,
+	PERF_REG_MIPS_R3,
+	PERF_REG_MIPS_R4,
+	PERF_REG_MIPS_R5,
+	PERF_REG_MIPS_R6,
+	PERF_REG_MIPS_R7,
+	PERF_REG_MIPS_R8,
+	PERF_REG_MIPS_R9,
+	PERF_REG_MIPS_R10,
+	PERF_REG_MIPS_R11,
+	PERF_REG_MIPS_R12,
+	PERF_REG_MIPS_R13,
+	PERF_REG_MIPS_R14,
+	PERF_REG_MIPS_R15,
+	PERF_REG_MIPS_R16,
+	PERF_REG_MIPS_R17,
+	PERF_REG_MIPS_R18,
+	PERF_REG_MIPS_R19,
+	PERF_REG_MIPS_R20,
+	PERF_REG_MIPS_R21,
+	PERF_REG_MIPS_R22,
+	PERF_REG_MIPS_R23,
+	PERF_REG_MIPS_R24,
+	PERF_REG_MIPS_R25,
+	/*
+	 * 26 and 27 are k0 and k1, they are always clobbered thus not
+	 * stored.
+	 */
+	PERF_REG_MIPS_R28,
+	PERF_REG_MIPS_R29,
+	PERF_REG_MIPS_R30,
+	PERF_REG_MIPS_R31,
+	PERF_REG_MIPS_MAX = PERF_REG_MIPS_R31 + 1,
+};
+#endif /* _ASM_MIPS_PERF_REGS_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 6a24628..1cdf1e9 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -97,7 +97,7 @@ CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/n
 
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
-obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
diff --git a/arch/mips/kernel/perf_regs.c b/arch/mips/kernel/perf_regs.c
new file mode 100644
index 0000000..65bb25c
--- /dev/null
+++ b/arch/mips/kernel/perf_regs.c
@@ -0,0 +1,67 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Some parts derived from x86 version of this file.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <linux/perf_event.h>
+
+#include <asm/ptrace.h>
+
+#ifdef CONFIG_32BIT
+u64 perf_reg_abi(struct task_struct *tsk)
+{
+	return PERF_SAMPLE_REGS_ABI_32;
+}
+#else /* Must be CONFIG_64BIT */
+u64 perf_reg_abi(struct task_struct *tsk)
+{
+	if (test_tsk_thread_flag(tsk, TIF_32BIT_REGS))
+		return PERF_SAMPLE_REGS_ABI_32;
+	else
+		return PERF_SAMPLE_REGS_ABI_64;
+}
+#endif /* CONFIG_32BIT */
+
+int perf_reg_validate(u64 mask)
+{
+	if (!mask)
+		return -EINVAL;
+	if (mask & ~((1ull << PERF_REG_MIPS_MAX) - 1))
+		return -EINVAL;
+	return 0;
+}
+
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	long v;
+
+	switch (idx) {
+	case PERF_REG_MIPS_PC:
+		v = regs->cp0_epc;
+		break;
+	case PERF_REG_MIPS_R1 ... PERF_REG_MIPS_R25:
+		v = regs->regs[idx - PERF_REG_MIPS_R1 + 1];
+		break;
+	case PERF_REG_MIPS_R28 ... PERF_REG_MIPS_R31:
+		v = regs->regs[idx - PERF_REG_MIPS_R28 + 28];
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	return (s64)v; /* Sign extend if 32-bit. */
+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+	struct pt_regs *regs, struct pt_regs *regs_user_copy)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi = perf_reg_abi(current);
+}
-- 
2.5.5
