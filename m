Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 00:55:42 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:37905 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860093AbaG1WINTH0vf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jul 2014 00:08:13 +0200
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by test.hauke-m.de (Postfix) with ESMTPSA id C36802000B;
        Tue, 29 Jul 2014 00:08:12 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2] MIPS: BCM47XX: fixup broken MAC addresses in nvram
Date:   Tue, 29 Jul 2014 00:08:01 +0200
Message-Id: <1406585281-13054-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406584487-31167-1-git-send-email-hauke@hauke-m.de>
References: <1406584487-31167-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41726
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

The address prefix 00:90:4C is used by Broadcom in their initial
configuration. When a mac address with the prefix 00:90:4C is used all
devices from the same series are sharing the same mac address. To
prevent mac address collisions we replace them with a mac address based
on the base address. To generate such addresses we take the main mac
address from et0macaddr and increase it by two for the first wifi
device and by 3 for the second one. This matches the printed mac
address on the device. The main mac address increased by one is used as
wan address by the vendor code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

v1: fix checkpatch warnings

 arch/mips/bcm47xx/sprom.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index da4cdb1..41226b6 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -28,6 +28,8 @@
 
 #include <bcm47xx.h>
 #include <bcm47xx_nvram.h>
+#include <linux/if_ether.h>
+#include <linux/etherdevice.h>
 
 static void create_key(const char *prefix, const char *postfix,
 		       const char *name, char *buf, int len)
@@ -631,6 +633,33 @@ static void bcm47xx_fill_sprom_path_r45(struct ssb_sprom *sprom,
 	}
 }
 
+static bool bcm47xx_is_valid_mac(u8 *mac)
+{
+	return mac && !(mac[0] == 0x00 && mac[1] == 0x90 && mac[2] == 0x4c);
+}
+
+static int bcm47xx_increase_mac_addr(u8 *mac, u8 num)
+{
+	u8 *oui = mac + ETH_ALEN/2 - 1;
+	u8 *p = mac + ETH_ALEN - 1;
+
+	do {
+		(*p) += num;
+		if (*p > num)
+			break;
+		p--;
+		num = 1;
+	} while (p != oui);
+
+	if (p == oui) {
+		pr_err("unable to fetch mac address\n");
+		return -ENOENT;
+	}
+	return 0;
+}
+
+static int mac_addr_used = 2;
+
 static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 					const char *prefix, bool fallback)
 {
@@ -648,6 +677,25 @@ static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 
 	nvram_read_macaddr(prefix, "macaddr", sprom->il0mac, fallback);
 	nvram_read_macaddr(prefix, "il0macaddr", sprom->il0mac, fallback);
+
+	/* The address prefix 00:90:4C is used by Broadcom in their initial
+	   configuration. When a mac address with the prefix 00:90:4C is used
+	   all devices from the same series are sharing the same mac address.
+	   To prevent mac address collisions we replace them with a mac address
+	   based on the base address. */
+	if (!bcm47xx_is_valid_mac(sprom->il0mac)) {
+		u8 mac[6];
+
+		nvram_read_macaddr(NULL, "et0macaddr", mac, false);
+		if (bcm47xx_is_valid_mac(mac)) {
+			int err = bcm47xx_increase_mac_addr(mac, mac_addr_used);
+
+			if (!err) {
+				ether_addr_copy(sprom->il0mac, mac);
+				mac_addr_used++;
+			}
+		}
+	}
 }
 
 static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix,
-- 
1.9.1
