Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:36:35 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36185 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007479AbaK1Ed3iNFtg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:29 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so6065422pab.28
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mc9XjSA6Zv4721HlrVJuofnXjHPTJRQjM7vMmqtRZIU=;
        b=epQLk1KKoHaSRlqDUOUTp3K3tImF0Ln+htT/LbDAJnoHg8xLXlgBHqp5gPeupLVK5L
         U5idFjD5EdRVHI2bROOIT52AihQ6gB9+e2vnBUXN101SlfJvylenCSH/wq65IkOOsnm9
         CzARSEuasfkZ3hmCZLe5F1BikHlyIESTviA/ir60IDpGPAYGjdQzptQwvDyBa8Zkxloa
         6zbFwk2sYjieOlZD43k+Yr1p8ykw7oEw1dEP+WGXzA3//k1g4RIm0/WFElu79I7Y85LN
         oI1azavO7ooL2ODkTIucquBHbCewTQI0jFCx0+d5WX9lJjRqlEhFSKzX7rjYsFzG4nBm
         E2oQ==
X-Received: by 10.68.103.195 with SMTP id fy3mr69690350pbb.84.1417149203877;
        Thu, 27 Nov 2014 20:33:23 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:23 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 12/16] MIPS: Create a common <asm/mach-generic/war.h>
Date:   Thu, 27 Nov 2014 20:32:18 -0800
Message-Id: <1417149142-3756-13-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

11 platforms require at least one of these workarounds to be enabled; 22
platforms do not.  In the latter case we can fall back to a generic version.

Note that this also deletes an orphaned reference to RM9000_CDEX_SMP_WAR.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mach-ar7/war.h           | 24 ------------------------
 arch/mips/include/asm/mach-ath25/war.h         | 25 -------------------------
 arch/mips/include/asm/mach-ath79/war.h         | 24 ------------------------
 arch/mips/include/asm/mach-au1x00/war.h        | 24 ------------------------
 arch/mips/include/asm/mach-bcm47xx/war.h       | 24 ------------------------
 arch/mips/include/asm/mach-bcm63xx/war.h       | 24 ------------------------
 arch/mips/include/asm/mach-cavium-octeon/war.h | 25 -------------------------
 arch/mips/include/asm/mach-cobalt/war.h        | 24 ------------------------
 arch/mips/include/asm/mach-dec/war.h           | 24 ------------------------
 arch/mips/include/asm/mach-emma2rh/war.h       | 24 ------------------------
 arch/mips/include/asm/mach-generic/war.h       | 24 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-jazz/war.h          | 24 ------------------------
 arch/mips/include/asm/mach-jz4740/war.h        | 24 ------------------------
 arch/mips/include/asm/mach-lantiq/war.h        | 23 -----------------------
 arch/mips/include/asm/mach-lasat/war.h         | 24 ------------------------
 arch/mips/include/asm/mach-loongson/war.h      | 24 ------------------------
 arch/mips/include/asm/mach-loongson1/war.h     | 24 ------------------------
 arch/mips/include/asm/mach-netlogic/war.h      | 25 -------------------------
 arch/mips/include/asm/mach-paravirt/war.h      | 25 -------------------------
 arch/mips/include/asm/mach-pnx833x/war.h       | 24 ------------------------
 arch/mips/include/asm/mach-ralink/war.h        | 24 ------------------------
 arch/mips/include/asm/mach-tx39xx/war.h        | 24 ------------------------
 arch/mips/include/asm/mach-vr41xx/war.h        | 24 ------------------------
 23 files changed, 24 insertions(+), 531 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ar7/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath25/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath79/war.h
 delete mode 100644 arch/mips/include/asm/mach-au1x00/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm47xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h
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
index 99071e50faab..000000000000
diff --git a/arch/mips/include/asm/mach-ath25/war.h b/arch/mips/include/asm/mach-ath25/war.h
deleted file mode 100644
index e3a5250ebd67..000000000000
diff --git a/arch/mips/include/asm/mach-ath79/war.h b/arch/mips/include/asm/mach-ath79/war.h
deleted file mode 100644
index 0bb30905fd5b..000000000000
diff --git a/arch/mips/include/asm/mach-au1x00/war.h b/arch/mips/include/asm/mach-au1x00/war.h
deleted file mode 100644
index 72e260d24e59..000000000000
diff --git a/arch/mips/include/asm/mach-bcm47xx/war.h b/arch/mips/include/asm/mach-bcm47xx/war.h
deleted file mode 100644
index a3d2f448b10e..000000000000
diff --git a/arch/mips/include/asm/mach-bcm63xx/war.h b/arch/mips/include/asm/mach-bcm63xx/war.h
deleted file mode 100644
index 05ee8671bef1..000000000000
diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
deleted file mode 100644
index eb72b35cf04b..000000000000
diff --git a/arch/mips/include/asm/mach-cobalt/war.h b/arch/mips/include/asm/mach-cobalt/war.h
deleted file mode 100644
index 34ae4046541e..000000000000
diff --git a/arch/mips/include/asm/mach-dec/war.h b/arch/mips/include/asm/mach-dec/war.h
deleted file mode 100644
index d29996feb3e7..000000000000
diff --git a/arch/mips/include/asm/mach-emma2rh/war.h b/arch/mips/include/asm/mach-emma2rh/war.h
deleted file mode 100644
index 79ae82da3ec7..000000000000
diff --git a/arch/mips/include/asm/mach-generic/war.h b/arch/mips/include/asm/mach-generic/war.h
new file mode 100644
index 000000000000..a1bc2e71f983
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
index 5b18b9a3d0ec..000000000000
diff --git a/arch/mips/include/asm/mach-jz4740/war.h b/arch/mips/include/asm/mach-jz4740/war.h
deleted file mode 100644
index 9b511d323838..000000000000
diff --git a/arch/mips/include/asm/mach-lantiq/war.h b/arch/mips/include/asm/mach-lantiq/war.h
deleted file mode 100644
index 358ca979c1bd..000000000000
diff --git a/arch/mips/include/asm/mach-lasat/war.h b/arch/mips/include/asm/mach-lasat/war.h
deleted file mode 100644
index 741ae724adc6..000000000000
diff --git a/arch/mips/include/asm/mach-loongson/war.h b/arch/mips/include/asm/mach-loongson/war.h
deleted file mode 100644
index f2570df66bb5..000000000000
diff --git a/arch/mips/include/asm/mach-loongson1/war.h b/arch/mips/include/asm/mach-loongson1/war.h
deleted file mode 100644
index 8fb50d008131..000000000000
diff --git a/arch/mips/include/asm/mach-netlogic/war.h b/arch/mips/include/asm/mach-netlogic/war.h
deleted file mode 100644
index 2c7216840e18..000000000000
diff --git a/arch/mips/include/asm/mach-paravirt/war.h b/arch/mips/include/asm/mach-paravirt/war.h
deleted file mode 100644
index 36d3afb98451..000000000000
diff --git a/arch/mips/include/asm/mach-pnx833x/war.h b/arch/mips/include/asm/mach-pnx833x/war.h
deleted file mode 100644
index e410df4e1b3a..000000000000
diff --git a/arch/mips/include/asm/mach-ralink/war.h b/arch/mips/include/asm/mach-ralink/war.h
deleted file mode 100644
index c074b5dc1f82..000000000000
diff --git a/arch/mips/include/asm/mach-tx39xx/war.h b/arch/mips/include/asm/mach-tx39xx/war.h
deleted file mode 100644
index 6a52e6534776..000000000000
diff --git a/arch/mips/include/asm/mach-vr41xx/war.h b/arch/mips/include/asm/mach-vr41xx/war.h
deleted file mode 100644
index ffe31e736009..000000000000
-- 
2.1.0
