Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:28:13 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43590 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835374AbaA0UXdsyiJW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:33 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 24/58] MIPS: asm: uaccess: Move duplicated code to common function
Date:   Mon, 27 Jan 2014 20:19:11 +0000
Message-ID: <1390853985-14246-25-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_28
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39142
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

Similar to __get_user_* functions, move common code to
__put_user_*_common so it can be shared among similar users.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uaccess.h | 61 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 5ba3933..0df57e7 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -326,13 +326,8 @@ do {									\
 #define __PUT_USER_DW(insn, ptr) __put_user_asm("sd", ptr)
 #endif
 
-#define __put_user_nocheck(x, ptr, size)				\
-({									\
-	__typeof__(*(ptr)) __pu_val;					\
-	int __pu_err = 0;						\
-									\
-	__chk_user_ptr(ptr);						\
-	__pu_val = (x);							\
+#define __put_user_common(ptr, size)					\
+do {									\
 	switch (size) {							\
 	case 1: __put_user_asm("sb", ptr); break;			\
 	case 2: __put_user_asm("sh", ptr); break;			\
@@ -340,6 +335,16 @@ do {									\
 	case 8: __PUT_USER_DW("sw", ptr); break;			\
 	default: __put_user_unknown(); break;				\
 	}								\
+} while (0)
+
+#define __put_user_nocheck(x, ptr, size)				\
+({									\
+	__typeof__(*(ptr)) __pu_val;					\
+	int __pu_err = 0;						\
+									\
+	__chk_user_ptr(ptr);						\
+	__pu_val = (x);							\
+	__put_user_common(ptr, size);					\
 	__pu_err;							\
 })
 
@@ -350,15 +355,9 @@ do {									\
 	int __pu_err = -EFAULT;						\
 									\
 	might_fault();							\
-	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size))) {	\
-		switch (size) {						\
-		case 1: __put_user_asm("sb", __pu_addr); break;		\
-		case 2: __put_user_asm("sh", __pu_addr); break;		\
-		case 4: __put_user_asm("sw", __pu_addr); break;		\
-		case 8: __PUT_USER_DW("sw", __pu_addr); break;		\
-		default: __put_user_unknown(); break;			\
-		}							\
-	}								\
+	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size)))		\
+		__put_user_common(__pu_addr, size);			\
+									\
 	__pu_err;							\
 })
 
@@ -594,19 +593,23 @@ do {									\
 #define __PUT_USER_UNALIGNED_DW(ptr) __put_user_unaligned_asm("usd", ptr)
 #endif
 
-#define __put_user_unaligned_nocheck(x,ptr,size)			\
-({									\
-	__typeof__(*(ptr)) __pu_val;					\
-	int __pu_err = 0;						\
-									\
-	__pu_val = (x);							\
+#define __put_user_unaligned_common(ptr, size)				\
+do {									\
 	switch (size) {							\
 	case 1: __put_user_asm("sb", ptr); break;			\
 	case 2: __put_user_unaligned_asm("ush", ptr); break;		\
 	case 4: __put_user_unaligned_asm("usw", ptr); break;		\
 	case 8: __PUT_USER_UNALIGNED_DW(ptr); break;			\
 	default: __put_user_unaligned_unknown(); break;			\
-	}								\
+} while (0)
+
+#define __put_user_unaligned_nocheck(x,ptr,size)			\
+({									\
+	__typeof__(*(ptr)) __pu_val;					\
+	int __pu_err = 0;						\
+									\
+	__pu_val = (x);							\
+	__put_user_unaligned_common(ptr, size);				\
 	__pu_err;							\
 })
 
@@ -616,15 +619,9 @@ do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
 	int __pu_err = -EFAULT;						\
 									\
-	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size))) {	\
-		switch (size) {						\
-		case 1: __put_user_asm("sb", __pu_addr); break;		\
-		case 2: __put_user_unaligned_asm("ush", __pu_addr); break; \
-		case 4: __put_user_unaligned_asm("usw", __pu_addr); break; \
-		case 8: __PUT_USER_UNALGINED_DW(__pu_addr); break;	\
-		default: __put_user_unaligned_unknown(); break;		\
-		}							\
-	}								\
+	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size)))		\
+		__put_user_unaligned_common(__pu_addr, size);		\
+									\
 	__pu_err;							\
 })
 
-- 
1.8.5.3
