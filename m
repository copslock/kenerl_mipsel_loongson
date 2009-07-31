Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2009 23:30:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:29499 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493872AbZGaVat (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2009 23:30:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a7362780001>; Fri, 31 Jul 2009 17:30:32 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Jul 2009 14:30:13 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Jul 2009 14:30:13 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n6VLU8Xx018644;
	Fri, 31 Jul 2009 14:30:09 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n6VLU7s0018643;
	Fri, 31 Jul 2009 14:30:07 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Run IPI code with interrupts disabled.
Date:	Fri, 31 Jul 2009 14:30:07 -0700
Message-Id: <1249075807-18619-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 31 Jul 2009 21:30:13.0823 (UTC) FILETIME=[170C74F0:01CA1226]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In mm/slab.c the function do_ccupdate_local requires that interrupts
be disabled.  If they are not, we panic with CONFIG_DEBUG_SLAB.

So we disable interrupts while processing IPIs.  Also these are not
shared irqs, so get rid of the IRQF_SHARED flag.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 0b891a9..32d51a3 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -194,11 +194,11 @@ static void octeon_init_secondary(void)
 void octeon_prepare_cpus(unsigned int max_cpus)
 {
 	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffffffff);
-	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_SHARED,
+	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_DISABLED,
 			"mailbox0", mailbox_interrupt)) {
 		panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
 	}
-	if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt, IRQF_SHARED,
+	if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt, IRQF_DISABLED,
 			"mailbox1", mailbox_interrupt)) {
 		panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
 	}
-- 
1.6.0.6
