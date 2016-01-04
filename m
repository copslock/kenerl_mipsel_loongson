Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 21:30:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22549 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014665AbcADU3aVtfSQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 21:29:30 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 526D8A4FEED57;
        Mon,  4 Jan 2016 20:29:21 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 4 Jan 2016 20:29:24 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 4 Jan 2016 20:29:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Leonid Yegoshin" <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH backport v3.15..v4.1 2/2] MIPS: uaccess: Take EVA into account in [__]clear_user
Date:   Mon, 4 Jan 2016 20:29:04 +0000
Message-ID: <1451939344-21557-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1451939344-21557-1-git-send-email-james.hogan@imgtec.com>
References: <1451939344-21557-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50881
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
---
 arch/mips/include/asm/uaccess.h | 32 ++++++++++++++++++++++----------
 arch/mips/kernel/mips_ksyms.c   |  2 ++
 arch/mips/lib/memset.S          |  2 ++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index d8f7394275af..2d4118499519 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1207,16 +1207,28 @@ __clear_user(void __user *addr, __kernel_size_t size)
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
2.4.10
