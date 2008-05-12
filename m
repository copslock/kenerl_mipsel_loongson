Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 16:59:22 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:4823 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031639AbYELP7A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 16:59:00 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JvaQO-0004fL-01; Mon, 12 May 2008 17:58:52 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 29DB4DE534; Mon, 12 May 2008 17:58:48 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [UPDATED PATCH] Fix check for valid stack pointer during backtrace
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080512155849.29DB4DE534@solo.franken.de>
Date:	Mon, 12 May 2008 17:58:48 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19221
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

 arch/mips/kernel/traps.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cb8b0e2..f9165d1 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -88,15 +88,17 @@ static void show_raw_backtrace(unsigned long reg29)
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
