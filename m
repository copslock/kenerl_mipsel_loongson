Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 04:46:14 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:27711 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037487AbWJaEpV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2006 04:45:21 +0000
Received: by mo.po.2iij.net (mo32) id k9V4jHES004884; Tue, 31 Oct 2006 13:45:17 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k9V4jEPa009920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Oct 2006 13:45:15 +0900 (JST)
Message-Id: <200610310445.k9V4jEPa009920@mbox30.po.2iij.net>
Date:	Tue, 31 Oct 2006 13:38:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix uninitialized variable in titan_i2c_xfer()
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed the problem of the initialization of variable.
The bytes is used uninitialized in titan_i2c_xfer().

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pmc-sierra/yosemite/i2c-yosemite.c mips/arch/mips/pmc-sierra/yosemite/i2c-yosemite.c
--- mips-orig/arch/mips/pmc-sierra/yosemite/i2c-yosemite.c	2006-10-31 09:48:05.213843250 +0900
+++ mips/arch/mips/pmc-sierra/yosemite/i2c-yosemite.c	2006-10-31 13:19:11.495169500 +0900
@@ -74,7 +74,7 @@ static int titan_i2c_poll(void)
 int titan_i2c_xfer(unsigned int slave_addr, titan_i2c_command * cmd,
 		   int size, unsigned int *addr)
 {
-	int loop = 0, bytes, i;
+	int loop, bytes = 0, i;
 	unsigned int *write_data, data, *read_data;
 	unsigned long reg_val, val;
 
