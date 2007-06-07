Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 07:05:41 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:35473 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022681AbXFGGFj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2007 07:05:39 +0100
Received: (qmail 1351 invoked by uid 511); 7 Jun 2007 06:11:56 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 7 Jun 2007 06:11:56 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Songmao Tian <tiansm@lemote.com>
Subject: [PATCH] override of arch/mips/mm/cache.c: __uncached_access
Date:	Thu,  7 Jun 2007 14:04:17 +0800
Message-Id: <11811962573610-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <20070606182814.GD30017@linux-mips.org>
References: <20070606182814.GD30017@linux-mips.org>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Songmao Tian <tiansm@lemote.com>

Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 arch/mips/lemote/lm2e/Makefile |    2 +-
 arch/mips/lemote/lm2e/mem.c    |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/lemote/lm2e/mem.c

diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
index 0ba6f12..fb1b48c 100644
--- a/arch/mips/lemote/lm2e/Makefile
+++ b/arch/mips/lemote/lm2e/Makefile
@@ -2,6 +2,6 @@
 # Makefile for Lemote Fulong mini-PC board.
 #
 
-obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o
+obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
 EXTRA_AFLAGS := $(CFLAGS)
 
diff --git a/arch/mips/lemote/lm2e/mem.c b/arch/mips/lemote/lm2e/mem.c
new file mode 100644
index 0000000..6068a17
--- /dev/null
+++ b/arch/mips/lemote/lm2e/mem.c
@@ -0,0 +1,25 @@
+/*
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/fs.h>
+#include <linux/fcntl.h>
+#include <linux/mm.h>
+
+/* override of arch/mips/mm/cache.c: __uncached_access */
+int __uncached_access(struct file *file, unsigned long addr)
+{
+	if (file->f_flags & O_SYNC)
+		return 1;
+
+	/* 
+	 * on lemote loongson 2e system, peripheral register 
+	 * reside between 0x1000 0000 and 0x2000 0000
+	 */
+	return addr >= __pa(high_memory) ||
+		((addr >=0x10000000) && (addr < 0x20000000));
+}
+
-- 
1.5.2.1
