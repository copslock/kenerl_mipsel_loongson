Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Mar 2005 19:45:02 +0000 (GMT)
Received: from port535.ds1-van.adsl.cybercity.dk ([IPv6:::ffff:217.157.140.228]:62319
	"EHLO valis.murphy.dk") by linux-mips.org with ESMTP
	id <S8224919AbVCTTor>; Sun, 20 Mar 2005 19:44:47 +0000
Received: from brian.localnet (root@[10.0.0.2])
	by valis.murphy.dk (8.13.2/8.13.2/Debian-1) with ESMTP id j2KJibRW031585;
	Sun, 20 Mar 2005 20:44:37 +0100
Received: from brian.localnet (brm@localhost [127.0.0.1])
	by brian.localnet (8.12.11/8.12.11/Debian-5) with ESMTP id j2KJibug021626;
	Sun, 20 Mar 2005 20:44:37 +0100
Received: (from brm@localhost)
	by brian.localnet (8.12.11/8.12.11/Debian-5) id j2KJiaPc021625;
	Sun, 20 Mar 2005 20:44:36 +0100
Date:	Sun, 20 Mar 2005 20:44:36 +0100
From:	Brian Murphy <brm@murphy.dk>
Message-Id: <200503201944.j2KJiaPc021625@brian.localnet>
To:	ralf@linux-mips.org
Subject: [PATCH] R43XX tlb write entry missing
Cc:	linux-mips@linux-mips.org
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	the R43XX is missing an entry in the tlbw synthesizer.
Here is a patch.

/Brian

Index: arch/mips/mm/tlbex.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/tlbex.c,v
retrieving revision 1.17
diff -u -r1.17 tlbex.c
--- arch/mips/mm/tlbex.c	1 Mar 2005 06:33:17 -0000	1.17
+++ arch/mips/mm/tlbex.c	17 Mar 2005 23:14:44 -0000
@@ -830,6 +830,7 @@
 		i_nop(p);
 		break;
 
+	case CPU_R4300:
 	case CPU_R4600:
 	case CPU_R4700:
 	case CPU_R5000:
