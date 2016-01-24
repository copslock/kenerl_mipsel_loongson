Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jan 2016 23:03:39 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:43026 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011093AbcAXWDUFJXjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jan 2016 23:03:20 +0100
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1aNSkh-0000XW-8S; Sun, 24 Jan 2016 22:03:19 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 051/128] MIPS: uaccess: Take EVA into account in [__]clear_user
Date:   Sun, 24 Jan 2016 22:00:06 +0000
Message-Id: <1453672883-2708-52-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1453672883-2708-1-git-send-email-luis.henriques@canonical.com>
References: <1453672883-2708-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt23 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: James Hogan <james.hogan@imgtec.com>

commit d6a428fb583738ad685c91a684748cdee7b2a05f upstream.

__clear_user() (and clear_user() which uses it), always access the user
mode address space, which results in EVA store instructions when EVA is
enabled even if the current user address limit is KERNEL_DS.

Fix this by adding a new symbol __bzero_kernel for the normal kernel
address space bzero in EVA mode, and call that from __clear_user() if
eva_kernel_access().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10844/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[james.hogan@imgtec.com: backport]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/uaccess.h | 32 ++++++++++++++++++++++----------
 arch/mips/kernel/mips_ksyms.c   |  2 ++
 arch/mips/lib/memset.S          |  2 ++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 81d4d7e012ca..681331257bac 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1204,16 +1204,28 @@ __clear_user(void __user *addr, __kernel_size_t size)
 {
 	__kernel_size_t res;
 
-	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		"move\t$5, $0\n\t"
-		"move\t$6, %2\n\t"
-		__MODULE_JAL(__bzero)
-		"move\t%0, $6"
-		: "=r" (res)
-		: "r" (addr), "r" (size)
-		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+	if (config_enabled(CONFIG_EVA) && segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, $0\n\t"
+			"move\t$6, %2\n\t"
+			__MODULE_JAL(__bzero_kernel)
+			"move\t%0, $6"
+			: "=r" (res)
+			: "r" (addr), "r" (size)
+			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+	} else {
+		might_fault();
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, $0\n\t"
+			"move\t$6, %2\n\t"
+			__MODULE_JAL(__bzero)
+			"move\t%0, $6"
+			: "=r" (res)
+			: "r" (addr), "r" (size)
+			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+	}
 
 	return res;
 }
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 1b2452e2be67..c1e152a27b17 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -17,6 +17,7 @@
 #include <asm/fpu.h>
 #include <asm/msa.h>
 
+extern void *__bzero_kernel(void *__s, size_t __count);
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_kernel_nocheck_asm(char *__to,
 					      const char *__from, long __len);
@@ -66,6 +67,7 @@ EXPORT_SYMBOL(__copy_from_user_eva);
 EXPORT_SYMBOL(__copy_in_user_eva);
 EXPORT_SYMBOL(__copy_to_user_eva);
 EXPORT_SYMBOL(__copy_user_inatomic_eva);
+EXPORT_SYMBOL(__bzero_kernel);
 #endif
 EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm);
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 7b0e5462ca51..fd83406ceccc 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -238,6 +238,8 @@ LEAF(memset)
 1:
 #ifndef CONFIG_EVA
 FEXPORT(__bzero)
+#else
+FEXPORT(__bzero_kernel)
 #endif
 	__BUILD_BZERO LEGACY_MODE
 
