Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:27:54 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43587 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860900AbaA0UXJ3Kjfq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:09 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 23/58] MIPS: asm: uaccess: Add instruction argument to __{put,get}_user_asm
Date:   Mon, 27 Jan 2014 20:19:10 +0000
Message-ID: <1390853985-14246-24-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_04
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39141
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

In preparation for EVA support, an instruction argument is needed
for the __get_user_asm{,_ll32} functions to allow instruction overrides in
EVA mode. Even though EVA only works for MIPS 32-bit, both codepaths are
changed (32-bit and 64-bit) for consistency reasons.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uaccess.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index f3fa375..5ba3933 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -223,10 +223,10 @@ struct __large_struct { unsigned long buf[100]; };
  * for 32 bit mode and old iron.
  */
 #ifdef CONFIG_32BIT
-#define __GET_USER_DW(val, ptr) __get_user_asm_ll32(val, ptr)
+#define __GET_USER_DW(val, insn, ptr) __get_user_asm_ll32(val, insn, ptr)
 #endif
 #ifdef CONFIG_64BIT
-#define __GET_USER_DW(val, ptr) __get_user_asm(val, "ld", ptr)
+#define __GET_USER_DW(val, insn, ptr) __get_user_asm(val, "ld", ptr)
 #endif
 
 extern void __get_user_unknown(void);
@@ -237,7 +237,7 @@ do {									\
 	case 1: __get_user_asm(val, "lb", ptr); break;			\
 	case 2: __get_user_asm(val, "lh", ptr); break;			\
 	case 4: __get_user_asm(val, "lw", ptr); break;			\
-	case 8: __GET_USER_DW(val, ptr); break;				\
+	case 8: __GET_USER_DW(val, "lw", ptr); break;			\
 	default: __get_user_unknown(); break;				\
 	}								\
 } while (0)
@@ -287,7 +287,7 @@ do {									\
 /*
  * Get a long long 64 using 32 bit registers.
  */
-#define __get_user_asm_ll32(val, addr)					\
+#define __get_user_asm_ll32(val, insn, addr)				\
 {									\
 	union {								\
 		unsigned long long	l;				\
@@ -295,8 +295,8 @@ do {									\
 	} __gu_tmp;							\
 									\
 	__asm__ __volatile__(						\
-	"1:	lw	%1, (%3)				\n"	\
-	"2:	lw	%D1, 4(%3)				\n"	\
+	"1:	" insn "	%1, (%3)			\n"	\
+	"2:	" insn "	%D1, 4(%3)			\n"	\
 	"3:							\n"	\
 	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
@@ -320,10 +320,10 @@ do {									\
  * for 32 bit mode and old iron.
  */
 #ifdef CONFIG_32BIT
-#define __PUT_USER_DW(ptr) __put_user_asm_ll32(ptr)
+#define __PUT_USER_DW(insn, ptr) __put_user_asm_ll32(insn, ptr)
 #endif
 #ifdef CONFIG_64BIT
-#define __PUT_USER_DW(ptr) __put_user_asm("sd", ptr)
+#define __PUT_USER_DW(insn, ptr) __put_user_asm("sd", ptr)
 #endif
 
 #define __put_user_nocheck(x, ptr, size)				\
@@ -337,7 +337,7 @@ do {									\
 	case 1: __put_user_asm("sb", ptr); break;			\
 	case 2: __put_user_asm("sh", ptr); break;			\
 	case 4: __put_user_asm("sw", ptr); break;			\
-	case 8: __PUT_USER_DW(ptr); break;				\
+	case 8: __PUT_USER_DW("sw", ptr); break;			\
 	default: __put_user_unknown(); break;				\
 	}								\
 	__pu_err;							\
@@ -355,7 +355,7 @@ do {									\
 		case 1: __put_user_asm("sb", __pu_addr); break;		\
 		case 2: __put_user_asm("sh", __pu_addr); break;		\
 		case 4: __put_user_asm("sw", __pu_addr); break;		\
-		case 8: __PUT_USER_DW(__pu_addr); break;		\
+		case 8: __PUT_USER_DW("sw", __pu_addr); break;		\
 		default: __put_user_unknown(); break;			\
 		}							\
 	}								\
@@ -380,11 +380,11 @@ do {									\
 	  "i" (-EFAULT));						\
 }
 
-#define __put_user_asm_ll32(ptr)					\
+#define __put_user_asm_ll32(insn, ptr)					\
 {									\
 	__asm__ __volatile__(						\
-	"1:	sw	%2, (%3)	# __put_user_asm_ll32	\n"	\
-	"2:	sw	%D2, 4(%3)				\n"	\
+	"1:	" insn "	%2, (%3)# __put_user_asm_ll32	\n"	\
+	"2:	" insn "	%D2, 4(%3)			\n"	\
 	"3:							\n"	\
 	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
-- 
1.8.5.3
