Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 23:10:14 +0100 (CET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:53884 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeKJWI1AIPTa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Nov 2018 23:08:27 +0100
Received: from localhost.localdomain (85-76-84-189-nat.elisa-mobile.fi [85.76.84.189])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id E0F1430017;
        Sun, 11 Nov 2018 00:08:25 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver
Date:   Sun, 11 Nov 2018 00:06:12 +0200
Message-Id: <20181110220612.21653-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67226
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

Re-enable OCTEON USB driver which is needed on older hardware
(e.g. EdgeRouter Lite) for mass storage etc. This got accidentally
deleted when config options were changed for OCTEON2/3 USB.

Fixes: f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more drivers")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/configs/cavium_octeon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 490b12af103c..c52d0efacd14 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -140,6 +140,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
+CONFIG_OCTEON_USB=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y
-- 
2.17.0
