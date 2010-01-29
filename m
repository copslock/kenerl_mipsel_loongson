Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 00:03:27 +0100 (CET)
Received: from mgate.redback.com ([155.53.3.41]:48095 "EHLO mgate.redback.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492930Ab0A2XC6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Jan 2010 00:02:58 +0100
X-IronPort-AV: E=Sophos;i="4.49,371,1262592000"; 
   d="scan'208";a="7716458"
Received: from prattle.redback.com ([155.53.12.9])
  by mgate.redback.com with ESMTP; 29 Jan 2010 15:02:55 -0800
Received: from localhost (localhost [127.0.0.1])
        by prattle.redback.com (Postfix) with ESMTP id 6025713D783B;
        Fri, 29 Jan 2010 15:02:55 -0800 (PST)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31990-10; Fri, 29 Jan 2010 15:02:55 -0800 (PST)
Received: from localhost (rbos-pc-13.lab.redback.com [10.12.11.133])
        by prattle.redback.com (Postfix) with ESMTP id 4F2F613D7839;
        Fri, 29 Jan 2010 15:02:55 -0800 (PST)
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     linux-mips@linux-mips.org
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>
Subject: [PATCH 01/01] Fix maximum virtual memory size for Sibyte CPUs
Date:   Fri, 29 Jan 2010 14:47:22 -0800
Message-Id: <1264805242-31929-2-git-send-email-guenter.roeck@ericsson.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1264805242-31929-1-git-send-email-guenter.roeck@ericsson.com>
References: <1264805242-31929-1-git-send-email-guenter.roeck@ericsson.com>
X-archive-position: 25753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19220

Maximum virtual memory on Sibyte CPUs is limited to 44 bit.
This is less than the amount calculated for VMALLOC_END in 64 bit builds.
This causes 2.6.32 and later kernels to crash if the page size
is configured to 16k or 64k.

Fix the problem by introducing a separate per-CPU variable
to define the maximum amount of virtual memory.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 arch/mips/include/asm/mach-generic/spaces.h |    8 ++++++++
 arch/mips/include/asm/mach-sibyte/spaces.h  |   22 ++++++++++++++++++++++
 arch/mips/include/asm/pgtable-64.h          |    8 +++++---
 3 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-sibyte/spaces.h

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index c9fa4b1..77f62d6 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -61,6 +61,14 @@
 #endif
 
 /*
+ * Maximum virtual memory size.
+ * The default maximum is a fictive number.
+ */
+#ifndef MAX_VMALLOC_SIZE
+#define MAX_VMALLOC_SIZE	(_AC(1, UL) << _AC(60, UL))
+#endif
+
+/*
  * Memory above this physical address will be considered highmem.
  * Fixme: 59 bits is a fictive number and makes assumptions about processors
  * in the distant future.  Nobody will care for a few years :-)
diff --git a/arch/mips/include/asm/mach-sibyte/spaces.h b/arch/mips/include/asm/mach-sibyte/spaces.h
new file mode 100644
index 0000000..f82f68a
--- /dev/null
+++ b/arch/mips/include/asm/mach-sibyte/spaces.h
@@ -0,0 +1,22 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010 Ericsson AB.
+ */
+#ifndef _ASM_SIBYTE_SPACES_H
+#define _ASM_SIBYTE_SPACES_H
+
+#ifdef CONFIG_64BIT
+
+/*
+ * Maximum virtual memory size
+ */
+#define MAX_VMALLOC_SIZE	(_AC(1, UL) << _AC(44, UL))
+
+#endif /* CONFIG_64BIT */
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_SIBYTE_SPACES_H */
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 9cd5089..f5e4433 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -108,9 +108,11 @@
 #define FIRST_USER_ADDRESS	0UL
 
 #define VMALLOC_START		MAP_BASE
-#define VMALLOC_END	\
-	(VMALLOC_START + \
-	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
+#define _VMALLOC_SIZE \
+	(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
+#define VMALLOC_END \
+	(VMALLOC_START + min(_VMALLOC_SIZE, MAX_VMALLOC_SIZE) - (1UL << 32))
+
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
-- 
1.6.0.4
