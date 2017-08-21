Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 14:31:26 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:56209 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993935AbdHUMaTh1ozG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Aug 2017 14:30:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id CFBBA1A21AC;
        Mon, 21 Aug 2017 14:30:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from mcs19.domain.local (mcs19.domain.local [10.10.13.51])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 7BEE01A2182;
        Mon, 21 Aug 2017 14:30:11 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 5/6] MIPS: math-emu: Add FP emu debugfs clear functionality
Date:   Mon, 21 Aug 2017 14:24:51 +0200
Message-Id: <20170821122526.22072-6-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170821122526.22072-1-aleksandar.markovic@rt-rk.com>
References: <20170821122526.22072-1-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add capability for the user to clear all FP emu debugfs counters.

This is achieved by having a special debugfs file "fpuemustats_clear"
(under default location "/sys/kernel/debug/mips"). Each access to the
file results in setting all counters to zero (it is enough, let's say,
to issue a "cat /sys/kernel/debug/mips/fpuemustats_clear").

This functionality already exists for R2 emulation statistics,
but was missing for FP emulation statistics. The implementation in
this patch is consistent with its R2 emulation counterpart.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/me-debugfs.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index 78b26c8..f080493 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -28,15 +28,51 @@ static int fpuemu_stat_get(void *data, u64 *val)
 }
 DEFINE_SIMPLE_ATTRIBUTE(fops_fpuemu_stat, fpuemu_stat_get, NULL, "%llu\n");
 
+static int fpuemustats_clear_show(struct seq_file *s, void *unused)
+{
+	__this_cpu_write((fpuemustats).emulated, 0);
+	__this_cpu_write((fpuemustats).loads, 0);
+	__this_cpu_write((fpuemustats).stores, 0);
+	__this_cpu_write((fpuemustats).branches, 0);
+	__this_cpu_write((fpuemustats).cp1ops, 0);
+	__this_cpu_write((fpuemustats).cp1xops, 0);
+	__this_cpu_write((fpuemustats).errors, 0);
+	__this_cpu_write((fpuemustats).ieee754_inexact, 0);
+	__this_cpu_write((fpuemustats).ieee754_underflow, 0);
+	__this_cpu_write((fpuemustats).ieee754_overflow, 0);
+	__this_cpu_write((fpuemustats).ieee754_zerodiv, 0);
+	__this_cpu_write((fpuemustats).ieee754_invalidop, 0);
+	__this_cpu_write((fpuemustats).ds_emul, 0);
+
+	return 0;
+}
+
+static int fpuemustats_clear_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fpuemustats_clear_show, inode->i_private);
+}
+
+static const struct file_operations fpuemustats_clear_fops = {
+	.open                   = fpuemustats_clear_open,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
 static int __init debugfs_fpuemu(void)
 {
-	struct dentry *d, *dir;
+	struct dentry *d, *dir, *reset_file;
 
 	if (!mips_debugfs_dir)
 		return -ENODEV;
 	dir = debugfs_create_dir("fpuemustats", mips_debugfs_dir);
 	if (!dir)
 		return -ENOMEM;
+	reset_file = debugfs_create_file("fpuemustats_clear", 0444,
+					 mips_debugfs_dir, NULL,
+					 &fpuemustats_clear_fops);
+	if (!reset_file)
+		return -ENOMEM;
 
 #define FPU_EMU_STAT_OFFSET(m)						\
 	offsetof(struct mips_fpu_emulator_stats, m)
-- 
2.9.3
