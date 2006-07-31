Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 15:05:48 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:20268 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8126917AbWGaOFi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 15:05:38 +0100
Received: by mo.po.2iij.net (mo31) id k6VE5ZNm082481; Mon, 31 Jul 2006 23:05:35 +0900 (JST)
Received: from localhost.localdomain (8.26.30.125.dy.iij4u.or.jp [125.30.26.8])
	by mbox.po.2iij.net (mbox32) id k6VE5XbT094551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 31 Jul 2006 23:05:33 +0900 (JST)
Date:	Mon, 31 Jul 2006 23:05:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fixed Makefile about EV64120 PCI fixup
Message-Id: <20060731230504.5f470eb6.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed Makefile about EV64120 PCI fixup.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/Makefile mips/arch/mips/pci/Makefile
--- mips-orig/arch/mips/pci/Makefile	2006-07-31 13:48:35.879388750 +0900
+++ mips/arch/mips/pci/Makefile	2006-07-31 13:49:44.115653250 +0900
@@ -28,7 +28,7 @@ obj-$(CONFIG_DDB5477)		+= fixup-ddb5477.
 obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_ATLAS)	+= fixup-atlas.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
-obj-$(CONFIG_MIPS_EV96100)	+= fixup-ev64120.o
+obj-$(CONFIG_MIPS_EV64120)	+= fixup-ev64120.o
 obj-$(CONFIG_MIPS_EV96100)	+= fixup-ev96100.o pci-ev96100.o
 obj-$(CONFIG_MIPS_ITE8172)	+= fixup-ite8172g.o
 obj-$(CONFIG_MIPS_IVR)		+= fixup-ivr.o
