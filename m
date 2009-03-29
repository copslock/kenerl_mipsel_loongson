Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 10:47:17 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:4047 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023479AbZC2JrK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 10:47:10 +0100
Received: (qmail 22431 invoked from network); 29 Mar 2009 11:46:22 +0200
Received: from flagship.roarinelk.net (HELO flagship) (192.168.0.197)
  by fnoeppeil48.netpark.at with SMTP; 29 Mar 2009 11:46:22 +0200
Received: by flagship (sSMTP sendmail emulation); Sun, 29 Mar 2009 11:47:06 +0200
From:	omelinux.net
To:	alsa-devel <alsa-devel@alsa-project.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Charles Eidsness <charles@cooper-street.com>
Subject: [PATCH] ALSA: au1x00: convert to platform device
Date:	Sun, 29 Mar 2009 11:47:06 +0200
Message-Id: <1238320026-4936-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Make sound/mips/au1x00.c a proper platform_driver.

Cc: Charles Eidsness <charles@cooper-street.com>
Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
Compile-tested only; I don't have the right hardware to test this.

Charles: If you still have access to the hardware, could you please test
this patch?  Just add something like the following to your board's
platform device registration:


#include <asm/mach-au1x00/au1000_dma.h>
static struct resource au1xxx_ac97c_res[] = {
       [0] = {
               .start  = AC97_PHYS_ADDR,
               .end    = AC97_PHYS_ADDR + 0xfff,
               .flags  = IORESOURCE_MEM,
       },
       [1] = {
               .start  = AU1000_AC97C_INT,
               .end    = AU1000_AC97C_INT,
               .flags  = IORESOURCE_IRQ,  
       },
       [2] = {
               .start  = DMA_ID_AC97C_TX,
               .end    = DMA_ID_AC97C_TX,
               .flags  = IORESOURCE_DMA, 
       },
       [3] = {
               .start  = DMA_ID_AC97C_RX,
               .end    = DMA_ID_AC97C_RX,
               .flags  = IORESOURCE_DMA, 
       },
};
  
static struct platform_device au1xxx_ac97c_device = {
       .name           = "au1000-ac97c",
       .id             = -1,
       .resource       = au1xxx_ac97c_res,
       .num_resources  = ARRAY_SIZE(au1xxx_ac97c_res),
};

and register the au1xxx_ac97c_device.

Thank you!

 sound/mips/au1x00.c |  244 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 147 insertions(+), 97 deletions(-)

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 3e763d6..11b5865 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -37,6 +37,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -97,6 +98,7 @@ struct snd_au1000 {
 
 	struct snd_pcm *pcm;
 	struct audio_stream *stream[2];	/* playback & capture */
+	int dmaid[2];		/* tx(0)/rx(1) DMA ids */
 };
 
 /*--------------------------- Local Functions --------------------------------*/
@@ -464,13 +466,13 @@ snd_au1000_pcm_new(struct snd_au1000 *au1000)
 	spin_lock_init(&au1000->stream[CAPTURE]->dma_lock);
 
 	flags = claim_dma_lock();
-	if ((au1000->stream[PLAYBACK]->dma = request_au1000_dma(DMA_ID_AC97C_TX,
+	if ((au1000->stream[PLAYBACK]->dma = request_au1000_dma(au1000->dmaid[0],
 			"AC97 TX", au1000_dma_interrupt, IRQF_DISABLED,
 			au1000->stream[PLAYBACK])) < 0) {
 		release_dma_lock(flags);
 		return -EBUSY;
 	}
-	if ((au1000->stream[CAPTURE]->dma = request_au1000_dma(DMA_ID_AC97C_RX,
+	if ((au1000->stream[CAPTURE]->dma = request_au1000_dma(au1000->dmaid[1],
 			"AC97 RX", au1000_dma_interrupt, IRQF_DISABLED,
 			au1000->stream[CAPTURE])) < 0){
 		release_dma_lock(flags);
@@ -550,69 +552,12 @@ get the interrupt driven case to work efficiently */
 	spin_unlock(&au1000->ac97_lock);
 }
 
-static int __devinit
-snd_au1000_ac97_new(struct snd_au1000 *au1000)
-{
-	int err;
-	struct snd_ac97_bus *pbus;
-	struct snd_ac97_template ac97;
- 	static struct snd_ac97_bus_ops ops = {
-		.write = snd_au1000_ac97_write,
-		.read = snd_au1000_ac97_read,
-	};
-
-	if ((au1000->ac97_res_port = request_mem_region(CPHYSADDR(AC97C_CONFIG),
-	       		0x100000, "Au1x00 AC97")) == NULL) {
-		snd_printk(KERN_ERR "ALSA AC97: can't grap AC97 port\n");
-		return -EBUSY;
-	}
-	au1000->ac97_ioport = (struct au1000_ac97_reg *)
-		KSEG1ADDR(au1000->ac97_res_port->start);
-
-	spin_lock_init(&au1000->ac97_lock);
-
-	/* configure pins for AC'97
-	TODO: move to board_setup.c */
-	au_writel(au_readl(SYS_PINFUNC) & ~0x02, SYS_PINFUNC);
-
-	/* Initialise Au1000's AC'97 Control Block */
-	au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
-	udelay(10);
-	au1000->ac97_ioport->cntrl = AC97C_CE;
-	udelay(10);
-
-	/* Initialise External CODEC -- cold reset */
-	au1000->ac97_ioport->config = AC97C_RESET;
-	udelay(10);
-	au1000->ac97_ioport->config = 0x0;
-	mdelay(5);
-
-	/* Initialise AC97 middle-layer */
-	if ((err = snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus)) < 0)
- 		return err;
-
-	memset(&ac97, 0, sizeof(ac97));
-	ac97.private_data = au1000;
-	if ((err = snd_ac97_mixer(pbus, &ac97, &au1000->ac97)) < 0)
-		return err;
-
-	return 0;
-}
-
 /*------------------------------ Setup / Destroy ----------------------------*/
 
-void
-snd_au1000_free(struct snd_card *card)
+static void snd_au1000_free(struct snd_card *card)
 {
 	struct snd_au1000 *au1000 = card->private_data;
 
-	if (au1000->ac97_res_port) {
-		/* put internal AC97 block into reset */
-		au1000->ac97_ioport->cntrl = AC97C_RS;
-		au1000->ac97_ioport = NULL;
-		release_and_free_resource(au1000->ac97_res_port);
-	}
-
 	if (au1000->stream[PLAYBACK]) {
 	  	if (au1000->stream[PLAYBACK]->dma >= 0)
 			free_au1000_dma(au1000->stream[PLAYBACK]->dma);
@@ -624,71 +569,176 @@ snd_au1000_free(struct snd_card *card)
 			free_au1000_dma(au1000->stream[CAPTURE]->dma);
 		kfree(au1000->stream[CAPTURE]);
 	}
-}
 
+	if (au1000->ac97_res_port) {
+		/* put internal AC97 block into reset */
+		au1000->ac97_ioport->cntrl = AC97C_RS;
+		iounmap(au1000->ac97_ioport);
+		au1000->ac97_ioport = NULL;
+		release_and_free_resource(au1000->ac97_res_port);
+		au1000->ac97_res_port = NULL;
+	}
+}
 
-static struct snd_card *au1000_card;
+static struct snd_ac97_bus_ops ops = {
+	.write	= snd_au1000_ac97_write,
+	.read	= snd_au1000_ac97_read,
+};
 
-static int __init
-au1000_init(void)
+static int __devinit au1000_ac97_probe(struct platform_device *pdev)
 {
 	int err;
+	void __iomem *io;
+	struct resource *r;
 	struct snd_card *card;
 	struct snd_au1000 *au1000;
+	struct snd_ac97_bus *pbus;
+	struct snd_ac97_template ac97;
 
 	err = snd_card_create(-1, "AC97", THIS_MODULE,
-			      sizeof(struct snd_au1000), &card);
+				sizeof(struct snd_au1000), &card);
 	if (err < 0)
-		return err;
+		goto out0;
 
-	card->private_free = snd_au1000_free;
 	au1000 = card->private_data;
 	au1000->card = card;
 
-	au1000->stream[PLAYBACK] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
-	au1000->stream[CAPTURE ] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
-	/* so that snd_au1000_free will work as intended */
- 	au1000->ac97_res_port = NULL;
-	if (au1000->stream[PLAYBACK])
-		au1000->stream[PLAYBACK]->dma = -1;
-	if (au1000->stream[CAPTURE ])
-		au1000->stream[CAPTURE ]->dma = -1;
-
-	if (au1000->stream[PLAYBACK] == NULL ||
-	    au1000->stream[CAPTURE ] == NULL) {
-		snd_card_free(card);
-		return -ENOMEM;
+	/* TX DMA ID */
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r) {
+		err = -ENODEV;
+		snd_printk(KERN_INFO "no TX DMA platform resource!\n");
+		goto out1;
 	}
-
-	if ((err = snd_au1000_ac97_new(au1000)) < 0 ) {
-		snd_card_free(card);
-		return err;
+	au1000->dmaid[0] = r->start;
+
+	/* RX DMA ID */
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r) {
+		err = -ENODEV;
+		snd_printk(KERN_INFO "no RX DMA platform resource!\n");
+		goto out1;
 	}
+	au1000->dmaid[1] = r->start;
 
-	if ((err = snd_au1000_pcm_new(au1000)) < 0) {
-		snd_card_free(card);
-		return err;
+	au1000->stream[PLAYBACK] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
+	if (!au1000->stream[PLAYBACK])
+		goto out1;
+	au1000->stream[PLAYBACK]->dma = -1;
+
+	au1000->stream[CAPTURE] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
+	if (!au1000->stream[CAPTURE])
+		goto out2;
+	au1000->stream[CAPTURE]->dma = -1;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		goto out3;
+
+	err = -EBUSY;
+	au1000->ac97_res_port = request_mem_region(r->start,
+					r->end - r->start + 1, pdev->name);
+	if (!au1000->ac97_res_port) {
+		snd_printk(KERN_ERR "ALSA AC97: can't grab AC97 port\n");
+		goto out3;
 	}
 
+	io = ioremap(r->start, r->end - r->start + 1);
+	if (!io)
+		goto out4;
+
+	au1000->ac97_ioport = (struct au1000_ac97_reg *)io;
+
+	spin_lock_init(&au1000->ac97_lock);
+
+	/* configure pins for AC'97
+	TODO: move to board_setup.c */
+	au_writel(au_readl(SYS_PINFUNC) & ~0x02, SYS_PINFUNC);
+
+	/* Initialise Au1000's AC'97 Control Block */
+	au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
+	udelay(10);
+	au1000->ac97_ioport->cntrl = AC97C_CE;
+	udelay(10);
+
+	/* Initialise External CODEC -- cold reset */
+	au1000->ac97_ioport->config = AC97C_RESET;
+	udelay(10);
+	au1000->ac97_ioport->config = 0x0;
+	mdelay(5);
+
+	/* Initialise AC97 middle-layer */
+	err = snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus);
+	if (err < 0)
+		goto out5;
+
+	/* from here on let ALSA call the special freeing function */
+	card->private_free = snd_au1000_free;
+
+	memset(&ac97, 0, sizeof(ac97));
+	ac97.private_data = au1000;
+	err = snd_ac97_mixer(pbus, &ac97, &au1000->ac97);
+	if (err < 0)
+		goto out1;
+
+	err = snd_au1000_pcm_new(au1000);
+	if (err < 0)
+		goto out1;
+
 	strcpy(card->driver, "Au1000-AC97");
 	strcpy(card->shortname, "AMD Au1000-AC97");
 	sprintf(card->longname, "AMD Au1000--AC97 ALSA Driver");
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_card_register(card);
+	if (err < 0)
+		goto out1;
+
+	printk( KERN_INFO "ALSA AC97: Driver Initialized\n" );
+
+	platform_set_drvdata(pdev, card);
 
-	printk(KERN_INFO "ALSA AC97: Driver Initialized\n");
-	au1000_card = card;
 	return 0;
+
+out5:
+	au1000->ac97_ioport->cntrl = AC97C_RS;
+	iounmap(io);
+out4:
+	release_and_free_resource(au1000->ac97_res_port);
+out3:
+	kfree(au1000->stream[PLAYBACK]);
+out2:
+	kfree(au1000->stream[PLAYBACK]);
+out1:
+	snd_card_free(card);
+out0:
+	return err;
 }
 
-static void __exit au1000_exit(void)
+static int __devexit au1000_ac97_remove(struct platform_device *pdev)
 {
-	snd_card_free(au1000_card);
+	struct snd_card *card = platform_get_drvdata(pdev);
+	snd_card_free(card);
+	return 0;
 }
 
-module_init(au1000_init);
-module_exit(au1000_exit);
+struct platform_driver au1000_ac97c_driver = {
+	.driver	= {
+		.name	= "au1000-ac97c",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= au1000_ac97_probe,
+	.remove		= __devexit_p(au1000_ac97_remove),
+};
+
+static int __init au1000_ac97_load(void)
+{
+	return platform_driver_register(&au1000_ac97c_driver);
+}
+
+static void __exit au1000_ac97_unload(void)
+{
+	platform_driver_unregister(&au1000_ac97c_driver);
+}
 
+module_init(au1000_ac97_load);
+module_exit(au1000_ac97_unload);
-- 
1.6.2
