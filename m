Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 20:03:44 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:20020 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28573807AbYDNTDm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Apr 2008 20:03:42 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 51E0D8810; Tue, 15 Apr 2008 00:03:41 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	bzolnier@gmail.com
Subject: [PATCH] Au1200: IDE driver build fix
Date:	Mon, 14 Apr 2008 23:03:04 +0400
User-Agent: KMail/1.5
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804142303.04661.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

The driver fails to compile with CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA enabled:

drivers/ide/mips/au1xxx-ide.c: In function `auide_build_dmatable':
drivers/ide/mips/au1xxx-ide.c:256: error: implicit declaration of function
`sg_virt'
drivers/ide/mips/au1xxx-ide.c:275: error: implicit declaration of function
`sg_next'
drivers/ide/mips/au1xxx-ide.c:275: warning: assignment makes pointer from
integer without a cast

Fix this by including <linux/scatterlist.h>. While at it, remove the #include's
without which the driver happily builds.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/mips/au1xxx-ide.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6/drivers/ide/mips/au1xxx-ide.c
@@ -32,19 +32,12 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-
 #include <linux/init.h>
 #include <linux/ide.h>
-#include <linux/sysdev.h>
-
-#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
 
-#include "ide-timing.h"
-
-#include <asm/io.h>
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
-
 #include <asm/mach-au1x00/au1xxx_ide.h>
 
 #define DRV_NAME	"au1200-ide"
