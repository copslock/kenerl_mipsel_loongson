Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 10:22:04 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9078 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822344Ab3HUIUAyBH2U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 10:20:00 +0200
Received: (qmail 11784 invoked by uid 89); 21 Aug 2013 08:19:58 -0000
Received: by simscan 1.3.1 ppid: 11570, pid: 11781, t: 0.1418s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO azrael.ibk.sigmapriv.at) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 21 Aug 2013 08:19:58 -0000
From:   Richard Weinberger <richard@nod.at>
To:     linux-arch@vger.kernel.org
Cc:     mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org,
        lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 8/8] Makefile: Remove SUBARCH
Date:   Wed, 21 Aug 2013 10:19:32 +0200
Message-Id: <1377073172-3662-9-git-send-email-richard@nod.at>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37614
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

As all users of SUBARCH have been removed we can finally get
rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 Makefile         | 15 +++------------
 arch/um/Makefile |  2 +-
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index a5a55f4..48bd8fe 100644
--- a/Makefile
+++ b/Makefile
@@ -159,13 +159,7 @@ VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
 export srctree objtree VPATH
 
 
-# SUBARCH tells the usermode build what the underlying arch is.  That is set
-# first, and if a usermode build is happening, the "ARCH=um" on the command
-# line overrides the setting of ARCH below.  If a native build is happening,
-# then ARCH is assigned, getting whatever value it gets normally, and 
-# SUBARCH is subsequently ignored.
-
-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+ARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 				  -e s/sun4u/sparc64/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
@@ -192,7 +186,6 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 # "make" in the configured kernel build directory always uses that.
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
-ARCH		?= $(SUBARCH)
 CROSS_COMPILE	?= $(CONFIG_CROSS_COMPILE:"%"=%)
 
 # Architecture as present in compile.h
@@ -1314,11 +1307,9 @@ endif #ifeq ($(mixed-targets),1)
 PHONY += checkstack kernelrelease kernelversion image_name
 
 # UML needs a little special treatment here.  It wants to use the host
-# toolchain, so needs $(SUBARCH) passed to checkstack.pl.  Everyone
-# else wants $(ARCH), including people doing cross-builds, which means
-# that $(SUBARCH) doesn't work here.
+# toolchain, so needs $(OS_ARCH) passed to checkstack.pl.
 ifeq ($(ARCH), um)
-CHECKSTACK_ARCH := $(SUBARCH)
+CHECKSTACK_ARCH := $(OS_ARCH)
 else
 CHECKSTACK_ARCH := $(ARCH)
 endif
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 5bc7892..c1b6a9b 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -156,4 +156,4 @@ endef
 include/generated/user_constants.h: $(HOST_DIR)/um/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-export USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
+export USER_CFLAGS CFLAGS_NO_HARDENING OS OS_ARCH DEV_NULL_PATH
-- 
1.8.1.4
