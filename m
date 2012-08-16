Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 17:18:50 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:60927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903605Ab2HPPQf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 17:16:35 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 16 Aug 2012 08:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,778,1336374000"; 
   d="scan'208";a="209391449"
Received: from blue.fi.intel.com ([10.237.72.50])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2012 08:15:56 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 36BE7E0088; Thu, 16 Aug 2012 18:15:59 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 5/7] x86: Add clear_page_nocache
Date:   Thu, 16 Aug 2012 18:15:52 +0300
Message-Id: <1345130154-9602-6-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
X-archive-position: 34214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill.shutemov@linux.intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Andi Kleen <ak@linux.intel.com>

Add a cache avoiding version of clear_page. Straight forward integer variant
of the existing 64bit clear_page, for both 32bit and 64bit.

Also add the necessary glue for highmem including a layer that non cache
coherent architectures that use the virtual address for flushing can
hook in. This is not needed on x86 of course.

If an architecture wants to provide cache avoiding version of clear_page
it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
clear_page_nocache() and clear_user_highpage_nocache().

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/page.h      |    2 +
 arch/x86/include/asm/string_32.h |    5 +++
 arch/x86/include/asm/string_64.h |    5 +++
 arch/x86/lib/Makefile            |    3 +-
 arch/x86/lib/clear_page_32.S     |   72 ++++++++++++++++++++++++++++++++++++++
 arch/x86/lib/clear_page_64.S     |   29 +++++++++++++++
 arch/x86/mm/fault.c              |    7 ++++
 7 files changed, 122 insertions(+), 1 deletions(-)
 create mode 100644 arch/x86/lib/clear_page_32.S

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 8ca8283..aa83a1b 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -29,6 +29,8 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 	copy_page(to, from);
 }
 
+void clear_user_highpage_nocache(struct page *page, unsigned long vaddr);
+
 #define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
 	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 3d3e835..3f2fbcf 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -3,6 +3,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/linkage.h>
+
 /* Let gcc decide whether to inline or use the out of line functions */
 
 #define __HAVE_ARCH_STRCPY
@@ -337,6 +339,9 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 #define __HAVE_ARCH_MEMSCAN
 extern void *memscan(void *addr, int c, size_t size);
 
+#define ARCH_HAS_USER_NOCACHE 1
+asmlinkage void clear_page_nocache(void *page);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_STRING_32_H */
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 19e2c46..ca23d1d 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -3,6 +3,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/linkage.h>
+
 /* Written 2002 by Andi Kleen */
 
 /* Only used for special circumstances. Stolen from i386/string.h */
@@ -63,6 +65,9 @@ char *strcpy(char *dest, const char *src);
 char *strcat(char *dest, const char *src);
 int strcmp(const char *cs, const char *ct);
 
+#define ARCH_HAS_USER_NOCACHE 1
+asmlinkage void clear_page_nocache(void *page);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_STRING_64_H */
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index b00f678..14e47a2 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -23,6 +23,7 @@ lib-y += memcpy_$(BITS).o
 lib-$(CONFIG_SMP) += rwlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o
+lib-y += clear_page_$(BITS).o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o
 
@@ -40,7 +41,7 @@ endif
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
-        lib-y += thunk_64.o clear_page_64.o copy_page_64.o
+        lib-y += thunk_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o copy_user_nocache_64.o
 	lib-y += cmpxchg16b_emu.o
diff --git a/arch/x86/lib/clear_page_32.S b/arch/x86/lib/clear_page_32.S
new file mode 100644
index 0000000..9592161
--- /dev/null
+++ b/arch/x86/lib/clear_page_32.S
@@ -0,0 +1,72 @@
+#include <linux/linkage.h>
+#include <asm/alternative-asm.h>
+#include <asm/cpufeature.h>
+#include <asm/dwarf2.h>
+
+/*
+ * Fallback version if SSE2 is not avaible.
+ */
+ENTRY(clear_page_nocache)
+	CFI_STARTPROC
+	mov    %eax,%edx
+	xorl   %eax,%eax
+	movl   $4096/32,%ecx
+	.p2align 4
+.Lloop:
+	decl	%ecx
+#define PUT(x) mov %eax,x*4(%edx)
+	PUT(0)
+	PUT(1)
+	PUT(2)
+	PUT(3)
+	PUT(4)
+	PUT(5)
+	PUT(6)
+	PUT(7)
+#undef PUT
+	lea	32(%edx),%edx
+	jnz	.Lloop
+	nop
+	ret
+	CFI_ENDPROC
+ENDPROC(clear_page_nocache)
+
+	.section .altinstr_replacement,"ax"
+1:      .byte 0xeb /* jmp <disp8> */
+	.byte (clear_page_nocache_sse2 - clear_page_nocache) - (2f - 1b)
+	/* offset */
+2:
+	.previous
+	.section .altinstructions,"a"
+	altinstruction_entry clear_page_nocache,1b,X86_FEATURE_XMM2,\
+				16, 2b-1b
+	.previous
+
+/*
+ * Zero a page avoiding the caches
+ * eax	page
+ */
+ENTRY(clear_page_nocache_sse2)
+	CFI_STARTPROC
+	mov    %eax,%edx
+	xorl   %eax,%eax
+	movl   $4096/32,%ecx
+	.p2align 4
+.Lloop_sse2:
+	decl	%ecx
+#define PUT(x) movnti %eax,x*4(%edx)
+	PUT(0)
+	PUT(1)
+	PUT(2)
+	PUT(3)
+	PUT(4)
+	PUT(5)
+	PUT(6)
+	PUT(7)
+#undef PUT
+	lea	32(%edx),%edx
+	jnz	.Lloop_sse2
+	nop
+	ret
+	CFI_ENDPROC
+ENDPROC(clear_page_nocache_sse2)
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index f2145cf..9d2f3c2 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -40,6 +40,7 @@ ENTRY(clear_page)
 	PUT(5)
 	PUT(6)
 	PUT(7)
+#undef PUT
 	leaq	64(%rdi),%rdi
 	jnz	.Lloop
 	nop
@@ -71,3 +72,31 @@ ENDPROC(clear_page)
 	altinstruction_entry clear_page,2b,X86_FEATURE_ERMS,   \
 			     .Lclear_page_end-clear_page,3b-2b
 	.previous
+
+/*
+ * Zero a page avoiding the caches
+ * rdi	page
+ */
+ENTRY(clear_page_nocache)
+	CFI_STARTPROC
+	xorl   %eax,%eax
+	movl   $4096/64,%ecx
+	.p2align 4
+.Lloop_nocache:
+	decl	%ecx
+#define PUT(x) movnti %rax,x*8(%rdi)
+	movnti %rax,(%rdi)
+	PUT(1)
+	PUT(2)
+	PUT(3)
+	PUT(4)
+	PUT(5)
+	PUT(6)
+	PUT(7)
+#undef PUT
+	leaq	64(%rdi),%rdi
+	jnz	.Lloop_nocache
+	nop
+	ret
+	CFI_ENDPROC
+ENDPROC(clear_page_nocache)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 76dcd9d..d8cf231 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1209,3 +1209,10 @@ good_area:
 
 	up_read(&mm->mmap_sem);
 }
+
+void clear_user_highpage_nocache(struct page *page, unsigned long vaddr)
+{
+	void *p = kmap_atomic(page);
+	clear_page_nocache(p);
+	kunmap_atomic(p);
+}
-- 
1.7.7.6
