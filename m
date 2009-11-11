Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 06:40:28 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:49575 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492198AbZKKFji (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 06:39:38 +0100
Received: by pxi6 with SMTP id 6so849504pxi.0
        for <multiple recipients>; Tue, 10 Nov 2009 21:39:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=P6jgS+j/BBSLj6MZj3crhk0B99dSQXE4/CbKePMoxw4=;
        b=JgeBjwKlpRbyY8AXt6bkn8haD7tzxHJbjxXH6/CM9a51EAtddjs0n0wWARkLeUCxS8
         PiFS5fqVgLUS1T2Z+2h9hwTrXgNXU3VZ5nZ+7tjIf3fJjvH7CuQE2AtYyYp3PVy+jdjQ
         IASWoFJvBJJXqcwLNckDPUnUy/otvUHgnPyWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QfLR8jyfXj0R4bDc4acxLeZUwCNkFslnNW79OxvpS3w+DbzWH2D2ztdWI/3rRdMRjC
         ezGeUWebNB0DhDwE8J8Rm6g9qjvbtoqQL7Ycy4SvJzrzamb9F2PaOJ9Brlq8B31a/JRv
         HhI1GXvpC4/Kdfa4eIykTprHtBvDw1qkwFkWM=
Received: by 10.115.117.4 with SMTP id u4mr2303891wam.43.1257917970861;
        Tue, 10 Nov 2009 21:39:30 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm850415pxi.6.2009.11.10.21.39.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 21:39:30 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/2] [loongson] 2f: Cleanups of the #if clauses
Date:	Wed, 11 Nov 2009 13:39:12 +0800
Message-Id: <367b02daf305474f0bf59b995c27d6a5aaa2e962.1257917611.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1cb2ae6fba2acd5e5d276f49f5b734876859e589.1257917611.git.wuzhangjin@gmail.com>
References: <cover.1257917611.git.wuzhangjin@gmail.com>
 <1cb2ae6fba2acd5e5d276f49f5b734876859e589.1257917611.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257917611.git.wuzhangjin@gmail.com>
References: <cover.1257917611.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds two new kernel options: CPU_SUPPORT_CPUFREQ and
CPU_SUPPORT_ADDRWINCFG to describe the new features of loongons2f, and
replaces the several ugly #if clauses by them.

These two options will be utilized by the future loongson revisions
and/or by the relative drivers, such as the coming Loongson2F CPUFreq
driver.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                              |    8 ++++++++
 arch/mips/include/asm/mach-loongson/loongson.h |    6 +++---
 arch/mips/include/asm/mach-loongson/pci.h      |    4 ++--
 arch/mips/loongson/common/init.c               |    2 +-
 arch/mips/loongson/common/mem.c                |    8 ++++----
 arch/mips/loongson/common/pci.c                |    2 +-
 6 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 240a3ca..539c384 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1318,8 +1318,16 @@ config CPU_LOONGSON2
 config SYS_HAS_CPU_LOONGSON2E
 	bool
 
+config CPU_SUPPORT_CPUFREQ
+	bool
+
+config CPU_SUPPORT_ADDRWINCFG
+	bool
+
 config SYS_HAS_CPU_LOONGSON2F
 	bool
+	select CPU_SUPPORT_CPUFREQ
+	select CPU_SUPPORT_ADDRWINCFG if 64BIT
 
 config SYS_HAS_CPU_MIPS32_R1
 	bool
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 5b83bea..008c768 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -227,7 +227,7 @@ extern void mach_irq_dispatch(unsigned int pending);
 	((((ADDR)>>26) & LOONGSON_PCIMAP_PCIMAP_LO0) << ((WIN)*6))
 
 /* Chip Config */
-#ifdef CONFIG_CPU_LOONGSON2F
+#ifdef CONFIG_CPU_SUPPORT_CPUFREQ
 #define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
 #endif
 
@@ -236,7 +236,7 @@ extern void mach_irq_dispatch(unsigned int pending);
  *
  * loongson2e do not have this module
  */
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
 
 /* address window config module base address */
 #define LOONGSON_ADDRWINCFG_BASE		0x3ff00000ul
@@ -306,6 +306,6 @@ extern unsigned long _loongson_addrwincfg_base;
 #define LOONGSON_ADDRWIN_PCITODDR(win, src, dst, size) \
 	LOONGSON_ADDRWIN_CFG(PCIDMA, DDR, win, src, dst, size)
 
-#endif	/* ! CONFIG_CPU_LOONGSON2F && CONFIG_64BIT */
+#endif	/* ! CONFIG_CPU_SUPPORT_ADDRWINCFG */
 
 #endif /* __ASM_MACH_LOONGSON_LOONGSON_H */
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
index 31ba908..a2b78fa 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -28,7 +28,7 @@ extern struct pci_ops loongson_pci_ops;
 /* this is an offset from mips_io_port_base */
 #define LOONGSON_PCI_IO_START	0x00004000UL
 
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
 
 /*
  * we use address window2 to map cpu address space to pci space
@@ -56,6 +56,6 @@ extern struct pci_ops loongson_pci_ops;
 /* this is an offset from mips_io_port_base */
 #define LOONGSON_PCI_IO_START	0x00004000UL
 
-#endif	/* !(defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT))*/
+#endif	/* !CONFIG_CPU_SUPPORT_ADDRWINCFG */
 
 #endif /* !__ASM_MACH_LOONGSON_PCI_H_ */
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index 743d357..000bebd 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -21,7 +21,7 @@ void __init prom_init(void)
 	set_io_port_base((unsigned long)
 		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
 
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
 	_loongson_addrwincfg_base = (unsigned long)
 		ioremap(LOONGSON_ADDRWINCFG_BASE, LOONGSON_ADDRWINCFG_SIZE);
 #endif
diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
index 312c765..467a91e 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -21,8 +21,7 @@ void __init prom_init_memory(void)
 	add_memory_region(memsize << 20,
 			LOONGSON_PCI_MEM_START - (memsize << 20),
 			  BOOT_MEM_RESERVED);
-#ifdef CONFIG_64BIT
-#ifdef CONFIG_CPU_LOONGSON2F
+#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
 	{
 		int bit;
 
@@ -37,8 +36,9 @@ void __init prom_init_memory(void)
 					  0x80000000ul, (1 << bit));
 		mmiowb();
 	}
-#endif				/* CONFIG_CPU_LOONGSON2F */
+#endif				/* !CONFIG_CPU_SUPPORT_ADDRWINCFG */
 
+#ifdef CONFIG_64BIT
 	if (highmemsize > 0)
 		add_memory_region(LOONGSON_HIGHMEM_START,
 				  highmemsize << 20, BOOT_MEM_RAM);
@@ -46,7 +46,7 @@ void __init prom_init_memory(void)
 	add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START -
 			  LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
 
-#endif				/* CONFIG_64BIT */
+#endif				/* !CONFIG_64BIT */
 }
 
 /* override of arch/mips/mm/cache.c: __uncached_access */
diff --git a/arch/mips/loongson/common/pci.c b/arch/mips/loongson/common/pci.c
index eac43b8..cc3fa17 100644
--- a/arch/mips/loongson/common/pci.c
+++ b/arch/mips/loongson/common/pci.c
@@ -68,7 +68,7 @@ static void __init setup_pcimap(void)
 	deassert for some broken device */
 	LOONGSON_PXARB_CFG = 0x00fe0105ul;
 
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+#ifdef CONFIG_CPU_SUPPORT_ADDRWINCFG
 	/*
 	 * set cpu addr window2 to map CPU address space to PCI address space
 	 */
-- 
1.6.2.1
