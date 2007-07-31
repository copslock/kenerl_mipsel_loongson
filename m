Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 08:52:23 +0100 (BST)
Received: from o074.orange.fastwebserver.de ([85.114.130.74]:55531 "EHLO
	bogenhausen.olympweb.de") by ftp.linux-mips.org with ESMTP
	id S20021571AbXGaHwV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 08:52:21 +0100
Received: (qmail 19447 invoked from network); 31 Jul 2007 09:51:44 +0200
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 31 Jul 2007 09:51:44 +0200
Received: from 213.238.49.68 ([213.238.49.68]) by webmail.phrozen.org
	(Horde MIME library) with HTTP; Tue, 31 Jul 2007 09:51:44 +0200
Message-ID: <20070731095144.95bm2ha4o4gs0g4c@webmail.phrozen.org>
Date:	Tue, 31 Jul 2007 09:51:44 +0200
From:	John Crispin <john@phrozen.org>
To:	linux-mips@linux-mips.org
Cc:	nbd@openwrt.org, florian@openwrt.org
Subject: [PATCH][au1x00/mtx1] - pci resource conflict
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
X-archive-position: 15957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Felix Fietkau <nbd@openwrt.org>

pci controller failed to register, as PCI_MEM_END was greater than  
IOMEM_RESOURCE_END and Au1500_PCI_IO_END was greater than  
IOPORT_RESOURCE_END
IO{MEM,PORT}_RESOURCE_END value were adjust to represent the actual  
memory map of the au1x00

--- linux-2.6.23-rc1.orig/include/asm-mips/mach-au1x00/au1000.h  
2007-07-24 18:44:21.598778839 +0200
+++ linux-2.6.23-rc1/include/asm-mips/mach-au1x00/au1000.h       
2007-07-24 22:08:49.761901610 +0200
@@ -1680,9 +1680,9 @@
  #define PCI_LAST_DEVFN  (19<<3)

  #define IOPORT_RESOURCE_START 0x00001000 /* skip legacy probing */
-#define IOPORT_RESOURCE_END   0xffffffff
+#define IOPORT_RESOURCE_END   0xfffffffffULL
  #define IOMEM_RESOURCE_START  0x10000000
-#define IOMEM_RESOURCE_END    0xffffffff
+#define IOMEM_RESOURCE_END    0xfffffffffULL

    /*
     * Borrowed from the PPC arch:
