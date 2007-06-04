Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 10:33:58 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:36582 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20021682AbXFDJdx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 10:33:53 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Hv8td-0001da-PL
	for linux-mips@linux-mips.org; Mon, 04 Jun 2007 02:30:41 -0700
Message-ID: <10946448.post@talk.nabble.com>
Date:	Mon, 4 Jun 2007 02:30:41 -0700 (PDT)
From:	Daniel Laird <daniel.j.laird@nxp.com>
To:	linux-mips@linux-mips.org
Subject: Adding 256MB support for PNX8550
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: daniel.j.laird@nxp.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips


The following patch allows for 256MB support on pnx8550 based systems:

--- /include/asm-mips/mach-pnx8550/pci.h.orig 
+++ /include/asm-mips/mach-pnx8550/pci.h.new 
@@ -63,6 +63,7 @@
 #define SIZE_32M                 0x4
 #define SIZE_64M                 0x5
 #define SIZE_128M                0x6
+#define SIZE_256M                0x7
 #define PCI_SETUP_BASE18_SIZE(X) (X<<18)
 #define PCI_SETUP_BASE18_EN      (1<<17)
 #define PCI_SETUP_BASE14_PREF    (1<<16)

Cheers
Dan Laird
-- 
View this message in context: http://www.nabble.com/Adding-256MB-support-for-PNX8550-tf3864000.html#a10946448
Sent from the linux-mips main mailing list archive at Nabble.com.
