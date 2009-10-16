Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:18:16 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:60124 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493007AbZJPGRq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:17:46 +0200
Received: by pxi17 with SMTP id 17so681981pxi.21
        for <multiple recipients>; Thu, 15 Oct 2009 23:17:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Yl7zPmaUUql98okGaqXWulebz+c69PglJ0GJTJggU8w=;
        b=IUaxTLz07VT5H/sc9+dvLHhLb5wqwdaW7hdolgxAw+rBNu6z8jF7uvr8E1pS75OSro
         fG5P7XESww98KtWl2I4cBq1TZuGfkPSqgMQJN7jU16UQfj9lOVhXOOPXe0Tf6oe/hC9c
         p+tP7hP1Cg796+DB2wq0/rH5wmxbu8xOGNnx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gZj9UL0lwua6Wu+XvHPEkwW6t2TiwF0CQcy5HEjAMqbaoCyK+bmqMp1CPyXw0R+GeL
         LGnL6ycOFC69Y9Hgm4vHH0twFaACh2kjhk70+dBhIRDTayPoFaGUHiqapTZNzv7cnKkB
         2Av0hQnUZjn5Bb5EuceLl64kGXARcbMUYIktQ=
Received: by 10.115.114.9 with SMTP id r9mr1242552wam.19.1255673858781;
        Thu, 15 Oct 2009 23:17:38 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.17.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:17:37 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/7] [loongson] fuloong2e: Cleanup the Kconfig
Date:	Fri, 16 Oct 2009 14:17:14 +0800
Message-Id: <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1255672832.git.wuzhangjin@gmail.com>
References: <cover.1255672832.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch replace the indention from whitespace to tab in
arch/mips/loongson/Kconfig.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Kconfig |   52 ++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index d450925..818a028 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -1,31 +1,31 @@
 choice
-    prompt "Machine Type"
-    depends on MACH_LOONGSON
+	prompt "Machine Type"
+	depends on MACH_LOONGSON
 
 config LEMOTE_FULOONG2E
-    bool "Lemote Fuloong(2e) mini-PC"
-    select ARCH_SPARSEMEM_ENABLE
-    select CEVT_R4K
-    select CSRC_R4K
-    select SYS_HAS_CPU_LOONGSON2E
-    select DMA_NONCOHERENT
-    select BOOT_ELF32
-    select BOARD_SCACHE
-    select HW_HAS_PCI
-    select I8259
-    select ISA
-    select IRQ_CPU
-    select SYS_SUPPORTS_32BIT_KERNEL
-    select SYS_SUPPORTS_64BIT_KERNEL
-    select SYS_SUPPORTS_LITTLE_ENDIAN
-    select SYS_SUPPORTS_HIGHMEM
-    select SYS_HAS_EARLY_PRINTK
-    select GENERIC_HARDIRQS_NO__DO_IRQ
-    select GENERIC_ISA_DMA_SUPPORT_BROKEN
-    select CPU_HAS_WB
-    help
-      Lemote Fuloong(2e) mini-PC board based on the Chinese Loongson-2E CPU and
-      an FPGA northbridge
+	bool "Lemote Fuloong(2e) mini-PC"
+	select ARCH_SPARSEMEM_ENABLE
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON2E
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
+	help
+	  Lemote Fuloong(2e) mini-PC board based on the Chinese Loongson-2E CPU and
+	  an FPGA northbridge
 
-      Lemote Fuloong(2e) mini PC have a VIA686B south bridge.
+	  Lemote Fuloong(2e) mini PC have a VIA686B south bridge.
 endchoice
-- 
1.6.2.1
