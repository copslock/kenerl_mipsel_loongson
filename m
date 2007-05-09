Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 16:55:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:25806 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023759AbXEIPzF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2007 16:55:05 +0100
Received: from localhost (p3015-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.15])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 92180C2BC; Thu, 10 May 2007 00:53:43 +0900 (JST)
Date:	Thu, 10 May 2007 00:53:36 +0900 (JST)
Message-Id: <20070510.005336.63743253.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Add some sysfs files to debug unaligned accesses
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070306.005143.69025642.anemo@mba.ocn.ne.jp>
References: <20070306.005143.69025642.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 06 Mar 2007 00:51:43 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Currently a number of unaligned instructions is counted but not used.
> Add /sys/kernel/mips/unaligned_instructions file to show the value.

Updated against current git tree.


Subject: [PATCH] Add some sysfs files to debug unaligned accesses

Currently a number of unaligned instructions is counted but not used.
Add /sys/kernel/mips/unaligned_instructions file to show the value.

And add /sys/kernel/mips/unaligned_action to control behavior upon an
unaligned access.  Possible actions are:

quiet: silently fixup the unaligned access.
signal: send SIGBUS.
show: dump registers, process name, etc. and fixup.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/setup.c     |   14 ++++++++
 arch/mips/kernel/unaligned.c |   70 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4975da0..1c8629c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -574,3 +574,17 @@ __setup("nodsp", dsp_disable);
 
 unsigned long kernelsp[NR_CPUS];
 unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+
+static struct attribute *mips_attrs[] = {
+	NULL
+};
+static struct attribute_group mips_attr_group = {
+	.name = "mips",
+	.attrs = mips_attrs,
+};
+
+static int __init sysfs_mips(void)
+{
+	return sysfs_create_group(&kernel_subsys.kobj, &mips_attr_group);
+}
+arch_initcall(sysfs_mips);
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index a7d49ae..bdead88 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -87,9 +87,14 @@
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
 
-#ifdef CONFIG_PROC_FS
-unsigned long unaligned_instructions;
+#ifdef CONFIG_SYSFS
+static unsigned long unaligned_instructions;
+static int unaligned_action;
+static const char *unaligned_actions[] = {"quiet", "signal", "show"};
+#else
+#define unaligned_action 0
 #endif
+extern void show_registers(struct pt_regs *regs);
 
 static inline int emulate_load_store_insn(struct pt_regs *regs,
 	void __user *addr, unsigned int __user *pc,
@@ -459,7 +464,7 @@ static inline int emulate_load_store_insn(struct pt_regs *regs,
 		goto sigill;
 	}
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SYSFS
 	unaligned_instructions++;
 #endif
 
@@ -516,6 +521,10 @@ asmlinkage void do_ade(struct pt_regs *regs)
 	pc = (unsigned int __user *) exception_epc(regs);
 	if (user_mode(regs) && (current->thread.mflags & MF_FIXADE) == 0)
 		goto sigbus;
+	if (unaligned_action == 1)
+		goto sigbus;
+	else if (unaligned_action == 2)
+		show_registers(regs);
 
 	/*
 	 * Do branch emulation only if we didn't forward the exception.
@@ -546,3 +555,58 @@ sigbus:
 	 * XXX On return from the signal handler we should advance the epc
 	 */
 }
+
+#ifdef CONFIG_SYSFS
+static ssize_t unaligned_instructions_show(struct kset *kset, char *buf)
+{
+	return sprintf(buf, "%lu\n", unaligned_instructions);
+}
+
+static ssize_t unaligned_action_show(struct kset *kset, char *buf)
+{
+	int i;
+	char *s = buf;
+
+	for (i = 0; i < ARRAY_SIZE(unaligned_actions); i++) {
+		if (i == unaligned_action)
+			s += sprintf(s, "[%s] ", unaligned_actions[i]);
+		else
+			s += sprintf(s, "%s ", unaligned_actions[i]);
+	}
+	s += sprintf(s, "\n");
+	return s - buf;
+}
+
+static ssize_t unaligned_action_store(struct kset *kset,
+				      const char *buf, size_t count)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(unaligned_actions); i++) {
+		if (!strncmp(buf, unaligned_actions[i],
+			     min(count, strlen(unaligned_actions[i])))) {
+			unaligned_action = i;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+#define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
+static struct subsys_attribute unaligned_attrs[] = {
+	__ATTR_RO(unaligned_instructions),
+	__ATTR_RW(unaligned_action),
+};
+
+static int __init sysfs_unaligned(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(unaligned_attrs); i++)
+		sysfs_add_file_to_group(&kernel_subsys.kobj,
+					&unaligned_attrs[i].attr,
+					"mips");
+	return 0;
+}
+__initcall(sysfs_unaligned);
+#endif
