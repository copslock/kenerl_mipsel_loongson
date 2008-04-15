Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 19:21:27 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:48390 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28575130AbYDOSVZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Apr 2008 19:21:25 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 48F578810; Tue, 15 Apr 2008 23:21:24 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 1/2] DBAu1200: fix bad SMC 91C111 resource size
Date:	Tue, 15 Apr 2008 22:20:45 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804152220.45725.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

The on-board SMC 91C111 chip only decodes 16 bytes of memory (obviously, it can
not decode a whole megabyte starting from address 0x19000300).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Looking into drivers/net/smc91x.h cleared the things up...

 arch/mips/au1000/common/platform.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -251,7 +251,7 @@ static struct resource smc91x_resources[
 	[0] = {
 		.name	= "smc91x-regs",
 		.start	= AU1XXX_SMC91111_PHYS_ADDR,
-		.end	= AU1XXX_SMC91111_PHYS_ADDR + 0xfffff,
+		.end	= AU1XXX_SMC91111_PHYS_ADDR + 0xf,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
