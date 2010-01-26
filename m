Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 16:09:03 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:41586 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493325Ab0AZPI7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 16:08:59 +0100
Received: by pwj1 with SMTP id 1so3086570pwj.24
        for <multiple recipients>; Tue, 26 Jan 2010 07:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=urSRdmRai+9EDyhaO1vN3JkkHoeySnwc+aesmVAajrQ=;
        b=G7+jim+VuxgDMBp3vzZfWClddtXQtPxBamSt+WuS5zIBrFBF4v+vPACovEitiPe5W9
         7omUVLEwr+AQpcM1a7wG2kkNMhDBGRxp/Cl/rrdJ03TLqHpZdZh1RdAEVqyOqwj63vx9
         daSVIP3MhO0iZneGdfIVA9iwYpueeIEs7IoWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RzR68Q+QC/iM2K64eVx+U11U40tgQYYf6dOPS4XDIIG8HIVnM+nAcx3QXHtq0ZRQOJ
         vUo6A8L8LlnaJQUksXKhq8PwnRLZwS0IUNIWlfHGxnHOyFmshChBRWphR9sDsGW9pQkS
         dLEy6xhS5Sl1R1I2RQZdsYzpyCoqDqZ+q/WZE=
Received: by 10.115.103.22 with SMTP id f22mr2653572wam.68.1264518531650;
        Tue, 26 Jan 2010 07:08:51 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm5859243pzk.2.2010.01.26.07.08.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:08:51 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue v2] MIPS: Cleanup the debugging of compressed kernel support
Date:   Tue, 26 Jan 2010 23:02:33 +0800
Message-Id: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16746

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from v1 (feedbacks from Ralf):

  o make DEBUG_ZBOOT also depend on DEBUG_KERNEL

  o DEBUG_ZBOOT already depends on SYS_SUPPORTS_ZBOOT_UART16550 so simplify the
  obj-$(CONFIG_DEBUG_ZBOOT_UART16550) into just obj-$(CONFIG_DEBUG_ZBOOT) and
  no ifdef.

This patch adds a new DEBUG_ZBOOT option to allow the developers to
debug the compressed kernel support for a new board.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig.debug            |   18 ++++++++++++++++++
 arch/mips/boot/compressed/Makefile |    2 +-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index d2b88a0..5e556f7 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -102,4 +102,22 @@ config RUNTIME_DEBUG
 	  arch/mips/include/asm/debug.h for debugging macros.
 	  If unsure, say N.
 
+config DEBUG_ZBOOT
+	bool "Enable compressed kernel support debugging"
+	depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT_UART16550
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
index 91a57a6..432b939 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -32,7 +32,7 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 
 obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
-obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+obj-$(CONFIG_SYS_SUPPORTS_ZBOOT) += $(obj)/uart-16550.o
 
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
 $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
-- 
1.6.6
