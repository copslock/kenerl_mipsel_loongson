Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2004 14:15:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:15074 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225215AbUAHOPm>; Thu, 8 Jan 2004 14:15:42 +0000
Received: from localhost (p4063-ipad32funabasi.chiba.ocn.ne.jp [221.189.136.63])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C82AB577C; Thu,  8 Jan 2004 23:15:38 +0900 (JST)
Date: Thu, 08 Jan 2004 23:20:00 +0900 (JST)
Message-Id: <20040108.232000.59460880.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: show_regs fix in 2.4
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Cut'n paste error in 2.4 arch/mips/kernel/traps.c.  Please apply.

Index: traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.62
diff -u -r1.99.2.62 traps.c
--- traps.c	15 Dec 2003 20:13:36 -0000	1.99.2.62
+++ traps.c	8 Jan 2004 14:07:41 -0000
@@ -237,7 +237,7 @@
 	 */
 	printk("epc   : %08lx    %s\n", regs->cp0_epc, print_tainted());
 	printk("Status: %08lx\n", regs->cp0_status);
-	printk("epc   : %08lx\n", regs->cp0_cause);
+	printk("Cause : %08lx\n", regs->cp0_cause);
 	printk("PrId  : %08x\n", read_c0_prid());
 }
 
---
Atsushi Nemoto
