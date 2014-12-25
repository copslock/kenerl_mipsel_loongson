Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 18:58:20 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:43971 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009759AbaLYR5LPthFt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:11 +0100
Received: by mail-pd0-f175.google.com with SMTP id g10so11830520pdj.6;
        Thu, 25 Dec 2014 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dARXBVvsWcPrt1mVuj+YldXfMI52ybqSmeS4+xSBc7k=;
        b=ebgVmyA9Mols4z9IwQN+N/791jxqoH9xfrvMeWMqDpWVoTdrdmiXkl7U27awJ5z1wl
         spJcBCEjx6fUCI0aqsY++m4g5t0GuWzQCgfilYPcfUHNx+4u8M8gVUz1GFdoG7s/5u1y
         xCHaT3PneBkNR1lTRHFb3uy6RbCcvmZV3+TFoc90AE/R1CQGzoJtb78XXmFt5SPd3aSp
         eq2U5RKLzAU/SuutvwFNCh8n5m3raPkGvY4JfLb9A43D9kuF4sw3DKQmyhC8Gf3BbZqP
         AJjI3nMU6/SJpJWaW5vQYzMblshjgMjzOAACr8/f64pYiqI2vtwI8fibkwBBdZNUk8cp
         GV6A==
X-Received: by 10.70.25.98 with SMTP id b2mr21606359pdg.10.1419530225490;
        Thu, 25 Dec 2014 09:57:05 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.03
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:04 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 04/25] MIPS: Create a common <asm/mach-generic/war.h>
Date:   Thu, 25 Dec 2014 09:48:59 -0800
Message-Id: <1419529760-9520-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44914
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
 arch/mips/include/asm/mach-ar7/war.h               | 24 ---------------------
 arch/mips/include/asm/mach-ath25/war.h             | 25 ----------------------
 arch/mips/include/asm/mach-ath79/war.h             | 24 ---------------------
 arch/mips/include/asm/mach-au1x00/war.h            | 24 ---------------------
 arch/mips/include/asm/mach-bcm3384/war.h           | 24 ---------------------
 arch/mips/include/asm/mach-bcm47xx/war.h           | 24 ---------------------
 arch/mips/include/asm/mach-bcm63xx/war.h           | 24 ---------------------
 arch/mips/include/asm/mach-cavium-octeon/war.h     | 25 ----------------------
 arch/mips/include/asm/mach-cobalt/war.h            | 24 ---------------------
 arch/mips/include/asm/mach-dec/war.h               | 24 ---------------------
 arch/mips/include/asm/mach-emma2rh/war.h           | 24 ---------------------
 .../asm/{mach-ralink => mach-generic}/war.h        |  6 +++---
 arch/mips/include/asm/mach-jazz/war.h              | 24 ---------------------
 arch/mips/include/asm/mach-jz4740/war.h            | 24 ---------------------
 arch/mips/include/asm/mach-lantiq/war.h            | 23 --------------------
 arch/mips/include/asm/mach-lasat/war.h             | 24 ---------------------
 arch/mips/include/asm/mach-loongson/war.h          | 24 ---------------------
 arch/mips/include/asm/mach-loongson1/war.h         | 24 ---------------------
 arch/mips/include/asm/mach-netlogic/war.h          | 25 ----------------------
 arch/mips/include/asm/mach-paravirt/war.h          | 25 ----------------------
 arch/mips/include/asm/mach-pnx833x/war.h           | 24 ---------------------
 arch/mips/include/asm/mach-tx39xx/war.h            | 24 ---------------------
 arch/mips/include/asm/mach-vr41xx/war.h            | 24 ---------------------
 23 files changed, 3 insertions(+), 534 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ar7/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath25/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath79/war.h
 delete mode 100644 arch/mips/include/asm/mach-au1x00/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm3384/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm47xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h
 delete mode 100644 arch/mips/include/asm/mach-cobalt/war.h
 delete mode 100644 arch/mips/include/asm/mach-dec/war.h
 delete mode 100644 arch/mips/include/asm/mach-emma2rh/war.h
 rename arch/mips/include/asm/{mach-ralink => mach-generic}/war.h (86%)
 delete mode 100644 arch/mips/include/asm/mach-jazz/war.h
 delete mode 100644 arch/mips/include/asm/mach-jz4740/war.h
 delete mode 100644 arch/mips/include/asm/mach-lantiq/war.h
 delete mode 100644 arch/mips/include/asm/mach-lasat/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson1/war.h
 delete mode 100644 arch/mips/include/asm/mach-netlogic/war.h
 delete mode 100644 arch/mips/include/asm/mach-paravirt/war.h
 delete mode 100644 arch/mips/include/asm/mach-pnx833x/war.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-vr41xx/war.h

diff --git a/arch/mips/include/asm/mach-ar7/war.h b/arch/mips/include/asm/mach-ar7/war.h
deleted file mode 100644
index 99071e5..0000000
diff --git a/arch/mips/include/asm/mach-ath25/war.h b/arch/mips/include/asm/mach-ath25/war.h
deleted file mode 100644
index e3a5250..0000000
diff --git a/arch/mips/include/asm/mach-ath79/war.h b/arch/mips/include/asm/mach-ath79/war.h
deleted file mode 100644
index 0bb3090..0000000
diff --git a/arch/mips/include/asm/mach-au1x00/war.h b/arch/mips/include/asm/mach-au1x00/war.h
deleted file mode 100644
index 72e260d..0000000
diff --git a/arch/mips/include/asm/mach-bcm3384/war.h b/arch/mips/include/asm/mach-bcm3384/war.h
deleted file mode 100644
index 59d7599..0000000
diff --git a/arch/mips/include/asm/mach-bcm47xx/war.h b/arch/mips/include/asm/mach-bcm47xx/war.h
deleted file mode 100644
index a3d2f44..0000000
diff --git a/arch/mips/include/asm/mach-bcm63xx/war.h b/arch/mips/include/asm/mach-bcm63xx/war.h
deleted file mode 100644
index 05ee867..0000000
diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
deleted file mode 100644
index eb72b35..0000000
diff --git a/arch/mips/include/asm/mach-cobalt/war.h b/arch/mips/include/asm/mach-cobalt/war.h
deleted file mode 100644
index 34ae404..0000000
diff --git a/arch/mips/include/asm/mach-dec/war.h b/arch/mips/include/asm/mach-dec/war.h
deleted file mode 100644
index d29996f..0000000
diff --git a/arch/mips/include/asm/mach-emma2rh/war.h b/arch/mips/include/asm/mach-emma2rh/war.h
deleted file mode 100644
index 79ae82d..0000000
diff --git a/arch/mips/include/asm/mach-ralink/war.h b/arch/mips/include/asm/mach-generic/war.h
similarity index 86%
rename from arch/mips/include/asm/mach-ralink/war.h
rename to arch/mips/include/asm/mach-generic/war.h
index c074b5d..a1bc2e7 100644
--- a/arch/mips/include/asm/mach-ralink/war.h
+++ b/arch/mips/include/asm/mach-generic/war.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
  */
-#ifndef __ASM_MACH_RALINK_WAR_H
-#define __ASM_MACH_RALINK_WAR_H
+#ifndef __ASM_MACH_GENERIC_WAR_H
+#define __ASM_MACH_GENERIC_WAR_H
 
 #define R4600_V1_INDEX_ICACHEOP_WAR	0
 #define R4600_V1_HIT_CACHEOP_WAR	0
@@ -21,4 +21,4 @@
 #define R10000_LLSC_WAR			0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
-#endif /* __ASM_MACH_RALINK_WAR_H */
+#endif /* __ASM_MACH_GENERIC_WAR_H */
diff --git a/arch/mips/include/asm/mach-jazz/war.h b/arch/mips/include/asm/mach-jazz/war.h
deleted file mode 100644
index 5b18b9a..0000000
diff --git a/arch/mips/include/asm/mach-jz4740/war.h b/arch/mips/include/asm/mach-jz4740/war.h
deleted file mode 100644
index 9b511d3..0000000
diff --git a/arch/mips/include/asm/mach-lantiq/war.h b/arch/mips/include/asm/mach-lantiq/war.h
deleted file mode 100644
index 358ca97..0000000
diff --git a/arch/mips/include/asm/mach-lasat/war.h b/arch/mips/include/asm/mach-lasat/war.h
deleted file mode 100644
index 741ae72..0000000
diff --git a/arch/mips/include/asm/mach-loongson/war.h b/arch/mips/include/asm/mach-loongson/war.h
deleted file mode 100644
index f2570df..0000000
diff --git a/arch/mips/include/asm/mach-loongson1/war.h b/arch/mips/include/asm/mach-loongson1/war.h
deleted file mode 100644
index 8fb50d0..0000000
diff --git a/arch/mips/include/asm/mach-netlogic/war.h b/arch/mips/include/asm/mach-netlogic/war.h
deleted file mode 100644
index 2c72168..0000000
diff --git a/arch/mips/include/asm/mach-paravirt/war.h b/arch/mips/include/asm/mach-paravirt/war.h
deleted file mode 100644
index 36d3afb..0000000
diff --git a/arch/mips/include/asm/mach-pnx833x/war.h b/arch/mips/include/asm/mach-pnx833x/war.h
deleted file mode 100644
index e410df4..0000000
diff --git a/arch/mips/include/asm/mach-tx39xx/war.h b/arch/mips/include/asm/mach-tx39xx/war.h
deleted file mode 100644
index 6a52e65..0000000
diff --git a/arch/mips/include/asm/mach-vr41xx/war.h b/arch/mips/include/asm/mach-vr41xx/war.h
deleted file mode 100644
index ffe31e7..0000000
-- 
2.1.1
