Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 19:41:56 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:2856
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225212AbTDMSlz>; Sun, 13 Apr 2003 19:41:55 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 194mQF-0004aB-00; Sun, 13 Apr 2003 20:41:47 +0200
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 2.4] trivial secondary cache probe fix for R5000/NEVADA
Message-Id: <E194mQF-0004aB-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Sun, 13 Apr 2003 20:41:47 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
despite the comment there are at least two more processors this 
probe is needed/works for.

Please apply.

/Brian

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.37
diff -u -r1.3.2.37 c-r4k.c
--- arch/mips/mm/c-r4k.c	13 Apr 2003 00:10:30 -0000	1.3.2.37
+++ arch/mips/mm/c-r4k.c	13 Apr 2003 18:32:21 -0000
@@ -996,6 +996,8 @@
 	case CPU_R4400PC:
 	case CPU_R4400SC:
 	case CPU_R4400MC:
+	case CPU_R5000:
+	case CPU_NEVADA:
 		probe_scache_kseg1 = (probe_func_t) (KSEG1ADDR(&probe_scache));
 		sc_present = probe_scache_kseg1(config);
 		break;
