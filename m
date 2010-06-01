Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 12:30:21 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:59983 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492455Ab0FAK3c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 12:29:32 +0200
Received: by pwi2 with SMTP id 2so2057117pwi.36
        for <multiple recipients>; Tue, 01 Jun 2010 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DTRM7Z0rUHfTz4mm2pdrcJAfbOb89zG6CKiwcsBUivI=;
        b=GYoZvKHmYVDVB8v/bQQiB4aL8xYiR/Dff9ATa60bI8LYxnjyCaO+dJftD7Nc1T2V/W
         vgIQLR6msznspFvRGe4F9v9sr1h30BvGzOLQxnWfZby6xvO2PzedZ1qUcJMckJfC/akB
         1Ukmr54PMBBI8xNqgPrc4qMaaHCzpoHz1SWs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qJLIu7lY9JB8j9PEsv8AWk6nSU7Ymi5fFASftp/BsTeAwUm4woyS43FcF0eBwnAg7H
         6MVYVwBVrRnwfZ2slagRD6MxqAaefwXF+7sFgFGq1nqinteMb2QLI1qKgbr7iWbvjF2W
         V/UveauXKblvbqEahKmGa2o1EwmqwAqZ+7Ifo=
Received: by 10.142.74.3 with SMTP id w3mr3847482wfa.243.1275388165934;
        Tue, 01 Jun 2010 03:29:25 -0700 (PDT)
Received: from yeeloong ([202.201.14.140])
        by mx.google.com with ESMTPS id s21sm1917785wff.0.2010.06.01.03.29.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 03:29:24 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Move Loongson Makefile parts to their own Platform file
Date:   Tue,  1 Jun 2010 18:29:04 +0800
Message-Id: <1275388144-5998-3-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com>
References: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com>
X-archive-position: 26958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 249

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kbuild.platforms  |    1 +
 arch/mips/Makefile          |   29 -----------------------------
 arch/mips/loongson/Platform |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 29 deletions(-)
 create mode 100644 arch/mips/loongson/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 681b2d4..9784c49 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -1,6 +1,7 @@
 # All platforms listed in alphabetic order
 
 platforms += ar7
+platforms += loongson
 
 # include the platform specific files
 include $(patsubst %, $(srctree)/arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index ff71a54..14b755d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -130,26 +130,6 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
-# only gcc >= 4.4 have the loongson-specific support
-cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2E) += \
-	$(call cc-option,-march=loongson2e,-march=r4600)
-cflags-$(CONFIG_CPU_LOONGSON2F) += \
-	$(call cc-option,-march=loongson2f,-march=r4600)
-# enable the workarounds for loongson2f
-ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
-  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
-    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-nop)
-  else
-    cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-nop
-  endif
-  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-jump,),)
-    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-jump)
-  else
-    cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-jump
-  endif
-endif
-
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
@@ -346,15 +326,6 @@ cflags-$(CONFIG_WR_PPMC)		+= -I$(srctree)/arch/mips/include/asm/mach-wrppmc
 load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
 
 #
-# Loongson family
-#
-core-$(CONFIG_MACH_LOONGSON) += arch/mips/loongson/
-cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson \
-                    -mno-branch-likely
-load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
-load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
-
-#
 # MIPS Malta board
 #
 core-$(CONFIG_MIPS_MALTA)	+= arch/mips/mti-malta/
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
new file mode 100644
index 0000000..29692e5
--- /dev/null
+++ b/arch/mips/loongson/Platform
@@ -0,0 +1,32 @@
+#
+# Loongson Processors' Support
+#
+
+# Only gcc >= 4.4 have Loongson specific support
+cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2E) += \
+	$(call cc-option,-march=loongson2e,-march=r4600)
+cflags-$(CONFIG_CPU_LOONGSON2F) += \
+	$(call cc-option,-march=loongson2f,-march=r4600)
+# Enable the workarounds for Loongson2f
+ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
+  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
+    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-nop)
+  else
+    cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-nop
+  endif
+  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-jump,),)
+    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-jump)
+  else
+    cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-jump
+  endif
+endif
+
+#
+# Loongson Machines' Support
+#
+
+platform-$(CONFIG_MACH_LOONGSON) += loongson/
+cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
+load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
+load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
-- 
1.6.5
