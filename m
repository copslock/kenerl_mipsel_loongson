Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Feb 2004 22:51:15 +0000 (GMT)
Received: from sc-f100-01.extremenetworks.com ([IPv6:::ffff:63.251.106.30]:5898
	"EHLO extrgate1.extremenetworks.com") by linux-mips.org with ESMTP
	id <S8225265AbUBKWvO>; Wed, 11 Feb 2004 22:51:14 +0000
Received: by extrgate1.extremenetworks.com with Internet Mail Service (5.5.2656.59)
	id <1V6VMAQ8>; Wed, 11 Feb 2004 14:50:42 -0800
Message-ID: <3DC3910A44FBD94B8513C8E2A3F220E1560A0B@sc-msexch-16.extremenetworks.com>
From: Lance Richardson <lrichardson@extremenetworks.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: SB1250 Pass1 Cache Workaround
Date: Wed, 11 Feb 2004 14:50:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <lrichardson@extremenetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrichardson@extremenetworks.com
Precedence: bulk
X-list: linux-mips

A recent change to arch/mips/mm/cex-sb1.S dropped the workaround 
for the SB1250 pass 1 spurious cache exception problem (yes, some
of us still have SWARMs with pass 1 parts...)

Here's a patch to restore the workaround, tested/verified on a 
SWARM with pass1 SB1250. It also removes the #include <asm/processor.h> 
which (as pointed out recently) causes grief for the assembler.

  - Lance

===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/cex-sb1.S,v
retrieving revision 1.13
diff -u -r1.13 cex-sb1.S
--- cex-sb1.S	14 Jan 2004 18:46:21 -0000	1.13
+++ cex-sb1.S	10 Feb 2004 17:30:08 -0000
@@ -23,7 +23,6 @@
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
 #include <asm/cacheops.h>
-#include <asm/processor.h>
 #include <asm/sibyte/board.h>
 
 #define C0_ERRCTL     $26             /* CP0: Error info */
@@ -83,6 +82,19 @@
 	 mtc0	$0,C0_CERR_D
 
 attempt_recovery:
+#ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
+	# look for signature of spurious CErr
+	lui	k0, 0x4000
+	bne	k0, k1, 1f
+	 mfc0	k1, C0_CERR_I, 1
+	lui	k0, 0xffe0
+	and	k1, k0, k1
+	lui	k0, 0x0200
+	beq	k0, k1, recovered 
+	 mtc0	$0,C0_CERR_D
+1:
+#endif
+
 	/*
 	 * k0 has C0_ERRCTL << 1, which puts 'DC' at bit 31.  Any
 	 * Dcache errors we can recover from will take more extensive
