Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 15:36:34 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:49645 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225243AbVAJPg3>;
	Mon, 10 Jan 2005 15:36:29 +0000
Received: MO(mo01)id j0AFaROe003718; Tue, 11 Jan 2005 00:36:27 +0900 (JST)
Received: MDO(mdo01) id j0AFaQq3028761; Tue, 11 Jan 2005 00:36:26 +0900 (JST)
Received: 4UMRO01 id j0AFaP13028369; Tue, 11 Jan 2005 00:36:26 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Tue, 11 Jan 2005 00:36:24 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: fixed build error
Message-Id: <20050111003624.0bb64944.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch is fixed the following build error.

  CC      arch/mips/pci/fixup-mpc30x.o
arch/mips/pci/fixup-mpc30x.c:32: error: irq_tab_mpc30x causes a section type conflict
make[1]: *** [arch/mips/pci/fixup-mpc30x.o] Error 1
make: *** [arch/mips/pci] Error 2

Please apply this patch to 2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-mpc30x.c a/arch/mips/pci/fixup-mpc30x.c
--- a-orig/arch/mips/pci/fixup-mpc30x.c	Fri Nov  5 00:42:26 2004
+++ a/arch/mips/pci/fixup-mpc30x.c	Mon Jan 10 23:54:09 2005
@@ -29,7 +29,7 @@
 	VRC4173_USB_IRQ,
 };
 
-static char irq_tab_mpc30x[] __initdata = {
+static const int irq_tab_mpc30x[] __initdata = {
  [12] = VRC4173_PCMCIA1_IRQ,
  [13] = VRC4173_PCMCIA2_IRQ,
  [29] = MQ200_IRQ,
