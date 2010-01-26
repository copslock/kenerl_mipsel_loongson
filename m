Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 10:10:42 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:54100 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492720Ab0AZJKP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 10:10:15 +0100
Received: by pzk35 with SMTP id 35so470829pzk.22
        for <multiple recipients>; Tue, 26 Jan 2010 01:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Xbu6+WDpKUUme+8fbLoaaf0h/UVR3T+kSYir0QvnfiY=;
        b=HUpJOy5u66lKEiG0azGducg5pvVfjVPn3mozTSiijW73c7Abl9VbTxjuvSccm2zmW0
         tc1N6AhaeT81AV83L/XXKT/dBjvxmx49RduLuqXgxT39jeIkWtRLj2l4hRAP7qLeHZuk
         YKu2ad1tBQGWKUM2CAQqt9718RILbqufebYxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vnn49DUp0Xf9dHaPOXJXqQ0cYCud3QD3c45mGLLIRfxbKsMJ/BTXuzxq9mrKbNavno
         Y7rItuWrn3cuBPY9/jq/XTBUXsORceTzVyqloB0POLgEhrQujnQ0mpgVos0Wx+R2FWkP
         STWoUbfytOFJbjKJ/dN9CbYXPjvVMUYbUKEKk=
Received: by 10.142.4.41 with SMTP id 41mr1263212wfd.123.1264497008187;
        Tue, 26 Jan 2010 01:10:08 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm5603365pzk.14.2010.01.26.01.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 01:10:07 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/2] MIPS: Cleanup the debugging of compressed kernel support
Date:   Tue, 26 Jan 2010 17:04:03 +0800
Message-Id: <cbf30435132e35087c6c6b8ca172c7d9cb0cbc37.1264496568.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <979633248ed16f2724296fd90f4b824f601809e1.1264496568.git.wuzhangjin@gmail.com>
References: <979633248ed16f2724296fd90f4b824f601809e1.1264496568.git.wuzhangjin@gmail.com>
In-Reply-To: <979633248ed16f2724296fd90f4b824f601809e1.1264496568.git.wuzhangjin@gmail.com>
References: <979633248ed16f2724296fd90f4b824f601809e1.1264496568.git.wuzhangjin@gmail.com>
X-archive-position: 25660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16537

This patch adds a new DEBUG_ZBOOT option to allow the developers to
debug the compressed kernel support for a new board.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig.debug            |   18 ++++++++++++++++++
 arch/mips/boot/compressed/Makefile |    2 ++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index d2b88a0..b3e20f4 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -102,4 +102,22 @@ config RUNTIME_DEBUG
 	  arch/mips/include/asm/debug.h for debugging macros.
 	  If unsure, say N.
 
+config DEBUG_ZBOOT
+	bool "Enable compressed kernel support debugging"
+	depends on SYS_SUPPORTS_ZBOOT_UART16550
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
index 91a57a6..68e5db8 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -32,7 +32,9 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 
 obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
+ifdef CONFIG_DEBUG_ZBOOT
 obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+endif
 
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
 $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
-- 
1.6.6
