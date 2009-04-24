Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 06:41:42 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:8636 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023422AbZDXFl3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 06:41:29 +0100
Received: (qmail 7141 invoked by uid 1000); 24 Apr 2009 07:41:28 +0200
Date:	Fri, 24 Apr 2009 07:41:28 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [RFC PATCH] MIPS: move out Alchemy stuff to separate Makefile
Message-ID: <20090424054128.GA7093@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Move Makefile information on all Alchemy boards to a separate file
in the arch subdir.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
Applies on top of my Alchemy-gpio patches;  builds and runs fine on a few
different alchemy systems.  It seems nicer to not have to modify the main
mips makefile when adding new alchemy boards. What do you all think?

 arch/mips/Makefile         |  104 +------------------------------------------
 arch/mips/alchemy/Makefile |  106 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 102 deletions(-)
 create mode 100644 arch/mips/alchemy/Makefile

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 676f8d4..91740f2 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -180,109 +180,9 @@ cflags-$(CONFIG_MACH_JAZZ)	+= -I$(srctree)/arch/mips/include/asm/mach-jazz
 load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
 
 #
-# Common Alchemy Au1x00 stuff
+# Alchemy-based systems
 #
-core-$(CONFIG_SOC_AU1X00)	+= arch/mips/alchemy/common/
-
-#
-# AMD Alchemy Pb1000 eval board
-#
-core-$(CONFIG_MIPS_PB1000)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
-load-$(CONFIG_MIPS_PB1000)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Pb1100 eval board
-#
-core-$(CONFIG_MIPS_PB1100)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
-load-$(CONFIG_MIPS_PB1100)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Pb1500 eval board
-#
-core-$(CONFIG_MIPS_PB1500)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
-load-$(CONFIG_MIPS_PB1500)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Pb1550 eval board
-#
-core-$(CONFIG_MIPS_PB1550)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
-load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Pb1200 eval board
-#
-core-$(CONFIG_MIPS_PB1200)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
-load-$(CONFIG_MIPS_PB1200)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Db1000 eval board
-#
-core-$(CONFIG_MIPS_DB1000)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1000)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Db1100 eval board
-#
-core-$(CONFIG_MIPS_DB1100)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1100)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Db1500 eval board
-#
-core-$(CONFIG_MIPS_DB1500)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1500)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Db1550 eval board
-#
-core-$(CONFIG_MIPS_DB1550)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1550)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Db1200 eval board
-#
-core-$(CONFIG_MIPS_DB1200)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Bosporus eval board
-#
-core-$(CONFIG_MIPS_BOSPORUS)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_BOSPORUS)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_BOSPORUS)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Mirage eval board
-#
-core-$(CONFIG_MIPS_MIRAGE)	+= arch/mips/alchemy/devboards/
-cflags-$(CONFIG_MIPS_MIRAGE)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_MIRAGE)	+= 0xffffffff80100000
-
-#
-# 4G-Systems eval board
-#
-libs-$(CONFIG_MIPS_MTX1)	+= arch/mips/alchemy/mtx-1/
-load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
-
-#
-# MyCable eval board
-#
-libs-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
-load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
-
-# must be last for Alchemy systems for GPIO to work properly
-cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
-
+include $(srctree)/arch/mips/alchemy/Makefile
 
 #
 # Cobalt Server
diff --git a/arch/mips/alchemy/Makefile b/arch/mips/alchemy/Makefile
new file mode 100644
index 0000000..19c79fa
--- /dev/null
+++ b/arch/mips/alchemy/Makefile
@@ -0,0 +1,106 @@
+#
+# Common Alchemy Au1x00 stuff
+#
+# NOTE: this file is included by the MIPS Makefile!
+#
+
+core-$(CONFIG_SOC_AU1X00)	+= arch/mips/alchemy/common/
+
+#
+# AMD Alchemy Pb1000 eval board
+#
+core-$(CONFIG_MIPS_PB1000)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1000)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1100 eval board
+#
+core-$(CONFIG_MIPS_PB1100)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1100)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1500 eval board
+#
+core-$(CONFIG_MIPS_PB1500)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1500)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1550 eval board
+#
+core-$(CONFIG_MIPS_PB1550)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1200 eval board
+#
+core-$(CONFIG_MIPS_PB1200)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1200)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1000 eval board
+#
+core-$(CONFIG_MIPS_DB1000)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1000)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1100 eval board
+#
+core-$(CONFIG_MIPS_DB1100)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1100)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1500 eval board
+#
+core-$(CONFIG_MIPS_DB1500)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1500)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1550 eval board
+#
+core-$(CONFIG_MIPS_DB1550)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1550)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1200 eval board
+#
+core-$(CONFIG_MIPS_DB1200)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Bosporus eval board
+#
+core-$(CONFIG_MIPS_BOSPORUS)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_BOSPORUS)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_BOSPORUS)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Mirage eval board
+#
+core-$(CONFIG_MIPS_MIRAGE)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_MIRAGE)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_MIRAGE)	+= 0xffffffff80100000
+
+#
+# 4G-Systems eval board
+#
+core-$(CONFIG_MIPS_MTX1)	+= arch/mips/alchemy/mtx-1/
+load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
+
+#
+# MyCable eval board
+#
+core-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
+load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
+
+# must be last in case board has provided alternative gpio.h header
+cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
-- 
1.6.2.3
