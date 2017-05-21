Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2017 15:09:49 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:45969 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990509AbdEUNJnPrF6B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 May 2017 15:09:43 +0200
Received: from hauke-desktop.lan (p2003008628380100610A1109F04F7762.dip0.t-ipconnect.de [IPv6:2003:86:2838:100:610a:1109:f04f:7762])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 33BA7100037;
        Sun, 21 May 2017 15:09:42 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 01/15] MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
Date:   Sun, 21 May 2017 15:09:04 +0200
Message-Id: <20170521130918.27446-2-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170521130918.27446-1-hauke@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57906
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This allows populating syscon devices which are using "simple-mfd"
instead of "simple-bus".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/mips/lantiq/prom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 96773bed8a8a..72cc12f1b6a5 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -117,7 +117,8 @@ void __init prom_init(void)
 
 int __init plat_of_setup(void)
 {
-	return __dt_register_buses(soc_info.compatible, "simple-bus");
+	return of_platform_populate(NULL, of_default_bus_match_table, NULL,
+				    NULL);
 }
 
 arch_initcall(plat_of_setup);
-- 
2.11.0
