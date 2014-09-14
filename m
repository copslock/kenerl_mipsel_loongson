Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:36:25 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35889 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008900AbaINTcLGJyGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:32:11 +0200
Received: by mail-lb0-f171.google.com with SMTP id 10so3385802lbg.2
        for <multiple recipients>; Sun, 14 Sep 2014 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O1gdMNvjWBXin9BSXXVrc9VnnvaXt9Ucv54lTDilRqA=;
        b=VKDlQT8jbggjdDW75++uZAjn6X516Ag75x5wuPmUE4VmKYqc+aiVTvvzu3DCW3bbSj
         4I5MW1PPnTuIB7UPjthbnh7WMv3lx1ibHA0wCI7iley+SAsX0dotLb8Xqnu6Nfhh2cST
         wiEn27iQRMNpJMkvnKd/KTeUcceXujeIA0d+fb4PoQXCp+i3OXNqkITFfVp58uoOFxpN
         E3ynDur/HLkWATO+tdTLcTJI2tTxbk9IDpNljvmG6lPl1WAqmTeElVzqDgVJhisBzHIx
         6eZWjg6SaRorCjMm7dJ8titUhZu7Cp9w9iaX/g7mXFg6FtuzBctAOKSIrM7xvcL309QO
         V5xQ==
X-Received: by 10.112.98.140 with SMTP id ei12mr22309688lbb.6.1410723125736;
        Sun, 14 Sep 2014 12:32:05 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.32.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:32:04 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        linux-wireless@vger.kernel.org, ath5k-devel@lists.ath5k.org
Subject: [RFC 16/18] ath5k: correct conditional compilation
Date:   Sun, 14 Sep 2014 23:33:31 +0400
Message-Id: <1410723213-22440-17-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42559
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

This code parts should depend on a config symbol defined in the driver
instead of arch specific one.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-wireless@vger.kernel.org
Cc: ath5k-devel@lists.ath5k.org
---
 drivers/net/wireless/ath/ath5k/ath5k.h | 2 +-
 drivers/net/wireless/ath/ath5k/base.c  | 4 ++--
 drivers/net/wireless/ath/ath5k/led.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

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
index 8ad2550..dd42487 100644
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
index 48a6a69b..c730677 100644
--- a/drivers/net/wireless/ath/ath5k/led.c
+++ b/drivers/net/wireless/ath/ath5k/led.c
@@ -162,7 +162,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
 {
 	int ret = 0;
 	struct ieee80211_hw *hw = ah->hw;
-#ifndef CONFIG_ATHEROS_AR231X
+#ifndef CONFIG_ATH5K_AHB
 	struct pci_dev *pdev = ah->pdev;
 #endif
 	char name[ATH5K_LED_MAX_NAME_LEN + 1];
@@ -171,7 +171,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
 	if (!ah->pdev)
 		return 0;
 
-#ifdef CONFIG_ATHEROS_AR231X
+#ifdef CONFIG_ATH5K_AHB
 	match = NULL;
 #else
 	match = pci_match_id(&ath5k_led_devices[0], pdev);
-- 
1.8.1.5
