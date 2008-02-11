Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Feb 2008 22:40:58 +0000 (GMT)
Received: from mx02.hansenet.de ([213.191.73.26]:46007 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20030784AbYBKWks (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Feb 2008 22:40:48 +0000
Received: from [80.171.60.123] (80.171.60.123) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 47AC550E00878C83; Mon, 11 Feb 2008 23:40:42 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 000AF47C14;
	Mon, 11 Feb 2008 23:42:13 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Mon, 11 Feb 2008 23:42:12 +0100
Subject: [PATCH] [MIPS] Fix broken rm7000/rm9000 interrupt handling
X-Length: 1223
X-UID:	22
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802112342.13435.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Properly acknowledge RM7K and RM9K interrupts. Before this,
interrupts were permanently masked after their first occurrence,
making them non-functional.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

diff --git a/arch/mips/kernel/irq-rm7000.c b/arch/mips/kernel/irq-rm7000.c
index 971adf6..fb50cc7 100644
--- a/arch/mips/kernel/irq-rm7000.c
+++ b/arch/mips/kernel/irq-rm7000.c
@@ -33,6 +33,7 @@ static struct irq_chip rm7k_irq_controller = {
 	.mask = mask_rm7k_irq,
 	.mask_ack = mask_rm7k_irq,
 	.unmask = unmask_rm7k_irq,
+	.eoi	= unmask_rm7k_irq
 };
 
 void __init rm7k_cpu_irq_init(void)
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index 7b04583..ed9febe 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -75,6 +75,7 @@ static struct irq_chip rm9k_irq_controller = {
 	.mask = mask_rm9k_irq,
 	.mask_ack = mask_rm9k_irq,
 	.unmask = unmask_rm9k_irq,
+	.eoi	= unmask_rm9k_irq
 };
 
 static struct irq_chip rm9k_perfcounter_irq = {
-- 
1.5.3.6
