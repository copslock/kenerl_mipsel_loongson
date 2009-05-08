Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 20:53:40 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:34380 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S28573926AbZEHTxe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 20:53:34 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a048da70001>; Fri, 08 May 2009 15:53:12 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 May 2009 12:52:18 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 May 2009 12:52:18 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n48JqFFb021067;
	Fri, 8 May 2009 12:52:15 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n48JqAHS021065;
	Fri, 8 May 2009 12:52:10 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Don't write ones to reserved entryhi bits.
Date:	Fri,  8 May 2009 12:52:10 -0700
Message-Id: <1241812330-21041-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 08 May 2009 19:52:18.0578 (UTC) FILETIME=[7E6E3720:01C9D016]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

According to the MIPS64 Privileged Resource Architecture manual, only
values of zero may be written to bits 8..10 of CP0 entryhi.  We need
to add masking by ASID_MASK.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mmu_context.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index d7f3eb0..3899f99 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -169,7 +169,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	ehb(); /* Make sure it propagates to TCStatus */
 	evpe(mtflags);
 #else
-	write_c0_entryhi(cpu_context(cpu, next));
+	write_c0_entryhi(cpu_context(cpu, next) & ASID_MASK);
 #endif /* CONFIG_MIPS_MT_SMTC */
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
 
@@ -229,7 +229,7 @@ activate_mm(struct mm_struct *prev, struct mm_struct *next)
 	ehb(); /* Make sure it propagates to TCStatus */
 	evpe(mtflags);
 #else
-	write_c0_entryhi(cpu_context(cpu, next));
+	write_c0_entryhi(cpu_context(cpu, next) & ASID_MASK);
 #endif /* CONFIG_MIPS_MT_SMTC */
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
 
-- 
1.6.0.6
