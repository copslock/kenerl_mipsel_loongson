Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:17:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46655 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992043AbcKGLQWvePLd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:16:22 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7D8858573BA38;
        Mon,  7 Nov 2016 11:16:14 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:16:16 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/10] MIPS: Export csum functions alongside their definitions
Date:   Mon, 7 Nov 2016 11:14:13 +0000
Message-ID: <20161107111417.11486-8-paul.burton@imgtec.com>
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
X-archive-position: 55690
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
EXPORT_SYMBOL invocations for the csum_partial_* functions to be
alongside their definitions.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/mips_ksyms.c | 8 --------
 arch/mips/lib/csum_partial.S  | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index ed571bc..3ba65d7 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -70,11 +70,3 @@ EXPORT_SYMBOL(__strnlen_kernel_nocheck_asm);
 EXPORT_SYMBOL(__strnlen_kernel_asm);
 EXPORT_SYMBOL(__strnlen_user_nocheck_asm);
 EXPORT_SYMBOL(__strnlen_user_asm);
-
-#ifndef CONFIG_CPU_MIPSR6
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
-EXPORT_SYMBOL(__csum_partial_copy_kernel);
-EXPORT_SYMBOL(__csum_partial_copy_to_user);
-EXPORT_SYMBOL(__csum_partial_copy_from_user);
-#endif
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index ed88647..2ff84f4 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #ifdef CONFIG_64BIT
@@ -103,6 +104,7 @@
 	.set	noreorder
 	.align	5
 LEAF(csum_partial)
+EXPORT_SYMBOL(csum_partial)
 	move	sum, zero
 	move	t7, zero
 
@@ -460,6 +462,7 @@ LEAF(csum_partial)
 #endif
 	.if \__nocheck == 1
 	FEXPORT(csum_partial_copy_nocheck)
+	EXPORT_SYMBOL(csum_partial_copy_nocheck)
 	.endif
 	move	sum, zero
 	move	odd, zero
@@ -823,9 +826,12 @@ LEAF(csum_partial)
 	.endm
 
 LEAF(__csum_partial_copy_kernel)
+EXPORT_SYMBOL(__csum_partial_copy_kernel)
 #ifndef CONFIG_EVA
 FEXPORT(__csum_partial_copy_to_user)
+EXPORT_SYMBOL(__csum_partial_copy_to_user)
 FEXPORT(__csum_partial_copy_from_user)
+EXPORT_SYMBOL(__csum_partial_copy_from_user)
 #endif
 __BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP 1
 END(__csum_partial_copy_kernel)
-- 
2.10.2
