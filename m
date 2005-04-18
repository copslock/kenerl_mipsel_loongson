Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 16:26:48 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.191]:243 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225528AbVDRP0c>; Mon, 18 Apr 2005 16:26:32 +0100
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DNY8t-0000Nw-00
	for linux-mips@linux-mips.org; Mon, 18 Apr 2005 17:26:31 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DNY8s-0000UE-00
	for linux-mips@linux-mips.org; Mon, 18 Apr 2005 17:26:30 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: [patch] some cleanups for Alchemy processors
Date:	Mon, 18 Apr 2005 17:27:21 +0200
User-Agent: KMail/1.7.2
References: <200504181137.49593.eckhardt@satorlaser.com>
In-Reply-To: <200504181137.49593.eckhardt@satorlaser.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504181727.22299.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

OK, here's a new version that fixes the objections raised by Christoph and 
Dan.

Uli


Changes:
 * use 'unsigned long' as address supplied to au_write[bwl]()
 * remove two already unused and commented structures
 * added an ULL suffix to several address constants that use
   bits 35-32

---
Index: include/asm-mips/mach-au1x00/au1000.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-au1x00/au1000.h,v
retrieving revision 1.16
diff -u -r1.16 au1000.h
--- include/asm-mips/mach-au1x00/au1000.h	4 Apr 2005 01:06:20 -0000	1.16
+++ include/asm-mips/mach-au1x00/au1000.h	18 Apr 2005 15:24:38 -0000
@@ -60,34 +60,34 @@
 	mdelay(ms);
 }
 
-void static inline au_writeb(u8 val, int reg)
+void static inline au_writeb(u8 val, unsigned long reg)
 {
 	*(volatile u8 *)(reg) = val;
 }
 
-void static inline au_writew(u16 val, int reg)
+void static inline au_writew(u16 val, unsigned long reg)
 {
 	*(volatile u16 *)(reg) = val;
 }
 
-void static inline au_writel(u32 val, int reg)
+void static inline au_writel(u32 val, unsigned long reg)
 {
 	*(volatile u32 *)(reg) = val;
 }
 
-static inline u8 au_readb(unsigned long port)
+static inline u8 au_readb(unsigned long reg)
 {
-	return (*(volatile u8 *)port);
+	return (*(volatile u8 *)reg);
 }
 
-static inline u16 au_readw(unsigned long port)
+static inline u16 au_readw(unsigned long reg)
 {
-	return (*(volatile u16 *)port);
+	return (*(volatile u16 *)reg);
 }
 
-static inline u32 au_readl(unsigned long port)
+static inline u32 au_readl(unsigned long reg)
 {
-	return (*(volatile u32 *)port);
+	return (*(volatile u32 *)reg);
 }
 
 /* These next three functions should be a generic part of the MIPS
@@ -181,26 +181,6 @@
 #define MEM_SDSLEEP		(0x0030)
 #define MEM_SDSMCKE		(0x0034)
 
-#ifndef ASSEMBLER
-/*typedef volatile struct
-{
-	uint32 sdmode0;
-	uint32 sdmode1;
-	uint32 sdmode2;
-	uint32 sdaddr0;
-	uint32 sdaddr1;
-	uint32 sdaddr2;
-	uint32 sdrefcfg;
-	uint32 sdautoref;
-	uint32 sdwrmd0;
-	uint32 sdwrmd1;
-	uint32 sdwrmd2;
-	uint32 sdsleep;
-	uint32 sdsmcke;
-
-} AU1X00_SDRAM;*/
-#endif
-
 /*
  * MEM_SDMODE register content definitions
  */
@@ -286,49 +266,6 @@
 #define MEM_SDSREF		(0x08D0)
 #define MEM_SDSLEEP		MEM_SDSREF
 
-#ifndef ASSEMBLER
-/*typedef volatile struct
-{
-	uint32 sdmode0;
-	uint32 reserved0;
-	uint32 sdmode1;
-	uint32 reserved1;
-	uint32 sdmode2;
-	uint32 reserved2[3];
-	uint32 sdaddr0;
-	uint32 reserved3;
-	uint32 sdaddr1;
-	uint32 reserved4;
-	uint32 sdaddr2;
-	uint32 reserved5[3];
-	uint32 sdconfiga;
-	uint32 reserved6;
-	uint32 sdconfigb;
-	uint32 reserved7;
-	uint32 sdstat;
-	uint32 reserved8;
-	uint32 sderraddr;
-	uint32 reserved9;
-	uint32 sdstride0;
-	uint32 reserved10;
-	uint32 sdstride1;
-	uint32 reserved11;
-	uint32 sdstride2;
-	uint32 reserved12[3];
-	uint32 sdwrmd0;
-	uint32 reserved13;
-	uint32 sdwrmd1;
-	uint32 reserved14;
-	uint32 sdwrmd2;
-	uint32 reserved15[11];
-	uint32 sdprecmd;
-	uint32 reserved16;
-	uint32 sdautoref;
-	uint32 reserved17;
-	uint32 sdsref;
-
-} AU1550_SDRAM;*/
-#endif
 #endif
 
 /*
@@ -365,9 +302,9 @@
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
 #define	SYS_PHYS_ADDR		0x11900000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000
+#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
 #endif
 
 /********************************************************************/
@@ -399,13 +336,13 @@
 #define	UART3_PHYS_ADDR		0x11400000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
-#define PCI_MEM_PHYS_ADDR     0x400000000
-#define PCI_IO_PHYS_ADDR      0x500000000
-#define PCI_CONFIG0_PHYS_ADDR 0x600000000
-#define PCI_CONFIG1_PHYS_ADDR 0x680000000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000
+#define PCI_MEM_PHYS_ADDR     0x400000000ULL
+#define PCI_IO_PHYS_ADDR      0x500000000ULL
+#define PCI_CONFIG0_PHYS_ADDR 0x600000000ULL
+#define PCI_CONFIG1_PHYS_ADDR 0x680000000ULL
+#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
 #endif
 
 /********************************************************************/
@@ -442,9 +379,9 @@
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
 #define LCD_PHYS_ADDR		0x15000000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000
+#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
 #endif
 
 /***********************************************************************/
@@ -473,13 +410,13 @@
 #define PSC1_PHYS_ADDR	 	0x11B00000
 #define PSC2_PHYS_ADDR	 	0x10A00000
 #define PSC3_PHYS_ADDR	 	0x10B00000
-#define PCI_MEM_PHYS_ADDR     0x400000000
-#define PCI_IO_PHYS_ADDR      0x500000000
-#define PCI_CONFIG0_PHYS_ADDR 0x600000000
-#define PCI_CONFIG1_PHYS_ADDR 0x680000000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000
+#define PCI_MEM_PHYS_ADDR     0x400000000ULL
+#define PCI_IO_PHYS_ADDR      0x500000000ULL
+#define PCI_CONFIG0_PHYS_ADDR 0x600000000ULL
+#define PCI_CONFIG1_PHYS_ADDR 0x680000000ULL
+#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
 #endif
 
 /***********************************************************************/
@@ -500,15 +437,15 @@
 #define	DDMA_PHYS_ADDR		0x14002000
 #define PSC0_PHYS_ADDR	 	0x11A00000
 #define PSC1_PHYS_ADDR	 	0x11B00000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000
 #define SD0_PHYS_ADDR		0x10600000
 #define SD1_PHYS_ADDR		0x10680000
 #define LCD_PHYS_ADDR		0x15000000
 #define SWCNT_PHYS_ADDR		0x1110010C
 #define MAEFE_PHYS_ADDR		0x14012000
 #define MAEBE_PHYS_ADDR		0x14010000
+#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
 #endif
 
 
@@ -1788,7 +1725,7 @@
 #define PCI_IO_START    0
 #define PCI_IO_END      0
 #define PCI_MEM_START   0
-#define PCI_MEM_END     0 
+#define PCI_MEM_END     0
 #define PCI_FIRST_DEVFN 0
 #define PCI_LAST_DEVFN  0
 
