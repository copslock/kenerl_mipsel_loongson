Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 21:08:18 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:63971 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab0EaTIN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 21:08:13 +0200
Received: by fxm15 with SMTP id 15so3114520fxm.36
        for <linux-mips@linux-mips.org>; Mon, 31 May 2010 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=i8kUdhX0fb+MncOrjTqBnwiFHXyIMtfOu3xvc6UNeMc=;
        b=h/xXXBcQ/Q2keAz993oh4k27wCy1kqJxbyyguSPCHdYdFuWCMN2NWyyare5H5l41x9
         loJPU6YbW8CXWIdPju9rcXMFm7X56vOHlripkh3yFbSXhMlFhDFul8PlzVXOtob7DCZ4
         5C5LJIyxheZNF0zhOhdleFshffjv0DSBXPeK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RabcxNEE8H7YQvxnQlJ1O4v20Enr0TkpwH0Y+RTa6IYPZMU9ZGWgtFjzw+5XlN98h/
         oSaRm2ZfVWXbfSLaWp6MWpuaKoOpxSm2TH8wFfvDhwMi/QMcqgwiuAn6YCoMTTaics8B
         4eGIGCEci9Qg+9Jg6rQjzd74dpnSJL2QjKyes=
Received: by 10.223.5.81 with SMTP id 17mr5957333fau.42.1275332887573;
        Mon, 31 May 2010 12:08:07 -0700 (PDT)
Received: from localhost.localdomain (p5496CC84.dip.t-dialin.net [84.150.204.132])
        by mx.google.com with ESMTPS id u12sm42674155fah.4.2010.05.31.12.08.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 12:08:06 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH -queue] MIPS: Move Alchemy Makefile parts to their own Platform file.
Date:   Mon, 31 May 2010 21:07:58 +0200
Message-Id: <1275332878-19762-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Applies on top of Sam's MIPS Kbuild patches in mips-queue.
Build-tested only.

 arch/mips/Kbuild.platforms |    2 +-
 arch/mips/Makefile         |  105 --------------------------------------------
 arch/mips/alchemy/Platform |  103 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 106 deletions(-)
 create mode 100644 arch/mips/alchemy/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 681b2d4..18eff23 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -1,6 +1,6 @@
 # All platforms listed in alphabetic order
 
-platforms += ar7
+platforms += alchemy ar7
 
 # include the platform specific files
 include $(patsubst %, $(srctree)/arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index ff71a54..b75b72b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -219,111 +219,6 @@ cflags-$(CONFIG_MACH_JAZZ)	+= -I$(srctree)/arch/mips/include/asm/mach-jazz
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
index 0000000..1994fdc
--- /dev/null
+++ b/arch/mips/alchemy/Platform
@@ -0,0 +1,103 @@
+#
+# Common Alchemy Au1x00 stuff
+#
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
+libs-$(CONFIG_MIPS_MTX1)	+= arch/mips/alchemy/mtx-1/
+load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
+
+#
+# MyCable eval board
+#
+libs-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
+load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
+
+# must be last for Alchemy systems for GPIO to work properly
+cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
-- 
1.7.1
