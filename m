Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 22:40:08 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41490 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903615Ab1KTVjb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Nov 2011 22:39:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id D6FC7140462;
        Sun, 20 Nov 2011 22:39:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id btIO72xW0sjT; Sun, 20 Nov 2011 22:39:25 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id E207614044C;
        Sun, 20 Nov 2011 22:39:24 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 2/7] MIPS: ath79: rename pci-ath724x.h
Date:   Sun, 20 Nov 2011 22:39:06 +0100
Message-Id: <1321825151-16053-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16768

The declared function in this header file is used by the
ath79 platform code only. Move the header to the platform
directory.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - move include "pci.h" out of the #ifdef CONFIG_PCI section
v2: - no changes
---
 arch/mips/ath79/mach-ubnt-xm.c                     |    2 +-
 arch/mips/ath79/pci.c                              |    2 +-
 .../asm/mach-ath79/pci-ath724x.h => ath79/pci.h}   |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/mips/{include/asm/mach-ath79/pci-ath724x.h => ath79/pci.h} (100%)

diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
index 3c311a5..a043500 100644
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -15,13 +15,13 @@
 
 #ifdef CONFIG_PCI
 #include <linux/ath9k_platform.h>
-#include <asm/mach-ath79/pci-ath724x.h>
 #endif /* CONFIG_PCI */
 
 #include "machtypes.h"
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
+#include "pci.h"
 
 #define UBNT_XM_GPIO_LED_L1		0
 #define UBNT_XM_GPIO_LED_L2		1
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 8db076e..4957428 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/pci.h>
-#include <asm/mach-ath79/pci-ath724x.h>
+#include "pci.h"
 
 static struct ath724x_pci_data *pci_data;
 static int pci_data_size;
diff --git a/arch/mips/include/asm/mach-ath79/pci-ath724x.h b/arch/mips/ath79/pci.h
similarity index 100%
rename from arch/mips/include/asm/mach-ath79/pci-ath724x.h
rename to arch/mips/ath79/pci.h
-- 
1.7.2.1
