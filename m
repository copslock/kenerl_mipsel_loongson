Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 17:48:09 +0100 (BST)
Received: from fed1rmmtao08.cox.net ([IPv6:::ffff:68.230.241.31]:222 "EHLO
	fed1rmmtao08.cox.net") by linux-mips.org with ESMTP
	id <S8225228AbUJTQsD>; Wed, 20 Oct 2004 17:48:03 +0100
Received: from opus ([68.107.143.141]) by fed1rmmtao08.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041020164744.VJFA15947.fed1rmmtao08.cox.net@opus>
          for <linux-mips@linux-mips.org>; Wed, 20 Oct 2004 12:47:44 -0400
Date: Wed, 20 Oct 2004 09:47:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-mips@linux-mips.org
Subject: [PATCH] Fix building with O=
Message-ID: <20041020164739.GF12544@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

When building with O=, -Iinclude/asm-mips/mach-generic catches
$(O)/include/asm-mips/ which isn't what we want.  Similarly, we don't
want $(O)/include/asm/gcc but $(srctree)/include/asm-mips/gcc.  Finally,
we want to explicitly look into $(srctree)/include/asm-mips/mach-generic
when processing vmlinux.lds

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.9.orig/arch/mips/Makefile
+++ linux-2.6.9/arch/mips/Makefile
@@ -72,7 +72,7 @@ endif
 # machines may also.  Since BFD is incredibly buggy with respect to
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
-cflags-y			+= -I $(TOPDIR)/include/asm/gcc
+cflags-y			+= -I $(srctree)/include/asm-mips/gcc
 cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
 cflags-y			+= $(call cc-option, -finline-limit=100000)
 LDFLAGS_vmlinux			+= -G 0 -static -n
@@ -632,7 +632,7 @@ core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/common/
 load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0xffffffff80020000
 
-cflags-y			+= -Iinclude/asm-mips/mach-generic
+cflags-y			+= -I $(srctree)/include/asm-mips/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
 ifdef CONFIG_MIPS32
@@ -669,7 +669,8 @@ OBJCOPYFLAGS		+= --remove-section=.regin
 CPPFLAGS_vmlinux.lds := \
 	-D"LOADADDR=$(load-y)" \
 	-D"JIFFIES=$(JIFFIES)" \
-	-imacros $(srctree)/include/asm-$(ARCH)/sn/mapped_kernel.h
+	-imacros $(srctree)/include/asm-$(ARCH)/sn/mapped_kernel.h \
+	-I $(srctree)/include/asm-mips/mach-generic
 
 head-y := arch/mips/kernel/head.o arch/mips/kernel/init_task.o

-- 
Tom Rini
http://gate.crashing.org/~trini/
