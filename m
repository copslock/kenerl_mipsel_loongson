Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 12:55:50 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:11459 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20029947AbYELLzs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 12:55:48 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JvWd7-000650-00; Mon, 12 May 2008 13:55:45 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 60F0EDE534; Mon, 12 May 2008 13:55:42 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix build_tlb_probe_entry for R4700
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080512115542.60F0EDE534@solo.franken.de>
Date:	Mon, 12 May 2008 13:55:42 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Treat R4700 like R4600 in build_tlb_probe_entry. Without this fix
kernel will lock up.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/mm/tlbex.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 382738c..76da73a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -224,8 +224,9 @@ static u32 final_handler[64] __cpuinitdata;
 static void __cpuinit __maybe_unused build_tlb_probe_entry(u32 **p)
 {
 	switch (current_cpu_type()) {
-	/* Found by experiment: R4600 v2.0 needs this, too.  */
+	/* Found by experiment: R4600 v2.0/R4700 needs this, too.  */
 	case CPU_R4600:
+	case CPU_R4700:
 	case CPU_R5000:
 	case CPU_R5000A:
 	case CPU_NEVADA:
