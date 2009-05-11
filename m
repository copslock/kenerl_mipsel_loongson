Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2009 20:13:02 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:51542 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026246AbZEKTM4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2009 20:12:56 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0878780000>; Mon, 11 May 2009 15:11:57 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 May 2009 12:11:06 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 May 2009 12:11:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4BJB34a021017;
	Mon, 11 May 2009 12:11:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4BJB2ZA021015;
	Mon, 11 May 2009 12:11:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Remove execution hazard barriers for Octeon.
Date:	Mon, 11 May 2009 12:11:02 -0700
Message-Id: <1242069062-20991-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 11 May 2009 19:11:06.0146 (UTC) FILETIME=[3BFC4820:01C9D26C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The Octeon has no execution hazards, so we can remove them and save an
instruction per TLB handler invocation.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3548acf..4b2ea1f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -257,7 +257,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case tlb_indexed: tlbw = uasm_i_tlbwi; break;
 	}
 
-	if (cpu_has_mips_r2) {
+	if (cpu_has_mips_r2 && current_cpu_type() != CPU_CAVIUM_OCTEON) {
 		uasm_i_ehb(p);
 		tlbw(p);
 		return;
-- 
1.6.0.6
