Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 23:54:36 +0100 (CET)
Received: from mail-yk0-f202.google.com ([209.85.160.202]:33062 "EHLO
        mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013727AbbCMWySDGfop (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 23:54:18 +0100
Received: by ykp131 with SMTP id 131so4310016ykp.0
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 15:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f4mqnKQQyOTTFNd86l8KpJzc0u56Gxbdy2ILe060Y4w=;
        b=fw0v9jdn/nyg9aGppFQKXQlIFrNY/rDV4NJr/EF0MkmFKw4j04g7IB0su5OlZhujxK
         Evu2BkexdDEOzyrFZyJh5Huoh9rpOlxVheWXS4Vaus9EgSucHcZ7FkOQYgdNvqjgNYsP
         xaRxRifQBAVIcgS/O9nT0wqnxhiTe08SnDPezxWOylTD7QrA+Aucm1WJFnjAKhBWT4bc
         yNztjqWj0X7dS5znn+mfWs1JdFQ9U892BFNBR+ym5wYnTYK5tnRvg2Q7FeNBGcoeeZ3w
         wssNZz/87f09hUzjsRGYX4yjD+RJ2dyoWfNJnlGiGvMlmCoCcRGcgRf2clg+ScaNaNUU
         KGyQ==
X-Gm-Message-State: ALoCoQkfKNRg9zNVCbnFKm1iRsUXFzHHEZ9BMMsYsjLcT6AmJwxswciseQuzRc3TaW5rITYo7uj0
X-Received: by 10.236.42.228 with SMTP id j64mr50859393yhb.36.1426287252648;
        Fri, 13 Mar 2015 15:54:12 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id d72si188779yhb.5.2015.03.13.15.54.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2015 15:54:12 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id fSTU6C30.1; Fri, 13 Mar 2015 15:54:12 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 876A8220C28; Fri, 13 Mar 2015 15:54:11 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 1/5] MIPS: Create a common <asm/mach-generic/war.h>
Date:   Fri, 13 Mar 2015 15:54:05 -0700
Message-Id: <1426287249-27185-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
References: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

From: Kevin Cernekee <cernekee@gmail.com>

11 platforms require at least one of these workarounds to be enabled; 22
platforms do not.  In the latter case we can fall back to a generic version.

Note that this also deletes an orphaned reference to RM9000_CDEX_SMP_WAR.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v1.
Changes from Kevin's v6:
 - Left cavium-octeon's war.h in-tact
---
 arch/mips/include/asm/mach-ar7/war.h       | 24 ------------------------
 arch/mips/include/asm/mach-ath25/war.h     | 25 -------------------------
 arch/mips/include/asm/mach-ath79/war.h     | 24 ------------------------
 arch/mips/include/asm/mach-au1x00/war.h    | 24 ------------------------
 arch/mips/include/asm/mach-bcm3384/war.h   | 24 ------------------------
 arch/mips/include/asm/mach-bcm47xx/war.h   | 24 ------------------------
 arch/mips/include/asm/mach-bcm63xx/war.h   | 24 ------------------------
 arch/mips/include/asm/mach-cobalt/war.h    | 24 ------------------------
 arch/mips/include/asm/mach-dec/war.h       | 24 ------------------------
 arch/mips/include/asm/mach-emma2rh/war.h   | 24 ------------------------
 arch/mips/include/asm/mach-generic/war.h   | 24 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-jazz/war.h      | 24 ------------------------
 arch/mips/include/asm/mach-jz4740/war.h    | 24 ------------------------
 arch/mips/include/asm/mach-lantiq/war.h    | 23 -----------------------
 arch/mips/include/asm/mach-lasat/war.h     | 24 ------------------------
 arch/mips/include/asm/mach-loongson/war.h  | 24 ------------------------
 arch/mips/include/asm/mach-loongson1/war.h | 24 ------------------------
 arch/mips/include/asm/mach-netlogic/war.h  | 25 -------------------------
 arch/mips/include/asm/mach-paravirt/war.h  | 25 -------------------------
 arch/mips/include/asm/mach-pnx833x/war.h   | 24 ------------------------
 arch/mips/include/asm/mach-ralink/war.h    | 24 ------------------------
 arch/mips/include/asm/mach-tx39xx/war.h    | 24 ------------------------
 arch/mips/include/asm/mach-vr41xx/war.h    | 24 ------------------------
 23 files changed, 24 insertions(+), 530 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ar7/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath25/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath79/war.h
 delete mode 100644 arch/mips/include/asm/mach-au1x00/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm3384/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm47xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-cobalt/war.h
 delete mode 100644 arch/mips/include/asm/mach-dec/war.h
 delete mode 100644 arch/mips/include/asm/mach-emma2rh/war.h
 create mode 100644 arch/mips/include/asm/mach-generic/war.h
 delete mode 100644 arch/mips/include/asm/mach-jazz/war.h
 delete mode 100644 arch/mips/include/asm/mach-jz4740/war.h
 delete mode 100644 arch/mips/include/asm/mach-lantiq/war.h
 delete mode 100644 arch/mips/include/asm/mach-lasat/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson1/war.h
 delete mode 100644 arch/mips/include/asm/mach-netlogic/war.h
 delete mode 100644 arch/mips/include/asm/mach-paravirt/war.h
 delete mode 100644 arch/mips/include/asm/mach-pnx833x/war.h
 delete mode 100644 arch/mips/include/asm/mach-ralink/war.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-vr41xx/war.h

diff --git a/arch/mips/include/asm/mach-ar7/war.h b/arch/mips/include/asm/mach-ar7/war.h
deleted file mode 100644
index 99071e5..0000000
--- a/arch/mips/include/asm/mach-ar7/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_AR7_WAR_H
-#define __ASM_MIPS_MACH_AR7_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_AR7_WAR_H */
diff --git a/arch/mips/include/asm/mach-ath25/war.h b/arch/mips/include/asm/mach-ath25/war.h
deleted file mode 100644
index e3a5250..0000000
--- a/arch/mips/include/asm/mach-ath25/war.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2008 Felix Fietkau <nbd@openwrt.org>
- */
-#ifndef __ASM_MACH_ATH25_WAR_H
-#define __ASM_MACH_ATH25_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define RM9000_CDEX_SMP_WAR		0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MACH_ATH25_WAR_H */
diff --git a/arch/mips/include/asm/mach-ath79/war.h b/arch/mips/include/asm/mach-ath79/war.h
deleted file mode 100644
index 0bb3090..0000000
--- a/arch/mips/include/asm/mach-ath79/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MACH_ATH79_WAR_H
-#define __ASM_MACH_ATH79_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MACH_ATH79_WAR_H */
diff --git a/arch/mips/include/asm/mach-au1x00/war.h b/arch/mips/include/asm/mach-au1x00/war.h
deleted file mode 100644
index 72e260d..0000000
--- a/arch/mips/include/asm/mach-au1x00/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_AU1X00_WAR_H
-#define __ASM_MIPS_MACH_AU1X00_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_AU1X00_WAR_H */
diff --git a/arch/mips/include/asm/mach-bcm3384/war.h b/arch/mips/include/asm/mach-bcm3384/war.h
deleted file mode 100644
index 59d7599..0000000
--- a/arch/mips/include/asm/mach-bcm3384/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_BCM3384_WAR_H
-#define __ASM_MIPS_MACH_BCM3384_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_BCM3384_WAR_H */
diff --git a/arch/mips/include/asm/mach-bcm47xx/war.h b/arch/mips/include/asm/mach-bcm47xx/war.h
deleted file mode 100644
index a3d2f44..0000000
--- a/arch/mips/include/asm/mach-bcm47xx/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_BCM47XX_WAR_H
-#define __ASM_MIPS_MACH_BCM47XX_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_BCM47XX_WAR_H */
diff --git a/arch/mips/include/asm/mach-bcm63xx/war.h b/arch/mips/include/asm/mach-bcm63xx/war.h
deleted file mode 100644
index 05ee867..0000000
--- a/arch/mips/include/asm/mach-bcm63xx/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_BCM63XX_WAR_H
-#define __ASM_MIPS_MACH_BCM63XX_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_BCM63XX_WAR_H */
diff --git a/arch/mips/include/asm/mach-cobalt/war.h b/arch/mips/include/asm/mach-cobalt/war.h
deleted file mode 100644
index 34ae404..0000000
--- a/arch/mips/include/asm/mach-cobalt/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_COBALT_WAR_H
-#define __ASM_MIPS_MACH_COBALT_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_COBALT_WAR_H */
diff --git a/arch/mips/include/asm/mach-dec/war.h b/arch/mips/include/asm/mach-dec/war.h
deleted file mode 100644
index d29996f..0000000
--- a/arch/mips/include/asm/mach-dec/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_DEC_WAR_H
-#define __ASM_MIPS_MACH_DEC_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_DEC_WAR_H */
diff --git a/arch/mips/include/asm/mach-emma2rh/war.h b/arch/mips/include/asm/mach-emma2rh/war.h
deleted file mode 100644
index 79ae82d..0000000
--- a/arch/mips/include/asm/mach-emma2rh/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_EMMA2RH_WAR_H
-#define __ASM_MIPS_MACH_EMMA2RH_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_EMMA2RH_WAR_H */
diff --git a/arch/mips/include/asm/mach-generic/war.h b/arch/mips/include/asm/mach-generic/war.h
new file mode 100644
index 0000000..a1bc2e7
--- /dev/null
+++ b/arch/mips/include/asm/mach-generic/war.h
@@ -0,0 +1,24 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MACH_GENERIC_WAR_H
+#define __ASM_MACH_GENERIC_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MACH_GENERIC_WAR_H */
diff --git a/arch/mips/include/asm/mach-jazz/war.h b/arch/mips/include/asm/mach-jazz/war.h
deleted file mode 100644
index 5b18b9a..0000000
--- a/arch/mips/include/asm/mach-jazz/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_JAZZ_WAR_H
-#define __ASM_MIPS_MACH_JAZZ_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_JAZZ_WAR_H */
diff --git a/arch/mips/include/asm/mach-jz4740/war.h b/arch/mips/include/asm/mach-jz4740/war.h
deleted file mode 100644
index 9b511d3..0000000
--- a/arch/mips/include/asm/mach-jz4740/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_JZ4740_WAR_H
-#define __ASM_MIPS_MACH_JZ4740_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_JZ4740_WAR_H */
diff --git a/arch/mips/include/asm/mach-lantiq/war.h b/arch/mips/include/asm/mach-lantiq/war.h
deleted file mode 100644
index 358ca97..0000000
--- a/arch/mips/include/asm/mach-lantiq/war.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- */
-#ifndef __ASM_MIPS_MACH_LANTIQ_WAR_H
-#define __ASM_MIPS_MACH_LANTIQ_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif
diff --git a/arch/mips/include/asm/mach-lasat/war.h b/arch/mips/include/asm/mach-lasat/war.h
deleted file mode 100644
index 741ae72..0000000
--- a/arch/mips/include/asm/mach-lasat/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_LASAT_WAR_H
-#define __ASM_MIPS_MACH_LASAT_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_LASAT_WAR_H */
diff --git a/arch/mips/include/asm/mach-loongson/war.h b/arch/mips/include/asm/mach-loongson/war.h
deleted file mode 100644
index f2570df..0000000
--- a/arch/mips/include/asm/mach-loongson/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MACH_LOONGSON_WAR_H
-#define __ASM_MACH_LOONGSON_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MACH_LEMOTE_WAR_H */
diff --git a/arch/mips/include/asm/mach-loongson1/war.h b/arch/mips/include/asm/mach-loongson1/war.h
deleted file mode 100644
index 8fb50d0..0000000
--- a/arch/mips/include/asm/mach-loongson1/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MACH_LOONGSON1_WAR_H
-#define __ASM_MACH_LOONGSON1_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MACH_LOONGSON1_WAR_H */
diff --git a/arch/mips/include/asm/mach-netlogic/war.h b/arch/mips/include/asm/mach-netlogic/war.h
deleted file mode 100644
index 2c72168..0000000
--- a/arch/mips/include/asm/mach-netlogic/war.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2011 Netlogic Microsystems.
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_NLM_WAR_H
-#define __ASM_MIPS_MACH_NLM_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_NLM_WAR_H */
diff --git a/arch/mips/include/asm/mach-paravirt/war.h b/arch/mips/include/asm/mach-paravirt/war.h
deleted file mode 100644
index 36d3afb..0000000
--- a/arch/mips/include/asm/mach-paravirt/war.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- * Copyright (C) 2013 Cavium Networks <support@caviumnetworks.com>
- */
-#ifndef __ASM_MIPS_MACH_PARAVIRT_WAR_H
-#define __ASM_MIPS_MACH_PARAVIRT_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_PARAVIRT_WAR_H */
diff --git a/arch/mips/include/asm/mach-pnx833x/war.h b/arch/mips/include/asm/mach-pnx833x/war.h
deleted file mode 100644
index e410df4..0000000
--- a/arch/mips/include/asm/mach-pnx833x/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_PNX833X_WAR_H
-#define __ASM_MIPS_MACH_PNX833X_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_PNX833X_WAR_H */
diff --git a/arch/mips/include/asm/mach-ralink/war.h b/arch/mips/include/asm/mach-ralink/war.h
deleted file mode 100644
index c074b5d..0000000
--- a/arch/mips/include/asm/mach-ralink/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MACH_RALINK_WAR_H
-#define __ASM_MACH_RALINK_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MACH_RALINK_WAR_H */
diff --git a/arch/mips/include/asm/mach-tx39xx/war.h b/arch/mips/include/asm/mach-tx39xx/war.h
deleted file mode 100644
index 6a52e65..0000000
--- a/arch/mips/include/asm/mach-tx39xx/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_TX39XX_WAR_H
-#define __ASM_MIPS_MACH_TX39XX_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_TX39XX_WAR_H */
diff --git a/arch/mips/include/asm/mach-vr41xx/war.h b/arch/mips/include/asm/mach-vr41xx/war.h
deleted file mode 100644
index ffe31e7..0000000
--- a/arch/mips/include/asm/mach-vr41xx/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_VR41XX_WAR_H
-#define __ASM_MIPS_MACH_VR41XX_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_VR41XX_WAR_H */
-- 
2.2.0.rc0.207.ga3a616c
