Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 23:48:08 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10596 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491126Ab1BQWsF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 23:48:05 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5da5d20000>; Thu, 17 Feb 2011 14:48:50 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 14:47:58 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 14:47:58 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1HMlt6H005166;
        Thu, 17 Feb 2011 14:47:55 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1HMls5A005165;
        Thu, 17 Feb 2011 14:47:54 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Don't request interrupts for unused IPI mailbox bits.
Date:   Thu, 17 Feb 2011 14:47:52 -0800
Message-Id: <1297982872-5124-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 17 Feb 2011 22:47:58.0367 (UTC) FILETIME=[B923E2F0:01CBCEF4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

We only use the three low-order mailbox bits.  Leave the upper bits
alone for possible use by drivers and other software.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/smp.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index ba78b21..716fae6 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -37,7 +37,7 @@ static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 	uint64_t action;
 
 	/* Load the mailbox register to figure out what we're supposed to do */
-	action = cvmx_read_csr(CVMX_CIU_MBOX_CLRX(coreid));
+	action = cvmx_read_csr(CVMX_CIU_MBOX_CLRX(coreid)) & 0xffff;
 
 	/* Clear the mailbox to clear the interrupt */
 	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), action);
@@ -200,16 +200,15 @@ void octeon_prepare_cpus(unsigned int max_cpus)
 	if (labi->labi_signature != LABI_SIGNATURE)
 		panic("The bootloader version on this board is incorrect.");
 #endif
-
-	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffffffff);
+	/*
+	 * Only the low order mailbox bits are used for IPIs, leave
+	 * the other bits alone.
+	 */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffff);
 	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_DISABLED,
-			"mailbox0", mailbox_interrupt)) {
+			"SMP-IPI", mailbox_interrupt)) {
 		panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
 	}
-	if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt, IRQF_DISABLED,
-			"mailbox1", mailbox_interrupt)) {
-		panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
-	}
 }
 
 /**
-- 
1.7.2.3
