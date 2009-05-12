Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 20:44:35 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10297 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025982AbZELTnY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 20:43:24 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a09d1400004>; Tue, 12 May 2009 15:42:56 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:42:00 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:42:00 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4CJfujr020753;
	Tue, 12 May 2009 12:41:56 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4CJfuc0020752;
	Tue, 12 May 2009 12:41:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] MIPS: Remove dead case label.
Date:	Tue, 12 May 2009 12:41:55 -0700
Message-Id: <1242157315-20719-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A09D0B1.2030305@caviumnetworks.com>
References: <4A09D0B1.2030305@caviumnetworks.com>
X-OriginalArrivalTime: 12 May 2009 19:42:00.0098 (UTC) FILETIME=[B770A820:01C9D339]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

CPU_CAVIUM_OCTEON is mips_r2 which is handled before the switch.  This
label in the switch statement is dead code, so we remove it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4108674..4dc4f3e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -311,7 +311,6 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BCM3302:
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
-	case CPU_CAVIUM_OCTEON:
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
-- 
1.6.0.6
