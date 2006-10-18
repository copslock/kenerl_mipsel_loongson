Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 15:27:41 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:15378 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038511AbWJRO1f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2006 15:27:35 +0100
Received: by mo.po.2iij.net (mo32) id k9IERVq1034962; Wed, 18 Oct 2006 23:27:31 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox32) id k9IERTUC041351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Oct 2006 23:27:30 +0900 (JST)
Date:	Wed, 18 Oct 2006 23:27:29 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] [MIPS] more vr41xx pt_regs fixup
Message-Id: <20061018232729.1b6416c8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed up pt_regs for vr41xx.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/vr41xx.h mips/include/asm-mips/vr41xx/vr41xx.h
--- mips-orig/include/asm-mips/vr41xx/vr41xx.h	2006-10-18 15:51:59.544965750 +0900
+++ mips/include/asm-mips/vr41xx/vr41xx.h	2006-10-18 18:38:43.194612250 +0900
@@ -75,7 +75,7 @@ extern void vr41xx_mask_clock(vr41xx_clo
  * Interrupt Control Unit
  */
 extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
-extern int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int, struct pt_regs *));
+extern int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int));
 
 #define PIUINT_COMMAND		0x0040
 #define PIUINT_DATA		0x0020
