Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2008 20:17:41 +0200 (CEST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:36483 "EHLO
	buildserver.ru.mvista.com") by lappi.linux-mips.net with ESMTP
	id S533091AbYDESRg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Apr 2008 20:17:36 +0200
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id DA0538810; Sun,  6 Apr 2008 00:17:24 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	linux-mips@linux-mips.org, i2c@lm-sensors.org
Subject: [PATCH] Alchemy: SMBus resource fix
Date:	Sat, 5 Apr 2008 22:16:21 +0400
User-Agent: KMail/1.5
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200804052216.21699.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

The Alchemy platform code registers the SMBus device using the virtual address
of its registers instead of the physical one -- fix this, taking into account
that actually the whole megabyte is decoded by any of the programmable serial
controllers (one of which is SMBus), and that all the Alchemy peripherals are
directly mappable into KSEG1 kernel space and therefore ioremap() call would
just boil down to CKSEG1ADDR() invocation.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

 arch/mips/au1000/common/platform.c |    4 ++--
 drivers/i2c/busses/i2c-au1550.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -274,8 +274,8 @@ static struct platform_device smc91x_dev
 #ifdef SMBUS_PSC_BASE
 static struct resource pbdb_smbus_resources[] = {
 	{
-		.start	= SMBUS_PSC_BASE,
-		.end	= SMBUS_PSC_BASE + 0x24 - 1,
+		.start	= CPHYSADDR(SMBUS_PSC_BASE),
+		.end	= CPHYSADDR(SMBUS_PSC_BASE + 0xfffff),
 		.flags	= IORESOURCE_MEM,
 	},
 };
Index: linux-2.6/drivers/i2c/busses/i2c-au1550.c
===================================================================
--- linux-2.6.orig/drivers/i2c/busses/i2c-au1550.c
+++ linux-2.6/drivers/i2c/busses/i2c-au1550.c
@@ -335,7 +335,7 @@ i2c_au1550_probe(struct platform_device 
 		goto out_mem;
 	}
 
-	priv->psc_base = r->start;
+	priv->psc_base = CKSEG1ADDR(r->start);
 	priv->xfer_timeout = 200;
 	priv->ack_timeout = 200;
 
