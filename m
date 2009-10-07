Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 20:17:09 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34596 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493547AbZJGSPb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2009 20:15:31 +0200
Received: by ewy12 with SMTP id 12so10566984ewy.0
        for <multiple recipients>; Wed, 07 Oct 2009 11:15:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ac/GYxwsR8Z9IBAXYU2Pez+RfKBWDT9uQ1dPEfxzFlk=;
        b=bXoV2lBM6VQS9R0RVaXLtdLMpsxCJwYbdxmFWilb+ZghfZAgsRFhWE935WQNcYZwBA
         asqPM/TCEXf9b87ymI23JjVCR5iiBESXUHxTRWiZ8uRfoHX49kIPAkd3n/hVjKdmdnCQ
         lUuuc/+aD35dCAy/UKWXGnVmSRm3q3PZg2HVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xWFo2E0i6OB8hUCXCzKKqgLiMZa7lV3EJUdihaaEm6Ix31hnra2fXjuXKRtYo0hU1R
         my2/0Yx2ERRvaqIqNPt2qenQ3zj4zXxoA8czhyRNylDRVQvSm+augHtmwZ9Ej2HUry9b
         FnLYy0Y7Uy00HUGPZ4gpqdrTDLmUVG/Ti6FlA=
Received: by 10.216.86.19 with SMTP id v19mr76364wee.99.1254939325953;
        Wed, 07 Oct 2009 11:15:25 -0700 (PDT)
Received: from localhost.localdomain (p5496B5E8.dip.t-dialin.net [84.150.181.232])
        by mx.google.com with ESMTPS id f13sm94596gvd.21.2009.10.07.11.15.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 11:15:25 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 4/4] Alchemy: Stop IRQ name sharing
Date:	Wed,  7 Oct 2009 20:15:15 +0200
Message-Id: <1254939315-8158-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254939315-8158-4-git-send-email-manuel.lauss@gmail.com>
References: <1254939315-8158-1-git-send-email-manuel.lauss@gmail.com>
 <1254939315-8158-2-git-send-email-manuel.lauss@gmail.com>
 <1254939315-8158-3-git-send-email-manuel.lauss@gmail.com>
 <1254939315-8158-4-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Eliminate the sharing of IRQ names among the differenct Alchemy
variants.  IRQ numbers need no longer be hidden behind a
CONFIG_SOC_AU1XXX symbol: step 1 in my quest to make the Alchemy
code less reliant on a hardcoded subtype.

This patch also renames the GPIO irq number constants. It's really
an interrupt line, NOT a GPIO number!

Code which relied on certain irq numbers to have the same name
across all supported cpu subtypes is changed to determine current
cpu subtype at runtime; in some places this isn't possible so
a "compat" symbol is used.

Run-tested on DB1200.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/dbdma.c                 |   61 ++-
 arch/mips/alchemy/common/dma.c                   |   36 +-
 arch/mips/alchemy/common/irq.c                   |  290 +++++-----
 arch/mips/alchemy/common/platform.c              |    8 +-
 arch/mips/alchemy/common/time.c                  |   35 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   64 ++-
 arch/mips/alchemy/devboards/db1x00/platform.c    |   52 +-
 arch/mips/alchemy/devboards/pb1000/board_setup.c |    2 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    8 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |    6 +-
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    4 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   20 +-
 arch/mips/alchemy/devboards/pb1500/platform.c    |    6 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   10 +-
 arch/mips/alchemy/devboards/pb1550/platform.c    |    8 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |   26 +-
 arch/mips/alchemy/xxs1500/board_setup.c          |   24 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |  674 +++++++++++-----------
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |   76 ++--
 19 files changed, 745 insertions(+), 665 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 19c1c82..fb09489 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -58,7 +59,6 @@ static DEFINE_SPINLOCK(au1xxx_dbdma_spin_lock);
 
 static dbdma_global_t *dbdma_gptr = (dbdma_global_t *)DDMA_GLOBAL_BASE;
 static int dbdma_initialized;
-static void au1xxx_dbdma_init(void);
 
 static dbdev_tab_t dbdev_tab[] = {
 #ifdef CONFIG_SOC_AU1550
@@ -250,8 +250,7 @@ u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
 	 * which can't be done successfully during board set up.
 	 */
 	if (!dbdma_initialized)
-		au1xxx_dbdma_init();
-	dbdma_initialized = 1;
+		return 0;
 
 	stp = find_dbdev_id(srcid);
 	if (stp == NULL)
@@ -868,28 +867,6 @@ static irqreturn_t dbdma_interrupt(int irq, void *dev_id)
 	return IRQ_RETVAL(1);
 }
 
-static void au1xxx_dbdma_init(void)
-{
-	int irq_nr;
-
-	dbdma_gptr->ddma_config = 0;
-	dbdma_gptr->ddma_throttle = 0;
-	dbdma_gptr->ddma_inten = 0xffff;
-	au_sync();
-
-#if defined(CONFIG_SOC_AU1550)
-	irq_nr = AU1550_DDMA_INT;
-#elif defined(CONFIG_SOC_AU1200)
-	irq_nr = AU1200_DDMA_INT;
-#else
-	#error Unknown Au1x00 SOC
-#endif
-
-	if (request_irq(irq_nr, dbdma_interrupt, IRQF_DISABLED,
-			"Au1xxx dbdma", (void *)dbdma_gptr))
-		printk(KERN_ERR "Can't get 1550 dbdma irq");
-}
-
 void au1xxx_dbdma_dump(u32 chanid)
 {
 	chan_tab_t	 *ctp;
@@ -1038,4 +1015,38 @@ void au1xxx_dbdma_resume(void)
 	}
 }
 #endif	/* CONFIG_PM */
+
+static int __init au1xxx_dbdma_init(void)
+{
+	int irq_nr, ret;
+
+	dbdma_gptr->ddma_config = 0;
+	dbdma_gptr->ddma_throttle = 0;
+	dbdma_gptr->ddma_inten = 0xffff;
+	au_sync();
+
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1550:
+		irq_nr = AU1550_DDMA_INT;
+		break;
+	case ALCHEMY_CPU_AU1200:
+		irq_nr = AU1200_DDMA_INT;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = request_irq(irq_nr, dbdma_interrupt, IRQF_DISABLED,
+			"Au1xxx dbdma", (void *)dbdma_gptr);
+	if (ret)
+		printk(KERN_ERR "Cannot grab DBDMA interrupt!\n");
+	else {
+		dbdma_initialized = 1;
+		printk(KERN_INFO "Alchemy DBDMA initialized\n");
+	}
+
+	return ret;
+}
+subsys_initcall(au1xxx_dbdma_init);
+
 #endif /* defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) */
diff --git a/arch/mips/alchemy/common/dma.c b/arch/mips/alchemy/common/dma.c
index d6fbda2..d527887 100644
--- a/arch/mips/alchemy/common/dma.c
+++ b/arch/mips/alchemy/common/dma.c
@@ -29,6 +29,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  */
+
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -188,17 +190,14 @@ int request_au1000_dma(int dev_id, const char *dev_str,
 		dev = &dma_dev_table[dev_id];
 
 	if (irqhandler) {
-		chan->irq = AU1000_DMA_INT_BASE + i;
 		chan->irq_dev = irq_dev_id;
 		ret = request_irq(chan->irq, irqhandler, irqflags, dev_str,
 				  chan->irq_dev);
 		if (ret) {
-			chan->irq = 0;
 			chan->irq_dev = NULL;
 			return ret;
 		}
 	} else {
-		chan->irq = 0;
 		chan->irq_dev = NULL;
 	}
 
@@ -226,13 +225,40 @@ void free_au1000_dma(unsigned int dmanr)
 	}
 
 	disable_dma(dmanr);
-	if (chan->irq)
+	if (chan->irq_dev)
 		free_irq(chan->irq, chan->irq_dev);
 
-	chan->irq = 0;
 	chan->irq_dev = NULL;
 	chan->dev_id = -1;
 }
 EXPORT_SYMBOL(free_au1000_dma);
 
+static int __init au1000_dma_init(void)
+{
+        int base, i;
+
+        switch (alchemy_get_cputype()) {
+        case ALCHEMY_CPU_AU1000:
+                base = AU1000_DMA_INT_BASE;
+                break;
+        case ALCHEMY_CPU_AU1500:
+                base = AU1500_DMA_INT_BASE;
+                break;
+        case ALCHEMY_CPU_AU1100:
+                base = AU1100_DMA_INT_BASE;
+                break;
+        default:
+                goto out;
+        }
+
+        for (i = 0; i < NUM_AU1000_DMA_CHANNELS; i++)
+                au1000_dma_table[i].irq = base + i;
+
+        printk(KERN_INFO "Alchemy DMA initialized\n");
+
+out:
+        return 0;
+}
+arch_initcall(au1000_dma_init);
+
 #endif /* AU1000 AU1500 AU1100 */
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index da53a3b..ab65997 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -53,160 +53,160 @@ struct au1xxx_irqmap {
 	int im_request;		/* set 1 to get higher priority */
 } au1xxx_ic0_map[] __initdata = {
 #if defined(CONFIG_SOC_AU1000)
-	{ AU1000_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_UART2_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_SSI0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_SSI1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+1, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+2, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+3, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+4, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+5, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+6, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+7, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
+	{ AU1000_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_UART2_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_SSI0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_SSI1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_IRDA_TX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_IRDA_RX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
 	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_MAC1_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_AC97C_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1000_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1000_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
 
 #elif defined(CONFIG_SOC_AU1500)
 
-	{ AU1500_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_PCI_INTA, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1000_PCI_INTB, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1500_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_PCI_INTC, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1000_PCI_INTD, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1000_DMA_INT_BASE, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+1, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+2, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+3, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+4, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+5, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+6, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+7, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
-	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1500_MAC1_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_AC97C_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1500_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1500_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_PCI_INTC,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1500_PCI_INTD,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1500_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1500_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
+	{ AU1500_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1500_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1500_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
 
 #elif defined(CONFIG_SOC_AU1100)
 
-	{ AU1100_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1100_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1100_SD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1100_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_SSI0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_SSI1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+1, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+2, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+3, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+4, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+5, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+6, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_DMA_INT_BASE+7, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
-	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1100_LCD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_AC97C_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_SSI0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_SSI1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1100_IRDA_TX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_IRDA_RX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
+	{ AU1100_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1100_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1100_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
 
 #elif defined(CONFIG_SOC_AU1550)
 
-	{ AU1550_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_PCI_INTA, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1550_PCI_INTB, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1550_DDMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_CRYPTO_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_PCI_INTC, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1550_PCI_INTD, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1550_PCI_RST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1550_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_PSC0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_PSC1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_PSC2_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_PSC3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1550_NAND_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
+	{ AU1550_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1550_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1550_DDMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_CRYPTO_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_PCI_INTC,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1550_PCI_INTD,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1550_PCI_RST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1550_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_PSC0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_PSC1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_PSC2_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_PSC3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1550_NAND_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
 	{ AU1550_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
-	{ AU1550_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1550_MAC1_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
+	{ AU1550_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1550_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 
 #elif defined(CONFIG_SOC_AU1200)
 
-	{ AU1200_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_SWT_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_SD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_DDMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_MAE_BE_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_MAE_FE_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_PSC0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_PSC1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_AES_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_CAMERA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1200_NAND_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_USB_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_LCD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1200_MAE_BOTH_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_SWT_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_DDMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_MAE_BE_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_MAE_FE_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_PSC0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_PSC1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_AES_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_CAMERA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1200_NAND_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_USB_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ AU1200_MAE_BOTH_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 
 #else
 #error "Error: Unknown Alchemy SOC"
@@ -316,7 +316,7 @@ static void au1x_ic1_unmask(unsigned int irq_nr)
  * nowhere in the current kernel sources is it disabled.	--mlau
  */
 #if defined(CONFIG_MIPS_PB1000)
-	if (irq_nr == AU1000_GPIO_15)
+	if (irq_nr == AU1000_GPIO15_INT)
 		au_writel(0x4000, PB1000_MDR); /* enable int */
 #endif
 	au_sync();
@@ -366,11 +366,13 @@ static void au1x_ic1_ack(unsigned int irq_nr)
 
 static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
 {
-	unsigned int bit = irq - AU1000_INTC1_INT_BASE;
+	int bit = irq - AU1000_INTC1_INT_BASE;
 	unsigned long wakemsk, flags;
 
-	/* only GPIO 0-7 can act as wakeup source: */
-	if ((irq < AU1000_GPIO_0) || (irq > AU1000_GPIO_7))
+	/* only GPIO 0-7 can act as wakeup source.  Fortunately these
+	 * are wired up identically on all supported variants.
+	 */
+	if ((bit < 0) || (bit > 7))
 		return -EINVAL;
 
 	local_irq_save(flags);
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 2b76a57..5a9a4f9 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -73,8 +73,8 @@ static struct resource au1xxx_usb_ohci_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= AU1000_USB_HOST_INT,
-		.end		= AU1000_USB_HOST_INT,
+		.start		= FOR_PLATFORM_C_USB_HOST_INT,
+		.end		= FOR_PLATFORM_C_USB_HOST_INT,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -132,8 +132,8 @@ static struct resource au1xxx_usb_ehci_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= AU1000_USB_HOST_INT,
-		.end		= AU1000_USB_HOST_INT,
+		.start		= AU1200_USB_INT,
+		.end		= AU1200_USB_INT,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 379a664..2aecb2f 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ * Copyright (C) 2008-2009 Manuel Lauss <manuel.lauss@gmail.com>
  *
  * Previous incarnations were:
  * Copyright (C) 2001, 2006, 2008 MontaVista Software, <source@mvista.com>
@@ -85,7 +85,6 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
 	.name		= "rtcmatch2",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 100,
-	.irq		= AU1000_RTC_MATCH2_INT,
 	.set_next_event	= au1x_rtcmatch2_set_next_event,
 	.set_mode	= au1x_rtcmatch2_set_mode,
 	.cpumask	= cpu_all_mask,
@@ -98,11 +97,13 @@ static struct irqaction au1x_rtcmatch2_irqaction = {
 	.dev_id		= &au1x_rtcmatch2_clockdev,
 };
 
-void __init plat_time_init(void)
+static int __init alchemy_time_init(unsigned int m2int)
 {
 	struct clock_event_device *cd = &au1x_rtcmatch2_clockdev;
 	unsigned long t;
 
+	au1x_rtcmatch2_clockdev.irq = m2int;
+
 	/* Check if firmware (YAMON, ...) has enabled 32kHz and clock
 	 * has been detected.  If so install the rtcmatch2 clocksource,
 	 * otherwise don't bother.  Note that both bits being set is by
@@ -148,13 +149,18 @@ void __init plat_time_init(void)
 	cd->max_delta_ns = clockevent_delta2ns(0xffffffff, cd);
 	cd->min_delta_ns = clockevent_delta2ns(8, cd);	/* ~0.25ms */
 	clockevents_register_device(cd);
-	setup_irq(AU1000_RTC_MATCH2_INT, &au1x_rtcmatch2_irqaction);
+	setup_irq(m2int, &au1x_rtcmatch2_irqaction);
 
 	printk(KERN_INFO "Alchemy clocksource installed\n");
 
-	return;
+	return 0;
 
 cntr_err:
+	return -1;
+}
+
+static void __init alchemy_setup_c0timer(void)
+{
 	/*
 	 * MIPS kernel assigns 'au1k_wait' to 'cpu_wait' before this
 	 * function is called.  Because the Alchemy counters are unusable
@@ -166,3 +172,22 @@ cntr_err:
 	r4k_clockevent_init();
 	init_r4k_clocksource();
 }
+
+static int alchemy_m2inttab[] __initdata = {
+	AU1000_RTC_MATCH2_INT,
+	AU1500_RTC_MATCH2_INT,
+	AU1100_RTC_MATCH2_INT,
+	AU1550_RTC_MATCH2_INT,
+	AU1200_RTC_MATCH2_INT,
+};
+
+void __init plat_time_init(void)
+{
+	int t;
+
+	t = alchemy_get_cputype();
+	if (t == ALCHEMY_CPU_UNKNOWN)
+		alchemy_setup_c0timer();
+	else if (alchemy_time_init(alchemy_m2inttab[t]))
+		alchemy_setup_c0timer();
+}
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 3b228a2..b1f3711 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -39,32 +39,32 @@
 
 #ifdef CONFIG_MIPS_DB1500
 char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - HPT371   */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
+	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - HPT371   */
+	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
 };
 #endif
 
 #ifdef CONFIG_MIPS_BOSPORUS
 char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 11 - miniPCI  */
-	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - SN1741   */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
+	[11] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 11 - miniPCI  */
+	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - SN1741   */
+	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
 };
 #endif
 
 #ifdef CONFIG_MIPS_MIRAGE
 char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, INTD, INTX, INTX, INTX }, /* IDSEL 11 - SMI VGX */
-	[12] = { -1, INTX, INTX, INTC, INTX }, /* IDSEL 12 - PNX1300 */
-	[13] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 13 - miniPCI */
+	[11] = { -1, AU1500_PCI_INTD, 0xff, 0xff, 0xff }, /* IDSEL 11 - SMI VGX */
+	[12] = { -1, 0xff, 0xff, AU1500_PCI_INTC, 0xff }, /* IDSEL 12 - PNX1300 */
+	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 13 - miniPCI */
 };
 #endif
 
 #ifdef CONFIG_MIPS_DB1550
 char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, INTC, INTX, INTX, INTX }, /* IDSEL 11 - on-board HPT371 */
-	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left) */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
+	[11] = { -1, AU1500_PCI_INTC, 0xff, 0xff, 0xff }, /* IDSEL 11 - on-board HPT371 */
+	[12] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD, AU1500_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left) */
+	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
 };
 #endif
 
@@ -185,21 +185,35 @@ void __init board_setup(void)
 static int __init db1x00_init_irq(void)
 {
 #if defined(CONFIG_MIPS_MIRAGE)
-	set_irq_type(AU1000_GPIO_7, IRQF_TRIGGER_RISING); /* TS pendown */
+	set_irq_type(AU1500_GPIO7_INT, IRQF_TRIGGER_RISING); /* TS pendown */
 #elif defined(CONFIG_MIPS_DB1550)
-	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);	/* CD0# */
-	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);	/* CD1# */
-	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);	/* CARD0# */
-	set_irq_type(AU1000_GPIO_5, IRQF_TRIGGER_LOW);	/* CARD1# */
-	set_irq_type(AU1000_GPIO_21, IRQF_TRIGGER_LOW);	/* STSCHG0# */
-	set_irq_type(AU1000_GPIO_22, IRQF_TRIGGER_LOW);	/* STSCHG1# */
-#else
-	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);	/* CD0# */
-	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);	/* CD1# */
-	set_irq_type(AU1000_GPIO_2, IRQF_TRIGGER_LOW);	/* CARD0# */
-	set_irq_type(AU1000_GPIO_5, IRQF_TRIGGER_LOW);	/* CARD1# */
-	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);	/* STSCHG0# */
-	set_irq_type(AU1000_GPIO_4, IRQF_TRIGGER_LOW);	/* STSCHG1# */
+	set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);  /* CD0# */
+	set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);  /* CD1# */
+	set_irq_type(AU1550_GPIO3_INT, IRQF_TRIGGER_LOW);  /* CARD0# */
+	set_irq_type(AU1550_GPIO5_INT, IRQF_TRIGGER_LOW);  /* CARD1# */
+	set_irq_type(AU1550_GPIO21_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	set_irq_type(AU1550_GPIO22_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
+#elif defined(CONFIG_MIPS_DB1500)
+	set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
+	set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
+	set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
+	set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
+	set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
+#elif defined(CONFIG_MIPS_DB1100)
+	set_irq_type(AU1100_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
+	set_irq_type(AU1100_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
+	set_irq_type(AU1100_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
+	set_irq_type(AU1100_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
+	set_irq_type(AU1100_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	set_irq_type(AU1100_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
+#elif defined(CONFIG_MIPS_DB1000)
+	set_irq_type(AU1000_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
+	set_irq_type(AU1000_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
+	set_irq_type(AU1000_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
+	set_irq_type(AU1000_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
+	set_irq_type(AU1000_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	set_irq_type(AU1000_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
 #endif
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index b762b79..0ac5dd0 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -24,32 +24,46 @@
 #include <asm/mach-au1x00/au1xxx.h>
 #include "../platform.h"
 
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || \
-    defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
-#define DB1XXX_HAS_PCMCIA
-#endif
-
 /* DB1xxx PCMCIA interrupt sources:
  * CD0/1 	GPIO0/3
  * STSCHG0/1	GPIO1/4
  * CARD0/1	GPIO2/5
  * Db1550:	0/1, 21/22, 3/5
  */
-#ifndef CONFIG_MIPS_DB1550
-/* Db1000, Db1100, Db1500 */
-#define DB1XXX_PCMCIA_CD0	AU1000_GPIO_0
-#define DB1XXX_PCMCIA_STSCHG0	AU1000_GPIO_1
-#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO_2
-#define DB1XXX_PCMCIA_CD1	AU1000_GPIO_3
-#define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO_4
-#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO_5
+
+#define DB1XXX_HAS_PCMCIA
+
+#if defined(CONFIG_MIPS_DB1000)
+#define DB1XXX_PCMCIA_CD0	AU1000_GPIO0_INT
+#define DB1XXX_PCMCIA_STSCHG0	AU1000_GPIO1_INT
+#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO2_INT
+#define DB1XXX_PCMCIA_CD1	AU1000_GPIO3_INT
+#define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO4_INT
+#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO5_INT
+#elif defined(CONFIG_MIPS_DB1100)
+#define DB1XXX_PCMCIA_CD0	AU1100_GPIO0_INT
+#define DB1XXX_PCMCIA_STSCHG0	AU1100_GPIO1_INT
+#define DB1XXX_PCMCIA_CARD0	AU1100_GPIO2_INT
+#define DB1XXX_PCMCIA_CD1	AU1100_GPIO3_INT
+#define DB1XXX_PCMCIA_STSCHG1	AU1100_GPIO4_INT
+#define DB1XXX_PCMCIA_CARD1	AU1100_GPIO5_INT
+#elif defined(CONFIG_MIPS_DB1500)
+#define DB1XXX_PCMCIA_CD0	AU1500_GPIO0_INT
+#define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO1_INT
+#define DB1XXX_PCMCIA_CARD0	AU1500_GPIO2_INT
+#define DB1XXX_PCMCIA_CD1	AU1500_GPIO3_INT
+#define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO4_INT
+#define DB1XXX_PCMCIA_CARD1	AU1500_GPIO5_INT
+#elif defined(CONFIG_MIPS_DB1550)
+#define DB1XXX_PCMCIA_CD0	AU1550_GPIO0_INT
+#define DB1XXX_PCMCIA_STSCHG0	AU1550_GPIO21_INT
+#define DB1XXX_PCMCIA_CARD0	AU1550_GPIO3_INT
+#define DB1XXX_PCMCIA_CD1	AU1550_GPIO1_INT
+#define DB1XXX_PCMCIA_STSCHG1	AU1550_GPIO22_INT
+#define DB1XXX_PCMCIA_CARD1	AU1550_GPIO5_INT
 #else
-#define DB1XXX_PCMCIA_CD0	AU1000_GPIO_0
-#define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO_21
-#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO_3
-#define DB1XXX_PCMCIA_CD1	AU1000_GPIO_1
-#define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO_22
-#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO_5
+/* other board: no PCMCIA */
+#undef DB1XXX_HAS_PCMCIA
 #endif
 
 static int __init db1xxx_dev_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index f1cafea..287d661 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -186,7 +186,7 @@ void __init board_setup(void)
 
 static int __init pb1000_init_irq(void)
 {
-	set_irq_type(AU1000_GPIO_15, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1000_GPIO15_INT, IRQF_TRIGGER_LOW);
 	return 0;
 }
 arch_initcall(pb1000_init_irq);
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index b282d93..e0bd855 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -147,10 +147,10 @@ void __init board_setup(void)
 
 static int __init pb1100_init_irq(void)
 {
-	set_irq_type(AU1000_GPIO_9,  IRQF_TRIGGER_LOW);	/* PCCD# */
-	set_irq_type(AU1000_GPIO_10, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
-	set_irq_type(AU1000_GPIO_11, IRQF_TRIGGER_LOW); /* PCCard# */
-	set_irq_type(AU1000_GPIO_13, IRQF_TRIGGER_LOW); /* DC_IRQ# */
+	set_irq_type(AU1100_GPIO9_INT,  IRQF_TRIGGER_LOW); /* PCCD# */
+	set_irq_type(AU1100_GPIO10_INT, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
+	set_irq_type(AU1100_GPIO11_INT, IRQF_TRIGGER_LOW); /* PCCard# */
+	set_irq_type(AU1100_GPIO13_INT, IRQF_TRIGGER_LOW); /* DC_IRQ# */
 
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index 8487da5..ec932e7 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -33,9 +33,9 @@ static int __init pb1100_dev_init(void)
 				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
 				    PCMCIA_IO_PSEUDO_PHYS,
 				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
-				    AU1000_GPIO_11,	 /* card */
-				    AU1000_GPIO_9,	 /* insert */
-				    /*AU1000_GPIO_10*/0, /* stschg */
+				    AU1100_GPIO11_INT,	 /* card */
+				    AU1100_GPIO9_INT,	 /* insert */
+				    /*AU1100_GPIO10_INT*/0, /* stschg */
 				    0,			 /* eject */
 				    0);			 /* id */
 	return 0;
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index 76aa652..e709b9e 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -173,8 +173,8 @@ static int __init pb1200_init_irq(void)
 	}
 #endif
 
-	set_irq_type(AU1000_GPIO_7, IRQF_TRIGGER_LOW);
-	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1000_GPIO_7);
+	set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
+	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1200_GPIO7_INT);
 
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index a148802..3f0c92c 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -35,8 +35,8 @@
 
 
 char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
-	[13] = { -1, INTA, INTB, INTC, INTD },   /* IDSEL 13 - PCI slot */
+	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff },   /* IDSEL 12 - HPT370	*/
+	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD },   /* IDSEL 13 - PCI slot */
 };
 
 
@@ -155,14 +155,14 @@ void __init board_setup(void)
 
 static int __init pb1500_init_irq(void)
 {
-	set_irq_type(AU1000_GPIO_9, IRQF_TRIGGER_LOW);	/* CD0# */
-	set_irq_type(AU1000_GPIO_10, IRQF_TRIGGER_LOW);	/* CARD0 */
-	set_irq_type(AU1000_GPIO_11, IRQF_TRIGGER_LOW);	/* STSCHG0# */
-	set_irq_type(AU1500_GPIO_204, IRQF_TRIGGER_HIGH);
-	set_irq_type(AU1500_GPIO_201, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_202, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_203, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_205, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO9_INT, IRQF_TRIGGER_LOW);   /* CD0# */
+	set_irq_type(AU1500_GPIO10_INT, IRQF_TRIGGER_LOW);  /* CARD0 */
+	set_irq_type(AU1500_GPIO11_INT, IRQF_TRIGGER_LOW);  /* STSCHG0# */
+	set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
+	set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
 
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index 6c00cbe..cdce775 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -32,9 +32,9 @@ static int __init pb1500_dev_init(void)
 				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
 				    PCMCIA_IO_PSEUDO_PHYS,
 				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
-				    AU1000_GPIO_11,	 /* card */
-				    AU1000_GPIO_9,	 /* insert */
-				    /*AU1000_GPIO_10*/0, /* stschg */
+				    AU1500_GPIO11_INT,	 /* card */
+				    AU1500_GPIO9_INT,	 /* insert */
+				    /*AU1500_GPIO10_INT*/0, /* stschg */
 				    0,			 /* eject */
 				    0);			 /* id */
 	return 0;
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index 64a6fc4..bb41740 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -39,8 +39,8 @@
 
 
 char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
+	[12] = { -1, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD, AU1550_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
+	[13] = { -1, AU1550_PCI_INTA, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
 };
 
 const char *get_system_type(void)
@@ -89,9 +89,9 @@ void __init board_setup(void)
 
 static int __init pb1550_init_irq(void)
 {
-	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_201_205, IRQF_TRIGGER_HIGH);
+	set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1550_GPIO201_205_INT, IRQF_TRIGGER_HIGH);
 
 	/* enable both PCMCIA card irqs in the shared line */
 	alchemy_gpio2_enable_int(201);
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index aa5016c..b496fb6 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -40,8 +40,8 @@ static int __init pb1550_dev_init(void)
 				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
 				    PCMCIA_IO_PSEUDO_PHYS,
 				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
-				    AU1500_GPIO_201_205,
-				    AU1000_GPIO_0,
+				    AU1550_GPIO201_205_INT,
+				    AU1550_GPIO0_INT,
 				    0,
 				    0,
 				    0);
@@ -52,8 +52,8 @@ static int __init pb1550_dev_init(void)
 				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00840000 - 1,
 				    PCMCIA_IO_PSEUDO_PHYS   + 0x00800000,
 				    PCMCIA_IO_PSEUDO_PHYS   + 0x00801000 - 1,
-				    AU1500_GPIO_201_205,
-				    AU1000_GPIO_1,
+				    AU1550_GPIO201_205_INT,
+				    AU1550_GPIO1_INT,
 				    0,
 				    0,
 				    1);
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 568492c..adc01ea 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -37,14 +37,14 @@
 #include <prom.h>
 
 char irq_tab_alchemy[][5] __initdata = {
-	[0] = { -1, INTA, INTA, INTX, INTX }, /* IDSEL 00 - AdapterA-Slot0 (top) */
-	[1] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
-	[2] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 02 - AdapterB-Slot0 (top) */
-	[3] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
-	[4] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 04 - AdapterC-Slot0 (top) */
-	[5] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
-	[6] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 06 - AdapterD-Slot0 (top) */
-	[7] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
+	[0] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 00 - AdapterA-Slot0 (top) */
+	[1] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
+	[2] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 02 - AdapterB-Slot0 (top) */
+	[3] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
+	[4] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 04 - AdapterC-Slot0 (top) */
+	[5] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
+	[6] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 06 - AdapterD-Slot0 (top) */
+	[7] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
 };
 
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
@@ -125,11 +125,11 @@ mtx1_pci_idsel(unsigned int devsel, int assert)
 
 static int __init mtx1_init_irq(void)
 {
-	set_irq_type(AU1500_GPIO_204, IRQF_TRIGGER_HIGH);
-	set_irq_type(AU1500_GPIO_201, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_202, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_203, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_205, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
+	set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
 
 	return 0;
 }
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index eb31350..21bef8d 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -80,19 +80,19 @@ void __init board_setup(void)
 
 static int __init xxs1500_init_irq(void)
 {
-	set_irq_type(AU1500_GPIO_204, IRQF_TRIGGER_HIGH);
-	set_irq_type(AU1500_GPIO_201, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_202, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_203, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_205, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO_207, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
+	set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO207_INT, IRQF_TRIGGER_LOW);
 
-	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1000_GPIO_2, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1000_GPIO_4, IRQF_TRIGGER_LOW); /* CF interrupt */
-	set_irq_type(AU1000_GPIO_5, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* CF irq */
+	set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW);
 
 	return 0;
 }
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 9174285..16ea5ad 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -173,6 +173,333 @@ void au_sleep(void);
 void save_au1xxx_intctl(void);
 void restore_au1xxx_intctl(void);
 
+
+/* SOC Interrupt numbers */
+
+#define AU1000_INTC0_INT_BASE	(MIPS_CPU_IRQ_BASE + 8)
+#define AU1000_INTC0_INT_LAST	(AU1000_INTC0_INT_BASE + 31)
+#define AU1000_INTC1_INT_BASE	(AU1000_INTC0_INT_LAST + 1)
+#define AU1000_INTC1_INT_LAST	(AU1000_INTC1_INT_BASE + 31)
+#define AU1000_MAX_INTR 	AU1000_INTC1_INT_LAST
+
+enum soc_au1000_ints {
+	AU1000_FIRST_INT	= AU1000_INTC0_INT_BASE,
+	AU1000_UART0_INT	= AU1000_FIRST_INT,
+	AU1000_UART1_INT,
+	AU1000_UART2_INT,
+	AU1000_UART3_INT,
+	AU1000_SSI0_INT,
+	AU1000_SSI1_INT,
+	AU1000_DMA_INT_BASE,
+
+	AU1000_TOY_INT		= AU1000_FIRST_INT + 14,
+	AU1000_TOY_MATCH0_INT,
+	AU1000_TOY_MATCH1_INT,
+	AU1000_TOY_MATCH2_INT,
+	AU1000_RTC_INT,
+	AU1000_RTC_MATCH0_INT,
+	AU1000_RTC_MATCH1_INT,
+	AU1000_RTC_MATCH2_INT,
+	AU1000_IRDA_TX_INT,
+	AU1000_IRDA_RX_INT,
+	AU1000_USB_DEV_REQ_INT,
+	AU1000_USB_DEV_SUS_INT,
+	AU1000_USB_HOST_INT,
+	AU1000_ACSYNC_INT,
+	AU1000_MAC0_DMA_INT,
+	AU1000_MAC1_DMA_INT,
+	AU1000_I2S_UO_INT,
+	AU1000_AC97C_INT,
+	AU1000_GPIO0_INT,
+	AU1000_GPIO1_INT,
+	AU1000_GPIO2_INT,
+	AU1000_GPIO3_INT,
+	AU1000_GPIO4_INT,
+	AU1000_GPIO5_INT,
+	AU1000_GPIO6_INT,
+	AU1000_GPIO7_INT,
+	AU1000_GPIO8_INT,
+	AU1000_GPIO9_INT,
+	AU1000_GPIO10_INT,
+	AU1000_GPIO11_INT,
+	AU1000_GPIO12_INT,
+	AU1000_GPIO13_INT,
+	AU1000_GPIO14_INT,
+	AU1000_GPIO15_INT,
+	AU1000_GPIO16_INT,
+	AU1000_GPIO17_INT,
+	AU1000_GPIO18_INT,
+	AU1000_GPIO19_INT,
+	AU1000_GPIO20_INT,
+	AU1000_GPIO21_INT,
+	AU1000_GPIO22_INT,
+	AU1000_GPIO23_INT,
+	AU1000_GPIO24_INT,
+	AU1000_GPIO25_INT,
+	AU1000_GPIO26_INT,
+	AU1000_GPIO27_INT,
+	AU1000_GPIO28_INT,
+	AU1000_GPIO29_INT,
+	AU1000_GPIO30_INT,
+	AU1000_GPIO31_INT,
+};
+
+enum soc_au1100_ints {
+	AU1100_FIRST_INT	= AU1000_INTC0_INT_BASE,
+	AU1100_UART0_INT	= AU1100_FIRST_INT,
+	AU1100_UART1_INT,
+	AU1100_SD_INT,
+	AU1100_UART3_INT,
+	AU1100_SSI0_INT,
+	AU1100_SSI1_INT,
+	AU1100_DMA_INT_BASE,
+
+	AU1100_TOY_INT		= AU1100_FIRST_INT + 14,
+	AU1100_TOY_MATCH0_INT,
+	AU1100_TOY_MATCH1_INT,
+	AU1100_TOY_MATCH2_INT,
+	AU1100_RTC_INT,
+	AU1100_RTC_MATCH0_INT,
+	AU1100_RTC_MATCH1_INT,
+	AU1100_RTC_MATCH2_INT,
+	AU1100_IRDA_TX_INT,
+	AU1100_IRDA_RX_INT,
+	AU1100_USB_DEV_REQ_INT,
+	AU1100_USB_DEV_SUS_INT,
+	AU1100_USB_HOST_INT,
+	AU1100_ACSYNC_INT,
+	AU1100_MAC0_DMA_INT,
+	AU1100_GPIO208_215_INT,
+	AU1100_LCD_INT,
+	AU1100_AC97C_INT,
+	AU1100_GPIO0_INT,
+	AU1100_GPIO1_INT,
+	AU1100_GPIO2_INT,
+	AU1100_GPIO3_INT,
+	AU1100_GPIO4_INT,
+	AU1100_GPIO5_INT,
+	AU1100_GPIO6_INT,
+	AU1100_GPIO7_INT,
+	AU1100_GPIO8_INT,
+	AU1100_GPIO9_INT,
+	AU1100_GPIO10_INT,
+	AU1100_GPIO11_INT,
+	AU1100_GPIO12_INT,
+	AU1100_GPIO13_INT,
+	AU1100_GPIO14_INT,
+	AU1100_GPIO15_INT,
+	AU1100_GPIO16_INT,
+	AU1100_GPIO17_INT,
+	AU1100_GPIO18_INT,
+	AU1100_GPIO19_INT,
+	AU1100_GPIO20_INT,
+	AU1100_GPIO21_INT,
+	AU1100_GPIO22_INT,
+	AU1100_GPIO23_INT,
+	AU1100_GPIO24_INT,
+	AU1100_GPIO25_INT,
+	AU1100_GPIO26_INT,
+	AU1100_GPIO27_INT,
+	AU1100_GPIO28_INT,
+	AU1100_GPIO29_INT,
+	AU1100_GPIO30_INT,
+	AU1100_GPIO31_INT,
+};
+
+enum soc_au1500_ints {
+	AU1500_FIRST_INT	= AU1000_INTC0_INT_BASE,
+	AU1500_UART0_INT	= AU1500_FIRST_INT,
+	AU1500_PCI_INTA,
+	AU1500_PCI_INTB,
+	AU1500_UART3_INT,
+	AU1500_PCI_INTC,
+	AU1500_PCI_INTD,
+	AU1500_DMA_INT_BASE,
+
+	AU1500_TOY_INT		= AU1500_FIRST_INT + 14,
+	AU1500_TOY_MATCH0_INT,
+	AU1500_TOY_MATCH1_INT,
+	AU1500_TOY_MATCH2_INT,
+	AU1500_RTC_INT,
+	AU1500_RTC_MATCH0_INT,
+	AU1500_RTC_MATCH1_INT,
+	AU1500_RTC_MATCH2_INT,
+	AU1500_PCI_ERR_INT,
+	AU1500_RESERVED_INT,
+	AU1500_USB_DEV_REQ_INT,
+	AU1500_USB_DEV_SUS_INT,
+	AU1500_USB_HOST_INT,
+	AU1500_ACSYNC_INT,
+	AU1500_MAC0_DMA_INT,
+	AU1500_MAC1_DMA_INT,
+	AU1500_AC97C_INT	= AU1500_FIRST_INT + 31,
+	AU1500_GPIO0_INT,
+	AU1500_GPIO1_INT,
+	AU1500_GPIO2_INT,
+	AU1500_GPIO3_INT,
+	AU1500_GPIO4_INT,
+	AU1500_GPIO5_INT,
+	AU1500_GPIO6_INT,
+	AU1500_GPIO7_INT,
+	AU1500_GPIO8_INT,
+	AU1500_GPIO9_INT,
+	AU1500_GPIO10_INT,
+	AU1500_GPIO11_INT,
+	AU1500_GPIO12_INT,
+	AU1500_GPIO13_INT,
+	AU1500_GPIO14_INT,
+	AU1500_GPIO15_INT,
+	AU1500_GPIO200_INT,
+	AU1500_GPIO201_INT,
+	AU1500_GPIO202_INT,
+	AU1500_GPIO203_INT,
+	AU1500_GPIO20_INT,
+	AU1500_GPIO204_INT,
+	AU1500_GPIO205_INT,
+	AU1500_GPIO23_INT,
+	AU1500_GPIO24_INT,
+	AU1500_GPIO25_INT,
+	AU1500_GPIO26_INT,
+	AU1500_GPIO27_INT,
+	AU1500_GPIO28_INT,
+	AU1500_GPIO206_INT,
+	AU1500_GPIO207_INT,
+	AU1500_GPIO208_215_INT,
+};
+
+enum soc_au1550_ints {
+	AU1550_FIRST_INT	= AU1000_INTC0_INT_BASE,
+	AU1550_UART0_INT	= AU1550_FIRST_INT,
+	AU1550_PCI_INTA,
+	AU1550_PCI_INTB,
+	AU1550_DDMA_INT,
+	AU1550_CRYPTO_INT,
+	AU1550_PCI_INTC,
+	AU1550_PCI_INTD,
+	AU1550_PCI_RST_INT,
+	AU1550_UART1_INT,
+	AU1550_UART3_INT,
+	AU1550_PSC0_INT,
+	AU1550_PSC1_INT,
+	AU1550_PSC2_INT,
+	AU1550_PSC3_INT,
+	AU1550_TOY_INT,
+	AU1550_TOY_MATCH0_INT,
+	AU1550_TOY_MATCH1_INT,
+	AU1550_TOY_MATCH2_INT,
+	AU1550_RTC_INT,
+	AU1550_RTC_MATCH0_INT,
+	AU1550_RTC_MATCH1_INT,
+	AU1550_RTC_MATCH2_INT,
+
+	AU1550_NAND_INT		= AU1550_FIRST_INT + 23,
+	AU1550_USB_DEV_REQ_INT,
+	AU1550_USB_DEV_SUS_INT,
+	AU1550_USB_HOST_INT,
+	AU1550_MAC0_DMA_INT,
+	AU1550_MAC1_DMA_INT,
+	AU1550_GPIO0_INT	= AU1550_FIRST_INT + 32,
+	AU1550_GPIO1_INT,
+	AU1550_GPIO2_INT,
+	AU1550_GPIO3_INT,
+	AU1550_GPIO4_INT,
+	AU1550_GPIO5_INT,
+	AU1550_GPIO6_INT,
+	AU1550_GPIO7_INT,
+	AU1550_GPIO8_INT,
+	AU1550_GPIO9_INT,
+	AU1550_GPIO10_INT,
+	AU1550_GPIO11_INT,
+	AU1550_GPIO12_INT,
+	AU1550_GPIO13_INT,
+	AU1550_GPIO14_INT,
+	AU1550_GPIO15_INT,
+	AU1550_GPIO200_INT,
+	AU1550_GPIO201_205_INT,	/* Logical or of GPIO201:205 */
+	AU1550_GPIO16_INT,
+	AU1550_GPIO17_INT,
+	AU1550_GPIO20_INT,
+	AU1550_GPIO21_INT,
+	AU1550_GPIO22_INT,
+	AU1550_GPIO23_INT,
+	AU1550_GPIO24_INT,
+	AU1550_GPIO25_INT,
+	AU1550_GPIO26_INT,
+	AU1550_GPIO27_INT,
+	AU1550_GPIO28_INT,
+	AU1550_GPIO206_INT,
+	AU1550_GPIO207_INT,
+	AU1550_GPIO208_215_INT,	/* Logical or of GPIO208:215 */
+};
+
+enum soc_au1200_ints {
+	AU1200_FIRST_INT	= AU1000_INTC0_INT_BASE,
+	AU1200_UART0_INT	= AU1200_FIRST_INT,
+	AU1200_SWT_INT,
+	AU1200_SD_INT,
+	AU1200_DDMA_INT,
+	AU1200_MAE_BE_INT,
+	AU1200_GPIO200_INT,
+	AU1200_GPIO201_INT,
+	AU1200_GPIO202_INT,
+	AU1200_UART1_INT,
+	AU1200_MAE_FE_INT,
+	AU1200_PSC0_INT,
+	AU1200_PSC1_INT,
+	AU1200_AES_INT,
+	AU1200_CAMERA_INT,
+	AU1200_TOY_INT,
+	AU1200_TOY_MATCH0_INT,
+	AU1200_TOY_MATCH1_INT,
+	AU1200_TOY_MATCH2_INT,
+	AU1200_RTC_INT,
+	AU1200_RTC_MATCH0_INT,
+	AU1200_RTC_MATCH1_INT,
+	AU1200_RTC_MATCH2_INT,
+	AU1200_GPIO203_INT,
+	AU1200_NAND_INT,
+	AU1200_GPIO204_INT,
+	AU1200_GPIO205_INT,
+	AU1200_GPIO206_INT,
+	AU1200_GPIO207_INT,
+	AU1200_GPIO208_215_INT,	/* Logical OR of 208:215 */
+	AU1200_USB_INT,
+	AU1200_LCD_INT,
+	AU1200_MAE_BOTH_INT,
+	AU1200_GPIO0_INT,
+	AU1200_GPIO1_INT,
+	AU1200_GPIO2_INT,
+	AU1200_GPIO3_INT,
+	AU1200_GPIO4_INT,
+	AU1200_GPIO5_INT,
+	AU1200_GPIO6_INT,
+	AU1200_GPIO7_INT,
+	AU1200_GPIO8_INT,
+	AU1200_GPIO9_INT,
+	AU1200_GPIO10_INT,
+	AU1200_GPIO11_INT,
+	AU1200_GPIO12_INT,
+	AU1200_GPIO13_INT,
+	AU1200_GPIO14_INT,
+	AU1200_GPIO15_INT,
+	AU1200_GPIO16_INT,
+	AU1200_GPIO17_INT,
+	AU1200_GPIO18_INT,
+	AU1200_GPIO19_INT,
+	AU1200_GPIO20_INT,
+	AU1200_GPIO21_INT,
+	AU1200_GPIO22_INT,
+	AU1200_GPIO23_INT,
+	AU1200_GPIO24_INT,
+	AU1200_GPIO25_INT,
+	AU1200_GPIO26_INT,
+	AU1200_GPIO27_INT,
+	AU1200_GPIO28_INT,
+	AU1200_GPIO29_INT,
+	AU1200_GPIO30_INT,
+	AU1200_GPIO31_INT,
+};
+
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 /*
@@ -564,70 +891,9 @@ void restore_au1xxx_intctl(void);
 
 #define IC1_TESTBIT		0xB1800080
 
-/* Interrupt Numbers */
+
 /* Au1000 */
 #ifdef CONFIG_SOC_AU1000
-enum soc_au1000_ints {
-	AU1000_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
-	AU1000_UART0_INT	= AU1000_FIRST_INT,
-	AU1000_UART1_INT,				/* au1000 */
-	AU1000_UART2_INT,				/* au1000 */
-	AU1000_UART3_INT,
-	AU1000_SSI0_INT,				/* au1000 */
-	AU1000_SSI1_INT,				/* au1000 */
-	AU1000_DMA_INT_BASE,
-
-	AU1000_TOY_INT		= AU1000_FIRST_INT + 14,
-	AU1000_TOY_MATCH0_INT,
-	AU1000_TOY_MATCH1_INT,
-	AU1000_TOY_MATCH2_INT,
-	AU1000_RTC_INT,
-	AU1000_RTC_MATCH0_INT,
-	AU1000_RTC_MATCH1_INT,
-	AU1000_RTC_MATCH2_INT,
-	AU1000_IRDA_TX_INT,				/* au1000 */
-	AU1000_IRDA_RX_INT,				/* au1000 */
-	AU1000_USB_DEV_REQ_INT,
-	AU1000_USB_DEV_SUS_INT,
-	AU1000_USB_HOST_INT,
-	AU1000_ACSYNC_INT,
-	AU1000_MAC0_DMA_INT,
-	AU1000_MAC1_DMA_INT,
-	AU1000_I2S_UO_INT,				/* au1000 */
-	AU1000_AC97C_INT,
-	AU1000_GPIO_0,
-	AU1000_GPIO_1,
-	AU1000_GPIO_2,
-	AU1000_GPIO_3,
-	AU1000_GPIO_4,
-	AU1000_GPIO_5,
-	AU1000_GPIO_6,
-	AU1000_GPIO_7,
-	AU1000_GPIO_8,
-	AU1000_GPIO_9,
-	AU1000_GPIO_10,
-	AU1000_GPIO_11,
-	AU1000_GPIO_12,
-	AU1000_GPIO_13,
-	AU1000_GPIO_14,
-	AU1000_GPIO_15,
-	AU1000_GPIO_16,
-	AU1000_GPIO_17,
-	AU1000_GPIO_18,
-	AU1000_GPIO_19,
-	AU1000_GPIO_20,
-	AU1000_GPIO_21,
-	AU1000_GPIO_22,
-	AU1000_GPIO_23,
-	AU1000_GPIO_24,
-	AU1000_GPIO_25,
-	AU1000_GPIO_26,
-	AU1000_GPIO_27,
-	AU1000_GPIO_28,
-	AU1000_GPIO_29,
-	AU1000_GPIO_30,
-	AU1000_GPIO_31,
-};
 
 #define UART0_ADDR		0xB1100000
 #define UART1_ADDR		0xB1200000
@@ -636,6 +902,7 @@ enum soc_au1000_ints {
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
+#define FOR_PLATFORM_C_USB_HOST_INT AU1000_USB_HOST_INT
 
 #define AU1000_ETH0_BASE	0xB0500000
 #define AU1000_ETH1_BASE	0xB0510000
@@ -646,78 +913,13 @@ enum soc_au1000_ints {
 
 /* Au1500 */
 #ifdef CONFIG_SOC_AU1500
-enum soc_au1500_ints {
-	AU1500_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
-	AU1500_UART0_INT	= AU1500_FIRST_INT,
-	AU1000_PCI_INTA,				/* au1500 */
-	AU1000_PCI_INTB,				/* au1500 */
-	AU1500_UART3_INT,
-	AU1000_PCI_INTC,				/* au1500 */
-	AU1000_PCI_INTD,				/* au1500 */
-	AU1000_DMA_INT_BASE,
-
-	AU1000_TOY_INT		= AU1500_FIRST_INT + 14,
-	AU1000_TOY_MATCH0_INT,
-	AU1000_TOY_MATCH1_INT,
-	AU1000_TOY_MATCH2_INT,
-	AU1000_RTC_INT,
-	AU1000_RTC_MATCH0_INT,
-	AU1000_RTC_MATCH1_INT,
-	AU1000_RTC_MATCH2_INT,
-	AU1500_PCI_ERR_INT,
-	AU1500_RESERVED_INT,
-	AU1000_USB_DEV_REQ_INT,
-	AU1000_USB_DEV_SUS_INT,
-	AU1000_USB_HOST_INT,
-	AU1000_ACSYNC_INT,
-	AU1500_MAC0_DMA_INT,
-	AU1500_MAC1_DMA_INT,
-	AU1000_AC97C_INT	= AU1500_FIRST_INT + 31,
-	AU1000_GPIO_0,
-	AU1000_GPIO_1,
-	AU1000_GPIO_2,
-	AU1000_GPIO_3,
-	AU1000_GPIO_4,
-	AU1000_GPIO_5,
-	AU1000_GPIO_6,
-	AU1000_GPIO_7,
-	AU1000_GPIO_8,
-	AU1000_GPIO_9,
-	AU1000_GPIO_10,
-	AU1000_GPIO_11,
-	AU1000_GPIO_12,
-	AU1000_GPIO_13,
-	AU1000_GPIO_14,
-	AU1000_GPIO_15,
-	AU1500_GPIO_200,
-	AU1500_GPIO_201,
-	AU1500_GPIO_202,
-	AU1500_GPIO_203,
-	AU1500_GPIO_20,
-	AU1500_GPIO_204,
-	AU1500_GPIO_205,
-	AU1500_GPIO_23,
-	AU1500_GPIO_24,
-	AU1500_GPIO_25,
-	AU1500_GPIO_26,
-	AU1500_GPIO_27,
-	AU1500_GPIO_28,
-	AU1500_GPIO_206,
-	AU1500_GPIO_207,
-	AU1500_GPIO_208_215,
-};
-
-/* shortcuts */
-#define INTA AU1000_PCI_INTA
-#define INTB AU1000_PCI_INTB
-#define INTC AU1000_PCI_INTC
-#define INTD AU1000_PCI_INTD
 
 #define UART0_ADDR		0xB1100000
 #define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017fffc
+#define FOR_PLATFORM_C_USB_HOST_INT AU1500_USB_HOST_INT
 
 #define AU1500_ETH0_BASE	0xB1500000
 #define AU1500_ETH1_BASE	0xB1510000
@@ -728,67 +930,6 @@ enum soc_au1500_ints {
 
 /* Au1100 */
 #ifdef CONFIG_SOC_AU1100
-enum soc_au1100_ints {
-	AU1100_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
-	AU1100_UART0_INT	= AU1100_FIRST_INT,
-	AU1100_UART1_INT,
-	AU1100_SD_INT,
-	AU1100_UART3_INT,
-	AU1000_SSI0_INT,
-	AU1000_SSI1_INT,
-	AU1000_DMA_INT_BASE,
-
-	AU1000_TOY_INT		= AU1100_FIRST_INT + 14,
-	AU1000_TOY_MATCH0_INT,
-	AU1000_TOY_MATCH1_INT,
-	AU1000_TOY_MATCH2_INT,
-	AU1000_RTC_INT,
-	AU1000_RTC_MATCH0_INT,
-	AU1000_RTC_MATCH1_INT,
-	AU1000_RTC_MATCH2_INT,
-	AU1000_IRDA_TX_INT,
-	AU1000_IRDA_RX_INT,
-	AU1000_USB_DEV_REQ_INT,
-	AU1000_USB_DEV_SUS_INT,
-	AU1000_USB_HOST_INT,
-	AU1000_ACSYNC_INT,
-	AU1100_MAC0_DMA_INT,
-	AU1100_GPIO_208_215,
-	AU1100_LCD_INT,
-	AU1000_AC97C_INT,
-	AU1000_GPIO_0,
-	AU1000_GPIO_1,
-	AU1000_GPIO_2,
-	AU1000_GPIO_3,
-	AU1000_GPIO_4,
-	AU1000_GPIO_5,
-	AU1000_GPIO_6,
-	AU1000_GPIO_7,
-	AU1000_GPIO_8,
-	AU1000_GPIO_9,
-	AU1000_GPIO_10,
-	AU1000_GPIO_11,
-	AU1000_GPIO_12,
-	AU1000_GPIO_13,
-	AU1000_GPIO_14,
-	AU1000_GPIO_15,
-	AU1000_GPIO_16,
-	AU1000_GPIO_17,
-	AU1000_GPIO_18,
-	AU1000_GPIO_19,
-	AU1000_GPIO_20,
-	AU1000_GPIO_21,
-	AU1000_GPIO_22,
-	AU1000_GPIO_23,
-	AU1000_GPIO_24,
-	AU1000_GPIO_25,
-	AU1000_GPIO_26,
-	AU1000_GPIO_27,
-	AU1000_GPIO_28,
-	AU1000_GPIO_29,
-	AU1000_GPIO_30,
-	AU1000_GPIO_31,
-};
 
 #define UART0_ADDR		0xB1100000
 #define UART1_ADDR		0xB1200000
@@ -796,6 +937,7 @@ enum soc_au1100_ints {
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
+#define FOR_PLATFORM_C_USB_HOST_INT AU1100_USB_HOST_INT
 
 #define AU1100_ETH0_BASE	0xB0500000
 #define AU1100_MAC0_ENABLE	0xB0520000
@@ -803,80 +945,6 @@ enum soc_au1100_ints {
 #endif /* CONFIG_SOC_AU1100 */
 
 #ifdef CONFIG_SOC_AU1550
-enum soc_au1550_ints {
-	AU1550_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
-	AU1550_UART0_INT	= AU1550_FIRST_INT,
-	AU1550_PCI_INTA,
-	AU1550_PCI_INTB,
-	AU1550_DDMA_INT,
-	AU1550_CRYPTO_INT,
-	AU1550_PCI_INTC,
-	AU1550_PCI_INTD,
-	AU1550_PCI_RST_INT,
-	AU1550_UART1_INT,
-	AU1550_UART3_INT,
-	AU1550_PSC0_INT,
-	AU1550_PSC1_INT,
-	AU1550_PSC2_INT,
-	AU1550_PSC3_INT,
-	AU1000_TOY_INT,
-	AU1000_TOY_MATCH0_INT,
-	AU1000_TOY_MATCH1_INT,
-	AU1000_TOY_MATCH2_INT,
-	AU1000_RTC_INT,
-	AU1000_RTC_MATCH0_INT,
-	AU1000_RTC_MATCH1_INT,
-	AU1000_RTC_MATCH2_INT,
-
-	AU1550_NAND_INT			= AU1550_FIRST_INT + 23,
-	AU1550_USB_DEV_REQ_INT,
-	AU1000_USB_DEV_REQ_INT		= AU1550_USB_DEV_REQ_INT,
-	AU1550_USB_DEV_SUS_INT,
-	AU1000_USB_DEV_SUS_INT		= AU1550_USB_DEV_SUS_INT,
-	AU1550_USB_HOST_INT,
-	AU1000_USB_HOST_INT		= AU1550_USB_HOST_INT,
-	AU1550_MAC0_DMA_INT,
-	AU1550_MAC1_DMA_INT,
-	AU1000_GPIO_0			= AU1550_FIRST_INT + 32,
-	AU1000_GPIO_1,
-	AU1000_GPIO_2,
-	AU1000_GPIO_3,
-	AU1000_GPIO_4,
-	AU1000_GPIO_5,
-	AU1000_GPIO_6,
-	AU1000_GPIO_7,
-	AU1000_GPIO_8,
-	AU1000_GPIO_9,
-	AU1000_GPIO_10,
-	AU1000_GPIO_11,
-	AU1000_GPIO_12,
-	AU1000_GPIO_13,
-	AU1000_GPIO_14,
-	AU1000_GPIO_15,
-	AU1550_GPIO_200,
-	AU1500_GPIO_201_205,			/* Logical or of GPIO201:205 */
-	AU1500_GPIO_16,
-	AU1500_GPIO_17,
-	AU1500_GPIO_20,
-	AU1500_GPIO_21,
-	AU1500_GPIO_22,
-	AU1500_GPIO_23,
-	AU1500_GPIO_24,
-	AU1500_GPIO_25,
-	AU1500_GPIO_26,
-	AU1500_GPIO_27,
-	AU1500_GPIO_28,
-	AU1500_GPIO_206,
-	AU1500_GPIO_207,
-	AU1500_GPIO_208_218,			/* Logical or of GPIO208:218 */
-};
-
-/* shortcuts */
-#define INTA AU1550_PCI_INTA
-#define INTB AU1550_PCI_INTB
-#define INTC AU1550_PCI_INTC
-#define INTD AU1550_PCI_INTD
-
 #define UART0_ADDR		0xB1100000
 #define UART1_ADDR		0xB1200000
 #define UART3_ADDR		0xB1400000
@@ -884,6 +952,7 @@ enum soc_au1550_ints {
 #define USB_OHCI_BASE		0x14020000	/* phys addr for ioremap */
 #define USB_OHCI_LEN		0x00060000
 #define USB_HOST_CONFIG 	0xB4027ffc
+#define FOR_PLATFORM_C_USB_HOST_INT AU1550_USB_HOST_INT
 
 #define AU1550_ETH0_BASE	0xB0500000
 #define AU1550_ETH1_BASE	0xB0510000
@@ -892,75 +961,8 @@ enum soc_au1550_ints {
 #define NUM_ETH_INTERFACES 2
 #endif /* CONFIG_SOC_AU1550 */
 
+
 #ifdef CONFIG_SOC_AU1200
-enum soc_au1200_ints {
-	AU1200_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
-	AU1200_UART0_INT	= AU1200_FIRST_INT,
-	AU1200_SWT_INT,
-	AU1200_SD_INT,
-	AU1200_DDMA_INT,
-	AU1200_MAE_BE_INT,
-	AU1200_GPIO_200,
-	AU1200_GPIO_201,
-	AU1200_GPIO_202,
-	AU1200_UART1_INT,
-	AU1200_MAE_FE_INT,
-	AU1200_PSC0_INT,
-	AU1200_PSC1_INT,
-	AU1200_AES_INT,
-	AU1200_CAMERA_INT,
-	AU1000_TOY_INT,
-	AU1000_TOY_MATCH0_INT,
-	AU1000_TOY_MATCH1_INT,
-	AU1000_TOY_MATCH2_INT,
-	AU1000_RTC_INT,
-	AU1000_RTC_MATCH0_INT,
-	AU1000_RTC_MATCH1_INT,
-	AU1000_RTC_MATCH2_INT,
-	AU1200_GPIO_203,
-	AU1200_NAND_INT,
-	AU1200_GPIO_204,
-	AU1200_GPIO_205,
-	AU1200_GPIO_206,
-	AU1200_GPIO_207,
-	AU1200_GPIO_208_215,			/* Logical OR of 208:215 */
-	AU1200_USB_INT,
-	AU1000_USB_HOST_INT	= AU1200_USB_INT,
-	AU1200_LCD_INT,
-	AU1200_MAE_BOTH_INT,
-	AU1000_GPIO_0,
-	AU1000_GPIO_1,
-	AU1000_GPIO_2,
-	AU1000_GPIO_3,
-	AU1000_GPIO_4,
-	AU1000_GPIO_5,
-	AU1000_GPIO_6,
-	AU1000_GPIO_7,
-	AU1000_GPIO_8,
-	AU1000_GPIO_9,
-	AU1000_GPIO_10,
-	AU1000_GPIO_11,
-	AU1000_GPIO_12,
-	AU1000_GPIO_13,
-	AU1000_GPIO_14,
-	AU1000_GPIO_15,
-	AU1000_GPIO_16,
-	AU1000_GPIO_17,
-	AU1000_GPIO_18,
-	AU1000_GPIO_19,
-	AU1000_GPIO_20,
-	AU1000_GPIO_21,
-	AU1000_GPIO_22,
-	AU1000_GPIO_23,
-	AU1000_GPIO_24,
-	AU1000_GPIO_25,
-	AU1000_GPIO_26,
-	AU1000_GPIO_27,
-	AU1000_GPIO_28,
-	AU1000_GPIO_29,
-	AU1000_GPIO_30,
-	AU1000_GPIO_31,
-};
 
 #define UART0_ADDR		0xB1100000
 #define UART1_ADDR		0xB1200000
@@ -989,15 +991,9 @@ enum soc_au1200_ints {
 #define USBMSRMCFG_RDCOMB	30
 #define USBMSRMCFG_PFEN 	31
 
-#endif /* CONFIG_SOC_AU1200 */
+#define FOR_PLATFORM_C_USB_HOST_INT AU1200_USB_INT
 
-#define AU1000_INTC0_INT_BASE	(MIPS_CPU_IRQ_BASE + 8)
-#define AU1000_INTC0_INT_LAST	(AU1000_INTC0_INT_BASE + 31)
-#define AU1000_INTC1_INT_BASE	(AU1000_INTC0_INT_BASE + 32)
-#define AU1000_INTC1_INT_LAST	(AU1000_INTC1_INT_BASE + 31)
-
-#define AU1000_MAX_INTR 	AU1000_INTC1_INT_LAST
-#define INTX			0xFF			/* not valid */
+#endif /* CONFIG_SOC_AU1200 */
 
 /* Programmable Counters 0 and 1 */
 #define SYS_BASE		0xB1900000
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index feea001..9cf32d9 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -35,15 +35,13 @@ static inline int au1000_gpio2_to_irq(int gpio)
 	return -ENXIO;
 }
 
-#ifdef CONFIG_SOC_AU1000
 static inline int au1000_irq_to_gpio(int irq)
 {
-	if ((irq >= AU1000_GPIO_0) && (irq <= AU1000_GPIO_31))
-		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	if ((irq >= AU1000_GPIO0_INT) && (irq <= AU1000_GPIO31_INT))
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO0_INT) + 0;
 
 	return -ENXIO;
 }
-#endif
 
 static inline int au1500_gpio1_to_irq(int gpio)
 {
@@ -71,27 +69,25 @@ static inline int au1500_gpio2_to_irq(int gpio)
 	return -ENXIO;
 }
 
-#ifdef CONFIG_SOC_AU1500
 static inline int au1500_irq_to_gpio(int irq)
 {
 	switch (irq) {
-	case AU1000_GPIO_0 ... AU1000_GPIO_15:
-	case AU1500_GPIO_20:
-	case AU1500_GPIO_23 ... AU1500_GPIO_28:
-		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
-	case AU1500_GPIO_200 ... AU1500_GPIO_203:
-		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_200) + 0;
-	case AU1500_GPIO_204 ... AU1500_GPIO_205:
-		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_204) + 4;
-	case AU1500_GPIO_206 ... AU1500_GPIO_207:
-		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
-	case AU1500_GPIO_208_215:
+	case AU1500_GPIO0_INT ... AU1500_GPIO15_INT:
+	case AU1500_GPIO20_INT:
+	case AU1500_GPIO23_INT ... AU1500_GPIO28_INT:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1500_GPIO0_INT) + 0;
+	case AU1500_GPIO200_INT ... AU1500_GPIO203_INT:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO200_INT) + 0;
+	case AU1500_GPIO204_INT ... AU1500_GPIO205_INT:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO204_INT) + 4;
+	case AU1500_GPIO206_INT ... AU1500_GPIO207_INT:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO206_INT) + 6;
+	case AU1500_GPIO208_215_INT:
 		return ALCHEMY_GPIO2_BASE + 8;
 	}
 
 	return -ENXIO;
 }
-#endif
 
 static inline int au1100_gpio1_to_irq(int gpio)
 {
@@ -104,21 +100,21 @@ static inline int au1100_gpio2_to_irq(int gpio)
 
 	if ((gpio >= 8) && (gpio <= 15))
 		return MAKE_IRQ(0, 29);		/* shared GPIO208_215 */
+
+	return -ENXIO;
 }
 
-#ifdef CONFIG_SOC_AU1100
 static inline int au1100_irq_to_gpio(int irq)
 {
 	switch (irq) {
-	case AU1000_GPIO_0 ... AU1000_GPIO_31:
-		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
-	case AU1100_GPIO_208_215:
+	case AU1100_GPIO0_INT ... AU1100_GPIO31_INT:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1100_GPIO0_INT) + 0;
+	case AU1100_GPIO208_215_INT:
 		return ALCHEMY_GPIO2_BASE + 8;
 	}
 
 	return -ENXIO;
 }
-#endif
 
 static inline int au1550_gpio1_to_irq(int gpio)
 {
@@ -147,24 +143,22 @@ static inline int au1550_gpio2_to_irq(int gpio)
 	return -ENXIO;
 }
 
-#ifdef CONFIG_SOC_AU1550
 static inline int au1550_irq_to_gpio(int irq)
 {
 	switch (irq) {
-	case AU1000_GPIO_0 ... AU1000_GPIO_15:
-		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
-	case AU1550_GPIO_200:
-	case AU1500_GPIO_201_205:
-		return ALCHEMY_GPIO2_BASE + (irq - AU1550_GPIO_200) + 0;
-	case AU1500_GPIO_16 ... AU1500_GPIO_28:
-		return ALCHEMY_GPIO1_BASE + (irq - AU1500_GPIO_16) + 16;
-	case AU1500_GPIO_206 ... AU1500_GPIO_208_218:
-		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
+	case AU1550_GPIO0_INT ... AU1550_GPIO15_INT:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1550_GPIO0_INT) + 0;
+	case AU1550_GPIO200_INT:
+	case AU1550_GPIO201_205_INT:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1550_GPIO200_INT) + 0;
+	case AU1550_GPIO16_INT ... AU1550_GPIO28_INT:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1550_GPIO16_INT) + 16;
+	case AU1550_GPIO206_INT ... AU1550_GPIO208_215_INT:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1550_GPIO206_INT) + 6;
 	}
 
 	return -ENXIO;
 }
-#endif
 
 static inline int au1200_gpio1_to_irq(int gpio)
 {
@@ -185,23 +179,21 @@ static inline int au1200_gpio2_to_irq(int gpio)
 	return -ENXIO;
 }
 
-#ifdef CONFIG_SOC_AU1200
 static inline int au1200_irq_to_gpio(int irq)
 {
 	switch (irq) {
-	case AU1000_GPIO_0 ... AU1000_GPIO_31:
-		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
-	case AU1200_GPIO_200 ... AU1200_GPIO_202:
-		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_200) + 0;
-	case AU1200_GPIO_203:
+	case AU1200_GPIO0_INT ... AU1200_GPIO31_INT:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1200_GPIO0_INT) + 0;
+	case AU1200_GPIO200_INT ... AU1200_GPIO202_INT:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO200_INT) + 0;
+	case AU1200_GPIO203_INT:
 		return ALCHEMY_GPIO2_BASE + 3;
-	case AU1200_GPIO_204 ... AU1200_GPIO_208_215:
-		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_204) + 4;
+	case AU1200_GPIO204_INT ... AU1200_GPIO208_215_INT:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO204_INT) + 4;
 	}
 
 	return -ENXIO;
 }
-#endif
 
 /*
  * GPIO1 block macros for common linux gpio functions.
-- 
1.6.5.rc2
