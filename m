Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Feb 2003 21:49:56 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:20299
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224939AbTBBVtz>; Sun, 2 Feb 2003 21:49:55 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18fRzs-000rsy-00; Sun, 02 Feb 2003 22:49:52 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18fRzs-0007Kb-00; Sun, 02 Feb 2003 22:49:52 +0100
Date: Sun, 2 Feb 2003 22:49:52 +0100
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix r3k exception handler location
Message-ID: <20030202214952.GL30469@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

this patch is untested, but I just can't see how a r3k can boot without it.


Thiemo


diff -BurpN linux-orig/arch/mips/kernel/traps.c linux-2.4.20/arch/mips/kernel/traps.c
--- linux-orig/arch/mips/kernel/traps.c	Fri Dec 20 04:19:49 2002
+++ linux-2.4.20/arch/mips/kernel/traps.c	Sun Feb  2 21:57:19 2003
@@ -1000,7 +1000,7 @@ void __init trap_init(void)
 	else if (mips_cpu.options & MIPS_CPU_4KEX)
 		memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
 	else
-		memcpy((void *)(KSEG0 + 0x080), &except_vec3_generic, 0x80);
+		memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
 
 	if (mips_cpu.cputype == CPU_R6000 || mips_cpu.cputype == CPU_R6000A) {
 		/*
diff -BurpN linux-orig/arch/mips64/kernel/traps.c linux-2.4.20/arch/mips64/kernel/traps.c
--- linux-orig/arch/mips64/kernel/traps.c	Fri Dec 20 04:19:51 2002
+++ linux-2.4.20/arch/mips64/kernel/traps.c	Sun Feb  2 21:57:20 2003
@@ -755,7 +755,7 @@ void __init trap_init(void)
 	} else if (mips_cpu.options & MIPS_CPU_4KEX)
 		memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
 	else
-		memcpy((void *)(KSEG0 + 0x080), &except_vec3_generic, 0x80);
+		memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
 
 	if (mips_cpu.cputype == CPU_R6000 || mips_cpu.cputype == CPU_R6000A) {
 		/*
