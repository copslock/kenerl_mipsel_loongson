Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:31:46 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51230 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010670AbaJGFapxeTnX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:30:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=N3GWdxDyBtTxspFESvoHlUXT8RAs/5H7I5C7CUAVt2A=;
        b=X80VjFYEVJFnkWjDlav+e79Mpu+2UkHc5DsRDqP3yNYg4HR0u0b9BSlvAF1q83Bg1pR84qQ4KpzOAkO02Jvz2keEznTepm7fXYvOw89+VKKff5MEODtzNcQyHeLDAw6WY6o/muOR3zDEtPKnntv0HcQS0IJHGkJ1wkysfN/ZEg4=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNM7-002hIT-Dm
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:30:39 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32894 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNKT-002Zpj-Tt; Tue, 07 Oct 2014 05:28:59 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Romain Perier <romain.perier@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Alexander Graf <agraf@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 01/44] kernel: Add support for poweroff handler call chain
Date:   Mon,  6 Oct 2014 22:28:03 -0700
Message-Id: <1412659726-29957-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.3
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020206.54337A7F.00C2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 747
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Various drivers implement architecture and/or device specific means to
remove power from the system.  For the most part, those drivers set the
global variable pm_power_off to point to a function within the driver.

This mechanism has a number of drawbacks.  Typically only one scheme
to remove power is supported (at least if pm_power_off is used).
At least in theory there can be multiple means remove power, some of
which may be less desirable. For example, some mechanisms may only
power off the CPU or the CPU card, while another may power off the
entire system.  Others may really just execute a restart sequence
or drop into the ROM monitor. Using pm_power_off can also be racy
if the function pointer is set from a driver built as module, as the
driver may be in the process of being unloaded when pm_power_off is
called. If there are multiple poweroff handlers in the system, removing
a module with such a handler may inadvertently reset the pointer to
pm_power_off to NULL, leaving the system with no means to remove power.

Introduce a system poweroff handler call chain to solve the described
problems.  This call chain is expected to be executed from the
architecture specific machine_power_off() function.  Drivers providing
system poweroff functionality are expected to register with this call chain.
By using the priority field in the notifier block, callers can control
poweroff handler execution sequence and thus ensure that the poweroff
handler with the optimal capabilities to remove power for a given system
is called first.

Cc: Andrew Morton <akpm@linux-foundation.org>
cc: Heiko Stuebner <heiko@sntech.de>
Cc: Romain Perier <romain.perier@gmail.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Alexander Graf <agraf@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/pm.h              |  13 +++
 kernel/power/Makefile           |   1 +
 kernel/power/poweroff_handler.c | 172 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 kernel/power/poweroff_handler.c

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 72c0fe0..45271b5 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -34,6 +34,19 @@
 extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
 
+/*
+ * Callbacks to manage poweroff handlers
+ */
+
+struct notifier_block;
+
+extern int register_poweroff_handler(struct notifier_block *);
+extern int register_poweroff_handler_simple(void (*function)(void),
+					    int priority);
+extern int unregister_poweroff_handler(struct notifier_block *);
+extern void do_kernel_poweroff(void);
+extern bool have_kernel_poweroff(void);
+
 struct device; /* we have a circular dep with device.h */
 #ifdef CONFIG_VT_CONSOLE_SLEEP
 extern void pm_vt_switch_required(struct device *dev, bool required);
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 29472bf..4d9f0c7 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -2,6 +2,7 @@
 ccflags-$(CONFIG_PM_DEBUG)	:= -DDEBUG
 
 obj-y				+= qos.o
+obj-y				+= poweroff_handler.o
 obj-$(CONFIG_PM)		+= main.o
 obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= console.o
 obj-$(CONFIG_FREEZER)		+= process.o
diff --git a/kernel/power/poweroff_handler.c b/kernel/power/poweroff_handler.c
new file mode 100644
index 0000000..ed99e5e
--- /dev/null
+++ b/kernel/power/poweroff_handler.c
@@ -0,0 +1,172 @@
+/*
+ * linux/kernel/power/poweroff_handler.c - Poweroff handling functions
+ *
+ * Copyright (c) 2014 Guenter Roeck
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt)	"poweroff: " fmt
+
+#include <linux/ctype.h>
+#include <linux/export.h>
+#include <linux/kallsyms.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to power off the system.
+ */
+static ATOMIC_NOTIFIER_HEAD(poweroff_handler_list);
+
+/**
+ *	register_poweroff_handler - Register function to be called to power off
+ *				    the system
+ *	@nb: Info about handler function to be called
+ *	@nb->priority:	Handler priority. Handlers should follow the
+ *			following guidelines for setting priorities.
+ *			0:	Poweroff handler of last resort,
+ *				with limited poweroff capabilities,
+ *				such as poweroff handlers which
+ *				do not really power off the system
+ *				but loop forever or stop the CPU.
+ *			128:	Default poweroff handler; use if no other
+ *				poweroff handler is expected to be available,
+ *				and/or if poweroff functionality is
+ *				sufficient to power off the entire system
+ *			255:	Highest priority poweroff handler, will
+ *				preempt all other poweroff handlers
+ *
+ *	Registers a function with code to be called to power off the
+ *	system.
+ *
+ *	Registered functions will be called from machine_power_off as last
+ *	step of the poweroff sequence. Registered functions are expected
+ *	to power off the system immediately. If more than one function is
+ *	registered, the poweroff handler priority selects which function
+ *	will be called first.
+ *
+ *	Poweroff handlers may be registered from architecture code or from
+ *	drivers. A typical use case would be a system where power off
+ *	functionality is provided through a multi-function chip or through
+ *	a programmable power controller. Multiple poweroff handlers may exist;
+ *	for example, one poweroff handler might power off the entire system,
+ *	while another only powers off the CPU card. In such cases, the
+ *	poweroff handler which only powers off part of the hardware is
+ *	expected to register with low priority to ensure that it only
+ *	runs if no other means to power off the system are available.
+ *
+ *	Currently always returns zero, as atomic_notifier_chain_register()
+ *	always returns zero.
+ */
+int register_poweroff_handler(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&poweroff_handler_list, nb);
+}
+EXPORT_SYMBOL(register_poweroff_handler);
+
+/**
+ *	unregister_poweroff_handler - Unregister previously registered
+ *				      poweroff handler
+ *	@nb: Hook to be unregistered
+ *
+ *	Unregisters a previously registered poweroff handler function.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_poweroff_handler(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&poweroff_handler_list, nb);
+}
+EXPORT_SYMBOL(unregister_poweroff_handler);
+
+struct _poweroff_handler_data {
+	void (*handler)(void);
+	struct notifier_block poweroff_nb;
+};
+
+static int _poweroff_handler(struct notifier_block *this,
+			     unsigned long _unused1, void *_unused2)
+{
+	struct _poweroff_handler_data *poh =
+		container_of(this, struct _poweroff_handler_data, poweroff_nb);
+
+	poh->handler();
+
+	return NOTIFY_DONE;
+}
+
+static struct _poweroff_handler_data poweroff_handler_data;
+
+/**
+ *	register_poweroff_handler_simple - Register function to be called to power off
+ *					   the system
+ *	@handler:	Function to be called to power off the system
+ *	@priority:	Handler priority. For priority guidelines see
+ *			register_poweroff_handler.
+ *
+ *	This is a simplified version of register_poweroff_handler. It does not
+ *	take a notifier as argument, but a function pointer. The function
+ *	registers a poweroff handler with specified priority. Poweroff
+ *	handlers registered with this function can not be unregistered,
+ *	and only a single poweroff handler can be installed using it.
+ *
+ *	This function must not be called from modules and is therefore
+ *	not exported.
+ *
+ *	Returns -EBUSY if a poweroff handler has already been registered
+ *	using register_poweroff_handler_simple. Otherwise returns zero,
+ *	since atomic_notifier_chain_register() currently always returns zero.
+ */
+int register_poweroff_handler_simple(void (*handler)(void), int priority)
+{
+	char symname[KSYM_NAME_LEN];
+
+	if (poweroff_handler_data.handler) {
+		lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
+				   symname);
+		pr_warn("Poweroff function already registered (%s)", symname);
+		lookup_symbol_name((unsigned long)handler, symname);
+		pr_cont(", cannot register %s\n", symname);
+		return -EBUSY;
+	}
+
+	poweroff_handler_data.handler = handler;
+	poweroff_handler_data.poweroff_nb.notifier_call = _poweroff_handler;
+	poweroff_handler_data.poweroff_nb.priority = priority;
+
+	return register_poweroff_handler(&poweroff_handler_data.poweroff_nb);
+}
+
+/**
+ *	do_kernel_poweroff - Execute kernel poweroff handler call chain
+ *
+ *	Calls functions registered with register_poweroff_handler.
+ *
+ *	Expected to be called from machine_power_off as last step of
+ *	the poweroff sequence.
+ *
+ *	Powers off the system immediately if a poweroff handler function
+ *	has been registered. Otherwise does nothing.
+ */
+void do_kernel_poweroff(void)
+{
+	atomic_notifier_call_chain(&poweroff_handler_list, 0, NULL);
+}
+
+/**
+ * have_kernel_poweroff() - Check if kernel poweroff handler is available
+ *
+ * Returns true is a kernel poweroff handler is available, false otherwise.
+ */
+bool have_kernel_poweroff(void)
+{
+	return pm_power_off != NULL || poweroff_handler_list.head != NULL;
+}
+EXPORT_SYMBOL(have_kernel_poweroff);
-- 
1.9.1
