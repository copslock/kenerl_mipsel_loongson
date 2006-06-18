Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2006 05:24:55 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:29835 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S3466132AbWFREYq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Jun 2006 05:24:46 +0100
Received: from lagash (88-106-172-197.dynamic.dsl.as9105.com [88.106.172.197])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 01122450B4; Sun, 18 Jun 2006 06:23:55 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Frop9-00028f-LG; Sun, 18 Jun 2006 05:23:47 +0100
Date:	Sun, 18 Jun 2006 05:23:47 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Random fixes for sb1250
Message-ID: <20060618042347.GC4480@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

some random improvements for sb1250: Silence compiler warnings, a
bugfix for the profiling code, and a comment typo.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index 0f6e54d..f853c32 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -435,13 +435,17 @@ static inline int dclz(unsigned long lon
 	return lz;
 }
 
+extern void sb1250_timer_interrupt(struct pt_regs *regs);
+extern void sb1250_mailbox_interrupt(struct pt_regs *regs);
+extern void sb1250_kgdb_interrupt(struct pt_regs *regs);
+
 asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
 {
 	unsigned int pending;
 
 #ifdef CONFIG_SIBYTE_SB1250_PROF
 	/* Set compare to count to silence count/compare timer interrupts */
-	write_c0_count(read_c0_count());
+	write_c0_compare(read_c0_count());
 #endif
 
 	/*
@@ -482,7 +486,7 @@ #endif
 		 * Default...we've hit an IP[2] interrupt, which means we've
 		 * got to check the 1250 interrupt registers to figure out what
 		 * to do.  Need to detect which CPU we're on, now that
-		 ~ smp_affinity is supported.
+		 * smp_affinity is supported.
 		 */
 		mask = __raw_readq(IOADDR(A_IMR_REGISTER(smp_processor_id(),
 		                              R_IMR_INTERRUPT_STATUS_BASE)));
