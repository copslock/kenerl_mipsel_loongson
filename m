Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2011 22:32:18 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7805 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491905Ab1JCUcJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Oct 2011 22:32:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e8a1c120000>; Mon, 03 Oct 2011 13:33:22 -0700
Received: from casmarthost.caveonetworks.com ([192.168.16.225]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 3 Oct 2011 13:32:05 -0700
Received: from localhost (webpowersw-sdk106.caveonetworks.com [10.18.162.106])
        by casmarthost.caveonetworks.com (8.13.8/8.13.8) with ESMTP id p93KW3GB016316;
        Mon, 3 Oct 2011 13:32:05 -0700
From:   Venkat Subbiah <venkat.subbiah@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-rt-users@vger.kernel.org, david.daney@cavium.com
Subject: [PATCH] MIPS: Octeon: Mark SMP-IPI interrupt as IRQF_NO_THREAD
Date:   Mon,  3 Oct 2011 13:31:10 -0700
Message-Id: <1317673870-10671-1-git-send-email-venkat.subbiah@caviumnetworks.com>
X-Mailer: git-send-email 1.7.0.4
X-OriginalArrivalTime: 03 Oct 2011 20:32:05.0819 (UTC) FILETIME=[8406C8B0:01CC820B]
X-archive-position: 31204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: venkat.subbiah@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1519

From: Venkat Subbiah <venkat.subbiah@cavium.com>

This is to exclude it from force threading to allow RT patch set to work.
And while on this line
* Remove IRQF_DISABLED as as this flag is NOOP
* Add IRQF_PERCPU as this is a per cpu interrupt.


Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/smp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 8b60642..efcfff4 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -207,8 +207,9 @@ void octeon_prepare_cpus(unsigned int max_cpus)
 	 * the other bits alone.
 	 */
 	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffff);
-	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_DISABLED,
-			"SMP-IPI", mailbox_interrupt)) {
+	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
+			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-IPI",
+			mailbox_interrupt)) {
 		panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
 	}
 }
-- 
1.7.0.4
