Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:26:35 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43583 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823911AbaA0UW7Z4V-a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:59 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 19/58] MIPS: lib: memcpy: Add EVA support
Date:   Mon, 27 Jan 2014 20:19:06 +0000
Message-ID: <1390853985-14246-20-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_54
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39137
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

Add copy_{to,from,in}_user when the CPU operates in EVA mode.
This is necessary so the EVA specific instructions can be used
to perform the virtual to physical translation for user space
addresses. We will use the non-EVA functions to read from kernel
if needed.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/mips_ksyms.c |  6 ++++
 arch/mips/lib/memcpy.S        | 77 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 675bd05..13e60f6 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -51,6 +51,12 @@ EXPORT_SYMBOL(copy_page);
  */
 EXPORT_SYMBOL(__copy_user);
 EXPORT_SYMBOL(__copy_user_inatomic);
+#ifdef CONFIG_EVA
+EXPORT_SYMBOL(__copy_from_user_eva);
+EXPORT_SYMBOL(__copy_in_user_eva);
+EXPORT_SYMBOL(__copy_to_user_eva);
+EXPORT_SYMBOL(__copy_user_inatomic_eva);
+#endif
 EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm);
 EXPORT_SYMBOL(__strncpy_from_kernel_asm);
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index d630a28..c17ef80 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -114,7 +114,24 @@
 		.section __ex_table,"a";			\
 		PTR	9b, handler;				\
 		.previous;					\
+	/* This is assembled in EVA mode */			\
+	.else;							\
+		/* If loading from user or storing to user */	\
+		.if ((\from == USEROP) && (type == LD_INSN)) || \
+		    ((\to == USEROP) && (type == ST_INSN));	\
+9:			__BUILD_EVA_INSN(insn##e, reg, addr);	\
+			.section __ex_table,"a";		\
+			PTR	9b, handler;			\
+			.previous;				\
+		.else;						\
+			/*					\
+			 *  Still in EVA, but no need for	\
+			 * exception handler or EVA insn	\
+			 */					\
+			insn reg, addr;				\
+		.endif;						\
 	.endif
+
 /*
  * Only on the 64-bit kernel we can made use of 64-bit registers.
  */
@@ -186,6 +203,22 @@
 #define _PREF(hint, addr, type)						\
 	.if \mode == LEGACY_MODE;					\
 		PREF(hint, addr);					\
+	.else;								\
+		.if ((\from == USEROP) && (type == SRC_PREFETCH)) ||	\
+		    ((\to == USEROP) && (type == DST_PREFETCH));	\
+			/*						\
+			 * PREFE has only 9 bits for the offset		\
+			 * compared to PREF which has 16, so it may	\
+			 * need to use the $at register but this	\
+			 * register should remain intact because it's	\
+			 * used later on. Therefore use $v1.		\
+			 */						\
+			.set at=v1;					\
+			PREFE(hint, addr);				\
+			.set noat;					\
+		.else;							\
+			PREF(hint, addr);				\
+		.endif;							\
 	.endif
 
 #define PREFS(hint, addr) _PREF(hint, addr, SRC_PREFETCH)
@@ -636,3 +669,47 @@ FEXPORT(__copy_user)
 __copy_user_common:
 	/* Legacy Mode, user <-> user */
 	__BUILD_COPY_USER LEGACY_MODE USEROP USEROP
+
+#ifdef CONFIG_EVA
+
+/*
+ * For EVA we need distinct symbols for reading and writing to user space.
+ * This is because we need to use specific EVA instructions to perform the
+ * virtual <-> physical translation when a virtual address is actually in user
+ * space
+ */
+
+LEAF(__copy_user_inatomic_eva)
+	b       __copy_from_user_common
+	li	t6, 1
+	END(__copy_user_inatomic_eva)
+
+/*
+ * __copy_from_user (EVA)
+ */
+
+LEAF(__copy_from_user_eva)
+	li	t6, 0	/* not inatomic */
+__copy_from_user_common:
+	__BUILD_COPY_USER EVA_MODE USEROP KERNELOP
+END(__copy_from_user_eva)
+
+
+
+/*
+ * __copy_to_user (EVA)
+ */
+
+LEAF(__copy_to_user_eva)
+__BUILD_COPY_USER EVA_MODE KERNELOP USEROP
+END(__copy_to_user_eva)
+
+/*
+ * __copy_in_user (EVA)
+ */
+
+LEAF(__copy_in_user_eva)
+__BUILD_COPY_USER EVA_MODE USEROP USEROP
+END(__copy_in_user_eva)
+
+#endif
-- 
1.8.5.3
