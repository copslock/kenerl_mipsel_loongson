Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 00:20:45 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859936AbaGDWUZ1CuiE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2014 00:20:25 +0200
Received: from localhost (c-76-28-255-20.hsd1.wa.comcast.net [76.28.255.20])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BEC2928;
        Fri,  4 Jul 2014 22:20:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.14 15/59] MIPS: MSC: Prevent out-of-bounds writes to MIPS SC ioremapd region
Date:   Fri,  4 Jul 2014 15:19:04 -0700
Message-Id: <20140704221540.251629958@linuxfoundation.org>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <20140704221539.544876024@linuxfoundation.org>
References: <20140704221539.544876024@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/irq-msc01.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -131,7 +131,7 @@ void __init init_msc_irqs(unsigned long
 
 	board_bind_eic_interrupt = &msc_bind_eic_interrupt;
 
-	for (; nirq >= 0; nirq--, imp++) {
+	for (; nirq > 0; nirq--, imp++) {
 		int n = imp->im_irq;
 
 		switch (imp->im_type) {
