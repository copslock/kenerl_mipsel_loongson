Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:16:45 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:35350 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533367AbYJ1AFn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:05:43 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f70010>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:16 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:16 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S03Bfv003360;
	Mon, 27 Oct 2008 17:03:11 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S03BTD003359;
	Mon, 27 Oct 2008 17:03:11 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 29/36] Cavium OCTEON FPU EMU exception as TLB exception
Date:	Mon, 27 Oct 2008 17:03:01 -0700
Message-Id: <1225152181-3221-29-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-28-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-16-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-17-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-18-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-19-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-20-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-21-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-22-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-23-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-24-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-25-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-26-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-27-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-28-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:16.0600 (UTC) FILETIME=[93FC4780:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The FPU exceptions come in as TLB exceptions -- see if this is
one of them, and act accordingly.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/fault.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index fa636fc..c8a3fb5 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/ptrace.h>
 #include <asm/highmem.h>		/* For VMALLOC_END */
+#include <asm/fpu_emulator.h>
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -47,6 +48,21 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	       field, regs->cp0_epc);
 #endif
 
+#ifdef CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
+	/*
+	 * Normally the FPU emulator uses a load word from address one
+	 * to retake control of the CPU after executing the
+	 * instruction in the delay slot of an emulated branch. The
+	 * Octeon hardware unaligned access fix changes this from an
+	 * address exception into a TLB exception. This code checks to
+	 * see if this page fault was caused by an FPU emulation.
+	 *
+	 * Terminate if exception was recognized as a delay slot return.
+	 */
+	if (do_dsemulret(regs))
+		return;
+#endif
+
 	info.si_code = SEGV_MAPERR;
 
 	/*
-- 
1.5.6.5
