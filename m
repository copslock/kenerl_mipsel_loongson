Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:22:29 +0100 (CET)
Received: from mail-la0-f54.google.com ([209.85.215.54]:45807 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011494AbaJ1XTNopqst (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:19:13 +0100
Received: by mail-la0-f54.google.com with SMTP id gm9so1528956lab.41
        for <multiple recipients>; Tue, 28 Oct 2014 16:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kd3cnPjcOiV90welv+CnEGyn2Lqq2rcxJSwoz2CE8oY=;
        b=jOddlo8aXFaXRmmXbGsGgwqPMTk+zz3vV18zlhwWd0bStRkCQ3RUPF+O0KfE88/mgp
         paisM2U4vi/wsYCt4BUTwYIb7Wtzr4kCuTUAWm8tJyKwA7rLvFWI7PSpU31U55HNnOjV
         I4WHZXIsmoLvpCLlftYnu1kdN2BrPYT9HgAYwNo22waO3sV/f1hZPgIJJYMzVdkyfL2l
         e+T8ZYNoAXhflFVICUOfdqbZCiuoPPN4w4uxNvO2bC9ByJwntsGIA36dkeNzmxi5PPzC
         4wgRf3efgiwkgqIDw14nbTfllFJpakcBylehkWPd9H62fuidNihzVAolJBa3BOy3ePqv
         i2AA==
X-Received: by 10.152.116.68 with SMTP id ju4mr7341301lab.13.1414538348309;
        Tue, 28 Oct 2014 16:19:08 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.19.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:19:07 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        linux-wireless@vger.kernel.org, ath5k-devel@lists.ath5k.org
Subject: [PATCH v3 12/13] ath5k: update dependencies
Date:   Wed, 29 Oct 2014 03:18:49 +0400
Message-Id: <1414538330-5548-13-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

- Use config symbol defined in the driver instead of arch specific one for
  conditional compilation.
- Rename the ATHEROS_AR231X config symbol to ATH25.
- Fix include (ar231x_platform.h -> ath25_platform.h).
- Some of AR231x SoCs (e.g. AR2315) have PCI bus support, so remove !PCI
  dependency, which block AHB support build.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Acked-by: John W. Linville <linville@tuxdriver.com>
Cc: Jiri Slaby <jirislaby@gmail.com>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-wireless@vger.kernel.org
Cc: ath5k-devel@lists.ath5k.org
---

Changes since RFC:
  - merge together patches that update ath5k dependencies

Changes since v1:
  - rename config symbol AR231X -> ATH25
  - rename arch header ar231x_platform.h -> ath25_platform.h

 drivers/net/wireless/ath/ath5k/Kconfig | 10 +++++-----
 drivers/net/wireless/ath/ath5k/ahb.c   |  2 +-
 drivers/net/wireless/ath/ath5k/ath5k.h |  2 +-
 drivers/net/wireless/ath/ath5k/base.c  |  4 ++--
 drivers/net/wireless/ath/ath5k/led.c   |  4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/Kconfig b/drivers/net/wireless/ath/ath5k/Kconfig
index c9f81a3..2399a39 100644
--- a/drivers/net/wireless/ath/ath5k/Kconfig
+++ b/drivers/net/wireless/ath/ath5k/Kconfig
@@ -1,13 +1,13 @@
 config ATH5K
 	tristate "Atheros 5xxx wireless cards support"
-	depends on (PCI || ATHEROS_AR231X) && MAC80211
+	depends on (PCI || ATH25) && MAC80211
 	select ATH_COMMON
 	select MAC80211_LEDS
 	select LEDS_CLASS
 	select NEW_LEDS
 	select AVERAGE
-	select ATH5K_AHB if (ATHEROS_AR231X && !PCI)
-	select ATH5K_PCI if (!ATHEROS_AR231X && PCI)
+	select ATH5K_AHB if ATH25
+	select ATH5K_PCI if !ATH25
 	---help---
 	  This module adds support for wireless adapters based on
 	  Atheros 5xxx chipset.
@@ -54,14 +54,14 @@ config ATH5K_TRACER
 
 config ATH5K_AHB
 	bool "Atheros 5xxx AHB bus support"
-	depends on (ATHEROS_AR231X && !PCI)
+	depends on ATH25
 	---help---
 	  This adds support for WiSoC type chipsets of the 5xxx Atheros
 	  family.
 
 config ATH5K_PCI
 	bool "Atheros 5xxx PCI bus support"
-	depends on (!ATHEROS_AR231X && PCI)
+	depends on (!ATH25 && PCI)
 	---help---
 	  This adds support for PCI type chipsets of the 5xxx Atheros
 	  family.
diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
index 79bffe1..8f387cf 100644
--- a/drivers/net/wireless/ath/ath5k/ahb.c
+++ b/drivers/net/wireless/ath/ath5k/ahb.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/etherdevice.h>
 #include <linux/export.h>
-#include <ar231x_platform.h>
+#include <ath25_platform.h>
 #include "ath5k.h"
 #include "debug.h"
 #include "base.h"
diff --git a/drivers/net/wireless/ath/ath5k/ath5k.h b/drivers/net/wireless/ath/ath5k/ath5k.h
index 85316bb..1ed7a88 100644
--- a/drivers/net/wireless/ath/ath5k/ath5k.h
+++ b/drivers/net/wireless/ath/ath5k/ath5k.h
@@ -1647,7 +1647,7 @@ static inline struct ath_regulatory *ath5k_hw_regulatory(struct ath5k_hw *ah)
 	return &(ath5k_hw_common(ah)->regulatory);
 }
 
-#ifdef CONFIG_ATHEROS_AR231X
+#ifdef CONFIG_ATH5K_AHB
 #define AR5K_AR2315_PCI_BASE	((void __iomem *)0xb0100000)
 
 static inline void __iomem *ath5k_ahb_reg(struct ath5k_hw *ah, u16 reg)
diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 59a8724..bc9cb35 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -99,7 +99,7 @@ static int ath5k_reset(struct ath5k_hw *ah, struct ieee80211_channel *chan,
 
 /* Known SREVs */
 static const struct ath5k_srev_name srev_names[] = {
-#ifdef CONFIG_ATHEROS_AR231X
+#ifdef CONFIG_ATH5K_AHB
 	{ "5312",	AR5K_VERSION_MAC,	AR5K_SREV_AR5312_R2 },
 	{ "5312",	AR5K_VERSION_MAC,	AR5K_SREV_AR5312_R7 },
 	{ "2313",	AR5K_VERSION_MAC,	AR5K_SREV_AR2313_R8 },
@@ -142,7 +142,7 @@ static const struct ath5k_srev_name srev_names[] = {
 	{ "5413",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_5413 },
 	{ "5424",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_5424 },
 	{ "5133",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_5133 },
-#ifdef CONFIG_ATHEROS_AR231X
+#ifdef CONFIG_ATH5K_AHB
 	{ "2316",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_2316 },
 	{ "2317",	AR5K_VERSION_RAD,	AR5K_SREV_RAD_2317 },
 #endif
diff --git a/drivers/net/wireless/ath/ath5k/led.c b/drivers/net/wireless/ath/ath5k/led.c
index 2062d11..ca4b7cc 100644
--- a/drivers/net/wireless/ath/ath5k/led.c
+++ b/drivers/net/wireless/ath/ath5k/led.c
@@ -163,7 +163,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
 {
 	int ret = 0;
 	struct ieee80211_hw *hw = ah->hw;
-#ifndef CONFIG_ATHEROS_AR231X
+#ifndef CONFIG_ATH5K_AHB
 	struct pci_dev *pdev = ah->pdev;
 #endif
 	char name[ATH5K_LED_MAX_NAME_LEN + 1];
@@ -172,7 +172,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
 	if (!ah->pdev)
 		return 0;
 
-#ifdef CONFIG_ATHEROS_AR231X
+#ifdef CONFIG_ATH5K_AHB
 	match = NULL;
 #else
 	match = pci_match_id(&ath5k_led_devices[0], pdev);
-- 
1.8.5.5
