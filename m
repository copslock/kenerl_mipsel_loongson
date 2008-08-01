Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:43:29 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:61138 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574357AbYHAJkg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:36 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 8CADCC8084;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 7xjyR2M2Oj8L; Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 0A368C806C;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id C8B7610806F; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 2/7] [MIPS] Remove unused config variable MIPS_MT_DISABLED
Date:	Fri,  1 Aug 2008 12:40:16 +0300
Message-Id: <1217583621-4772-3-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The config variable MIPS_MT_DISABLED is defined but not actually
used anywhere. This patch removes the variable.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/Kconfig                          |    8 --------
 arch/mips/configs/bcm47xx_defconfig        |    1 -
 arch/mips/configs/bigsur_defconfig         |    1 -
 arch/mips/configs/capcella_defconfig       |    1 -
 arch/mips/configs/cobalt_defconfig         |    1 -
 arch/mips/configs/db1000_defconfig         |    1 -
 arch/mips/configs/db1100_defconfig         |    1 -
 arch/mips/configs/db1200_defconfig         |    1 -
 arch/mips/configs/db1500_defconfig         |    1 -
 arch/mips/configs/db1550_defconfig         |    1 -
 arch/mips/configs/decstation_defconfig     |    1 -
 arch/mips/configs/e55_defconfig            |    1 -
 arch/mips/configs/emma2rh_defconfig        |    1 -
 arch/mips/configs/excite_defconfig         |    1 -
 arch/mips/configs/fulong_defconfig         |    1 -
 arch/mips/configs/ip22_defconfig           |    1 -
 arch/mips/configs/ip27_defconfig           |    1 -
 arch/mips/configs/ip28_defconfig           |    1 -
 arch/mips/configs/ip32_defconfig           |    1 -
 arch/mips/configs/jazz_defconfig           |    1 -
 arch/mips/configs/jmr3927_defconfig        |    1 -
 arch/mips/configs/lasat_defconfig          |    1 -
 arch/mips/configs/malta_defconfig          |    1 -
 arch/mips/configs/mipssim_defconfig        |    1 -
 arch/mips/configs/mpc30x_defconfig         |    1 -
 arch/mips/configs/msp71xx_defconfig        |    1 -
 arch/mips/configs/mtx1_defconfig           |    1 -
 arch/mips/configs/pb1100_defconfig         |    1 -
 arch/mips/configs/pb1500_defconfig         |    1 -
 arch/mips/configs/pb1550_defconfig         |    1 -
 arch/mips/configs/pnx8550-jbs_defconfig    |    1 -
 arch/mips/configs/pnx8550-stb810_defconfig |    1 -
 arch/mips/configs/rb532_defconfig          |    1 -
 arch/mips/configs/rbtx49xx_defconfig       |    1 -
 arch/mips/configs/rm200_defconfig          |    1 -
 arch/mips/configs/sb1250-swarm_defconfig   |    1 -
 arch/mips/configs/tb0219_defconfig         |    1 -
 arch/mips/configs/tb0226_defconfig         |    1 -
 arch/mips/configs/tb0287_defconfig         |    1 -
 arch/mips/configs/workpad_defconfig        |    1 -
 arch/mips/configs/wrppmc_defconfig         |    1 -
 arch/mips/configs/yosemite_defconfig       |    1 -
 42 files changed, 0 insertions(+), 49 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8429773..fced035 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1380,14 +1380,6 @@ config CPU_HAS_PREFETCH
 choice
 	prompt "MIPS MT options"
 
-config MIPS_MT_DISABLED
-	bool "Disable multithreading support."
-	help
-	  Use this option if your workload can't take advantage of
-	  MIPS hardware multithreading support.  On systems that don't have
-	  the option of an MT-enabled processor this option will be the only
-	  option in this menu.
-
 config MIPS_MT_SMP
 	bool "Use 1 TC on each available VPE for SMP"
 	depends on SYS_SUPPORTS_MULTITHREADING
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index d869433..0a81d31 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -108,7 +108,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index a3bbbf0..9aa8e6e 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -126,7 +126,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_SIBYTE_DMA_PAGEOPS is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index 185df23..b35dbe2 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -101,7 +101,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index 2678b7e..7f1935a 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -100,7 +100,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index ebb8ad6..3266d66 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -109,7 +109,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index ad4e5ef..995900c 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -109,7 +109,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index d0dc2e8..3842902 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -109,7 +109,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 9155082..2c64da0 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -111,7 +111,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index e4e3244..becccf7 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -110,7 +110,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 9e65e6a..84b726e 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -107,7 +107,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index 1bd84d4..1675d6d 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -100,7 +100,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/emma2rh_defconfig b/arch/mips/configs/emma2rh_defconfig
index 634bb4e..eaeca09 100644
--- a/arch/mips/configs/emma2rh_defconfig
+++ b/arch/mips/configs/emma2rh_defconfig
@@ -107,7 +107,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/excite_defconfig b/arch/mips/configs/excite_defconfig
index 3572e80..b79d1b8 100644
--- a/arch/mips/configs/excite_defconfig
+++ b/arch/mips/configs/excite_defconfig
@@ -113,7 +113,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/fulong_defconfig b/arch/mips/configs/fulong_defconfig
index 6209800..fc5d5d4 100644
--- a/arch/mips/configs/fulong_defconfig
+++ b/arch/mips/configs/fulong_defconfig
@@ -98,7 +98,6 @@ CONFIG_64BIT=y
 CONFIG_PAGE_SIZE_16KB=y
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_BOARD_SCACHE=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index cc8e6bf..c91f7ef 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -107,7 +107,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_BOARD_SCACHE=y
 CONFIG_IP22_CPU_SCACHE=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index bed6016..e51d388 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -102,7 +102,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index 3540707..7f86d72 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -121,7 +121,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index fe4699d..3794abd 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -113,7 +113,6 @@ CONFIG_PAGE_SIZE_4KB=y
 CONFIG_BOARD_SCACHE=y
 CONFIG_R5000_CPU_SCACHE=y
 CONFIG_RM7000_CPU_SCACHE=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index bbacc35..181462d 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -114,7 +114,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 9d5bd2a..f7e3527 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -107,7 +107,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/lasat_defconfig b/arch/mips/configs/lasat_defconfig
index bc9159f..0db2dcf 100644
--- a/arch/mips/configs/lasat_defconfig
+++ b/arch/mips/configs/lasat_defconfig
@@ -105,7 +105,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_BOARD_SCACHE=y
 CONFIG_R5000_CPU_SCACHE=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 74daa0c..dee1ceb 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -121,7 +121,6 @@ CONFIG_PAGE_SIZE_4KB=y
 CONFIG_BOARD_SCACHE=y
 CONFIG_MIPS_CPU_SCACHE=y
 CONFIG_CPU_HAS_PREFETCH=y
-# CONFIG_MIPS_MT_DISABLED is not set
 CONFIG_MIPS_MT_SMP=y
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_MIPS_MT=y
diff --git a/arch/mips/configs/mipssim_defconfig b/arch/mips/configs/mipssim_defconfig
index 2c0a631..424a874 100644
--- a/arch/mips/configs/mipssim_defconfig
+++ b/arch/mips/configs/mipssim_defconfig
@@ -110,7 +110,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_SYS_SUPPORTS_MULTITHREADING=y
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index 8c720e5..57f5689 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -101,7 +101,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/msp71xx_defconfig b/arch/mips/configs/msp71xx_defconfig
index 59d1947..03dde5f 100644
--- a/arch/mips/configs/msp71xx_defconfig
+++ b/arch/mips/configs/msp71xx_defconfig
@@ -123,7 +123,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index bacf0dd..07ae765 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -112,7 +112,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_64BIT_PHYS_ADDR=y
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index 6dfe6f7..fda4b41 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -110,7 +110,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index c965a87..4096e47 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -109,7 +109,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index 0778996..06ed223 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -110,7 +110,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/pnx8550-jbs_defconfig b/arch/mips/configs/pnx8550-jbs_defconfig
index 37c7b5f..571806f 100644
--- a/arch/mips/configs/pnx8550-jbs_defconfig
+++ b/arch/mips/configs/pnx8550-jbs_defconfig
@@ -107,7 +107,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/pnx8550-stb810_defconfig b/arch/mips/configs/pnx8550-stb810_defconfig
index 893e5c4..fa7af42 100644
--- a/arch/mips/configs/pnx8550-stb810_defconfig
+++ b/arch/mips/configs/pnx8550-stb810_defconfig
@@ -107,7 +107,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index f28dc32..75eee9a 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -110,7 +110,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index e42aed5..c9633d7 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -123,7 +123,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_LLSC=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 0f4da03..00ee239 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -119,7 +119,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_BOARD_SCACHE=y
 CONFIG_R5000_CPU_SCACHE=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index 1ea9786..72cef77 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -129,7 +129,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_SIBYTE_DMA_PAGEOPS is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_SB1_PASS_2_WORKAROUNDS=y
diff --git a/arch/mips/configs/tb0219_defconfig b/arch/mips/configs/tb0219_defconfig
index b505988..ebc3662 100644
--- a/arch/mips/configs/tb0219_defconfig
+++ b/arch/mips/configs/tb0219_defconfig
@@ -112,7 +112,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index b06a716..b8f6ce3 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -112,7 +112,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index 46512cf..b3dc2c8 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -112,7 +112,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index b437eb7..6d79a28 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -100,7 +100,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_CPU_HAS_SYNC=y
diff --git a/arch/mips/configs/wrppmc_defconfig b/arch/mips/configs/wrppmc_defconfig
index fc2c567..284aa61 100644
--- a/arch/mips/configs/wrppmc_defconfig
+++ b/arch/mips/configs/wrppmc_defconfig
@@ -115,7 +115,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
diff --git a/arch/mips/configs/yosemite_defconfig b/arch/mips/configs/yosemite_defconfig
index 7f86c43..356e097 100644
--- a/arch/mips/configs/yosemite_defconfig
+++ b/arch/mips/configs/yosemite_defconfig
@@ -110,7 +110,6 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
-- 
1.5.6
