Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 12:24:39 +0000 (GMT)
Received: from mail.baslerweb.com ([IPv6:::ffff:145.253.187.130]:51534 "EHLO
	mail.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225326AbUKIMYc>; Tue, 9 Nov 2004 12:24:32 +0000
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id iA9CNJAE001081
	for <linux-mips@linux-mips.org>; Tue, 9 Nov 2004 13:23:19 +0100
Received: from unknown by gateway id /var/KryptoWall/smtpp/kwk4WLSI; Tue Nov 09 13:23:10 2004
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id WHM64HZP; Tue, 9 Nov 2004 13:24:22 +0100
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: [PATCH] Function / prototype mismatch
Date: Tue, 9 Nov 2004 13:28:42 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Message-Id: <200411091328.42360.thomas.koeller@baslerweb.com>
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

The definition of do_IRQ() in arch/mips/kernel/irq.c
does not match the prototype in include/asm-mips/irq.h,
resulting in a compile error.

tk

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>


--- linux-mips-cvs/arch/mips/kernel/irq.c	2004-11-09 11:43:46.921669824 +0100
+++ linux-mips-basler/arch/mips/kernel/irq.c	2004-11-09 13:18:46.496202792 +0100
@@ -45,7 +45,7 @@
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(unsigned int irq, struct pt_regs *regs)
+asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs)
 {
 	irq_enter();
 

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
