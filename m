Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 08:54:30 +0100 (BST)
Received: from ftp.ckdenergo.cz ([IPv6:::ffff:80.95.97.155]:14579 "EHLO simek")
	by linux-mips.org with ESMTP id <S8224861AbTENHy2>;
	Wed, 14 May 2003 08:54:28 +0100
Received: from ladis by simek with local (Exim 3.36 #1 (Debian))
	id 19Fr5C-0001EN-00; Wed, 14 May 2003 09:53:50 +0200
Date: Wed, 14 May 2003 09:53:40 +0200
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] High memory detection for Indigo2
Message-ID: <20030514075340.GA4710@simek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi,

this is second version of high memory detection for Indigo2.
It will allow to use more that 256M RAM. I was told by Ralf that
CONFIG_HIGHMEM is broken for I2, so you'll need to build 64bit
kernel to use it (I was also told there is more bugs related to
high memory support and I think that once high memory is detected
properly more people will be interested in hunting those bugs :))
Patch also completely replaces ARCS based memory detection by
memory controller based one. We need to read memory configuration
from MC anyway, so this will make kernel a bit smaller.


Index: arch/mips/sgi-ip22/ip22-mc.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-mc.c,v
retrieving revision 1.1.2.7
diff -u -r1.1.2.7 ip22-mc.c
--- arch/mips/sgi-ip22/ip22-mc.c	6 Apr 2003 01:47:27 -0000	1.1.2.7
+++ arch/mips/sgi-ip22/ip22-mc.c	14 May 2003 07:37:53 -0000
@@ -1,51 +1,111 @@
 /*
- * ip22-mc.c: Routines for manipulating the INDY memory controller.
+ * ip22-mc.c: Routines for manipulating SGI Memory Controller.
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1999 Andrew R. Baker (andrewb@uab.edu) - Indigo2 changes
+ * Copyright (C) 2003 Ladislav Michl  (ladis@linux-mips.org)
  */
 
 #include <linux/init.h>
 #include <linux/kernel.h>
 
 #include <asm/addrspace.h>
+#include <asm/bootinfo.h>
 #include <asm/ptrace.h>
 #include <asm/sgialib.h>
 #include <asm/sgi/mc.h>
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ip22.h>
 
-/* #define DEBUG_SGIMC */
-
 struct sgimc_regs *sgimc;
 
-#ifdef DEBUG_SGIMC
-static inline char *mconfig_string(unsigned long val)
+static inline unsigned int get_bank_size(unsigned int val)
 {
 	switch(val & SGIMC_MCONFIG_RMASK) {
-	case SGIMC_MCONFIG_FOURMB:
-		return "4MB";
-
-	case SGIMC_MCONFIG_EIGHTMB:
-		return "8MB";
+	case SGIMC_MCONFIG_256K: return 4*4*256 * 1024;
+	case SGIMC_MCONFIG_512K: return 4*4*512 * 1024;
+	case SGIMC_MCONFIG_1M:   return 4*4*1024 * 1024;
+	case SGIMC_MCONFIG_2M:   return 4*4*2048 * 1024;
+	case SGIMC_MCONFIG_4M:   return 4*4*4096 * 1024;
+	case SGIMC_MCONFIG_8M:   return 4*4*8192 * 1024;
+	default:                 return 0;
+	}
+}
 
-	case SGIMC_MCONFIG_SXTEENMB:
-		return "16MB";
+static inline unsigned int get_bank_config(int bank)
+{
+	unsigned int res = bank > 1 ? sgimc->mconfig1 : sgimc->mconfig0;
+	return bank % 2 ? res & 0xffff : res >> 16;
+}
 
-	case SGIMC_MCONFIG_TTWOMB:
-		return "32MB";
+struct mem {
+	unsigned long addr;
+	unsigned long size;
+};
 
-	case SGIMC_MCONFIG_SFOURMB:
-		return "64MB";
+/*
+ * Detect installed memory, do some sanity checks and notify kernel about it
+ */
+static void probe_memory(void)
+{
+	int i, j, found, cnt = 0;
+	struct mem bank[4];
+	struct mem space[2] = {{SGIMC_SEG0_BADDR, 0}, {SGIMC_SEG1_BADDR, 0}};
+
+	printk(KERN_INFO "MC: Probing memory configuration:\n");
+	for (i = 0; i < ARRAY_SIZE(bank); i++) {
+		int tmp = get_bank_config(i);
+		if (!(tmp & SGIMC_MCONFIG_BVALID))
+			continue;
+
+		if (!(bank[cnt].size = get_bank_size(tmp))) {
+			printk(KERN_WARNING " bank%d: unknown, ignored\n", i);
+			continue;
+		}
 
-	case SGIMC_MCONFIG_OTEIGHTMB:
-		return "128MB";
+		bank[cnt].addr = (tmp & SGIMC_MCONFIG_BASEADDR) << 22;
+		printk(KERN_INFO " bank%d: %3ldM @ %08lx\n",
+			i, bank[cnt].size / 1024 / 1024, bank[cnt].addr);
+		cnt++;
+	}
 
-	default:
-		return "wheee, unknown";
+	/* And you thought bubble sort is dead algorithm... */
+	do {
+		unsigned long addr, size;
+
+		found = 0;
+		for (i = 1; i < cnt; i++)
+			if (bank[i-1].addr > bank[i].addr) {
+				addr = bank[i].addr;
+				size = bank[i].size;
+				bank[i].addr = bank[i-1].addr;
+				bank[i].size = bank[i-1].size;
+				bank[i-1].addr = addr;
+				bank[i-1].size = size;
+				found = 1;
+			}
+	} while (found);
+
+	/* Figure out how are memory banks mapped into spaces */
+	for (i = 0; i < cnt; i++) {
+		found = 0;
+		for (j = 0; j < ARRAY_SIZE(space) && !found; j++)
+			if (space[j].addr + space[j].size == bank[i].addr) {
+				space[j].size += bank[i].size;
+				found = 1;
+			}
+		/* There is either hole or overlapping memory */
+		if (!found)
+			printk(KERN_CRIT "MC: Memory configuration mismatch "
+					 "(%08lx), expect Bus Error soon\n",
+					 bank[i].addr);
 	}
+
+	for (i = 0; i < ARRAY_SIZE(space); i++)
+		if (space[i].size)
+			add_memory_region(space[i].addr, space[i].size,
+					  BOOT_MEM_RAM);
 }
-#endif
 
 void __init sgimc_init(void)
 {
@@ -56,17 +116,6 @@
 	printk(KERN_INFO "MC: SGI memory controller Revision %d\n",
 	       (int) sgimc->systemid & SGIMC_SYSID_MASKREV);
 
-#ifdef DEBUG_SGIMC
-	prom_printf("sgimc_init: memconfig0<%s> mconfig1<%s>\n",
-		    mconfig_string(sgimc->mconfig0),
-		    mconfig_string(sgimc->mconfig1));
-
-	prom_printf("mcdump: cpuctrl0<%08lx> cpuctrl1<%08lx>\n",
-		    sgimc->cpuctrl0, sgimc->cpuctrl1);
-	prom_printf("mcdump: divider<%08lx>, gioparm<%04x>\n",
-		    sgimc->divider, sgimc->gioparm);
-#endif
-
 	/* Place the MC into a known state.  This must be done before
 	 * interrupts are first enabled etc.
 	 */
@@ -126,27 +175,32 @@
 	 */
 
 	/* First the basic invariants across all GIO64 implementations. */
-	tmp = SGIMC_GIOPAR_HPC64;    /* All 1st HPC's interface at 64bits. */
-	tmp |= SGIMC_GIOPAR_ONEBUS;  /* Only one physical GIO bus exists. */
+	tmp = SGIMC_GIOPAR_HPC64;	/* All 1st HPC's interface at 64bits */
+	tmp |= SGIMC_GIOPAR_ONEBUS;	/* Only one physical GIO bus exists */
 
 	if (ip22_is_fullhouse()) {
 		/* Fullhouse specific settings. */
 		if (SGIOC_SYSID_BOARDREV(sgioc->sysid) < 2) {
-			tmp |= SGIMC_GIOPAR_HPC264; /* 2nd HPC at 64bits */
-			tmp |= SGIMC_GIOPAR_PLINEEXP0; /* exp0 pipelines */
-			tmp |= SGIMC_GIOPAR_MASTEREXP1;/* exp1 masters */
-			tmp |= SGIMC_GIOPAR_RTIMEEXP0; /* exp0 is realtime */
+			tmp |= SGIMC_GIOPAR_HPC264;	/* 2nd HPC at 64bits */
+			tmp |= SGIMC_GIOPAR_PLINEEXP0;	/* exp0 pipelines */
+			tmp |= SGIMC_GIOPAR_MASTEREXP1;	/* exp1 masters */
+			tmp |= SGIMC_GIOPAR_RTIMEEXP0;	/* exp0 is realtime */
 		} else {
-			tmp |= SGIMC_GIOPAR_HPC264; /* 2nd HPC 64bits */
-			tmp |= SGIMC_GIOPAR_PLINEEXP0; /* exp[01] pipelined */
+			tmp |= SGIMC_GIOPAR_HPC264;	/* 2nd HPC 64bits */
+			tmp |= SGIMC_GIOPAR_PLINEEXP0;	/* exp[01] pipelined */
 			tmp |= SGIMC_GIOPAR_PLINEEXP1;
-			tmp |= SGIMC_GIOPAR_MASTEREISA;/* EISA masters */
-			tmp |= SGIMC_GIOPAR_GFX64; 	/* GFX at 64 bits */
+			tmp |= SGIMC_GIOPAR_MASTEREISA;	/* EISA masters */
+			tmp |= SGIMC_GIOPAR_GFX64;	/* GFX at 64 bits */
 		}
 	} else {
 		/* Guiness specific settings. */
-		tmp |= SGIMC_GIOPAR_EISA64;     /* MC talks to EISA at 64bits */
-		tmp |= SGIMC_GIOPAR_MASTEREISA; /* EISA bus can act as master */
+		tmp |= SGIMC_GIOPAR_EISA64;	/* MC talks to EISA at 64bits */
+		tmp |= SGIMC_GIOPAR_MASTEREISA;	/* EISA bus can act as master */
 	}
-	sgimc->giopar = tmp; /* poof */
+	sgimc->giopar = tmp;	/* poof */
+
+	probe_memory();
 }
+
+void __init prom_meminit(void) {}
+void __init prom_free_prom_memory (void) {}
Index: arch/mips/config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
retrieving revision 1.1.2.59
diff -u -r1.1.2.59 config-shared.in
--- arch/mips/config-shared.in	5 May 2003 07:50:48 -0000	1.1.2.59
+++ arch/mips/config-shared.in	14 May 2003 07:37:53 -0000
@@ -481,7 +481,6 @@
 fi
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    define_bool CONFIG_ARC32 y
-   define_bool CONFIG_ARC_MEMORY y
    define_bool CONFIG_ARC_PROMLIB y
    define_bool CONFIG_BOARD_SCACHE y
    define_bool CONFIG_BOOT_ELF32 y
Index: include/asm-mips/sgi/mc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/sgi/mc.h,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 mc.h
--- include/asm-mips/sgi/mc.h	27 Apr 2003 22:25:28 -0000	1.1.2.2
+++ include/asm-mips/sgi/mc.h	14 May 2003 07:37:53 -0000
@@ -95,19 +95,22 @@
 	u32 _unused10[3];
 	volatile u32 lbursttp;	/* Time period for long bursts */
 
+	/* MC chip can drive up to 4 bank 4 SIMMs each. All SIMMs in bank must
+	 * be the same size. The size encoding for supported SIMMs is bellow */
 	u32 _unused11[9];
 	volatile u32 mconfig0;	/* Memory config register zero */
 	u32 _unused12;
 	volatile u32 mconfig1;	/* Memory config register one */
-
-	/* These defines apply to both mconfig registers above. */
-#define SGIMC_MCONFIG_FOURMB	0x00000000 /* Physical ram = 4megs */
-#define SGIMC_MCONFIG_EIGHTMB	0x00000100 /* Physical ram = 8megs */
-#define SGIMC_MCONFIG_SXTEENMB	0x00000300 /* Physical ram = 16megs */
-#define SGIMC_MCONFIG_TTWOMB	0x00000700 /* Physical ram = 32megs */
-#define SGIMC_MCONFIG_SFOURMB	0x00000f00 /* Physical ram = 64megs */
-#define SGIMC_MCONFIG_OTEIGHTMB	0x00001f00 /* Physical ram = 128megs */
+#define SGIMC_MCONFIG_BASEADDR	0x000000ff /* Base address of bank*/
+#define SGIMC_MCONFIG_256K	0x00000000 /* 256k x 36 bits */
+#define SGIMC_MCONFIG_512K	0x00000100 /* 512k x 36 bits, 2 subbanks */
+#define SGIMC_MCONFIG_1M	0x00000300 /* 1M   x 36 bits */
+#define SGIMC_MCONFIG_2M	0x00000700 /* 2M   x 36 bits, 2 subbanks */
+#define SGIMC_MCONFIG_4M	0x00000f00 /* 4M   x 36 bits */
+#define SGIMC_MCONFIG_8M	0x00001f00 /* 8M   x 36 bits, 2 subbanks */
 #define SGIMC_MCONFIG_RMASK	0x00001f00 /* Ram config bitmask */
+#define SGIMC_MCONFIG_BVALID	0x00002000 /* Bank is valid */
+#define SGIMC_MCONFIG_SBANKS	0x00004000 /* Number of subbanks */
 
 	u32 _unused13;
 	volatile u32 cmacc;        /* Mem access config for CPU */
Index: include/asm-mips64/sgi/mc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/sgi/mc.h,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 mc.h
--- include/asm-mips64/sgi/mc.h	27 Apr 2003 22:25:28 -0000	1.1.2.2
+++ include/asm-mips64/sgi/mc.h	14 May 2003 07:37:53 -0000
@@ -95,19 +95,22 @@
 	u32 _unused10[3];
 	volatile u32 lbursttp;	/* Time period for long bursts */
 
+	/* MC chip can drive up to 4 bank 4 SIMMs each. All SIMMs in bank must
+	 * be the same size. The size encoding for supported SIMMs is bellow */
 	u32 _unused11[9];
 	volatile u32 mconfig0;	/* Memory config register zero */
 	u32 _unused12;
 	volatile u32 mconfig1;	/* Memory config register one */
-
-	/* These defines apply to both mconfig registers above. */
-#define SGIMC_MCONFIG_FOURMB	0x00000000 /* Physical ram = 4megs */
-#define SGIMC_MCONFIG_EIGHTMB	0x00000100 /* Physical ram = 8megs */
-#define SGIMC_MCONFIG_SXTEENMB	0x00000300 /* Physical ram = 16megs */
-#define SGIMC_MCONFIG_TTWOMB	0x00000700 /* Physical ram = 32megs */
-#define SGIMC_MCONFIG_SFOURMB	0x00000f00 /* Physical ram = 64megs */
-#define SGIMC_MCONFIG_OTEIGHTMB	0x00001f00 /* Physical ram = 128megs */
+#define SGIMC_MCONFIG_BASEADDR	0x000000ff /* Base address of bank*/
+#define SGIMC_MCONFIG_256K	0x00000000 /* 256k x 36 bits */
+#define SGIMC_MCONFIG_512K	0x00000100 /* 512k x 36 bits, 2 subbanks */
+#define SGIMC_MCONFIG_1M	0x00000300 /* 1M   x 36 bits */
+#define SGIMC_MCONFIG_2M	0x00000700 /* 2M   x 36 bits, 2 subbanks */
+#define SGIMC_MCONFIG_4M	0x00000f00 /* 4M   x 36 bits */
+#define SGIMC_MCONFIG_8M	0x00001f00 /* 8M   x 36 bits, 2 subbanks */
 #define SGIMC_MCONFIG_RMASK	0x00001f00 /* Ram config bitmask */
+#define SGIMC_MCONFIG_BVALID	0x00002000 /* Bank is valid */
+#define SGIMC_MCONFIG_SBANKS	0x00004000 /* Number of subbanks */
 
 	u32 _unused13;
 	volatile u32 cmacc;        /* Mem access config for CPU */
