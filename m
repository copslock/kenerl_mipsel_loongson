Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2010 14:03:11 +0200 (CEST)
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:42273 "EHLO
        eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491025Ab0JEMBu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Oct 2010 14:01:50 +0200
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob109.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKsTjQ4ju8Oh5esDLmHBAfxBmFhUyWqk@postini.com; Tue, 05 Oct 2010 12:01:49 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C00B012A;
        Tue,  5 Oct 2010 12:00:27 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 627E79B0;
        Tue,  5 Oct 2010 12:00:27 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id CF7B7A8074;
        Tue,  5 Oct 2010 14:00:20 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 5 Oct
 2010 14:00:26 +0200
From:   Arun Murthy <arun.murthy@stericsson.com>
To:     <lars@metafoo.de>, <akpm@linux-foundation.org>,
        <kernel@pengutronix.de>, <philipp.zabel@gmail.com>,
        <robert.jarzmik@free.fr>, <marek.vasut@gmail.com>,
        <eric.y.miao@gmail.com>, <rpurdie@rpsys.net>,
        <sameo@linux.intel.com>, <kgene.kim@samsung.com>,
        <linux-omap@vger.kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <STEricsson_nomadik_linux@list.st.com>,
        <arun.murthy@stericsson.com>, <bgat@billgatliff.com>
Subject: [PATCHv2 7/7] pwm: Modify backlight and led Kconfig aligning to pwm core
Date:   Tue, 5 Oct 2010 17:30:02 +0530
Message-ID: <1286280002-1636-8-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
In-Reply-To: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <arun.murthy@stericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

PWM based backlight and led driver will not be calling the pwm drivers
through the pwm core driver and hence adding dependancy on the same.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/leds/Kconfig            |    2 +-
 drivers/pwm/Kconfig             |    2 --
 drivers/video/backlight/Kconfig |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e411262..8324dd0 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -244,7 +244,7 @@ config LEDS_DAC124S085
 
 config LEDS_PWM
 	tristate "PWM driven LED Support"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM_DEVICES
 	help
 	  This option enables support for pwm driven LEDs
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e4ef199..4acc0a6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -19,7 +19,6 @@ if PWM_DEVICES
 config AB8500_PWM
 	bool "AB8500 PWM support"
 	depends on AB8500_CORE
-	select HAVE_PWM
 	help
 	  This driver exports functions to enable/disble/config/free Pulse
 	  Width Modulation in the Analog Baseband Chip AB8500.
@@ -28,7 +27,6 @@ config AB8500_PWM
 config TWL6030_PWM
 	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
 	depends on TWL4030_CORE
-	select HAVE_PWM
 	default n
 	help
 	  Say yes here if you want support for TWL6030 PWM.
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e54a337..c07fc16 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -217,7 +217,7 @@ config BACKLIGHT_CARILLO_RANCH
 
 config BACKLIGHT_PWM
 	tristate "Generic PWM based Backlight Driver"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM_DEVICES
 	help
 	  If you have a LCD backlight adjustable by PWM, say Y to enable
 	  this driver.
-- 
1.7.2.dirty
