Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 10:20:38 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9065 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824926Ab3HUITvETNe- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 10:19:51 +0200
Received: (qmail 11627 invoked by uid 89); 21 Aug 2013 08:19:52 -0000
Received: by simscan 1.3.1 ppid: 11570, pid: 11623, t: 0.1039s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO azrael.ibk.sigmapriv.at) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 21 Aug 2013 08:19:51 -0000
From:   Richard Weinberger <richard@nod.at>
To:     linux-arch@vger.kernel.org
Cc:     mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org,
        lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/8] um: Do not use SUBARCH
Date:   Wed, 21 Aug 2013 10:19:26 +0200
Message-Id: <1377073172-3662-3-git-send-email-richard@nod.at>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

From now on UML does no longer depend on SUBARCH and will
never silently change CONFIG_64BIT.

"make defconfig ARCH=um" produces now a .config with is suitable
for your host arch.

"make i386_defconfig ARCH=um" replaces "make defconfig ARCH=um SUBARCH=i386"
"and make x86_64_defconfig ARCH=um" replaces "make defconfig ARCH=um SUBARCH=x86_64"

Finally a "make ARCH=um" will produce an UML as described in your .config and you
don't have to worry about setting the correct SUBARCH.

This patch is based on: https://lkml.org/lkml/2013/7/4/396

Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common |  4 ----
 arch/um/Makefile       | 21 +++++++++++----------
 arch/x86/Makefile.um   |  2 +-
 arch/x86/um/Kconfig    |  6 +++---
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index bceee66..a7ef0b4 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -58,7 +58,3 @@ config GENERIC_BUG
 config HZ
 	int
 	default 100
-
-config SUBARCH
-	string
-	option env="SUBARCH"
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 133f7de..5bc7892 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -8,6 +8,8 @@
 
 ARCH_DIR := arch/um
 OS := $(shell uname -s)
+OS_ARCH := $(shell uname -m)
+
 # We require bash because the vmlinux link and loader script cpp use bash
 # features.
 SHELL := /bin/bash
@@ -20,15 +22,14 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
-HEADER_ARCH 	:= $(SUBARCH)
-
-# Additional ARCH settings for x86
-ifeq ($(SUBARCH),i386)
-        HEADER_ARCH := x86
-endif
-ifeq ($(SUBARCH),x86_64)
-        HEADER_ARCH := x86
-	KBUILD_CFLAGS += -mcmodel=large
+# Currently we support only i386 and x86_64, if you port UML to another arch
+# add another if branch...
+ifeq ($(OS_ARCH),x86_64)
+	HEADER_ARCH := x86
+	KBUILD_DEFCONFIG := x86_64_defconfig
+else
+	HEADER_ARCH := x86
+	KBUILD_DEFCONFIG := i386_defconfig
 endif
 
 HOST_DIR := arch/$(HEADER_ARCH)
@@ -155,4 +156,4 @@ endef
 include/generated/user_constants.h: $(HOST_DIR)/um/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-export SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
+export USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 36b62bc..91d088c 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -40,7 +40,7 @@ else
 
 START := 0x60000000
 
-KBUILD_CFLAGS += -fno-builtin -m64 
+KBUILD_CFLAGS += -fno-builtin -m64 -mcmodel=large
 
 CHECKFLAGS  += -m64 -D__x86_64__
 KBUILD_AFLAGS += -m64
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 14ef8d1..bb6df67 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -1,4 +1,4 @@
-mainmenu "User Mode Linux/$SUBARCH $KERNELVERSION Kernel Configuration"
+mainmenu "User Mode Linux $KERNELVERSION Kernel Configuration"
 
 source "arch/um/Kconfig.common"
 
@@ -15,8 +15,8 @@ config UML_X86
 	select GENERIC_FIND_FIRST_BIT
 
 config 64BIT
-	bool "64-bit kernel" if SUBARCH = "x86"
-	default SUBARCH != "i386"
+	bool "64-bit kernel"
+	default n
 
 config X86_32
 	def_bool !64BIT
-- 
1.8.1.4
