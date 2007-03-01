Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2007 13:57:55 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:62738 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039435AbXCAN5r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Mar 2007 13:57:47 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E8727E1CD8;
	Thu,  1 Mar 2007 14:57:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-xayQFJScnP; Thu,  1 Mar 2007 14:57:05 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5EE5AE1CDE;
	Thu,  1 Mar 2007 14:57:05 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l21DvFZE011392;
	Thu, 1 Mar 2007 14:57:15 +0100
Date:	Thu, 1 Mar 2007 13:57:11 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2.6.21-rc2] dz: Remove struct pt_regs references
Message-ID: <Pine.LNX.4.64N.0703011326490.25556@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90/2689/Thu Mar  1 06:46:09 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Remove remaining references to saved registers now that 
uart_handle_sysrq_char() does not want them.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 The driver does not build without this update.

 Please apply.

  Maciej

patch-mips-2.6.21-rc1-20070222-dz-pt_regs-0
diff -up --recursive --new-file linux-mips-2.6.21-rc1-20070222.macro/drivers/serial/dz.c linux-mips-2.6.21-rc1-20070222/drivers/serial/dz.c
--- linux-mips-2.6.21-rc1-20070222.macro/drivers/serial/dz.c	2007-02-05 16:38:50.000000000 +0000
+++ linux-mips-2.6.21-rc1-20070222/drivers/serial/dz.c	2007-03-01 01:36:56.000000000 +0000
@@ -170,8 +170,7 @@ static void dz_enable_ms(struct uart_por
  * This routine deals with inputs from any lines.
  * ------------------------------------------------------------
  */
-static inline void dz_receive_chars(struct dz_port *dport_in,
-				    struct pt_regs *regs)
+static inline void dz_receive_chars(struct dz_port *dport_in)
 {
 	struct dz_port *dport;
 	struct tty_struct *tty = NULL;
@@ -226,7 +225,7 @@ static inline void dz_receive_chars(stru
 			break;
 		}
 
-		if (uart_handle_sysrq_char(&dport->port, ch, regs))
+		if (uart_handle_sysrq_char(&dport->port, ch))
 			continue;
 
 		if ((status & dport->port.ignore_status_mask) == 0) {
@@ -332,7 +331,7 @@ static irqreturn_t dz_interrupt(int irq,
 	status = dz_in(dport, DZ_CSR);
 
 	if ((status & (DZ_RDONE | DZ_RIE)) == (DZ_RDONE | DZ_RIE))
-		dz_receive_chars(dport, regs);
+		dz_receive_chars(dport);
 
 	if ((status & (DZ_TRDY | DZ_TIE)) == (DZ_TRDY | DZ_TIE))
 		dz_transmit_chars(dport);
patch-mips-2.6.21-rc1-20070222-dz-pt_regs-0
