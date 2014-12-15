Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:09:08 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41760 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008840AbaLOSGzWYpxz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:55 +0100
Received: by mail-lb0-f174.google.com with SMTP id 10so9568927lbg.19
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5wxEjPEb21rwJaQOSDcPUt7E67ApF7tgsH4CdJbIiUc=;
        b=Qpdn/Lzz82A8Jodpkkevb2ZCmgSNwf59UEjz2MEeSRoZ6riO/WWlUtQXquDQOFQJ7v
         hbmPFdMC/CFBJUjA3TVUpYXOVzK+kUeQBJpGAEAgLWsMxiuDOHIP4UqAVhLFjz+F1/hj
         73Auav/wDW9EdLOZpIqBrobzersVUfM1zxI47U1ak5mi/CO49VABhrhKnzmFH0dz1SX6
         NRFVKzXTzZURq+JGOp4vOVz/p/sZWLXJVAOOQl8k8z0YJvefUU7/wTooxGSTrWIyBGUW
         xBQXraiMaG17d2TeQOaaApgQ/pv5wTuCjjFAr0npNHHglums0ABO3rjhU6MujVHb2C/1
         f2GA==
X-Received: by 10.112.234.201 with SMTP id ug9mr31359686lbc.79.1418666810175;
        Mon, 15 Dec 2014 10:06:50 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:49 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 11/14] MIPS: OCTEON: Implement DCache errata workaround for all CN6XXX
Date:   Mon, 15 Dec 2014 21:03:17 +0300
Message-Id: <1418666603-15159-12-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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

Make messages refer to all CN6XXX.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/setup.c                | 7 ++++---
 arch/mips/include/asm/mach-cavium-octeon/war.h | 3 +++
 arch/mips/mm/uasm.c                            | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 8bba56f..c0f0955 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1070,7 +1070,7 @@ EXPORT_SYMBOL(prom_putchar);
 
 void prom_free_prom_memory(void)
 {
-	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X)) {
+	if (CAVIUM_OCTEON_DCACHE_PREFETCH_WAR) {
 		/* Check for presence of Core-14449 fix.  */
 		u32 insn;
 		u32 *foo;
@@ -1092,8 +1092,9 @@ void prom_free_prom_memory(void)
 			panic("No PREF instruction at Core-14449 probe point.");
 
 		if (((insn >> 16) & 0x1f) != 28)
-			panic("Core-14449 WAR not in place (%04x).\n"
-			      "Please build kernel with proper options (CONFIG_CAVIUM_CN63XXP1).", insn);
+			panic("OCTEON II DCache prefetch workaround not in place (%04x).\n"
+			      "Please build kernel with proper options (CONFIG_CAVIUM_CN63XXP1).",
+			      insn);
 	}
 }
 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
index eb72b35..35c80be 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/war.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/war.h
@@ -22,4 +22,7 @@
 #define R10000_LLSC_WAR			0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
+#define CAVIUM_OCTEON_DCACHE_PREFETCH_WAR	\
+	OCTEON_IS_MODEL(OCTEON_CN6XXX)
+
 #endif /* __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H */
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index a01b0d6..3b87612 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -328,7 +328,7 @@ I_u3u1u2(_ldx)
 void ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
 			    unsigned int c)
 {
-	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X) && a <= 24 && a != 5)
+	if (CAVIUM_OCTEON_DCACHE_PREFETCH_WAR && a <= 24 && a != 5)
 		/*
 		 * As per erratum Core-14449, replace prefetches 0-4,
 		 * 6-24 with 'pref 28'.
-- 
2.1.3
