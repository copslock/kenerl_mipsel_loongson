From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Wed, 21 May 2008 15:13:51 +0200
Subject: [PATCH] Alchemy: remove unused MMC macros from db1x00 header.
Message-ID: <20080521131351.Mm1uwXxcvRlI2ti1xlzG9oQMD8cSr6mOMcagYyuFYqg@z>

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 include/asm-mips/mach-db1x00/db1x00.h |   45 ---------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/include/asm-mips/mach-db1x00/db1x00.h b/include/asm-mips/mach-db1x00/db1x00.h
index 612ae90..1a515b8 100644
--- a/include/asm-mips/mach-db1x00/db1x00.h
+++ b/include/asm-mips/mach-db1x00/db1x00.h
@@ -146,51 +146,6 @@ typedef volatile struct
 	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
 
 /*
- * SD controller macros
- */
-
-/* Detect card. */
-#define mmc_card_inserted(_n_, _res_) \
-	do { \
-		BCSR * const bcsr = (BCSR *)0xAE000000; \
-		unsigned long mmc_wp, board_specific; \
-		if ((_n_)) { \
-			mmc_wp = BCSR_BOARD_SD1_WP; \
-		} else { \
-			mmc_wp = BCSR_BOARD_SD0_WP; \
-		} \
-		board_specific = au_readl((unsigned long)(&bcsr->specific)); \
-		if (!(board_specific & mmc_wp)) {/* low means card present */ \
-			*(int *)(_res_) = 1; \
-		} else { \
-			*(int *)(_res_) = 0; \
-		} \
-	} while (0)
-
-/*
- * Apply power to card slot(s).
- */
-#define mmc_power_on(_n_) \
-	do { \
-		BCSR * const bcsr = (BCSR *)0xAE000000; \
-		unsigned long mmc_pwr, mmc_wp, board_specific; \
-		if ((_n_)) { \
-			mmc_pwr = BCSR_BOARD_SD1_PWR; \
-			mmc_wp	= BCSR_BOARD_SD1_WP; \
-		} else { \
-			mmc_pwr = BCSR_BOARD_SD0_PWR; \
-			mmc_wp	= BCSR_BOARD_SD0_WP; \
-		} \
-		board_specific = au_readl((unsigned long)(&bcsr->specific)); \
-		if (!(board_specific & mmc_wp)) {/* low means card present */ \
-			board_specific |= mmc_pwr; \
-			au_writel(board_specific, (int)(&bcsr->specific)); \
-			au_sync(); \
-		} \
-	} while (0)
-
-
-/*
  * NAND defines
  *
  * Timing values as described in databook, * ns value stripped of the
-- 
1.5.5.3
