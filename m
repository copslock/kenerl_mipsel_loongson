Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 17:00:00 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:59849 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20022729AbXJYP7w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 16:59:52 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id A49F848EA5;
	Thu, 25 Oct 2007 17:52:37 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1Il572-00078y-BG; Thu, 25 Oct 2007 16:59:12 +0100
Date:	Thu, 25 Oct 2007 16:59:12 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Use a sensible tlbex default for unknown CPUs
Message-ID: <20071025155912.GD3994@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

currently the kernel panics when it boots on an unknown CPU model
(with an unknown PRID). Based on the assumption that the majority
of newly supported CPU will conform to Release 2 standard, I wrote
the appended patch which handles unknown CPUs as R2. It isn't
completely bulletproof, as (yet unsupported) non-R1/R2 CPUs may
use the AT config bits for different purposes. I still think this
is good enough a test.

This patch allows me to boot Linux on a "generic" MIPS64R2 Qemu
without making up a potentially conflicting PRID. All-zeroes
like for other undefined fields does fine.


Thiemo


Signed-Off-By: Thiemo Seufer <ths@networkno.de>
---

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a61246d..82188f2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -935,14 +935,6 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 		tlbw(p);
 		break;
 
-	case CPU_4KEC:
-	case CPU_24K:
-	case CPU_34K:
-	case CPU_74K:
-		i_ehb(p);
-		tlbw(p);
-		break;
-
 	case CPU_RM9000:
 		/*
 		 * When the JTLB is updated by tlbwi or tlbwr, a subsequent
@@ -982,8 +974,18 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 		break;
 
 	default:
-		panic("No TLB refill handler yet (CPU type: %d)",
-		      current_cpu_data.cputype);
+		/* Panic if this isn't a Release 2 CPU. */
+		if (!((read_c0_config() & MIPS_CONF_AT) >> 13)) {
+			panic("No TLB refill handler yet (CPU type: %d)",
+			      current_cpu_data.cputype);
+		}
+		/* fall through */
+	case CPU_4KEC:
+	case CPU_24K:
+	case CPU_34K:
+	case CPU_74K:
+		i_ehb(p);
+		tlbw(p);
 		break;
 	}
 }
