Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2MGlbf25426
	for linux-mips-outgoing; Fri, 22 Mar 2002 08:47:37 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2MGlLq25408;
	Fri, 22 Mar 2002 08:47:22 -0800
Received: from dev1 (unknown [10.1.1.85])
	by ns1.ltc.com (Postfix) with ESMTP
	id 09A13590B2; Fri, 22 Mar 2002 11:44:17 -0500 (EST)
Received: from brad by dev1 with local (Exim 3.34 #1 (Debian))
	id 16oSDZ-0004x8-00; Fri, 22 Mar 2002 11:48:41 -0500
Date: Fri, 22 Mar 2002 11:48:37 -0500
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: [PATCH] Clear BEV in init_traps
Message-ID: <20020322114837.A19038@dev1.ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: "Bradley D. LaRonde" <brad@ltc.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This used to happen in head.S, then got moved to per_cpu_trap_init, but
that only covers secondary cpus.  This takes care of the boot cpu.

Regards,
Brad

diff -urNbB -X ../diff-linux-exclude ../oss/linux-oss-2.4-2002-03-19/arch/mips/kernel/traps.c linux-encore-oss-merge/arch/mips/kernel/traps.c
--- ../oss/linux-oss-2.4-2002-03-19/arch/mips/kernel/traps.c	Tue Mar 19 20:18:36 2002
+++ linux-encore-oss-merge/arch/mips/kernel/traps.c	Fri Mar 22 09:58:36 2002
@@ -852,6 +852,9 @@
 	extern char except_vec_ejtag_debug;
 	unsigned long i;
 
+	/* Some firmware leaves the BEV flag set, clear it.  */
+	clear_cp0_status(ST0_BEV);
+
 	/* Copy the generic exception handler code to it's final destination. */
 	memcpy((void *)(KSEG0 + 0x80), &except_vec1_generic, 0x80);
 	memcpy((void *)(KSEG0 + 0x100), &except_vec2_generic, 0x80);
