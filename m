Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 17:52:16 +0100 (BST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:51646 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S8133859AbWGTQwI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Jul 2006 17:52:08 +0100
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1G3bko-00024v-00
	for <linux-mips@linux-mips.org>; Thu, 20 Jul 2006 18:52:02 +0200
Subject: [PATCH] Honour "panic_on_oops" sysctl on mips arch
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Thu, 20 Jul 2006 18:52:02 +0200
Message-Id: <1153414322.20352.268.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


Hello all,

The panic_on_oops sysctl has no effect on mips, the following patch
fixes it.


Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

--- linux-2.6.17.6/arch/mips/kernel/traps.c.orig	2006-07-20 18:42:37.000000000 +0200
+++ linux-2.6.17.6/arch/mips/kernel/traps.c	2006-07-20 18:42:56.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
 #include <linux/bootmem.h>
+#include <linux/interrupt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -293,6 +294,16 @@
 	printk("%s[#%d]:\n", str, ++die_counter);
 	show_registers(regs);
 	spin_unlock_irq(&die_lock);
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+
+	if (panic_on_oops) {
+		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
+		ssleep(5);
+		panic("Fatal exception");
+	}
+
 	do_exit(SIGSEGV);
 }
 


Regards,

-- 
Maxime
