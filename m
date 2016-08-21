Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 21:59:42 +0200 (CEST)
Received: from mail5.windriver.com ([192.103.53.11]:45860 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992381AbcHUT6woHgFn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Aug 2016 21:58:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u7LJwhQ8001945
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
        Sun, 21 Aug 2016 12:58:45 -0700
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Sun, 21 Aug 2016 12:58:42 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/5] mips/mm: Audit and remove any unnecessary uses of module.h
Date:   Sun, 21 Aug 2016 15:58:14 -0400
Message-ID: <20160821195817.5802-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160821195817.5802-1-paul.gortmaker@windriver.com>
References: <20160821195817.5802-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

Historically a lot of these existed because we did not have
a distinction between what was modular code and what was providing
support to modules via EXPORT_SYMBOL and friends.  That changed
when we forked out support for the latter into the export.h file.

This means we should be able to reduce the usage of module.h
in code that is obj-y Makefile or bool Kconfig.  The advantage
in doing so is that module.h itself sources about 15 other headers;
adding significantly to what we feed cpp, and it can obscure what
headers we are effectively using.

Since module.h was the source for init.h (for __init) and for
export.h (for EXPORT_SYMBOL) we consider each obj-y/bool instance
for the presence of either and replace as needed.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/mm/c-r4k.c       | 2 +-
 arch/mips/mm/cache.c       | 2 +-
 arch/mips/mm/dma-default.c | 2 +-
 arch/mips/mm/fault.c       | 1 -
 arch/mips/mm/highmem.c     | 3 ++-
 arch/mips/mm/init.c        | 2 +-
 arch/mips/mm/ioremap.c     | 2 +-
 arch/mips/mm/mmap.c        | 2 +-
 arch/mips/mm/page.c        | 1 -
 arch/mips/mm/tlb-r4k.c     | 2 +-
 10 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index cd72805b64a7..82889922e5b8 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -17,7 +17,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/bitops.h>
 
 #include <asm/bcache.h>
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index bf04c6c479a4..208199e2d55b 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -10,7 +10,7 @@
 #include <linux/fcntl.h>
 #include <linux/kernel.h>
 #include <linux/linkage.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/syscalls.h>
 #include <linux/mm.h>
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index b2eadd6fa9a1..755259c54976 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/gfp.h>
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 9560ad731120..d56a855828c2 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
-#include <linux/module.h>
 #include <linux/kprobes.h>
 #include <linux/perf_event.h>
 #include <linux/uaccess.h>
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index d7258a103439..f13f51003bd8 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -1,5 +1,6 @@
 #include <linux/compiler.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 2c3749d98f04..8fa31b3c7012 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -10,7 +10,7 @@
  */
 #include <linux/bug.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index 8d5008cbdc0f..1f189627440f 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -6,7 +6,7 @@
  * (C) Copyright 1995 1996 Linus Torvalds
  * (C) Copyright 2001, 2002 Ralf Baechle
  */
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
 #include <linux/sched.h>
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 353037699512..d08ea3ff0f53 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -10,7 +10,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/personality.h>
 #include <linux/random.h>
 #include <linux/sched.h>
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index c41953ca6605..6f804f5960ab 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -12,7 +12,6 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/proc_fs.h>
 
 #include <asm/bugs.h>
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index e8b335c16295..d4aec9656495 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -14,7 +14,7 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <asm/cpu.h>
 #include <asm/cpu-type.h>
-- 
2.8.4
