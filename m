Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:09:13 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53909
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010971AbaJIPIGk0b5D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:06 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 04/10] MIPS: ralink: add a bootrom dumper module
Date:   Thu,  9 Oct 2014 01:52:59 +0200
Message-Id: <1412812385-64820-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This patch adds a trivial driver that allows userland to extract the bootrom of
a SoC via debugfs.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Makefile  |    2 ++
 arch/mips/ralink/bootrom.c |   48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/mips/ralink/bootrom.c

diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 98ae349..584a8d9 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -17,4 +17,6 @@ obj-$(CONFIG_SOC_MT7620) += mt7620.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
+obj-$(CONFIG_DEBUG_FS) += bootrom.o
+
 obj-y += dts/
diff --git a/arch/mips/ralink/bootrom.c b/arch/mips/ralink/bootrom.c
new file mode 100644
index 0000000..5403468
--- /dev/null
+++ b/arch/mips/ralink/bootrom.c
@@ -0,0 +1,48 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#define BOOTROM_OFFSET	0x10118000
+#define BOOTROM_SIZE	0x8000
+
+static void __iomem *membase = (void __iomem *) KSEG1ADDR(BOOTROM_OFFSET);
+
+static int bootrom_show(struct seq_file *s, void *unused)
+{
+	seq_write(s, membase, BOOTROM_SIZE);
+
+	return 0;
+}
+
+static int bootrom_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, bootrom_show, NULL);
+}
+
+static const struct file_operations bootrom_file_ops = {
+	.open		= bootrom_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int bootrom_setup(void)
+{
+	if (!debugfs_create_file("bootrom", 0444,
+			NULL, NULL, &bootrom_file_ops)) {
+		pr_err("Failed to create bootrom debugfs file\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+postcore_initcall(bootrom_setup);
-- 
1.7.10.4
