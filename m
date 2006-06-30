Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2006 11:04:27 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:27363 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S3686606AbWF3KER (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jun 2006 11:04:17 +0100
Received: from hulk.enneenne.com
	([192.168.32.38] helo=localhost.localdomain ident=Debian-exim)
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FwFmS-0002QN-N0
	for linux-mips@linux-mips.org; Fri, 30 Jun 2006 11:59:21 +0200
Received: from giometti by localhost.localdomain with local (Exim 4.60)
	(envelope-from <giometti@hulk.enneenne.com>)
	id 1FwFpw-0001X4-8J
	for linux-mips@linux-mips.org; Fri, 30 Jun 2006 12:02:56 +0200
Date:	Fri, 30 Jun 2006 12:02:56 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060630100256.GW7300@hulk.enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DHd0DHvhbdljNSqO"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.38
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Au1xxx sound registration and power management
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--DHd0DHvhbdljNSqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch to support device registration and power management for
the au1xxx ALSA driver.

Ciao,

Rodolfo

P.S. Please, let me know if I should send this patch to other lists
too.

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--DHd0DHvhbdljNSqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1000_snd-pm-and-registration

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index 0088889..34de6d3 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -88,6 +88,31 @@ static struct platform_device au1xxx_eth
 #endif
 #endif
 
+#if defined(CONFIG_SND_AU1X00)
+/* AC97 controller */
+static struct resource au1xxx_snd_resources[] = {
+	[0] = {
+		.name   = "snd-base",
+		.start  = AC97C_BASE,
+		.end    = AC97C_BASE + AC97_IOSIZE - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "snd-irq",
+		.start	= AU1000_AC97C_INT,
+		.end	= AU1000_AC97C_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device au1xxx_snd_device = {
+		.name   = "au1xxx-snd",
+		.id             = -1,
+		.num_resources  = ARRAY_SIZE(au1xxx_snd_resources),
+		.resource       = au1xxx_snd_resources,
+};
+#endif
+
 /* OHCI (USB full speed host controller) */
 static struct resource au1xxx_usb_ohci_resources[] = {
 	[0] = {
@@ -376,6 +401,9 @@ #if defined(CONFIG_SOC_AU1000) || \
 	&au1xxx_eth1_device,
 #endif
 #endif
+#if defined(CONFIG_SND_AU1X00)
+	&au1xxx_snd_device,
+#endif
 	&au1xxx_usb_ohci_device,
 	&au1x00_pcmcia_device,
 #ifdef CONFIG_FB_AU1100
diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-au1x00/au1000.h
index 0988af9..cb8939a 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -1600,6 +1600,9 @@ #define SYS_CPUPLL                0xB190
 #define SYS_AUXPLL                0xB1900064
 
 /* AC97 Controller */
+#define AC97C_BASE              AC97_PHYS_ADDR
+#define AC97_IOSIZE		0x14
+
 #define AC97C_CONFIG              0xB0000000
   #define AC97C_RECV_SLOTS_BIT  13
   #define AC97C_RECV_SLOTS_MASK (0x3ff << AC97C_RECV_SLOTS_BIT)
diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index cf476fe..2dd6862 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -5,6 +5,8 @@
  * Copyright 2004 Cooper Street Innovations Inc.
  * Author: Charles Eidsness	<charles@cooper-street.com>
  *
+ * PM support added by Rodolfo Giometti <giometti@linux.it>
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
@@ -40,6 +42,7 @@ #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/version.h>
+#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -53,6 +56,8 @@ MODULE_DESCRIPTION("Au1000 AC'97 ALSA Dr
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{AMD,Au1000 AC'97}}");
 
+#define DRV_NAME        "au1xxx-snd"
+
 #define PLAYBACK 0
 #define CAPTURE 1
 #define AC97_SLOT_3 0x01
@@ -526,7 +531,6 @@ get the interupt driven case to work eff
 
 }
 
-
 static void
 snd_au1000_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
 {
@@ -550,24 +554,17 @@ get the interupt driven case to work eff
 	spin_unlock(&au1000->ac97_lock);
 }
 
+static struct snd_ac97_bus_ops au1000_ac97_ops = {
+	.write = snd_au1000_ac97_write,
+	.read = snd_au1000_ac97_read,
+};
+
 static int __devinit
 snd_au1000_ac97_new(struct snd_au1000 *au1000)
 {
 	int err;
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
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
 
 	spin_lock_init(&au1000->ac97_lock);
 
@@ -588,7 +585,7 @@ snd_au1000_ac97_new(struct snd_au1000 *a
 	mdelay(5);
 
 	/* Initialise AC97 middle-layer */
-	if ((err = snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus)) < 0)
+	if ((err = snd_ac97_bus(au1000->card, 0, &au1000_ac97_ops, au1000, &pbus)) < 0)
  		return err;
 
 	memset(&ac97, 0, sizeof(ac97));
@@ -626,68 +623,154 @@ snd_au1000_free(struct snd_card *card)
 	}
 }
 
+#ifdef CONFIG_PM
+static u32 au1000_ac97_config;
+
+static int au1000_drv_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_card *card = platform_get_drvdata(pdev);
+	struct snd_au1000 *au1000 = card->private_data;
+
+	if (!card)
+		return 0;
 
-static struct snd_card *au1000_card;
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
+	snd_pcm_suspend_all(au1000->pcm);
+	snd_ac97_suspend(au1000->ac97);
+
+	/* Save Au1000's AC'97 Control Block and disable the controller */
+	au1000_ac97_config = au1000->ac97_ioport->config;
+	au1000->ac97_ioport->cntrl = AC97C_RS;
+
+	return 0;
+}
 
-static int __init
-au1000_init(void)
+static int au1000_drv_resume(struct platform_device *pdev)
 {
-	int err;
-	struct snd_card *card;
-	struct snd_au1000 *au1000;
+	struct snd_card *card = platform_get_drvdata(pdev);
+	struct snd_au1000 *au1000 = card->private_data;
+
+	if (!card)
+		return 0;
 
+	/* Initialise Au1000's AC'97 Control Block and restore previous
+	 * configuration */
+	au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
+	udelay(10);
+	au1000->ac97_ioport->cntrl = AC97C_CE;
+	udelay(10);
+	au1000->ac97_ioport->config = au1000_ac97_config;
+
+	snd_ac97_resume(au1000->ac97);
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	return 0;
+}
+#endif
+
+static int __init au1000_drv_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct snd_card *card = NULL;
+	struct snd_au1000 *au1000 = NULL;
+	int ret;
+
+	/* Get the resource info */
+	ret = -ENODEV;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "snd-base");
+	if (!res)
+		goto exit;
+
+	ret = -ENOMEM;
 	card = snd_card_new(-1, "AC97", THIS_MODULE, sizeof(struct snd_au1000));
 	if (card == NULL)
-		return -ENOMEM;
+		goto exit;
 
+	card->dev = &pdev->dev;
 	card->private_free = snd_au1000_free;
 	au1000 = card->private_data;
 	au1000->card = card;
 
+	au1000->ac97_res_port = res;
+	au1000->ac97_ioport = ioremap(res->start, res->end - res->start + 1);
+	ret = -ENOMEM;
+	if (!au1000->ac97_ioport) {
+		printk (KERN_ERR "%s: unable to remap address %lx\n",
+			DRV_NAME, res->start);
+		goto exit;
+	}
+
 	au1000->stream[PLAYBACK] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
 	au1000->stream[CAPTURE ] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
 	/* so that snd_au1000_free will work as intended */
- 	au1000->ac97_res_port = NULL;
 	if (au1000->stream[PLAYBACK])
 		au1000->stream[PLAYBACK]->dma = -1;
 	if (au1000->stream[CAPTURE ])
 		au1000->stream[CAPTURE ]->dma = -1;
 
 	if (au1000->stream[PLAYBACK] == NULL ||
-	    au1000->stream[CAPTURE ] == NULL) {
-		snd_card_free(card);
-		return -ENOMEM;
-	}
+	    au1000->stream[CAPTURE ] == NULL)
+		goto exit;
 
-	if ((err = snd_au1000_ac97_new(au1000)) < 0 ) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((ret = snd_au1000_ac97_new(au1000)) < 0)
+		goto exit;
 
-	if ((err = snd_au1000_pcm_new(au1000)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((ret = snd_au1000_pcm_new(au1000)) < 0)
+		goto exit;
 
 	strcpy(card->driver, "Au1000-AC97");
 	strcpy(card->shortname, "AMD Au1000-AC97");
 	sprintf(card->longname, "AMD Au1000--AC97 ALSA Driver");
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((ret = snd_card_register(card)) < 0)
+		goto exit;
+	platform_set_drvdata(pdev, card);
 
 	printk( KERN_INFO "ALSA AC97: Driver Initialized\n" );
-	au1000_card = card;
+
 	return 0;
+
+exit :
+	if (au1000 && au1000->ac97_ioport)
+		iounmap(au1000->ac97_ioport);
+	if (card)
+		snd_card_free(card);
+
+	return ret;
 }
 
-static void __exit au1000_exit(void)
+static int __exit au1000_drv_remove(struct platform_device *pdev)
 {
-	snd_card_free(au1000_card);
+	struct snd_card *card = platform_get_drvdata(pdev);
+
+	if (card)
+		snd_card_free(card);
+
+	return 0;
 }
 
-module_init(au1000_init);
-module_exit(au1000_exit);
+static struct platform_driver au1000_driver = {
+	.probe		= au1000_drv_probe,
+	.remove		= au1000_drv_remove,
+#ifdef CONFIG_PM
+	.suspend	= au1000_drv_suspend,
+	.resume		= au1000_drv_resume,
+#endif
+	.driver		= {
+		.name	= DRV_NAME,
+	},
+};
+
+
+static int __init au1000_snd_init(void)
+{
+	return platform_driver_register(&au1000_driver);
+}
+
+static void __exit au1000_snd_exit(void)
+{
+	platform_driver_unregister(&au1000_driver);
+}
 
+module_init(au1000_snd_init);
+module_exit(au1000_snd_exit);

--DHd0DHvhbdljNSqO--
