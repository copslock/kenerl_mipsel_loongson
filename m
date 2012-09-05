Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 22:29:59 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:56499 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903410Ab2IEU2P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 22:28:15 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1T9MCn-0004QI-29; Wed, 05 Sep 2012 15:28:09 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 4/4] MIPS: Remove kernel_uses_smartmips_rixi macro definition.
Date:   Wed,  5 Sep 2012 15:27:58 -0500
Message-Id: <1346876878-25965-5-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346876878-25965-1-git-send-email-sjhill@mips.com>
References: <1346876878-25965-1-git-send-email-sjhill@mips.com>
X-archive-position: 34422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Remove the 'kernel_uses_smartmips_rixi' macro definitions from
the architecture header files.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu-features.h               |    3 ---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    2 --
 2 files changed, 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index c78a77b..7452d78 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -95,9 +95,6 @@
 #ifndef cpu_has_smartmips
 #define cpu_has_smartmips      (cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
 #endif
-#ifndef kernel_uses_smartmips_rixi
-#define kernel_uses_smartmips_rixi 0
-#endif
 #ifndef cpu_has_ri
 #define cpu_has_ri		(cpu_data[0].options & MIPS_CPU_RI)
 #endif 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index a58addb..971bdc2 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -58,8 +58,6 @@
 #define cpu_has_veic		0
 #define cpu_hwrena_impl_bits	0xc0000000
 
-#define kernel_uses_smartmips_rixi (cpu_data[0].cputype != CPU_CAVIUM_OCTEON)
-
 #define ARCH_HAS_IRQ_PER_CPU	1
 #define ARCH_HAS_SPINLOCK_PREFETCH 1
 #define spin_lock_prefetch(x) prefetch(x)
-- 
1.7.9.5
