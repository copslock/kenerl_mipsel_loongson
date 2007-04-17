Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2007 11:16:49 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:23324 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023603AbXDQKQp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2007 11:16:45 +0100
Received: by mo.po.2iij.net (mo31) id l3HAFODs040681; Tue, 17 Apr 2007 19:15:24 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l3HAFMsS091358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 Apr 2007 19:15:22 +0900 (JST)
Date:	Tue, 17 Apr 2007 19:15:22 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fix NEC VR4100 series explanation
Message-Id: <20070417191522.6382f086.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed NEC VR4100 series explanation in arch/mips/Kconfig.
This small fix is only for linux-mips.org tree.
It's already fixed in linus tree.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-04-14 22:14:15.756283750 +0900
+++ mips/arch/mips/Kconfig	2007-04-14 22:15:46.073928250 +0900
@@ -1233,7 +1233,7 @@ config CPU_VR41XX
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	help
-	  The options selects support for the NEC VR41xx series of processors.
+	  The options selects support for the NEC VR4100 series of processors.
 	  Only choose this option if you have one of these processors as a
 	  kernel built with this option will not run on any other type of
 	  processor or vice versa.
