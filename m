Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 17:30:43 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:22670 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225250AbTBTRam>; Thu, 20 Feb 2003 17:30:42 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA01128;
	Thu, 20 Feb 2003 18:31:03 +0100 (MET)
Date: Thu, 20 Feb 2003 18:31:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [patch] Cobalt IRQ handler CP0 interlock?
Message-ID: <Pine.GSO.3.96.1030220182355.25777G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Does Cobalt have a processor that implements its pipeline differently or
interlocks on CP0 loads?  If not, I'll apply the following fix. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-20030214-cobalt-int-0
diff -up --recursive --new-file linux-mips-2.4.20-20030214.macro/arch/mips/cobalt/int-handler.S linux-mips-2.4.20-20030214/arch/mips/cobalt/int-handler.S
--- linux-mips-2.4.20-20030214.macro/arch/mips/cobalt/int-handler.S	2003-01-28 03:56:27.000000000 +0000
+++ linux-mips-2.4.20-20030214/arch/mips/cobalt/int-handler.S	2003-02-15 10:28:15.000000000 +0000
@@ -31,6 +31,7 @@
 		 */
 		mfc0	s0,CP0_CAUSE	# get raw irq status
 		mfc0	a0,CP0_STATUS	# get irq mask
+		nop
 		and	s0,s0,a0	# compute masked irq status
 
 		andi	a0,s0,CAUSEF_IP2	/* Check for Galileo timer */
