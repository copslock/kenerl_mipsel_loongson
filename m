Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 01:01:50 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:58163 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903787Ab2B0X6Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 00:58:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6FD788F68;
        Tue, 28 Feb 2012 00:58:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mj-RAAS18XBn; Tue, 28 Feb 2012 00:58:06 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 407DC8F6A;
        Tue, 28 Feb 2012 00:57:02 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 10/11] MIPS: BCM47XX: move and extend sprom parsing
Date:   Tue, 28 Feb 2012 00:56:13 +0100
Message-Id: <1330386974-4056-11-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1330386974-4056-1-git-send-email-hauke@hauke-m.de>
References: <1330386974-4056-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Move the sprom parsing from nvram into sprom.c. There are all values
needed for sprom version 1 to 9 read from nvram and there are more
sanity checks added. This is based on the sprom parsing in the open
source part of the Broadcom SDK.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/Makefile                   |    2 +-
 arch/mips/bcm47xx/setup.c                    |  151 +-------
 arch/mips/bcm47xx/sprom.c                    |  620 ++++++++++++++++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    3 +
 4 files changed, 625 insertions(+), 151 deletions(-)
 create mode 100644 arch/mips/bcm47xx/sprom.c

diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 4add173..4389de1 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,5 +3,5 @@
 # under Linux.
 #
 
-obj-y 				+= gpio.o irq.o nvram.o prom.o serial.o setup.o time.o
+obj-y 				+= gpio.o irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
 obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index aab6b0c..6b0dacd 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -85,156 +85,7 @@ static void bcm47xx_machine_halt(void)
 }
 
 #ifdef CONFIG_BCM47XX_SSB
-#define READ_FROM_NVRAM(_outvar, name, buf) \
-	if (nvram_getprefix(prefix, name, buf, sizeof(buf)) >= 0)\
-		sprom->_outvar = simple_strtoul(buf, NULL, 0);
-
-#define READ_FROM_NVRAM2(_outvar, name1, name2, buf) \
-	if (nvram_getprefix(prefix, name1, buf, sizeof(buf)) >= 0 || \
-	    nvram_getprefix(prefix, name2, buf, sizeof(buf)) >= 0)\
-		sprom->_outvar = simple_strtoul(buf, NULL, 0);
-
-static inline int nvram_getprefix(const char *prefix, char *name,
-				  char *buf, int len)
-{
-	if (prefix) {
-		char key[100];
-
-		snprintf(key, sizeof(key), "%s%s", prefix, name);
-		return nvram_getenv(key, buf, len);
-	}
-
-	return nvram_getenv(name, buf, len);
-}
-
-static u32 nvram_getu32(const char *name, char *buf, int len)
-{
-	int rv;
-	char key[100];
-	u16 var0, var1;
-
-	snprintf(key, sizeof(key), "%s0", name);
-	rv = nvram_getenv(key, buf, len);
-	/* return 0 here so this looks like unset */
-	if (rv < 0)
-		return 0;
-	var0 = simple_strtoul(buf, NULL, 0);
-
-	snprintf(key, sizeof(key), "%s1", name);
-	rv = nvram_getenv(key, buf, len);
-	if (rv < 0)
-		return 0;
-	var1 = simple_strtoul(buf, NULL, 0);
-	return var1 << 16 | var0;
-}
-
-static void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
-{
-	char buf[100];
-	u32 boardflags;
-
-	memset(sprom, 0, sizeof(struct ssb_sprom));
-
-	sprom->revision = 1; /* Fallback: Old hardware does not define this. */
-	READ_FROM_NVRAM(revision, "sromrev", buf);
-	if (nvram_getprefix(prefix, "il0macaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getprefix(prefix, "macaddr", buf, sizeof(buf)) >= 0)
-		nvram_parse_macaddr(buf, sprom->il0mac);
-	if (nvram_getprefix(prefix, "et0macaddr", buf, sizeof(buf)) >= 0)
-		nvram_parse_macaddr(buf, sprom->et0mac);
-	if (nvram_getprefix(prefix, "et1macaddr", buf, sizeof(buf)) >= 0)
-		nvram_parse_macaddr(buf, sprom->et1mac);
-	READ_FROM_NVRAM(et0phyaddr, "et0phyaddr", buf);
-	READ_FROM_NVRAM(et1phyaddr, "et1phyaddr", buf);
-	READ_FROM_NVRAM(et0mdcport, "et0mdcport", buf);
-	READ_FROM_NVRAM(et1mdcport, "et1mdcport", buf);
-	READ_FROM_NVRAM(board_rev, "boardrev", buf);
-	READ_FROM_NVRAM(country_code, "ccode", buf);
-	READ_FROM_NVRAM(ant_available_a, "aa5g", buf);
-	READ_FROM_NVRAM(ant_available_bg, "aa2g", buf);
-	READ_FROM_NVRAM(pa0b0, "pa0b0", buf);
-	READ_FROM_NVRAM(pa0b1, "pa0b1", buf);
-	READ_FROM_NVRAM(pa0b2, "pa0b2", buf);
-	READ_FROM_NVRAM(pa1b0, "pa1b0", buf);
-	READ_FROM_NVRAM(pa1b1, "pa1b1", buf);
-	READ_FROM_NVRAM(pa1b2, "pa1b2", buf);
-	READ_FROM_NVRAM(pa1lob0, "pa1lob0", buf);
-	READ_FROM_NVRAM(pa1lob2, "pa1lob1", buf);
-	READ_FROM_NVRAM(pa1lob1, "pa1lob2", buf);
-	READ_FROM_NVRAM(pa1hib0, "pa1hib0", buf);
-	READ_FROM_NVRAM(pa1hib2, "pa1hib1", buf);
-	READ_FROM_NVRAM(pa1hib1, "pa1hib2", buf);
-	READ_FROM_NVRAM2(gpio0, "ledbh0", "wl0gpio0", buf);
-	READ_FROM_NVRAM2(gpio1, "ledbh1", "wl0gpio1", buf);
-	READ_FROM_NVRAM2(gpio2, "ledbh2", "wl0gpio2", buf);
-	READ_FROM_NVRAM2(gpio3, "ledbh3", "wl0gpio3", buf);
-	READ_FROM_NVRAM2(maxpwr_bg, "maxp2ga0", "pa0maxpwr", buf);
-	READ_FROM_NVRAM2(maxpwr_al, "maxp5gla0", "pa1lomaxpwr", buf);
-	READ_FROM_NVRAM2(maxpwr_a, "maxp5ga0", "pa1maxpwr", buf);
-	READ_FROM_NVRAM2(maxpwr_ah, "maxp5gha0", "pa1himaxpwr", buf);
-	READ_FROM_NVRAM2(itssi_bg, "itt5ga0", "pa0itssit", buf);
-	READ_FROM_NVRAM2(itssi_a, "itt2ga0", "pa1itssit", buf);
-	READ_FROM_NVRAM(tri2g, "tri2g", buf);
-	READ_FROM_NVRAM(tri5gl, "tri5gl", buf);
-	READ_FROM_NVRAM(tri5g, "tri5g", buf);
-	READ_FROM_NVRAM(tri5gh, "tri5gh", buf);
-	READ_FROM_NVRAM(txpid2g[0], "txpid2ga0", buf);
-	READ_FROM_NVRAM(txpid2g[1], "txpid2ga1", buf);
-	READ_FROM_NVRAM(txpid2g[2], "txpid2ga2", buf);
-	READ_FROM_NVRAM(txpid2g[3], "txpid2ga3", buf);
-	READ_FROM_NVRAM(txpid5g[0], "txpid5ga0", buf);
-	READ_FROM_NVRAM(txpid5g[1], "txpid5ga1", buf);
-	READ_FROM_NVRAM(txpid5g[2], "txpid5ga2", buf);
-	READ_FROM_NVRAM(txpid5g[3], "txpid5ga3", buf);
-	READ_FROM_NVRAM(txpid5gl[0], "txpid5gla0", buf);
-	READ_FROM_NVRAM(txpid5gl[1], "txpid5gla1", buf);
-	READ_FROM_NVRAM(txpid5gl[2], "txpid5gla2", buf);
-	READ_FROM_NVRAM(txpid5gl[3], "txpid5gla3", buf);
-	READ_FROM_NVRAM(txpid5gh[0], "txpid5gha0", buf);
-	READ_FROM_NVRAM(txpid5gh[1], "txpid5gha1", buf);
-	READ_FROM_NVRAM(txpid5gh[2], "txpid5gha2", buf);
-	READ_FROM_NVRAM(txpid5gh[3], "txpid5gha3", buf);
-	READ_FROM_NVRAM(rxpo2g, "rxpo2g", buf);
-	READ_FROM_NVRAM(rxpo5g, "rxpo5g", buf);
-	READ_FROM_NVRAM(rssisav2g, "rssisav2g", buf);
-	READ_FROM_NVRAM(rssismc2g, "rssismc2g", buf);
-	READ_FROM_NVRAM(rssismf2g, "rssismf2g", buf);
-	READ_FROM_NVRAM(bxa2g, "bxa2g", buf);
-	READ_FROM_NVRAM(rssisav5g, "rssisav5g", buf);
-	READ_FROM_NVRAM(rssismc5g, "rssismc5g", buf);
-	READ_FROM_NVRAM(rssismf5g, "rssismf5g", buf);
-	READ_FROM_NVRAM(bxa5g, "bxa5g", buf);
-	READ_FROM_NVRAM(cck2gpo, "cck2gpo", buf);
-
-	sprom->ofdm2gpo = nvram_getu32("ofdm2gpo", buf, sizeof(buf));
-	sprom->ofdm5glpo = nvram_getu32("ofdm5glpo", buf, sizeof(buf));
-	sprom->ofdm5gpo = nvram_getu32("ofdm5gpo", buf, sizeof(buf));
-	sprom->ofdm5ghpo = nvram_getu32("ofdm5ghpo", buf, sizeof(buf));
-
-	READ_FROM_NVRAM(antenna_gain.ghz24.a0, "ag0", buf);
-	READ_FROM_NVRAM(antenna_gain.ghz24.a1, "ag1", buf);
-	READ_FROM_NVRAM(antenna_gain.ghz24.a2, "ag2", buf);
-	READ_FROM_NVRAM(antenna_gain.ghz24.a3, "ag3", buf);
-	memcpy(&sprom->antenna_gain.ghz5, &sprom->antenna_gain.ghz24,
-	       sizeof(sprom->antenna_gain.ghz5));
-
-	if (nvram_getprefix(prefix, "boardflags", buf, sizeof(buf)) >= 0) {
-		boardflags = simple_strtoul(buf, NULL, 0);
-		if (boardflags) {
-			sprom->boardflags_lo = (boardflags & 0x0000FFFFU);
-			sprom->boardflags_hi = (boardflags & 0xFFFF0000U) >> 16;
-		}
-	}
-	if (nvram_getprefix(prefix, "boardflags2", buf, sizeof(buf)) >= 0) {
-		boardflags = simple_strtoul(buf, NULL, 0);
-		if (boardflags) {
-			sprom->boardflags2_lo = (boardflags & 0x0000FFFFU);
-			sprom->boardflags2_hi = (boardflags & 0xFFFF0000U) >> 16;
-		}
-	}
-}
-
-int bcm47xx_get_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
+static int bcm47xx_get_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
 {
 	char prefix[10];
 
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
new file mode 100644
index 0000000..5c8dcd2
--- /dev/null
+++ b/arch/mips/bcm47xx/sprom.c
@@ -0,0 +1,620 @@
+/*
+ *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
+ *  Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ *  Copyright (C) 2006 Michael Buesch <m@bues.ch>
+ *  Copyright (C) 2010 Waldemar Brodkorb <wbx@openadk.org>
+ *  Copyright (C) 2010-2012 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <bcm47xx.h>
+#include <nvram.h>
+
+static void create_key(const char *prefix, const char *postfix,
+		       const char *name, char *buf, int len)
+{
+	if (prefix && postfix)
+		snprintf(buf, len, "%s%s%s", prefix, name, postfix);
+	else if (prefix)
+		snprintf(buf, len, "%s%s", prefix, name);
+	else if (postfix)
+		snprintf(buf, len, "%s%s", name, postfix);
+	else
+		snprintf(buf, len, "%s", name);
+}
+
+#define NVRAM_READ_VAL(type)						\
+static void nvram_read_ ## type (const char *prefix,			\
+				 const char *postfix, const char *name,	\
+				 type *val, type allset)		\
+{									\
+	char buf[100];							\
+	char key[40];							\
+	int err;							\
+	type var;							\
+									\
+	create_key(prefix, postfix, name, key, sizeof(key));		\
+									\
+	err = nvram_getenv(key, buf, sizeof(buf));			\
+	if (err < 0)							\
+		return;							\
+	err = kstrto ## type (buf, 0, &var);				\
+	if (err) {							\
+		pr_warn("can not parse nvram name %s with value %s"	\
+			" got %i", key, buf, err);			\
+		return;							\
+	}								\
+	if (allset && var == allset)					\
+		return;							\
+	*val = var;							\
+}
+
+NVRAM_READ_VAL(u8)
+NVRAM_READ_VAL(s8)
+NVRAM_READ_VAL(u16)
+NVRAM_READ_VAL(u32)
+
+#undef NVRAM_READ_VAL
+
+static void nvram_read_u32_2(const char *prefix, const char *name,
+			     u16 *val_lo, u16 *val_hi)
+{
+	char buf[100];
+	char key[40];
+	int err;
+	u32 val;
+
+	create_key(prefix, NULL, name, key, sizeof(key));
+
+	err = nvram_getenv(key, buf, sizeof(buf));
+	if (err < 0)
+		return;
+	err = kstrtou32(buf, 0, &val);
+	if (err) {
+		pr_warn("can not parse nvram name %s with value %s got %i",
+			key, buf, err);
+		return;
+	}
+	*val_lo = (val & 0x0000FFFFU);
+	*val_hi = (val & 0xFFFF0000U) >> 16;
+}
+
+static void nvram_read_leddc(const char *prefix, const char *name,
+			     u8 *leddc_on_time, u8 *leddc_off_time)
+{
+	char buf[100];
+	char key[40];
+	int err;
+	u32 val;
+
+	create_key(prefix, NULL, name, key, sizeof(key));
+
+	err = nvram_getenv(key, buf, sizeof(buf));
+	if (err < 0)
+		return;
+	err = kstrtou32(buf, 0, &val);
+	if (err) {
+		pr_warn("can not parse nvram name %s with value %s got %i",
+			key, buf, err);
+		return;
+	}
+
+	if (val == 0xffff || val == 0xffffffff)
+		return;
+
+	*leddc_on_time = val & 0xff;
+	*leddc_off_time = (val >> 16) & 0xff;
+}
+
+static void nvram_read_macaddr(const char *prefix, const char *name,
+			       u8 (*val)[6])
+{
+	char buf[100];
+	char key[40];
+	int err;
+
+	create_key(prefix, NULL, name, key, sizeof(key));
+
+	err = nvram_getenv(key, buf, sizeof(buf));
+	if (err < 0)
+		return;
+	nvram_parse_macaddr(buf, *val);
+}
+
+static void nvram_read_alpha2(const char *prefix, const char *name,
+			     char (*val)[2])
+{
+	char buf[10];
+	char key[40];
+	int err;
+
+	create_key(prefix, NULL, name, key, sizeof(key));
+
+	err = nvram_getenv(key, buf, sizeof(buf));
+	if (err < 0)
+		return;
+	if (buf[0] == '0')
+		return;
+	if (strlen(buf) > 2) {
+		pr_warn("alpha2 is too long %s", buf);
+		return;
+	}
+	memcpy(val, buf, sizeof(val));
+}
+
+static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
+					const char *prefix)
+{
+	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0);
+	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0);
+	nvram_read_u8(prefix, NULL, "ledbh0", &sprom->gpio0, 0xff);
+	nvram_read_u8(prefix, NULL, "ledbh1", &sprom->gpio1, 0xff);
+	nvram_read_u8(prefix, NULL, "ledbh2", &sprom->gpio2, 0xff);
+	nvram_read_u8(prefix, NULL, "ledbh3", &sprom->gpio3, 0xff);
+	nvram_read_u8(prefix, NULL, "aa2g", &sprom->ant_available_bg, 0);
+	nvram_read_u8(prefix, NULL, "aa5g", &sprom->ant_available_a, 0);
+	nvram_read_s8(prefix, NULL, "ag0", &sprom->antenna_gain.a0, 0);
+	nvram_read_s8(prefix, NULL, "ag1", &sprom->antenna_gain.a1, 0);
+	nvram_read_alpha2(prefix, "ccode", &sprom->alpha2);
+}
+
+static void bcm47xx_fill_sprom_r12389(struct ssb_sprom *sprom,
+				      const char *prefix)
+{
+	nvram_read_u16(prefix, NULL, "pa0b0", &sprom->pa0b0, 0);
+	nvram_read_u16(prefix, NULL, "pa0b1", &sprom->pa0b1, 0);
+	nvram_read_u16(prefix, NULL, "pa0b2", &sprom->pa0b2, 0);
+	nvram_read_u8(prefix, NULL, "pa0itssit", &sprom->itssi_bg, 0);
+	nvram_read_u8(prefix, NULL, "pa0maxpwr", &sprom->maxpwr_bg, 0);
+	nvram_read_u16(prefix, NULL, "pa1b0", &sprom->pa1b0, 0);
+	nvram_read_u16(prefix, NULL, "pa1b1", &sprom->pa1b1, 0);
+	nvram_read_u16(prefix, NULL, "pa1b2", &sprom->pa1b2, 0);
+	nvram_read_u8(prefix, NULL, "pa1itssit", &sprom->itssi_a, 0);
+	nvram_read_u8(prefix, NULL, "pa1maxpwr", &sprom->maxpwr_a, 0);
+}
+
+static void bcm47xx_fill_sprom_r1(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u16(prefix, NULL, "boardflags", &sprom->boardflags_lo, 0);
+	nvram_read_u8(prefix, NULL, "cc", &sprom->country_code, 0);
+}
+
+static void bcm47xx_fill_sprom_r2389(struct ssb_sprom *sprom,
+				     const char *prefix)
+{
+	nvram_read_u8(prefix, NULL, "opo", &sprom->opo, 0);
+	nvram_read_u16(prefix, NULL, "pa1lob0", &sprom->pa1lob0, 0);
+	nvram_read_u16(prefix, NULL, "pa1lob1", &sprom->pa1lob1, 0);
+	nvram_read_u16(prefix, NULL, "pa1lob2", &sprom->pa1lob2, 0);
+	nvram_read_u16(prefix, NULL, "pa1hib0", &sprom->pa1hib0, 0);
+	nvram_read_u16(prefix, NULL, "pa1hib1", &sprom->pa1hib1, 0);
+	nvram_read_u16(prefix, NULL, "pa1hib2", &sprom->pa1hib2, 0);
+	nvram_read_u8(prefix, NULL, "pa1lomaxpwr", &sprom->maxpwr_al, 0);
+	nvram_read_u8(prefix, NULL, "pa1himaxpwr", &sprom->maxpwr_ah, 0);
+}
+
+static void bcm47xx_fill_sprom_r2(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
+			 &sprom->boardflags_hi);
+	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
+}
+
+static void bcm47xx_fill_sprom_r389(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u8(prefix, NULL, "bxa2g", &sprom->bxa2g, 0);
+	nvram_read_u8(prefix, NULL, "rssisav2g", &sprom->rssisav2g, 0);
+	nvram_read_u8(prefix, NULL, "rssismc2g", &sprom->rssismc2g, 0);
+	nvram_read_u8(prefix, NULL, "rssismf2g", &sprom->rssismf2g, 0);
+	nvram_read_u8(prefix, NULL, "bxa5g", &sprom->bxa5g, 0);
+	nvram_read_u8(prefix, NULL, "rssisav5g", &sprom->rssisav5g, 0);
+	nvram_read_u8(prefix, NULL, "rssismc5g", &sprom->rssismc5g, 0);
+	nvram_read_u8(prefix, NULL, "rssismf5g", &sprom->rssismf5g, 0);
+	nvram_read_u8(prefix, NULL, "tri2g", &sprom->tri2g, 0);
+	nvram_read_u8(prefix, NULL, "tri5g", &sprom->tri5g, 0);
+	nvram_read_u8(prefix, NULL, "tri5gl", &sprom->tri5gl, 0);
+	nvram_read_u8(prefix, NULL, "tri5gh", &sprom->tri5gh, 0);
+	nvram_read_s8(prefix, NULL, "rxpo2g", &sprom->rxpo2g, 0);
+	nvram_read_s8(prefix, NULL, "rxpo5g", &sprom->rxpo5g, 0);
+}
+
+static void bcm47xx_fill_sprom_r3(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
+			 &sprom->boardflags_hi);
+	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
+	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0);
+	nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
+			 &sprom->leddc_off_time);
+}
+
+static void bcm47xx_fill_sprom_r4589(struct ssb_sprom *sprom,
+				     const char *prefix)
+{
+	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
+			 &sprom->boardflags_hi);
+	nvram_read_u32_2(prefix, "boardflags2", &sprom->boardflags2_lo,
+			 &sprom->boardflags2_hi);
+	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
+	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0);
+	nvram_read_s8(prefix, NULL, "ag2", &sprom->antenna_gain.a2, 0);
+	nvram_read_s8(prefix, NULL, "ag3", &sprom->antenna_gain.a3, 0);
+	nvram_read_u8(prefix, NULL, "txchain", &sprom->txchain, 0xf);
+	nvram_read_u8(prefix, NULL, "rxchain", &sprom->rxchain, 0xf);
+	nvram_read_u8(prefix, NULL, "antswitch", &sprom->antswitch, 0xff);
+	nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
+			 &sprom->leddc_off_time);
+}
+
+static void bcm47xx_fill_sprom_r458(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u16(prefix, NULL, "cck2gpo", &sprom->cck2gpo, 0);
+	nvram_read_u32(prefix, NULL, "ofdm2gpo", &sprom->ofdm2gpo, 0);
+	nvram_read_u32(prefix, NULL, "ofdm5gpo", &sprom->ofdm5gpo, 0);
+	nvram_read_u32(prefix, NULL, "ofdm5glpo", &sprom->ofdm5glpo, 0);
+	nvram_read_u32(prefix, NULL, "ofdm5ghpo", &sprom->ofdm5ghpo, 0);
+	nvram_read_u16(prefix, NULL, "cddpo", &sprom->cddpo, 0);
+	nvram_read_u16(prefix, NULL, "stbcpo", &sprom->stbcpo, 0);
+	nvram_read_u16(prefix, NULL, "bw40po", &sprom->bw40po, 0);
+	nvram_read_u16(prefix, NULL, "bwduppo", &sprom->bwduppo, 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo0", &sprom->mcs2gpo[0], 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo1", &sprom->mcs2gpo[1], 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo2", &sprom->mcs2gpo[2], 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo3", &sprom->mcs2gpo[3], 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo4", &sprom->mcs2gpo[4], 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo5", &sprom->mcs2gpo[5], 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo6", &sprom->mcs2gpo[6], 0);
+	nvram_read_u16(prefix, NULL, "mcs2gpo7", &sprom->mcs2gpo[7], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo0", &sprom->mcs5gpo[0], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo1", &sprom->mcs5gpo[1], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo2", &sprom->mcs5gpo[2], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo3", &sprom->mcs5gpo[3], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo4", &sprom->mcs5gpo[4], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo5", &sprom->mcs5gpo[5], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo6", &sprom->mcs5gpo[6], 0);
+	nvram_read_u16(prefix, NULL, "mcs5gpo7", &sprom->mcs5gpo[7], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo0", &sprom->mcs5glpo[0], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo1", &sprom->mcs5glpo[1], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo2", &sprom->mcs5glpo[2], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo3", &sprom->mcs5glpo[3], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo4", &sprom->mcs5glpo[4], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo5", &sprom->mcs5glpo[5], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo6", &sprom->mcs5glpo[6], 0);
+	nvram_read_u16(prefix, NULL, "mcs5glpo7", &sprom->mcs5glpo[7], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo0", &sprom->mcs5ghpo[0], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo1", &sprom->mcs5ghpo[1], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo2", &sprom->mcs5ghpo[2], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo3", &sprom->mcs5ghpo[3], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo4", &sprom->mcs5ghpo[4], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo5", &sprom->mcs5ghpo[5], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo6", &sprom->mcs5ghpo[6], 0);
+	nvram_read_u16(prefix, NULL, "mcs5ghpo7", &sprom->mcs5ghpo[7], 0);
+}
+
+static void bcm47xx_fill_sprom_r45(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u8(prefix, NULL, "txpid2ga0", &sprom->txpid2g[0], 0);
+	nvram_read_u8(prefix, NULL, "txpid2ga1", &sprom->txpid2g[1], 0);
+	nvram_read_u8(prefix, NULL, "txpid2ga2", &sprom->txpid2g[2], 0);
+	nvram_read_u8(prefix, NULL, "txpid2ga3", &sprom->txpid2g[3], 0);
+	nvram_read_u8(prefix, NULL, "txpid5ga0", &sprom->txpid5g[0], 0);
+	nvram_read_u8(prefix, NULL, "txpid5ga1", &sprom->txpid5g[1], 0);
+	nvram_read_u8(prefix, NULL, "txpid5ga2", &sprom->txpid5g[2], 0);
+	nvram_read_u8(prefix, NULL, "txpid5ga3", &sprom->txpid5g[3], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gla0", &sprom->txpid5gl[0], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gla1", &sprom->txpid5gl[1], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gla2", &sprom->txpid5gl[2], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gla3", &sprom->txpid5gl[3], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gha0", &sprom->txpid5gh[0], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gha1", &sprom->txpid5gh[1], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gha2", &sprom->txpid5gh[2], 0);
+	nvram_read_u8(prefix, NULL, "txpid5gha3", &sprom->txpid5gh[3], 0);
+}
+
+static void bcm47xx_fill_sprom_r89(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u8(prefix, NULL, "tssipos2g", &sprom->fem.ghz2.tssipos, 0);
+	nvram_read_u8(prefix, NULL, "extpagain2g",
+		      &sprom->fem.ghz2.extpa_gain, 0);
+	nvram_read_u8(prefix, NULL, "pdetrange2g",
+		      &sprom->fem.ghz2.pdet_range, 0);
+	nvram_read_u8(prefix, NULL, "triso2g", &sprom->fem.ghz2.tr_iso, 0);
+	nvram_read_u8(prefix, NULL, "antswctl2g", &sprom->fem.ghz2.antswlut, 0);
+	nvram_read_u8(prefix, NULL, "tssipos5g", &sprom->fem.ghz5.tssipos, 0);
+	nvram_read_u8(prefix, NULL, "extpagain5g",
+		      &sprom->fem.ghz5.extpa_gain, 0);
+	nvram_read_u8(prefix, NULL, "pdetrange5g",
+		      &sprom->fem.ghz5.pdet_range, 0);
+	nvram_read_u8(prefix, NULL, "triso5g", &sprom->fem.ghz5.tr_iso, 0);
+	nvram_read_u8(prefix, NULL, "antswctl5g", &sprom->fem.ghz5.antswlut, 0);
+	nvram_read_u8(prefix, NULL, "tempthresh", &sprom->tempthresh, 0);
+	nvram_read_u8(prefix, NULL, "tempoffset", &sprom->tempoffset, 0);
+	nvram_read_u16(prefix, NULL, "rawtempsense", &sprom->rawtempsense, 0);
+	nvram_read_u8(prefix, NULL, "measpower", &sprom->measpower, 0);
+	nvram_read_u8(prefix, NULL, "tempsense_slope",
+		      &sprom->tempsense_slope, 0);
+	nvram_read_u8(prefix, NULL, "tempcorrx", &sprom->tempcorrx, 0);
+	nvram_read_u8(prefix, NULL, "tempsense_option",
+		      &sprom->tempsense_option, 0);
+	nvram_read_u8(prefix, NULL, "freqoffset_corr",
+		      &sprom->freqoffset_corr, 0);
+	nvram_read_u8(prefix, NULL, "iqcal_swp_dis", &sprom->iqcal_swp_dis, 0);
+	nvram_read_u8(prefix, NULL, "hw_iqcal_en", &sprom->hw_iqcal_en, 0);
+	nvram_read_u8(prefix, NULL, "elna2g", &sprom->elna2g, 0);
+	nvram_read_u8(prefix, NULL, "elna5g", &sprom->elna5g, 0);
+	nvram_read_u8(prefix, NULL, "phycal_tempdelta",
+		      &sprom->phycal_tempdelta, 0);
+	nvram_read_u8(prefix, NULL, "temps_period", &sprom->temps_period, 0);
+	nvram_read_u8(prefix, NULL, "temps_hysteresis",
+		      &sprom->temps_hysteresis, 0);
+	nvram_read_u8(prefix, NULL, "measpower1", &sprom->measpower1, 0);
+	nvram_read_u8(prefix, NULL, "measpower2", &sprom->measpower2, 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr2ga0",
+		      &sprom->rxgainerr2ga[0], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr2ga1",
+		      &sprom->rxgainerr2ga[1], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr2ga2",
+		      &sprom->rxgainerr2ga[2], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gla0",
+		      &sprom->rxgainerr5gla[0], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gla1",
+		      &sprom->rxgainerr5gla[1], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gla2",
+		      &sprom->rxgainerr5gla[2], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gma0",
+		      &sprom->rxgainerr5gma[0], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gma1",
+		      &sprom->rxgainerr5gma[1], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gma2",
+		      &sprom->rxgainerr5gma[2], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gha0",
+		      &sprom->rxgainerr5gha[0], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gha1",
+		      &sprom->rxgainerr5gha[1], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gha2",
+		      &sprom->rxgainerr5gha[2], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gua0",
+		      &sprom->rxgainerr5gua[0], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gua1",
+		      &sprom->rxgainerr5gua[1], 0);
+	nvram_read_u8(prefix, NULL, "rxgainerr5gua2",
+		      &sprom->rxgainerr5gua[2], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl2ga0", &sprom->noiselvl2ga[0], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl2ga1", &sprom->noiselvl2ga[1], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl2ga2", &sprom->noiselvl2ga[2], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gla0",
+		      &sprom->noiselvl5gla[0], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gla1",
+		      &sprom->noiselvl5gla[1], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gla2",
+		      &sprom->noiselvl5gla[2], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gma0",
+		      &sprom->noiselvl5gma[0], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gma1",
+		      &sprom->noiselvl5gma[1], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gma2",
+		      &sprom->noiselvl5gma[2], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gha0",
+		      &sprom->noiselvl5gha[0], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gha1",
+		      &sprom->noiselvl5gha[1], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gha2",
+		      &sprom->noiselvl5gha[2], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gua0",
+		      &sprom->noiselvl5gua[0], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gua1",
+		      &sprom->noiselvl5gua[1], 0);
+	nvram_read_u8(prefix, NULL, "noiselvl5gua2",
+		      &sprom->noiselvl5gua[2], 0);
+	nvram_read_u8(prefix, NULL, "pcieingress_war",
+		      &sprom->pcieingress_war, 0);
+}
+
+static void bcm47xx_fill_sprom_r9(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u16(prefix, NULL, "cckbw202gpo", &sprom->cckbw202gpo, 0);
+	nvram_read_u16(prefix, NULL, "cckbw20ul2gpo", &sprom->cckbw20ul2gpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw202gpo",
+		       &sprom->legofdmbw202gpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw20ul2gpo",
+		       &sprom->legofdmbw20ul2gpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw205glpo",
+		       &sprom->legofdmbw205glpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw20ul5glpo",
+		       &sprom->legofdmbw20ul5glpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw205gmpo",
+		       &sprom->legofdmbw205gmpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw20ul5gmpo",
+		       &sprom->legofdmbw20ul5gmpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw205ghpo",
+		       &sprom->legofdmbw205ghpo, 0);
+	nvram_read_u32(prefix, NULL, "legofdmbw20ul5ghpo",
+		       &sprom->legofdmbw20ul5ghpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw202gpo", &sprom->mcsbw202gpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw20ul2gpo", &sprom->mcsbw20ul2gpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw402gpo", &sprom->mcsbw402gpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw205glpo", &sprom->mcsbw205glpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw20ul5glpo",
+		       &sprom->mcsbw20ul5glpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw405glpo", &sprom->mcsbw405glpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw205gmpo", &sprom->mcsbw205gmpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw20ul5gmpo",
+		       &sprom->mcsbw20ul5gmpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw405gmpo", &sprom->mcsbw405gmpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw205ghpo", &sprom->mcsbw205ghpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw20ul5ghpo",
+		       &sprom->mcsbw20ul5ghpo, 0);
+	nvram_read_u32(prefix, NULL, "mcsbw405ghpo", &sprom->mcsbw405ghpo, 0);
+	nvram_read_u16(prefix, NULL, "mcs32po", &sprom->mcs32po, 0);
+	nvram_read_u16(prefix, NULL, "legofdm40duppo",
+		       &sprom->legofdm40duppo, 0);
+	nvram_read_u8(prefix, NULL, "sar2g", &sprom->sar2g, 0);
+	nvram_read_u8(prefix, NULL, "sar5g", &sprom->sar5g, 0);
+}
+
+static void bcm47xx_fill_sprom_path_r4589(struct ssb_sprom *sprom,
+					  const char *prefix)
+{
+	char postfix[2];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sprom->core_pwr_info); i++) {
+		struct ssb_sprom_core_pwr_info *pwr_info = &sprom->core_pwr_info[i];
+		snprintf(postfix, sizeof(postfix), "%i", i);
+		nvram_read_u8(prefix, postfix, "maxp2ga",
+			      &pwr_info->maxpwr_2g, 0);
+		nvram_read_u8(prefix, postfix, "itt2ga",
+			      &pwr_info->itssi_2g, 0);
+		nvram_read_u8(prefix, postfix, "itt5ga",
+			      &pwr_info->itssi_5g, 0);
+		nvram_read_u16(prefix, postfix, "pa2gw0a",
+			       &pwr_info->pa_2g[0], 0);
+		nvram_read_u16(prefix, postfix, "pa2gw1a",
+			       &pwr_info->pa_2g[1], 0);
+		nvram_read_u16(prefix, postfix, "pa2gw2a",
+			       &pwr_info->pa_2g[2], 0);
+		nvram_read_u8(prefix, postfix, "maxp5ga",
+			      &pwr_info->maxpwr_5g, 0);
+		nvram_read_u8(prefix, postfix, "maxp5gha",
+			      &pwr_info->maxpwr_5gh, 0);
+		nvram_read_u8(prefix, postfix, "maxp5gla",
+			      &pwr_info->maxpwr_5gl, 0);
+		nvram_read_u16(prefix, postfix, "pa5gw0a",
+			       &pwr_info->pa_5g[0], 0);
+		nvram_read_u16(prefix, postfix, "pa5gw1a",
+			       &pwr_info->pa_5g[1], 0);
+		nvram_read_u16(prefix, postfix, "pa5gw2a",
+			       &pwr_info->pa_5g[2], 0);
+		nvram_read_u16(prefix, postfix, "pa5glw0a",
+			       &pwr_info->pa_5gl[0], 0);
+		nvram_read_u16(prefix, postfix, "pa5glw1a",
+			       &pwr_info->pa_5gl[1], 0);
+		nvram_read_u16(prefix, postfix, "pa5glw2a",
+			       &pwr_info->pa_5gl[2], 0);
+		nvram_read_u16(prefix, postfix, "pa5ghw0a",
+			       &pwr_info->pa_5gh[0], 0);
+		nvram_read_u16(prefix, postfix, "pa5ghw1a",
+			       &pwr_info->pa_5gh[1], 0);
+		nvram_read_u16(prefix, postfix, "pa5ghw2a",
+			       &pwr_info->pa_5gh[2], 0);
+	}
+}
+
+static void bcm47xx_fill_sprom_path_r45(struct ssb_sprom *sprom,
+					const char *prefix)
+{
+	char postfix[2];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sprom->core_pwr_info); i++) {
+		struct ssb_sprom_core_pwr_info *pwr_info = &sprom->core_pwr_info[i];
+		snprintf(postfix, sizeof(postfix), "%i", i);
+		nvram_read_u16(prefix, postfix, "pa2gw3a",
+			       &pwr_info->pa_2g[3], 0);
+		nvram_read_u16(prefix, postfix, "pa5gw3a",
+			       &pwr_info->pa_5g[3], 0);
+		nvram_read_u16(prefix, postfix, "pa5glw3a",
+			       &pwr_info->pa_5gl[3], 0);
+		nvram_read_u16(prefix, postfix, "pa5ghw3a",
+			       &pwr_info->pa_5gh[3], 0);
+	}
+}
+
+void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_macaddr(prefix, "et0macaddr", &sprom->et0mac);
+	nvram_read_u8(prefix, NULL, "et0mdcport", &sprom->et0mdcport, 0);
+	nvram_read_u8(prefix, NULL, "et0phyaddr", &sprom->et0phyaddr, 0);
+
+	nvram_read_macaddr(prefix, "et1macaddr", &sprom->et1mac);
+	nvram_read_u8(prefix, NULL, "et1mdcport", &sprom->et1mdcport, 0);
+	nvram_read_u8(prefix, NULL, "et1phyaddr", &sprom->et1phyaddr, 0);
+
+	nvram_read_macaddr(prefix, "macaddr", &sprom->il0mac);
+	nvram_read_macaddr(prefix, "il0macaddr", &sprom->il0mac);
+}
+
+void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
+{
+	memset(sprom, 0, sizeof(struct ssb_sprom));
+
+	bcm47xx_fill_sprom_ethernet(sprom, prefix);
+
+	nvram_read_u8(prefix, NULL, "sromrev", &sprom->revision, 0);
+
+	switch (sprom->revision) {
+	case 1:
+		bcm47xx_fill_sprom_r1234589(sprom, prefix);
+		bcm47xx_fill_sprom_r12389(sprom, prefix);
+		bcm47xx_fill_sprom_r1(sprom, prefix);
+		break;
+	case 2:
+		bcm47xx_fill_sprom_r1234589(sprom, prefix);
+		bcm47xx_fill_sprom_r12389(sprom, prefix);
+		bcm47xx_fill_sprom_r2389(sprom, prefix);
+		bcm47xx_fill_sprom_r2(sprom, prefix);
+		break;
+	case 3:
+		bcm47xx_fill_sprom_r1234589(sprom, prefix);
+		bcm47xx_fill_sprom_r12389(sprom, prefix);
+		bcm47xx_fill_sprom_r2389(sprom, prefix);
+		bcm47xx_fill_sprom_r389(sprom, prefix);
+		bcm47xx_fill_sprom_r3(sprom, prefix);
+		break;
+	case 4:
+	case 5:
+		bcm47xx_fill_sprom_r1234589(sprom, prefix);
+		bcm47xx_fill_sprom_r4589(sprom, prefix);
+		bcm47xx_fill_sprom_r458(sprom, prefix);
+		bcm47xx_fill_sprom_r45(sprom, prefix);
+		bcm47xx_fill_sprom_path_r4589(sprom, prefix);
+		bcm47xx_fill_sprom_path_r45(sprom, prefix);
+		break;
+	case 8:
+		bcm47xx_fill_sprom_r1234589(sprom, prefix);
+		bcm47xx_fill_sprom_r12389(sprom, prefix);
+		bcm47xx_fill_sprom_r2389(sprom, prefix);
+		bcm47xx_fill_sprom_r389(sprom, prefix);
+		bcm47xx_fill_sprom_r4589(sprom, prefix);
+		bcm47xx_fill_sprom_r458(sprom, prefix);
+		bcm47xx_fill_sprom_r89(sprom, prefix);
+		bcm47xx_fill_sprom_path_r4589(sprom, prefix);
+		break;
+	case 9:
+		bcm47xx_fill_sprom_r1234589(sprom, prefix);
+		bcm47xx_fill_sprom_r12389(sprom, prefix);
+		bcm47xx_fill_sprom_r2389(sprom, prefix);
+		bcm47xx_fill_sprom_r389(sprom, prefix);
+		bcm47xx_fill_sprom_r4589(sprom, prefix);
+		bcm47xx_fill_sprom_r89(sprom, prefix);
+		bcm47xx_fill_sprom_r9(sprom, prefix);
+		bcm47xx_fill_sprom_path_r4589(sprom, prefix);
+		break;
+	default:
+		pr_warn("Unsupported SPROM revision %d detected. Will extract"
+			" v1\n", sprom->revision);
+		sprom->revision = 1;
+		bcm47xx_fill_sprom_r1234589(sprom, prefix);
+		bcm47xx_fill_sprom_r12389(sprom, prefix);
+		bcm47xx_fill_sprom_r1(sprom, prefix);
+	}
+}
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index de95e07..5ecaf47 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -44,4 +44,7 @@ union bcm47xx_bus {
 extern union bcm47xx_bus bcm47xx_bus;
 extern enum bcm47xx_bus_type bcm47xx_bus_type;
 
+void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix);
+void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom, const char *prefix);
+
 #endif /* __ASM_BCM47XX_H */
-- 
1.7.5.4
