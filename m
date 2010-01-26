Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 18:08:10 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:39423 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493366Ab0AZRIC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 18:08:02 +0100
Received: by ewy23 with SMTP id 23so663837ewy.24
        for <multiple recipients>; Tue, 26 Jan 2010 09:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GDj6l9XkdO3u6WiEk9SYVSxRFMpGfzGY9dpmCFe0obs=;
        b=FMYKSrmtGNjyaFmPR1RPY9u4zfBwryZr5NLRjrKcQFBNHwomusi46SN0OQ/3ihFUA5
         +XITcgd+rvnrAQB3vPtQFCNpt7anIFjPC/RB9Xy4oOVQ82gcB/QxbCYNaztF+TSJEoaM
         QNBqi+rSmhwmPxhFp+/JGf+FJ8Jc3+xNaxUEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=euV5CyjUoRsIOj2TQWa6MvzI8JB/C7uqhT0n0cX+aQTtVByQGv+KJTUcq3Bg79EqoB
         mzMrLJd3QRd+ai49kbyrmgQe+dpLiuo8inf+sTQsbH8FTK3GihyL7VyQL5BcpBJQ0Wjd
         VmUEr8uk5XL/DUHgdO3QGLPhkbEi8fyJBYc3Q=
Received: by 10.216.89.12 with SMTP id b12mr816923wef.93.1264525676602;
        Tue, 26 Jan 2010 09:07:56 -0800 (PST)
Received: from localhost.localdomain ([219.246.59.166])
        by mx.google.com with ESMTPS id m5sm12232138gve.7.2010.01.26.09.07.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 09:07:55 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue v3] MIPS: Cleanup the debugging of compressed kernel support
Date:   Wed, 27 Jan 2010 01:01:50 +0800
Message-Id: <cf2781a56090637044a5ad3837caef468a674ee4.1264524254.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16816

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from v2:

  O Not make the DEBUG_ZBOOT depend on the specific debugging support but only
  SYS_SUPPORTS_ZBOOT, which will make this option stable.
  O Keep the obj-$() work as the first revision does to allow the developers to
  add a new debugging support more conveniently.
  O Add new comment for this commit as a "manual" for the developers.

This patch adds a new DEBUG_ZBOOT option to allow the developers to debug the
compressed kernel support for a new board.

If you want to add compressed kernel support to a new board, and the board
supports uart16550 compatible serial port, please select
SYS_SUPPORTS_ZBOOT_UART16550 for your board and enable this option to debug it:

FILE: arch/mips/Kconfig

config MACH_XXX
	...
+	select SYS_SUPPORTS_ZBOOT_UART16550
	...

If your board doesn't support uart16550 compatible serial port, you can try to
select SYS_SUPPORTS_ZBOOT and use the other methods to debug it. for example,
add a new serial port support just as arch/mips/boot/compressed/uart-16550.c
does:

FILE: arch/mips/Kconfig

config MACH_XXX
	...
+	select SYS_SUPPORTS_ZBOOT_UARTXXX
	...

+config SYS_SUPPORTS_ZBOOT_UARTXXX
+	bool
+	select SYS_SUPPORTS_ZBOOT

FILE: arch/mips/boot/compressed/Makefile

ifdef DEBUG_ZBOOT
obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UARTXXX) += $(obj)/uart-xxx.o
endif

FILE(new): arch/mips/boot/compressed/uart-xxx.c

After the compressed kernel support works, please disable this option to reduce
the kernel image size and speed up the booting procedure a little.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig.debug            |   18 ++++++++++++++++++
 arch/mips/boot/compressed/Makefile |    2 ++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index d2b88a0..6fccbf0 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -102,4 +102,22 @@ config RUNTIME_DEBUG
 	  arch/mips/include/asm/debug.h for debugging macros.
 	  If unsure, say N.
 
+config DEBUG_ZBOOT
+	bool "Enable compressed kernel support debugging"
+	depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT
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
index 91a57a6..b27d12a 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -32,7 +32,9 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 
 obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
+ifdef DEBUG_ZBOOT
 obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+endif
 
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
 $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
-- 
1.6.6
