Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2016 20:40:12 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:42760 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992091AbcHWSkFpl7p7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2016 20:40:05 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 75E282340BB;
        Tue, 23 Aug 2016 21:40:03 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: fix platform bus probing
Date:   Tue, 23 Aug 2016 21:39:43 +0300
Message-Id: <20160823183943.20888-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54734
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

Commit 44a7185c2ae6 ("of/platform: Add common method to populate
default bus") added new arch_initcall of_platform_default_populate_init()
that will override device_initcall octeon_publish_devices(). This broke
many OCTEON boards as important devices are not getting probed anymore
(e.g. on EdgeRouter Lite the USB mass storage/rootfs is missing).

Fix by changing octeon_publish_devices() to arch_initcall.

Fixes: 44a7185c2ae6 ("of/platform: Add common method to populate default bus")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index b31fbc9..37a932d 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -1059,7 +1059,7 @@ static int __init octeon_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, octeon_ids, NULL);
 }
-device_initcall(octeon_publish_devices);
+arch_initcall(octeon_publish_devices);
 
 MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
 MODULE_LICENSE("GPL");
-- 
2.9.2
