Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 20:06:56 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:58929 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20023188AbYEHTGy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 May 2008 20:06:54 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 1DA018815; Fri,  9 May 2008 00:06:51 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Au1200: MMC resource size off by one
Date:	Thu, 8 May 2008 23:06:17 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805082306.17553.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Au12x0 MMC platform device strangely claims 0x41 bytes for its memory-mapped
registers.  Make it claim the whole 0x80000 instead according to the memory
map given in the datasheets.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Inspired by the patches posted by Manuel Lauss.
Should apply to the top of Linux/MIPS tree...

 arch/mips/au1000/common/platform.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -165,12 +165,12 @@ static struct resource au1xxx_usb_gdt_re
 static struct resource au1xxx_mmc_resources[] = {
 	[0] = {
 		.start          = SD0_PHYS_ADDR,
-		.end            = SD0_PHYS_ADDR + 0x40,
+		.end            = SD0_PHYS_ADDR + 0x7ffff,
 		.flags          = IORESOURCE_MEM,
 	},
 	[1] = {
 		.start		= SD1_PHYS_ADDR,
-		.end 		= SD1_PHYS_ADDR + 0x40,
+		.end 		= SD1_PHYS_ADDR + 0x7ffff,
 		.flags		= IORESOURCE_MEM,
 	},
 	[2] = {
