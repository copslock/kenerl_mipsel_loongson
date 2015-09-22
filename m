Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:12:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19333 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008747AbbIVRMXad1ir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:12:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A10BDB00EC2BB;
        Tue, 22 Sep 2015 18:12:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:12:17 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:12:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/4] MIPS: Declare mips_debugfs_dir in a header
Date:   Tue, 22 Sep 2015 10:10:55 -0700
Message-ID: <1442941856-31838-4-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 49279
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

We have many extern declarations of mips_debugfs_dir through arch/mips/
in various C files. Unify them by declaring mips_debugfs_dir in a
header, including it in each affected C file & removing the duplicate
declarations.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/debug.h         | 22 ++++++++++++++++++++++
 arch/mips/kernel/mips-r2-to-r6-emul.c |  2 +-
 arch/mips/kernel/segment.c            |  2 +-
 arch/mips/kernel/setup.c              |  1 +
 arch/mips/kernel/spinlock_test.c      |  4 +---
 arch/mips/kernel/unaligned.c          |  2 +-
 arch/mips/math-emu/me-debugfs.c       |  2 +-
 7 files changed, 28 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/include/asm/debug.h

diff --git a/arch/mips/include/asm/debug.h b/arch/mips/include/asm/debug.h
new file mode 100644
index 0000000..254f00d
--- /dev/null
+++ b/arch/mips/include/asm/debug.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_DEBUG_H__
+#define __MIPS_ASM_DEBUG_H__
+
+#include <linux/dcache.h>
+
+/*
+ * mips_debugfs_dir corresponds to the "mips" directory at the top level
+ * of the DebugFS hierarchy. MIPS-specific DebugFS entires should be
+ * placed beneath this directory.
+ */
+extern struct dentry *mips_debugfs_dir;
+
+#endif /* __MIPS_ASM_DEBUG_H__ */
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index f2977f0..1f5aac7 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -22,6 +22,7 @@
 #include <asm/asm.h>
 #include <asm/branch.h>
 #include <asm/break.h>
+#include <asm/debug.h>
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/inst.h>
@@ -2363,7 +2364,6 @@ static const struct file_operations mipsr2_clear_fops = {
 
 static int __init mipsr2_init_debugfs(void)
 {
-	extern struct dentry	*mips_debugfs_dir;
 	struct dentry		*mipsr2_emul;
 
 	if (!mips_debugfs_dir)
diff --git a/arch/mips/kernel/segment.c b/arch/mips/kernel/segment.c
index 076ead2..87bc74a 100644
--- a/arch/mips/kernel/segment.c
+++ b/arch/mips/kernel/segment.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <asm/cpu.h>
+#include <asm/debug.h>
 #include <asm/mipsregs.h>
 
 static void build_segment_config(char *str, unsigned int cfg)
@@ -91,7 +92,6 @@ static const struct file_operations segments_fops = {
 
 static int __init segments_info(void)
 {
-	extern struct dentry *mips_debugfs_dir;
 	struct dentry *segments;
 
 	if (cpu_has_segments) {
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 35b8316..31c994e 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <asm/cache.h>
 #include <asm/cdmm.h>
 #include <asm/cpu.h>
+#include <asm/debug.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
diff --git a/arch/mips/kernel/spinlock_test.c b/arch/mips/kernel/spinlock_test.c
index 39f7ab7..f7d8695 100644
--- a/arch/mips/kernel/spinlock_test.c
+++ b/arch/mips/kernel/spinlock_test.c
@@ -5,7 +5,7 @@
 #include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
-
+#include <asm/debug.h>
 
 static int ss_get(void *data, u64 *val)
 {
@@ -115,8 +115,6 @@ static int multi_get(void *data, u64 *val)
 
 DEFINE_SIMPLE_ATTRIBUTE(fops_multi, multi_get, NULL, "%llu\n");
 
-
-extern struct dentry *mips_debugfs_dir;
 static int __init spinlock_test(void)
 {
 	struct dentry *d;
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 990354d..490cea5 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -85,6 +85,7 @@
 #include <asm/branch.h>
 #include <asm/byteorder.h>
 #include <asm/cop2.h>
+#include <asm/debug.h>
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/inst.h>
@@ -2295,7 +2296,6 @@ sigbus:
 }
 
 #ifdef CONFIG_DEBUG_FS
-extern struct dentry *mips_debugfs_dir;
 static int __init debugfs_unaligned(void)
 {
 	struct dentry *d;
diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index 506a67a..be650ed 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/types.h>
+#include <asm/debug.h>
 #include <asm/fpu_emulator.h>
 #include <asm/local.h>
 
@@ -27,7 +28,6 @@ static int fpuemu_stat_get(void *data, u64 *val)
 }
 DEFINE_SIMPLE_ATTRIBUTE(fops_fpuemu_stat, fpuemu_stat_get, NULL, "%llu\n");
 
-extern struct dentry *mips_debugfs_dir;
 static int __init debugfs_fpuemu(void)
 {
 	struct dentry *d, *dir;
-- 
2.5.3
