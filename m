Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:28:53 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43592 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867245AbaA0UXjt-Wn2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:39 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 27/58] MIPS: asm: uaccess: Rename {get,put}_user_asm macros
Date:   Mon, 27 Jan 2014 20:19:14 +0000
Message-ID: <1390853985-14246-28-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_39
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39144
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

The {get,put}_user_asm functions can be used to load data from
kernel or the user address space so rename them to avoid
confusion.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uaccess.h | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 522fc41..59bbebb 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -248,20 +248,20 @@ struct __large_struct { unsigned long buf[100]; };
 #define __get_kernel_common(val, size, ptr)				\
 do {									\
 	switch (size) {							\
-	case 1: __get_user_asm(val, _loadb, ptr); break;		\
-	case 2: __get_user_asm(val, _loadh, ptr); break;		\
-	case 4: __get_user_asm(val, _loadw, ptr); break;		\
-	case 8: __GET_USER_DW(val, _loadd, ptr); break;			\
+	case 1: __get_data_asm(val, _loadb, ptr); break;		\
+	case 2: __get_data_asm(val, _loadh, ptr); break;		\
+	case 4: __get_data_asm(val, _loadw, ptr); break;		\
+	case 8: __GET_DW(val, _loadd, ptr); break;			\
 	default: __get_user_unknown(); break;				\
 	}								\
 } while (0)
 #endif
 
 #ifdef CONFIG_32BIT
-#define __GET_USER_DW(val, insn, ptr) __get_user_asm_ll32(val, insn, ptr)
+#define __GET_DW(val, insn, ptr) __get_data_asm_ll32(val, insn, ptr)
 #endif
 #ifdef CONFIG_64BIT
-#define __GET_USER_DW(val, insn, ptr) __get_user_asm(val, insn, ptr)
+#define __GET_DW(val, insn, ptr) __get_data_asm(val, insn, ptr)
 #endif
 
 extern void __get_user_unknown(void);
@@ -269,10 +269,10 @@ extern void __get_user_unknown(void);
 #define __get_user_common(val, size, ptr)				\
 do {									\
 	switch (size) {							\
-	case 1: __get_user_asm(val, user_lb, ptr); break;		\
-	case 2: __get_user_asm(val, user_lh, ptr); break;		\
-	case 4: __get_user_asm(val, user_lw, ptr); break;		\
-	case 8: __GET_USER_DW(val, user_ld, ptr); break;		\
+	case 1: __get_data_asm(val, user_lb, ptr); break;		\
+	case 2: __get_data_asm(val, user_lh, ptr); break;		\
+	case 4: __get_data_asm(val, user_lw, ptr); break;		\
+	case 8: __GET_DW(val, user_ld, ptr); break;			\
 	default: __get_user_unknown(); break;				\
 	}								\
 } while (0)
@@ -306,7 +306,7 @@ do {									\
 	__gu_err;							\
 })
 
-#define __get_user_asm(val, insn, addr)					\
+#define __get_data_asm(val, insn, addr)					\
 {									\
 	long __gu_tmp;							\
 									\
@@ -330,7 +330,7 @@ do {									\
 /*
  * Get a long long 64 using 32 bit registers.
  */
-#define __get_user_asm_ll32(val, insn, addr)				\
+#define __get_data_asm_ll32(val, insn, addr)				\
 {									\
 	union {								\
 		unsigned long long	l;				\
@@ -364,7 +364,7 @@ do {									\
 /*
  * Kernel specific functions for EVA. We need to use normal load instructions
  * to read data from kernel when operating in EVA mode. We use these macros to
- * avoid redefining __get_user_asm for EVA.
+ * avoid redefining __get_data_asm for EVA.
  */
 #undef _stored
 #undef _storew
@@ -383,10 +383,10 @@ do {									\
 #define __put_kernel_common(ptr, size)					\
 do {									\
 	switch (size) {							\
-	case 1: __put_user_asm(_storeb, ptr); break;			\
-	case 2: __put_user_asm(_storeh, ptr); break;			\
-	case 4: __put_user_asm(_storew, ptr); break;			\
-	case 8: __PUT_USER_DW(_stored, ptr); break;			\
+	case 1: __put_data_asm(_storeb, ptr); break;			\
+	case 2: __put_data_asm(_storeh, ptr); break;			\
+	case 4: __put_data_asm(_storew, ptr); break;			\
+	case 8: __PUT_DW(_stored, ptr); break;				\
 	default: __put_user_unknown(); break;				\
 	}								\
 } while(0)
@@ -397,19 +397,19 @@ do {									\
  * for 32 bit mode and old iron.
  */
 #ifdef CONFIG_32BIT
-#define __PUT_USER_DW(insn, ptr) __put_user_asm_ll32(insn, ptr)
+#define __PUT_DW(insn, ptr) __put_data_asm_ll32(insn, ptr)
 #endif
 #ifdef CONFIG_64BIT
-#define __PUT_USER_DW(insn, ptr) __put_user_asm(insn, ptr)
+#define __PUT_DW(insn, ptr) __put_data_asm(insn, ptr)
 #endif
 
 #define __put_user_common(ptr, size)					\
 do {									\
 	switch (size) {							\
-	case 1: __put_user_asm(user_sb, ptr); break;			\
-	case 2: __put_user_asm(user_sh, ptr); break;			\
-	case 4: __put_user_asm(user_sw, ptr); break;			\
-	case 8: __PUT_USER_DW(user_sd, ptr); break;			\
+	case 1: __put_data_asm(user_sb, ptr); break;			\
+	case 2: __put_data_asm(user_sh, ptr); break;			\
+	case 4: __put_data_asm(user_sw, ptr); break;			\
+	case 8: __PUT_DW(user_sd, ptr); break;				\
 	default: __put_user_unknown(); break;				\
 	}								\
 } while (0)
@@ -446,10 +446,10 @@ do {									\
 	__pu_err;							\
 })
 
-#define __put_user_asm(insn, ptr)					\
+#define __put_data_asm(insn, ptr)					\
 {									\
 	__asm__ __volatile__(						\
-	"1:	"insn("%z2", "%3")"	# __put_user_asm	\n"	\
+	"1:	"insn("%z2", "%3")"	# __put_data_asm	\n"	\
 	"2:							\n"	\
 	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
@@ -464,10 +464,10 @@ do {									\
 	  "i" (-EFAULT));						\
 }
 
-#define __put_user_asm_ll32(insn, ptr)					\
+#define __put_data_asm_ll32(insn, ptr)					\
 {									\
 	__asm__ __volatile__(						\
-	"1:	"insn("%2", "(%3)")"	# __put_user_asm_ll32	\n"	\
+	"1:	"insn("%2", "(%3)")"	# __put_data_asm_ll32	\n"	\
 	"2:	"insn("%D2", "4(%3)")"				\n"	\
 	"3:							\n"	\
 	"	.insn						\n"	\
@@ -593,7 +593,7 @@ extern void __get_user_unaligned_unknown(void);
 #define __get_user_unaligned_common(val, size, ptr)			\
 do {									\
 	switch (size) {							\
-	case 1: __get_user_asm(val, "lb", ptr); break;			\
+	case 1: __get_data_asm(val, "lb", ptr); break;			\
 	case 2: __get_user_unaligned_asm(val, "ulh", ptr); break;	\
 	case 4: __get_user_unaligned_asm(val, "ulw", ptr); break;	\
 	case 8: __GET_USER_UNALIGNED_DW(val, ptr); break;		\
@@ -620,7 +620,7 @@ do {									\
 	__gu_err;							\
 })
 
-#define __get_user_unaligned_asm(val, insn, addr)			\
+#define __get_data_unaligned_asm(val, insn, addr)			\
 {									\
 	long __gu_tmp;							\
 									\
@@ -686,7 +686,7 @@ do {									\
 #define __put_user_unaligned_common(ptr, size)				\
 do {									\
 	switch (size) {							\
-	case 1: __put_user_asm("sb", ptr); break;			\
+	case 1: __put_data_asm("sb", ptr); break;			\
 	case 2: __put_user_unaligned_asm("ush", ptr); break;		\
 	case 4: __put_user_unaligned_asm("usw", ptr); break;		\
 	case 8: __PUT_USER_UNALIGNED_DW(ptr); break;			\
-- 
1.8.5.3
