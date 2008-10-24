Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:09:50 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19303 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251756AbYJXA6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:58:39 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d680000>; Thu, 23 Oct 2008 20:57:12 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:11 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:11 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v6vN005673;
	Thu, 23 Oct 2008 17:57:06 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v63X005672;
	Thu, 23 Oct 2008 17:57:06 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 28/37] Cavium OCTEON FPU EMU exception as TLB exception
Date:	Thu, 23 Oct 2008 17:56:52 -0700
Message-Id: <1224809821-5532-29-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:11.0188 (UTC) FILETIME=[724C3D40:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

The FPU exceptions come in as TLB exceptions -- see if this is
one of them, and act accordingly.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/fault.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index fa636fc..9ce503a 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -47,6 +47,21 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
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
+	 * Terminate if exception was recognized as a delay slot return */
+	extern int do_dsemulret(struct pt_regs *);
+	if (do_dsemulret(regs))
+		return;
+#endif
+
 	info.si_code = SEGV_MAPERR;
 
 	/*
-- 
1.5.5.1
