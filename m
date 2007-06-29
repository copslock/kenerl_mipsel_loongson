Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 16:56:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:15073 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021683AbXF2P4W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Jun 2007 16:56:22 +0100
Received: from localhost (p7072-ipad34funabasi.chiba.ocn.ne.jp [124.85.64.72])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9DE0AB7DA; Sat, 30 Jun 2007 00:55:01 +0900 (JST)
Date:	Sat, 30 Jun 2007 00:55:48 +0900 (JST)
Message-Id: <20070630.005548.15242239.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add some debugfs files to debug unaligned accesses
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
X-archive-position: 15579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Currently a number of unaligned instructions is counted but not used.
Add /debug/mips/unaligned_instructions file to show the value.

And add /debug/mips/unaligned_action to control behavior upon an
unaligned access.  Possible actions are:

0: silently fixup the unaligned access.
1: send SIGBUS.
2: dump registers, process name, etc. and fixup.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is a replacement of a patch titled:
"[PATCH] Add some sysfs files to debug unaligned accesses"

 arch/mips/kernel/setup.c     |   16 ++++++++++++++++
 arch/mips/kernel/unaligned.c |   41 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4975da0..316685f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/highmem.h>
 #include <linux/console.h>
 #include <linux/pfn.h>
+#include <linux/debugfs.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -574,3 +575,18 @@ __setup("nodsp", dsp_disable);
 
 unsigned long kernelsp[NR_CPUS];
 unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+
+#ifdef CONFIG_DEBUG_FS
+struct dentry *mips_debugfs_dir;
+static int __init debugfs_mips(void)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("mips", NULL);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	mips_debugfs_dir = d;
+	return 0;
+}
+arch_initcall(debugfs_mips);
+#endif
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 18c4a3c..8b9c34f 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -77,6 +77,7 @@
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/debugfs.h>
 #include <asm/asm.h>
 #include <asm/branch.h>
 #include <asm/byteorder.h>
@@ -87,9 +88,18 @@
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
 
-#ifdef CONFIG_PROC_FS
-unsigned long unaligned_instructions;
+enum {
+	UNALIGNED_ACTION_QUIET,
+	UNALIGNED_ACTION_SIGNAL,
+	UNALIGNED_ACTION_SHOW,
+};
+#ifdef CONFIG_DEBUG_FS
+static u32 unaligned_instructions;
+static u32 unaligned_action;
+#else
+#define unaligned_action UNALIGNED_ACTION_QUIET
 #endif
+extern void show_registers(struct pt_regs *regs);
 
 static inline int emulate_load_store_insn(struct pt_regs *regs,
 	void __user *addr, unsigned int __user *pc,
@@ -459,7 +469,7 @@ static inline int emulate_load_store_insn(struct pt_regs *regs,
 		goto sigill;
 	}
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_DEBUG_FS
 	unaligned_instructions++;
 #endif
 
@@ -516,6 +526,10 @@ asmlinkage void do_ade(struct pt_regs *regs)
 	pc = (unsigned int __user *) exception_epc(regs);
 	if (user_mode(regs) && (current->thread.mflags & MF_FIXADE) == 0)
 		goto sigbus;
+	if (unaligned_action == UNALIGNED_ACTION_SIGNAL)
+		goto sigbus;
+	else if (unaligned_action == UNALIGNED_ACTION_SHOW)
+		show_registers(regs);
 
 	/*
 	 * Do branch emulation only if we didn't forward the exception.
@@ -546,3 +560,24 @@ sigbus:
 	 * XXX On return from the signal handler we should advance the epc
 	 */
 }
+
+#ifdef CONFIG_DEBUG_FS
+extern struct dentry *mips_debugfs_dir;
+static int __init debugfs_unaligned(void)
+{
+	struct dentry *d;
+
+	if (!mips_debugfs_dir)
+		return -ENODEV;
+	d = debugfs_create_u32("unaligned_instructions", S_IRUGO,
+			       mips_debugfs_dir, &unaligned_instructions);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	d = debugfs_create_u32("unaligned_action", S_IRUGO | S_IWUSR,
+			       mips_debugfs_dir, &unaligned_action);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	return 0;
+}
+__initcall(debugfs_unaligned);
+#endif
