Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 09:55:28 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:48147 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039195AbWKAJz0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2006 09:55:26 +0000
Received: by mo.po.2iij.net (mo31) id kA19tO7L095732; Wed, 1 Nov 2006 18:55:24 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id kA19tMD0090788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Nov 2006 18:55:22 +0900 (JST)
Date:	Wed, 1 Nov 2006 18:55:22 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix warning mips-boards generic pci
Message-Id: <20061101185522.678913fb.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed the following warning.

arch/mips/mips-boards/generic/pci.c: In function `mips_pcibios_init':
arch/mips/mips-boards/generic/pci.c:227: warning: comparison of distinct pointer types lacks a cast
arch/mips/mips-boards/generic/pci.c:228: warning: comparison of distinct pointer types lacks a cast

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/mips-boards/generic/pci.c mips/arch/mips/mips-boards/generic/pci.c
--- mips-orig/arch/mips/mips-boards/generic/pci.c	2006-10-29 13:42:19.471809750 +0900
+++ mips/arch/mips/mips-boards/generic/pci.c	2006-10-29 13:48:04.077346250 +0900
@@ -90,7 +90,7 @@ static struct pci_controller msc_control
 void __init mips_pcibios_init(void)
 {
 	struct pci_controller *controller;
-	unsigned long start, end, map, start1, end1, map1, map2, map3, mask;
+	resource_size_t start, end, map, start1, end1, map1, map2, map3, mask;
 
 	switch (mips_revision_corid) {
 	case MIPS_REVISION_CORID_QED_RM5261:
