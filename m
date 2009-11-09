Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:06:37 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.158]:16722 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492371AbZKIQGa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 17:06:30 +0100
Received: by fg-out-1718.google.com with SMTP id e12so703423fga.6
        for <multiple recipients>; Mon, 09 Nov 2009 08:06:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=71krOEAoR9pvdrgsL5eCJSutFVZb6QsnvE11gJdZnvY=;
        b=pJWdSN/OuQnwHffwL/eTsSgFqSWu1I9gbvw6f9kx0g2t7DphaewDuwp4kIv3sKECGE
         mFbcxAi+ZnhVOrFH2NzRfWaabvvtv7saqAzDSOxCZedpYdS9xp7ih13Lf5moWHAhOfAo
         P+eevM6KYT3I7H6euTnSf8ncaKseCZaChODsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RVsPYsY+w6brJ9LbtNnmXg1xbdeH+DEktPiaXMAJA2crlrEsKqZleuUBtropO4DrsX
         3WSSbWAANpwVBI2HjSClYVBZZx0adCG2ddNVpAeSc8QvREvyVoitCTIlGqSW8Emhy+gC
         qIfrm93a0JsVtRAO/2KXzfPCZ2bdX/h0qFT14=
Received: by 10.216.90.195 with SMTP id e45mr1456181wef.189.1257782787822;
        Mon, 09 Nov 2009 08:06:27 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id p37sm9150866gvf.24.2009.11.09.08.06.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 08:06:26 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org
Subject: [PATCH v2 1/7] [loongson] lemote-2f: add a LEMOTE_MACH2F kernel option
Date:	Tue, 10 Nov 2009 00:06:10 +0800
Message-Id: <3154ef478a3a08f808e3a4b9c9cab9f4e263a8a2.1257781987.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257781987.git.wuzhangjin@gmail.com>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24791
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
