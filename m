Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3LLf9c17396
	for linux-mips-outgoing; Sat, 21 Apr 2001 14:41:09 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3LLf7M17393
	for <linux-mips@oss.sgi.com>; Sat, 21 Apr 2001 14:41:08 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14r57p-0002to-00; Sat, 21 Apr 2001 23:41:05 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14r57p-0000IZ-00; Sat, 21 Apr 2001 23:41:05 +0200
Date: Sat, 21 Apr 2001 23:41:05 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: watchdog vs reboot
Message-ID: <20010421234105.A1106@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com,
	Ralf Baechle <ralf@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
When building the indy watchdog kernel module using 
"Disable watchdog shutdown on close" the watchdog 
does not get turned off at all, so we have to do this 
"immediately" after reboot. Attached patch does this.
 -- Guido

--pWyiEgJYm5f9v55/
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="turn_of_watchdog.c"

--- arch/mips/sgi/kernel/indy_mc.c.orig	Sat Apr 21 22:24:59 2001
+++ arch/mips/sgi/kernel/indy_mc.c	Sat Apr 21 22:29:01 2001
@@ -84,6 +84,14 @@
 	 * interrupts are first enabled etc.
 	 */
 
+	/* Step 0: Make sure we turn of the watchdog in case it's
+	 *         still running(which might be the case after a
+	 *         soft reboot).
+	 */
+	tmpreg = mcmisc_regs->cpuctrl0; 
+	tmpreg &= ~SGIMC_CCTRL0_WDOG;
+	mcmisc_regs->cpuctrl0 = tmpreg;
+
 	/* Step 1: The CPU/GIO error status registers will not latch
 	 *         up a new error status until the register has been
 	 *         cleared by the cpu.  These status registers are

--pWyiEgJYm5f9v55/--
