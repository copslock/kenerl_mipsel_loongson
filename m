Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 13:51:11 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52394 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823079Ab3KGMtDZ1Pi1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 13:49:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 6/6] mips: non-exec stack & heap when non-exec PT_GNU_STACK is present
Date:   Thu, 7 Nov 2013 12:48:33 +0000
Message-ID: <1383828513-28462-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_07_12_49_03
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The stack and heap have both been executable by default on MIPS until
now. This patch changes the default to be non-executable, but only for
ELF binaries with a non-executable PT_GNU_STACK header present. This
does apply to both the heap & the stack, despite the name PT_GNU_STACK,
and this matches the behaviour of other architectures like ARM & x86.

Current MIPS toolchains do not produce the PT_GNU_STACK header, which
means that we can rely upon this patch not changing the behaviour of
existing binaries. The new default will only take effect for newly
compiled binaries once toolchains are updated to support PT_GNU_STACK,
and since those binaries are newly compiled they can be compiled
expecting the change in default behaviour. Again this matches the way in
which the ARM & x86 architectures handled their implementations of
non-executable memory.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/elf.h  |  5 +++++
 arch/mips/include/asm/page.h |  6 ++++--
 arch/mips/kernel/Makefile    |  7 ++++---
 arch/mips/kernel/elf.c       | 28 ++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/kernel/elf.c

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 17163cf..d6c91dd 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -393,4 +393,9 @@ struct mm_struct;
 extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define arch_randomize_brk arch_randomize_brk
 
+#define elf_read_implies_exec(ex, stk) mips_elf_read_implies_exec(&(ex), stk)
+struct elf32_hdr;
+extern int mips_elf_read_implies_exec(const struct elf32_hdr *elf_ex,
+				      int exstack);
+
 #endif /* _ASM_ELF_H */
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index f6be474..87f862d 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -202,8 +202,10 @@ extern int __virt_addr_valid(const volatile void *kaddr);
 #define virt_addr_valid(kaddr)						\
 	__virt_addr_valid((const volatile void *) (kaddr))
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_DEFAULT_FLAGS \
+	(VM_READ | VM_WRITE | \
+	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
+	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
 #define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 1c1b717..97d3bf7 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -4,9 +4,10 @@
 
 extra-y		:= head.o vmlinux.lds
 
-obj-y		+= cpu-probe.o branch.o entry.o genex.o idle.o irq.o process.o \
-		   prom.o ptrace.o reset.o setup.o signal.o syscall.o \
-		   time.o topology.o traps.o unaligned.o watch.o vdso.o
+obj-y		+= cpu-probe.o branch.o elf.o entry.o genex.o idle.o irq.o \
+		   process.o prom.o ptrace.o reset.o setup.o signal.o \
+		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
+		   vdso.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
new file mode 100644
index 0000000..92212ba
--- /dev/null
+++ b/arch/mips/kernel/elf.c
@@ -0,0 +1,28 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013  Imagination Technologies Ltd.
+ */
+
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/export.h>
+#include <asm/cpu-features.h>
+
+int mips_elf_read_implies_exec(const struct elf32_hdr *elf_ex, int exstack)
+{
+	if (exstack != EXSTACK_DISABLE_X) {
+		/* the binary doesn't request a non-executable stack */
+		return 1;
+	}
+
+	if (!cpu_has_rixi) {
+		/* the CPU doesn't support non-executable memory */
+		return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mips_elf_read_implies_exec);
-- 
1.8.4.1
