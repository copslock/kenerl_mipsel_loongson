Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 04:59:36 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:37178 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021773AbXEKD7f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 04:59:35 +0100
Received: by mo.po.2iij.net (mo32) id l4B3xP4Z032929; Fri, 11 May 2007 12:59:25 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l4B3xJbn089751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 12:59:20 +0900 (JST)
Date:	Fri, 11 May 2007 12:59:19 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	drzeus@drzeus.cx
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] mmc: add include <linux/mmc/mmc.h> to au1xmmc.c
Message-Id: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch has fixed the following error about au1xmmc.c .

drivers/mmc/host/au1xmmc.c: In function 'au1xmmc_send_command':
drivers/mmc/host/au1xmmc.c:217: error: 'MMC_READ_SINGLE_BLOCK' undeclared (first use in this function)
drivers/mmc/host/au1xmmc.c:217: error: (Each undeclared identifier is reported only once
drivers/mmc/host/au1xmmc.c:217: error: for each function it appears in.)
drivers/mmc/host/au1xmmc.c:218: error: 'SD_APP_SEND_SCR' undeclared (first use in this function)
drivers/mmc/host/au1xmmc.c:221: error: 'MMC_READ_MULTIPLE_BLOCK' undeclared (first use in this function)
drivers/mmc/host/au1xmmc.c:224: error: 'MMC_WRITE_BLOCK' undeclared (first use in this function)
drivers/mmc/host/au1xmmc.c:228: error: 'MMC_WRITE_MULTIPLE_BLOCK' undeclared (first use in this function)
drivers/mmc/host/au1xmmc.c:231: error: 'MMC_STOP_TRANSMISSION' undeclared (first use in this function)

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mmc/host/au1xmmc.c mips/drivers/mmc/host/au1xmmc.c
--- mips-orig/drivers/mmc/host/au1xmmc.c	2007-05-10 15:14:44.705610250 +0900
+++ mips/drivers/mmc/host/au1xmmc.c	2007-05-10 18:12:02.785248000 +0900
@@ -42,6 +42,7 @@
 #include <linux/dma-mapping.h>
 
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <asm/io.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
