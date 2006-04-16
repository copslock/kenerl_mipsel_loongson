Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 11:18:01 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:40879 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133403AbWDQKRx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 11:17:53 +0100
Received: (qmail 9892 invoked from network); 16 Apr 2006 19:46:16 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 16 Apr 2006 19:46:16 -0000
Message-ID: <444265EB.50503@ru.mvista.com>
Date:	Sun, 16 Apr 2006 19:42:35 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	jgarzik@pobox.com
CC:	linux-net@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] NEx000: fix RTL8019AS base address for RBTX4938
Content-Type: multipart/mixed;
 boundary="------------080305010002070700050107"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080305010002070700050107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Correct the base address of the Realtek RTL8019AS chip on the Toshiba RBTX4938
board -- this should make the driver work at least when CONFIG_PCI is enabled.

Signed-off-by: Yuri Shpilevsky <yshpilevsky@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080305010002070700050107
Content-Type: text/plain;
 name="RBTX4938-fix-RTL8019AS-base-addr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RBTX4938-fix-RTL8019AS-base-addr.patch"

diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index 08b218c..93c494b 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -226,7 +226,7 @@ struct net_device * __init ne_probe(int 
 	netdev_boot_setup_check(dev);
 
 #ifdef CONFIG_TOSHIBA_RBTX4938
-	dev->base_addr = 0x07f20280;
+	dev->base_addr = RBTX4938_RTL_8019_BASE;
 	dev->irq = RBTX4938_RTL_8019_IRQ;
 #endif
 	err = do_ne_probe(dev);



--------------080305010002070700050107--
