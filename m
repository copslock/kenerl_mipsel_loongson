Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 21:48:23 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:31016
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225212AbTDMUsW>; Sun, 13 Apr 2003 21:48:22 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 194oOe-0006U4-00; Sun, 13 Apr 2003 22:48:16 +0200
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 2.4] trivial secondary cache probe fix for R5000/NEVADA - v2
Message-Id: <E194oOe-0006U4-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Sun, 13 Apr 2003 22:48:16 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
How's this then?

/Brian

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.37
diff -u -r1.3.2.37 c-r4k.c
--- arch/mips/mm/c-r4k.c	13 Apr 2003 00:10:30 -0000	1.3.2.37
+++ arch/mips/mm/c-r4k.c	13 Apr 2003 20:43:34 -0000
@@ -1000,6 +1000,14 @@
 		sc_present = probe_scache_kseg1(config);
 		break;
 
+	case CPU_R5000:
+	case CPU_NEVADA:
+		setup_noscache_funcs();
+#ifdef CONFIG_R5000_CPU_SCACHE
+		r5k_sc_init();
+#endif
+                return;
+
 	default:
 		sc_present = 0;
 	}
@@ -1014,17 +1022,7 @@
 	    !(current_cpu_data.scache.flags & MIPS_CACHE_NOT_PRESENT))
 		panic("Dunno how to handle MIPS32 / MIPS64 second level cache");
 
-	switch (current_cpu_data.cputype) {
-	case CPU_R5000:
-	case CPU_NEVADA:
-		setup_noscache_funcs();
-#ifdef CONFIG_R5000_CPU_SCACHE
-		r5k_sc_init();
-#endif
-		break;
-	default:
-		setup_scache_funcs();
-	}
+        setup_scache_funcs();
 }
 
 void __init ld_mmu_r4xx0(void)
