Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2006 00:46:54 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:35015 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133791AbWCUAqi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Mar 2006 00:46:38 +0000
Received: (qmail 10875 invoked from network); 21 Mar 2006 05:56:12 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 21 Mar 2006 05:56:12 -0000
Message-ID: <441F4EBB.6000906@ru.mvista.com>
Date:	Tue, 21 Mar 2006 03:54:19 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] Au1xx0: OHCI region size off-by-one
Content-Type: multipart/mixed;
 boundary="------------080208030603020804070804"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080208030603020804070804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Reposting with signoff which I constantly forget about... :-/

    Au1xx0 OHCI driver claims one byte too many for the memory mapped
controller registers.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080208030603020804070804
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




--------------080208030603020804070804--
