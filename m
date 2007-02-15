Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 13:05:46 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.224]:56463 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038467AbXBONFl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 13:05:41 +0000
Received: by hu-out-0506.google.com with SMTP id 27so233367hub
        for <linux-mips@linux-mips.org>; Thu, 15 Feb 2007 05:05:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=tWoEPalvw6JaXT0LHV+Tz8gQ8qN98UenVrJiTEmrYfnE+n8BBGt6y35EybP5MmS7omCt1aATH/RYJ6u+QrVSNiT+Onjf2kpxhyUSt38FTGuKlQVrTECZz3fvT4flK9Yr71lgCYFR4Bkht+PZ1qPSkTGlTm7ogp7I06qNXdeLJ7s=
Received: by 10.48.210.20 with SMTP id i20mr1352954nfg.1171544708816;
        Thu, 15 Feb 2007 05:05:08 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id p45sm10464473nfa.2007.02.15.05.05.07;
        Thu, 15 Feb 2007 05:05:07 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id EE68A23F76F; Thu, 15 Feb 2007 14:04:20 +0100 (CET)
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
Date:	Thu, 15 Feb 2007 14:04:19 +0100
Message-Id: <1171544660166-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11715446603241-git-send-email-fbuihuu@gmail.com>
References: <11715446603241-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

We do not rely on user anymore to setup this config correctly.
Instead we make our choice depending on the load address.

If we want to force Kbuild to use ELF64 format whatever
the load address we can still do:

        $ make BUILD_ELF32=no

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Kconfig  |   15 ---------------
 arch/mips/Makefile |   23 ++++++++++++++++++++---
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9ccaddc..21812da 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2014,21 +2014,6 @@ source "fs/Kconfig.binfmt"
 config TRAD_SIGNALS
 	bool
 
-config BUILD_ELF64
-	bool "Use 64-bit ELF format for building"
-	depends on 64BIT
-	help
-	  A 64-bit kernel is usually built using the 64-bit ELF binary object
-	  format as it's one that allows arbitrary 64-bit constructs.  For
-	  kernels that are loaded within the KSEG compatibility segments the
-	  32-bit ELF format can optionally be used resulting in a somewhat
-	  smaller binary, but this option is not explicitly supported by the
-	  toolchain and since binutils 2.14 it does not even work at all.
-
-	  Say Y to use the 64-bit format or N to use the 32-bit one.
-
-	  If unsure say Y.
-
 config BINFMT_IRIX
 	bool "Include IRIX binary compatibility"
 	depends on CPU_BIG_ENDIAN && 32BIT && BROKEN
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4240ca1..2e9ae19 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -60,9 +60,6 @@ vmlinux-32		= vmlinux.32
 vmlinux-64		= vmlinux
 
 cflags-y		+= -mabi=64
-ifndef CONFIG_BUILD_ELF64
-cflags-y		+= $(call cc-option,-msym32)
-endif
 endif
 
 
@@ -614,6 +611,26 @@ else
 JIFFIES			= jiffies_64
 endif
 
+#
+# Automatically detect the build format. By default we choose
+# the elf format according to the load address.
+# We can always force a build with a 64-bits symbol format by
+# passing 'BUILD_ELF32=no' option to the make's command line.
+#
+ifdef CONFIG_64BIT
+  ifndef BUILD_ELF32
+    ifeq ($(shell expr $(load-y) \< 0xffffffff80000000), 0)
+      BUILD_ELF32 = y
+    endif
+  endif
+
+  ifeq ($(BUILD_ELF32), y)
+    cflags-y += -msym32
+  else
+    cflags-y += -DCONFIG_BUILD_ELF64
+  endif
+endif
+
 AFLAGS		+= $(cflags-y)
 CFLAGS		+= $(cflags-y)
 
-- 
1.4.4.3.ge6d4
