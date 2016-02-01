From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 31 Jan 2016 17:40:01 -0800
Subject: MAINTAINERS: Remove stale entry for BCM33xx chips
Message-ID: <20160201014001.nOtksRPEGySmbgjOZFaJ8hjNmjvSvgH-CxrbsdIvIic@z>

commit 87bee0ecf01d2ed0d48bba1fb12c954f9476d243 upstream.

Commit 70371cef114ca ("MAINTAINERS: Add entry for BMIPS multiplatform
kernel") supersedes this entry for BCM33xx.

Fixes: 70371cef114ca ("MAINTAINERS: Add entry for BMIPS multiplatform kernel")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: blogic@openwrt.org
Cc: cernekee@gmail.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12301/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 052550c..af67971 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2108,14 +2108,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
 N:	bcm2835

-BROADCOM BCM33XX MIPS ARCHITECTURE
-M:	Kevin Cernekee <cernekee@gmail.com>
-L:	linux-mips@linux-mips.org
-S:	Maintained
-F:	arch/mips/bcm3384/*
-F:	arch/mips/include/asm/mach-bcm3384/*
-F:	arch/mips/kernel/*bmips*
-
 BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	linux-arm-kernel@lists.infradead.org
--
2.7.0
