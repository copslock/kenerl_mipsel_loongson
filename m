Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 02:28:09 +0200 (CEST)
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52679 "EHLO
        mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834670AbaDMAZlJMiJ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 02:25:41 +0200
Received: by mail-pb0-f46.google.com with SMTP id rq2so6838167pbb.19
        for <multiple recipients>; Sat, 12 Apr 2014 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f17LMrrDTBrBkAQXcUS7A6JuB6f49IQKFsC4Lh8NVbE=;
        b=uSSec1TCH8pu5+RUr705VmM4/2zVRbNi9RRpVMKgpAwWcOaZXU1202++P7w39GUJJ8
         w8PDYHPoPpsbrz7v0Avca5rHtg21uckLirmbNUr6qa/UJxHN03C7pPgyWe9SL6iowa5J
         EGviBh185v7tyqm+6Kf5sNop4KD6TyCESIp7mVUjBKhm7y/YZqGc4ZGQriez0gQ3Hzlm
         fu+tNCsOobPWR6VFTyyxu0+0EPWuLJ8sNZ/g2dCWq6H/lfYiiCm1TYU+H/zbvUyjztjO
         FdP4f9TQzPapT7+yqUtTpqHSYPQus9FL/aIwA3aW5m+gpujUQvzL7lKtPov3Gsgh+4Aw
         S+Pw==
X-Received: by 10.69.2.2 with SMTP id bk2mr35775324pbd.75.1397348734949;
        Sat, 12 Apr 2014 17:25:34 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sh5sm24474879pbc.21.2014.04.12.17.25.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 17:25:34 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 8/8] MIPS: Loongson: Rename CONFIG_LEMOTE_MACH3A to CONFIG_LOONGSON_MACH3X
Date:   Sun, 13 Apr 2014 08:24:22 +0800
Message-Id: <1397348662-22502-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Since this CONFIG option will be used for both Loongson-3A/3B machines,
and not all Loongson-3 machines are produced by Lemote, we rename
CONFIG_LEMOTE_MACH3A to CONFIG_LOONGSON_MACH3X.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/configs/loongson3_defconfig         |    2 +-
 arch/mips/include/asm/mach-loongson/machine.h |    4 ++--
 arch/mips/loongson/Kconfig                    |    8 ++++----
 arch/mips/loongson/Platform                   |    2 +-
 arch/mips/pci/Makefile                        |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index ea1761f..130e31b 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -1,6 +1,6 @@
 CONFIG_MACH_LOONGSON=y
 CONFIG_SWIOTLB=y
-CONFIG_LEMOTE_MACH3A=y
+CONFIG_LOONGSON_MACH3X=y
 CONFIG_CPU_LOONGSON3=y
 CONFIG_64BIT=y
 CONFIG_PAGE_SIZE_16KB=y
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 1b1f592..228e3784 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -24,10 +24,10 @@
 
 #endif
 
-#ifdef CONFIG_LEMOTE_MACH3A
+#ifdef CONFIG_LOONGSON_MACH3X
 
 #define LOONGSON_MACHTYPE MACH_LEMOTE_A1101
 
-#endif /* CONFIG_LEMOTE_MACH3A */
+#endif /* CONFIG_LOONGSON_MACH3X */
 
 #endif /* __ASM_MACH_LOONGSON_MACHINE_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 976c858..1c1595b 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -60,8 +60,8 @@ config LEMOTE_MACH2F
 	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
 	  LingLoong allinone PC and so forth.
 
-config LEMOTE_MACH3A
-	bool "Lemote Loongson 3A family machines"
+config LOONGSON_MACH3X
+	bool "Generic Loongson 3 family machines"
 	select ARCH_SPARSEMEM_ENABLE
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select BOOT_ELF32
@@ -87,8 +87,8 @@ config LEMOTE_MACH3A
 	select ZONE_DMA32
 	select LEFI_FIRMWARE_INTERFACE
 	help
-		Lemote Loongson 3A family machines utilize the 3A revision of
-		Loongson processor and RS780/SBX00 chipset.
+		Generic Loongson 3 family machines utilize the 3A/3B revision
+		of Loongson processor and RS780/SBX00 chipset.
 endchoice
 
 config CS5536
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
index 6205372..0ac20eb 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson/Platform
@@ -30,4 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
-load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
+load-$(CONFIG_LOONGSON_MACH3X) += 0xffffffff80200000
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index d61138a..afb5324 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
-obj-$(CONFIG_LEMOTE_MACH3A)	+= fixup-loongson3.o ops-loongson3.o
+obj-$(CONFIG_LOONGSON_MACH3X)	+= fixup-loongson3.o ops-loongson3.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o pci-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
-- 
1.7.7.3
