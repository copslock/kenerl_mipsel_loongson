Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 14:59:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:18105 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133753AbWFGN7a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 14:59:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k57DxTSI027717;
	Wed, 7 Jun 2006 14:59:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k57DxMBN027716;
	Wed, 7 Jun 2006 14:59:22 +0100
Date:	Wed, 7 Jun 2006 14:59:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-mips@linux-mips.org
Subject: [PATCH] Fix OHCI HCD build for PNX 8550
Message-ID: <20060607135922.GA26754@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The PNX8550 OHCI is a platform device so we better include the necessary
headers.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/usb/host/ohci-pnx8550.c b/drivers/usb/host/ohci-pnx8550.c
index db9c5db..ed242e7 100644
--- a/drivers/usb/host/ohci-pnx8550.c
+++ b/drivers/usb/host/ohci-pnx8550.c
@@ -23,7 +23,7 @@
  * This file is licenced under the GPL.
  */
 
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <asm/mach-pnx8550/usb.h>
 #include <asm/mach-pnx8550/int.h>
 #include <asm/mach-pnx8550/pci.h>
