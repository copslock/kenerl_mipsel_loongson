Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 17:20:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30509 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993306AbcHIPUJovBZN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 17:20:09 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3AF6D67CDF010;
        Tue,  9 Aug 2016 16:19:49 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 16:19:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ivan Delalande <colona@arista.com>,
        Thierry Reding <treding@nvidia.com>,
        Borislav Petkov <bp@suse.de>, Jan Kara <jack@suse.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2] console: Don't prefer first registered if DT specifies stdout-path
Date:   Tue, 9 Aug 2016 16:19:37 +0100
Message-ID: <20160809151937.26118-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160809125010.14150-1-paul.burton@imgtec.com>
References: <20160809125010.14150-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.230]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54463
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

If a device tree specifies a preferred device for kernel console output
via the stdout-path or linux,stdout-path chosen node properties or the
stdout alias then the kernel ought to honor it & output the kernel
console to that device. As it stands, this isn't the case. Whilst we
parse the stdout-path properties & set an of_stdout variable from
of_alias_scan(), and use that from of_console_check() to determine
whether to add a console device as a preferred console whilst
registering it, we also prefer the first registered console if no other
has been selected at the time of its registration.

This means that if a console other than the one the device tree selects
via stdout-path is registered first, we will switch to using it & when
the stdout-path console is later registered the call to
add_preferred_console() via of_console_check() is too late to do
anything useful. In practice this seems to mean that we switch to the
dummy console device fairly early & see no further console output:

    Console: colour dummy device 80x25
    console [tty0] enabled
    bootconsole [ns16550a0] disabled

Fix this by not automatically preferring the first registered console if
one is specified by the device tree. This allows consoles to be
registered but not enabled, and once the driver for the console selected
by stdout-path calls of_console_check() the driver will be added to the
list of preferred consoles before any other console has been enabled.
When that console is then registered via register_console() it will be
enabled as expected.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- Declare, not just define, static dummy function.

 drivers/of/base.c       |  2 ++
 include/linux/console.h |  6 ++++++
 kernel/printk/printk.c  | 13 ++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7792266..a930ec9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2011,6 +2011,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			name = of_get_property(of_aliases, "stdout", NULL);
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
+		if (of_stdout)
+			console_set_by_of();
 	}
 
 	if (!of_aliases)
diff --git a/include/linux/console.h b/include/linux/console.h
index d530c46..3672809 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -173,6 +173,12 @@ static inline void console_sysfs_notify(void)
 #endif
 extern bool console_suspend_enabled;
 
+#ifdef CONFIG_OF
+extern void console_set_by_of(void);
+#else
+static inline void console_set_by_of(void) {}
+#endif
+
 /* Suspend and resume console messages over PM events */
 extern void suspend_console(void);
 extern void resume_console(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a5ef95c..2b4947c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -253,6 +253,17 @@ static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
+#ifdef CONFIG_OF
+static bool of_specified_console;
+
+void console_set_by_of(void)
+{
+	of_specified_console = true;
+}
+#else
+# define of_specified_console false
+#endif
+
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
@@ -2668,7 +2679,7 @@ void register_console(struct console *newcon)
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (preferred_console < 0) {
+	if (preferred_console < 0 && !of_specified_console) {
 		if (newcon->index < 0)
 			newcon->index = 0;
 		if (newcon->setup == NULL ||
-- 
2.9.2
