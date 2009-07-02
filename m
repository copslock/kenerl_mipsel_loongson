Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:29:42 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:60930 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492206AbZGBP3g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:29:36 +0200
Received: by ewy10 with SMTP id 10so2098091ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:23:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PaOFrDF+hSYpdCa9winuGKDZUv8V7cg2vynUNIbQNuA=;
        b=ZHJ1v/epQm4k+Qz3rsRTsIMDK+FlAnACUhiKgusl1jvKjwn4x21EJa2wbiGlw+l0UZ
         mPII7dvBKHW/wDANG/LurmNPWCv5ut4KShw5dVkdsTVpmwgPk8+KDjwZWRZ2sDqxccW2
         Bjt0fik/j7rbcoYgi6Kao2ttlkgYIp4AMIZwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dDQ7iRCOUbqabPjTroFvtXFzACNl0h03RLVAGMxe7BVuatO3HYjCjArtbNATaVc40J
         7wKkMLtm6phbbg4azsByyb0y5amnmKoDSov+/4MssIq3zWUBK3S3QxTVT5hCm+kltHDH
         WqjsLMA2w+hUM4WtNT4cyFQMQh2NlUprTP2bw=
Received: by 10.210.110.5 with SMTP id i5mr1081965ebc.80.1246548225491;
        Thu, 02 Jul 2009 08:23:45 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 28sm5323930eyg.14.2009.07.02.08.23.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:23:44 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 09/16] [loongson] pci: clean up pcimap setup
Date:	Thu,  2 Jul 2009 23:23:30 +0800
Message-Id: <6a16acdd7c6617798d87b064dedbbca26f69a153.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

fixup the wrong original comment of pcimap, and make the source code
more understandable. and also, some new extra consideration is added in.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-lemote/loongson.h |   17 +++++++++++
 arch/mips/include/asm/mach-lemote/pci.h      |    4 +-
 arch/mips/lemote/lm2e/pci.c                  |   41 ++++++++++++++++---------
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/mach-lemote/loongson.h b/arch/mips/include/asm/mach-lemote/loongson.h
index 76cc2bd..916eace 100644
--- a/arch/mips/include/asm/mach-lemote/loongson.h
+++ b/arch/mips/include/asm/mach-lemote/loongson.h
@@ -33,4 +33,21 @@ extern void __init prom_init_memory(void);
 extern void __init prom_init_cmdline(void);
 extern void __init prom_init_env(void);
 
+/* PCI Configuration Registers */
+#define LOONGSON_PCI_ISR4C  BONITO_PCI_REG(0x4c)
+
+/* PCI_Hit*_Sel_* */
+
+#define LOONGSON_PCI_HIT0_SEL_L     BONITO(BONITO_REGBASE + 0x50)
+#define LOONGSON_PCI_HIT0_SEL_H     BONITO(BONITO_REGBASE + 0x54)
+#define LOONGSON_PCI_HIT1_SEL_L     BONITO(BONITO_REGBASE + 0x58)
+#define LOONGSON_PCI_HIT1_SEL_H     BONITO(BONITO_REGBASE + 0x5c)
+#define LOONGSON_PCI_HIT2_SEL_L     BONITO(BONITO_REGBASE + 0x60)
+#define LOONGSON_PCI_HIT2_SEL_H     BONITO(BONITO_REGBASE + 0x64)
+
+/* PXArb Config & Status */
+
+#define LOONGSON_PXARB_CFG      BONITO(BONITO_REGBASE + 0x68)
+#define LOONGSON_PXARB_STATUS       BONITO(BONITO_REGBASE + 0x6c)
+
 #endif /* __ASM_MACH_LOONGSON_LOONGSON_H */
diff --git a/arch/mips/include/asm/mach-lemote/pci.h b/arch/mips/include/asm/mach-lemote/pci.h
index 92b2f59..3e6b130 100644
--- a/arch/mips/include/asm/mach-lemote/pci.h
+++ b/arch/mips/include/asm/mach-lemote/pci.h
@@ -24,8 +24,8 @@
 
 extern struct pci_ops bonito64_pci_ops;
 
-#define LOONGSON2E_PCI_MEM_START	0x14000000UL
-#define LOONGSON2E_PCI_MEM_END		0x1fffffffUL
+#define LOONGSON2E_PCI_MEM_START	BONITO_PCILO1_BASE
+#define LOONGSON2E_PCI_MEM_END		(BONITO_PCILO1_BASE + 0x04000000 * 2)
 #define LOONGSON2E_PCI_IO_START		0x00004000UL
 
 #endif /* !__ASM_MACH_LEMOTE_PCI_H_ */
diff --git a/arch/mips/lemote/lm2e/pci.c b/arch/mips/lemote/lm2e/pci.c
index bee846e..9812c30 100644
--- a/arch/mips/lemote/lm2e/pci.c
+++ b/arch/mips/lemote/lm2e/pci.c
@@ -34,33 +34,44 @@ static struct pci_controller  loongson2e_pci_controller = {
 	.io_offset      = 0x00000000UL,
 };
 
-static void __init ict_pcimap(void)
+static void __init setup_pcimap(void)
 {
 	/*
-	 * local to PCI mapping: [256M,512M] -> [256M,512M]; differ from PMON
-	 *
+	 * local to PCI mapping for CPU accessing PCI space
 	 * CPU address space [256M,448M] is window for accessing pci space
-	 * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
-	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
+	 * we set pcimap_lo[0,1,2] to map it to pci space[0M,64M], [320M,448M]
+	 *
+	 * pcimap: PCI_MAP2  PCI_Mem_Lo2 PCI_Mem_Lo1 PCI_Mem_Lo0
+	 * 	     [<2G]   [384M,448M] [320M,384M] [0M,64M]
 	 */
-	/* 1,00 0110 ,0001 01,00 0000 */
-	BONITO_PCIMAP = 0x46140;
-
-	/* 1, 00 0010, 0000,01, 00 0000 */
-	/* BONITO_PCIMAP = 0x42040; */
+	BONITO_PCIMAP = BONITO_PCIMAP_PCIMAP_2 |
+		BONITO_PCIMAP_WIN(2, BONITO_PCILO2_BASE) |
+		BONITO_PCIMAP_WIN(1, BONITO_PCILO1_BASE) |
+		BONITO_PCIMAP_WIN(0, 0);
 
 	/*
-	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
+	 * PCI-DMA to local mapping: [2G,2G+256M] -> [0M,256M]
 	 */
-	BONITO_PCIBASE0 = 0x80000000;
-	BONITO_PCIBASE1 = 0x00800000;
-	BONITO_PCIBASE2 = 0x90000000;
+	BONITO_PCIBASE0 = 0x80000000ul;   /* base: 2G -> mmap: 0M */
+	/* size: 256M, burst transmission, pre-fetch enable, 64bit */
+	LOONGSON_PCI_HIT0_SEL_L = 0xc000000cul;
+	LOONGSON_PCI_HIT0_SEL_H = 0xfffffffful;
+	LOONGSON_PCI_HIT1_SEL_L = 0x00000006ul; /* set this BAR as invalid */
+	LOONGSON_PCI_HIT1_SEL_H = 0x00000000ul;
+	LOONGSON_PCI_HIT2_SEL_L = 0x00000006ul; /* set this BAR as invalid */
+	LOONGSON_PCI_HIT2_SEL_H = 0x00000000ul;
+
+	/* avoid deadlock of PCI reading/writing lock operation */
+	LOONGSON_PCI_ISR4C = 0xd2000001ul;
 
+	/* can not change gnt to break pci transfer when device's gnt not
+	deassert for some broken device */
+	LOONGSON_PXARB_CFG = 0x00fe0105ul;
 }
 
 static int __init pcibios_init(void)
 {
-	ict_pcimap();
+	setup_pcimap();
 
 	loongson2e_pci_controller.io_map_base = mips_io_port_base;
 
-- 
1.6.2.1
