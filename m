Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:57:02 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43588 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903753Ab2FEVwK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:52:10 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1Ab-000824-6m; Tue, 05 Jun 2012 16:20:05 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 33/35] MIPS: txx9: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:37 -0500
Message-Id: <1338931179-9611-34-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Make headers consistent across the files and make changes based on
running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/txx9/generic/setup.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 8a053d6..00fc82b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -1,34 +1,29 @@
 /*
- * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
- *	    and RBTX49xx patch from CELF patch archive.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Based on linux/arch/mips/txx9/rbtx4938/setup.c and RBTX49xx patch
+ * from CELF patch archive.
  *
  * 2003-2005 (c) MontaVista Software, Inc.
  * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
 #include <linux/string.h>
 #include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/err.h>
+#include <linux/slab.h>
 #include <linux/gpio.h>
+#include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/serial_core.h>
 #include <linux/mtd/physmap.h>
-#include <linux/leds.h>
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <asm/time.h>
+#include <linux/serial_core.h>
+
 #include <asm/reboot.h>
 #include <asm/r4kcache.h>
 #include <asm/sections.h>
+#include <asm/time.h>
 #include <asm/fw/fw.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
-- 
1.7.10.3
