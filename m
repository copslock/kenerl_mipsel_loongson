Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2003 21:32:50 +0100 (BST)
Received: from p0329.as-l042.contactel.cz ([IPv6:::ffff:194.108.238.75]:1028
	"EHLO kopretinka") by linux-mips.org with ESMTP id <S8225226AbTEGUcL>;
	Wed, 7 May 2003 21:32:11 +0100
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 19DVN9-00009x-00; Wed, 07 May 2003 22:18:39 +0200
Date: Wed, 7 May 2003 22:18:39 +0200
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] implement NVRAM access for Indy
Message-ID: <20030507201839.GA598@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips


This patch brings you access to NVRAM chips and serial EEPROMs. Next
posts will show how useful it can be (not mentioning /proc interface to
PROM variables i'm going to implement :))

generated for 2.4 version. i'll generate 2.5 version if anyone is
interested...


diff -Naur linux_2_4/arch/mips/sgi-ip22/Makefile linux_2_4-fucked/arch/mips/sgi-ip22/Makefile
--- linux_2_4/arch/mips/sgi-ip22/Makefile	Tue May  6 03:20:28 2003
+++ linux_2_4-fucked/arch/mips/sgi-ip22/Makefile	Wed May  7 19:55:29 2003
@@ -14,8 +14,8 @@
 
 export-objs	:= ip22-ksyms.o
 obj-y		+= ip22-mc.o ip22-hpc.o ip22-int.o ip22-irq.o ip22-berr.o \
-		   ip22-time.o ip22-rtc.o ip22-reset.o ip22-system.o \
-		   ip22-setup.o ip22-ksyms.o
+		   ip22-time.o ip22-rtc.o ip22-nvram.o ip22-reset.o \
+		   ip22-system.o ip22-setup.o ip22-ksyms.o
 
 obj-$(CONFIG_IP22_EISA)		+= ip22-eisa.o
 
diff -Naur linux_2_4/arch/mips/sgi-ip22/ip22-ksyms.c linux_2_4-fucked/arch/mips/sgi-ip22/ip22-ksyms.c
--- linux_2_4/arch/mips/sgi-ip22/ip22-ksyms.c	Tue May  6 03:20:49 2003
+++ linux_2_4-fucked/arch/mips/sgi-ip22/ip22-ksyms.c	Wed May  7 19:55:30 2003
@@ -7,6 +7,7 @@
 #include <asm/sgi/mc.h>
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ioc.h>
+#include <asm/sgi/ip22.h>
 
 EXPORT_SYMBOL(sgimc);
 EXPORT_SYMBOL(hpc3c0);
@@ -14,5 +15,7 @@
 EXPORT_SYMBOL(sgioc);
 
 extern void (*indy_volume_button)(int);
-
 EXPORT_SYMBOL(indy_volume_button);
+
+EXPORT_SYMBOL(ip22_eeprom_read);
+EXPORT_SYMBOL(ip22_nvram_read);
diff -Naur linux_2_4/arch/mips/sgi-ip22/ip22-nvram.c linux_2_4-fucked/arch/mips/sgi-ip22/ip22-nvram.c
--- linux_2_4/arch/mips/sgi-ip22/ip22-nvram.c	Thu Jan  1 01:00:00 1970
+++ linux_2_4-fucked/arch/mips/sgi-ip22/ip22-nvram.c	Wed May  7 21:31:32 2003
@@ -0,0 +1,114 @@
+/*
+ * ip22-nvram.c: NVRAM and serial EEPROM handling.
+ *
+ * Copyright (C) 2003 Ladislav Michl (ladis@linux-mips.org)
+ */
+
+#include <asm/sgi/hpc3.h>
+#include <asm/sgi/ip22.h>
+
+/* Control opcode for serial eeprom  */
+#define EEPROM_READ	0xc000	/* serial memory read */
+#define EEPROM_WEN	0x9800	/* write enable before prog modes */
+#define EEPROM_WRITE	0xa000	/* serial memory write */
+#define EEPROM_WRALL	0x8800	/* write all registers */
+#define EEPROM_WDS	0x8000	/* disable all programming */
+#define	EEPROM_PRREAD	0xc000	/* read protect register */
+#define	EEPROM_PREN	0x9800	/* enable protect register mode */
+#define	EEPROM_PRCLEAR	0xffff	/* clear protect register */
+#define	EEPROM_PRWRITE	0xa000	/* write protect register */
+#define	EEPROM_PRDS	0x8000	/* disable protect register, forever */
+
+#define EEPROM_EPROT	0x01	/* Protect register enable */
+#define EEPROM_CSEL	0x02	/* Chip select */
+#define EEPROM_ECLK	0x04	/* EEPROM clock */
+#define EEPROM_DATO	0x08	/* Data out */
+#define EEPROM_DATI	0x10	/* Data in */
+
+/* We need to use this functions early... */
+#define delay()	({						\
+	int x;							\
+	for (x=0; x<100000; x++) __asm__ __volatile__(""); })
+
+#define eeprom_cs_on(ptr) ({	\
+	*ptr &= ~EEPROM_DATO;	\
+	*ptr &= ~EEPROM_ECLK;	\
+	*ptr &= ~EEPROM_EPROT;	\
+	delay();		\
+	*ptr |= EEPROM_CSEL;	\
+	*ptr |= EEPROM_ECLK; })
+
+		
+#define eeprom_cs_off(ptr) ({	\
+	*ptr &= ~EEPROM_ECLK;	\
+	*ptr &= ~EEPROM_CSEL;	\
+	*ptr |= EEPROM_EPROT;	\
+	*ptr |= EEPROM_ECLK; })
+
+#define	BITS_IN_COMMAND	11
+/*
+ * clock in the nvram command and the register number. For the
+ * national semiconductor nv ram chip the op code is 3 bits and
+ * the address is 6/8 bits. 
+ */
+static inline void eeprom_cmd(volatile unsigned int *ctrl, unsigned cmd,
+			      unsigned reg)
+{
+	unsigned short ser_cmd;
+	int i;
+
+	ser_cmd = cmd | (reg << (16 - BITS_IN_COMMAND));
+	for (i = 0; i < BITS_IN_COMMAND; i++) {
+		if (ser_cmd & (1<<15))	/* if high order bit set */
+			*ctrl |= EEPROM_DATO;
+		else
+			*ctrl &= ~EEPROM_DATO;
+		*ctrl &= ~EEPROM_ECLK;
+		*ctrl |= EEPROM_ECLK;
+		ser_cmd <<= 1;
+	}
+	*ctrl &= ~EEPROM_DATO;	/* see data sheet timing diagram */
+}
+
+unsigned short ip22_eeprom_read(volatile unsigned int *ctrl, int reg)
+{
+	unsigned short res = 0;
+	int i;
+
+	*ctrl &= ~EEPROM_EPROT;
+	eeprom_cs_on(ctrl);
+	eeprom_cmd(ctrl, EEPROM_READ, reg);
+
+	/* clock the data ouf of serial mem */
+	for (i = 0; i < 16; i++) {
+		*ctrl &= ~EEPROM_ECLK;
+		delay();
+		*ctrl |= EEPROM_ECLK;
+		delay();
+		res <<= 1;
+		if (*ctrl & EEPROM_DATI)
+			res |= 1;
+	}
+		
+	eeprom_cs_off(ctrl);
+
+	return res;
+}
+
+/*
+ * Read specified register from main NVRAM
+ */
+unsigned short ip22_nvram_read(int reg)
+{
+	if (ip22_is_fullhouse())
+		/* IP22 (Indigo2 aka FullHouse) stores env variables into
+		 * 93CS56 Microwire Bus EEPROM 2048 Bit (128x16) */
+		return ip22_eeprom_read(&hpc3c0->eeprom, reg);
+	else {
+		unsigned short tmp;
+		/* IP24 (Indy aka Guiness) uses DS1386 8K version */
+		reg = 2 * reg + 64;
+		tmp = hpc3c0->bbram[reg++] & 0xff;
+		return (tmp << 8) | (hpc3c0->bbram[reg] & 0xff);
+	}		
+}
diff -Naur linux_2_4/arch/mips/sgi-ip22/ip22-rtc.c linux_2_4-fucked/arch/mips/sgi-ip22/ip22-rtc.c
--- linux_2_4/arch/mips/sgi-ip22/ip22-rtc.c	Tue May  6 03:20:49 2003
+++ linux_2_4-fucked/arch/mips/sgi-ip22/ip22-rtc.c	Wed May  7 19:55:30 2003
@@ -8,20 +8,16 @@
  * Copyright (C) 1998, 2001 by Ralf Baechle
  */
 #include <asm/ds1286.h>
-#include <asm/sgi/ip22.h>
+#include <asm/sgi/hpc3.h>
 
 static unsigned char ip22_rtc_read_data(unsigned long addr)
 {
-	volatile unsigned int *rtcregs = (void *)IP22_CLOCK_REGS;
-
-	return rtcregs[addr];
+	return hpc3c0->rtcregs[addr];
 }
 
 static void ip22_rtc_write_data(unsigned char data, unsigned long addr)
 {
-	volatile unsigned int *rtcregs = (void *)IP22_CLOCK_REGS;
-
-	rtcregs[addr] = data;
+	hpc3c0->rtcregs[addr] = data;
 }
 
 static int ip22_rtc_bcd_mode(void)
diff -Naur linux_2_4/include/asm-mips/sgi/hpc3.h linux_2_4-fucked/include/asm-mips/sgi/hpc3.h
--- linux_2_4/include/asm-mips/sgi/hpc3.h	Tue May  6 03:21:22 2003
+++ linux_2_4-fucked/include/asm-mips/sgi/hpc3.h	Wed May  7 21:20:17 2003
@@ -206,7 +206,7 @@
 #define HPC3_GIOMISC_ERTIME	0x1	/* Enable external timer real time. */
 #define HPC3_GIOMISC_DENDIAN	0x2	/* dma descriptor endian, 1=lit 0=big */
 
-	volatile u32 eeprom_data;	/* EEPROM data reg. */
+	volatile u32 eeprom;		/* EEPROM data reg. */
 #define HPC3_EEPROM_EPROT	0x01	/* Protect register enable */
 #define HPC3_EEPROM_CSEL	0x02	/* Chip select */
 #define HPC3_EEPROM_ECLK	0x04	/* EEPROM clock */
@@ -298,7 +298,10 @@
 #define HPC3_PROM_STAT	0x1	/* General purpose status bit in gout */
 
 	u32 _unused7[0x1000/4 - 1];
-	volatile u32 pbus_promram[16384];	/* 64k of PROM battery backed ram */
+	union {
+		volatile u32 bbram[8192];	/* Battery backed ram */
+		volatile u32 rtcregs[14];	/* Dallas clock registers */
+	};
 };
 
 /* 
diff -Naur linux_2_4/include/asm-mips/sgi/ip22.h linux_2_4-fucked/include/asm-mips/sgi/ip22.h
--- linux_2_4/include/asm-mips/sgi/ip22.h	Tue May  6 03:21:24 2003
+++ linux_2_4-fucked/include/asm-mips/sgi/ip22.h	Wed May  7 20:00:31 2003
@@ -71,6 +71,7 @@
 
 #define ip22_is_fullhouse()	(sgioc->sysid & SGIOC_SYSID_FULLHOUSE)
 
-#define IP22_CLOCK_REGS (KSEG1ADDR(0x1fbe0000))
+extern unsigned short ip22_eeprom_read(volatile unsigned int *ctrl, int reg);
+extern unsigned short ip22_nvram_read(int reg);
 
 #endif
diff -Naur linux_2_4/include/asm-mips64/sgi/hpc3.h linux_2_4-fucked/include/asm-mips64/sgi/hpc3.h
--- linux_2_4/include/asm-mips64/sgi/hpc3.h	Tue May  6 03:21:28 2003
+++ linux_2_4-fucked/include/asm-mips64/sgi/hpc3.h	Wed May  7 21:46:08 2003
@@ -206,7 +206,7 @@
 #define HPC3_GIOMISC_ERTIME	0x1	/* Enable external timer real time. */
 #define HPC3_GIOMISC_DENDIAN	0x2	/* dma descriptor endian, 1=lit 0=big */
 
-	volatile u32 eeprom_data;	/* EEPROM data reg. */
+	volatile u32 eeprom;		/* EEPROM data reg. */
 #define HPC3_EEPROM_EPROT	0x01	/* Protect register enable */
 #define HPC3_EEPROM_CSEL	0x02	/* Chip select */
 #define HPC3_EEPROM_ECLK	0x04	/* EEPROM clock */
@@ -298,7 +298,10 @@
 #define HPC3_PROM_STAT	0x1	/* General purpose status bit in gout */
 
 	u32 _unused7[0x1000/4 - 1];
-	volatile u32 pbus_promram[16384];	/* 64k of PROM battery backed ram */
+	union {
+		volatile u32 bbram[8192];	/* Battery backed ram */
+		volatile u32 rtcregs[14];	/* Dallas clock registers */
+	};
 };
 
 /* 
diff -Naur linux_2_4/include/asm-mips64/sgi/ip22.h linux_2_4-fucked/include/asm-mips64/sgi/ip22.h
--- linux_2_4/include/asm-mips64/sgi/ip22.h	Tue May  6 03:21:30 2003
+++ linux_2_4-fucked/include/asm-mips64/sgi/ip22.h	Wed May  7 19:55:29 2003
@@ -6,7 +6,7 @@
  * ip22.h: Definitions for SGI IP22 machines
  *
  * Copyright (C) 1996 David S. Miller
- * Copyright (C) 1997, 1999, 2000 Ralf Baechle
+ * Copyright (C) 1997, 1998, 1999, 2000 Ralf Baechle
  */
 
 #ifndef _SGI_IP22_H
@@ -71,6 +71,7 @@
 
 #define ip22_is_fullhouse()	(sgioc->sysid & SGIOC_SYSID_FULLHOUSE)
 
-#define IP22_CLOCK_REGS (KSEG1ADDR(0x1fbe0000))
+extern unsigned short ip22_eeprom_read(volatile unsigned int *ctrl, int reg);
+extern unsigned short ip22_nvram_read(int reg);
 
 #endif
