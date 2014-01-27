Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:29:50 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43605 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870550AbaA0UXuRCT6A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:50 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 29/58] MIPS: asm: uaccess: Add EVA support for str*_user operations
Date:   Mon, 27 Jan 2014 20:19:16 +0000
Message-ID: <1390853985-14246-30-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_45
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39147
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

The str*_user functions are used to securely access NULL terminated
strings from userland. Therefore, it's necessary to use the appropriate
EVA function. However, if the string is in kernel space, then the normal
instructions are being used to access it. The __str*_kernel_asm and
__str*_user_asm symbols are the same for non-EVA mode so there is no
functional change for the non-EVA kernels.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uaccess.h | 172 +++++++++++++++++++++++++++-------------
 1 file changed, 119 insertions(+), 53 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index fe72837..da52765 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1246,16 +1246,28 @@ __strncpy_from_user(char *__to, const char __user *__from, long __len)
 {
 	long res;
 
-	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		"move\t$5, %2\n\t"
-		"move\t$6, %3\n\t"
-		__MODULE_JAL(__strncpy_from_user_nocheck_asm)
-		"move\t%0, $2"
-		: "=r" (res)
-		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
+	if (segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			"move\t$6, %3\n\t"
+			__MODULE_JAL(__strncpy_from_kernel_nocheck_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (__to), "r" (__from), "r" (__len)
+			: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
+	} else {
+		might_fault();
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			"move\t$6, %3\n\t"
+			__MODULE_JAL(__strncpy_from_user_nocheck_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (__to), "r" (__from), "r" (__len)
+			: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
+	}
 
 	return res;
 }
@@ -1283,16 +1295,28 @@ strncpy_from_user(char *__to, const char __user *__from, long __len)
 {
 	long res;
 
-	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		"move\t$5, %2\n\t"
-		"move\t$6, %3\n\t"
-		__MODULE_JAL(__strncpy_from_user_asm)
-		"move\t%0, $2"
-		: "=r" (res)
-		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
+	if (segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			"move\t$6, %3\n\t"
+			__MODULE_JAL(__strncpy_from_kernel_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (__to), "r" (__from), "r" (__len)
+			: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
+	} else {
+		might_fault();
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			"move\t$6, %3\n\t"
+			__MODULE_JAL(__strncpy_from_user_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (__to), "r" (__from), "r" (__len)
+			: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
+	}
 
 	return res;
 }
@@ -1302,14 +1326,24 @@ static inline long __strlen_user(const char __user *s)
 {
 	long res;
 
-	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		__MODULE_JAL(__strlen_user_nocheck_asm)
-		"move\t%0, $2"
-		: "=r" (res)
-		: "r" (s)
-		: "$2", "$4", __UA_t0, "$31");
+	if (segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			__MODULE_JAL(__strlen_kernel_nocheck_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s)
+			: "$2", "$4", __UA_t0, "$31");
+	} else {
+		might_fault();
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			__MODULE_JAL(__strlen_user_nocheck_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s)
+			: "$2", "$4", __UA_t0, "$31");
+	}
 
 	return res;
 }
@@ -1332,14 +1366,24 @@ static inline long strlen_user(const char __user *s)
 {
 	long res;
 
-	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		__MODULE_JAL(__strlen_user_asm)
-		"move\t%0, $2"
-		: "=r" (res)
-		: "r" (s)
-		: "$2", "$4", __UA_t0, "$31");
+	if (segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			__MODULE_JAL(__strlen_kernel_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s)
+			: "$2", "$4", __UA_t0, "$31");
+	} else {
+		might_fault();
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			__MODULE_JAL(__strlen_kernel_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s)
+			: "$2", "$4", __UA_t0, "$31");
+	}
 
 	return res;
 }
@@ -1349,15 +1393,26 @@ static inline long __strnlen_user(const char __user *s, long n)
 {
 	long res;
 
-	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		"move\t$5, %2\n\t"
-		__MODULE_JAL(__strnlen_user_nocheck_asm)
-		"move\t%0, $2"
-		: "=r" (res)
-		: "r" (s), "r" (n)
-		: "$2", "$4", "$5", __UA_t0, "$31");
+	if (segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			__MODULE_JAL(__strnlen_kernel_nocheck_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s), "r" (n)
+			: "$2", "$4", "$5", __UA_t0, "$31");
+	} else {
+		might_fault();
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			__MODULE_JAL(__strnlen_user_nocheck_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s), "r" (n)
+			: "$2", "$4", "$5", __UA_t0, "$31");
+	}
 
 	return res;
 }
@@ -1381,14 +1436,25 @@ static inline long strnlen_user(const char __user *s, long n)
 	long res;
 
 	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		"move\t$5, %2\n\t"
-		__MODULE_JAL(__strnlen_user_asm)
-		"move\t%0, $2"
-		: "=r" (res)
-		: "r" (s), "r" (n)
-		: "$2", "$4", "$5", __UA_t0, "$31");
+	if (segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			__MODULE_JAL(__strnlen_kernel_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s), "r" (n)
+			: "$2", "$4", "$5", __UA_t0, "$31");
+	} else {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, %2\n\t"
+			__MODULE_JAL(__strnlen_user_asm)
+			"move\t%0, $2"
+			: "=r" (res)
+			: "r" (s), "r" (n)
+			: "$2", "$4", "$5", __UA_t0, "$31");
+	}
 
 	return res;
 }
-- 
1.8.5.3
