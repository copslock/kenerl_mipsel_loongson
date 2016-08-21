Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 22:00:02 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:49523 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992443AbcHUT6wx0mBn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Aug 2016 21:58:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u7LJwkCG023782
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 21 Aug 2016 12:58:46 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Sun, 21 Aug 2016 12:58:46 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/5] mips/lib: Audit and remove any unnecessary uses of module.h
Date:   Sun, 21 Aug 2016 15:58:15 -0400
Message-ID: <20160821195817.5802-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160821195817.5802-1-paul.gortmaker@windriver.com>
References: <20160821195817.5802-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54715
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

The compiler.h additions are for an implict presence of the
"notrace" which module.h brought in but export.h does not.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/lib/ashldi3.c   | 2 +-
 arch/mips/lib/ashrdi3.c   | 2 +-
 arch/mips/lib/bswapdi.c   | 3 ++-
 arch/mips/lib/bswapsi.c   | 3 ++-
 arch/mips/lib/cmpdi2.c    | 2 +-
 arch/mips/lib/delay.c     | 2 +-
 arch/mips/lib/iomap-pci.c | 2 +-
 arch/mips/lib/iomap.c     | 2 +-
 arch/mips/lib/lshrdi3.c   | 2 +-
 arch/mips/lib/ucmpdi2.c   | 2 +-
 10 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
index 927dc94a030f..c3e22053d13e 100644
--- a/arch/mips/lib/ashldi3.c
+++ b/arch/mips/lib/ashldi3.c
@@ -1,4 +1,4 @@
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include "libgcc.h"
 
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
index 9fdf1a598428..17456024873d 100644
--- a/arch/mips/lib/ashrdi3.c
+++ b/arch/mips/lib/ashrdi3.c
@@ -1,4 +1,4 @@
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include "libgcc.h"
 
diff --git a/arch/mips/lib/bswapdi.c b/arch/mips/lib/bswapdi.c
index e3e77aa52c95..a8114148f82a 100644
--- a/arch/mips/lib/bswapdi.c
+++ b/arch/mips/lib/bswapdi.c
@@ -1,4 +1,5 @@
-#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/compiler.h>
 
 unsigned long long notrace __bswapdi2(unsigned long long u)
 {
diff --git a/arch/mips/lib/bswapsi.c b/arch/mips/lib/bswapsi.c
index 530a8afe6fda..106fd978317d 100644
--- a/arch/mips/lib/bswapsi.c
+++ b/arch/mips/lib/bswapsi.c
@@ -1,4 +1,5 @@
-#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/compiler.h>
 
 unsigned int notrace __bswapsi2(unsigned int u)
 {
diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
index 06857da96993..9d849d8743c9 100644
--- a/arch/mips/lib/cmpdi2.c
+++ b/arch/mips/lib/cmpdi2.c
@@ -1,4 +1,4 @@
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include "libgcc.h"
 
diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index 21d27c6819a2..2307a3cb2714 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -8,7 +8,7 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2007, 2014 Maciej W. Rozycki
  */
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/param.h>
 #include <linux/smp.h>
 #include <linux/stringify.h>
diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
index fd35daa45314..a629077fd7b9 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -7,7 +7,7 @@
  *     written by Ralf Baechle <ralf@linux-mips.org>
  */
 #include <linux/pci.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/io.h>
 
 void __iomem *__pci_ioport_map(struct pci_dev *dev,
diff --git a/arch/mips/lib/iomap.c b/arch/mips/lib/iomap.c
index 8e7e378ce51c..9daa92428e23 100644
--- a/arch/mips/lib/iomap.c
+++ b/arch/mips/lib/iomap.c
@@ -6,7 +6,7 @@
  * (C) Copyright 2007 MIPS Technologies, Inc.
  *     written by Ralf Baechle <ralf@linux-mips.org>
  */
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/io.h>
 
 /*
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
index 364547449c65..221167c1be55 100644
--- a/arch/mips/lib/lshrdi3.c
+++ b/arch/mips/lib/lshrdi3.c
@@ -1,4 +1,4 @@
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include "libgcc.h"
 
diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
index bd599f58234c..08067fa538f2 100644
--- a/arch/mips/lib/ucmpdi2.c
+++ b/arch/mips/lib/ucmpdi2.c
@@ -1,4 +1,4 @@
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include "libgcc.h"
 
-- 
2.8.4
