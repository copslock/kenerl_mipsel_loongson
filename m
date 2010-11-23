Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 16:08:25 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43903 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491932Ab0KWPG5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 16:06:57 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id EE1E14DC009;
        Tue, 23 Nov 2010 16:06:51 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7C6E51F0001;
        Tue, 23 Nov 2010 16:06:51 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, kaloz@openwrt.org,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 03/18] MIPS: add generic support for multiple machines within a single kernel
Date:   Tue, 23 Nov 2010 16:06:25 +0100
Message-Id: <1290524800-21419-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A14B2CC0BA0 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds a generic solution to support multiple machines based on
a given SoC within a single kernel image. It is implemented already for
several other architectures but MIPS has no generic support for that yet.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---

Changes since RFC: ---

 arch/mips/Kconfig                    |    3 +
 arch/mips/include/asm/mips_machine.h |   54 +++++++++++++++++++++
 arch/mips/kernel/Makefile            |    1 +
 arch/mips/kernel/mips_machine.c      |   86 ++++++++++++++++++++++++++++++++++
 arch/mips/kernel/proc.c              |    7 ++-
 arch/mips/kernel/vmlinux.lds.S       |    7 +++
 6 files changed, 157 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/mips_machine.h
 create mode 100644 arch/mips/kernel/mips_machine.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ec69df5..307c2e4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -899,6 +899,9 @@ config MIPS_DISABLE_OBSOLETE_IDE
 config SYNC_R4K
 	bool
 
+config MIPS_MACHINE
+	def_bool n
+
 config NO_IOPORT
 	def_bool n
 
diff --git a/arch/mips/include/asm/mips_machine.h b/arch/mips/include/asm/mips_machine.h
new file mode 100644
index 0000000..363bb35
--- /dev/null
+++ b/arch/mips/include/asm/mips_machine.h
@@ -0,0 +1,54 @@
+/*
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_MIPS_MACHINE_H
+#define __ASM_MIPS_MACHINE_H
+
+#include <linux/init.h>
+#include <linux/stddef.h>
+
+#include <asm/bootinfo.h>
+
+struct mips_machine {
+	unsigned long		mach_type;
+	const char		*mach_id;
+	const char		*mach_name;
+	void			(*mach_setup)(void);
+};
+
+#define MIPS_MACHINE(_type, _id, _name, _setup)			\
+static const char machine_name_##_type[] __initconst		\
+			__aligned(1) = _name;			\
+static const char machine_id_##_type[] __initconst		\
+			__aligned(1) = _id;			\
+static struct mips_machine machine_##_type			\
+		__used __section(.mips.machines.init) =		\
+{								\
+	.mach_type	= _type,				\
+	.mach_id	= machine_id_##_type,			\
+	.mach_name	= machine_name_##_type,			\
+	.mach_setup	= _setup,				\
+};
+
+extern long __mips_machines_start;
+extern long __mips_machines_end;
+
+#ifdef CONFIG_MIPS_MACHINE
+int  mips_machtype_setup(char *id) __init;
+void mips_machine_setup(void) __init;
+void mips_set_machine_name(const char *name) __init;
+char *mips_get_machine_name(void);
+#else
+static inline int mips_machtype_setup(char *id) { return 1; }
+static inline void mips_machine_setup(void) { }
+static inline void mips_set_machine_name(const char *name) { }
+static inline char *mips_get_machine_name(void) { return NULL; }
+#endif /* CONFIG_MIPS_MACHINE */
+
+#endif /* __ASM_MIPS_MACHINE_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 22b2e0e..3977397 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_SPINLOCK_TEST)	+= spinlock_test.o
+obj-$(CONFIG_MIPS_MACHINE)	+= mips_machine.o
 
 obj-$(CONFIG_OF)		+= prom.o
 
diff --git a/arch/mips/kernel/mips_machine.c b/arch/mips/kernel/mips_machine.c
new file mode 100644
index 0000000..411a058
--- /dev/null
+++ b/arch/mips/kernel/mips_machine.c
@@ -0,0 +1,86 @@
+/*
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+#include <asm/mips_machine.h>
+
+static struct mips_machine *mips_machine __initdata;
+static char *mips_machine_name = "Unknown";
+
+#define for_each_machine(mach) \
+	for ((mach) = (struct mips_machine *)&__mips_machines_start; \
+	     (mach) && \
+	     (unsigned long)(mach) < (unsigned long)&__mips_machines_end; \
+	     (mach)++)
+
+__init void mips_set_machine_name(const char *name)
+{
+	char *p;
+
+	if (name == NULL)
+		return;
+
+	p = kstrdup(name, GFP_KERNEL);
+	if (!p)
+		pr_err("MIPS: no memory for machine_name\n");
+
+	mips_machine_name = p;
+}
+
+char *mips_get_machine_name(void)
+{
+	return mips_machine_name;
+}
+
+__init int mips_machtype_setup(char *id)
+{
+	struct mips_machine *mach;
+
+	for_each_machine(mach) {
+		if (mach->mach_id == NULL)
+			continue;
+
+		if (strcmp(mach->mach_id, id) == 0) {
+			mips_machtype = mach->mach_type;
+			return 0;
+		}
+	}
+
+	pr_err("MIPS: no machine found for id '%s', supported machines:\n", id);
+	pr_err("%-24s %s\n", "id", "name");
+	for_each_machine(mach)
+		pr_err("%-24s %s\n", mach->mach_id, mach->mach_name);
+
+	return 1;
+}
+
+__setup("machtype=", mips_machtype_setup);
+
+__init void mips_machine_setup(void)
+{
+	struct mips_machine *mach;
+
+	for_each_machine(mach) {
+		if (mips_machtype == mach->mach_type) {
+			mips_machine = mach;
+			break;
+		}
+	}
+
+	if (!mips_machine)
+		return;
+
+	mips_set_machine_name(mips_machine->mach_name);
+	pr_info("MIPS: machine is %s\n", mips_machine_name);
+
+	if (mips_machine->mach_setup)
+		mips_machine->mach_setup();
+}
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 26109c4..4195abb 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -12,6 +12,7 @@
 #include <asm/cpu-features.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
+#include <asm/mips_machine.h>
 
 unsigned int vced_count, vcei_count;
 
@@ -31,8 +32,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	/*
 	 * For the first processor also print the system type
 	 */
-	if (n == 0)
+	if (n == 0) {
 		seq_printf(m, "system type\t\t: %s\n", get_system_type());
+		if (mips_get_machine_name())
+			seq_printf(m, "machine\t\t\t: %s\n",
+				   mips_get_machine_name());
+	}
 
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index f25df73..570607b 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -98,6 +98,13 @@ SECTIONS
 	INIT_TEXT_SECTION(PAGE_SIZE)
 	INIT_DATA_SECTION(16)
 
+	. = ALIGN(4);
+	.mips.machines.init : AT(ADDR(.mips.machines.init) - LOAD_OFFSET) {
+		__mips_machines_start = .;
+		*(.mips.machines.init)
+		__mips_machines_end = .;
+	}
+
 	/* .exit.text is discarded at runtime, not link time, to deal with
 	 * references from .rodata
 	 */
-- 
1.7.2.1
