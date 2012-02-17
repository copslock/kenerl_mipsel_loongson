Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:36:34 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36934 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903694Ab2BQKdg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:36 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/9] MIPS: add clkdev.h
Date:   Fri, 17 Feb 2012 11:33:12 +0100
Message-Id: <1329474800-20979-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32445
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
