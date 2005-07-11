Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 16:53:25 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:22995 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226472AbVGKPxH>;
	Mon, 11 Jul 2005 16:53:07 +0100
Received: MO(mo00)id j6BFs1hZ022853; Tue, 12 Jul 2005 00:54:01 +0900 (JST)
Received: MDO(mdo00) id j6BFs0V7023492; Tue, 12 Jul 2005 00:54:00 +0900 (JST)
Received: from stratos (h086.p498.iij4u.or.jp [210.149.242.86])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j6BFrxS4019061
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 12 Jul 2005 00:54:00 +0900 (JST)
Date:	Tue, 12 Jul 2005 00:53:57 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: add EXPORT_SYMBOL to irq.c
Message-Id: <20050712005357.32221bc7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added EXPORT_SYMBOL to irq.c.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/irq.c a/arch/mips/vr41xx/common/irq.c
--- a-orig/arch/mips/vr41xx/common/irq.c	2005-06-02 23:37:13.000000000 +0900
+++ a/arch/mips/vr41xx/common/irq.c	2005-07-12 00:49:23.597771624 +0900
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/interrupt.h>
+#include <linux/module.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/system.h>
@@ -56,6 +57,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL_GPL(cascade_irq);
+
 asmlinkage void irq_dispatch(unsigned int irq, struct pt_regs *regs)
 {
 	irq_cascade_t *cascade;
