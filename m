Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 21:07:42 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:45090
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992818AbeABUGjXOAkJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 21:06:39 +0100
Received: by mail-wm0-x242.google.com with SMTP id 9so62960732wme.4
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 12:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YeY2Xm5F7YqCntxBJlOwEmhyquMbh7oq6A2LuKFDBk0=;
        b=I7jWcnRZxSQJ+r+NtiSwxZap+e4+EqIntXlM8zv+adVYkjRBnxpAYSFrC0dqGsT1QF
         8rDSC94FmIB9N8KAC8sCCuRCErl1CHAnd3c/Uj+mcD10ddgBJm92tB35pktDiPzqQesh
         +AnUz+oxl5F+2nDDr5snXku1SfLcXf+ApxaMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YeY2Xm5F7YqCntxBJlOwEmhyquMbh7oq6A2LuKFDBk0=;
        b=h2OpxaX/A3xCjFliqqMghHL3tSDsKqT4ZnLJOPzHw82Ixw1sHyrMK6T+ltKAG4I8wf
         63U6rOK6kLJtqpycV2yo5byhIcBTCI14iZFboWEDC3me/HLOqT70rdSkuZyQDkfvLMki
         ycjElVV1iY9Txxn8BfWm/DRg35KPjv+zcAiGemuxIBGWlJz2bToxynjO9/bG0lWU45xr
         uqE6RzZ/piMotq1pKtMTrFkEzEHdkvL8QesRRcPEkgyT3/EGqwcs22KAubAXVfi5DRHR
         oJ31+XtdRBNfvwNPVXJZh+Gs55aMeswVLRMZg/Z5GQO/I4iibtfpB9u0ES8ipEXm7ilk
         5oaQ==
X-Gm-Message-State: AKGB3mJJZ2p6InR2VTfLJmkx+ZsJwrT1odwTRkTVP/i5Fhtn3/Nr9CIv
        NQJyfliQYPYPvzQ/N2zmypBfjw==
X-Google-Smtp-Source: ACJfBot7xUb0qYmgPwxw/RXnKwp6js00bW9Gxhi5G8z2oVkjLuiiU4e/YG3F/p9nd9P/k33kbNIRBg==
X-Received: by 10.28.129.69 with SMTP id c66mr38913551wmd.29.1514923590192;
        Tue, 02 Jan 2018 12:06:30 -0800 (PST)
Received: from localhost.localdomain ([160.89.138.198])
        by smtp.gmail.com with ESMTPSA id m70sm19128526wma.36.2018.01.02.12.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 12:06:29 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v7 03/10] module: use relative references for __ksymtab entries
Date:   Tue,  2 Jan 2018 20:05:42 +0000
Message-Id: <20180102200549.22984-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
entries, each consisting of two 64-bit fields containing absolute
references, to the symbol itself and to a char array containing
its name, respectively.

When we build the same configuration with KASLR enabled, we end
up with an additional ~192 KB of relocations in the .init section,
i.e., one 24 byte entry for each absolute reference, which all need
to be processed at boot time.

Given how the struct kernel_symbol that describes each entry is
completely local to module.c (except for the references emitted
by EXPORT_SYMBOL() itself), we can easily modify it to contain
two 32-bit relative references instead. This reduces the size of
the __ksymtab section by 50% for all 64-bit architectures, and
gets rid of the runtime relocations entirely for architectures
implementing KASLR, either via standard PIE linking (arm64) or
using custom host tools (x86).

Note that the binary search involving __ksymtab contents relies
on each section being sorted by symbol name. This is implemented
based on the input section names, not the names in the ksymtab
entries, so this patch does not interfere with that.

Given that the use of place-relative relocations requires support
both in the toolchain and in the module loader, we cannot enable
this feature for all architectures. So make it dependent on whether
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is defined.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Nicolas Pitre <nico@linaro.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/Kbuild   |  1 +
 arch/x86/include/asm/export.h |  5 ---
 include/asm-generic/export.h  | 12 ++++-
 include/linux/compiler.h      | 10 +++++
 include/linux/export.h        | 46 +++++++++++++++-----
 kernel/module.c               | 33 +++++++++++---
 6 files changed, 83 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 5d6a53fd7521..3e8a88dcaa1d 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -9,5 +9,6 @@ generated-y += xen-hypercalls.h
 generic-y += clkdev.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
+generic-y += export.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/x86/include/asm/export.h b/arch/x86/include/asm/export.h
deleted file mode 100644
index 2a51d66689c5..000000000000
--- a/arch/x86/include/asm/export.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifdef CONFIG_64BIT
-#define KSYM_ALIGN 16
-#endif
-#include <asm-generic/export.h>
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 719db1968d81..97ce606459ae 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -5,12 +5,10 @@
 #define KSYM_FUNC(x) x
 #endif
 #ifdef CONFIG_64BIT
-#define __put .quad
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 8
 #endif
 #else
-#define __put .long
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 4
 #endif
@@ -25,6 +23,16 @@
 #define KSYM(name) name
 #endif
 
+.macro __put, val, name
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	.long	\val - ., \name - .
+#elif defined(CONFIG_64BIT)
+	.quad	\val, \name
+#else
+	.long	\val, \name
+#endif
+.endm
+
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 52e611ab9a6c..79db4aa87d75 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -327,4 +327,14 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
+/*
+ * Force the compiler to emit 'sym' as a symbol, so that we can reference
+ * it from inline assembler. Necessary in case 'sym' could be inlined
+ * otherwise, or eliminated entirely due to lack of references that are
+ * visible to the compiler.
+ */
+#define __ADDRESSABLE(sym) \
+	static void * const __attribute__((section(".discard"), used))	\
+		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/export.h b/include/linux/export.h
index 6dba2fb08f77..4744cf4736b0 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -24,12 +24,6 @@
 #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
 
 #ifndef __ASSEMBLY__
-struct kernel_symbol
-{
-	unsigned long value;
-	const char *name;
-};
-
 #ifdef MODULE
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
@@ -60,17 +54,47 @@ extern struct module __this_module;
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#include <linux/compiler.h>
+/*
+ * Emit the ksymtab entry as a pair of relative references: this reduces
+ * the size by half on 64-bit architectures, and eliminates the need for
+ * absolute relocations that require runtime processing on relocatable
+ * kernels.
+ */
+#define __KSYMTAB_ENTRY(sym, sec)					\
+	__ADDRESSABLE(sym)						\
+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.balign	8					\n"	\
+	    VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(sym) "- .		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"	\
+	    "	.previous					\n")
+
+struct kernel_symbol {
+	int value_offset;
+	int name_offset;
+};
+#else
+#define __KSYMTAB_ENTRY(sym, sec)					\
+	static const struct kernel_symbol __ksymtab_##sym		\
+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
+	= { (unsigned long)&sym, __kstrtab_##sym }
+
+struct kernel_symbol {
+	unsigned long value;
+	const char *name;
+};
+#endif
+
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define ___EXPORT_SYMBOL(sym, sec)					\
 	extern typeof(sym) sym;						\
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
-	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
 	= VMLINUX_SYMBOL_STR(sym);					\
-	static const struct kernel_symbol __ksymtab_##sym		\
-	__used								\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+	__KSYMTAB_ENTRY(sym, sec)
 
 #if defined(__KSYM_DEPS__)
 
diff --git a/kernel/module.c b/kernel/module.c
index dea01ac9cb74..d3a908ffc42c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -549,12 +549,31 @@ static bool check_symbol(const struct symsearch *syms,
 	return true;
 }
 
+static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return (unsigned long)&sym->value_offset + sym->value_offset;
+#else
+	return sym->value;
+#endif
+}
+
+static const char *kernel_symbol_name(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return (const char *)((unsigned long)&sym->name_offset +
+			      sym->name_offset);
+#else
+	return sym->name;
+#endif
+}
+
 static int cmp_name(const void *va, const void *vb)
 {
 	const char *a;
 	const struct kernel_symbol *b;
 	a = va; b = vb;
-	return strcmp(a, b->name);
+	return strcmp(a, kernel_symbol_name(b));
 }
 
 static bool find_symbol_in_section(const struct symsearch *syms,
@@ -2198,7 +2217,7 @@ void *__symbol_get(const char *symbol)
 		sym = NULL;
 	preempt_enable();
 
-	return sym ? (void *)sym->value : NULL;
+	return sym ? (void *)kernel_symbol_value(sym) : NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
@@ -2228,10 +2247,12 @@ static int verify_export_symbols(struct module *mod)
 
 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
-			if (find_symbol(s->name, &owner, NULL, true, false)) {
+			if (find_symbol(kernel_symbol_name(s), &owner, NULL,
+					true, false)) {
 				pr_err("%s: exports duplicate symbol %s"
 				       " (owned by %s)\n",
-				       mod->name, s->name, module_name(owner));
+				       mod->name, kernel_symbol_name(s),
+				       module_name(owner));
 				return -ENOEXEC;
 			}
 		}
@@ -2280,7 +2301,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 			ksym = resolve_symbol_wait(mod, info, name);
 			/* Ok if resolved.  */
 			if (ksym && !IS_ERR(ksym)) {
-				sym[i].st_value = ksym->value;
+				sym[i].st_value = kernel_symbol_value(ksym);
 				break;
 			}
 
@@ -2540,7 +2561,7 @@ static int is_exported(const char *name, unsigned long value,
 		ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
 	else
 		ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
-	return ks != NULL && ks->value == value;
+	return ks != NULL && kernel_symbol_value(ks) == value;
 }
 
 /* As per nm */
-- 
2.11.0
