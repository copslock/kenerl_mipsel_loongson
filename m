Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 19:29:33 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:7732 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20024197AbYDNS3b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Apr 2008 19:29:31 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 0FF788810; Mon, 14 Apr 2008 23:29:29 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: [PATCH] Au1200: kill IDE driver function prototypes
Date:	Mon, 14 Apr 2008 22:28:51 +0400
User-Agent: KMail/1.5
Cc:	ralf@linux-mips.org, bzolnier@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804142228.51987.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:

include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
`static' but never defined
include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
 `static' but never defined

by wiping out the whole "function prototyping" section from the header file
<asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
already dead in the IDE driver; move the only useful prototype into the driver.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
remove that added prototype since it won't be needed anymore...

 drivers/ide/mips/au1xxx-ide.c             |    2 ++
 include/asm-mips/mach-au1x00/au1xxx_ide.h |   18 ------------------
 2 files changed, 2 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6/drivers/ide/mips/au1xxx-ide.c
@@ -56,6 +56,8 @@
 static _auide_hwif auide_hwif;
 static int dbdma_init_done;
 
+static int auide_ddma_init(_auide_hwif *auide);
+
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA)
 
 void auide_insw(unsigned long port, void *addr, u32 count)
Index: linux-2.6/include/asm-mips/mach-au1x00/au1xxx_ide.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -122,24 +122,6 @@ static const struct drive_list_entry dma
 };
 #endif
 
-/* function prototyping */
-u8 auide_inb(unsigned long port);
-u16 auide_inw(unsigned long port);
-u32 auide_inl(unsigned long port);
-void auide_insw(unsigned long port, void *addr, u32 count);
-void auide_insl(unsigned long port, void *addr, u32 count);
-void auide_outb(u8 addr, unsigned long port);
-void auide_outbsync(ide_drive_t *drive, u8 addr, unsigned long port);
-void auide_outw(u16 addr, unsigned long port);
-void auide_outl(u32 addr, unsigned long port);
-void auide_outsw(unsigned long port, void *addr, u32 count);
-void auide_outsl(unsigned long port, void *addr, u32 count);
-static void auide_tune_drive(ide_drive_t *drive, byte pio);
-static int auide_tune_chipset(ide_drive_t *drive, u8 speed);
-static int auide_ddma_init( _auide_hwif *auide );
-static void auide_setup_ports(hw_regs_t *hw, _auide_hwif *ahwif);
-int __init auide_probe(void);
-
 /*******************************************************************************
 * PIO Mode timing calculation :                                                *
 *                                                                              *
