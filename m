Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 08:21:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42418 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028474AbcEMGVJmvHeL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 08:21:09 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 5E71DE13BB131;
        Fri, 13 May 2016 07:21:01 +0100 (IST)
Received: from [10.20.78.172] (10.20.78.172) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 13 May 2016
 07:21:02 +0100
Date:   Fri, 13 May 2016 07:20:55 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 2/3] MIPS: ELF: Unify __MIPS_O32_FP64_MUST_BE_ZERO
 definitions
In-Reply-To: <alpine.DEB.2.00.1605121036270.6794@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1605130419500.6794@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1605121036270.6794@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.172]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53425
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

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-elf-fp64-must-be-zero.diff
Index: linux-sfr-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/elf.h	2016-05-12 18:06:18.257061000 +0100
+++ linux-sfr-test/arch/mips/include/asm/elf.h	2016-05-12 18:09:18.739392000 +0100
@@ -211,19 +211,6 @@ typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
 #ifdef CONFIG_32BIT
-
-/*
- * In order to be sure that we don't attempt to execute an O32 binary which
- * requires 64 bit FP (FR=1) on a system which does not support it we refuse
- * to execute any binary which has bits specified by the following macro set
- * in its ELF header flags.
- */
-#ifdef CONFIG_MIPS_O32_FP64_SUPPORT
-# define __MIPS_O32_FP64_MUST_BE_ZERO	0
-#else
-# define __MIPS_O32_FP64_MUST_BE_ZERO	EF_MIPS_FP64
-#endif
-
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
@@ -290,6 +277,18 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 
 #endif /* !defined(ELF_ARCH) */
 
+/*
+ * In order to be sure that we don't attempt to execute an O32 binary which
+ * requires 64 bit FP (FR=1) on a system which does not support it we refuse
+ * to execute any binary which has bits specified by the following macro set
+ * in its ELF header flags.
+ */
+#ifdef CONFIG_MIPS_O32_FP64_SUPPORT
+# define __MIPS_O32_FP64_MUST_BE_ZERO	0
+#else
+# define __MIPS_O32_FP64_MUST_BE_ZERO	EF_MIPS_FP64
+#endif
+
 #define mips_elf_check_machine(x) ((x)->e_machine == EM_MIPS)
 
 #define vmcore_elf32_check_arch mips_elf_check_machine
Index: linux-sfr-test/arch/mips/kernel/binfmt_elfo32.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/binfmt_elfo32.c	2016-05-12 18:06:18.260062000 +0100
+++ linux-sfr-test/arch/mips/kernel/binfmt_elfo32.c	2016-05-12 18:09:18.745397000 +0100
@@ -28,18 +28,6 @@ typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
 /*
- * In order to be sure that we don't attempt to execute an O32 binary which
- * requires 64 bit FP (FR=1) on a system which does not support it we refuse
- * to execute any binary which has bits specified by the following macro set
- * in its ELF header flags.
- */
-#ifdef CONFIG_MIPS_O32_FP64_SUPPORT
-# define __MIPS_O32_FP64_MUST_BE_ZERO	0
-#else
-# define __MIPS_O32_FP64_MUST_BE_ZERO	EF_MIPS_FP64
-#endif
-
-/*
  * This is used to ensure we don't load something for the wrong architecture.
  */
 #define elf_check_arch(hdr)						\
