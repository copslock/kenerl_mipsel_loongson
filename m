Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 00:48:18 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13126 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492317AbZIBWsL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2009 00:48:11 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a9ef60a0000>; Wed, 02 Sep 2009 18:47:40 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Sep 2009 15:47:41 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Sep 2009 15:47:41 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n82MlaoI021293;
	Wed, 2 Sep 2009 15:47:36 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n82MlZ0J021292;
	Wed, 2 Sep 2009 15:47:35 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Don't corrupt page tables on vmalloc fault.
Date:	Wed,  2 Sep 2009 15:47:34 -0700
Message-Id: <1251931654-21268-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 02 Sep 2009 22:47:41.0243 (UTC) FILETIME=[60C238B0:01CA2C1F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The code after the vmalloc_fault: label in do_page_fault() modifies
user page tables, this is not correct for 64-bit kernels.

For 64-bit kernels we should go straight to the no_context handler
skipping vmalloc_fault.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/fault.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index f956ecb..e97a7a2 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -58,11 +58,17 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
+#ifdef CONFIG_64BIT
+# define VMALLOC_FAULT_TARGET no_context
+#else
+# define VMALLOC_FAULT_TARGET vmalloc_fault
+#endif
+
 	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
-		goto vmalloc_fault;
+		goto VMALLOC_FAULT_TARGET;
 #ifdef MODULE_START
 	if (unlikely(address >= MODULE_START && address < MODULE_END))
-		goto vmalloc_fault;
+		goto VMALLOC_FAULT_TARGET;
 #endif
 
 	/*
@@ -203,6 +209,7 @@ do_sigbus:
 	force_sig_info(SIGBUS, &info, tsk);
 
 	return;
+#ifndef CONFIG_64BIT
 vmalloc_fault:
 	{
 		/*
@@ -241,4 +248,5 @@ vmalloc_fault:
 			goto no_context;
 		return;
 	}
+#endif
 }
-- 
1.6.0.6
