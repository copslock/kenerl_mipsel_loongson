Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 10:37:25 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.189]:59854
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225462AbVDRJhI>; Mon, 18 Apr 2005 10:37:08 +0100
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DNSgf-0006UM-00; Mon, 18 Apr 2005 11:37:01 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DNSge-0006Tc-00; Mon, 18 Apr 2005 11:37:01 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] some cleanups for Alchemy processors
Date:	Mon, 18 Apr 2005 11:37:48 +0200
User-Agent: KMail/1.7.2
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504181137.49593.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Changes:
 * use 'unsigned long' as address supplied to au_write[bwl]()
 * remove two already unused and commented structures
 * replace three evil macros used to alias fields of a structure 
   with an anonymous union
 * added an ULL suffix to several address constants that use 
   bits 35-32

cheers

Uli

---
Index: include/asm-mips/mach-au1x00/au1000.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-au1x00/au1000.h,v
retrieving revision 1.16
diff -u -w -r1.16 au1000.h
--- include/asm-mips/mach-au1x00/au1000.h	4 Apr 2005 01:06:20 -0000	1.16
+++ include/asm-mips/mach-au1x00/au1000.h	18 Apr 2005 09:33:57 -0000
@@ -60,19 +60,19 @@
 	mdelay(ms);
 }
 
-void static inline au_writeb(u8 val, int reg)
+void static inline au_writeb(u8 val, unsigned long port)
 {
-	*(volatile u8 *)(reg) = val;
+	*(volatile u8 *)(port) = val;
 }
 
-void static inline au_writew(u16 val, int reg)
+void static inline au_writew(u16 val, unsigned long port)
 {
-	*(volatile u16 *)(reg) = val;
+	*(volatile u16 *)(port) = val;
 }
 
-void static inline au_writel(u32 val, int reg)
+void static inline au_writel(u32 val, unsigned long port)
 {
-	*(volatile u32 *)(reg) = val;
+	*(volatile u32 *)(port) = val;
 }
 
 static inline u8 au_readb(unsigned long port)
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
 
 
@@ -1830,15 +1767,20 @@
 	/* 0x0078 */ u32 slppwr;
 	/* 0x007C */ u32 sleep;
 	/* 0x0080 */ u32 reserved5[32];
-	/* 0x0100 */ u32 trioutrd;
-#define trioutclr trioutrd
+	/* 0x0100 */ union {
+		u32 trioutrd;
+		u32 trioutclr;
+	};
 	/* 0x0104 */ u32 reserved6;
-	/* 0x0108 */ u32 outputrd;
-#define outputset outputrd
+	/* 0x0108 */ union {
+		u32 outputrd;
+		u32 outputset;
+	};
 	/* 0x010C */ u32 outputclr;
-	/* 0x0110 */ u32 pinstaterd;
-#define pininputen pinstaterd
-
+	/* 0x0110 */ union {
+		u32 pinstaterd;
+		u32 pininputen;
+	};
 } AU1X00_SYS;
 
 static AU1X00_SYS* const sys  = (AU1X00_SYS *)SYS_BASE;
