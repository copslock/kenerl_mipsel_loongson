Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 04:44:54 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:13132 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021437AbXHBDou (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 04:44:50 +0100
Received: by mo.po.2iij.net (mo31) id l723ik1s014689; Thu, 2 Aug 2007 12:44:46 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l723iiOt002957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Aug 2007 12:44:45 +0900
Date:	Thu, 2 Aug 2007 12:44:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused pnx8550 Kconfig
Message-Id: <20070802124444.5dda6060.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused pnx8550 Kconfig

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-08-01 11:25:02.551361500 +0900
+++ mips/arch/mips/Kconfig	2007-08-01 11:46:19.307153750 +0900
@@ -604,7 +604,6 @@ source "arch/mips/sibyte/Kconfig"
 source "arch/mips/tx4927/Kconfig"
 source "arch/mips/tx4938/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
-source "arch/mips/philips/pnx8550/common/Kconfig"
 
 endmenu
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/philips/pnx8550/common/Kconfig mips/arch/mips/philips/pnx8550/common/Kconfig
--- mips-orig/arch/mips/philips/pnx8550/common/Kconfig	2007-08-01 11:25:03.967450000 +0900
+++ mips/arch/mips/philips/pnx8550/common/Kconfig	1970-01-01 09:00:00.000000000 +0900
@@ -1 +0,0 @@
-# Place holder
