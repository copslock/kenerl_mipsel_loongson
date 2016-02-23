Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 23:52:48 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:33991 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013848AbcBWWwLduHdR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 23:52:11 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 2C074234053;
        Wed, 24 Feb 2016 00:52:11 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 2/3] MIPS: OCTEON: device_tree_init: don't fill mac if already set
Date:   Wed, 24 Feb 2016 00:52:06 +0200
Message-Id: <1456267927-2492-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
References: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Don't fill MAC address if it's already set. This allows DTB to
override the bootinfo.

Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/octeon-platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index a7d9f07..7aeafed 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/usb.h>
 #include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -525,10 +526,17 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
 
 static void __init octeon_fdt_set_mac_addr(int n, u64 *pmac)
 {
+	const u8 *old_mac;
+	int old_len;
 	u8 new_mac[6];
 	u64 mac = *pmac;
 	int r;
 
+	old_mac = fdt_getprop(initial_boot_params, n, "local-mac-address",
+			      &old_len);
+	if (!old_mac || old_len != 6 || is_valid_ether_addr(old_mac))
+		return;
+
 	new_mac[0] = (mac >> 40) & 0xff;
 	new_mac[1] = (mac >> 32) & 0xff;
 	new_mac[2] = (mac >> 24) & 0xff;
-- 
2.4.0
