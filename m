Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 13:53:56 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:48846 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8224847AbSLDMxz>;
	Wed, 4 Dec 2002 13:53:55 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB4CrUNf022761;
	Wed, 4 Dec 2002 04:53:30 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA14038;
	Wed, 4 Dec 2002 04:53:28 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB4CrTb13738;
	Wed, 4 Dec 2002 13:53:29 +0100 (MET)
Message-ID: <3DEDFAC8.F295F7B2@mips.com>
Date: Wed, 04 Dec 2002 13:53:29 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: MIPS16 patch in unaligned.c
Content-Type: multipart/mixed;
 boundary="------------73DC21F3D4A65EF8B07A6456"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------73DC21F3D4A65EF8B07A6456
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The attached patch make sure we don't try to emulate load and stores,
when running in MIPS16 mode on CPUs, which support MIPS16.
Without this patch the kernel crashes, if running something nasty like
crashme on a CPU, which support MIPS16.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------73DC21F3D4A65EF8B07A6456
Content-Type: text/plain; charset=iso-8859-15;
 name="mips16.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips16.patch"

Index: arch/mips/kernel/unaligned.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/unaligned.c,v
retrieving revision 1.15.2.7
diff -u -r1.15.2.7 unaligned.c
--- arch/mips/kernel/unaligned.c	7 Nov 2002 23:50:11 -0000	1.15.2.7
+++ arch/mips/kernel/unaligned.c	4 Dec 2002 12:37:38 -0000
@@ -494,10 +494,10 @@
 
 	/*
 	 * Did we catch a fault trying to load an instruction?
-	 * This also catches attempts to activate MIPS16 code on
-	 * CPUs which don't support it.
+	 * Or are we running in MIPS16 mode?
 	 */
-	if (regs->cp0_badvaddr == regs->cp0_epc)
+	if ((regs->cp0_badvaddr == regs->cp0_epc) ||
+	    (regs->cp0_epc & 0x1))
 		goto sigbus;
 
 	pc = regs->cp0_epc + ((regs->cp0_cause & CAUSEF_BD) ? 4 : 0);
Index: arch/mips64/kernel/unaligned.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/unaligned.c,v
retrieving revision 1.6.2.6
diff -u -r1.6.2.6 unaligned.c
--- arch/mips64/kernel/unaligned.c	7 Nov 2002 23:50:11 -0000	1.6.2.6
+++ arch/mips64/kernel/unaligned.c	4 Dec 2002 12:37:40 -0000
@@ -494,10 +494,10 @@
 
 	/*
 	 * Did we catch a fault trying to load an instruction?
-	 * This also catches attempts to activate MIPS16 code on
-	 * CPUs which don't support it.
+	 * Or are we running in MIPS16 mode?
 	 */
-	if (regs->cp0_badvaddr == regs->cp0_epc)
+	if ((regs->cp0_badvaddr == regs->cp0_epc) ||
+	    (regs->cp0_epc & 0x1))
 		goto sigbus;
 
 	pc = regs->cp0_epc + ((regs->cp0_cause & CAUSEF_BD) ? 4 : 0);

--------------73DC21F3D4A65EF8B07A6456--
