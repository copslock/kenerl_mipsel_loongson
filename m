Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:46:11 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:61082 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492263Ab0AaMqH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:46:07 +0100
Received: by pzk41 with SMTP id 41so5445407pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 04:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=w2TuaS2ix81oNYMMQNnhQ09+mejFgjcOiMA5c6FqZBo=;
        b=aa1MY/AW6xV+ajIfkIKE2yJkBjotEndodO/HH8gXk4WQMzKFi724A8ko8t4D9WlTac
         kD7/AdaDAk0oHMeVwgIrcqNdTd4zynNccYzFypWQZfJJ8r03ScQF8oAzr22TFfo/7boP
         7iQVgiwbMzuZqctf9haB1dHqeIgHVTmSaLHV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wPsU8fhE88wL2t+Z5htLDt4ER7s5dKSXT0EWcgEbGbE8SEZMRNPD9YBFLxFDCaGKkt
         te1Pba5HKTcC6jEvVTkaZeNcx35fBhfn6O1xQBtJ30YB64zphCrQNX1S6jQnbStunoCS
         nlgsRrhVco1wMLJOkmCp4muUckDqicg/CFWvM=
Received: by 10.141.2.2 with SMTP id e2mr2195769rvi.274.1264941960712;
        Sun, 31 Jan 2010 04:46:00 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3575766pzk.15.2010.01.31.04.45.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:46:00 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v4] MIPS: Make the debugging of compressed kernel configurable
Date:   Sun, 31 Jan 2010 20:39:40 +0800
Message-Id: <67a1110ea3c3276af659bc669ec87f0976121815.1264941563.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19727

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from v3:

 O Rebased on the latest linux-queue git tree of Ralf.
 O Make the option is disabled by default.
 O Fix the missing CONFIG_ prefix of DEBUG_ZBOOT in Makefile
 (reported by "Manuel Lauss")

This patch adds a new DEBUG_ZBOOT option to allow the users to enable it
to debug the compressed kernel support for a new board and this optoin
should be disabled to reduce the kernel image size and speed up the
kernel booting procedure when the compressed kernel support is stable.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig.debug            |   19 +++++++++++++++++++
 arch/mips/boot/compressed/Makefile |    2 ++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index d2b88a0..32a010d 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -102,4 +102,23 @@ config RUNTIME_DEBUG
 	  arch/mips/include/asm/debug.h for debugging macros.
 	  If unsure, say N.
 
+config DEBUG_ZBOOT
+	bool "Enable compressed kernel support debugging"
+	depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT
+	default n
+	help
+	  If you want to add compressed kernel support to a new board, and the
+	  board supports uart16550 compatible serial port, please select
+	  SYS_SUPPORTS_ZBOOT_UART16550 for your board and enable this option to
+	  debug it.
+
+	  If your board doesn't support uart16550 compatible serial port, you
+	  can try to select SYS_SUPPORTS_ZBOOT and use the other methods to
+	  debug it. for example, add a new serial port support just as
+	  arch/mips/boot/compressed/uart-16550.c does.
+
+	  After the compressed kernel support works, please disable this option
+	  to reduce the kernel image size and speed up the booting procedure a
+	  little.
+
 endmenu
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 76d6930..790ddd3 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -35,8 +35,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 
 obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
+ifdef CONFIG_DEBUG_ZBOOT
 obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 obj-$(CONFIG_MACH_ALCHEMY)		   += $(obj)/uart-alchemy.o
+endif
 
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
 $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
-- 
1.6.6
