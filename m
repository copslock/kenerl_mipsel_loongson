Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 00:24:35 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:58898 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837945AbaGVWY10Q7B0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 00:24:27 +0200
Received: from c-67-160-228-185.hsd1.ca.comcast.net ([67.160.228.185] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1X9iSC-0001hJ-E5; Tue, 22 Jul 2014 22:22:36 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1X9iSA-0005K1-H1; Tue, 22 Jul 2014 15:22:34 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.8 113/116] MIPS: MSC: Prevent out-of-bounds writes to MIPS SC ioremap'd region
Date:   Tue, 22 Jul 2014 15:22:04 -0700
Message-Id: <1406067727-19683-114-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406067727-19683-1-git-send-email-kamal@canonical.com>
References: <1406067727-19683-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.8
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

3.8.13.27 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit ab6c15bc6620ebe220970cc040b29bcb2757f373 upstream.

Previously, the lower limit for the MIPS SC initialization loop was
set incorrectly allowing one extra loop leading to writes
beyond the MSC ioremap'd space. More precisely, the value of the 'imp'
in the last loop increased beyond the msc_irqmap_t boundaries and
as a result of which, the 'n' variable was loaded with an incorrect
value. This value was used later on to calculate the offset in the
MSC01_IC_SUP which led to random crashes like the following one:

CPU 0 Unable to handle kernel paging request at virtual address e75c0200,
epc == 8058dba4, ra == 8058db90
[...]
Call Trace:
[<8058dba4>] init_msc_irqs+0x104/0x154
[<8058b5bc>] arch_init_irq+0xd8/0x154
[<805897b0>] start_kernel+0x220/0x36c

Kernel panic - not syncing: Attempted to kill the idle task!

This patch fixes the problem

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7118/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/irq-msc01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
index 14ac52c..884de34 100644
--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -131,7 +131,7 @@ void __init init_msc_irqs(unsigned long icubase, unsigned int irqbase, msc_irqma
 
 	board_bind_eic_interrupt = &msc_bind_eic_interrupt;
 
-	for (; nirq >= 0; nirq--, imp++) {
+	for (; nirq > 0; nirq--, imp++) {
 		int n = imp->im_irq;
 
 		switch (imp->im_type) {
-- 
1.9.1
