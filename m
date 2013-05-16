Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 21:07:59 +0200 (CEST)
Received: from mail-pb0-f47.google.com ([209.85.160.47]:42954 "EHLO
        mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825732Ab3EPTHu6F4vM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 May 2013 21:07:50 +0200
Received: by mail-pb0-f47.google.com with SMTP id rr4so2599587pbb.34
        for <multiple recipients>; Thu, 16 May 2013 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=UYkv85iaE3Zps2sqNV3cNL6IZeBXgb0ZjkQzMP7yH54=;
        b=tx7kYb9suCfX5+d9a863g6tpJ6K+icPlvluWxXZYhP8uvS9n22xZp0a2I8nwiZuQa/
         JkYr9vS3fCO2GtSwoTd+Q+y8OEwy/eO8OfALPuAOlTboVbqsGZy5ABDXZPD9SfbEXLee
         8yS/Ss/9HyUK4Rg+d4OJDzukkESUUDEp9R2IpeNQkJ6jq2K0hKzKRbaVfYFRXXtxJp0J
         oUDQg7KJXTrtqN8mzinr5livPGU8j8sy1/E8AU6KfVAdEM0StTCV3itNGpEYAO0n2E0a
         rCbUqoLLnr3iIzi7DyNbm0ah0g0DZ9xZfs7ZCDCBAkiXe7XsWJqsorod6SIOSS5aZjDO
         3KCA==
X-Received: by 10.66.164.3 with SMTP id ym3mr45282228pab.106.1368731262318;
        Thu, 16 May 2013 12:07:42 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cq1sm7833835pbc.13.2013.05.16.12.07.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 12:07:41 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4GJ7dSJ019138;
        Thu, 16 May 2013 12:07:39 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4GJ7aSX019137;
        Thu, 16 May 2013 12:07:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Add user stack and registers to perf.
Date:   Thu, 16 May 2013 12:07:33 -0700
Message-Id: <1368731253-19102-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                      |  2 ++
 arch/mips/include/uapi/asm/perf_regs.h | 41 +++++++++++++++++++++++
 arch/mips/kernel/Makefile              |  2 +-
 arch/mips/kernel/perf_regs.c           | 60 ++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/uapi/asm/perf_regs.h
 create mode 100644 arch/mips/kernel/perf_regs.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a58ab9..2ae8e1d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -5,6 +5,8 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
 	select ARCH_HAVE_CUSTOM_GPIO_H
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
index 6ad9e04..17c99d7 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -91,7 +91,7 @@ CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/n
 
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
-obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
diff --git a/arch/mips/kernel/perf_regs.c b/arch/mips/kernel/perf_regs.c
new file mode 100644
index 0000000..0451c4b
--- /dev/null
+++ b/arch/mips/kernel/perf_regs.c
@@ -0,0 +1,60 @@
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
-- 
1.7.11.7
