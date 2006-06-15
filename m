Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 15:15:59 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:19254 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8134052AbWFOOPq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2006 15:15:46 +0100
Received: by mo.po.2iij.net (mo30) id k5FEFg7C070160; Thu, 15 Jun 2006 23:15:42 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox31) id k5FEFaCf052837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Jun 2006 23:15:37 +0900 (JST)
Date:	Thu, 15 Jun 2006 23:15:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] vr41xx: conform TANBAC board name to Kconfig
Message-Id: <20060615231535.68140419.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch conforms TANBAC board name to Kconfig.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips-rc6/Documentation/dontdiff mips-rc6-orig/arch/mips/Makefile mips-rc6/arch/mips/Makefile
--- mips-rc6-orig/arch/mips/Makefile	2006-06-09 00:32:57.201212750 +0900
+++ mips-rc6/arch/mips/Makefile	2006-06-09 10:51:37.222981000 +0900
@@ -454,7 +454,7 @@ core-$(CONFIG_CASIO_E55)	+= arch/mips/vr
 load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
 
 #
-# TANBAC TB0225 VR4131 Multi-chip module/TB0229 VR4131DIMM (VR4131)
+# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
 #
 load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000
 
