Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 16:25:03 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:55822
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225261AbUKUQY7>; Sun, 21 Nov 2004 16:24:59 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CVuWI-0002OO-00; Sun, 21 Nov 2004 17:24:58 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CVuWI-0006nE-00; Sun, 21 Nov 2004 17:24:58 +0100
Date: Sun, 21 Nov 2004 17:24:58 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Add comment about oversized r4000 interrupt vector
Message-ID: <20041121162458.GP20986@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

to prevent it to get lost again, this adds an explanatory comment
to the r4000 exception vector init.


Thiemo


Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.201
diff -u -p -r1.201 traps.c
--- arch/mips/kernel/traps.c	11 Nov 2004 03:06:01 -0000	1.201
+++ arch/mips/kernel/traps.c	20 Nov 2004 16:46:40 -0000
@@ -1026,6 +1027,7 @@ void __init trap_init(void)
 		set_except_vector(24, handle_mcheck);
 
 	if (cpu_has_vce)
+		/* Special exception: R4[04]00 uses also the divec space. */
 		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_r4000, 0x100);
 	else if (cpu_has_4kex)
 		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_generic, 0x80);
