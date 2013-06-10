Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:47:26 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1196 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835048Ab3FJHkUwmKxF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:20 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:34:29 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:40:10 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:40:09 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 9F9BFF2D8E; Mon, 10
 Jun 2013 00:40:05 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 11/11] MIPS: Netlogic: Fix plat_irq_dispatch
Date:   Mon, 10 Jun 2013 13:11:10 +0530
Message-ID: <1370850070-5127-12-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5E0F1R029041287-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Fix an issue in plat_irq_dispatch due to which it can call do_IRQ
with a PIC irq that is not mapped.

When a per-cpu interrupt and a PIC interrupt are both active, the
check 'eirr & PERCPU_IRQ_MASK' will be true, but the interrupt in 'i'
will be the number of the PIC interrupt. In this case, we will call
do_IRQ on the PIC interrupt without mapping it with nlm_irq_to_xirq().

Fix this by using __ffs64 instead of __ilog2_u64 and using the
interrupt number instead of mask to identify per-cpu interrupts.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/irq.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 9f84c60..73facb2 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -253,13 +253,12 @@ asmlinkage void plat_irq_dispatch(void)
 
 	node = nlm_nodeid();
 	eirr = read_c0_eirr_and_eimr();
-
-	i = __ilog2_u64(eirr);
-	if (i == -1)
+	if (eirr == 0)
 		return;
 
+	i = __ffs64(eirr);
 	/* per-CPU IRQs don't need translation */
-	if (eirr & PERCPU_IRQ_MASK) {
+	if (i < PIC_IRQ_BASE) {
 		do_IRQ(i);
 		return;
 	}
-- 
1.7.9.5
