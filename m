Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 00:28:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50370 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859955AbaF1W2IY21j- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 00:28:08 +0200
Date:   Sat, 28 Jun 2014 23:28:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: c-r4k: Avoid duplicate CPU_74K/CPU_1074K checks
Message-ID: <alpine.LFD.2.11.1406282313490.15455@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Code in a switch statement in probe_pcache checks the CPU type twice 
unnecessarily for processor implementations that have the alias removal 
feature reported by the CP0 Config7.AR and Config7.IAR bits.  This change 
rewrites the affected fragment avoiding the extraneous check and improving 
readability.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Since nobody bothered to earn credit for integrating the proposal I posted 
earlier on:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=alpine.LFD.2.10.1403222210230.21669%40eddie.linux-mips.org

I decided to take the credit myself.  Ralf, please apply.

  Maciej

linux-mips-c-r4k-1074k-cleanup.patch
Index: linux-20140623-4maxp64/arch/mips/mm/c-r4k.c
===================================================================
--- linux-20140623-4maxp64.orig/arch/mips/mm/c-r4k.c
+++ linux-20140623-4maxp64/arch/mips/mm/c-r4k.c
@@ -1230,19 +1230,19 @@ static void probe_pcache(void)
 	case CPU_R14000:
 		break;
 
+	case CPU_74K:
+	case CPU_1074K:
+		alias_74k_erratum(c);
+		/* Fall through. */
 	case CPU_M14KC:
 	case CPU_M14KEC:
 	case CPU_24K:
 	case CPU_34K:
-	case CPU_74K:
 	case CPU_1004K:
-	case CPU_1074K:
 	case CPU_INTERAPTIV:
 	case CPU_P5600:
 	case CPU_PROAPTIV:
 	case CPU_M5150:
-		if ((c->cputype == CPU_74K) || (c->cputype == CPU_1074K))
-			alias_74k_erratum(c);
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
 		    (c->icache.waysize > PAGE_SIZE))
 			c->icache.flags |= MIPS_CACHE_ALIASES;
