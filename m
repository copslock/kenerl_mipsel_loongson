Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 13:30:12 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:36353 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008504AbaLWMaJPo7Ex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 13:30:09 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 23 Dec
 2014 15:30:03 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/3] MIPS: OCTEON: Protect accesses to bootbus flash with octeon_bootbus_sem.
Date:   Tue, 23 Dec 2014 15:27:00 +0300
Message-ID: <1419337623-16101-3-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1419337623-16101-1-git-send-email-aleksey.makarov@auriga.com>
References: <1419337623-16101-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

Without this, we get bus errors.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/Kconfig                     |  1 +
 arch/mips/cavium-octeon/flash_setup.c | 42 ++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3289969..94f6012 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -790,6 +790,7 @@ config CAVIUM_OCTEON_SOC
 	select SYS_SUPPORTS_SMP
 	select NR_CPUS_DEFAULT_16
 	select BUILTIN_DTB
+	select MTD_COMPLEX_MAPPINGS
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
index 237e5b1..39e26df 100644
--- a/arch/mips/cavium-octeon/flash_setup.c
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -9,6 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/semaphore.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
@@ -25,6 +26,41 @@ static const char *part_probe_types[] = {
 	NULL
 };
 
+static map_word octeon_flash_map_read(struct map_info *map, unsigned long ofs)
+{
+	map_word r;
+
+	down(&octeon_bootbus_sem);
+	r = inline_map_read(map, ofs);
+	up(&octeon_bootbus_sem);
+
+	return r;
+}
+
+static void octeon_flash_map_write(struct map_info *map, const map_word datum,
+				   unsigned long ofs)
+{
+	down(&octeon_bootbus_sem);
+	inline_map_write(map, datum, ofs);
+	up(&octeon_bootbus_sem);
+}
+
+static void octeon_flash_map_copy_from(struct map_info *map, void *to,
+				       unsigned long from, ssize_t len)
+{
+	down(&octeon_bootbus_sem);
+	inline_map_copy_from(map, to, from, len);
+	up(&octeon_bootbus_sem);
+}
+
+static void octeon_flash_map_copy_to(struct map_info *map, unsigned long to,
+				     const void *from, ssize_t len)
+{
+	down(&octeon_bootbus_sem);
+	inline_map_copy_to(map, to, from, len);
+	up(&octeon_bootbus_sem);
+}
+
 /**
  * Module/ driver initialization.
  *
@@ -56,7 +92,11 @@ static int __init flash_init(void)
 		flash_map.virt = ioremap(flash_map.phys, flash_map.size);
 		pr_notice("Bootbus flash: Setting flash for %luMB flash at "
 			  "0x%08llx\n", flash_map.size >> 20, flash_map.phys);
-		simple_map_init(&flash_map);
+		WARN_ON(!map_bankwidth_supported(flash_map.bankwidth));
+		flash_map.read = octeon_flash_map_read;
+		flash_map.write = octeon_flash_map_write;
+		flash_map.copy_from = octeon_flash_map_copy_from;
+		flash_map.copy_to = octeon_flash_map_copy_to;
 		mymtd = do_map_probe("cfi_probe", &flash_map);
 		if (mymtd) {
 			mymtd->owner = THIS_MODULE;
-- 
2.1.3
