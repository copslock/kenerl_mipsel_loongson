Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2005 15:31:48 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:44742 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133454AbVLPPb3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Dec 2005 15:31:29 +0000
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1EnHYx-00065z-00; Fri, 16 Dec 2005 16:32:03 +0100
Date:	Fri, 16 Dec 2005 16:32:03 +0100
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org, u-boot-users@lists.sourceforge.net
Subject: Freezing & Unfreezing the au11000
Message-ID: <20051216153203.GK14341@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
\From:	Rodolfo Giometti <giometti@linux.it>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

I'm just trying to support the save_and_sleep() support into u-boot
for an au1100 based board.

Into u-boot I added the following code:

Index: cpu/mips/start.S
===================================================================
RCS file: /home/develop/cvs_private/uboot-mips-exadron/cpu/mips/start.S,v
retrieving revision 1.2
diff -u -r1.2 start.S
--- cpu/mips/start.S	12 Oct 2005 12:55:54 -0000	1.2
+++ cpu/mips/start.S	16 Dec 2005 15:29:22 -0000
@@ -26,6 +26,7 @@
 #include <config.h>
 #include <version.h>
 #include <asm/regdef.h>
+#include <asm/au1x00.h>
 #include <asm/mipsregs.h>
 
 
@@ -273,6 +274,33 @@
 	li	t0, CONF_CM_CACHABLE_NONCOHERENT
 	mtc0	t0, CP0_CONFIG
 
+	/* Now check the wakeup cause
+	 */
+	li      t0, SYS_WAKESRC
+	lw      t1, 0(t0)
+	andi    t1, t1, 0x00000002	/* check the SW bit */
+	beq     zero, t1, 1f
+	nop
+
+	li	t0, SYS_SCRATCH0
+	lw      t1, 0(t0)
+	move	sp, t1
+	li	t0, SYS_SCRATCH1
+	lw      t1, 0(t0)
+	j	t1 			/* this cause a jump into already
+	nop				   frozen Linux (brr! :) */	
+
+	/* If we reach this point we come from a normal system power up,
+           so just clear the wakeup cause registers
+	 */
+
+1:	li      t0, SYS_WAKEMSK
+	li      t1, 0x00000000
+	sw      t1, 0(t0)
+
+	li      t0, SYS_WAKESRC
+	li      t1, 0x00000000
+	sw      t1, 0(t0)
 
 	/* Set up temporary stack.
 	 */

in order to restore the scratch registers contents as descibed into
file "linux/arch/mips/au1000/common/sleeper.S":

        /* Now set up the scratch registers so the boot rom will
         * return to this point upon wakeup.
         */     
        la      k0, 1f
        lui     k1, 0xb190
        ori     k1, 0x18
        sw      sp, 0(k1)
        ori     k1, 0x1c
        sw      k0, 0(k1)

However it seems something is wrong since the system at the end of
save_and_sleep() does not correctly continue its execution...

Unlikely my JTAG do not allow me to follow the code after the
save_and_sleep()'s return (I definitely have to buy a better one),
however I noticed that when the system tryes to resume the register 29
(the sp) doing:

        lw      $29, PT_R29(sp)

something goes wrong!

Suggestions? :)

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
