Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 13:03:17 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:30739 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20021565AbXFUMDP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2007 13:03:15 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1I1LKY-0001UB-00
	for <linux-mips@linux-mips.org>; Thu, 21 Jun 2007 13:00:06 +0100
Received: from hendon.mips.com ([192.168.192.184] helo=localhost.localdomain)
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1I1LKQ-0001Pd-02; Thu, 21 Jun 2007 12:59:58 +0100
From:	chris@mips.com
To:	linux-mips@linux-mips.org
Cc:	Chris Dearman <chris@mips.com>
Subject: [PATCH] Count timer interrupts correctly.
Date:	Thu, 21 Jun 2007 12:59:58 +0100
Message-Id: <11824271981950-git-send-email-chris@mips.com>
X-Mailer: git-send-email 1.4.3.GIT
In-Reply-To: <1182427198884-git-send-email-chris@mips.com>
References: <11824271984112-git-send-email-chris@mips.com> <1182427198884-git-send-email-chris@mips.com>
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: chris@mips.com
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---
 arch/mips/kernel/smtc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 2e01147..046b03b 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -822,7 +822,7 @@ void ipi_decode(struct smtc_ipi *pipi)
 	switch (type_copy) {
 	case SMTC_CLOCK_TICK:
 		irq_enter();
-		kstat_this_cpu.irqs[MIPS_CPU_IRQ_BASE + cp0_perfcount_irq]++;
+		kstat_this_cpu.irqs[MIPS_CPU_IRQ_BASE + cp0_compare_irq]++;
 		/* Invoke Clock "Interrupt" */
 		ipi_timer_latch[dest_copy] = 0;
 #ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
-- 
1.4.4.3
