Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2003 21:32:28 +0100 (BST)
Received: from p0329.as-l042.contactel.cz ([IPv6:::ffff:194.108.238.75]:772
	"EHLO kopretinka") by linux-mips.org with ESMTP id <S8225222AbTEGUcG>;
	Wed, 7 May 2003 21:32:06 +0100
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 19DVQr-0000AX-00; Wed, 07 May 2003 22:22:29 +0200
Date: Wed, 7 May 2003 22:22:29 +0200
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] sc-ip22.c cleanup
Message-ID: <20030507202229.GA627@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

use serial eeprom access functions to detect scache size


diff -Naur linux_2_4/arch/mips/mm/sc-ip22.c linux_2_4-fucked/arch/mips/mm/sc-ip22.c
--- linux_2_4/arch/mips/mm/sc-ip22.c	Thu Apr 17 02:29:14 2003
+++ linux_2_4-fucked/arch/mips/mm/sc-ip22.c	Wed May  7 20:10:22 2003
@@ -14,9 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/bootinfo.h>
-#include <asm/mmu_context.h>
-#include <asm/sgialib.h>
-#include <asm/sgi/sgi.h>
+#include <asm/sgi/ip22.h>
 #include <asm/sgi/mc.h>
 
 /* Secondary cache size in bytes, if present.  */
@@ -149,60 +147,14 @@
 
 static inline int __init indy_sc_probe(void)
 {
-	volatile unsigned int *cpu_control;
-	unsigned short cmd = 0xc220;
-	unsigned long data = 0;
-	int i, n;
-
-#ifdef __MIPSEB__
-	cpu_control = (volatile unsigned int *) KSEG1ADDR(0x1fa00034);
-#else
-	cpu_control = (volatile unsigned int *) KSEG1ADDR(0x1fa00030);
-#endif
-#define DEASSERT(bit) (*(cpu_control) &= (~(bit)))
-#define ASSERT(bit) (*(cpu_control) |= (bit))
-#define DELAY  for(n = 0; n < 100000; n++) __asm__ __volatile__("")
-	DEASSERT(SGIMC_EEPROM_PRE);
-	DEASSERT(SGIMC_EEPROM_SDATAO);
-	DEASSERT(SGIMC_EEPROM_SECLOCK);
-	DEASSERT(SGIMC_EEPROM_PRE);
-	DELAY;
-	ASSERT(SGIMC_EEPROM_CSEL); ASSERT(SGIMC_EEPROM_SECLOCK);
-	for(i = 0; i < 11; i++) {
-		if(cmd & (1<<15))
-			ASSERT(SGIMC_EEPROM_SDATAO);
-		else
-			DEASSERT(SGIMC_EEPROM_SDATAO);
-		DEASSERT(SGIMC_EEPROM_SECLOCK);
-		ASSERT(SGIMC_EEPROM_SECLOCK);
-		cmd <<= 1;
-	}
-	DEASSERT(SGIMC_EEPROM_SDATAO);
-	for(i = 0; i < (sizeof(unsigned short) * 8); i++) {
-		unsigned int tmp;
-
-		DEASSERT(SGIMC_EEPROM_SECLOCK);
-		DELAY;
-		ASSERT(SGIMC_EEPROM_SECLOCK);
-		DELAY;
-		data <<= 1;
-		tmp = *cpu_control;
-		if(tmp & SGIMC_EEPROM_SDATAI)
-			data |= 1;
-	}
-	DEASSERT(SGIMC_EEPROM_SECLOCK);
-	DEASSERT(SGIMC_EEPROM_CSEL);
-	ASSERT(SGIMC_EEPROM_PRE);
-	ASSERT(SGIMC_EEPROM_SECLOCK);
-
-	data <<= PAGE_SHIFT;
-	if (data == 0)
+	unsigned long size = ip22_eeprom_read(&sgimc->eeprom, 17);
+	size <<= PAGE_SHIFT;
+	if (size == 0)
 		return 0;
 
-	scache_size = data;
-
 	printk(KERN_INFO "R4600/R5000 SCACHE size %ldK, linesize 32 bytes.\n",
-	       scache_size >> 10);
+	       size >> 10);
+	scache_size = size;
 
 	return 1;
 }
diff -Naur linux_2_4/arch/mips/mm/sc-ip22.c linux_2_4-fucked/arch/mips/mm/sc-ip22.c
--- linux_2_4/arch/mips/mm/sc-ip22.c	Thu Apr 17 02:29:14 2003
+++ linux_2_4-fucked/arch/mips/mm/sc-ip22.c	Wed May  7 20:10:22 2003
@@ -14,9 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/bootinfo.h>
-#include <asm/mmu_context.h>
-#include <asm/sgialib.h>
-#include <asm/sgi/sgi.h>
+#include <asm/sgi/ip22.h>
 #include <asm/sgi/mc.h>
 
 /* Secondary cache size in bytes, if present.  */
@@ -149,60 +147,14 @@
 
 static inline int __init indy_sc_probe(void)
 {
-	volatile unsigned int *cpu_control;
-	unsigned short cmd = 0xc220;
-	unsigned long data = 0;
-	int i, n;
-
-#ifdef __MIPSEB__
-	cpu_control = (volatile unsigned int *) KSEG1ADDR(0x1fa00034);
-#else
-	cpu_control = (volatile unsigned int *) KSEG1ADDR(0x1fa00030);
-#endif
-#define DEASSERT(bit) (*(cpu_control) &= (~(bit)))
-#define ASSERT(bit) (*(cpu_control) |= (bit))
-#define DELAY  for(n = 0; n < 100000; n++) __asm__ __volatile__("")
-	DEASSERT(SGIMC_EEPROM_PRE);
-	DEASSERT(SGIMC_EEPROM_SDATAO);
-	DEASSERT(SGIMC_EEPROM_SECLOCK);
-	DEASSERT(SGIMC_EEPROM_PRE);
-	DELAY;
-	ASSERT(SGIMC_EEPROM_CSEL); ASSERT(SGIMC_EEPROM_SECLOCK);
-	for(i = 0; i < 11; i++) {
-		if(cmd & (1<<15))
-			ASSERT(SGIMC_EEPROM_SDATAO);
-		else
-			DEASSERT(SGIMC_EEPROM_SDATAO);
-		DEASSERT(SGIMC_EEPROM_SECLOCK);
-		ASSERT(SGIMC_EEPROM_SECLOCK);
-		cmd <<= 1;
-	}
-	DEASSERT(SGIMC_EEPROM_SDATAO);
-	for(i = 0; i < (sizeof(unsigned short) * 8); i++) {
-		unsigned int tmp;
-
-		DEASSERT(SGIMC_EEPROM_SECLOCK);
-		DELAY;
-		ASSERT(SGIMC_EEPROM_SECLOCK);
-		DELAY;
-		data <<= 1;
-		tmp = *cpu_control;
-		if(tmp & SGIMC_EEPROM_SDATAI)
-			data |= 1;
-	}
-	DEASSERT(SGIMC_EEPROM_SECLOCK);
-	DEASSERT(SGIMC_EEPROM_CSEL);
-	ASSERT(SGIMC_EEPROM_PRE);
-	ASSERT(SGIMC_EEPROM_SECLOCK);
-
-	data <<= PAGE_SHIFT;
-	if (data == 0)
+	unsigned long size = ip22_eeprom_read(&sgimc->eeprom, 17);
+	size <<= PAGE_SHIFT;
+	if (size == 0)
 		return 0;
 
-	scache_size = data;
-
 	printk(KERN_INFO "R4600/R5000 SCACHE size %ldK, linesize 32 bytes.\n",
-	       scache_size >> 10);
+	       size >> 10);
+	scache_size = size;
 
 	return 1;
 }
