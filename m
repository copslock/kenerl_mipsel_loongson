Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 20:21:54 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:26853 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28591923AbYHLTVZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 20:21:25 +0100
Received: (qmail 9776 invoked from network); 12 Aug 2008 21:21:22 +0200
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 12 Aug 2008 21:21:22 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kevin Hickey <khickey@rmicorp.com>, linux-mips@linux-mips.org,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] Alchemy: rework DBDMA init sequence.
Date:	Tue, 12 Aug 2008 21:21:20 +0200
Message-Id: <1218568881-3544-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.5.6.4
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/dbdma.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/mips/au1000/common/dbdma.c b/arch/mips/au1000/common/dbdma.c
index 601ee91..c1f0a3c 100644
--- a/arch/mips/au1000/common/dbdma.c
+++ b/arch/mips/au1000/common/dbdma.c
@@ -57,8 +57,6 @@ static DEFINE_SPINLOCK(au1xxx_dbdma_spin_lock);
 #define ALIGN_ADDR(x, a)	((((u32)(x)) + (a-1)) & ~(a-1))
 
 static dbdma_global_t *dbdma_gptr = (dbdma_global_t *)DDMA_GLOBAL_BASE;
-static int dbdma_initialized;
-static void au1xxx_dbdma_init(void);
 
 static dbdev_tab_t dbdev_tab[] = {
 #ifdef CONFIG_SOC_AU1550
@@ -239,15 +237,6 @@ u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
 	chan_tab_t	*ctp;
 	au1x_dma_chan_t *cp;
 
-	/*
-	 * We do the intialization on the first channel allocation.
-	 * We have to wait because of the interrupt handler initialization
-	 * which can't be done successfully during board set up.
-	 */
-	if (!dbdma_initialized)
-		au1xxx_dbdma_init();
-	dbdma_initialized = 1;
-
 	stp = find_dbdev_id(srcid);
 	if (stp == NULL)
 		return 0;
@@ -863,9 +852,9 @@ static irqreturn_t dbdma_interrupt(int irq, void *dev_id)
 	return IRQ_RETVAL(1);
 }
 
-static void au1xxx_dbdma_init(void)
+static int __init au1xxx_dbdma_init(void)
 {
-	int irq_nr;
+	int irq_nr, ret;
 
 	dbdma_gptr->ddma_config = 0;
 	dbdma_gptr->ddma_throttle = 0;
@@ -880,10 +869,14 @@ static void au1xxx_dbdma_init(void)
 	#error Unknown Au1x00 SOC
 #endif
 
-	if (request_irq(irq_nr, dbdma_interrupt, IRQF_DISABLED,
-			"Au1xxx dbdma", (void *)dbdma_gptr))
-		printk(KERN_ERR "Can't get 1550 dbdma irq");
+	ret = request_irq(irq_nr, dbdma_interrupt, IRQF_DISABLED,
+			"Au1xxx dbdma", (void *)dbdma_gptr);
+	if (ret)
+		printk(KERN_ERR "Au1xxx dbdma: cannot get IRQ\n");
+
+	return ret;
 }
+subsys_initcall(au1xxx_dbdma_init);
 
 void au1xxx_dbdma_dump(u32 chanid)
 {
-- 
1.5.6.4
