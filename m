Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 22:47:53 +0200 (CEST)
Received: from smtp-out-121.synserver.de ([212.40.185.121]:1167 "EHLO
        smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6834662AbaDVUqvvkt24 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 22:46:51 +0200
Received: (qmail 18665 invoked by uid 0); 22 Apr 2014 20:46:46 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 18380
Received: from ppp-188-174-45-35.dynamic.mnet-online.de (HELO lars-adi-laptop.fritz.box) [188.174.45.35]
  by 217.119.54.96 with SMTP; 22 Apr 2014 20:46:46 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] ASoC: qi_lb60: Use GPIO descriptor API
Date:   Tue, 22 Apr 2014 22:46:35 +0200
Message-Id: <1398199596-23649-5-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The new GPIO descriptor API is now the preferred way for handling GPIOs. It also
allows us to separate the platform depended code from the platform independent
code (Which will make it possible to increase build test coverage of the
platform independent code).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Preferably this should go through the ASoC tree, but needs an Ack from Ralf for
the MIPS portions.
---
 arch/mips/jz4740/board-qi_lb60.c | 11 ++++++++
 sound/soc/jz4740/qi_lb60.c       | 54 +++++++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index c01900e..088e92a 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -425,6 +425,15 @@ static struct platform_device qi_lb60_audio_device = {
 	.id = -1,
 };
 
+static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
+	.dev_id = "qi-lb60-audio",
+	.table = {
+		GPIO_LOOKUP("Bank B", 29, "snd", 0),
+		GPIO_LOOKUP("Bank D", 4, "amp", 0),
+		{ },
+	},
+};
+
 static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_udc_device,
 	&jz4740_udc_xceiv_device,
@@ -461,6 +470,8 @@ static int __init qi_lb60_init_platform_devices(void)
 	jz4740_adc_device.dev.platform_data = &qi_lb60_battery_pdata;
 	jz4740_mmc_device.dev.platform_data = &qi_lb60_mmc_pdata;
 
+	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
+
 	jz4740_serial_device_register();
 
 	spi_register_board_info(qi_lb60_spi_board_info,
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index be0a437..5cb91f9 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -19,18 +19,21 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
-#define QI_LB60_SND_GPIO JZ_GPIO_PORTB(29)
-#define QI_LB60_AMP_GPIO JZ_GPIO_PORTD(4)
+struct qi_lb60 {
+	struct gpio_desc *snd_gpio;
+	struct gpio_desc *amp_gpio;
+};
 
 static int qi_lb60_spk_event(struct snd_soc_dapm_widget *widget,
 			     struct snd_kcontrol *ctrl, int event)
 {
+	struct qi_lb60 *qi_lb60 = snd_soc_card_get_drvdata(widget->dapm->card);
 	int on = !SND_SOC_DAPM_EVENT_OFF(event);
 
-	gpio_set_value(QI_LB60_SND_GPIO, on);
-	gpio_set_value(QI_LB60_AMP_GPIO, on);
+	gpiod_set_value_cansleep(qi_lb60->snd_gpio, on);
+	gpiod_set_value_cansleep(qi_lb60->amp_gpio, on);
 
 	return 0;
 }
@@ -57,7 +60,7 @@ static struct snd_soc_dai_link qi_lb60_dai = {
 		SND_SOC_DAIFMT_CBM_CFM,
 };
 
-static struct snd_soc_card qi_lb60 = {
+static struct snd_soc_card qi_lb60_card = {
 	.name = "QI LB60",
 	.owner = THIS_MODULE,
 	.dai_link = &qi_lb60_dai,
@@ -70,35 +73,35 @@ static struct snd_soc_card qi_lb60 = {
 	.fully_routed = true,
 };
 
-static const struct gpio qi_lb60_gpios[] = {
-	{ QI_LB60_SND_GPIO, GPIOF_OUT_INIT_LOW, "SND" },
-	{ QI_LB60_AMP_GPIO, GPIOF_OUT_INIT_LOW, "AMP" },
-};
-
 static int qi_lb60_probe(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = &qi_lb60;
+	struct qi_lb60 *qi_lb60;
+	struct snd_soc_card *card = &qi_lb60_card;
 	int ret;
 
-	ret = gpio_request_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
+	qi_lb60 = devm_kzalloc(&pdev->dev, sizeof(*qi_lb60), GFP_KERNEL);
+	if (!qi_lb60)
+		return -ENOMEM;
+
+	qi_lb60->snd_gpio = devm_gpiod_get(&pdev->dev, "snd");
+	if (IS_ERR(qi_lb60->snd_gpio))
+		return PTR_ERR(qi_lb60->snd_gpio);
+	ret = gpiod_direction_output(qi_lb60->snd_gpio, 0);
+	if (ret)
+		return ret;
+
+	qi_lb60->amp_gpio = devm_gpiod_get(&pdev->dev, "amp");
+	if (IS_ERR(qi_lb60->amp_gpio))
+		return PTR_ERR(qi_lb60->amp_gpio);
+	ret = gpiod_direction_output(qi_lb60->amp_gpio, 0);
 	if (ret)
 		return ret;
 
 	card->dev = &pdev->dev;
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-			ret);
-		gpio_free_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
-	}
-	return ret;
-}
+	snd_soc_card_set_drvdata(card, qi_lb60);
 
-static int qi_lb60_remove(struct platform_device *pdev)
-{
-	gpio_free_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 static struct platform_driver qi_lb60_driver = {
@@ -107,7 +110,6 @@ static struct platform_driver qi_lb60_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= qi_lb60_probe,
-	.remove		= qi_lb60_remove,
 };
 
 module_platform_driver(qi_lb60_driver);
-- 
1.8.0
