Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 18:24:28 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:31543 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133726AbVLFSYK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 18:24:10 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB6INqt19576;
	Tue, 6 Dec 2005 22:23:52 +0400
Message-ID: <4395D738.3080800@ru.mvista.com>
Date:	Tue, 06 Dec 2005 21:23:52 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	ralf@linux-mips.org, ppopov@embeddedalley.com
Subject: [PATCH] Philips PNX8550 USB Host driver compile fix
Content-Type: multipart/mixed;
 boundary="------------020604080105030507040509"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020604080105030507040509
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Ralf, Pete,

The current ohci-hcd driver is a little defective.
It's unable to use usb-ohci as modules in the case when PCI and on-chip 
USB are enabled.
It just will not be compiled since there are two calls if module_init in 
ohci-hcd.

Please look at the patch attached.
I 'm not sure is this patch well for this situation.
Any suggestions are very appreciated.

TIA,
Vladimir



--------------020604080105030507040509
Content-Type: text/plain;
 name="usb_modules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb_modules.patch"

--- linux-2.6.10.orig/drivers/usb/host/ohci-hcd.c	2005-12-02 16:37:59.000000000 +0300
+++ linux-2.6.10/drivers/usb/host/ohci-hcd.c	2005-12-02 19:34:21.000000000 +0300
@@ -906,8 +906,12 @@ MODULE_LICENSE ("GPL");
 #endif
 
 #ifdef CONFIG_PNX8550
+#if defined(CONFIG_PCI) && defined(CONFIG_USB_OHCI_HCD_MODULE)
+#error "unable to compile PNX8550 USB and PCI USB as modules simultaneously until usb hcd stack is rewritten"
+#else
 #include "ohci-pnx8550.c"
 #endif
+#endif
 
 #ifdef CONFIG_USB_OHCI_HCD_PPC_SOC
 #include "ohci-ppc-soc.c"
@@ -919,6 +923,7 @@ MODULE_LICENSE ("GPL");
       || defined (CONFIG_ARCH_LH7A404) \
       || defined (CONFIG_PXA27x) \
       || defined (CONFIG_SOC_AU1X00) \
+      || defined (CONFIG_PNX8550) \
       || defined (CONFIG_USB_OHCI_HCD_PPC_SOC) \
 	)
 #error "missing bus glue for ohci-hcd"

--------------020604080105030507040509--
