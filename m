Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 22:35:14 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:41251 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904174Ab1KEVdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Nov 2011 22:33:39 +0100
Received: (qmail 28074 invoked from network); 5 Nov 2011 17:28:40 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Nov 2011 17:28:40 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 10:28:40 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 5/9] MIPS: BMIPS: Add CFLAGS, Makefile entries for BMIPS
Date:   Sat, 05 Nov 2011 14:21:14 -0700
Message-Id: <b3bb1f25a5a454bcdbef139749f3ac73@localhost>
In-Reply-To: <c2c8833593cb8eeef5c102468e105497@localhost>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4402

Add CONFIG_CPU_BMIPS* in all of the right places, so that BMIPS kernel
images will compile and run.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Makefile              |    1 +
 arch/mips/include/asm/hazards.h |    3 ++-
 arch/mips/include/asm/module.h  |    2 ++
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9b4cb00..ae5cfa7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -157,6 +157,7 @@ ifeq (,$(findstring march=octeon, $(cflags-$(CONFIG_CPU_CAVIUM_OCTEON))))
 cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
 endif
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
+cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 8f630e4..b4c20e4 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -87,7 +87,8 @@ do {									\
 	: "=r" (tmp));							\
 } while (0)
 
-#elif defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MIPS_ALCHEMY)
+#elif (defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MIPS_ALCHEMY)) || \
+	defined(CONFIG_CPU_BMIPS)
 
 /*
  * These are slightly complicated by the fact that we guarantee R1 kernels to
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index bc01a02..c392df2 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -120,6 +120,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "OCTEON "
 #elif defined CONFIG_CPU_XLR
 #define MODULE_PROC_FAMILY "XLR "
+#elif defined CONFIG_CPU_BMIPS
+#define MODULE_PROC_FAMILY "BMIPS "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
-- 
1.7.6.3
