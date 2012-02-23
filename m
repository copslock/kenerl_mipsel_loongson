Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:05:07 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47346 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903631Ab2BWQDc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:03:32 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 01/14] MIPS: add clkdev.h
Date:   Thu, 23 Feb 2012 17:03:00 +0100
Message-Id: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 32507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

For clkdev to work on MIPS we need this file

include/linux/clkdev.h:#include <asm/clkdev.h>

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/clkdev.h |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/clkdev.h

diff --git a/arch/mips/include/asm/clkdev.h b/arch/mips/include/asm/clkdev.h
new file mode 100644
index 0000000..2624754
--- /dev/null
+++ b/arch/mips/include/asm/clkdev.h
@@ -0,0 +1,25 @@
+/*
+ *  based on arch/arm/include/asm/clkdev.h
+ *
+ *  Copyright (C) 2008 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+#ifndef __ASM_CLKDEV_H
+#define __ASM_CLKDEV_H
+
+#include <linux/slab.h>
+
+#define __clk_get(clk)	({ 1; })
+#define __clk_put(clk)	do { } while (0)
+
+static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+#endif
-- 
1.7.7.1
