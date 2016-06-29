Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2016 16:39:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24973 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27044075AbcF2OjtipHln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jun 2016 16:39:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ABF932B4410D6;
        Wed, 29 Jun 2016 15:39:39 +0100 (IST)
Received: from localhost (10.100.200.191) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 29 Jun
 2016 15:39:42 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec PT_GNU_STACK is present
Date:   Wed, 29 Jun 2016 15:38:30 +0100
Message-ID: <20160629143830.526-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160629143830.526-1-paul.burton@imgtec.com>
References: <20160629143830.526-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.191]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54176
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

Changes in v3:
- Rebase atop v4.7-rc5.

Changes in v2: None

 arch/mips/include/asm/elf.h  |  5 +++++
 arch/mips/include/asm/page.h |  6 ++++--
 arch/mips/kernel/elf.c       | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index f5f4571..914981d 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -498,4 +498,9 @@ extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
 extern void mips_set_personality_nan(struct arch_elf_state *state);
 extern void mips_set_personality_fp(struct arch_elf_state *state);
 
+#define elf_read_implies_exec(ex, stk) mips_elf_read_implies_exec(&(ex), stk)
+struct elf32_hdr;
+extern int mips_elf_read_implies_exec(const struct elf32_hdr *elf_ex,
+				      int exstack);
+
 #endif /* _ASM_ELF_H */
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 21ed715..74cb004 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -229,8 +229,10 @@ extern int __virt_addr_valid(const volatile void *kaddr);
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
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 891f5ee..9aa55b8 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -8,9 +8,12 @@
  * option) any later version.
  */
 
+#include <linux/binfmts.h>
 #include <linux/elf.h>
+#include <linux/export.h>
 #include <linux/sched.h>
 
+#include <asm/cpu-features.h>
 #include <asm/cpu-info.h>
 
 /* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
@@ -326,3 +329,19 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 		BUG();
 	}
 }
+
+int mips_elf_read_implies_exec(const struct elf32_hdr *elf_ex, int exstack)
+{
+	if (exstack != EXSTACK_DISABLE_X) {
+		/* The binary doesn't request a non-executable stack */
+		return 1;
+	}
+
+	if (!cpu_has_rixi) {
+		/* The CPU doesn't support non-executable memory */
+		return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mips_elf_read_implies_exec);
-- 
2.9.0
