Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 13:41:24 +0000 (GMT)
Received: from mo30.po.2iij.NET ([210.128.50.53]:45592 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20032328AbXLLNlQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2007 13:41:16 +0000
Received: by mo.po.2iij.net (mo30) id lBCDdwmx000543; Wed, 12 Dec 2007 22:39:58 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id lBCDdsNh016166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Dec 2007 22:39:55 +0900
Date:	Wed, 12 Dec 2007 22:39:54 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] move the eXcite local config to excitedirectory
Message-Id: <20071212223954.44e12672.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Moved the eXcite local config to excite directory.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-12-12 00:06:19.245069500 +0900
+++ mips/arch/mips/Kconfig	2007-12-12 00:09:53.974489250 +0900
@@ -37,16 +37,6 @@ config BASLER_EXCITE
 	  The eXcite is a smart camera platform manufactured by
 	  Basler Vision Technologies AG.
 
-config BASLER_EXCITE_PROTOTYPE
-	bool "Support for pre-release units"
-	depends on BASLER_EXCITE
-	default n
-	help
-	  Pre-series (prototype) units are different from later ones in
-	  some ways. Select this option if you have one of these. Please
-	  note that a kernel built with this option selected will not be
-	  able to run on normal units.
-
 config BCM47XX
 	bool "BCM47XX based boards"
 	select CEVT_R4K
@@ -688,6 +678,7 @@ config WR_PPMC
 endchoice
 
 source "arch/mips/au1000/Kconfig"
+source "arch/mips/basler/excite/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/basler/excite/Kconfig mips/arch/mips/basler/excite/Kconfig
--- mips-orig/arch/mips/basler/excite/Kconfig	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/basler/excite/Kconfig	2007-12-12 00:09:53.974489250 +0900
@@ -0,0 +1,9 @@
+config BASLER_EXCITE_PROTOTYPE
+	bool "Support for pre-release units"
+	depends on BASLER_EXCITE
+	default n
+	help
+	  Pre-series (prototype) units are different from later ones in
+	  some ways. Select this option if you have one of these. Please
+	  note that a kernel built with this option selected will not be
+	  able to run on normal units.
