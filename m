Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 16:32:55 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:24556 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225307AbVHAPcg>;
	Mon, 1 Aug 2005 16:32:36 +0100
Received: MO(mo01)id j71FZeI3005271; Tue, 2 Aug 2005 00:35:40 +0900 (JST)
Received: MDO(mdo00) id j71FZdfc029425; Tue, 2 Aug 2005 00:35:40 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j71FZcOJ025783
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 2 Aug 2005 00:35:39 +0900 (JST)
Date:	Tue, 2 Aug 2005 00:35:38 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: fix spurious IRQ problem
Message-Id: <20050802003538.6b6e6abc.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed spurious IRQ problem about vr41xx.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/irq.c a/arch/mips/vr41xx/common/irq.c
--- a-orig/arch/mips/vr41xx/common/irq.c	2005-07-12 01:04:42.000000000 +0900
+++ a/arch/mips/vr41xx/common/irq.c	2005-07-31 21:07:17.000000000 +0900
@@ -62,6 +62,7 @@
 asmlinkage void irq_dispatch(unsigned int irq, struct pt_regs *regs)
 {
 	irq_cascade_t *cascade;
+	irq_desc_t *desc;
 
 	if (irq >= NR_IRQS) {
 		atomic_inc(&irq_err_count);
@@ -70,11 +71,15 @@
 
 	cascade = irq_cascade + irq;
 	if (cascade->get_irq != NULL) {
+		unsigned int source_irq = irq;
+		desc = irq_desc + source_irq;
+		desc->handler->ack(source_irq);
 		irq = cascade->get_irq(irq, regs);
 		if (irq < 0)
 			atomic_inc(&irq_err_count);
 		else
 			irq_dispatch(irq, regs);
+		desc->handler->end(source_irq);
 	} else
 		do_IRQ(irq, regs);
 }
