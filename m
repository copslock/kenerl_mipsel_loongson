Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 22:39:11 +0000 (GMT)
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:2459 "EHLO
	outbound5-sin-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20039413AbYAOWjB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 22:39:01 +0000
Received: from outbound5-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound5-sin-R.bigfish.com (Postfix) with ESMTP id 56884F100DC;
	Tue, 15 Jan 2008 22:35:57 +0000 (UTC)
Received: from mail206-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound5-sin.bigfish.com (Postfix) with ESMTP id 3F47A8B805E;
	Tue, 15 Jan 2008 22:35:57 +0000 (UTC)
Received: from mail206-sin (localhost.localdomain [127.0.0.1])
	by mail206-sin-R.bigfish.com (Postfix) with ESMTP id 27F7C4C011E;
	Tue, 15 Jan 2008 22:35:57 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.66.75;Service: EHS
Received: by mail206-sin (MessageSwitch) id 1200436557143523_24849; Tue, 15 Jan 2008 22:35:57 +0000 (UCT)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	by mail206-sin.bigfish.com (Postfix) with ESMTP id A5F9181005B;
	Tue, 15 Jan 2008 22:35:56 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id m0FMZtLh029257;
	Tue, 15 Jan 2008 22:35:55 GMT
Received: from USBMAXIM02.am.sony.com ([43.145.108.26])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0FMZsqt008477;
	Tue, 15 Jan 2008 22:35:54 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM02.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 15 Jan 2008 17:35:54 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 17:35:54 -0500
Subject: [PATCH 4/4] invoke kgdb via magic sysrq
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <1200436139.4092.30.camel@bx740>
References: <1200436139.4092.30.camel@bx740>
Content-Type: text/plain
Date:	Tue, 15 Jan 2008 14:34:54 -0800
Message-Id: <1200436494.4092.39.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 22:35:54.0145 (UTC) FILETIME=[FD18A110:01C857C6]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips

From: Frank Rowand <frank.rowand@am.sony.com>

Add hooks so that the host can connect to KGDB or asynchronously invoke an
already connected KGDB via a magic sysrq.  This should work for most MIPS
targets that support KGDB, though it has only been tested on the Toshiba
RBTX4927.  This can be useful to invoke an already connected KGDB for some
types of system hang.  It also allows normally booting without connecting
to KGDB, then later connecting to KGDB if kernel debugging is desired.

This functionality exists for PowerPC and sh.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 arch/mips/kernel/gdb-stub.c |   26 	26 +	0 -	0 !
 1 files changed, 26 insertions(+)

Index: linux-2.6.24-rc7/arch/mips/kernel/gdb-stub.c
===================================================================
--- linux-2.6.24-rc7.orig/arch/mips/kernel/gdb-stub.c
+++ linux-2.6.24-rc7/arch/mips/kernel/gdb-stub.c
@@ -131,6 +131,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/reboot.h>
+#include <linux/sysrq.h>
 
 #include <asm/asm.h>
 #include <asm/cacheflush.h>
@@ -1154,3 +1155,28 @@ static int __init register_gdb_console(v
 console_initcall(register_gdb_console);
 
 #endif
+
+#ifdef CONFIG_MAGIC_SYSRQ
+static void sysrq_handle_gdb(int key, struct tty_struct *tty)
+{
+	if (!initialized) {
+		printk(KERN_ALERT "Wait for gdb client connection ...\n");
+		set_debug_traps();
+	}
+
+	breakpoint();
+}
+static struct sysrq_key_op sysrq_gdb_op = {
+	.handler        = sysrq_handle_gdb,
+	.help_msg       = "Gdb",
+	.action_msg     = "GDB",
+};
+
+static int gdb_register_sysrq(void)
+{
+	printk(KERN_INFO "Registering GDB sysrq handler\n");
+	register_sysrq_key('g', &sysrq_gdb_op);
+	return 0;
+}
+module_init(gdb_register_sysrq);
+#endif
