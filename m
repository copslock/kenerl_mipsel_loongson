Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:16:54 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:36360 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904080Ab1KQXQ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:16:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 99FD4140474;
        Fri, 18 Nov 2011 00:16:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EpwmhZ6zHI8k; Fri, 18 Nov 2011 00:16:22 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 0E4811403CC;
        Fri, 18 Nov 2011 00:16:22 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/2] MIPS: ath79: rename dev-ar913x-wmac.c to dev-wmac.c
Date:   Fri, 18 Nov 2011 00:16:01 +0100
Message-Id: <1321571761-17612-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321571761-17612-1-git-send-email-juhosg@openwrt.org>
References: <1321571761-17612-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14936

Rename the file as a last step of the 'ar913x' removal changes.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Makefile                          |    2 +-
 arch/mips/ath79/{dev-ar913x-wmac.c => dev-wmac.c} |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/mips/ath79/{dev-ar913x-wmac.c => dev-wmac.c} (100%)

diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index ac159e6..32c6990 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
 obj-$(CONFIG_ATH79_DEV_USB)		+= dev-usb.o
-obj-$(CONFIG_ATH79_DEV_WMAC)		+= dev-ar913x-wmac.o
+obj-$(CONFIG_ATH79_DEV_WMAC)		+= dev-wmac.o
 
 #
 # Machines
diff --git a/arch/mips/ath79/dev-ar913x-wmac.c b/arch/mips/ath79/dev-wmac.c
similarity index 100%
rename from arch/mips/ath79/dev-ar913x-wmac.c
rename to arch/mips/ath79/dev-wmac.c
-- 
1.7.2.1
