Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 08:54:59 +0100 (BST)
Received: from o074.orange.fastwebserver.de ([85.114.130.74]:41163 "EHLO
	bogenhausen.olympweb.de") by ftp.linux-mips.org with ESMTP
	id S20021570AbXGaHy5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 08:54:57 +0100
Received: (qmail 20238 invoked from network); 31 Jul 2007 09:54:45 +0200
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 31 Jul 2007 09:54:45 +0200
Received: from 213.238.49.68 ([213.238.49.68]) by webmail.phrozen.org
	(Horde MIME library) with HTTP; Tue, 31 Jul 2007 09:54:45 +0200
Message-ID: <20070731095445.6k13xssqo0ccs0oo@webmail.phrozen.org>
Date:	Tue, 31 Jul 2007 09:54:45 +0200
From:	John Crispin <john@phrozen.org>
To:	linux-mips@linux-mips.org
Cc:	nbd@openwrt.org, florian@openwrt.org
Subject: [PATCH][au1x00/mtx1] - pci iomap
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
X-archive-position: 15958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Felix Fietkau <nbd@openwrt.org>

for some reason the au1x00 pci code remaps the pci mem region but does  
not pass the virt_io_addr when registering the pci controller

--- linux-2.6.23-rc1.orig/arch/mips/au1000/common/pci.c 2007-07-24  
18:42:21.031908123 +0200
+++ linux-2.6.23-rc1/arch/mips/au1000/common/pci.c      2007-07-24  
22:12:07.373162835 +0200
@@ -74,6 +74,7 @@
                 printk(KERN_ERR "Unable to ioremap pci space\n");
                 return 1;
         }
+       au1x_controller.io_map_base = virt_io_addr;

  #ifdef CONFIG_DMA_NONCOHERENT
         {
