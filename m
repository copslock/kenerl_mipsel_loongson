Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 08:29:49 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:6436 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133365AbWGNH3j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Jul 2006 08:29:39 +0100
Received: by mo.po.2iij.net (mo31) id k6E7Ta9Z056434; Fri, 14 Jul 2006 16:29:36 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k6E7TZNs064507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Jul 2006 16:29:35 +0900 (JST)
Date:	Fri, 14 Jul 2006 16:29:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] USB: removed a unbalanced #endif from ohci-au1xxx.c
Message-Id: <20060714162935.70502a98.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch has removed a unbalanced #endif from ohci-au1xxx.c .

Error message was:
In file included from drivers/usb/host/ohci-hcd.c:909:
drivers/usb/host/ohci-au1xxx.c:113:2: #endif without #if

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X 2.6.18-rc1/Documentation/dontdiff 2.6.18-rc1-orig/drivers/usb/host/ohci-au1xxx.c 2.6.18-rc1/drivers/usb/host/ohci-au1xxx.c
--- 2.6.18-rc1-orig/drivers/usb/host/ohci-au1xxx.c	2006-07-14 11:17:34.443211500 +0900
+++ 2.6.18-rc1/drivers/usb/host/ohci-au1xxx.c	2006-07-14 10:33:47.945949750 +0900
@@ -110,7 +110,6 @@ static void au1xxx_start_ohc(struct plat
 
 	printk(KERN_DEBUG __FILE__
 	": Clock to USB host has been enabled \n");
-#endif
 }
 
 static void au1xxx_stop_ohc(struct platform_device *dev)
