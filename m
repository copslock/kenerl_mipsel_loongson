Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 22:31:29 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:56763 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492512Ab0FAUa7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 22:30:59 +0200
Received: by fxm15 with SMTP id 15so4161007fxm.36
        for <linux-mips@linux-mips.org>; Tue, 01 Jun 2010 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eCtAOpA+Lc9OUkWeQ6sRot77dBNfu9lBLG9Knnwpwrg=;
        b=lNo3+jvA65q3GA2KfVXe0VFyjvc1WofXO15ewXzkDsskSl48SWPGIZ2pmhdnC5DjWt
         8DxZBjSKzwwG7cbKFrz78SyEmgPnoEl1W64v7xD5LcSp5d8XEKW628h3MwgRsG2ddO+d
         9Kfuj0PTU+CUgGllvt37eZJ/uuv3tgDXzq5e8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G0u3pyjE1S/3e74nuUaKzkl6Y9BcvsZS49Fnse80wrMXNiO0XJ4Uw5GTGE4Dbs9PlL
         I6FEZhyC9tkzCX5aQOWDlxwW144qcKCPRXsNPW7yQ3JVQT8SjwDG+FngFuiFkWIAkPDB
         IU90AKm+H25Njjzaew5TJZaxi3gRR7BnTWFGg=
Received: by 10.223.25.208 with SMTP id a16mr7621405fac.79.1275424252815;
        Tue, 01 Jun 2010 13:30:52 -0700 (PDT)
Received: from localhost.localdomain (p5496C36D.dip.t-dialin.net [84.150.195.109])
        by mx.google.com with ESMTPS id 2sm48702233fav.13.2010.06.01.13.30.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 13:30:51 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH -queue v3 2/2] MIPS: Move Alchemy Makefile parts to their own Platform file.
Date:   Tue,  1 Jun 2010 22:30:37 +0200
Message-Id: <1275424237-8120-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275424237-8120-1-git-send-email-manuel.lauss@googlemail.com>
References: <1275424237-8120-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 26976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 705

From: Manuel Lauss <manuel.lauss@gmail.com>

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
On top of mips-queue, build tested.

 arch/mips/Kbuild.platforms           |    1 +
 arch/mips/Makefile                   |  105 --------------------------------
 arch/mips/alchemy/Platform           |  109 ++++++++++++++++++++++++++++++++++
 arch/mips/alchemy/common/Makefile    |    2 -
 arch/mips/alchemy/devboards/Makefile |    2 -
 arch/mips/alchemy/mtx-1/Makefile     |    2 -
 arch/mips/alchemy/xxs1500/Makefile   |    2 -
 7 files changed, 110 insertions(+), 113 deletions(-)
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
index 8282152..b191730 100644
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
-core-$(CONFIG_MIPS_MTX1)	+= arch/mips/alchemy/mtx-1/
-load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
-
-#
-# MyCable eval board
-#
-core-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
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
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 06c0e65..27811fe 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -18,5 +18,3 @@ ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
 endif
 
 obj-$(CONFIG_PCI)		+= pci.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index ecbd37f..826449c 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -16,5 +16,3 @@ obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
 obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
 obj-$(CONFIG_MIPS_MIRAGE)	+= db1x00/
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
index f912022..81b540c 100644
--- a/arch/mips/alchemy/mtx-1/Makefile
+++ b/arch/mips/alchemy/mtx-1/Makefile
@@ -7,5 +7,3 @@
 #
 
 obj-y += init.o board_setup.o platform.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index 81c516e..91defcf 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -6,5 +6,3 @@
 #
 
 obj-y += init.o board_setup.o platform.o
-
-EXTRA_CFLAGS += -Werror
-- 
1.7.1
