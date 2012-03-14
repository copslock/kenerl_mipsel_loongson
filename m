Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:23:40 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34755 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903649Ab2CNJXI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:23:08 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A9A2023C00C1;
        Wed, 14 Mar 2012 09:52:42 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org,
        Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 2/2] MIPS: ath79: Use kmemdup rather than duplicating its implementation
Date:   Wed, 14 Mar 2012 11:28:36 +0100
Message-Id: <1331720916-4015-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331720916-4015-1-git-send-email-juhosg@openwrt.org>
References: <1331720916-4015-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Thomas Meyer <thomas@m3y3r.de>

The semantic patch that makes this change is available
in scripts/coccinelle/api/memdup.cocci.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

 arch/mips/ath79/dev-gpio-buttons.c |    4 +---
 arch/mips/ath79/dev-leds-gpio.c    |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/ath79/dev-gpio-buttons.c b/arch/mips/ath79/dev-gpio-buttons.c
index 4b0168a..366b35f 100644
--- a/arch/mips/ath79/dev-gpio-buttons.c
+++ b/arch/mips/ath79/dev-gpio-buttons.c
@@ -25,12 +25,10 @@ void __init ath79_register_gpio_keys_polled(int id,
 	struct gpio_keys_button *p;
 	int err;
 
-	p = kmalloc(nbuttons * sizeof(*p), GFP_KERNEL);
+	p = kmemdup(buttons, nbuttons * sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return;
 
-	memcpy(p, buttons, nbuttons * sizeof(*p));
-
 	pdev = platform_device_alloc("gpio-keys-polled", id);
 	if (!pdev)
 		goto err_free_buttons;
diff --git a/arch/mips/ath79/dev-leds-gpio.c b/arch/mips/ath79/dev-leds-gpio.c
index cdade68..dcb1deb 100644
--- a/arch/mips/ath79/dev-leds-gpio.c
+++ b/arch/mips/ath79/dev-leds-gpio.c
@@ -24,12 +24,10 @@ void __init ath79_register_leds_gpio(int id,
 	struct gpio_led *p;
 	int err;
 
-	p = kmalloc(num_leds * sizeof(*p), GFP_KERNEL);
+	p = kmemdup(leds, num_leds * sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return;
 
-	memcpy(p, leds, num_leds * sizeof(*p));
-
 	pdev = platform_device_alloc("leds-gpio", id);
 	if (!pdev)
 		goto err_free_leds;
-- 
1.7.2.1
