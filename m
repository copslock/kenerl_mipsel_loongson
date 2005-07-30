Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jul 2005 07:47:39 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:37444
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8224836AbVG3GrX>; Sat, 30 Jul 2005 07:47:23 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j6U6oCS5015425;
	Sat, 30 Jul 2005 15:50:13 +0900
Date:	Sat, 30 Jul 2005 15:53:10 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: [PATCH 1/1] TX4938: Bugfix for PCI 66MHz of Toshiba
 RBHMA4500(TX4938)
Message-Id: <20050730155310.76cf960d.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch is against latest cvs.
Could you review it?

	Hiroshi DOYU

----
Bugfix for handling PCI 66MHz correctly

Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>

 setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: mipslinux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
===================================================================
--- mipslinux.orig/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ mipslinux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -411,7 +411,8 @@
 	tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI66;
 	/* Double PCICLK (if possible) */
 	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
-		unsigned int pcidivmode = 0;
+		unsigned int pcidivmode =
+			tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK;
 		switch (pcidivmode) {
 		case TX4938_CCFG_PCIDIVMODE_8:
 		case TX4938_CCFG_PCIDIVMODE_4:
