Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:53:54 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52662 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817387Ab2LZUwSIzGQB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:52:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id AD7748F60;
        Wed, 26 Dec 2012 21:52:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id feE-deMiR5RG; Wed, 26 Dec 2012 21:52:07 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 4D0128F67;
        Wed, 26 Dec 2012 21:51:48 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] MIPS: BCM47XX: add bcm47xx prefix in front of nvram function names
Date:   Wed, 26 Dec 2012 21:51:14 +0100
Message-Id: <1356555074-1230-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The nvram functions are exported and used by some normal drivers. To
prevent name clashes with ofter parts of the kernel code add a bcm47xx_
prefix in front of the function names and the header file name.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c                                    |    6 +++---
 arch/mips/bcm47xx/setup.c                                    |    6 +++---
 arch/mips/bcm47xx/sprom.c                                    |    8 ++++----
 .../include/asm/mach-bcm47xx/{nvram.h => bcm47xx_nvram.h}    |   10 +++++-----
 drivers/mtd/bcm47xxpart.c                                    |    2 +-
 drivers/net/ethernet/broadcom/b44.c                          |    4 ++--
 drivers/ssb/driver_chipcommon_pmu.c                          |    4 ++--
 include/linux/ssb/ssb_driver_gige.h                          |    6 +++---
 8 files changed, 23 insertions(+), 23 deletions(-)
 rename arch/mips/include/asm/mach-bcm47xx/{nvram.h => bcm47xx_nvram.h} (84%)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index b4a47fc..e63bd5a 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <asm/addrspace.h>
-#include <asm/mach-bcm47xx/nvram.h>
+#include <bcm47xx_nvram.h>
 #include <asm/mach-bcm47xx/bcm47xx.h>
 
 static char nvram_buf[NVRAM_SPACE];
@@ -159,7 +159,7 @@ static int nvram_init(void)
 	return -ENXIO;
 }
 
-int nvram_getenv(char *name, char *val, size_t val_len)
+int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
 	int err;
@@ -189,4 +189,4 @@ int nvram_getenv(char *name, char *val, size_t val_len)
 	}
 	return -ENOENT;
 }
-EXPORT_SYMBOL(nvram_getenv);
+EXPORT_SYMBOL(bcm47xx_nvram_getenv);
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 4d54b58..b2246cd 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -35,7 +35,7 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <asm/mach-bcm47xx/nvram.h>
+#include <bcm47xx_nvram.h>
 
 union bcm47xx_bus bcm47xx_bus;
 EXPORT_SYMBOL(bcm47xx_bus);
@@ -115,7 +115,7 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	memset(&iv->sprom, 0, sizeof(struct ssb_sprom));
 	bcm47xx_fill_sprom(&iv->sprom, NULL, false);
 
-	if (nvram_getenv("cardbus", buf, sizeof(buf)) >= 0)
+	if (bcm47xx_nvram_getenv("cardbus", buf, sizeof(buf)) >= 0)
 		iv->has_cardbus_slot = !!simple_strtoul(buf, NULL, 10);
 
 	return 0;
@@ -138,7 +138,7 @@ static void __init bcm47xx_register_ssb(void)
 		panic("Failed to initialize SSB bus (err %d)", err);
 
 	mcore = &bcm47xx_bus.ssb.mipscore;
-	if (nvram_getenv("kernel_args", buf, sizeof(buf)) >= 0) {
+	if (bcm47xx_nvram_getenv("kernel_args", buf, sizeof(buf)) >= 0) {
 		if (strstr(buf, "console=ttyS1")) {
 			struct ssb_serial_port port;
 
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 66b71c3..89b9bf4 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -27,7 +27,7 @@
  */
 
 #include <bcm47xx.h>
-#include <nvram.h>
+#include <bcm47xx_nvram.h>
 
 static void create_key(const char *prefix, const char *postfix,
 		       const char *name, char *buf, int len)
@@ -50,10 +50,10 @@ static int get_nvram_var(const char *prefix, const char *postfix,
 
 	create_key(prefix, postfix, name, key, sizeof(key));
 
-	err = nvram_getenv(key, buf, len);
+	err = bcm47xx_nvram_getenv(key, buf, len);
 	if (fallback && err == -ENOENT && prefix) {
 		create_key(NULL, postfix, name, key, sizeof(key));
-		err = nvram_getenv(key, buf, len);
+		err = bcm47xx_nvram_getenv(key, buf, len);
 	}
 	return err;
 }
@@ -144,7 +144,7 @@ static void nvram_read_macaddr(const char *prefix, const char *name,
 	if (err < 0)
 		return;
 
-	nvram_parse_macaddr(buf, *val);
+	bcm47xx_nvram_parse_macaddr(buf, *val);
 }
 
 static void nvram_read_alpha2(const char *prefix, const char *name,
diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
similarity index 84%
rename from arch/mips/include/asm/mach-bcm47xx/nvram.h
rename to arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
index 550a7fc..b8e7be8 100644
--- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
@@ -8,8 +8,8 @@
  *  option) any later version.
  */
 
-#ifndef __NVRAM_H
-#define __NVRAM_H
+#ifndef __BCM47XX_NVRAM_H
+#define __BCM47XX_NVRAM_H
 
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -32,9 +32,9 @@ struct nvram_header {
 #define NVRAM_MAX_VALUE_LEN 255
 #define NVRAM_MAX_PARAM_LEN 64
 
-extern int nvram_getenv(char *name, char *val, size_t val_len);
+extern int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len);
 
-static inline void nvram_parse_macaddr(char *buf, u8 macaddr[6])
+static inline void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
 {
 	if (strchr(buf, ':'))
 		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
@@ -48,4 +48,4 @@ static inline void nvram_parse_macaddr(char *buf, u8 macaddr[6])
 		printk(KERN_WARNING "Can not parse mac address: %s\n", buf);
 }
 
-#endif
+#endif /* __BCM47XX_NVRAM_H */
diff --git a/drivers/mtd/bcm47xxpart.c b/drivers/mtd/bcm47xxpart.c
index e06d782..6a11805 100644
--- a/drivers/mtd/bcm47xxpart.c
+++ b/drivers/mtd/bcm47xxpart.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <asm/mach-bcm47xx/nvram.h>
+#include <bcm47xx_nvram.h>
 
 /* 10 parts were found on sflash on Netgear WNDR4500 */
 #define BCM47XXPART_MAX_PARTS		12
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 219f622..330b090 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -381,7 +381,7 @@ static void b44_set_flow_ctrl(struct b44 *bp, u32 local, u32 remote)
 }
 
 #ifdef CONFIG_BCM47XX
-#include <asm/mach-bcm47xx/nvram.h>
+#include <bcm47xx_nvram.h>
 static void b44_wap54g10_workaround(struct b44 *bp)
 {
 	char buf[20];
@@ -393,7 +393,7 @@ static void b44_wap54g10_workaround(struct b44 *bp)
 	 * see https://dev.openwrt.org/ticket/146
 	 * check and reset bit "isolate"
 	 */
-	if (nvram_getenv("boardnum", buf, sizeof(buf)) < 0)
+	if (bcm47xx_nvram_getenv("boardnum", buf, sizeof(buf)) < 0)
 		return;
 	if (simple_strtoul(buf, NULL, 0) == 2) {
 		err = __b44_readphy(bp, 0, MII_BMCR, &val);
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index a43415a..4c0f6d8 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #ifdef CONFIG_BCM47XX
-#include <asm/mach-bcm47xx/nvram.h>
+#include <bcm47xx_nvram.h>
 #endif
 
 #include "ssb_private.h"
@@ -322,7 +322,7 @@ static void ssb_pmu_pll_init(struct ssb_chipcommon *cc)
 	if (bus->bustype == SSB_BUSTYPE_SSB) {
 #ifdef CONFIG_BCM47XX
 		char buf[20];
-		if (nvram_getenv("xtalfreq", buf, sizeof(buf)) >= 0)
+		if (bcm47xx_nvram_getenv("xtalfreq", buf, sizeof(buf)) >= 0)
 			crystalfreq = simple_strtoul(buf, NULL, 0);
 #endif
 	}
diff --git a/include/linux/ssb/ssb_driver_gige.h b/include/linux/ssb/ssb_driver_gige.h
index 6b05dcd..6d92a92 100644
--- a/include/linux/ssb/ssb_driver_gige.h
+++ b/include/linux/ssb/ssb_driver_gige.h
@@ -98,14 +98,14 @@ static inline bool ssb_gige_must_flush_posted_writes(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_BCM47XX
-#include <asm/mach-bcm47xx/nvram.h>
+#include <bcm47xx_nvram.h>
 /* Get the device MAC address */
 static inline void ssb_gige_get_macaddr(struct pci_dev *pdev, u8 *macaddr)
 {
 	char buf[20];
-	if (nvram_getenv("et0macaddr", buf, sizeof(buf)) < 0)
+	if (bcm47xx_nvram_getenv("et0macaddr", buf, sizeof(buf)) < 0)
 		return;
-	nvram_parse_macaddr(buf, macaddr);
+	bcm47xx_nvram_parse_macaddr(buf, macaddr);
 }
 #else
 static inline void ssb_gige_get_macaddr(struct pci_dev *pdev, u8 *macaddr)
-- 
1.7.10.4
