Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 May 2013 15:56:37 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:51029 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822668Ab3ERNyxD6Ihw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 May 2013 15:54:53 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 06:54:44 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 5707E630052; Sat, 18 May 2013 06:54:28 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     linux-mips@linux-mips.org
Cc:     kvm@vger.kernel.org, ralf@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 3/4] KVM/MIPS32: Export min_low_pfn.
Date:   Sat, 18 May 2013 06:54:25 -0700
Message-Id: <1368885266-8619-4-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368885266-8619-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368885266-8619-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

The KVM module uses the standard MIPS cache management routines, which use min_low_pfn.
This creates and indirect dependency, requiring min_low_pfn to be exported.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kernel/mips_ksyms.c | 6 ++++++
 arch/mips/kvm/kvm_tlb.c       | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 6e58e97..0299472 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 #include <asm/ftrace.h>
+#include <linux/bootmem.h>
 
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_user_nocheck_asm(char *__to,
@@ -60,3 +61,8 @@ EXPORT_SYMBOL(invalid_pte_table);
 /* _mcount is defined in arch/mips/kernel/mcount.S */
 EXPORT_SYMBOL(_mcount);
 #endif
+
+/* The KVM module uses the standard MIPS cache functions which use
+ * min_low_pfn, requiring it to be exported.
+ */
+EXPORT_SYMBOL(min_low_pfn);
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index ab2e9b0..87d845e 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -16,7 +16,6 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/module.h>
-#include <linux/bootmem.h>
 #include <linux/kvm_host.h>
 #include <linux/srcu.h>
 
-- 
1.7.11.3
