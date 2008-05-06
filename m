Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2008 11:21:29 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:39392 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28591803AbYEFKVZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 May 2008 11:21:25 +0100
Received: from lagash (88-106-226-17.dynamic.dsl.as9105.com [88.106.226.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 848DE48916;
	Tue,  6 May 2008 12:21:23 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JtKIU-0002WH-5E; Tue, 06 May 2008 11:21:22 +0100
Date:	Tue, 6 May 2008 11:21:22 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: fix warning message on SMP kernels
Message-ID: <20080506102122.GE22413@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

This patch fixes a (harmless) warning message.


Signed-off-by: Thiemo Seufer <ths@networkno.de>

Index: linux.git/arch/mips/kernel/smp.c
===================================================================
--- linux.git.orig/arch/mips/kernel/smp.c	2008-05-06 11:06:07.000000000 +0100
+++ linux.git/arch/mips/kernel/smp.c	2008-05-06 11:15:02.000000000 +0100
@@ -87,8 +87,8 @@
 
 __cpuinit void register_smp_ops(struct plat_smp_ops *ops)
 {
-	if (ops)
-		printk(KERN_WARNING "Overriding previous set SMP ops\n");
+	if (mp_ops)
+		printk(KERN_WARNING "Overriding previously set SMP ops\n");
 
 	mp_ops = ops;
 }
