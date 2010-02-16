Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2010 00:27:00 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4762 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491789Ab0BPX0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2010 00:26:54 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7b29bf0000>; Tue, 16 Feb 2010 15:27:00 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 16 Feb 2010 15:26:45 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 16 Feb 2010 15:26:45 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1GNQeop020374;
        Tue, 16 Feb 2010 15:26:41 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1GNQbdF020317;
        Tue, 16 Feb 2010 15:26:37 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: crazy spinlock speed test.
Date:   Tue, 16 Feb 2010 15:26:35 -0800
Message-Id: <1266362795-20199-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
X-OriginalArrivalTime: 16 Feb 2010 23:26:45.0566 (UTC) FILETIME=[8111C5E0:01CAAF5F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is just a test program for raw_spinlocks.  The main reason I
wrote it is to validate my spinlock changes that I sent in a previous
patch.

To use it enable CONFIG_DEBUG_FS and CONFIG_SPINLOCK_TEST then at run
time do:

# mount -t debugfs none /sys/kernel/debug/
# cat /sys/kernel/debug/mips/spin_single
# cat /sys/kernel/debug/mips/spin_multi

On my 600MHz octeon cn5860 (16 CPUs) I get

		spin_single	spin_multi
base		106885		247941
spinlock_patch	75194		219465

This shows that for uncontended locks the spinlock patch gives 41%
improvement and for contended locks 12% improvement (1/time).

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig.debug          |    7 ++
 arch/mips/kernel/Makefile        |    1 +
 arch/mips/kernel/spinlock_test.c |  141 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/spinlock_test.c

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index d8c0fd7..8354a18 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -131,4 +131,11 @@ config DEBUG_ZBOOT
 	  to reduce the kernel image size and speed up the booting procedure a
 	  little.
 
+config SPINLOCK_TEST
+	bool "Enable spinlock timing tests in debugfs"
+	depends on DEBUG_FS
+	default n
+	help
+	  Add several files to the debugfs to test spinlock speed.
+
 endmenu
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 642ae95..aac78e3 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_SPINLOCK_TEST)	+= spinlock_test.o
 
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
diff --git a/arch/mips/kernel/spinlock_test.c b/arch/mips/kernel/spinlock_test.c
new file mode 100644
index 0000000..da61134
--- /dev/null
+++ b/arch/mips/kernel/spinlock_test.c
@@ -0,0 +1,141 @@
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/hrtimer.h>
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+
+static int ss_get(void *data, u64 *val)
+{
+	ktime_t start, finish;
+	int loops;
+	int cont;
+	DEFINE_RAW_SPINLOCK(ss_spin);
+
+	loops = 1000000;
+	cont = 1;
+
+	start = ktime_get();
+
+	while (cont) {
+		raw_spin_lock(&ss_spin);
+		loops--;
+		if (loops == 0)
+			cont = 0;
+		raw_spin_unlock(&ss_spin);
+	}
+
+	finish = ktime_get();
+
+	*val = ktime_us_delta(finish, start);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_ss, ss_get, NULL, "%llu\n");
+
+
+
+struct spin_multi_state {
+	raw_spinlock_t lock;
+	atomic_t start_wait;
+	atomic_t enter_wait;
+	atomic_t exit_wait;
+	int loops;
+};
+
+struct spin_multi_per_thread {
+	struct spin_multi_state *state;
+	ktime_t start;
+};
+
+static int multi_other(void *data)
+{
+	int loops;
+	int cont;
+	struct spin_multi_per_thread *pt = data;
+	struct spin_multi_state *s = pt->state;
+
+	loops = s->loops;
+	cont = 1;
+
+	atomic_dec(&s->enter_wait);
+
+	while (atomic_read(&s->enter_wait))
+		; /* spin */
+
+	pt->start = ktime_get();
+
+	atomic_dec(&s->start_wait);
+
+	while (atomic_read(&s->start_wait))
+		; /* spin */
+
+	while (cont) {
+		raw_spin_lock(&s->lock);
+		loops--;
+		if (loops == 0)
+			cont = 0;
+		raw_spin_unlock(&s->lock);
+	}
+
+	atomic_dec(&s->exit_wait);
+	while (atomic_read(&s->exit_wait))
+		; /* spin */
+	return 0;
+}
+
+static int multi_get(void *data, u64 *val)
+{
+	ktime_t finish;
+	struct spin_multi_state ms;
+	struct spin_multi_per_thread t1, t2;
+
+	ms.lock = __RAW_SPIN_LOCK_UNLOCKED("multi_get");
+	ms.loops = 1000000;
+
+	atomic_set(&ms.start_wait, 2);
+	atomic_set(&ms.enter_wait, 2);
+	atomic_set(&ms.exit_wait, 2);
+	t1.state = &ms;
+	t2.state = &ms;
+
+	kthread_run(multi_other, &t2, "multi_get");
+
+	multi_other(&t1);
+
+	finish = ktime_get();
+
+	*val = ktime_us_delta(finish, t1.start);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_multi, multi_get, NULL, "%llu\n");
+
+
+extern struct dentry *mips_debugfs_dir;
+static int __init spinlock_test(void)
+{
+	struct dentry *d;
+
+	if (!mips_debugfs_dir)
+		return -ENODEV;
+
+	d = debugfs_create_file("spin_single", S_IRUGO,
+				mips_debugfs_dir, NULL,
+				&fops_ss);
+	if (!d)
+		return -ENOMEM;
+
+	d = debugfs_create_file("spin_multi", S_IRUGO,
+				mips_debugfs_dir, NULL,
+				&fops_multi);
+	if (!d)
+		return -ENOMEM;
+
+	return 0;
+}
+device_initcall(spinlock_test);
-- 
1.6.6
