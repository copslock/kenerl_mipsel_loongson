Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jan 2003 14:09:19 +0000 (GMT)
Received: from natsmtp00.webmailer.de ([IPv6:::ffff:192.67.198.74]:49140 "EHLO
	post.webmailer.de") by linux-mips.org with ESMTP
	id <S8225192AbTAXOJS>; Fri, 24 Jan 2003 14:09:18 +0000
Received: from excalibur.cologne.de (pD9E40690.dip.t-dialin.net [217.228.6.144])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id PAA08581;
	Fri, 24 Jan 2003 15:08:51 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 18c4c8-0000BN-00; Fri, 24 Jan 2003 15:15:24 +0100
Date: Fri, 24 Jan 2003 15:15:24 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Cc: tom@maisl.net
Subject: [PATCH] Cobalt interrupthandler fix
Message-ID: <20030124141524.GA685@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org, tom@maisl.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

the Cobalt NASRaQ (as well as other RaQ models) has the problem of freezing
when there is activity on the serial port and on the ethernet at the same
time. Peter de Schrijver has tracked this down to a bug in the interrupt
handler. The handler currently does not check whether an interrupt is masked
and calls the handling routine for _every_ interrupt, not only for those
that are not masked out currently.

The following patch fixes this. Ralf, could you please apply the fix
to the CVS?

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cobalt-irqhandler.diff"

diff -Nur linux/arch/mips/cobalt/int-handler.S linux-cobalt/arch/mips/cobalt/int-handler.S
--- linux/arch/mips/cobalt/int-handler.S	Fri Sep 13 21:21:58 2002
+++ linux-cobalt/arch/mips/cobalt/int-handler.S	Tue Dec 31 22:26:18 2002
@@ -30,7 +30,9 @@
 		/*
 		 * Get pending Interrupts
 		 */
-		mfc0	s0,CP0_CAUSE	# get irq mask
+		mfc0	s0,CP0_CAUSE	# get raw irq status
+		mfc0	a0,CP0_STATUS	# get irq mask
+		and	s0,s0,a0	# compute masked irq status
 
 		andi	a0,s0,CAUSEF_IP2	/* Check for Galileo timer */
 		beq	a0,zero,1f

--SkvwRMAIpAhPCcCJ--
