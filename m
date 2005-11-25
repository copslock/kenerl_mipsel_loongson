Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2005 19:03:23 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:41167 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S3466664AbVKYTDF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Nov 2005 19:03:05 +0000
Received: (qmail 1245 invoked from network); 25 Nov 2005 19:05:59 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 25 Nov 2005 19:05:59 -0000
Message-ID: <43876118.3060503@dev.rtsoft.ru>
Date:	Fri, 25 Nov 2005 22:08:08 +0300
From:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Organization: RTSoft, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crusoe <jordan.crouse@amd.com>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] Fix Au1550 OHCI memory map size
Content-Type: multipart/mixed;
 boundary="------------060800070208090600080108"
Return-Path: <sshtylyov@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060800070208090600080108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     USB OpenHCI host controller on Au1550 only decodes memory addresses from
0x14020000 to 0x1407FFFF according to the databook, which gives 0x60000 (on
the prior Au1x00 chips the map size was 1MB).

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------060800070208090600080108
Content-Type: text/plain;
 name="Au1550-OHCI-mem-size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1550-OHCI-mem-size.patch"

diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-au1x00/au1000.h
index 8327ec3..8e1d7ed 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -838,6 +838,7 @@ extern au1xxx_irq_map_t au1xxx_irq_map[]
 #define UART3_ADDR                0xB1400000
 
 #define USB_OHCI_BASE             0x14020000 // phys addr for ioremap
+#define USB_OHCI_LEN              0x00060000
 #define USB_HOST_CONFIG           0xB4027ffc
 
 #define AU1550_ETH0_BASE      0xB0500000
@@ -1017,10 +1018,12 @@ extern au1xxx_irq_map_t au1xxx_irq_map[]
   #define I2S_CONTROL_D         (1<<1)
   #define I2S_CONTROL_CE        (1<<0)
 
-#ifndef CONFIG_SOC_AU1200
-
 /* USB Host Controller */
+#ifndef USB_OHCI_LEN
 #define USB_OHCI_LEN              0x00100000
+#endif
+
+#ifndef CONFIG_SOC_AU1200
 
 /* USB Device Controller */
 #define USBD_EP0RD                0xB0200000







--------------060800070208090600080108--
