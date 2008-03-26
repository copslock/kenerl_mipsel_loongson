Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 19:14:08 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:34193 "EHLO elvis.franken.de")
	by lappi.linux-mips.net with ESMTP id S1102780AbYCZPq1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 16:46:27 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JeXmD-0000Fz-00; Wed, 26 Mar 2008 16:42:57 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id D6760C2B7D; Wed, 26 Mar 2008 16:42:54 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Add missing 4KEC TLB refill handler
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080326154254.D6760C2B7D@solo.franken.de>
Date:	Wed, 26 Mar 2008 16:42:54 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Early 4KEc were MIPS32r1 and therefore need some love to get a TLB 
refill handler.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/mm/tlbex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3a93d4c..382738c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -307,6 +307,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R12000:
 	case CPU_R14000:
 	case CPU_4KC:
+	case CPU_4KEC:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_4KSC:
