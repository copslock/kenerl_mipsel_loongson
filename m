Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 21:58:55 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:41940 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992339AbcHUT6sf5Inn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Aug 2016 21:58:48 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u7LJwfA9020523
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 21 Aug 2016 12:58:41 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Sun, 21 Aug 2016 12:58:41 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/5] mips/kernel: Audit and remove any unnecessary uses of module.h
Date:   Sun, 21 Aug 2016 15:58:13 -0400
Message-ID: <20160821195817.5802-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160821195817.5802-1-paul.gortmaker@windriver.com>
References: <20160821195817.5802-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54712
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

In the case of the n32/o32 files, we have to get rid of a couple
no-op MODULE_ tags to facilitate the module.h removal.  They piggy
back off the fs/ elf binary support, which is also a bool Kconfig.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/kernel/binfmt_elfn32.c      | 8 +-------
 arch/mips/kernel/binfmt_elfo32.c      | 8 +-------
 arch/mips/kernel/branch.c             | 2 +-
 arch/mips/kernel/linux32.c            | 1 -
 arch/mips/kernel/mips-r2-to-r6-emul.c | 1 -
 arch/mips/kernel/smp.c                | 2 +-
 6 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/mips/kernel/binfmt_elfn32.c b/arch/mips/kernel/binfmt_elfn32.c
index 58ad63d7eb42..9c7f3e136d50 100644
--- a/arch/mips/kernel/binfmt_elfn32.c
+++ b/arch/mips/kernel/binfmt_elfn32.c
@@ -1,5 +1,6 @@
 /*
  * Support for n32 Linux/MIPS ELF binaries.
+ * Author: Ralf Baechle (ralf@linux-mips.org)
  *
  * Copyright (C) 1999, 2001 Ralf Baechle
  * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
@@ -37,7 +38,6 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 #define ELF_ET_DYN_BASE		(TASK32_SIZE / 3 * 2)
 
 #include <asm/processor.h>
-#include <linux/module.h>
 #include <linux/elfcore.h>
 #include <linux/compat.h>
 #include <linux/math64.h>
@@ -96,12 +96,6 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 
 #define ELF_CORE_EFLAGS EF_MIPS_ABI2
 
-MODULE_DESCRIPTION("Binary format loader for compatibility with n32 Linux/MIPS binaries");
-MODULE_AUTHOR("Ralf Baechle (ralf@linux-mips.org)");
-
-#undef MODULE_DESCRIPTION
-#undef MODULE_AUTHOR
-
 #undef TASK_SIZE
 #define TASK_SIZE TASK_SIZE32
 
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index 49fb881481f7..1ab34322dd97 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -1,5 +1,6 @@
 /*
  * Support for o32 Linux/MIPS ELF binaries.
+ * Author: Ralf Baechle (ralf@linux-mips.org)
  *
  * Copyright (C) 1999, 2001 Ralf Baechle
  * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
@@ -42,7 +43,6 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
 #include <asm/processor.h>
 
-#include <linux/module.h>
 #include <linux/elfcore.h>
 #include <linux/compat.h>
 #include <linux/math64.h>
@@ -99,12 +99,6 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 	value->tv_usec = rem / NSEC_PER_USEC;
 }
 
-MODULE_DESCRIPTION("Binary format loader for compatibility with o32 Linux/MIPS binaries");
-MODULE_AUTHOR("Ralf Baechle (ralf@linux-mips.org)");
-
-#undef MODULE_DESCRIPTION
-#undef MODULE_AUTHOR
-
 #undef TASK_SIZE
 #define TASK_SIZE TASK_SIZE32
 
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 46c227fc98f5..f5c68483c98e 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 0b29646bcee7..50fb62544df7 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -26,7 +26,6 @@
 #include <linux/utsname.h>
 #include <linux/personality.h>
 #include <linux/dnotify.h>
-#include <linux/module.h>
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/compat.h>
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index c3372cac6db2..ffe3b9e67c94 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -15,7 +15,6 @@
 #include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/ptrace.h>
 #include <linux/seq_file.h>
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f95f094f36e4..5931bafada70 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -25,7 +25,7 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/threads.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
-- 
2.8.4
