Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 12:44:33 +0100 (CET)
Received: from conuserg010.nifty.com ([202.248.44.36]:33921 "EHLO
        conuserg010-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007238AbbC0LobWI3mb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2015 12:44:31 +0100
Received: from beagle.diag.org (KD106151093169.au-net.ne.jp [106.151.93.169]) (authenticated)
        by conuserg010-v.nifty.com with ESMTP id t2RBhcvJ024225;
        Fri, 27 Mar 2015 20:43:48 +0900
X-Nifty-SrcIP: [106.151.93.169]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org,
        user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Michal Marek <mmarek@suse.cz>,
        user-mode-linux-user@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 2/4] kbuild: use relative path more to include Makefile
Date:   Fri, 27 Mar 2015 20:43:36 +0900
Message-Id: <1427456618-23830-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
References: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

Prior to this commit, it was impossible to use relative path to
include Makefiles from the top level Makefile because the option
"--include-dir=$(srctree)" becomes effective when Make enters into
sub Makefiles.

To use relative path in any places, this commit moves the option
above the "sub-make" target.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile             | 22 ++++++++++------------
 arch/mips/Makefile   |  2 +-
 arch/um/Makefile     |  6 +++---
 arch/x86/Makefile    |  2 +-
 arch/x86/Makefile.um |  2 +-
 5 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index cc68048..402ff77 100644
--- a/Makefile
+++ b/Makefile
@@ -10,9 +10,10 @@ NAME = Hurr durr I'ma sheep
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
-# Do not use make's built-in rules and variables
-# (this increases performance and avoids hard-to-debug behaviour);
-MAKEFLAGS += -rR
+# o Do not use make's built-in rules and variables
+#   (this increases performance and avoids hard-to-debug behaviour);
+# o Look for make include files relative to root of kernel src
+MAKEFLAGS += -rR --include-dir=$(CURDIR)
 
 # Avoid funny character set dependencies
 unexport LC_ALL
@@ -344,12 +345,9 @@ endif
 export COMPILER
 endif
 
-# Look for make include files relative to root of kernel src
-MAKEFLAGS += --include-dir=$(srctree)
-
 # We need some generic definitions (do not try to remake the file).
-$(srctree)/scripts/Kbuild.include: ;
-include $(srctree)/scripts/Kbuild.include
+scripts/Kbuild.include: ;
+include scripts/Kbuild.include
 
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
@@ -533,7 +531,7 @@ ifeq ($(config-targets),1)
 # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
-include $(srctree)/arch/$(SRCARCH)/Makefile
+include arch/$(SRCARCH)/Makefile
 export KBUILD_DEFCONFIG KBUILD_KCONFIG
 
 config: scripts_basic outputmakefile FORCE
@@ -609,7 +607,7 @@ endif # $(dot-config)
 # Defaults to vmlinux, but the arch makefile usually adds further targets
 all: vmlinux
 
-include $(srctree)/arch/$(SRCARCH)/Makefile
+include arch/$(SRCARCH)/Makefile
 
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 
@@ -781,8 +779,8 @@ ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC)), y)
 	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
 endif
 
-include $(srctree)/scripts/Makefile.kasan
-include $(srctree)/scripts/Makefile.extrawarn
+include scripts/Makefile.kasan
+include scripts/Makefile.extrawarn
 
 # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
 KBUILD_CPPFLAGS += $(KCPPFLAGS)
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8f57fc7..d152dfb 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -225,7 +225,7 @@ endif
 #
 # Board-dependent options and extra files
 #
-include $(srctree)/arch/mips/Kbuild.platforms
+include arch/mips/Kbuild.platforms
 
 ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
diff --git a/arch/um/Makefile b/arch/um/Makefile
index e4b1a96..17d4460 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -43,8 +43,8 @@ endif
 
 HOST_DIR := arch/$(HEADER_ARCH)
 
-include $(srctree)/$(ARCH_DIR)/Makefile-skas
-include $(srctree)/$(HOST_DIR)/Makefile.um
+include $(ARCH_DIR)/Makefile-skas
+include $(HOST_DIR)/Makefile.um
 
 core-y += $(HOST_DIR)/um/
 
@@ -73,7 +73,7 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -D__KERNEL__,,\
 	$(filter -I%,$(CFLAGS)) -D_FILE_OFFSET_BITS=64 -idirafter include
 
 #This will adjust *FLAGS accordingly to the platform.
-include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
+include $(ARCH_DIR)/Makefile-os-$(OS)
 
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
 		   -I$(srctree)/$(HOST_DIR)/include/uapi \
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5ba2d9c..2fda005 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -63,7 +63,7 @@ ifeq ($(CONFIG_X86_32),y)
 				$(call cc-option,-fno-unit-at-a-time))
 
         # CPU-specific tuning. Anything which can be shared with UML should go here.
-        include $(srctree)/arch/x86/Makefile_32.cpu
+        include arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
         # temporary until string.h is fixed
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 95eba55..5b7e898 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -18,7 +18,7 @@ LDS_EXTRA		:= -Ui386
 export LDS_EXTRA
 
 # First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
-include $(srctree)/arch/x86/Makefile_32.cpu
+include arch/x86/Makefile_32.cpu
 
 # prevent gcc from keeping the stack 16 byte aligned. Taken from i386.
 cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
-- 
1.9.1
