Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:31:02 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43627 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870553AbaA0UYGdYSpJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:06 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 32/58] MIPS: checksum: Split the 'copy_user' symbol
Date:   Mon, 27 Jan 2014 20:19:19 +0000
Message-ID: <1390853985-14246-33-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_24_01
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The 'copy_user' symbol can be used to copy from or to
userland so we will use two different symbols for these
operations. This makes no difference in the existing code,
but when the core is operating in EVA mode, different instructions
need to be used to read and write to userland address space.
The old function has also been renamed to 'copy_kernel' to denote
that it is suitable for copy data to and from kernel space.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/checksum.h | 18 ++++++++++++------
 arch/mips/kernel/mips_ksyms.c    |  4 +++-
 arch/mips/lib/csum_partial.S     |  9 ++++++---
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index ac3d2b8..3c9aea5 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -7,6 +7,7 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Copyright (C) 2001 Thiemo Seufer.
  * Copyright (C) 2002 Maciej W. Rozycki
+ * Copyright (C) 2014 Imagination Technologies Ltd.
  */
 #ifndef _ASM_CHECKSUM_H
 #define _ASM_CHECKSUM_H
@@ -29,8 +30,13 @@
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-__wsum __csum_partial_copy_user(const void *src, void *dst,
-				int len, __wsum sum, int *err_ptr);
+__wsum __csum_partial_copy_kernel(const void *src, void *dst,
+				  int len, __wsum sum, int *err_ptr);
+
+__wsum __csum_partial_copy_from_user(const void *src, void *dst,
+				     int len, __wsum sum, int *err_ptr);
+__wsum __csum_partial_copy_to_user(const void *src, void *dst,
+				   int len, __wsum sum, int *err_ptr);
 
 /*
  * this is a new version of the above that records errors it finds in *errp,
@@ -41,8 +47,8 @@ __wsum csum_partial_copy_from_user(const void __user *src, void *dst, int len,
 				   __wsum sum, int *err_ptr)
 {
 	might_fault();
-	return __csum_partial_copy_user((__force void *)src, dst,
-					len, sum, err_ptr);
+	return __csum_partial_copy_from_user((__force void *)src, dst,
+					     len, sum, err_ptr);
 }
 
 /*
@@ -55,8 +61,8 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 {
 	might_fault();
 	if (access_ok(VERIFY_WRITE, dst, len))
-		return __csum_partial_copy_user(src, (__force void *)dst,
-						len, sum, err_ptr);
+		return __csum_partial_copy_to_user(src, (__force void *)dst,
+						   len, sum, err_ptr);
 	if (len)
 		*err_ptr = -EFAULT;
 
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 13e60f6..2607c3a 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -73,7 +73,9 @@ EXPORT_SYMBOL(__strnlen_user_asm);
 
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
-EXPORT_SYMBOL(__csum_partial_copy_user);
+EXPORT_SYMBOL(__csum_partial_copy_kernel);
+EXPORT_SYMBOL(__csum_partial_copy_to_user);
+EXPORT_SYMBOL(__csum_partial_copy_from_user);
 
 EXPORT_SYMBOL(invalid_pte_table);
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index a6adffb..5d73d0d 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -8,6 +8,7 @@
  * Copyright (C) 1998, 1999 Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2014 Imagination Technologies Ltd.
  */
 #include <linux/errno.h>
 #include <asm/asm.h>
@@ -296,7 +297,7 @@ LEAF(csum_partial)
  * checksum and copy routines based on memcpy.S
  *
  *	csum_partial_copy_nocheck(src, dst, len, sum)
- *	__csum_partial_copy_user(src, dst, len, sum, errp)
+ *	__csum_partial_copy_kernel(src, dst, len, sum, errp)
  *
  * See "Spec" in memcpy.S for details.	Unlike __copy_user, all
  * function in this file use the standard calling convention.
@@ -396,7 +397,9 @@ LEAF(csum_partial)
 	.set	at=v1
 #endif
 
-LEAF(__csum_partial_copy_user)
+LEAF(__csum_partial_copy_kernel)
+FEXPORT(__csum_partial_copy_to_user)
+FEXPORT(__csum_partial_copy_from_user)
 	PTR_ADDU	AT, src, len	/* See (1) above. */
 #ifdef CONFIG_64BIT
 	move	errptr, a4
@@ -757,4 +760,4 @@ EXC(	lbu	t1, 0(src),	.Ll_exc)
 	jr	ra
 	 sw	v1, (errptr)
 	.set	pop
-	END(__csum_partial_copy_user)
+	END(__csum_partial_copy_kernel)
-- 
1.8.5.3
