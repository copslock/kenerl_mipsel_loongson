Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jul 2011 15:12:30 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:49486 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab1GXNLl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jul 2011 15:11:41 +0200
Received: by fxd20 with SMTP id 20so5793683fxd.36
        for <linux-mips@linux-mips.org>; Sun, 24 Jul 2011 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lkMLnFKW4JPaJ7GbHTwLK5fb4swNsJ1yjaX0euXECMk=;
        b=cUtbBotuOF1+cFpU/+lOuDtvA4MjzLVZAWiNUJl2t3Sr7jV7F7ixKklakmCOJ/3J9D
         CvIyqtNMsqizLSYqJHwUCPLNWJRyxyRc8kDk/e/FXDKTy0LilUq9vc2NKqUQ4hvNG+fI
         Nr0Abu9r+BK6ArA2naXIEOyCvlC5fMUwy0Xb4=
Received: by 10.223.145.2 with SMTP id b2mr5161241fav.99.1311513095932;
        Sun, 24 Jul 2011 06:11:35 -0700 (PDT)
Received: from localhost.localdomain (188-22-2-77.adsl.highway.telekom.at [188.22.2.77])
        by mx.google.com with ESMTPS id h10sm3192115fai.19.2011.07.24.06.11.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 06:11:35 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] ASoC: au1x: update db1200 machine to the new way of things
Date:   Sun, 24 Jul 2011 15:11:28 +0200
Message-Id: <1311513088-18802-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311513088-18802-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311513088-18802-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17130

The use of the "soc-audio" platform device is no longer en vogue,
update the code to the newer, simpler way of doing things.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/db1200/platform.c |   10 ++++
 sound/soc/au1x/db1200.c                       |   64 +++++++++++++++++--------
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index cfb71ae..dda090b 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -422,6 +422,7 @@ static struct resource au1200_psc1_res[] = {
 	},
 };
 
+/* AC97 or I2S device */
 static struct platform_device db1200_audio_dev = {
 	/* name assigned later based on switch setting */
 	.id		= 1,	/* PSC ID */
@@ -429,6 +430,12 @@ static struct platform_device db1200_audio_dev = {
 	.resource	= au1200_psc1_res,
 };
 
+/* DB1200 ASoC card device */
+static struct platform_device db1200_sound_dev = {
+	/* name assigned later based on switch setting */
+	.id		= 1,	/* PSC ID */
+};
+
 static struct platform_device db1200_stac_dev = {
 	.name		= "ac97-codec",
 	.id		= 1,	/* on PSC1 */
@@ -448,6 +455,7 @@ static struct platform_device *db1200_devs[] __initdata = {
 	&db1200_audiodma_dev,
 	&db1200_audio_dev,
 	&db1200_stac_dev,
+	&db1200_sound_dev,
 };
 
 static int __init db1200_dev_init(void)
@@ -507,10 +515,12 @@ static int __init db1200_dev_init(void)
 	if (sw == BCSR_SWITCHES_DIP_8) {
 		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_PSC1MUX);
 		db1200_audio_dev.name = "au1xpsc_i2s";
+		db1200_sound_dev.name = "db1200-i2s";
 		printk(KERN_INFO " S6.7 ON : PSC1 mode I2S\n");
 	} else {
 		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC1MUX, 0);
 		db1200_audio_dev.name = "au1xpsc_ac97";
+		db1200_sound_dev.name = "db1200-ac97";
 		printk(KERN_INFO " S6.7 OFF: PSC1 mode AC97\n");
 	}
 
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 1d3e258..289312c 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -1,7 +1,7 @@
 /*
  * DB1200 ASoC audio fabric support code.
  *
- * (c) 2008-9 Manuel Lauss <manuel.lauss@gmail.com>
+ * (c) 2008-2011 Manuel Lauss <manuel.lauss@googlemail.com>
  *
  */
 
@@ -21,6 +21,17 @@
 #include "../codecs/wm8731.h"
 #include "psc.h"
 
+static struct platform_device_id db1200_pids[] = {
+	{
+		.name		= "db1200-ac97",
+		.driver_data	= 0,
+	}, {
+		.name		= "db1200-i2s",
+		.driver_data	= 1,
+	},
+	{},
+};
+
 /*-------------------------  AC97 PART  ---------------------------*/
 
 static struct snd_soc_dai_link db1200_ac97_dai = {
@@ -89,36 +100,47 @@ static struct snd_soc_card db1200_i2s_machine = {
 
 /*-------------------------  COMMON PART  ---------------------------*/
 
-static struct platform_device *db1200_asoc_dev;
+static struct snd_soc_card *db1200_cards[] __devinitdata = {
+	&db1200_ac97_machine,
+	&db1200_i2s_machine,
+};
 
-static int __init db1200_audio_load(void)
+static int __devinit db1200_audio_probe(struct platform_device *pdev)
 {
-	int ret;
+	const struct platform_device_id *pid = platform_get_device_id(pdev);
+	struct snd_soc_card *card;
 
-	ret = -ENOMEM;
-	db1200_asoc_dev = platform_device_alloc("soc-audio", 1); /* PSC1 */
-	if (!db1200_asoc_dev)
-		goto out;
+	card = db1200_cards[pid->driver_data];
+	card->dev = &pdev->dev;
+	return snd_soc_register_card(card);
+}
 
-	/* DB1200 board setup set PSC1MUX to preferred audio device */
-	if (bcsr_read(BCSR_RESETS) & BCSR_RESETS_PSC1MUX)
-		platform_set_drvdata(db1200_asoc_dev, &db1200_i2s_machine);
-	else
-		platform_set_drvdata(db1200_asoc_dev, &db1200_ac97_machine);
+static int __devexit db1200_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	snd_soc_unregister_card(card);
+	return 0;
+}
 
-	ret = platform_device_add(db1200_asoc_dev);
+static struct platform_driver db1200_audio_driver = {
+	.driver	= {
+		.name	= "db1200-ac97",
+		.owner	= THIS_MODULE,
+		.pm	= &snd_soc_pm_ops,
+	},
+	.id_table	= db1200_pids,
+	.probe		= db1200_audio_probe,
+	.remove		= __devexit_p(db1200_audio_remove),
+};
 
-	if (ret) {
-		platform_device_put(db1200_asoc_dev);
-		db1200_asoc_dev = NULL;
-	}
-out:
-	return ret;
+static int __init db1200_audio_load(void)
+{
+	return platform_driver_register(&db1200_audio_driver);
 }
 
 static void __exit db1200_audio_unload(void)
 {
-	platform_device_unregister(db1200_asoc_dev);
+	platform_driver_unregister(&db1200_audio_driver);
 }
 
 module_init(db1200_audio_load);
-- 
1.7.6
