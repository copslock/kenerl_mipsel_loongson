Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 09:45:06 +0200 (CEST)
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:50912 "EHLO
        eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491944Ab0I1Hoi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 09:44:38 +0200
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob113.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKGcdbo/8jY49Fh3etmfNaoWIPZ/Arit@postini.com; Tue, 28 Sep 2010 07:44:38 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 121457F;
        Tue, 28 Sep 2010 07:41:28 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E8BB1956;
        Tue, 28 Sep 2010 07:41:20 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 43C2624C2F6;
        Tue, 28 Sep 2010 09:41:12 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 28 Sep
 2010 09:41:15 +0200
From:   Arun Murthy <arun.murthy@stericsson.com>
To:     <eric.y.miao@gmail.com>, <linux@arm.linux.org.uk>,
        <grinberg@compulab.co.il>, <mike@compulab.co.il>,
        <robert.jarzmik@free.fr>, <marek.vasut@gmail.com>,
        <drwyrm@gmail.com>, <stefan@openezx.org>, <laforge@openezx.org>,
        <ospite@studenti.unina.it>, <philipp.zabel@gmail.com>,
        <mad_soft@inbox.ru>, <maz@misterjones.org>, <daniel@caiaq.de>,
        <haojian.zhuang@marvell.com>, <timur@freescale.com>,
        <ben-linux@fluff.org>, <support@simtec.co.uk>,
        <arnaud.patard@rtp-net.org>, <dgreenday@gmail.com>,
        <anarsoul@gmail.com>, <akpm@linux-foundation.org>,
        <mcuelenaere@gmail.com>, <kernel@pengutronix.de>,
        <andre.goddard@gmail.com>, <jkosina@suse.cz>, <tj@kernel.org>,
        <hsweeten@visionengravers.com>, <u.kleine-koenig@pengutronix.de>,
        <kgene.kim@samsung.com>, <ralf@linux-mips.org>, <lars@metafoo.de>,
        <dilinger@collabora.co.uk>, <mroth@nessie.de>,
        <randy.dunlap@oracle.com>, <lethal@linux-sh.org>,
        <rusty@rustcorp.com.au>, <damm@opensource.se>, <mst@redhat.com>,
        <rpurdie@rpsys.net>, <sguinot@lacie.co>, <sameo@linux.intel.com>,
        <broonie@opensource.wolfsonmicro.com>, <balajitk@ti.com>,
        <rnayak@ti.com>, <santosh.shilimkar@ti.com>, <hemanthv@ti.com>,
        <michael.hennerich@analog.com>, <vapier@gentoo.org>,
        <khali@linux-fr.org>, <jic23@cam.ac.uk>, <re.emese@gmail.com>,
        <linux@simtec.co.uk>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <arun.murthy@stericsson.com>, <linus.walleij@stericsson.com>,
        <mattias.wallin@stericsson.com>
Subject: [PATCH 5/7] platform: Update the pwm based led and backlight platform data
Date:   Tue, 28 Sep 2010 13:10:46 +0530
Message-ID: <1285659648-21409-6-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
In-Reply-To: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 27837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22113

	mxc-pwm: Update the platform data with pwm name for backlight
	s3c24xx-pwm: update platform data for backlight with pwm name

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-pxa/cm-x300.c               |    1 +
 arch/arm/mach-pxa/colibri-pxa270-income.c |    1 +
 arch/arm/mach-pxa/ezx.c                   |    1 +
 arch/arm/mach-pxa/hx4700.c                |    1 +
 arch/arm/mach-pxa/lpd270.c                |    1 +
 arch/arm/mach-pxa/magician.c              |    1 +
 arch/arm/mach-pxa/mainstone.c             |    1 +
 arch/arm/mach-pxa/mioa701.c               |    1 +
 arch/arm/mach-pxa/palm27x.c               |    1 +
 arch/arm/mach-pxa/palmtc.c                |    1 +
 arch/arm/mach-pxa/palmte2.c               |    1 +
 arch/arm/mach-pxa/pcm990-baseboard.c      |    1 +
 arch/arm/mach-pxa/raumfeld.c              |    1 +
 arch/arm/mach-pxa/tavorevb.c              |    2 ++
 arch/arm/mach-pxa/viper.c                 |    1 +
 arch/arm/mach-pxa/z2.c                    |    2 ++
 arch/arm/mach-pxa/zylonite.c              |    1 +
 arch/arm/mach-s3c2410/mach-h1940.c        |    1 +
 arch/arm/mach-s3c2440/mach-rx1950.c       |    1 +
 arch/arm/mach-s3c64xx/mach-hmt.c          |    1 +
 arch/arm/mach-s3c64xx/mach-smartq.c       |    1 +
 21 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index c70e6c2..ddf763b 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -301,6 +301,7 @@ static inline void cm_x300_init_lcd(void) {}
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
 static struct platform_pwm_backlight_data cm_x300_backlight_data = {
 	.pwm_id		= 2,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	.pwm_period_ns	= 10000,
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 37f0f3e..d5b5874 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -234,6 +234,7 @@ static inline void income_lcd_init(void) {}
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM__MODULE)
 static struct platform_pwm_backlight_data income_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 0x3ff,
 	.dft_brightness	= 0x1ff,
 	.pwm_period_ns	= 1000000,
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 626c82b..747f217 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -49,6 +49,7 @@
 
 static struct platform_pwm_backlight_data ezx_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 1023,
 	.dft_brightness	= 1023,
 	.pwm_period_ns	= 78770,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 848c861..8e4905a 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -565,6 +565,7 @@ static struct platform_device hx4700_lcd = {
 
 static struct platform_pwm_backlight_data backlight_data = {
 	.pwm_id         = 1,
+	.name		= "pxa25x-pwm",
 	.max_brightness = 200,
 	.dft_brightness = 100,
 	.pwm_period_ns  = 30923,
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index d279507..91efade 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -273,6 +273,7 @@ static struct platform_device lpd270_flash_device[2] = {
 
 static struct platform_pwm_backlight_data lpd270_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 1,
 	.dft_brightness	= 1,
 	.pwm_period_ns	= 78770,
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index e81dd0c..bb657a4 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -382,6 +382,7 @@ static void magician_backlight_exit(struct device *dev)
 
 static struct platform_pwm_backlight_data backlight_data = {
 	.pwm_id         = 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness = 272,
 	.dft_brightness = 100,
 	.pwm_period_ns  = 30923,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 5543c64..cbd359c 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -342,6 +342,7 @@ static struct platform_device mst_flash_device[2] = {
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static struct platform_pwm_backlight_data mainstone_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 1023,
 	.dft_brightness	= 1023,
 	.pwm_period_ns	= 78770,
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index dc66942..e442088 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -224,6 +224,7 @@ static void mio_gpio_free(struct gpio_ress *gpios, int size)
 /* LCD Screen and Backlight */
 static struct platform_pwm_backlight_data mioa701_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 100,
 	.dft_brightness	= 50,
 	.pwm_period_ns	= 4000 * 1024,	/* Fl = 250kHz */
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 77ad6d3..46677a4 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -321,6 +321,7 @@ static void palm27x_backlight_exit(struct device *dev)
 
 static struct platform_pwm_backlight_data palm27x_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 0xfe,
 	.dft_brightness	= 0x7e,
 	.pwm_period_ns	= 3500,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index ce1104d..385a0b5 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -180,6 +180,7 @@ static void palmtc_backlight_exit(struct device *dev)
 
 static struct platform_pwm_backlight_data palmtc_backlight_data = {
 	.pwm_id		= 1,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= PALMTC_MAX_INTENSITY,
 	.dft_brightness	= PALMTC_MAX_INTENSITY,
 	.pwm_period_ns	= PALMTC_PERIOD_NS,
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 93c11a0..b7e95f4 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -177,6 +177,7 @@ static void palmte2_backlight_exit(struct device *dev)
 
 static struct platform_pwm_backlight_data palmte2_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= PALMTE2_MAX_INTENSITY,
 	.dft_brightness	= PALMTE2_MAX_INTENSITY,
 	.pwm_period_ns	= PALMTE2_PERIOD_NS,
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index f56ae10..29c7e88 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -138,6 +138,7 @@ static struct pxafb_mach_info pcm990_fbinfo __initdata = {
 
 static struct platform_pwm_backlight_data pcm990_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 1023,
 	.dft_brightness	= 1023,
 	.pwm_period_ns	= 78770,
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 67e04f4..98dc2e3 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -535,6 +535,7 @@ static void __init raumfeld_w1_init(void)
 /* PWM controlled backlight */
 static struct platform_pwm_backlight_data raumfeld_pwm_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	/* 10000 ns = 10 ms ^= 100 kHz */
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index f02dcb5..3164de8 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -168,6 +168,7 @@ static struct platform_pwm_backlight_data tavorevb_backlight_data[] = {
 	[0] = {
 		/* primary backlight */
 		.pwm_id		= 2,
+		.name		= "pxa25x-pwm",
 		.max_brightness	= 100,
 		.dft_brightness	= 100,
 		.pwm_period_ns	= 100000,
@@ -175,6 +176,7 @@ static struct platform_pwm_backlight_data tavorevb_backlight_data[] = {
 	[1] = {
 		/* secondary backlight */
 		.pwm_id		= 0,
+		.name		= "pxa25x-pwm",
 		.max_brightness	= 100,
 		.dft_brightness	= 100,
 		.pwm_period_ns	= 100000,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index e90114a..fdb768c 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -397,6 +397,7 @@ static void viper_backlight_exit(struct device *dev)
 
 static struct platform_pwm_backlight_data viper_backlight_data = {
 	.pwm_id		= 0,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	.pwm_period_ns	= 1000000,
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index f0d0228..bb3d821 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -204,6 +204,7 @@ static struct platform_pwm_backlight_data z2_backlight_data[] = {
 	[0] = {
 		/* Keypad Backlight */
 		.pwm_id		= 1,
+		.name		= "pxa25x-pwm",
 		.max_brightness	= 1023,
 		.dft_brightness	= 512,
 		.pwm_period_ns	= 1260320,
@@ -211,6 +212,7 @@ static struct platform_pwm_backlight_data z2_backlight_data[] = {
 	[1] = {
 		/* LCD Backlight */
 		.pwm_id		= 2,
+		.name		= "pxa25x-pwm",
 		.max_brightness	= 1023,
 		.dft_brightness	= 512,
 		.pwm_period_ns	= 1260320,
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 5ba9d99..29492bf 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -122,6 +122,7 @@ static inline void zylonite_init_leds(void) {}
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static struct platform_pwm_backlight_data zylonite_backlight_data = {
 	.pwm_id		= 3,
+	.name		= "pxa25x-pwm",
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	.pwm_period_ns	= 10000,
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 3ba3bab..357342f 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -224,6 +224,7 @@ static void h1940_backlight_exit(struct device *dev)
 
 static struct platform_pwm_backlight_data backlight_data = {
 	.pwm_id         = 0,
+	.name		= "s3c24xx-pwm",
 	.max_brightness = 100,
 	.dft_brightness = 50,
 	/* tcnt = 0x31 */
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 142d1f9..6d993de 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -291,6 +291,7 @@ static int rx1950_backlight_notify(struct device *dev, int brightness)
 
 static struct platform_pwm_backlight_data rx1950_backlight_data = {
 	.pwm_id = 0,
+	.name = "s3c24xx-pwm",
 	.max_brightness = 24,
 	.dft_brightness = 4,
 	.pwm_period_ns = 48000,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index fba9022..14e9011 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -109,6 +109,7 @@ static void hmt_bl_exit(struct device *dev)
 
 static struct platform_pwm_backlight_data hmt_backlight_data = {
 	.pwm_id		= 1,
+	.name		= "s3c24xx-pwm",
 	.max_brightness	= 100 * 256,
 	.dft_brightness	= 40 * 256,
 	.pwm_period_ns	= 1000000000 / (100 * 256 * 20),
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index cb1ebeb..20999d5 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -145,6 +145,7 @@ static int smartq_bl_init(struct device *dev)
 
 static struct platform_pwm_backlight_data smartq_backlight_data = {
 	.pwm_id		= 1,
+	.name		= "s3c24xx-pwm",
 	.max_brightness	= 1000,
 	.dft_brightness	= 600,
 	.pwm_period_ns	= 1000000000 / (1000 * 20),
-- 
1.7.2.dirty
