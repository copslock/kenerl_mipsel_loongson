Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:15:04 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:25878 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533357AbYJ1AFe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:05:34 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f7000c>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:15 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:15 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S03AmH003352;
	Mon, 27 Oct 2008 17:03:10 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S03AvH003351;
	Mon, 27 Oct 2008 17:03:10 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 27/36] Add Cavium OCTEON slot into proper tlb category.
Date:	Mon, 27 Oct 2008 17:02:59 -0700
Message-Id: <1225152181-3221-27-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-26-git-send-email-ddaney@caviumnetworks.com>
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
X-OriginalArrivalTime: 28 Oct 2008 00:03:15.0397 (UTC) FILETIME=[9344B750:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Expand the case statement for build_tlb_write_entry so that it does
the right thing on Cavium CPU variants.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 979cf91..4294203 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -317,6 +317,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BCM3302:
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
+	case CPU_CAVIUM_OCTEON:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
 		tlbw(p);
-- 
1.5.6.5
