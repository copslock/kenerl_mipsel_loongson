Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 20:08:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52339 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825760Ab3IRSIPdqM9J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 20:08:15 +0200
Date:   Wed, 18 Sep 2013 19:08:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [MIPS] Correct 74K/1074K erratum workaround
Message-ID: <alpine.LFD.2.03.1309171725580.5967@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37874
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

Make sure 74K revision numbers are not applied to the 1074K.  Also catch 
invalid usage.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Please apply.  I saw a similar change fly by, but it lacked the necessary 
readability and the safety guard, to say nothing of the change explanation 
chosen.

  Maciej

linux-mips-74k-erratum.patch
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mm/c-r4k.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/mm/c-r4k.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mm/c-r4k.c
@@ -780,20 +780,30 @@ static inline void rm7k_erratum31(void)
 
 static inline void alias_74k_erratum(struct cpuinfo_mips *c)
 {
+	unsigned int imp = c->processor_id & PRID_IMP_MASK;
+	unsigned int rev = c->processor_id & PRID_REV_MASK;
+
 	/*
 	 * Early versions of the 74K do not update the cache tags on a
 	 * vtag miss/ptag hit which can occur in the case of KSEG0/KUSEG
 	 * aliases. In this case it is better to treat the cache as always
 	 * having aliases.
 	 */
-	if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_ENCODE_332(2, 4, 0))
-		c->dcache.flags |= MIPS_CACHE_VTAG;
-	if ((c->processor_id & PRID_REV_MASK) == PRID_REV_ENCODE_332(2, 4, 0))
-		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
-	if ((c->processor_id & PRID_IMP_MASK) == PRID_IMP_1074K &&
-	    (c->processor_id & PRID_REV_MASK) <= PRID_REV_ENCODE_332(1, 1, 0)) {
-		c->dcache.flags |= MIPS_CACHE_VTAG;
-		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+	switch (imp) {
+	case PRID_IMP_74K:
+		if (rev <= PRID_REV_ENCODE_332(2, 4, 0))
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+		if (rev == PRID_REV_ENCODE_332(2, 4, 0))
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		break;
+	case PRID_IMP_1074K:
+		if (rev <= PRID_REV_ENCODE_332(1, 1, 0)) {
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		}
+		break;
+	default:
+		BUG();
 	}
 }
 
