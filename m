Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 17:23:34 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45419 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492486Ab0FAPX3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 17:23:29 +0200
Received: by fxm15 with SMTP id 15so3848868fxm.36
        for <linux-mips@linux-mips.org>; Tue, 01 Jun 2010 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=thkr8vKBxcqz3CYIZl/7GAUvD98nF6Cf19Q7/hX00sM=;
        b=Gy5v/f3dMwTFH2D8lDUNfqvAFExOwSjQ9BoeG8JoCHNWTtJHQodlsJYoGSjd387p0T
         h8TRV3uQbu++5bafxjoJaMbqYmMn9xOSLiJAhWfXkPfBV3SSsKRaWfzMyUNKrHcsQAFj
         EydcLmGS5d4Ju8ZwoNvCG65m//yFUi5dkMdM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DuOnGaAr82kM/dqNwiWaNGj1JS6yuv+7YXr9iaYbkRt1dV186dNzsGvDA4K67QJnTc
         ddrOLfC81K1Rw9V39+Zbsb4vB1dVJaGR2t616HVa1NdK6Xs0JVVpn4JH57plPbWizHic
         qNiJ00IHAM3XI3bglq5/J7eomMI/tSYJMUa/w=
Received: by 10.223.10.11 with SMTP id n11mr7276256fan.3.1275405803860;
        Tue, 01 Jun 2010 08:23:23 -0700 (PDT)
Received: from localhost.localdomain (p5496CC84.dip.t-dialin.net [84.150.204.132])
        by mx.google.com with ESMTPS id g10sm47570505fai.12.2010.06.01.08.23.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 08:23:22 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH -queue v2] MIPS: Move Alchemy Makefile parts to their own Platform file.
Date:   Tue,  1 Jun 2010 17:23:15 +0200
Message-Id: <1275405795-9009-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 26967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 459

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
On top of latest mips-queue.  The changes to the mtx1/xx1500 Makefiles were
necessary to work around vmlinux link failures.

 arch/mips/Kbuild.platforms         |    1 +
 arch/mips/Makefile                 |  105 ----------------------------------
 arch/mips/alchemy/Platform         |  109 ++++++++++++++++++++++++++++++++++++
 arch/mips/alchemy/mtx-1/Makefile   |    3 +-
 arch/mips/alchemy/xxs1500/Makefile |    2 +-
 5 files changed, 112 insertions(+), 108 deletions(-)
 create mode 100644 arch/mips/alchemy/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 9784c49..dc2bac5 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -1,5 +1,6 @@
 # All platforms listed in alphabetic order
 
+platforms += alchemy
 platforms += ar7
 platforms += loongson
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 14b755d..b191730 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -199,111 +199,6 @@ cflags-$(CONFIG_MACH_JAZZ)	+= -I$(srctree)/arch/mips/include/asm/mach-jazz
 load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
 
 #
-# Common Alchemy Au1x00 stuff
-#
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
-
-#
 # Cobalt Server
 #
 core-$(CONFIG_MIPS_COBALT)	+= arch/mips/cobalt/
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
new file mode 100644
index 0000000..495cc9a
--- /dev/null
+++ b/arch/mips/alchemy/Platform
@@ -0,0 +1,109 @@
+#
+# Core Alchemy code
+#
+platform-$(CONFIG_MACH_ALCHEMY)	+= alchemy/common/
+
+
+#
+# AMD Alchemy Pb1000 eval board
+#
+platform-$(CONFIG_MIPS_PB1000)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1000)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1100 eval board
+#
+platform-$(CONFIG_MIPS_PB1100)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1100)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1500 eval board
+#
+platform-$(CONFIG_MIPS_PB1500)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1500)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1550 eval board
+#
+platform-$(CONFIG_MIPS_PB1550)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Pb1200 eval board
+#
+platform-$(CONFIG_MIPS_PB1200)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_PB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
+load-$(CONFIG_MIPS_PB1200)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1000 eval board
+#
+platform-$(CONFIG_MIPS_DB1000)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1000)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1100 eval board
+#
+platform-$(CONFIG_MIPS_DB1100)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1100)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1500 eval board
+#
+platform-$(CONFIG_MIPS_DB1500)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1500)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1550 eval board
+#
+platform-$(CONFIG_MIPS_DB1550)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1550)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Db1200 eval board
+#
+platform-$(CONFIG_MIPS_DB1200)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
+
+#
+# AMD Alchemy Bosporus eval board
+#
+platform-$(CONFIG_MIPS_BOSPORUS) += alchemy/devboards/
+cflags-$(CONFIG_MIPS_BOSPORUS)	 += -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_BOSPORUS)	 += 0xffffffff80100000
+
+#
+# AMD Alchemy Mirage eval board
+#
+platform-$(CONFIG_MIPS_MIRAGE)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_MIRAGE)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_MIRAGE)	+= 0xffffffff80100000
+
+#
+# 4G-Systems eval board
+#
+platform-$(CONFIG_MIPS_MTX1)	+= alchemy/mtx-1/
+load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
+
+#
+# MyCable eval board
+#
+platform-$(CONFIG_MIPS_XXS1500)	+= alchemy/xxs1500/
+load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
+
+
+# boards can specify their own <gpio.h> in one of their include dirs.
+# If they do, placing this line here at the end will make sure the
+# compiler picks the board one.  If they don't, it will make sure
+# the alchemy generic gpio header is picked up.
+
+cflags-$(CONFIG_MACH_ALCHEMY)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
index 4a53815..4d1367e 100644
--- a/arch/mips/alchemy/mtx-1/Makefile
+++ b/arch/mips/alchemy/mtx-1/Makefile
@@ -6,7 +6,6 @@
 # Makefile for 4G Systems MTX-1 board.
 #
 
-lib-y := init.o board_setup.o
-obj-y := platform.o
+obj-y := init.o board_setup.o platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index 4dc81d7..346bdb0 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -5,6 +5,6 @@
 # Makefile for MyCable XXS1500 board.
 #
 
-lib-y := init.o board_setup.o platform.o
+obj-y := init.o board_setup.o platform.o
 
 EXTRA_CFLAGS += -Werror
-- 
1.7.1
