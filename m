Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jun 2010 01:46:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4149 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492388Ab0FYXqZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Jun 2010 01:46:25 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c253fe60000>; Fri, 25 Jun 2010 16:46:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Jun 2010 16:46:22 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Jun 2010 16:46:22 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5PNkIVV028968;
        Fri, 25 Jun 2010 16:46:18 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5PNkHgp028967;
        Fri, 25 Jun 2010 16:46:17 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Create and use asm/arch_hweight.h
Date:   Fri, 25 Jun 2010 16:46:07 -0700
Message-Id: <1277509568-28927-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1277509568-28927-1-git-send-email-ddaney@caviumnetworks.com>
References: <1277509568-28927-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 25 Jun 2010 23:46:22.0831 (UTC) FILETIME=[9E0FE7F0:01CB14C0]
X-archive-position: 27251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17735

Some MIPS ISA processor varients can do hweight operations
efficiently.

Split arch_hweight.h into a seperate file, and implement the
operations with __builtin_popcount{,ll} if supported.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/arch_hweight.h |   38 ++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/bitops.h       |    5 +++-
 2 files changed, 42 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/arch_hweight.h

diff --git a/arch/mips/include/asm/arch_hweight.h b/arch/mips/include/asm/arch_hweight.h
new file mode 100644
index 0000000..712a744
--- /dev/null
+++ b/arch/mips/include/asm/arch_hweight.h
@@ -0,0 +1,38 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+#ifndef _ASM_ARCH_HWEIGHT_H
+#define _ASM_ARCH_HWEIGHT_H
+
+#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
+
+#include <asm/types.h>
+
+static inline unsigned int __arch_hweight32(unsigned int w)
+{
+	return __builtin_popcount(w);
+}
+
+static inline unsigned int __arch_hweight16(unsigned int w)
+{
+	return __builtin_popcount(w & 0xffff);
+}
+
+static inline unsigned int __arch_hweight8(unsigned int w)
+{
+	return __builtin_popcount(w & 0xff);
+}
+
+static inline unsigned long __arch_hweight64(__u64 w)
+{
+	return __builtin_popcountll(w);
+}
+
+#else
+#include <asm-generic/bitops/arch_hweight.h>
+#endif
+
+#endif /* _ASM_ARCH_HWEIGHT_H */
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 9255cfb..b0ce7ca 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -700,7 +700,10 @@ static inline int ffs(int word)
 #ifdef __KERNEL__
 
 #include <asm-generic/bitops/sched.h>
-#include <asm-generic/bitops/hweight.h>
+
+#include <asm/arch_hweight.h>
+#include <asm-generic/bitops/const_hweight.h>
+
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/minix.h>
-- 
1.6.6.1
