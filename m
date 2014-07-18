Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 09:28:16 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:47505 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861343AbaGRH1l5d6sL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 09:27:41 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.82)
        (envelope-from <jslaby@suse.cz>)
        id 1X82Zn-0003X0-BO; Fri, 18 Jul 2014 09:27:31 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: MSC: Prevent out-of-bounds writes to MIPS SC ioremap'd region
Date:   Fri, 18 Jul 2014 09:25:01 +0200
Message-Id: <1405668451-13298-20-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405668451-13298-1-git-send-email-jslaby@suse.cz>
References: <1405668451-13298-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/irq-msc01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
index fab40f7d2e03..ac9facc08694 100644
--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -131,7 +131,7 @@ void __init init_msc_irqs(unsigned long icubase, unsigned int irqbase, msc_irqma
 
 	board_bind_eic_interrupt = &msc_bind_eic_interrupt;
 
-	for (; nirq >= 0; nirq--, imp++) {
+	for (; nirq > 0; nirq--, imp++) {
 		int n = imp->im_irq;
 
 		switch (imp->im_type) {
-- 
2.0.0
