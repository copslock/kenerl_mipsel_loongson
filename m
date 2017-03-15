Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 19:00:10 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:42521 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbdCOSAELyjYr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 19:00:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 423281A4708;
        Wed, 15 Mar 2017 18:59:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from mcs14.domain.local (mcs14.domain.local [192.168.232.214])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 2E68F1A4158;
        Wed, 15 Mar 2017 18:59:58 +0100 (CET)
From:   Petar Jovanovic <petar.jovanovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com,
        petar.jovanovic@imgtec.com,
        Petar Jovanovic <petar.jovanovic@rt-rk.com>
Subject: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1
Date:   Wed, 15 Mar 2017 18:59:11 +0100
Message-Id: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <petar.jovanovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petar.jovanovic@rt-rk.com
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

Define Cavium Octeon as a CPU that has support for mips32r1, mips32r2 and
mips64r1. This will affect show_cpuinfo() that will now correctly expose
mips32r1, mips32r2 and mips64r1 as supported ISAs.

Signed-off-by: Petar Jovanovic <petar.jovanovic@rt-rk.com>
---
 arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index bd8b9bb..a4f7986 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -46,9 +46,9 @@
 #define cpu_has_64bits		1
 #define cpu_has_octeon_cache	1
 #define cpu_has_saa		octeon_has_saa()
-#define cpu_has_mips32r1	0
-#define cpu_has_mips32r2	0
-#define cpu_has_mips64r1	0
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	1
 #define cpu_has_mips64r2	1
 #define cpu_has_dsp		0
 #define cpu_has_dsp2		0
-- 
1.9.1
