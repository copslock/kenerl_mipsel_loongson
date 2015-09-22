Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:13:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21039 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008788AbbIVRMloOv8r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:12:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0111BE2506E91;
        Tue, 22 Sep 2015 18:12:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:12:35 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:12:34 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] MIPS: Allow L2 prefetch to be configured via debugfs
Date:   Tue, 22 Sep 2015 10:10:56 -0700
Message-ID: <1442941856-31838-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442941856-31838-1-git-send-email-paul.burton@imgtec.com>
References: <1442941856-31838-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

When debugging or examining the performance of a system it can be useful
to examine the effect of L2 prefetching. Provide an optional debugfs
entry to allow a user to enable or disable L2 prefetching.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig.debug   | 10 ++++++
 arch/mips/mm/Makefile     |  1 +
 arch/mips/mm/sc-debugfs.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 arch/mips/mm/sc-debugfs.c

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index e250524..d1962cb 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -113,4 +113,14 @@ config SPINLOCK_TEST
 	help
 	  Add several files to the debugfs to test spinlock speed.
 
+config SCACHE_DEBUGFS
+	bool "L2 cache debugfs entries"
+	depends on DEBUG_FS
+	help
+	  Enable this to allow parts of the L2 cache configuration, such as
+	  whether or not prefetching is enabled, to be exposed to userland
+	  via debugfs.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 67ede4e..b4c64bd 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)	+= sc-r5k.o
 obj-$(CONFIG_RM7000_CPU_SCACHE) += sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
+obj-$(CONFIG_SCACHE_DEBUGFS)	+= sc-debugfs.o
diff --git a/arch/mips/mm/sc-debugfs.c b/arch/mips/mm/sc-debugfs.c
new file mode 100644
index 0000000..5eefe32
--- /dev/null
+++ b/arch/mips/mm/sc-debugfs.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/bcache.h>
+#include <asm/debug.h>
+#include <asm/uaccess.h>
+#include <linux/debugfs.h>
+#include <linux/init.h>
+
+static ssize_t sc_prefetch_read(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	bool enabled = bc_prefetch_is_enabled();
+	char buf[3];
+
+	buf[0] = enabled ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = 0;
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t sc_prefetch_write(struct file *file,
+				 const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	char buf[32];
+	ssize_t buf_size;
+	bool enabled;
+	int err;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	err = strtobool(buf, &enabled);
+	if (err)
+		return err;
+
+	if (enabled)
+		bc_prefetch_enable();
+	else
+		bc_prefetch_disable();
+
+	return count;
+}
+
+static const struct file_operations sc_prefetch_fops = {
+	.open = simple_open,
+	.llseek = default_llseek,
+	.read = sc_prefetch_read,
+	.write = sc_prefetch_write,
+};
+
+static int __init sc_debugfs_init(void)
+{
+	struct dentry *dir, *file;
+
+	if (!mips_debugfs_dir)
+		return -ENODEV;
+
+	dir = debugfs_create_dir("l2cache", mips_debugfs_dir);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	file = debugfs_create_file("prefetch", S_IRUGO | S_IWUSR, dir,
+				   NULL, &sc_prefetch_fops);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	return 0;
+}
+late_initcall(sc_debugfs_init);
-- 
2.5.3
