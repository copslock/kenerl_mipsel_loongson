Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:18:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31767 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992087AbcKGLQwGPETd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:16:52 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5C9B7ABDF38C;
        Mon,  7 Nov 2016 11:16:43 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:16:45 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/10] MIPS: Export memcpy & memset functions alongside their definitions
Date:   Mon, 7 Nov 2016 11:14:15 +0000
Message-ID: <20161107111417.11486-10-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111417.11486-1-paul.burton@imgtec.com>
References: <20161107111417.11486-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55692
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

Now that EXPORT_SYMBOL can be used from assembly source, move the
EXPORT_SYMBOL invocations for the memcpy & memset functions & variants
thereof to be alongside their definitions.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/cavium-octeon/octeon-memcpy.S |  5 +++++
 arch/mips/kernel/mips_ksyms.c           | 24 ------------------------
 arch/mips/lib/memcpy.S                  |  9 +++++++++
 arch/mips/lib/memset.S                  |  5 +++++
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 64e08df..7d96d9c 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -15,6 +15,7 @@
 
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define dst a0
@@ -142,6 +143,7 @@
  * t7 is used as a flag to note inatomic mode.
  */
 LEAF(__copy_user_inatomic)
+EXPORT_SYMBOL(__copy_user_inatomic)
 	b	__copy_user_common
 	 li	t7, 1
 	END(__copy_user_inatomic)
@@ -154,9 +156,11 @@ LEAF(__copy_user_inatomic)
  */
 	.align	5
 LEAF(memcpy)					/* a0=dst a1=src a2=len */
+EXPORT_SYMBOL(memcpy)
 	move	v0, dst				/* return value */
 __memcpy:
 FEXPORT(__copy_user)
+EXPORT_SYMBOL(__copy_user)
 	li	t7, 0				/* not inatomic */
 __copy_user_common:
 	/*
@@ -459,6 +463,7 @@ s_exc:
 
 	.align	5
 LEAF(memmove)
+EXPORT_SYMBOL(memmove)
 	ADD	t0, a0, a2
 	ADD	t1, a1, a2
 	sltu	t0, a1, t0			# dst + len <= src -> memcpy
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index dd65676..c641fd0 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -17,32 +17,8 @@
 #include <asm/fpu.h>
 #include <asm/msa.h>
 
-extern void *__bzero_kernel(void *__s, size_t __count);
-extern void *__bzero(void *__s, size_t __count);
-
-/*
- * String functions
- */
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memmove);
-
 /*
  * Functions that operate on entire pages.  Mostly used by memory management.
  */
 EXPORT_SYMBOL(clear_page);
 EXPORT_SYMBOL(copy_page);
-
-/*
- * Userspace access stuff.
- */
-EXPORT_SYMBOL(__copy_user);
-EXPORT_SYMBOL(__copy_user_inatomic);
-#ifdef CONFIG_EVA
-EXPORT_SYMBOL(__copy_from_user_eva);
-EXPORT_SYMBOL(__copy_in_user_eva);
-EXPORT_SYMBOL(__copy_to_user_eva);
-EXPORT_SYMBOL(__copy_user_inatomic_eva);
-EXPORT_SYMBOL(__bzero_kernel);
-#endif
-EXPORT_SYMBOL(__bzero);
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 6c303a9..c3031f1 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -31,6 +31,7 @@
 
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define dst a0
@@ -622,6 +623,7 @@ SEXC(1)
 
 	.align	5
 LEAF(memmove)
+EXPORT_SYMBOL(memmove)
 	ADD	t0, a0, a2
 	ADD	t1, a1, a2
 	sltu	t0, a1, t0			# dst + len <= src -> memcpy
@@ -674,6 +676,7 @@ LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
  * t6 is used as a flag to note inatomic mode.
  */
 LEAF(__copy_user_inatomic)
+EXPORT_SYMBOL(__copy_user_inatomic)
 	b	__copy_user_common
 	li	t6, 1
 	END(__copy_user_inatomic)
@@ -686,9 +689,11 @@ LEAF(__copy_user_inatomic)
  */
 	.align	5
 LEAF(memcpy)					/* a0=dst a1=src a2=len */
+EXPORT_SYMBOL(memcpy)
 	move	v0, dst				/* return value */
 .L__memcpy:
 FEXPORT(__copy_user)
+EXPORT_SYMBOL(__copy_user)
 	li	t6, 0	/* not inatomic */
 __copy_user_common:
 	/* Legacy Mode, user <-> user */
@@ -704,6 +709,7 @@ __copy_user_common:
  */
 
 LEAF(__copy_user_inatomic_eva)
+EXPORT_SYMBOL(__copy_user_inatomic_eva)
 	b       __copy_from_user_common
 	li	t6, 1
 	END(__copy_user_inatomic_eva)
@@ -713,6 +719,7 @@ LEAF(__copy_user_inatomic_eva)
  */
 
 LEAF(__copy_from_user_eva)
+EXPORT_SYMBOL(__copy_from_user_eva)
 	li	t6, 0	/* not inatomic */
 __copy_from_user_common:
 	__BUILD_COPY_USER EVA_MODE USEROP KERNELOP
@@ -725,6 +732,7 @@ END(__copy_from_user_eva)
  */
 
 LEAF(__copy_to_user_eva)
+EXPORT_SYMBOL(__copy_to_user_eva)
 __BUILD_COPY_USER EVA_MODE KERNELOP USEROP
 END(__copy_to_user_eva)
 
@@ -733,6 +741,7 @@ END(__copy_to_user_eva)
  */
 
 LEAF(__copy_in_user_eva)
+EXPORT_SYMBOL(__copy_in_user_eva)
 __BUILD_COPY_USER EVA_MODE USEROP USEROP
 END(__copy_in_user_eva)
 
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 18a1ccd..a145666 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -10,6 +10,7 @@
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #if LONGSIZE == 4
@@ -270,6 +271,7 @@
  */
 
 LEAF(memset)
+EXPORT_SYMBOL(memset)
 	beqz		a1, 1f
 	move		v0, a0			/* result */
 
@@ -285,13 +287,16 @@ LEAF(memset)
 1:
 #ifndef CONFIG_EVA
 FEXPORT(__bzero)
+EXPORT_SYMBOL(__bzero)
 #else
 FEXPORT(__bzero_kernel)
+EXPORT_SYMBOL(__bzero_kernel)
 #endif
 	__BUILD_BZERO LEGACY_MODE
 
 #ifdef CONFIG_EVA
 LEAF(__bzero)
+EXPORT_SYMBOL(__bzero)
 	__BUILD_BZERO EVA_MODE
 END(__bzero)
 #endif
-- 
2.10.2
