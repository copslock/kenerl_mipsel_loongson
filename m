Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DDMa107704
	for linux-mips-outgoing; Mon, 13 Aug 2001 06:22:36 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DDMUj07701
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 06:22:31 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA21183;
	Mon, 13 Aug 2001 15:24:25 +0200 (MET DST)
Date: Mon, 13 Aug 2001 15:24:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4.5: Additional DEC memory configuration macros
Message-ID: <Pine.GSO.3.96.1010813151622.18279E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 The following patch adds a few macros for memory configuration for
DECstation 5000/2x0 systems.  Please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010704-dec_memory-0
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-mips/dec/kn02.h linux-mips-2.4.5-20010704/include/asm-mips/dec/kn02.h
--- linux-mips-2.4.5-20010704.macro/include/asm-mips/dec/kn02.h	Wed Jun 27 22:35:33 2001
+++ linux-mips-2.4.5-20010704/include/asm-mips/dec/kn02.h	Sun Aug 12 01:26:09 2001
@@ -28,6 +28,8 @@
 #define KN02_RTC_BASE	KSEG1ADDR(0x1fe80000)
 #define KN02_DZ11_BASE	KSEG1ADDR(0x1fe00000)
 
+#define KN02_CSR_BNK32M	(1<<10)			/* 32M stride */
+
 /*
  * Interrupt enable Bits
  */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-mips/dec/kn03.h linux-mips-2.4.5-20010704/include/asm-mips/dec/kn03.h
--- linux-mips-2.4.5-20010704.macro/include/asm-mips/dec/kn03.h	Wed Jun 27 22:35:33 2001
+++ linux-mips-2.4.5-20010704/include/asm-mips/dec/kn03.h	Sun Aug 12 01:23:20 2001
@@ -24,6 +24,10 @@
  */
 #define KN03_IOASIC_BASE	KSEG1ADDR(0x1f840000)	/* I/O ASIC */
 #define KN03_RTC_BASE		KSEG1ADDR(0x1fa00000)	/* RTC */
+#define KN03_MCR_BASE		KSEG1ADDR(0x1fac0000)	/* MCR */
+
+#define KN03_MCR_BNK32M		(1<<10)			/* 32M stride */
+#define KN03_MCR_ECCEN		(1<<13)			/* ECC enabled */
 
 #define KN03_IOASIC_REG(r)	(KN03_IOASIC_BASE+(r))
 
