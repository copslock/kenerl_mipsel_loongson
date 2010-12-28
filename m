Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 22:26:40 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8067 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491024Ab0L1V0d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 22:26:33 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1a56350000>; Tue, 28 Dec 2010 13:27:17 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Dec 2010 13:26:31 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Dec 2010 13:26:31 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBSLQQ7M014506;
        Tue, 28 Dec 2010 13:26:26 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBSLQO8U014505;
        Tue, 28 Dec 2010 13:26:24 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@redhat.com>
Subject: [PATCH v4] jump lable: Add MIPS support.
Date:   Tue, 28 Dec 2010 13:26:23 -0800
Message-Id: <1293571583-14472-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 28 Dec 2010 21:26:31.0105 (UTC) FILETIME=[E509A310:01CBA6D5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In order not to be left behind, we add jump label support for MIPS.

Tested on 64-bit big endian (Octeon), and 32-bit little endian
(malta/qemu).

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Baron <jbaron@redhat.com>
---

The only change from v3 is to guard the body of
arch/mips/kernel/jump_label.c with #ifdef HAVE_JUMP_LABEL.  This
avoids compiler errors when CONFIG_JUMP_LABEL is selected, but the
compiler does not support it.

 arch/mips/Kconfig                  |    1 +
 arch/mips/include/asm/jump_label.h |   48 ++++++++++++++++++++++++++++++++
 arch/mips/kernel/Makefile          |    2 +
 arch/mips/kernel/jump_label.c      |   54 ++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/module.c          |    5 +++
 5 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/jump_label.h
 create mode 100644 arch/mips/kernel/jump_label.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 913d50d..12d0d0f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -21,6 +21,7 @@ config MIPS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
+	select HAVE_ARCH_JUMP_LABEL
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
new file mode 100644
index 0000000..7622ccf
--- /dev/null
+++ b/arch/mips/include/asm/jump_label.h
@@ -0,0 +1,48 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2010 Cavium Networks, Inc.
+ */
+#ifndef _ASM_MIPS_JUMP_LABEL_H
+#define _ASM_MIPS_JUMP_LABEL_H
+
+#include <linux/types.h>
+
+#ifdef __KERNEL__
+
+#define JUMP_LABEL_NOP_SIZE 4
+
+#ifdef CONFIG_64BIT
+#define WORD_INSN ".dword"
+#else
+#define WORD_INSN ".word"
+#endif
+
+#define JUMP_LABEL(key, label)						\
+	do {								\
+		asm goto("1:\tnop\n\t"					\
+			"nop\n\t"					\
+			".pushsection __jump_table,  \"a\"\n\t"		\
+			WORD_INSN " 1b, %l[" #label "], %0\n\t"		\
+			".popsection\n\t"				\
+			: :  "i" (key) :  : label);			\
+	} while (0)
+
+
+#endif /* __KERNEL__ */
+
+#ifdef CONFIG_64BIT
+typedef u64 jump_label_t;
+#else
+typedef u32 jump_label_t;
+#endif
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
+#endif /* _ASM_MIPS_JUMP_LABEL_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 3977397..cedee2b 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -107,4 +107,6 @@ obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
 
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/mips/kernel/jump_label.c b/arch/mips/kernel/jump_label.c
new file mode 100644
index 0000000..6001610
--- /dev/null
+++ b/arch/mips/kernel/jump_label.c
@@ -0,0 +1,54 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2010 Cavium Networks, Inc.
+ */
+
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/memory.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/cpu.h>
+
+#include <asm/cacheflush.h>
+#include <asm/inst.h>
+
+#ifdef HAVE_JUMP_LABEL
+
+#define J_RANGE_MASK ((1ul << 28) - 1)
+
+void arch_jump_label_transform(struct jump_entry *e,
+			       enum jump_label_type type)
+{
+	union mips_instruction insn;
+	union mips_instruction *insn_p =
+		(union mips_instruction *)(unsigned long)e->code;
+
+	/* Jump only works within a 256MB aligned region. */
+	BUG_ON((e->target & ~J_RANGE_MASK) != (e->code & ~J_RANGE_MASK));
+
+	/* Target must have 4 byte alignment. */
+	BUG_ON((e->target & 3) != 0);
+
+	if (type == JUMP_LABEL_ENABLE) {
+		insn.j_format.opcode = j_op;
+		insn.j_format.target = (e->target & J_RANGE_MASK) >> 2;
+	} else {
+		insn.word = 0; /* nop */
+	}
+
+	get_online_cpus();
+	mutex_lock(&text_mutex);
+	*insn_p = insn;
+
+	flush_icache_range((unsigned long)insn_p,
+			   (unsigned long)insn_p + sizeof(*insn_p));
+
+	mutex_unlock(&text_mutex);
+	put_online_cpus();
+}
+
+#endif /* HAVE_JUMP_LABEL */
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 6f51dda..bb9cde4 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -30,6 +30,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/jump_label.h>
+
 #include <asm/pgtable.h>	/* MODULE_START */
 
 struct mips_hi16 {
@@ -390,6 +392,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
+	/* Make jump label nops. */
+	jump_label_apply_nops(me);
+
 	INIT_LIST_HEAD(&me->arch.dbe_list);
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
 		if (strcmp("__dbe_table", secstrings + s->sh_name) != 0)
-- 
1.7.2.3
