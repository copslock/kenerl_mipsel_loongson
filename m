Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 02:07:44 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:41975 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492410Ab0FAAHl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 02:07:41 +0200
Received: (qmail 13323 invoked from network); 1 Jun 2010 00:07:35 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 1 Jun 2010 00:07:35 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Mon, 31 May 2010 17:07:34 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     <mingo@elte.hu>, <akpm@linux-foundation.org>,
        <simon.kagstrom@netinsight.net>, <David.Woodhouse@intel.com>,
        <rgetz@analog.com>, <lethal@linux-sh.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Date:   Mon, 31 May 2010 16:57:15 -0700
Subject: [PATCH v2] printk: fix delayed messages from CPU hotplug events
Message-Id: <ede63b5a20af951c755736f035d1e787772d7c28@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 26951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

When a secondary CPU is being brought up, it is not uncommon for
printk() to be invoked when cpu_online(smp_processor_id()) == 0.  The
case that I witnessed personally was on MIPS:

http://lkml.org/lkml/2010/5/30/4

If (can_use_console() == 0), printk() will spool its output to log_buf
and it will be visible in "dmesg", but that output will NOT be echoed to
the console until somebody calls release_console_sem() from a CPU that
is online.  Therefore, the boot time messages from the new CPU can get
stuck in "limbo" for a long time, and might suddenly appear on the
screen when a completely unrelated event (e.g. "eth0: link is down")
occurs.

This patch modifies the console code so that any pending messages are
automatically flushed out to the console whenever a CPU hotplug
operation completes successfully or aborts.

The issue was seen on 2.6.34.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 kernel/printk.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 444b770..9c04719 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -37,6 +37,8 @@
 #include <linux/ratelimit.h>
 #include <linux/kmsg_dump.h>
 #include <linux/syslog.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 
@@ -985,6 +987,37 @@ void resume_console(void)
 }
 
 /**
+ * console_cpu_notify - print deferred console messages after CPU hotplug
+ *
+ * If printk() is called from a CPU that is not online yet, the messages
+ * will be spooled but will not show up on the console.  This function is
+ * called when a new CPU comes online and ensures that any such output
+ * gets printed.
+ */
+static int __cpuinit console_cpu_notify(struct notifier_block *self,
+	unsigned long action, void *hcpu)
+{
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_UP_CANCELED:
+		if (try_acquire_console_sem() == 0)
+			release_console_sem();
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata console_nb = {
+	.notifier_call		= console_cpu_notify,
+};
+
+static int __init console_notifier_init(void)
+{
+	register_cpu_notifier(&console_nb);
+	return 0;
+}
+late_initcall(console_notifier_init);
+
+/**
  * acquire_console_sem - lock the console system for exclusive use.
  *
  * Acquires a semaphore which guarantees that the caller has
-- 
1.7.0.4
