Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 23:27:15 +0200 (CEST)
Received: from mail-we0-f171.google.com ([74.125.82.171]:38472 "EHLO
        mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861337AbaGQV04lIU9h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 23:26:56 +0200
Received: by mail-we0-f171.google.com with SMTP id p10so3753235wes.16
        for <multiple recipients>; Thu, 17 Jul 2014 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3fwoA7Xx3vuhSrsfABCGTt6f1yE3RHuMMh7z6ndJHJQ=;
        b=ahb3tKKuHOALVTvpZE+BTsEssiRHp2hCpH+7usZRTmhEzfWJWbbOwsPsTEncuGT111
         SyDRhoU2CthWwQQUvvFYmXQXjgpIxoQKjgXjmZBJa1Il94c/CChPfH81xxpH4tVWXl97
         afkfeiarAvqLLIVmm1ZABD6/VK+c7WW4ZGfxSdeisQ5Gk0ZksHjvsAOVn9g+Qt9hddrV
         hzzD6juILsYB0/hD4+SnvqeMrAKYFzCSV4REjzlj6+yGcGnj7RRhQEVTxb7JPb6wN0tc
         IosNwfJyckzUw9H0u3QZOx3LJ1Aln296yDtPM/jri3KLoiCwjlS53J1opa6v/eHBA3Ns
         ks2A==
X-Received: by 10.180.24.34 with SMTP id r2mr1431786wif.46.1405632411096;
        Thu, 17 Jul 2014 14:26:51 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id fu7sm25223443wib.2.2014.07.17.14.26.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 14:26:50 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM47XX: Detect more then 128 MiB of RAM (HIGHMEM)
Date:   Thu, 17 Jul 2014 23:26:33 +0200
Message-Id: <1405632393-17960-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1405632393-17960-1-git-send-email-zajec5@gmail.com>
References: <1405632393-17960-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

So far BCM47XX can only detect amount of HIGHMEM. It still requires
adding (registering) and well-testing before enabling by default.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
Changes since RFC:
1) Use pgtable-32.h instead of ugly "extern" in .c file
2) Make it clear it needs work & testing before enabling
---
 arch/mips/bcm47xx/bcm47xx_private.h |  3 ++
 arch/mips/bcm47xx/prom.c            | 68 ++++++++++++++++++++++++++++++++++++-
 arch/mips/bcm47xx/setup.c           |  3 ++
 arch/mips/include/asm/pgtable-32.h  |  2 ++
 arch/mips/mm/tlb-r4k.c              |  2 +-
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index 0194c3b..f1cc9d0 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -3,6 +3,9 @@
 
 #include <linux/kernel.h>
 
+/* prom.c */
+void __init bcm47xx_prom_highmem_init(void);
+
 /* buttons.c */
 int __init bcm47xx_buttons_register(void);
 
diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 1a03a2f..1b170bf 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -51,6 +51,8 @@ __init void bcm47xx_set_system_type(u16 chip_id)
 		 chip_id);
 }
 
+static unsigned long lowmem __initdata;
+
 static __init void prom_init_mem(void)
 {
 	unsigned long mem;
@@ -87,6 +89,7 @@ static __init void prom_init_mem(void)
 		if (!memcmp(prom_init, prom_init + mem, 32))
 			break;
 	}
+	lowmem = mem;
 
 	/* Ignoring the last page when ddr size is 128M. Cached
 	 * accesses to last page is causing the processor to prefetch
@@ -95,7 +98,6 @@ static __init void prom_init_mem(void)
 	 */
 	if (c->cputype == CPU_74K && (mem == (128  << 20)))
 		mem -= 0x1000;
-
 	add_memory_region(0, mem, BOOT_MEM_RAM);
 }
 
@@ -114,3 +116,67 @@ void __init prom_init(void)
 void __init prom_free_prom_memory(void)
 {
 }
+
+#if defined(CONFIG_BCM47XX_BCMA) && defined(CONFIG_HIGHMEM)
+
+#define EXTVBASE	0xc0000000
+#define ENTRYLO(x)	((pte_val(pfn_pte((x) >> _PFN_SHIFT, PAGE_KERNEL_UNCACHED)) >> 6) | 1)
+
+#include <asm/tlbflush.h>
+
+/* Stripped version of tlb_init, with the call to build_tlb_refill_handler
+ * dropped. Calling it at this stage causes a hang.
+ */
+void __cpuinit early_tlb_init(void)
+{
+	write_c0_pagemask(PM_DEFAULT_MASK);
+	write_c0_wired(0);
+	temp_tlb_entry = current_cpu_data.tlbsize - 1;
+	local_flush_tlb_all();
+}
+
+void __init bcm47xx_prom_highmem_init(void)
+{
+	unsigned long off = (unsigned long)prom_init;
+	unsigned long extmem = 0;
+	bool highmem_region = false;
+
+	if (WARN_ON(bcm47xx_bus_type != BCM47XX_BUS_TYPE_BCMA))
+		return;
+
+	if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
+		highmem_region = true;
+
+	if (lowmem != 128 << 20 || !highmem_region)
+		return;
+
+	early_tlb_init();
+
+	/* Add one temporary TLB entry to map SDRAM Region 2.
+	 *      Physical        Virtual
+	 *      0x80000000      0xc0000000      (1st: 256MB)
+	 *      0x90000000      0xd0000000      (2nd: 256MB)
+	 */
+	add_temporary_entry(ENTRYLO(0x80000000),
+			    ENTRYLO(0x80000000 + (256 << 20)),
+			    EXTVBASE, PM_256M);
+
+	off = EXTVBASE + __pa(off);
+	for (extmem = 128 << 20; extmem < 512 << 20; extmem <<= 1) {
+		if (!memcmp(prom_init, (void *)(off + extmem), 16))
+			break;
+	}
+	extmem -= lowmem;
+
+	early_tlb_init();
+
+	if (!extmem)
+		return;
+
+	pr_warn("Found %lu MiB of extra memory, but highmem is unsupported yet!\n",
+		extmem >> 20);
+
+	/* TODO: Register extra memory */
+}
+
+#endif /* defined(CONFIG_BCM47XX_BCMA) && defined(CONFIG_HIGHMEM) */
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 63a4b0e..8c8e7cd 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -218,6 +218,9 @@ void __init plat_mem_setup(void)
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_BCMA;
 		bcm47xx_register_bcma();
 		bcm47xx_set_system_type(bcm47xx_bus.bcma.bus.chipinfo.id);
+#ifdef CONFIG_HIGHMEM
+		bcm47xx_prom_highmem_init();
+#endif
 #endif
 	} else {
 		printk(KERN_INFO "bcm47xx: using ssb bus\n");
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 2b11332..cd7d606 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -18,6 +18,8 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
+extern int temp_tlb_entry __cpuinitdata;
+
 /*
  * - add_temporary_entry() add a temporary TLB entry. We use TLB entries
  *	starting at the top and working down. This is for populating the
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 04feeb5..92c9efdb 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -397,7 +397,7 @@ int __init has_transparent_hugepage(void)
  * lifetime of the system
  */
 
-static int temp_tlb_entry __cpuinitdata;
+int temp_tlb_entry __cpuinitdata;
 
 __init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 			       unsigned long entryhi, unsigned long pagemask)
-- 
1.8.4.5
