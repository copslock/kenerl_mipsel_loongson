Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 13:47:22 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.176]:41678
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226019AbVCaMrG>; Thu, 31 Mar 2005 13:47:06 +0100
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DGz4i-00024D-00; Thu, 31 Mar 2005 14:47:04 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DGz4i-0001nY-00; Thu, 31 Mar 2005 14:47:04 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] unused and buggy macros
Date:	Thu, 31 Mar 2005 14:47:24 +0200
User-Agent: KMail/1.7.1
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311447.24961.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

In db1x00/db1x00.h are two macros (mmc_card_inserted, mmc_power_on) that are 
not used and partially buggy. The 'bug' in them is that they use 0xAE000000 
directly instead of BCSR_KSEG1_ADDR, possibly breaking db1550 which has its 
BCSRs at a different address.

Another thing I stumbled across is the definitions of NAND_* in the same file. 
These are repeated in a few other board-specific headers, but always with the 
same values. The final NAND_TIMING is also only used once in 
drivers/mtd/nand/au1550nd.c. I don't know if that is intentional, but maybe 
someone that knows what's going on there could take a look at it.

This patch removes only the mmc_* macros, I didn't touch the others. The patch 
is against the 2.6 sources, but I found that these macros also exist under 
2.4.29 (not sure if this is from l-m.org or from kernel.org) and are unused 
there as well.

cheers

Uli

---

Index: include/asm/mach-db1x00/db1x00.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-db1x00/db1x00.h,v
retrieving revision 1.7
diff -u -w -r1.7 db1x00.h
--- include/asm/mach-db1x00/db1x00.h 15 Jan 2005 01:31:04 -0000 1.7
+++ include/asm/mach-db1x00/db1x00.h 31 Mar 2005 12:45:51 -0000
@@ -59,7 +59,6 @@
  unsigned short reserved6;
  /*1C*/ unsigned short swreset;
  unsigned short reserved7;
-
 } BCSR;
 
 
@@ -134,50 +133,6 @@
 #define SET_VCC_VPP(VCC, VPP, SLOT)\
  ((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
 
-/* SD controller macros */
-/*
- * Detect card.
- */
-#define mmc_card_inserted(_n_, _res_) \
- do { \
-  BCSR * const bcsr = (BCSR *)0xAE000000; \
-  unsigned long mmc_wp, board_specific; \
-  if ((_n_)) { \
-   mmc_wp = BCSR_BOARD_SD1_WP; \
-  } else { \
-   mmc_wp = BCSR_BOARD_SD0_WP; \
-  } \
-  board_specific = au_readl((unsigned long)(&bcsr->specific)); \
-  if (!(board_specific & mmc_wp)) {/* low means card present */ \
-   *(int *)(_res_) = 1; \
-  } else { \
-   *(int *)(_res_) = 0; \
-  } \
- } while (0)
-
-/*
- * Apply power to card slot(s).
- */
-#define mmc_power_on(_n_) \
- do { \
-  BCSR * const bcsr = (BCSR *)0xAE000000; \
-  unsigned long mmc_pwr, mmc_wp, board_specific; \
-  if ((_n_)) { \
-   mmc_pwr = BCSR_BOARD_SD1_PWR; \
-   mmc_wp = BCSR_BOARD_SD1_WP; \
-  } else { \
-   mmc_pwr = BCSR_BOARD_SD0_PWR; \
-   mmc_wp = BCSR_BOARD_SD0_WP; \
-  } \
-  board_specific = au_readl((unsigned long)(&bcsr->specific)); \
-  if (!(board_specific & mmc_wp)) {/* low means card present */ \
-   board_specific |= mmc_pwr; \
-   au_writel(board_specific, (int)(&bcsr->specific)); \
-   au_sync(); \
-  } \
- } while (0)
-
-
 /* NAND defines */
 /* Timing values as described in databook, * ns value stripped of
  * lower 2 bits.
