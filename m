Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 13:59:34 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:9158 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031017AbYELM7c (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 13:59:32 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JvXck-0002ba-01; Mon, 12 May 2008 14:59:26 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 0C641DE534; Mon, 12 May 2008 14:59:23 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix check for valid stack pointer during backtrace
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080512125923.0C641DE534@solo.franken.de>
Date:	Mon, 12 May 2008 14:59:23 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

The newly added check for valid stack pointer address breaks at least for
64bit kernels.  Use __get_user() for accessing stack content to avoid crashes,
when doing the backtrace.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/kernel/traps.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cb8b0e2..063d9bf 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -81,22 +81,24 @@ void (*board_bind_eic_interrupt)(int irq, int regset);
 
 static void show_raw_backtrace(unsigned long reg29)
 {
-	unsigned long *sp = (unsigned long *)(reg29 & ~3);
+	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);
 	unsigned long addr;
 
 	printk("Call Trace:");
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-#define IS_KVA01(a) ((((unsigned int)a) & 0xc0000000) == 0x80000000)
-	if (IS_KVA01(sp)) {
-		while (!kstack_end(sp)) {
-			addr = *sp++;
-			if (__kernel_text_address(addr))
-				print_ip_sym(addr);
+	while (!kstack_end(sp)) {
+		unsigned long __user *p =
+			(unsigned long __user *)(unsigned long)sp++;
+		if (__get_user(addr, p)) {
+			printk(" (Bad stack address)");
+			break;
 		}
-		printk("\n");
+		if (__kernel_text_address(addr))
+			print_ip_sym(addr);
 	}
+	printk("\n");
 }
 
 #ifdef CONFIG_KALLSYMS
