Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:37:15 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:50404 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225317AbSLRBgy>;
	Wed, 18 Dec 2002 01:36:54 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 7C0A1D68F; Wed, 18 Dec 2002 02:42:50 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: config1 is only used by MIPS32 and MIPS64
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:42:50 +0100
Message-ID: <m2n0n4qezp.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        subject told everything

Later, Juan.

Index: arch/mips/mm/tlb-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlb-r4k.c,v
retrieving revision 1.6.2.9
diff -u -r1.6.2.9 tlb-r4k.c
--- arch/mips/mm/tlb-r4k.c	4 Dec 2002 23:50:23 -0000	1.6.2.9
+++ arch/mips/mm/tlb-r4k.c	18 Dec 2002 00:49:19 -0000
@@ -334,8 +334,10 @@
 
 static void __init probe_tlb(unsigned long config)
 {
-	unsigned int prid, config1;
-
+	unsigned int prid;
+#if defined(CONFIG_CPU_MIPS32) || defined (CONFIG_CPU_MIPS64)
+	unsigned int config1;
+#endif
 	prid = read_c0_prid() & 0xff00;
 	if (prid == PRID_IMP_RM7000 || !(config & (1 << 31)))
 		/*


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
