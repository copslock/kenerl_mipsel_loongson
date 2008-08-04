Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 18:44:46 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:3248 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20039720AbYHDRoj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2008 18:44:39 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KQ46n-0003vC-00; Mon, 04 Aug 2008 19:44:37 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 7BD6FC2EAC; Mon,  4 Aug 2008 19:44:34 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix data bus error recovery
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080804174434.7BD6FC2EAC@solo.franken.de>
Date:	Mon,  4 Aug 2008 19:44:34 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

With -ffunction-section the entries in __dbe_table aren't no longer
sorted, so the lookup of exception addresses in do_be() failed for
some addresses. To avoid this we now sort __dbe_table.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/kernel/traps.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 426cced..1f579a8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -373,8 +373,8 @@ void __noreturn die(const char * str, const struct pt_regs * regs)
 	do_exit(SIGSEGV);
 }
 
-extern const struct exception_table_entry __start___dbe_table[];
-extern const struct exception_table_entry __stop___dbe_table[];
+extern struct exception_table_entry __start___dbe_table[];
+extern struct exception_table_entry __stop___dbe_table[];
 
 __asm__(
 "	.section	__dbe_table, \"a\"\n"
@@ -1682,4 +1682,6 @@ void __init trap_init(void)
 
 	flush_icache_range(ebase, ebase + 0x400);
 	flush_tlb_handlers();
+
+	sort_extable(__start___dbe_table, __stop___dbe_table);
 }
