Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 08:56:07 +0100 (BST)
Received: from o074.orange.fastwebserver.de ([85.114.130.74]:44747 "EHLO
	bogenhausen.olympweb.de") by ftp.linux-mips.org with ESMTP
	id S20021597AbXGaH4E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 08:56:04 +0100
Received: (qmail 20833 invoked from network); 31 Jul 2007 09:56:12 +0200
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 31 Jul 2007 09:56:12 +0200
Received: from 213.238.49.68 ([213.238.49.68]) by webmail.phrozen.org
	(Horde MIME library) with HTTP; Tue, 31 Jul 2007 09:56:12 +0200
Message-ID: <20070731095612.n423vnw29wc88cog@webmail.phrozen.org>
Date:	Tue, 31 Jul 2007 09:56:12 +0200
From:	John Crispin <john@phrozen.org>
To:	linux-mips@linux-mips.org
Cc:	nbd@openwrt.org, florian@openwrt.org
Subject: [PATCH][au1x00/mtx1] - usb power switch
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Felix Fietkau <nbd@openwrt.org>


the gpio for the usb power switch is not pulled on the mtx-1 on 2.6 kernels

--- linux-2.6.23-rc1.orig/arch/mips/au1000/mtx-1/board_setup.c   
2007-07-29 18:57:35.000000000 +0200
+++ linux-2.6.23-rc1/arch/mips/au1000/mtx-1/board_setup.c        
2007-07-29 18:59:48.000000000 +0200
@@ -54,7 +54,7 @@

  void __init board_setup(void)
  {
-#ifdef CONFIG_USB_OHCI
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
         // enable USB power switch
         au_writel( au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR );
         au_writel( 0x100000, GPIO2_OUTPUT );
