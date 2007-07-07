Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2007 15:21:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14786 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023000AbXGGOVD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Jul 2007 15:21:03 +0100
Received: from localhost (p2176-ipad32funabasi.chiba.ocn.ne.jp [221.189.134.176])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 696F78845; Sat,  7 Jul 2007 23:20:58 +0900 (JST)
Date:	Sat, 07 Jul 2007 23:21:49 +0900 (JST)
Message-Id: <20070707.232149.25909198.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add debugfs files to show fpuemu statistics
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Export contents of struct mips_fpu_emulator_stats via debugfs.

There is no way to read these statistics for now but they (at least
the "emulated" count) might be sometimes useful for performance tuning
on FPU-less CPUs.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied to linux-queue tree.

 arch/mips/math-emu/cp1emu.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 80531b3..d7f05b0 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -35,6 +35,7 @@
  * better performance by compiling with -msoft-float!
  */
 #include <linux/sched.h>
+#include <linux/debugfs.h>
 
 #include <asm/inst.h>
 #include <asm/bootinfo.h>
@@ -1277,3 +1278,36 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 
 	return sig;
 }
+
+#ifdef CONFIG_DEBUG_FS
+extern struct dentry *mips_debugfs_dir;
+static int __init debugfs_fpuemu(void)
+{
+	struct dentry *d, *dir;
+	int i;
+	static struct {
+		const char *name;
+		unsigned int *v;
+	} vars[] __initdata = {
+		{ "emulated", &fpuemustats.emulated },
+		{ "loads",    &fpuemustats.loads },
+		{ "stores",   &fpuemustats.stores },
+		{ "cp1ops",   &fpuemustats.cp1ops },
+		{ "cp1xops",  &fpuemustats.cp1xops },
+		{ "errors",   &fpuemustats.errors },
+	};
+
+	if (!mips_debugfs_dir)
+		return -ENODEV;
+	dir = debugfs_create_dir("fpuemustats", mips_debugfs_dir);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		d = debugfs_create_u32(vars[i].name, S_IRUGO, dir, vars[i].v);
+		if (IS_ERR(d))
+			return PTR_ERR(d);
+	}
+	return 0;
+}
+__initcall(debugfs_fpuemu);
+#endif
