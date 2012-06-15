Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:11:59 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50514 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903388Ab2FOILR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:11:17 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so5186436pbb.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SW8Vxi63Qf2lm52UyUBZcEGHqj1mgCC/jZtkBPIzZmU=;
        b=gRmzpACzIClEZjAzhPxTBue9ZcW0wn+ze4+8lgGghgGA3Ro+knsBakYZdmKz8trICa
         FEw+2f8sKXkKuf8VNynJ5rqY386NjkS0UE3/sXE8Wft44By2ovZ6JihYMQe1+Ft9K96r
         jDOmh5qra3L95Cyu0PBwov9vjMgIKWRY5zNww5CmNWmxQx9QC0SHrgnitOjRJpdYEnr9
         P9eO2dKhAcIuwXaoG6M/afKHM7F7Z3K5RCs8D6I/vphC+XqrnTSXCAPfY2l5L9Nzi+qQ
         zOV98hzEoCQz5k1m7WYcby+Uk22Tevo5lNid1/h0vkcWgIJ6jam1AEJvr00tXK9pMIPj
         IjjA==
Received: by 10.68.238.68 with SMTP id vi4mr16669657pbc.123.1339747876524;
        Fri, 15 Jun 2012 01:11:16 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.11.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:11:15 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 02/14] MIPS: Loongson 3: Add Lemote-3A machtypes definition.
Date:   Fri, 15 Jun 2012 16:09:49 +0800
Message-Id: <1339747801-28691-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add three Loongson 3 based machine types:
MACH_LEMOTE_A1004 is laptop;
MACH_LEMOTE_A1101 is mini-itx;
MACH_LEMOTE_A1205 is all-in-one machine.

The most significant differrent between A1004 and A1101/A1205 is
the laptop has EC but others don't.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/bootinfo.h              |   23 +++++++++++++--------
 arch/mips/include/asm/mach-loongson/machine.h |    6 +++++
 arch/mips/loongson/Kconfig                    |   26 +++++++++++++++++++++++++
 arch/mips/loongson/common/machtype.c          |    5 +++-
 4 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 7a51d87..d5da63e 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -61,15 +61,20 @@
 /*
  * Valid machtype for Loongson family
  */
-#define MACH_LOONGSON_UNKNOWN  0
-#define MACH_LEMOTE_FL2E       1
-#define MACH_LEMOTE_FL2F       2
-#define MACH_LEMOTE_ML2F7      3
-#define MACH_LEMOTE_YL2F89     4
-#define MACH_DEXXON_GDIUM2F10  5
-#define MACH_LEMOTE_NAS        6
-#define MACH_LEMOTE_LL2F       7
-#define MACH_LOONGSON_END      8
+enum loongson_machine_type {
+	MACH_LOONGSON_UNKNOWN,
+	MACH_LEMOTE_FL2E,
+	MACH_LEMOTE_FL2F,
+	MACH_LEMOTE_ML2F7,
+	MACH_LEMOTE_YL2F89,
+	MACH_DEXXON_GDIUM2F10,
+	MACH_LEMOTE_NAS,
+	MACH_LEMOTE_LL2F,
+	MACH_LEMOTE_A1004,
+	MACH_LEMOTE_A1101,
+	MACH_LEMOTE_A1205,
+	MACH_LOONGSON_END
+};
 
 /*
  * Valid machtype for group INGENIC
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 4321338..481c5d9 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -24,4 +24,10 @@
 
 #endif
 
+#ifdef CONFIG_LEMOTE_MACH3A
+
+#define LOONGSON_MACHTYPE MACH_LEMOTE_A1004
+
+#endif /* CONFIG_LEMOTE_MACH3A */
+
 #endif /* __ASM_MACH_LOONGSON_MACHINE_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index d46a923..6c56c97 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -58,6 +58,32 @@ config LEMOTE_MACH2F
 
 	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
 	  LingLoong allinone PC and so forth.
+
+config LEMOTE_MACH3A
+	bool "Lemote Loongson 3A family machines"
+	select ARCH_SPARSEMEM_ENABLE
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select CSRC_R4K
+	select CEVT_R4K
+	select CPU_HAS_WB
+	select HW_HAS_PCI
+	select ISA
+	select I8259
+	select IRQ_CPU
+	select SYS_HAS_CPU_LOONGSON3
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select LOONGSON_MC146818
+	help
+		Lemote Loongson 3A family machines utilize the 3A revision of
+		Loongson processor and RS780/SBX00 chipset.
 endchoice
 
 config CS5536
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 2efd5d9..e377b44 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -25,8 +25,11 @@ static const char *system_types[] = {
 	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
 	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
 	[MACH_DEXXON_GDIUM2F10]         "dexxon-gdium-2f",
-	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
+	[MACH_LEMOTE_NAS]               "lemote-nas-2f",
 	[MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
+	[MACH_LEMOTE_A1004]             "lemote-3a-notebook-a1004",
+	[MACH_LEMOTE_A1101]             "lemote-3a-itx-a1101",
+	[MACH_LEMOTE_A1205]             "lemote-2gq-aio-a1205",
 	[MACH_LOONGSON_END]             NULL,
 };
 
-- 
1.7.7.3
