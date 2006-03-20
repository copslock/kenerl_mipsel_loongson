Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 23:31:00 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:32709 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133791AbWCTXas (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 23:30:48 +0000
Received: (qmail 10477 invoked from network); 21 Mar 2006 04:40:15 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 21 Mar 2006 04:40:15 -0000
Message-ID: <441F3CF6.9090509@ru.mvista.com>
Date:	Tue, 21 Mar 2006 02:38:30 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] Au1xx0: OHCI region size off-by-one
Content-Type: multipart/mixed;
 boundary="------------090800070801040505050401"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090800070801040505050401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Manish.

    Au1xx0 OHCI driver claims one byte too many for the memory mapped
controller registers.

WBR, Sergei


--------------090800070801040505050401
Content-Type: text/plain;
 name="Au1xx0-OHCI-region-size-off-by-one.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-OHCI-region-size-off-by-one.patch"

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index d7a8f0a..79407ab 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -20,7 +20,7 @@
 static struct resource au1xxx_usb_ohci_resources[] = {
 	[0] = {
 		.start		= USB_OHCI_BASE,
-		.end		= USB_OHCI_BASE + USB_OHCI_LEN,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {



--------------090800070801040505050401--
