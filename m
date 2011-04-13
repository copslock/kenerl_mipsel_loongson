Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2011 01:24:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45814 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491872Ab1DMXY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2011 01:24:26 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p3DNNA4H001690;
        Thu, 14 Apr 2011 01:23:10 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p3DNN8kA001684;
        Thu, 14 Apr 2011 01:23:08 +0200
Date:   Thu, 14 Apr 2011 01:23:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] USB: OHCI: Fix build warning on Alchemy
Message-ID: <20110413232308.GA22925@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

  CC      drivers/usb/host/ohci-hcd.o
In file included from drivers/usb/host/ohci-hcd.c:1028:0:
drivers/usb/host/ohci-au1xxx.c:36:7: warning: "__BIG_ENDIAN" is not defined [-Wundef]

Fix the warning and some other build bullet proofing; let's not rely on
other needed header files getting dragged in magically.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

 drivers/usb/host/ohci-au1xxx.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 17a6043..0723990 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -19,7 +19,10 @@
  */
 
 #include <linux/platform_device.h>
-#include <linux/signal.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <asm/byteorder.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
@@ -33,7 +36,7 @@
 
 #ifdef __LITTLE_ENDIAN
 #define USBH_ENABLE_INIT (USBH_ENABLE_CE | USBH_ENABLE_E | USBH_ENABLE_C)
-#elif __BIG_ENDIAN
+#elif defined(__BIG_ENDIAN)
 #define USBH_ENABLE_INIT (USBH_ENABLE_CE | USBH_ENABLE_E | USBH_ENABLE_C | \
 			  USBH_ENABLE_BE)
 #else
