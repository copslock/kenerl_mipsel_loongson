Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 04:46:39 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:56595 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037532AbWJaEpV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2006 04:45:21 +0000
Received: by mo.po.2iij.net (mo31) id k9V4jGIu043323; Tue, 31 Oct 2006 13:45:16 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id k9V4jEJS019886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Oct 2006 13:45:14 +0900 (JST)
Date:	Tue, 31 Oct 2006 12:53:29 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add BROKEN to FPCIB0 Backplane support
Message-Id: <20061031125329.0b5eef68.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added "depends on BROKEN" to FPCIB0 Backplane Support.
The files to make smsc_fdc37m81x.o doesn't exist.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/tx4927/Kconfig mips/arch/mips/tx4927/Kconfig
--- mips-orig/arch/mips/tx4927/Kconfig	2006-10-31 09:48:06.461921250 +0900
+++ mips/arch/mips/tx4927/Kconfig	2006-10-31 11:41:02.713404500 +0900
@@ -1,3 +1,3 @@
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
-	depends on TOSHIBA_RBTX4927
+	depends on TOSHIBA_RBTX4927 && BROKEN
