Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 07:42:02 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:46086 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903951Ab1KKGlI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 07:41:08 +0100
Received: (qmail 16043 invoked from network); 11 Nov 2011 06:40:57 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Nov 2011 06:40:57 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 10 Nov 2011 22:40:57 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH V2 3/8] MIPS: BMIPS: Add CFLAGS, Makefile entries for BMIPS
Date:   Thu, 10 Nov 2011 22:30:26 -0800
Message-Id: <f130d5d9c038f61fa3176b971526cd5f@localhost>
In-Reply-To: <5f9666eb295ce196b2a9688afab07dea@localhost>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10044

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
