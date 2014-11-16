Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 02:02:45 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:60612 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013700AbaKPBCnSl90G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 02:02:43 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-02.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XpoEb-0002f6-Py from Maciej_Rozycki@mentor.com ; Sat, 15 Nov 2014 17:02:34 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-02.mgc.mentorg.com
 (137.202.0.106) with Microsoft SMTP Server (TLS) id 14.3.181.6; Sun, 16 Nov
 2014 01:02:32 +0000
Date:   Sun, 16 Nov 2014 01:02:29 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: c-r4k.c: Fix the 74K D-cache alias erratum
 workaround
Message-ID: <alpine.DEB.1.10.1411160041230.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

Fix the 74K D-cache alias erratum workaround so that it actually works.  
Our current code sets MIPS_CACHE_VTAG for the D-cache, but that flag 
only has any effect for the I-cache.  Additionally MIPS_CACHE_PINDEX is 
set for the D-cache if CP0.Config7.AR is also set for an affected 
processor, leading to confusing information in the bootstrap log (the 
flag isn't used beyond that).

So delete the setting of MIPS_CACHE_VTAG and rely on MIPS_CACHE_ALIASES, 
set in a common place, removing I-cache coherency issues seen in GDB 
testing with software breakpoints, gdbserver and ptrace(2), on affected 
systems.

While at it add a little piece of explanation of what CP0.Config6.SYND 
is so that people do not have to chase documentation.

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Hi,

 It looks like I-cache aliasing handling setup needs some TLC too, first 
of all what's the purpose of checking CP0.Config7.IAR and setting the 
MIPS_CACHE_ALIASES flag for the I-cache where the flag is nowhere used 
afterwards?  Anyway that's something for another occasion.  For now, 
please apply this change.

  Maciej

linux-mips-vtag-dcache-fix.diff
Index: linux-3.18-rc4-malta/arch/mips/mm/c-r4k.c
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/mm/c-r4k.c	2014-11-16 00:08:15.511902298 +0000
+++ linux-3.18-rc4-malta/arch/mips/mm/c-r4k.c	2014-11-16 00:20:45.131908612 +0000
@@ -888,33 +888,39 @@ static inline void rm7k_erratum31(void)
 	}
 }
 
-static inline void alias_74k_erratum(struct cpuinfo_mips *c)
+static inline int alias_74k_erratum(struct cpuinfo_mips *c)
 {
 	unsigned int imp = c->processor_id & PRID_IMP_MASK;
 	unsigned int rev = c->processor_id & PRID_REV_MASK;
+	int present = 0;
 
 	/*
 	 * Early versions of the 74K do not update the cache tags on a
 	 * vtag miss/ptag hit which can occur in the case of KSEG0/KUSEG
-	 * aliases. In this case it is better to treat the cache as always
-	 * having aliases.
+	 * aliases.  In this case it is better to treat the cache as always
+	 * having aliases.  Also disable the synonym tag update feature
+	 * where available.  In this case no opportunistic tag update will
+	 * happen where a load causes a virtual address miss but a physical
+	 * address hit during a D-cache look-up.
 	 */
 	switch (imp) {
 	case PRID_IMP_74K:
 		if (rev <= PRID_REV_ENCODE_332(2, 4, 0))
-			c->dcache.flags |= MIPS_CACHE_VTAG;
+			present = 1;
 		if (rev == PRID_REV_ENCODE_332(2, 4, 0))
 			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
 		break;
 	case PRID_IMP_1074K:
 		if (rev <= PRID_REV_ENCODE_332(1, 1, 0)) {
-			c->dcache.flags |= MIPS_CACHE_VTAG;
+			present = 1;
 			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
 		}
 		break;
 	default:
 		BUG();
 	}
+
+	return present;
 }
 
 static char *way_string[] = { NULL, "direct mapped", "2-way",
@@ -926,6 +932,7 @@ static void probe_pcache(void)
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config = read_c0_config();
 	unsigned int prid = read_c0_prid();
+	int has_74k_erratum = 0;
 	unsigned long config1;
 	unsigned int lsize;
 
@@ -1232,7 +1239,7 @@ static void probe_pcache(void)
 
 	case CPU_74K:
 	case CPU_1074K:
-		alias_74k_erratum(c);
+		has_74k_erratum = alias_74k_erratum(c);
 		/* Fall through. */
 	case CPU_M14KC:
 	case CPU_M14KEC:
@@ -1246,7 +1253,7 @@ static void probe_pcache(void)
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
 		    (c->icache.waysize > PAGE_SIZE))
 			c->icache.flags |= MIPS_CACHE_ALIASES;
-		if (read_c0_config7() & MIPS_CONF7_AR) {
+		if (!has_74k_erratum && (read_c0_config7() & MIPS_CONF7_AR)) {
 			/*
 			 * Effectively physically indexed dcache,
 			 * thus no virtual aliases.
@@ -1255,7 +1262,7 @@ static void probe_pcache(void)
 			break;
 		}
 	default:
-		if (c->dcache.waysize > PAGE_SIZE)
+		if (has_74k_erratum || c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
 	}
 
