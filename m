Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2007 14:57:31 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:37138 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022489AbXE1N5G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2007 14:57:06 +0100
Received: by mo.po.2iij.net (mo31) id l4SDv3hA076632; Mon, 28 May 2007 22:57:03 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox31) id l4SDuwdD050702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 28 May 2007 22:56:59 +0900 (JST)
Date:	Mon, 28 May 2007 22:56:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][2/2] remove unused config entry
Message-Id: <20070528225635.71a12db2.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070528225428.016e473d.yoichi_yuasa@tripeaks.co.jp>
References: <20070528225428.016e473d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused config entry.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-05-25 13:42:39.708898750 +0900
+++ mips/arch/mips/Kconfig	2007-05-25 13:42:12.303186000 +0900
@@ -844,15 +844,10 @@ config MIPS_TX3927
 config MIPS_RM9122
 	bool
 	select SERIAL_RM9000
-	select GPI_RM9000
-	select WDT_RM9000
 
 config PCI_MARVELL
 	bool
 
-config SERIAL_RM9000
-	bool
-
 config PNX8550
 	bool
 	select SOC_PNX8550
@@ -878,12 +873,6 @@ config EMMA2RH
 config SERIAL_RM9000
 	bool
 
-config GPI_RM9000
-	bool
-
-config WDT_RM9000
-	bool
-
 #
 # Unfortunately not all GT64120 systems run the chip at the same clock.
 # As the user for the clock rate and try to minimize the available options.
