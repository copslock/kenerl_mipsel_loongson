Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQFcRB08077
	for linux-mips-outgoing; Mon, 26 Nov 2001 07:38:27 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQFbpo08052
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 07:37:58 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA00100;
	Mon, 26 Nov 2001 15:35:18 +0100 (MET)
Date: Mon, 26 Nov 2001 15:35:17 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: A critical DECstation interrupt handler fix
Message-ID: <Pine.GSO.3.96.1011126151119.21598L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 The DECstation's interrupt handler can crash under certain circumstances. 
Due to a missing masking of the CP0 Cause register, if a spurious
interrupt is delivered (its deasserted before reading the register), the
handler may jump to an arbitrary memory location as determined by data
fetched from an incorrect location.  Due to this problem my new /260
system used to crash frequently, because Cause.CE is often set to 3 (CE is
unspecified for all but coprocessor unusable exceptions). 

 The following patch masks Cause appropriately.  A small reorganization of
code was also possible due to changes in the scheduling of delay slots. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.14-20011123-dec-cause-0
diff -up --recursive --new-file linux-mips-2.4.14-20011123.macro/arch/mips/dec/int-handler.S linux-mips-2.4.14-20011123/arch/mips/dec/int-handler.S
--- linux-mips-2.4.14-20011123.macro/arch/mips/dec/int-handler.S	Tue Jul  3 04:27:16 2001
+++ linux-mips-2.4.14-20011123/arch/mips/dec/int-handler.S	Sun Nov 25 00:40:11 2001
@@ -140,7 +140,7 @@
 		 */
 		mfc0	t0,CP0_CAUSE		# get pending interrupts
 		mfc0	t2,CP0_STATUS
-		la	t1,cpu_mask_tbl
+		andi	t0,ST0_IM		# CAUSE.CE may be non-zero!
 		and	t0,t2			# isolate allowed ones
 
 		beqz	t0,spurious
@@ -148,7 +148,8 @@
 		/*
 		 * Find irq with highest priority
 		 */
-1:		 lw	t2,(t1)
+		 la	t1,cpu_mask_tbl
+1:		lw	t2,(t1)
 		move	t3,t0
 		and	t3,t2
 		beq	t3,zero,1b
