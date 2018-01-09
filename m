Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2018 12:48:06 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:60191 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992404AbeAILr7YMVlJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Jan 2018 12:47:59 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id AAA1E1A5914
        for <linux-mips@linux-mips.org>; Tue,  9 Jan 2018 12:47:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (unknown [10.10.13.43])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 910741A1EAB
        for <linux-mips@linux-mips.org>; Tue,  9 Jan 2018 12:47:53 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v5] MIPS: Add noexec=on|off kernel parameter
Date:   Tue,  9 Jan 2018 12:47:49 +0100
Message-Id: <1515498469-13815-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61955
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

Add a new kernel parameter to override the default behavior related to
the decision whether to indicate stack as non-executable or executable
(regardless of PT_GNU_STACK entry or CPU RIXI support) in function
mips_elf_read_implies_exec().

Allowed values:

noexec=on:	force indicating non-exec stack & heap
noexec=off:	force indicating executable stack & heap

If this parameter is omitted, kernel behavior remains the same as it
was before this patch is applied.

This functionality is convenient during debugging and is especially
useful for Android development where indication of non-executable
stack is required.

NOTE: Using noexec=on on a system without CPU XI support is not
recommended since there is no actual HW support that provide
non-executable stack and heap. Use only for debugging purposes and
not in a production environment.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
In the last version, code comments, documentation, and commit message
are modified to better explain the purpose and nature of this option.
A precautionary note is added as well.
---
 Documentation/admin-guide/kernel-parameters.txt | 19 ++++++++++
 arch/mips/kernel/elf.c                          | 48 +++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index af7104a..64c562a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2600,6 +2600,25 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
+	noexec		[MIPS]
+			Force indicating stack and heap as non-executable or
+			executable regardless of PT_GNU_STACK entry or CPU XI
+			(execute inhibit) support. Valid valuess are: on, off.
+			noexec=on:  force indicating non-executable
+				    stack and heap
+			noexec=off: force indicating executable
+				    stack and heap
+			If this parameter is omitted, stack and heap will be
+			indicated non-executable or executable as they are
+			actually set up, which depends on PT_GNU_STACK entry
+			and possibly other factors (for instance, CPU XI
+			support).
+			NOTE: Using noexec=on on a system without CPU XI
+			support	is not recommended since there is no actual
+			HW support that provide non-executable stack/heap.
+			Use only for debugging purposes and not in a
+			production environment.
+
 	nosmap		[X86]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 731325a..9bb40cc 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -326,8 +326,56 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 	}
 }
 
+static int noexec = EXSTACK_DEFAULT;
+
+/*
+ * kernel parameter: noexec=on|off
+ *
+ * Force indicating stack and heap as non-executable or
+ * executable regardless of PT_GNU_STACK entry or CPU XI
+ * (execute inhibit) support. Valid valuess are: on, off.
+ *
+ * noexec=on:  force indicating non-executable
+ *             stack and heap
+ * noexec=off: force indicating executable
+ *             stack and heap
+ *
+ * If this parameter is omitted, stack and heap will be
+ * indicated non-executable or executable as they are
+ * actually set up, which depends on PT_GNU_STACK entry
+ * and possibly other factors (for instance, CPU XI
+ * support).
+ *
+ * NOTE: Using noexec=on on a system without CPU XI
+ * support is not recommended since there is no actual
+ * HW support that provide non-executable stack/heap.
+ * Use only for debugging purposes and not in a
+ * production environment.
+ */
+static int __init noexec_setup(char *str)
+{
+	if (!strcmp(str, "on"))
+		noexec = EXSTACK_DISABLE_X;
+	else if (!strcmp(str, "off"))
+		noexec = EXSTACK_ENABLE_X;
+	else
+		pr_err("Malformed noexec format! noexec=on|off\n");
+
+	return 1;
+}
+__setup("noexec=", noexec_setup);
+
 int mips_elf_read_implies_exec(void *elf_ex, int exstack)
 {
+	switch (noexec) {
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
