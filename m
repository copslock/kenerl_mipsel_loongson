Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 08:21:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14919 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028474AbcEMGVzS51JL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 08:21:55 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4B433AF214303;
        Fri, 13 May 2016 07:21:46 +0100 (IST)
Received: from [10.20.78.172] (10.20.78.172) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 13 May 2016
 07:21:47 +0100
Date:   Fri, 13 May 2016 07:21:40 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 3/3] MIPS: ELF: Unify ABI classification macros
In-Reply-To: <alpine.DEB.2.00.1605121036270.6794@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1605130357500.6794@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1605121036270.6794@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.172]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Remove a duplicate o32 `elf_check_arch' implementation, move all macro 
variants to <asm/elf.h> and define them unconditionally under indvidual 
names, substituting alias `elf_check_arch' definitions in variant code.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-elf-check-arch.diff
Index: linux-sfr-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/elf.h	2016-05-12 19:24:09.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/elf.h	2016-05-13 02:47:23.868157000 +0100
@@ -214,25 +214,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(hdr)						\
-({									\
-	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
-									\
-	if (!mips_elf_check_machine(__h))				\
-		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
-		__res = 0;						\
-	if ((__h->e_flags & EF_MIPS_ABI2) != 0)				\
-		__res = 0;						\
-	if (((__h->e_flags & EF_MIPS_ABI) != 0) &&			\
-	    ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))		\
-		__res = 0;						\
-	if (__h->e_flags & __MIPS_O32_FP64_MUST_BE_ZERO)		\
-		__res = 0;						\
-									\
-	__res;								\
-})
+#define elf_check_arch elfo32_check_arch
 
 /*
  * These are used to set parameters in the core dumps.
@@ -245,18 +227,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(hdr)						\
-({									\
-	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
-									\
-	if (!mips_elf_check_machine(__h))				\
-		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
-		__res = 0;						\
-									\
-	__res;								\
-})
+#define elf_check_arch elfn64_check_arch
 
 /*
  * These are used to set parameters in the core dumps.
@@ -294,6 +265,64 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 #define vmcore_elf32_check_arch mips_elf_check_machine
 #define vmcore_elf64_check_arch mips_elf_check_machine
 
+/*
+ * Return non-zero if HDR identifies an o32 ELF binary.
+ */
+#define elfo32_check_arch(hdr)						\
+({									\
+	int __res = 1;							\
+	struct elfhdr *__h = (hdr);					\
+									\
+	if (!mips_elf_check_machine(__h))				\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
+		__res = 0;						\
+	if ((__h->e_flags & EF_MIPS_ABI2) != 0)				\
+		__res = 0;						\
+	if (((__h->e_flags & EF_MIPS_ABI) != 0) &&			\
+	    ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))		\
+		__res = 0;						\
+	if (__h->e_flags & __MIPS_O32_FP64_MUST_BE_ZERO)		\
+		__res = 0;						\
+									\
+	__res;								\
+})
+
+/*
+ * Return non-zero if HDR identifies an n64 ELF binary.
+ */
+#define elfn64_check_arch(hdr)						\
+({									\
+	int __res = 1;							\
+	struct elfhdr *__h = (hdr);					\
+									\
+	if (!mips_elf_check_machine(__h))				\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
+		__res = 0;						\
+									\
+	__res;								\
+})
+
+/*
+ * Return non-zero if HDR identifies an n32 ELF binary.
+ */
+#define elfn32_check_arch(hdr)						\
+({									\
+	int __res = 1;							\
+	struct elfhdr *__h = (hdr);					\
+									\
+	if (!mips_elf_check_machine(__h))				\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
+		__res = 0;						\
+	if (((__h->e_flags & EF_MIPS_ABI2) == 0) ||			\
+	    ((__h->e_flags & EF_MIPS_ABI) != 0))			\
+		__res = 0;						\
+									\
+	__res;								\
+})
+
 struct mips_abi;
 
 extern struct mips_abi mips_abi;
Index: linux-sfr-test/arch/mips/kernel/binfmt_elfn32.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/binfmt_elfn32.c	2016-05-13 02:48:27.667690000 +0100
+++ linux-sfr-test/arch/mips/kernel/binfmt_elfn32.c	2016-05-13 02:37:06.394017000 +0100
@@ -30,21 +30,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(hdr)						\
-({									\
-	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
-									\
-	if (!mips_elf_check_machine(__h))				\
-		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
-		__res = 0;						\
-	if (((__h->e_flags & EF_MIPS_ABI2) == 0) ||			\
-	    ((__h->e_flags & EF_MIPS_ABI) != 0))			\
-		__res = 0;						\
-									\
-	__res;								\
-})
+#define elf_check_arch elfn32_check_arch
 
 #define TASK32_SIZE		0x7fff8000UL
 #undef ELF_ET_DYN_BASE
Index: linux-sfr-test/arch/mips/kernel/binfmt_elfo32.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/binfmt_elfo32.c	2016-05-12 19:24:09.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/binfmt_elfo32.c	2016-05-13 02:36:37.589772000 +0100
@@ -30,25 +30,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(hdr)						\
-({									\
-	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
-									\
-	if (!mips_elf_check_machine(__h))				\
-		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
-		__res = 0;						\
-	if ((__h->e_flags & EF_MIPS_ABI2) != 0)				\
-		__res = 0;						\
-	if (((__h->e_flags & EF_MIPS_ABI) != 0) &&			\
-	    ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))		\
-		__res = 0;						\
-	if (__h->e_flags & __MIPS_O32_FP64_MUST_BE_ZERO)		\
-		__res = 0;						\
-									\
-	__res;								\
-})
+#define elf_check_arch elfo32_check_arch
 
 #ifdef CONFIG_KVM_GUEST
 #define TASK32_SIZE		0x3fff8000UL
