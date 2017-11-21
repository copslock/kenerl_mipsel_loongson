Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Nov 2017 14:52:54 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:57058 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990588AbdKUNwq32gVY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Nov 2017 14:52:46 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 1BC4B1A47D5;
        Tue, 21 Nov 2017 14:52:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id E91751A1E2E;
        Tue, 21 Nov 2017 14:52:39 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Miodrag Dinic <aleksandar.markovic@mips.com>,
        Christoffer Dall <cdall@linaro.org>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        James Hogan <james.hogan@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH] MIPS: Add nonxstack=on|off kernel parameter
Date:   Tue, 21 Nov 2017 14:52:17 +0100
Message-Id: <1511272339-10327-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@mips.com>

Add a new kernel parameter to override the default behavior related
to the decision whether to set up stack as non-executable in function
mips_elf_read_implies_exec().

The new parameter is used to control non executable stack and heap,
regardless of PT_GNU_STACK entry. This does apply to both steak and
heap, despite the name.

Allowed values:

nonxstack=on	Force non-exec stack & heap
nonxstack=off	Force executable stack & heap

If this parameter is omitted, kernel behavior remains the same as it
was before this patch is applied.

This functionality is convenient during debugging and is especially
useful for Android development where non-exec stack is required.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Miodrag Dinic <aleksandar.markovic@mips.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++
 arch/mips/kernel/elf.c                          | 39 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b74e133..99464ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2614,6 +2614,17 @@
 			noexec32=off: disable non-executable mappings
 				read implies executable mappings
 
+	nonxstack	[MIPS]
+			Force setting up stack and heap as non-executable or
+			executable regardless of PT_GNU_STACK entry. Both
+			stack and heap are affected, despite the name. Valid
+			arguments: on, off.
+			nonxstack=on:	Force non-executable stack and heap
+			nonxstack=off:	Force executable stack and heap
+			If ommited, stack and heap will or will not be set
+			up as non-executable depending on PT_GNU_STACK
+			entry and possibly other factors.
+
 	nofpu		[MIPS,SH] Disable hardware FPU at boot time.
 
 	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 731325a..28ef7f3 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -326,8 +326,47 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 	}
 }
 
+static int nonxstack = EXSTACK_DEFAULT;
+
+/*
+ * kernel parameter: nonxstack=on|off
+ *
+ *   Force setting up stack and heap as non-executable or
+ *   executable regardless of PT_GNU_STACK entry. Both
+ *   stack and heap are affected, despite the name. Valid
+ *   arguments: on, off.
+ *
+ *     nonxstack=on:   Force non-executable stack and heap
+ *     nonxstack=off:  Force executable stack and heap
+ *
+ *   If ommited, stack and heap will or will not be set
+ *   up as non-executable depending on PT_GNU_STACK
+ *   entry and possibly other factors.
+ */
+static int __init nonxstack_setup(char *str)
+{
+	if (!strcmp(str, "on"))
+		nonxstack = EXSTACK_DISABLE_X;
+	else if (!strcmp(str, "off"))
+		nonxstack = EXSTACK_ENABLE_X;
+	else
+		pr_err("Malformed nonxstack format! nonxstack=on|off\n");
+
+	return 1;
+}
+__setup("nonxstack=", nonxstack_setup);
+
 int mips_elf_read_implies_exec(void *elf_ex, int exstack)
 {
+	switch (nonxstack) {
+	case EXSTACK_DISABLE_X:
+		return 0;
+	case EXSTACK_ENABLE_X:
+		return 1;
+	default:
+		break;
+	}
+
 	if (exstack != EXSTACK_DISABLE_X) {
 		/* The binary doesn't request a non-executable stack */
 		return 1;
-- 
2.7.4
