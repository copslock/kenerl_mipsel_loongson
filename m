Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 00:28:38 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:52525 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992936AbdFSW03oK26i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 00:26:29 +0200
Received: from hauke-desktop.lan (p4FD9730E.dip0.t-ipconnect.de [79.217.115.14])
        by mail.hauke-m.de (Postfix) with ESMTPSA id B4E761001DE;
        Tue, 20 Jun 2017 00:26:23 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 01/16] MIPS: lantiq: Use of_platform_default_populate instead of __dt_register_buses
Date:   Tue, 20 Jun 2017 00:25:53 +0200
Message-Id: <20170619222608.13344-2-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170619222608.13344-1-hauke@hauke-m.de>
References: <20170619222608.13344-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58642
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
 arch/mips/lantiq/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 96773bed8a8a..9ff7ccde9de0 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -117,7 +117,7 @@ void __init prom_init(void)
 
 int __init plat_of_setup(void)
 {
-	return __dt_register_buses(soc_info.compatible, "simple-bus");
+	return of_platform_default_populate(NULL, NULL, NULL);
 }
 
 arch_initcall(plat_of_setup);
-- 
2.11.0
