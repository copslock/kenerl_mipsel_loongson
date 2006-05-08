Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 19:20:54 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:6095 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133477AbWEHSUd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 May 2006 19:20:33 +0100
Received: (qmail 23961 invoked from network); 8 May 2006 22:25:56 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 May 2006 22:25:56 -0000
Message-ID: <445F8BA8.8050006@ru.mvista.com>
Date:	Mon, 08 May 2006 22:19:20 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] RBTX4938: make RTL8019AS work when CONFIG_PCI=n
Content-Type: multipart/mixed;
 boundary="------------070805090307060006080304"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070805090307060006080304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch should make the on-board Ethernet chip (Realtek RTL8019AS) work 
when CONFIG_PCI is disabled...

Signed-off-by: Yuri Shpilevsky <yshpilevsky@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------070805090307060006080304
Content-Type: text/plain;
 name="RBTX4938-fix-IO-port-base.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RBTX4938-fix-IO-port-base.patch"

diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 5c7ace9..a96d442 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -918,7 +918,7 @@ void __init toshiba_rbtx4938_setup(void)
 	TX4938_WR(0xff1ff414, 0x00000000);	/* h/w flow control off */
 
 #ifndef CONFIG_PCI
-	set_io_port_base(RBTX4938_ETHER_BASE);
+	set_io_port_base(KSEG1);
 #endif
 
 #ifdef CONFIG_SERIAL_TXX9



--------------070805090307060006080304--
