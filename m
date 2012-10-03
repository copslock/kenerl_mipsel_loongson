Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:45:36 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:56714 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6902617Ab2JDJmslhZLd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 11:42:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B393F8F6C;
        Wed,  3 Oct 2012 14:34:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ol5dqfzEHkqD; Wed,  3 Oct 2012 14:34:39 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 7AB478F65;
        Wed,  3 Oct 2012 14:34:24 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 5/5] MIPS: BCM47xx: sprom: read values without prefix as fallback
Date:   Wed,  3 Oct 2012 14:34:20 +0200
Message-Id: <1349267660-31845-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349267660-31845-1-git-send-email-hauke@hauke-m.de>
References: <1349267660-31845-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34573
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

There are bcma based devices like the Linksys E2000 out there, which do
have one ieee80211 core, but no PCIe core and they are using no
prefixes for the sprom. In addition some values like boardtype are
stored without a prefix for the main SoC chip also when they have an
additional PCIe wifi chip with an own boardtype var on some devices.

The Ethernet addresses are now also read out correctly without a prefix
so calling bcm47xx_fill_sprom_ethernet is not needed any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c                    |   11 +-
 arch/mips/bcm47xx/sprom.c                    |  766 +++++++++++++++-----------
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    4 +-
 3 files changed, 449 insertions(+), 332 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 803764d..4d54b58 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -94,7 +94,7 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
 			 bus->host_pci->bus->number + 1,
 			 PCI_SLOT(bus->host_pci->devfn));
-		bcm47xx_fill_sprom(out, prefix);
+		bcm47xx_fill_sprom(out, prefix, false);
 		return 0;
 	} else {
 		printk(KERN_WARNING "bcm47xx: unable to fill SPROM for given bustype.\n");
@@ -113,7 +113,7 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	bcm47xx_fill_ssb_boardinfo(&iv->boardinfo, NULL);
 
 	memset(&iv->sprom, 0, sizeof(struct ssb_sprom));
-	bcm47xx_fill_sprom(&iv->sprom, NULL);
+	bcm47xx_fill_sprom(&iv->sprom, NULL, false);
 
 	if (nvram_getenv("cardbus", buf, sizeof(buf)) >= 0)
 		iv->has_cardbus_slot = !!simple_strtoul(buf, NULL, 10);
@@ -165,18 +165,17 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
 			 bus->host_pci->bus->number + 1,
 			 PCI_SLOT(bus->host_pci->devfn));
-		bcm47xx_fill_sprom(out, prefix);
+		bcm47xx_fill_sprom(out, prefix, false);
 		return 0;
 	case BCMA_HOSTTYPE_SOC:
 		memset(out, 0, sizeof(struct ssb_sprom));
-		bcm47xx_fill_sprom_ethernet(out, NULL);
 		core = bcma_find_core(bus, BCMA_CORE_80211);
 		if (core) {
 			snprintf(prefix, sizeof(prefix), "sb/%u/",
 				 core->core_index);
-			bcm47xx_fill_sprom(out, prefix);
+			bcm47xx_fill_sprom(out, prefix, true);
 		} else {
-			bcm47xx_fill_sprom(out, NULL);
+			bcm47xx_fill_sprom(out, NULL, false);
 		}
 		return 0;
 	default:
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 7fa3da3..289cc0a 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -42,25 +42,39 @@ static void create_key(const char *prefix, const char *postfix,
 		snprintf(buf, len, "%s", name);
 }
 
+static int get_nvram_var(const char *prefix, const char *postfix,
+			 const char *name, char *buf, int len, bool fallback)
+{
+	char key[40];
+	int err;
+
+	create_key(prefix, postfix, name, key, sizeof(key));
+
+	err = nvram_getenv(key, buf, len);
+	if (fallback && err == NVRAM_ERR_ENVNOTFOUND && prefix) {
+		create_key(NULL, postfix, name, key, sizeof(key));
+		err = nvram_getenv(key, buf, len);
+	}
+	return err;
+}
+
 #define NVRAM_READ_VAL(type)						\
 static void nvram_read_ ## type (const char *prefix,			\
 				 const char *postfix, const char *name,	\
-				 type *val, type allset)		\
+				 type *val, type allset, bool fallback)	\
 {									\
 	char buf[100];							\
-	char key[40];							\
 	int err;							\
 	type var;							\
 									\
-	create_key(prefix, postfix, name, key, sizeof(key));		\
-									\
-	err = nvram_getenv(key, buf, sizeof(buf));			\
+	err = get_nvram_var(prefix, postfix, name, buf, sizeof(buf),	\
+			    fallback);					\
 	if (err < 0)							\
 		return;							\
 	err = kstrto ## type (buf, 0, &var);				\
 	if (err) {							\
-		pr_warn("can not parse nvram name %s with value %s"	\
-			" got %i", key, buf, err);			\
+		pr_warn("can not parse nvram name %s%s%s with value %s got %i\n",	\
+			prefix, name, postfix, buf, err);		\
 		return;							\
 	}								\
 	if (allset && var == allset)					\
@@ -76,22 +90,19 @@ NVRAM_READ_VAL(u32)
 #undef NVRAM_READ_VAL
 
 static void nvram_read_u32_2(const char *prefix, const char *name,
-			     u16 *val_lo, u16 *val_hi)
+			     u16 *val_lo, u16 *val_hi, bool fallback)
 {
 	char buf[100];
-	char key[40];
 	int err;
 	u32 val;
 
-	create_key(prefix, NULL, name, key, sizeof(key));
-
-	err = nvram_getenv(key, buf, sizeof(buf));
+	err = get_nvram_var(prefix, NULL, name, buf, sizeof(buf), fallback);
 	if (err < 0)
 		return;
 	err = kstrtou32(buf, 0, &val);
 	if (err) {
-		pr_warn("can not parse nvram name %s with value %s got %i",
-			key, buf, err);
+		pr_warn("can not parse nvram name %s%s with value %s got %i\n",
+			prefix, name, buf, err);
 		return;
 	}
 	*val_lo = (val & 0x0000FFFFU);
@@ -99,22 +110,20 @@ static void nvram_read_u32_2(const char *prefix, const char *name,
 }
 
 static void nvram_read_leddc(const char *prefix, const char *name,
-			     u8 *leddc_on_time, u8 *leddc_off_time)
+			     u8 *leddc_on_time, u8 *leddc_off_time,
+			     bool fallback)
 {
 	char buf[100];
-	char key[40];
 	int err;
 	u32 val;
 
-	create_key(prefix, NULL, name, key, sizeof(key));
-
-	err = nvram_getenv(key, buf, sizeof(buf));
+	err = get_nvram_var(prefix, NULL, name, buf, sizeof(buf), fallback);
 	if (err < 0)
 		return;
 	err = kstrtou32(buf, 0, &val);
 	if (err) {
-		pr_warn("can not parse nvram name %s with value %s got %i",
-			key, buf, err);
+		pr_warn("can not parse nvram name %s%s with value %s got %i\n",
+			prefix, name, buf, err);
 		return;
 	}
 
@@ -126,336 +135,435 @@ static void nvram_read_leddc(const char *prefix, const char *name,
 }
 
 static void nvram_read_macaddr(const char *prefix, const char *name,
-			       u8 (*val)[6])
+			       u8 (*val)[6], bool fallback)
 {
 	char buf[100];
-	char key[40];
 	int err;
 
-	create_key(prefix, NULL, name, key, sizeof(key));
-
-	err = nvram_getenv(key, buf, sizeof(buf));
+	err = get_nvram_var(prefix, NULL, name, buf, sizeof(buf), fallback);
 	if (err < 0)
 		return;
+
 	nvram_parse_macaddr(buf, *val);
 }
 
 static void nvram_read_alpha2(const char *prefix, const char *name,
-			     char (*val)[2])
+			     char (*val)[2], bool fallback)
 {
 	char buf[10];
-	char key[40];
 	int err;
 
-	create_key(prefix, NULL, name, key, sizeof(key));
-
-	err = nvram_getenv(key, buf, sizeof(buf));
+	err = get_nvram_var(prefix, NULL, name, buf, sizeof(buf), fallback);
 	if (err < 0)
 		return;
 	if (buf[0] == '0')
 		return;
 	if (strlen(buf) > 2) {
-		pr_warn("alpha2 is too long %s", buf);
+		pr_warn("alpha2 is too long %s\n", buf);
 		return;
 	}
 	memcpy(val, buf, sizeof(val));
 }
 
 static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
-					const char *prefix)
+					const char *prefix, bool fallback)
 {
-	nvram_read_u8(prefix, NULL, "ledbh0", &sprom->gpio0, 0xff);
-	nvram_read_u8(prefix, NULL, "ledbh1", &sprom->gpio1, 0xff);
-	nvram_read_u8(prefix, NULL, "ledbh2", &sprom->gpio2, 0xff);
-	nvram_read_u8(prefix, NULL, "ledbh3", &sprom->gpio3, 0xff);
-	nvram_read_u8(prefix, NULL, "aa2g", &sprom->ant_available_bg, 0);
-	nvram_read_u8(prefix, NULL, "aa5g", &sprom->ant_available_a, 0);
-	nvram_read_s8(prefix, NULL, "ag0", &sprom->antenna_gain.a0, 0);
-	nvram_read_s8(prefix, NULL, "ag1", &sprom->antenna_gain.a1, 0);
-	nvram_read_alpha2(prefix, "ccode", &sprom->alpha2);
+	nvram_read_u8(prefix, NULL, "ledbh0", &sprom->gpio0, 0xff, fallback);
+	nvram_read_u8(prefix, NULL, "ledbh1", &sprom->gpio1, 0xff, fallback);
+	nvram_read_u8(prefix, NULL, "ledbh2", &sprom->gpio2, 0xff, fallback);
+	nvram_read_u8(prefix, NULL, "ledbh3", &sprom->gpio3, 0xff, fallback);
+	nvram_read_u8(prefix, NULL, "aa2g", &sprom->ant_available_bg, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "aa5g", &sprom->ant_available_a, 0,
+		      fallback);
+	nvram_read_s8(prefix, NULL, "ag0", &sprom->antenna_gain.a0, 0,
+		      fallback);
+	nvram_read_s8(prefix, NULL, "ag1", &sprom->antenna_gain.a1, 0,
+		      fallback);
+	nvram_read_alpha2(prefix, "ccode", &sprom->alpha2, fallback);
 }
 
 static void bcm47xx_fill_sprom_r12389(struct ssb_sprom *sprom,
-				      const char *prefix)
+				      const char *prefix, bool fallback)
 {
-	nvram_read_u16(prefix, NULL, "pa0b0", &sprom->pa0b0, 0);
-	nvram_read_u16(prefix, NULL, "pa0b1", &sprom->pa0b1, 0);
-	nvram_read_u16(prefix, NULL, "pa0b2", &sprom->pa0b2, 0);
-	nvram_read_u8(prefix, NULL, "pa0itssit", &sprom->itssi_bg, 0);
-	nvram_read_u8(prefix, NULL, "pa0maxpwr", &sprom->maxpwr_bg, 0);
-	nvram_read_u16(prefix, NULL, "pa1b0", &sprom->pa1b0, 0);
-	nvram_read_u16(prefix, NULL, "pa1b1", &sprom->pa1b1, 0);
-	nvram_read_u16(prefix, NULL, "pa1b2", &sprom->pa1b2, 0);
-	nvram_read_u8(prefix, NULL, "pa1itssit", &sprom->itssi_a, 0);
-	nvram_read_u8(prefix, NULL, "pa1maxpwr", &sprom->maxpwr_a, 0);
+	nvram_read_u16(prefix, NULL, "pa0b0", &sprom->pa0b0, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa0b1", &sprom->pa0b1, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa0b2", &sprom->pa0b2, 0, fallback);
+	nvram_read_u8(prefix, NULL, "pa0itssit", &sprom->itssi_bg, 0, fallback);
+	nvram_read_u8(prefix, NULL, "pa0maxpwr", &sprom->maxpwr_bg, 0,
+		      fallback);
+	nvram_read_u16(prefix, NULL, "pa1b0", &sprom->pa1b0, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1b1", &sprom->pa1b1, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1b2", &sprom->pa1b2, 0, fallback);
+	nvram_read_u8(prefix, NULL, "pa1itssit", &sprom->itssi_a, 0, fallback);
+	nvram_read_u8(prefix, NULL, "pa1maxpwr", &sprom->maxpwr_a, 0, fallback);
 }
 
-static void bcm47xx_fill_sprom_r1(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_r1(struct ssb_sprom *sprom, const char *prefix,
+				  bool fallback)
 {
-	nvram_read_u16(prefix, NULL, "boardflags", &sprom->boardflags_lo, 0);
-	nvram_read_u8(prefix, NULL, "cc", &sprom->country_code, 0);
+	nvram_read_u16(prefix, NULL, "boardflags", &sprom->boardflags_lo, 0,
+		       fallback);
+	nvram_read_u8(prefix, NULL, "cc", &sprom->country_code, 0, fallback);
 }
 
 static void bcm47xx_fill_sprom_r2389(struct ssb_sprom *sprom,
-				     const char *prefix)
+				     const char *prefix, bool fallback)
 {
-	nvram_read_u8(prefix, NULL, "opo", &sprom->opo, 0);
-	nvram_read_u16(prefix, NULL, "pa1lob0", &sprom->pa1lob0, 0);
-	nvram_read_u16(prefix, NULL, "pa1lob1", &sprom->pa1lob1, 0);
-	nvram_read_u16(prefix, NULL, "pa1lob2", &sprom->pa1lob2, 0);
-	nvram_read_u16(prefix, NULL, "pa1hib0", &sprom->pa1hib0, 0);
-	nvram_read_u16(prefix, NULL, "pa1hib1", &sprom->pa1hib1, 0);
-	nvram_read_u16(prefix, NULL, "pa1hib2", &sprom->pa1hib2, 0);
-	nvram_read_u8(prefix, NULL, "pa1lomaxpwr", &sprom->maxpwr_al, 0);
-	nvram_read_u8(prefix, NULL, "pa1himaxpwr", &sprom->maxpwr_ah, 0);
+	nvram_read_u8(prefix, NULL, "opo", &sprom->opo, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1lob0", &sprom->pa1lob0, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1lob1", &sprom->pa1lob1, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1lob2", &sprom->pa1lob2, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1hib0", &sprom->pa1hib0, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1hib1", &sprom->pa1hib1, 0, fallback);
+	nvram_read_u16(prefix, NULL, "pa1hib2", &sprom->pa1hib2, 0, fallback);
+	nvram_read_u8(prefix, NULL, "pa1lomaxpwr", &sprom->maxpwr_al, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "pa1himaxpwr", &sprom->maxpwr_ah, 0,
+		      fallback);
 }
 
-static void bcm47xx_fill_sprom_r389(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_r389(struct ssb_sprom *sprom, const char *prefix,
+				    bool fallback)
 {
-	nvram_read_u8(prefix, NULL, "bxa2g", &sprom->bxa2g, 0);
-	nvram_read_u8(prefix, NULL, "rssisav2g", &sprom->rssisav2g, 0);
-	nvram_read_u8(prefix, NULL, "rssismc2g", &sprom->rssismc2g, 0);
-	nvram_read_u8(prefix, NULL, "rssismf2g", &sprom->rssismf2g, 0);
-	nvram_read_u8(prefix, NULL, "bxa5g", &sprom->bxa5g, 0);
-	nvram_read_u8(prefix, NULL, "rssisav5g", &sprom->rssisav5g, 0);
-	nvram_read_u8(prefix, NULL, "rssismc5g", &sprom->rssismc5g, 0);
-	nvram_read_u8(prefix, NULL, "rssismf5g", &sprom->rssismf5g, 0);
-	nvram_read_u8(prefix, NULL, "tri2g", &sprom->tri2g, 0);
-	nvram_read_u8(prefix, NULL, "tri5g", &sprom->tri5g, 0);
-	nvram_read_u8(prefix, NULL, "tri5gl", &sprom->tri5gl, 0);
-	nvram_read_u8(prefix, NULL, "tri5gh", &sprom->tri5gh, 0);
-	nvram_read_s8(prefix, NULL, "rxpo2g", &sprom->rxpo2g, 0);
-	nvram_read_s8(prefix, NULL, "rxpo5g", &sprom->rxpo5g, 0);
+	nvram_read_u8(prefix, NULL, "bxa2g", &sprom->bxa2g, 0, fallback);
+	nvram_read_u8(prefix, NULL, "rssisav2g", &sprom->rssisav2g, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "rssismc2g", &sprom->rssismc2g, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "rssismf2g", &sprom->rssismf2g, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "bxa5g", &sprom->bxa5g, 0, fallback);
+	nvram_read_u8(prefix, NULL, "rssisav5g", &sprom->rssisav5g, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "rssismc5g", &sprom->rssismc5g, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "rssismf5g", &sprom->rssismf5g, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "tri2g", &sprom->tri2g, 0, fallback);
+	nvram_read_u8(prefix, NULL, "tri5g", &sprom->tri5g, 0, fallback);
+	nvram_read_u8(prefix, NULL, "tri5gl", &sprom->tri5gl, 0, fallback);
+	nvram_read_u8(prefix, NULL, "tri5gh", &sprom->tri5gh, 0, fallback);
+	nvram_read_s8(prefix, NULL, "rxpo2g", &sprom->rxpo2g, 0, fallback);
+	nvram_read_s8(prefix, NULL, "rxpo5g", &sprom->rxpo5g, 0, fallback);
 }
 
-static void bcm47xx_fill_sprom_r3(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_r3(struct ssb_sprom *sprom, const char *prefix,
+				  bool fallback)
 {
-	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0);
+	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0, fallback);
 	nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
-			 &sprom->leddc_off_time);
+			 &sprom->leddc_off_time, fallback);
 }
 
 static void bcm47xx_fill_sprom_r4589(struct ssb_sprom *sprom,
-				     const char *prefix)
+				     const char *prefix, bool fallback)
 {
-	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0);
-	nvram_read_s8(prefix, NULL, "ag2", &sprom->antenna_gain.a2, 0);
-	nvram_read_s8(prefix, NULL, "ag3", &sprom->antenna_gain.a3, 0);
-	nvram_read_u8(prefix, NULL, "txchain", &sprom->txchain, 0xf);
-	nvram_read_u8(prefix, NULL, "rxchain", &sprom->rxchain, 0xf);
-	nvram_read_u8(prefix, NULL, "antswitch", &sprom->antswitch, 0xff);
+	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0, fallback);
+	nvram_read_s8(prefix, NULL, "ag2", &sprom->antenna_gain.a2, 0,
+		      fallback);
+	nvram_read_s8(prefix, NULL, "ag3", &sprom->antenna_gain.a3, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txchain", &sprom->txchain, 0xf, fallback);
+	nvram_read_u8(prefix, NULL, "rxchain", &sprom->rxchain, 0xf, fallback);
+	nvram_read_u8(prefix, NULL, "antswitch", &sprom->antswitch, 0xff,
+		      fallback);
 	nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
-			 &sprom->leddc_off_time);
+			 &sprom->leddc_off_time, fallback);
 }
 
-static void bcm47xx_fill_sprom_r458(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_r458(struct ssb_sprom *sprom, const char *prefix,
+				    bool fallback)
 {
-	nvram_read_u16(prefix, NULL, "cck2gpo", &sprom->cck2gpo, 0);
-	nvram_read_u32(prefix, NULL, "ofdm2gpo", &sprom->ofdm2gpo, 0);
-	nvram_read_u32(prefix, NULL, "ofdm5gpo", &sprom->ofdm5gpo, 0);
-	nvram_read_u32(prefix, NULL, "ofdm5glpo", &sprom->ofdm5glpo, 0);
-	nvram_read_u32(prefix, NULL, "ofdm5ghpo", &sprom->ofdm5ghpo, 0);
-	nvram_read_u16(prefix, NULL, "cddpo", &sprom->cddpo, 0);
-	nvram_read_u16(prefix, NULL, "stbcpo", &sprom->stbcpo, 0);
-	nvram_read_u16(prefix, NULL, "bw40po", &sprom->bw40po, 0);
-	nvram_read_u16(prefix, NULL, "bwduppo", &sprom->bwduppo, 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo0", &sprom->mcs2gpo[0], 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo1", &sprom->mcs2gpo[1], 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo2", &sprom->mcs2gpo[2], 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo3", &sprom->mcs2gpo[3], 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo4", &sprom->mcs2gpo[4], 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo5", &sprom->mcs2gpo[5], 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo6", &sprom->mcs2gpo[6], 0);
-	nvram_read_u16(prefix, NULL, "mcs2gpo7", &sprom->mcs2gpo[7], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo0", &sprom->mcs5gpo[0], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo1", &sprom->mcs5gpo[1], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo2", &sprom->mcs5gpo[2], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo3", &sprom->mcs5gpo[3], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo4", &sprom->mcs5gpo[4], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo5", &sprom->mcs5gpo[5], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo6", &sprom->mcs5gpo[6], 0);
-	nvram_read_u16(prefix, NULL, "mcs5gpo7", &sprom->mcs5gpo[7], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo0", &sprom->mcs5glpo[0], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo1", &sprom->mcs5glpo[1], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo2", &sprom->mcs5glpo[2], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo3", &sprom->mcs5glpo[3], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo4", &sprom->mcs5glpo[4], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo5", &sprom->mcs5glpo[5], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo6", &sprom->mcs5glpo[6], 0);
-	nvram_read_u16(prefix, NULL, "mcs5glpo7", &sprom->mcs5glpo[7], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo0", &sprom->mcs5ghpo[0], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo1", &sprom->mcs5ghpo[1], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo2", &sprom->mcs5ghpo[2], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo3", &sprom->mcs5ghpo[3], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo4", &sprom->mcs5ghpo[4], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo5", &sprom->mcs5ghpo[5], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo6", &sprom->mcs5ghpo[6], 0);
-	nvram_read_u16(prefix, NULL, "mcs5ghpo7", &sprom->mcs5ghpo[7], 0);
+	nvram_read_u16(prefix, NULL, "cck2gpo", &sprom->cck2gpo, 0, fallback);
+	nvram_read_u32(prefix, NULL, "ofdm2gpo", &sprom->ofdm2gpo, 0, fallback);
+	nvram_read_u32(prefix, NULL, "ofdm5gpo", &sprom->ofdm5gpo, 0, fallback);
+	nvram_read_u32(prefix, NULL, "ofdm5glpo", &sprom->ofdm5glpo, 0,
+		       fallback);
+	nvram_read_u32(prefix, NULL, "ofdm5ghpo", &sprom->ofdm5ghpo, 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "cddpo", &sprom->cddpo, 0, fallback);
+	nvram_read_u16(prefix, NULL, "stbcpo", &sprom->stbcpo, 0, fallback);
+	nvram_read_u16(prefix, NULL, "bw40po", &sprom->bw40po, 0, fallback);
+	nvram_read_u16(prefix, NULL, "bwduppo", &sprom->bwduppo, 0, fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo0", &sprom->mcs2gpo[0], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo1", &sprom->mcs2gpo[1], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo2", &sprom->mcs2gpo[2], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo3", &sprom->mcs2gpo[3], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo4", &sprom->mcs2gpo[4], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo5", &sprom->mcs2gpo[5], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo6", &sprom->mcs2gpo[6], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs2gpo7", &sprom->mcs2gpo[7], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo0", &sprom->mcs5gpo[0], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo1", &sprom->mcs5gpo[1], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo2", &sprom->mcs5gpo[2], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo3", &sprom->mcs5gpo[3], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo4", &sprom->mcs5gpo[4], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo5", &sprom->mcs5gpo[5], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo6", &sprom->mcs5gpo[6], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5gpo7", &sprom->mcs5gpo[7], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo0", &sprom->mcs5glpo[0], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo1", &sprom->mcs5glpo[1], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo2", &sprom->mcs5glpo[2], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo3", &sprom->mcs5glpo[3], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo4", &sprom->mcs5glpo[4], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo5", &sprom->mcs5glpo[5], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo6", &sprom->mcs5glpo[6], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5glpo7", &sprom->mcs5glpo[7], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo0", &sprom->mcs5ghpo[0], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo1", &sprom->mcs5ghpo[1], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo2", &sprom->mcs5ghpo[2], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo3", &sprom->mcs5ghpo[3], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo4", &sprom->mcs5ghpo[4], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo5", &sprom->mcs5ghpo[5], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo6", &sprom->mcs5ghpo[6], 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo7", &sprom->mcs5ghpo[7], 0,
+		       fallback);
 }
 
-static void bcm47xx_fill_sprom_r45(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_r45(struct ssb_sprom *sprom, const char *prefix,
+				   bool fallback)
 {
-	nvram_read_u8(prefix, NULL, "txpid2ga0", &sprom->txpid2g[0], 0);
-	nvram_read_u8(prefix, NULL, "txpid2ga1", &sprom->txpid2g[1], 0);
-	nvram_read_u8(prefix, NULL, "txpid2ga2", &sprom->txpid2g[2], 0);
-	nvram_read_u8(prefix, NULL, "txpid2ga3", &sprom->txpid2g[3], 0);
-	nvram_read_u8(prefix, NULL, "txpid5ga0", &sprom->txpid5g[0], 0);
-	nvram_read_u8(prefix, NULL, "txpid5ga1", &sprom->txpid5g[1], 0);
-	nvram_read_u8(prefix, NULL, "txpid5ga2", &sprom->txpid5g[2], 0);
-	nvram_read_u8(prefix, NULL, "txpid5ga3", &sprom->txpid5g[3], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gla0", &sprom->txpid5gl[0], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gla1", &sprom->txpid5gl[1], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gla2", &sprom->txpid5gl[2], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gla3", &sprom->txpid5gl[3], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gha0", &sprom->txpid5gh[0], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gha1", &sprom->txpid5gh[1], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gha2", &sprom->txpid5gh[2], 0);
-	nvram_read_u8(prefix, NULL, "txpid5gha3", &sprom->txpid5gh[3], 0);
+	nvram_read_u8(prefix, NULL, "txpid2ga0", &sprom->txpid2g[0], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid2ga1", &sprom->txpid2g[1], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid2ga2", &sprom->txpid2g[2], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid2ga3", &sprom->txpid2g[3], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5ga0", &sprom->txpid5g[0], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5ga1", &sprom->txpid5g[1], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5ga2", &sprom->txpid5g[2], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5ga3", &sprom->txpid5g[3], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gla0", &sprom->txpid5gl[0], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gla1", &sprom->txpid5gl[1], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gla2", &sprom->txpid5gl[2], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gla3", &sprom->txpid5gl[3], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gha0", &sprom->txpid5gh[0], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gha1", &sprom->txpid5gh[1], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gha2", &sprom->txpid5gh[2], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "txpid5gha3", &sprom->txpid5gh[3], 0,
+		      fallback);
 }
 
-static void bcm47xx_fill_sprom_r89(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_r89(struct ssb_sprom *sprom, const char *prefix,
+				   bool fallback)
 {
-	nvram_read_u8(prefix, NULL, "tssipos2g", &sprom->fem.ghz2.tssipos, 0);
+	nvram_read_u8(prefix, NULL, "tssipos2g", &sprom->fem.ghz2.tssipos, 0,
+		      fallback);
 	nvram_read_u8(prefix, NULL, "extpagain2g",
-		      &sprom->fem.ghz2.extpa_gain, 0);
+		      &sprom->fem.ghz2.extpa_gain, 0, fallback);
 	nvram_read_u8(prefix, NULL, "pdetrange2g",
-		      &sprom->fem.ghz2.pdet_range, 0);
-	nvram_read_u8(prefix, NULL, "triso2g", &sprom->fem.ghz2.tr_iso, 0);
-	nvram_read_u8(prefix, NULL, "antswctl2g", &sprom->fem.ghz2.antswlut, 0);
-	nvram_read_u8(prefix, NULL, "tssipos5g", &sprom->fem.ghz5.tssipos, 0);
+		      &sprom->fem.ghz2.pdet_range, 0, fallback);
+	nvram_read_u8(prefix, NULL, "triso2g", &sprom->fem.ghz2.tr_iso, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "antswctl2g", &sprom->fem.ghz2.antswlut, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "tssipos5g", &sprom->fem.ghz5.tssipos, 0,
+		      fallback);
 	nvram_read_u8(prefix, NULL, "extpagain5g",
-		      &sprom->fem.ghz5.extpa_gain, 0);
+		      &sprom->fem.ghz5.extpa_gain, 0, fallback);
 	nvram_read_u8(prefix, NULL, "pdetrange5g",
-		      &sprom->fem.ghz5.pdet_range, 0);
-	nvram_read_u8(prefix, NULL, "triso5g", &sprom->fem.ghz5.tr_iso, 0);
-	nvram_read_u8(prefix, NULL, "antswctl5g", &sprom->fem.ghz5.antswlut, 0);
-	nvram_read_u8(prefix, NULL, "tempthresh", &sprom->tempthresh, 0);
-	nvram_read_u8(prefix, NULL, "tempoffset", &sprom->tempoffset, 0);
-	nvram_read_u16(prefix, NULL, "rawtempsense", &sprom->rawtempsense, 0);
-	nvram_read_u8(prefix, NULL, "measpower", &sprom->measpower, 0);
+		      &sprom->fem.ghz5.pdet_range, 0, fallback);
+	nvram_read_u8(prefix, NULL, "triso5g", &sprom->fem.ghz5.tr_iso, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "antswctl5g", &sprom->fem.ghz5.antswlut, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "tempthresh", &sprom->tempthresh, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "tempoffset", &sprom->tempoffset, 0,
+		      fallback);
+	nvram_read_u16(prefix, NULL, "rawtempsense", &sprom->rawtempsense, 0,
+		       fallback);
+	nvram_read_u8(prefix, NULL, "measpower", &sprom->measpower, 0,
+		      fallback);
 	nvram_read_u8(prefix, NULL, "tempsense_slope",
-		      &sprom->tempsense_slope, 0);
-	nvram_read_u8(prefix, NULL, "tempcorrx", &sprom->tempcorrx, 0);
+		      &sprom->tempsense_slope, 0, fallback);
+	nvram_read_u8(prefix, NULL, "tempcorrx", &sprom->tempcorrx, 0,
+		       fallback);
 	nvram_read_u8(prefix, NULL, "tempsense_option",
-		      &sprom->tempsense_option, 0);
+		      &sprom->tempsense_option, 0, fallback);
 	nvram_read_u8(prefix, NULL, "freqoffset_corr",
-		      &sprom->freqoffset_corr, 0);
-	nvram_read_u8(prefix, NULL, "iqcal_swp_dis", &sprom->iqcal_swp_dis, 0);
-	nvram_read_u8(prefix, NULL, "hw_iqcal_en", &sprom->hw_iqcal_en, 0);
-	nvram_read_u8(prefix, NULL, "elna2g", &sprom->elna2g, 0);
-	nvram_read_u8(prefix, NULL, "elna5g", &sprom->elna5g, 0);
+		      &sprom->freqoffset_corr, 0, fallback);
+	nvram_read_u8(prefix, NULL, "iqcal_swp_dis", &sprom->iqcal_swp_dis, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "hw_iqcal_en", &sprom->hw_iqcal_en, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "elna2g", &sprom->elna2g, 0, fallback);
+	nvram_read_u8(prefix, NULL, "elna5g", &sprom->elna5g, 0, fallback);
 	nvram_read_u8(prefix, NULL, "phycal_tempdelta",
-		      &sprom->phycal_tempdelta, 0);
-	nvram_read_u8(prefix, NULL, "temps_period", &sprom->temps_period, 0);
+		      &sprom->phycal_tempdelta, 0, fallback);
+	nvram_read_u8(prefix, NULL, "temps_period", &sprom->temps_period, 0,
+		      fallback);
 	nvram_read_u8(prefix, NULL, "temps_hysteresis",
-		      &sprom->temps_hysteresis, 0);
-	nvram_read_u8(prefix, NULL, "measpower1", &sprom->measpower1, 0);
-	nvram_read_u8(prefix, NULL, "measpower2", &sprom->measpower2, 0);
+		      &sprom->temps_hysteresis, 0, fallback);
+	nvram_read_u8(prefix, NULL, "measpower1", &sprom->measpower1, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "measpower2", &sprom->measpower2, 0,
+		      fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr2ga0",
-		      &sprom->rxgainerr2ga[0], 0);
+		      &sprom->rxgainerr2ga[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr2ga1",
-		      &sprom->rxgainerr2ga[1], 0);
+		      &sprom->rxgainerr2ga[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr2ga2",
-		      &sprom->rxgainerr2ga[2], 0);
+		      &sprom->rxgainerr2ga[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gla0",
-		      &sprom->rxgainerr5gla[0], 0);
+		      &sprom->rxgainerr5gla[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gla1",
-		      &sprom->rxgainerr5gla[1], 0);
+		      &sprom->rxgainerr5gla[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gla2",
-		      &sprom->rxgainerr5gla[2], 0);
+		      &sprom->rxgainerr5gla[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gma0",
-		      &sprom->rxgainerr5gma[0], 0);
+		      &sprom->rxgainerr5gma[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gma1",
-		      &sprom->rxgainerr5gma[1], 0);
+		      &sprom->rxgainerr5gma[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gma2",
-		      &sprom->rxgainerr5gma[2], 0);
+		      &sprom->rxgainerr5gma[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gha0",
-		      &sprom->rxgainerr5gha[0], 0);
+		      &sprom->rxgainerr5gha[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gha1",
-		      &sprom->rxgainerr5gha[1], 0);
+		      &sprom->rxgainerr5gha[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gha2",
-		      &sprom->rxgainerr5gha[2], 0);
+		      &sprom->rxgainerr5gha[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gua0",
-		      &sprom->rxgainerr5gua[0], 0);
+		      &sprom->rxgainerr5gua[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gua1",
-		      &sprom->rxgainerr5gua[1], 0);
+		      &sprom->rxgainerr5gua[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "rxgainerr5gua2",
-		      &sprom->rxgainerr5gua[2], 0);
-	nvram_read_u8(prefix, NULL, "noiselvl2ga0", &sprom->noiselvl2ga[0], 0);
-	nvram_read_u8(prefix, NULL, "noiselvl2ga1", &sprom->noiselvl2ga[1], 0);
-	nvram_read_u8(prefix, NULL, "noiselvl2ga2", &sprom->noiselvl2ga[2], 0);
+		      &sprom->rxgainerr5gua[2], 0, fallback);
+	nvram_read_u8(prefix, NULL, "noiselvl2ga0", &sprom->noiselvl2ga[0], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "noiselvl2ga1", &sprom->noiselvl2ga[1], 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "noiselvl2ga2", &sprom->noiselvl2ga[2], 0,
+		      fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gla0",
-		      &sprom->noiselvl5gla[0], 0);
+		      &sprom->noiselvl5gla[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gla1",
-		      &sprom->noiselvl5gla[1], 0);
+		      &sprom->noiselvl5gla[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gla2",
-		      &sprom->noiselvl5gla[2], 0);
+		      &sprom->noiselvl5gla[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gma0",
-		      &sprom->noiselvl5gma[0], 0);
+		      &sprom->noiselvl5gma[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gma1",
-		      &sprom->noiselvl5gma[1], 0);
+		      &sprom->noiselvl5gma[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gma2",
-		      &sprom->noiselvl5gma[2], 0);
+		      &sprom->noiselvl5gma[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gha0",
-		      &sprom->noiselvl5gha[0], 0);
+		      &sprom->noiselvl5gha[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gha1",
-		      &sprom->noiselvl5gha[1], 0);
+		      &sprom->noiselvl5gha[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gha2",
-		      &sprom->noiselvl5gha[2], 0);
+		      &sprom->noiselvl5gha[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gua0",
-		      &sprom->noiselvl5gua[0], 0);
+		      &sprom->noiselvl5gua[0], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gua1",
-		      &sprom->noiselvl5gua[1], 0);
+		      &sprom->noiselvl5gua[1], 0, fallback);
 	nvram_read_u8(prefix, NULL, "noiselvl5gua2",
-		      &sprom->noiselvl5gua[2], 0);
+		      &sprom->noiselvl5gua[2], 0, fallback);
 	nvram_read_u8(prefix, NULL, "pcieingress_war",
-		      &sprom->pcieingress_war, 0);
+		      &sprom->pcieingress_war, 0, fallback);
 }
 
-static void bcm47xx_fill_sprom_r9(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_r9(struct ssb_sprom *sprom, const char *prefix,
+				  bool fallback)
 {
-	nvram_read_u16(prefix, NULL, "cckbw202gpo", &sprom->cckbw202gpo, 0);
-	nvram_read_u16(prefix, NULL, "cckbw20ul2gpo", &sprom->cckbw20ul2gpo, 0);
+	nvram_read_u16(prefix, NULL, "cckbw202gpo", &sprom->cckbw202gpo, 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "cckbw20ul2gpo", &sprom->cckbw20ul2gpo, 0,
+		       fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw202gpo",
-		       &sprom->legofdmbw202gpo, 0);
+		       &sprom->legofdmbw202gpo, 0, fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw20ul2gpo",
-		       &sprom->legofdmbw20ul2gpo, 0);
+		       &sprom->legofdmbw20ul2gpo, 0, fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw205glpo",
-		       &sprom->legofdmbw205glpo, 0);
+		       &sprom->legofdmbw205glpo, 0, fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw20ul5glpo",
-		       &sprom->legofdmbw20ul5glpo, 0);
+		       &sprom->legofdmbw20ul5glpo, 0, fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw205gmpo",
-		       &sprom->legofdmbw205gmpo, 0);
+		       &sprom->legofdmbw205gmpo, 0, fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw20ul5gmpo",
-		       &sprom->legofdmbw20ul5gmpo, 0);
+		       &sprom->legofdmbw20ul5gmpo, 0, fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw205ghpo",
-		       &sprom->legofdmbw205ghpo, 0);
+		       &sprom->legofdmbw205ghpo, 0, fallback);
 	nvram_read_u32(prefix, NULL, "legofdmbw20ul5ghpo",
-		       &sprom->legofdmbw20ul5ghpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw202gpo", &sprom->mcsbw202gpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw20ul2gpo", &sprom->mcsbw20ul2gpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw402gpo", &sprom->mcsbw402gpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw205glpo", &sprom->mcsbw205glpo, 0);
+		       &sprom->legofdmbw20ul5ghpo, 0, fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw202gpo", &sprom->mcsbw202gpo, 0,
+		       fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw20ul2gpo", &sprom->mcsbw20ul2gpo, 0,
+		       fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw402gpo", &sprom->mcsbw402gpo, 0,
+		       fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw205glpo", &sprom->mcsbw205glpo, 0,
+		       fallback);
 	nvram_read_u32(prefix, NULL, "mcsbw20ul5glpo",
-		       &sprom->mcsbw20ul5glpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw405glpo", &sprom->mcsbw405glpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw205gmpo", &sprom->mcsbw205gmpo, 0);
+		       &sprom->mcsbw20ul5glpo, 0, fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw405glpo", &sprom->mcsbw405glpo, 0,
+		       fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw205gmpo", &sprom->mcsbw205gmpo, 0,
+		       fallback);
 	nvram_read_u32(prefix, NULL, "mcsbw20ul5gmpo",
-		       &sprom->mcsbw20ul5gmpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw405gmpo", &sprom->mcsbw405gmpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw205ghpo", &sprom->mcsbw205ghpo, 0);
+		       &sprom->mcsbw20ul5gmpo, 0, fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw405gmpo", &sprom->mcsbw405gmpo, 0,
+		       fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw205ghpo", &sprom->mcsbw205ghpo, 0,
+		       fallback);
 	nvram_read_u32(prefix, NULL, "mcsbw20ul5ghpo",
-		       &sprom->mcsbw20ul5ghpo, 0);
-	nvram_read_u32(prefix, NULL, "mcsbw405ghpo", &sprom->mcsbw405ghpo, 0);
-	nvram_read_u16(prefix, NULL, "mcs32po", &sprom->mcs32po, 0);
+		       &sprom->mcsbw20ul5ghpo, 0, fallback);
+	nvram_read_u32(prefix, NULL, "mcsbw405ghpo", &sprom->mcsbw405ghpo, 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "mcs32po", &sprom->mcs32po, 0, fallback);
 	nvram_read_u16(prefix, NULL, "legofdm40duppo",
-		       &sprom->legofdm40duppo, 0);
-	nvram_read_u8(prefix, NULL, "sar2g", &sprom->sar2g, 0);
-	nvram_read_u8(prefix, NULL, "sar5g", &sprom->sar5g, 0);
+		       &sprom->legofdm40duppo, 0, fallback);
+	nvram_read_u8(prefix, NULL, "sar2g", &sprom->sar2g, 0, fallback);
+	nvram_read_u8(prefix, NULL, "sar5g", &sprom->sar5g, 0, fallback);
 }
 
 static void bcm47xx_fill_sprom_path_r4589(struct ssb_sprom *sprom,
-					  const char *prefix)
+					  const char *prefix, bool fallback)
 {
 	char postfix[2];
 	int i;
@@ -464,46 +572,46 @@ static void bcm47xx_fill_sprom_path_r4589(struct ssb_sprom *sprom,
 		struct ssb_sprom_core_pwr_info *pwr_info = &sprom->core_pwr_info[i];
 		snprintf(postfix, sizeof(postfix), "%i", i);
 		nvram_read_u8(prefix, postfix, "maxp2ga",
-			      &pwr_info->maxpwr_2g, 0);
+			      &pwr_info->maxpwr_2g, 0, fallback);
 		nvram_read_u8(prefix, postfix, "itt2ga",
-			      &pwr_info->itssi_2g, 0);
+			      &pwr_info->itssi_2g, 0, fallback);
 		nvram_read_u8(prefix, postfix, "itt5ga",
-			      &pwr_info->itssi_5g, 0);
+			      &pwr_info->itssi_5g, 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa2gw0a",
-			       &pwr_info->pa_2g[0], 0);
+			       &pwr_info->pa_2g[0], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa2gw1a",
-			       &pwr_info->pa_2g[1], 0);
+			       &pwr_info->pa_2g[1], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa2gw2a",
-			       &pwr_info->pa_2g[2], 0);
+			       &pwr_info->pa_2g[2], 0, fallback);
 		nvram_read_u8(prefix, postfix, "maxp5ga",
-			      &pwr_info->maxpwr_5g, 0);
+			      &pwr_info->maxpwr_5g, 0, fallback);
 		nvram_read_u8(prefix, postfix, "maxp5gha",
-			      &pwr_info->maxpwr_5gh, 0);
+			      &pwr_info->maxpwr_5gh, 0, fallback);
 		nvram_read_u8(prefix, postfix, "maxp5gla",
-			      &pwr_info->maxpwr_5gl, 0);
+			      &pwr_info->maxpwr_5gl, 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5gw0a",
-			       &pwr_info->pa_5g[0], 0);
+			       &pwr_info->pa_5g[0], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5gw1a",
-			       &pwr_info->pa_5g[1], 0);
+			       &pwr_info->pa_5g[1], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5gw2a",
-			       &pwr_info->pa_5g[2], 0);
+			       &pwr_info->pa_5g[2], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5glw0a",
-			       &pwr_info->pa_5gl[0], 0);
+			       &pwr_info->pa_5gl[0], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5glw1a",
-			       &pwr_info->pa_5gl[1], 0);
+			       &pwr_info->pa_5gl[1], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5glw2a",
-			       &pwr_info->pa_5gl[2], 0);
+			       &pwr_info->pa_5gl[2], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5ghw0a",
-			       &pwr_info->pa_5gh[0], 0);
+			       &pwr_info->pa_5gh[0], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5ghw1a",
-			       &pwr_info->pa_5gh[1], 0);
+			       &pwr_info->pa_5gh[1], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5ghw2a",
-			       &pwr_info->pa_5gh[2], 0);
+			       &pwr_info->pa_5gh[2], 0, fallback);
 	}
 }
 
 static void bcm47xx_fill_sprom_path_r45(struct ssb_sprom *sprom,
-					const char *prefix)
+					const char *prefix, bool fallback)
 {
 	char postfix[2];
 	int i;
@@ -512,104 +620,112 @@ static void bcm47xx_fill_sprom_path_r45(struct ssb_sprom *sprom,
 		struct ssb_sprom_core_pwr_info *pwr_info = &sprom->core_pwr_info[i];
 		snprintf(postfix, sizeof(postfix), "%i", i);
 		nvram_read_u16(prefix, postfix, "pa2gw3a",
-			       &pwr_info->pa_2g[3], 0);
+			       &pwr_info->pa_2g[3], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5gw3a",
-			       &pwr_info->pa_5g[3], 0);
+			       &pwr_info->pa_5g[3], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5glw3a",
-			       &pwr_info->pa_5gl[3], 0);
+			       &pwr_info->pa_5gl[3], 0, fallback);
 		nvram_read_u16(prefix, postfix, "pa5ghw3a",
-			       &pwr_info->pa_5gh[3], 0);
+			       &pwr_info->pa_5gh[3], 0, fallback);
 	}
 }
 
-void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
+					const char *prefix, bool fallback)
 {
-	nvram_read_macaddr(prefix, "et0macaddr", &sprom->et0mac);
-	nvram_read_u8(prefix, NULL, "et0mdcport", &sprom->et0mdcport, 0);
-	nvram_read_u8(prefix, NULL, "et0phyaddr", &sprom->et0phyaddr, 0);
-
-	nvram_read_macaddr(prefix, "et1macaddr", &sprom->et1mac);
-	nvram_read_u8(prefix, NULL, "et1mdcport", &sprom->et1mdcport, 0);
-	nvram_read_u8(prefix, NULL, "et1phyaddr", &sprom->et1phyaddr, 0);
-
-	nvram_read_macaddr(prefix, "macaddr", &sprom->il0mac);
-	nvram_read_macaddr(prefix, "il0macaddr", &sprom->il0mac);
+	nvram_read_macaddr(prefix, "et0macaddr", &sprom->et0mac, fallback);
+	nvram_read_u8(prefix, NULL, "et0mdcport", &sprom->et0mdcport, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "et0phyaddr", &sprom->et0phyaddr, 0,
+		      fallback);
+
+	nvram_read_macaddr(prefix, "et1macaddr", &sprom->et1mac, fallback);
+	nvram_read_u8(prefix, NULL, "et1mdcport", &sprom->et1mdcport, 0,
+		      fallback);
+	nvram_read_u8(prefix, NULL, "et1phyaddr", &sprom->et1phyaddr, 0,
+		      fallback);
+
+	nvram_read_macaddr(prefix, "macaddr", &sprom->il0mac, fallback);
+	nvram_read_macaddr(prefix, "il0macaddr", &sprom->il0mac, fallback);
 }
 
-static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix)
+static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix,
+				    bool fallback)
 {
-	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0);
-	if (!sprom->board_rev)
-		nvram_read_u16(NULL, NULL, "boardrev", &sprom->board_rev, 0);
-	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0);
-	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
+	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0,
+		       fallback);
+	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0,
+		       fallback);
 	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
-			 &sprom->boardflags_hi);
+			 &sprom->boardflags_hi, fallback);
 	nvram_read_u32_2(prefix, "boardflags2", &sprom->boardflags2_lo,
-			 &sprom->boardflags2_hi);
+			 &sprom->boardflags2_hi, fallback);
 }
 
-void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
+void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
+			bool fallback)
 {
-	bcm47xx_fill_sprom_ethernet(sprom, prefix);
-	bcm47xx_fill_board_data(sprom, prefix);
+	bcm47xx_fill_sprom_ethernet(sprom, prefix, fallback);
+	bcm47xx_fill_board_data(sprom, prefix, fallback);
 
-	nvram_read_u8(prefix, NULL, "sromrev", &sprom->revision, 0);
+	nvram_read_u8(prefix, NULL, "sromrev", &sprom->revision, 0, fallback);
 
 	switch (sprom->revision) {
 	case 1:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-		bcm47xx_fill_sprom_r12389(sprom, prefix);
-		bcm47xx_fill_sprom_r1(sprom, prefix);
+		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r1(sprom, prefix, fallback);
 		break;
 	case 2:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-		bcm47xx_fill_sprom_r12389(sprom, prefix);
-		bcm47xx_fill_sprom_r2389(sprom, prefix);
+		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r2389(sprom, prefix, fallback);
 		break;
 	case 3:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-		bcm47xx_fill_sprom_r12389(sprom, prefix);
-		bcm47xx_fill_sprom_r2389(sprom, prefix);
-		bcm47xx_fill_sprom_r389(sprom, prefix);
-		bcm47xx_fill_sprom_r3(sprom, prefix);
+		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r2389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r3(sprom, prefix, fallback);
 		break;
 	case 4:
 	case 5:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-		bcm47xx_fill_sprom_r4589(sprom, prefix);
-		bcm47xx_fill_sprom_r458(sprom, prefix);
-		bcm47xx_fill_sprom_r45(sprom, prefix);
-		bcm47xx_fill_sprom_path_r4589(sprom, prefix);
-		bcm47xx_fill_sprom_path_r45(sprom, prefix);
+		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r4589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r458(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r45(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_path_r45(sprom, prefix, fallback);
 		break;
 	case 8:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-		bcm47xx_fill_sprom_r12389(sprom, prefix);
-		bcm47xx_fill_sprom_r2389(sprom, prefix);
-		bcm47xx_fill_sprom_r389(sprom, prefix);
-		bcm47xx_fill_sprom_r4589(sprom, prefix);
-		bcm47xx_fill_sprom_r458(sprom, prefix);
-		bcm47xx_fill_sprom_r89(sprom, prefix);
-		bcm47xx_fill_sprom_path_r4589(sprom, prefix);
+		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r2389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r4589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r458(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r89(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
 		break;
 	case 9:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-		bcm47xx_fill_sprom_r12389(sprom, prefix);
-		bcm47xx_fill_sprom_r2389(sprom, prefix);
-		bcm47xx_fill_sprom_r389(sprom, prefix);
-		bcm47xx_fill_sprom_r4589(sprom, prefix);
-		bcm47xx_fill_sprom_r89(sprom, prefix);
-		bcm47xx_fill_sprom_r9(sprom, prefix);
-		bcm47xx_fill_sprom_path_r4589(sprom, prefix);
+		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r2389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r4589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r89(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r9(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
 		break;
 	default:
 		pr_warn("Unsupported SPROM revision %d detected. Will extract"
 			" v1\n", sprom->revision);
 		sprom->revision = 1;
-		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-		bcm47xx_fill_sprom_r12389(sprom, prefix);
-		bcm47xx_fill_sprom_r1(sprom, prefix);
+		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
+		bcm47xx_fill_sprom_r1(sprom, prefix, fallback);
 	}
 }
 
@@ -617,11 +733,12 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
 				const char *prefix)
 {
-	nvram_read_u16(prefix, NULL, "boardvendor", &boardinfo->vendor, 0);
+	nvram_read_u16(prefix, NULL, "boardvendor", &boardinfo->vendor, 0,
+		       true);
 	if (!boardinfo->vendor)
 		boardinfo->vendor = SSB_BOARDVENDOR_BCM;
 
-	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0);
+	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0, true);
 }
 #endif
 
@@ -629,10 +746,11 @@ void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
 void bcm47xx_fill_bcma_boardinfo(struct bcma_boardinfo *boardinfo,
 				 const char *prefix)
 {
-	nvram_read_u16(prefix, NULL, "boardvendor", &boardinfo->vendor, 0);
+	nvram_read_u16(prefix, NULL, "boardvendor", &boardinfo->vendor, 0,
+		       true);
 	if (!boardinfo->vendor)
 		boardinfo->vendor = SSB_BOARDVENDOR_BCM;
 
-	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0);
+	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0, true);
 }
 #endif
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 26fdaf4..cc7563b 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -44,8 +44,8 @@ union bcm47xx_bus {
 extern union bcm47xx_bus bcm47xx_bus;
 extern enum bcm47xx_bus_type bcm47xx_bus_type;
 
-void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix);
-void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom, const char *prefix);
+void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
+			bool fallback);
 
 #ifdef CONFIG_BCM47XX_SSB
 void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
-- 
1.7.9.5
