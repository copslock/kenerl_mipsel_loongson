Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 01:12:23 +0200 (CEST)
Received: from mail5.windriver.com ([192.103.53.11]:35180 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992681AbcHOXMPXvX3x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 01:12:15 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u7FNC7rS001942
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 15 Aug 2016 16:12:08 -0700
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Mon, 15 Aug 2016 16:12:07 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] mips: migrate exception table users off module.h and onto extable.h
Date:   Mon, 15 Aug 2016 19:11:52 -0400
Message-ID: <20160815231152.5161-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54558
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

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

In the case of traps.c we can't dump the module.h include since it is
also used to provide "print_modules".

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[see: https://lkml.org/lkml/2016/7/24/224 for additional context if needed]

 arch/mips/kernel/module.c | 1 +
 arch/mips/kernel/traps.c  | 1 +
 arch/mips/mm/extable.c    | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 79850e376ef6..94627a3a6a0d 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -20,6 +20,7 @@
 
 #undef DEBUG
 
+#include <linux/extable.h>
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 3de85be2486a..6061d47c57c9 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
diff --git a/arch/mips/mm/extable.c b/arch/mips/mm/extable.c
index 9d25d2ba4b9e..e474fa2efed4 100644
--- a/arch/mips/mm/extable.c
+++ b/arch/mips/mm/extable.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 1997, 99, 2001 - 2004 Ralf Baechle <ralf@linux-mips.org>
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/spinlock.h>
 #include <asm/branch.h>
 #include <asm/uaccess.h>
-- 
2.8.4
