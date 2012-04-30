Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:36:41 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56984 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903712Ab2D3Lee (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:34:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 06/14] MIPS: add clkdev.h
Date:   Mon, 30 Apr 2012 13:33:01 +0200
Message-Id: <1335785589-32532-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

For clock device lookup tables to work on MIPS, we need to provide this
architecture specific header file.

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
1.7.9.1
