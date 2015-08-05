Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:43:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27851 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012329AbbHEPmVFzb80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:42:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 025B51BBDC06D;
        Wed,  5 Aug 2015 16:42:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:42:15 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:42:14 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Leonid Yegoshin" <leonid.yegoshin@imgtec.com>
Subject: [PATCH 3/3] MIPS: uaccess: Take EVA into account in [__]clear_user
Date:   Wed, 5 Aug 2015 16:41:39 +0100
Message-ID: <1438789299-1608-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1438789299-1608-1-git-send-email-james.hogan@imgtec.com>
References: <1438789299-1608-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

__clear_user() (and clear_user() which uses it), always access the user
mode address space, which results in EVA store instructions when EVA is
enabled even if the current user address limit is KERNEL_DS.

Fix this by adding a new symbol __bzero_kernel for the normal kernel
address space bzero in EVA mode, and call that from __clear_user() if
eva_kernel_access().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
I've not Cc'd stable on this patch as eva_kernel_access() was only added
in 4.2. I'll submit a backport once it is merged.
---
 arch/mips/include/asm/uaccess.h | 32 ++++++++++++++++++++++----------
 arch/mips/kernel/mips_ksyms.c   |  2 ++
 arch/mips/lib/memset.S          |  2 ++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 5014e187df23..2e3b3991cf0b 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1235,16 +1235,28 @@ __clear_user(void __user *addr, __kernel_size_t size)
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
+	if (eva_kernel_access()) {
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
index 291af0b5c482..e2b6ab74643d 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -17,6 +17,7 @@
 #include <asm/fpu.h>
 #include <asm/msa.h>
 
+extern void *__bzero_kernel(void *__s, size_t __count);
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_kernel_nocheck_asm(char *__to,
 					      const char *__from, long __len);
@@ -64,6 +65,7 @@ EXPORT_SYMBOL(__copy_from_user_eva);
 EXPORT_SYMBOL(__copy_in_user_eva);
 EXPORT_SYMBOL(__copy_to_user_eva);
 EXPORT_SYMBOL(__copy_user_inatomic_eva);
+EXPORT_SYMBOL(__bzero_kernel);
 #endif
 EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm);
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index b8e63fd00375..8f0019a2e5c8 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -283,6 +283,8 @@ LEAF(memset)
 1:
 #ifndef CONFIG_EVA
 FEXPORT(__bzero)
+#else
+FEXPORT(__bzero_kernel)
 #endif
 	__BUILD_BZERO LEGACY_MODE
 
-- 
2.3.6
