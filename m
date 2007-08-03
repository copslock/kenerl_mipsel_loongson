Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 22:59:38 +0100 (BST)
Received: from bogenhausen.olympweb.de ([85.114.130.74]:39320 "EHLO
	bogenhausen.olympweb.de") by ftp.linux-mips.org with ESMTP
	id S20023895AbXHCV7g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 22:59:36 +0100
Received: (qmail 13970 invoked from network); 3 Aug 2007 23:59:55 +0200
Received: from e177170096.adsl.alicedsl.de (HELO ?192.168.16.234?) (85.177.170.96)
  by bogenhausen.olympweb.de with SMTP; 3 Aug 2007 23:59:55 +0200
Message-ID: <46B3A543.5020007@phrozen.org>
Date:	Fri, 03 Aug 2007 23:59:31 +0200
From:	John Crispin <john@phrozen.org>
User-Agent: Icedove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH][au1x00/mtx1] - usb power switch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips

the gpio of the usb power switch for the mtx-1 is not pulled high due to 
wrong #ifdef

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>

--- linux-2.6.23.orig/arch/mips/au1000/mtx-1/board_setup.c	2007-07-29 18:57:35.000000000 +0200
+++ linux-2.6.23/arch/mips/au1000/mtx-1/board_setup.c	2007-07-29 18:59:48.000000000 +0200
@@ -54,7 +54,7 @@
 
 void __init board_setup(void)
 {
-#ifdef CONFIG_USB_OHCI
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) 
 	// enable USB power switch
 	au_writel( au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR );
 	au_writel( 0x100001, GPIO2_OUTPUT );
