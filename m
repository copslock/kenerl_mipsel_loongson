Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 14:12:29 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:39281 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492723AbZKFNMD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 14:12:03 +0100
Received: by pxi26 with SMTP id 26so367498pxi.21
        for <multiple recipients>; Fri, 06 Nov 2009 05:11:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=71krOEAoR9pvdrgsL5eCJSutFVZb6QsnvE11gJdZnvY=;
        b=AeFkcSUjIqN6Lijt8wGt8YH9KQhdCud0VCywlXoq4sdDH+UjCk6Zb2XpofsNv27G8i
         P5TFef+43lrq3jHc1xH/2GsE933w0kYV1v590n7f3cK9fSzpDu/ARGENRWBgEqOSy18J
         ae36nS73aByMk9oKq76LBZJgsHaMR3FLw1JPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IRFDnz08X9zVSlcBj/tgZAJvOdQGRxrrWg2lvLy1hcKC8/d7v364ML87XWF7R0NUaR
         wc+44JZMr6HQaMvrqyQjsUsKs/2p+yabzogI7lcmZL/ZwvUcDmJSENMbitCfVazUjIE/
         3ULngrN+BubuECDNtfuQQ/6x8+gg3w322biqk=
Received: by 10.115.66.10 with SMTP id t10mr6770523wak.20.1257513116316;
        Fri, 06 Nov 2009 05:11:56 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm26431pxi.7.2009.11.06.05.11.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 05:11:55 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, zhangfx@lemote.com,
	yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH -queue v1 1/7] [loongson] lemote-2f: add lemote loongson2f family machines support
Date:	Fri,  6 Nov 2009 21:11:26 +0800
Message-Id: <17e5d58a0cd7273b81c7151b7f7f2096c9694b59.1257510612.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch add a new kernel option for lemote loongson2f family
machines.

Lemote loongson2f family machines utilize the 2f revision of loongson
processor and the AMD CS5536 south bridge.

These family machines include fuloong2f mini PC, yeeloong2f notebook,
LingLoong allinone PC and so forth.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile                            |    1 +
 arch/mips/include/asm/mach-loongson/machine.h |    7 ++++++
 arch/mips/loongson/Kconfig                    |   29 +++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 47ecded..184d5be 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -327,6 +327,7 @@ core-$(CONFIG_MACH_LOONGSON) +=arch/mips/loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson \
                     -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) +=0xffffffff80100000
+load-$(CONFIG_LEMOTE_MACH2F) +=0xffffffff80200000
 
 #
 # MIPS Malta board
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index d2f5861..acf8359 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -17,4 +17,11 @@
 
 #endif
 
+/* use fuloong2f as the default machine of LEMOTE_MACH2F */
+#ifdef CONFIG_LEMOTE_MACH2F
+
+#define LOONGSON_MACHTYPE MACH_LEMOTE_FL2F
+
+#endif
+
 #endif /* __ASM_MACH_LOONGSON_MACHINE_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 818a028..9573406 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -28,4 +28,33 @@ config LEMOTE_FULOONG2E
 	  an FPGA northbridge
 
 	  Lemote Fuloong(2e) mini PC have a VIA686B south bridge.
+
+config LEMOTE_MACH2F
+	bool "Lemote loongson2f family machines"
+	select ARCH_SPARSEMEM_ENABLE
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON2F
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select HW_HAS_PCI
+	select I8259
+	select ISA
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select CPU_HAS_WB
+	select CS5536
+	help
+	  Lemote loongson2f family machines utilize the 2f revision of loongson
+	  processor and the AMD CS5536 south bridge.
+
+	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
+	  LingLoong allinone PC and so forth.
 endchoice
-- 
1.6.2.1
