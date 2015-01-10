Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 19:27:45 +0100 (CET)
Received: from smtp-out-109.synserver.de ([212.40.185.109]:1063 "EHLO
        smtp-out-109.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011155AbbAJS12nDqMF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2015 19:27:28 +0100
Received: (qmail 6936 invoked by uid 0); 10 Jan 2015 18:27:27 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 6744
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [88.217.3.222]
  by 217.119.54.96 with SMTP; 10 Jan 2015 18:27:27 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] MIPS: qi_lb60: Register watchdog device
Date:   Sat, 10 Jan 2015 19:29:09 +0100
Message-Id: <1420914550-18335-2-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1420914550-18335-1-git-send-email-lars@metafoo.de>
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45053
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

The next commit will move the restart code to the watchdog driver. So for
restart to continue to work we need to register the watchdog device.

Also enable the watchdog driver in the default config.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/configs/qi_lb60_defconfig |    2 ++
 arch/mips/jz4740/board-qi_lb60.c    |    1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index 2b96547..ce06a92 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -73,6 +73,8 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_JZ4740=y
 CONFIG_CHARGER_GPIO=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_JZ4740_WDT=y
 CONFIG_MFD_JZ4740_ADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index c454525..a00f134 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -436,6 +436,7 @@ static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
 };
 
 static struct platform_device *jz_platform_devices[] __initdata = {
+	&jz4740_wdt_device,
 	&jz4740_udc_device,
 	&jz4740_udc_xceiv_device,
 	&jz4740_mmc_device,
-- 
1.7.10.4
