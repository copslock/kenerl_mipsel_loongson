Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 17:33:52 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:40370 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225425AbTIRQdt>;
	Thu, 18 Sep 2003 17:33:49 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A01iy-0005kn-EQ; Thu, 18 Sep 2003 12:33:44 -0400
Date: Thu, 18 Sep 2003 12:33:44 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: ddb5477 fixes for 2.6
Message-ID: <20030918163344.GA22013@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Here's just enough to make the ddb5477 compile and boot.  The defconfig has
lost the onboard network card, and you also need to turn on CONFIG_EMBEDDED
to turn off CONFIG_VT.  Otherwise, conswitchp is uninitialized, causing a
crash.  If I initialize it to &dummy_con, serial consoles stop working
(???).

Userspace doesn't work - lots of scripts segfault, portmap times out, there
are a number of other glitches.  init=/bin/bash hangs.  But at least it's
progress.

I update CFLAGS for gcc 3.3/binutils 2.14.  I think asking people to use
vaguely modern tools for 2.6 is reasonable.  And the old flags don't work
any more.  This should work with 3.2 too.

The PCI and ac97 changes are pretty mindless merge work.

Ralf, this re-adds CONFIG_PCI_AUTO.  Do you know where it went? :)  Probably
a lot of other boards are sad about its disappearance also.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

Index: arch/mips/Kconfig
===================================================================
RCS file: /home/cvs/linux/arch/mips/Kconfig,v
retrieving revision 1.12
diff -u -p -r1.12 Kconfig
--- arch/mips/Kconfig	10 Sep 2003 16:45:49 -0000	1.12
+++ arch/mips/Kconfig	18 Sep 2003 16:25:07 -0000
@@ -726,6 +726,11 @@ config NEW_PCI
 	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
 
+config PCI_AUTO
+	bool
+	depends on DDB5477 || DDB5476
+	default y
+
 config SWAP_IO_SPACE
 	bool
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SIBYTE_SB1xxx_SOC || SGI_IP22 || MOMENCO_OCELOT_C || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_MALTA || MIPS_ATLAS || MIPS_EV96100 || MIPS_PB1100 || MIPS_PB1000
Index: arch/mips/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/Makefile,v
retrieving revision 1.138
diff -u -p -r1.138 Makefile
--- arch/mips/Makefile	3 Sep 2003 15:10:33 -0000	1.138
+++ arch/mips/Makefile	18 Sep 2003 16:25:07 -0000
@@ -104,8 +104,8 @@ cflags-$(CONFIG_CPU_MIPS64)	+= 
 cflags-$(CONFIG_CPU_R5000)	+= -mcpu=r8000
 32bit-isa-$(CONFIG_CPU_R5000)	+= -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R5000)	+= -mips4 -Wa,--trap
-cflags-$(CONFIG_CPU_R5432)	+= -mcpu=r5000
-32bit-isa-$(CONFIG_CPU_R5432)	+= -mips1 -Wa,--trap
+cflags-$(CONFIG_CPU_R5432)	+= -mtune=r5000
+32bit-isa-$(CONFIG_CPU_R5432)	+= -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R5432)	+= -mips3 -Wa,--trap
 cflags-$(CONFIG_CPU_NEVADA)	+= -mcpu=r8000 -mmad
 32bit-isa-$(CONFIG_CPU_NEVADA)	+= -mips2 -Wa,--trap
Index: arch/mips/ddb5xxx/ddb5477/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/ddb5xxx/ddb5477/setup.c,v
retrieving revision 1.17
diff -u -p -r1.17 setup.c
--- arch/mips/ddb5xxx/ddb5477/setup.c	25 Aug 2003 16:15:25 -0000	1.17
+++ arch/mips/ddb5xxx/ddb5477/setup.c	18 Sep 2003 16:25:07 -0000
@@ -142,7 +142,7 @@ static void __init ddb_time_init(void)
 	}
 
 	/* mips_hpt_frequency is 1/2 of the cpu core freq */
-	i =  (read_32bit_cp0_register(CP0_CONFIG) >> 28 ) & 7;
+	i =  (read_c0_config() >> 28 ) & 7;
 	if ((current_cpu_data.cputype == CPU_R5432) && (i == 3)) 
 		i = 4;
 	mips_hpt_frequency = bus_frequency*(i+4)/4;
Index: arch/mips/pci/ops-ddb5477.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pci/ops-ddb5477.c,v
retrieving revision 1.2
diff -u -p -r1.2 ops-ddb5477.c
--- arch/mips/pci/ops-ddb5477.c	13 Jun 2003 14:19:56 -0000	1.2
+++ arch/mips/pci/ops-ddb5477.c	18 Sep 2003 16:25:08 -0000
@@ -127,39 +127,41 @@ static inline void ddb_close_config_base
 }
 
 static int read_config_dword(struct pci_config_swap *swap,
-			     struct pci_bus *bus, u32 where, u32 * val)
+			     struct pci_bus *bus, unsigned int devfn,
+			     u32 where, u32 * val)
 {
-	u32 bus, slot_num, func_num;
+	u32 busno, slot_num, func_num;
 	u32 base;
 
 	db_assert((where & 3) == 0);
 	db_assert(where < (1 << 8));
 
 	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		db_assert(bus != 0);
+	if (bus->parent != NULL) {
+		busno = bus->number;
+		db_assert(busno != 0);
 	} else {
-		bus = 0;
+		busno = 0;
 	}
 
-	slot_num = PCI_SLOT(dev->devfn);
-	func_num = PCI_FUNC(dev->devfn);
-	base = ddb_access_config_base(swap, bus, slot_num);
+	slot_num = PCI_SLOT(devfn);
+	func_num = PCI_FUNC(devfn);
+	base = ddb_access_config_base(swap, busno, slot_num);
 	*val = *(volatile u32 *) (base + (func_num << 8) + where);
 	ddb_close_config_base(swap);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int read_config_word(struct pci_config_swap *swap,
-			    struct pci_bus *bus, u32 where, u16 * val)
+			    struct pci_bus *bus, unsigned int devfn,
+			    u32 where, u16 * val)
 {
 	int status;
 	u32 result;
 
 	db_assert((where & 1) == 0);
 
-	status = read_config_dword(swap, bus, where & ~3, &result);
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
 	if (where & 2)
 		result >>= 16;
 	*val = result & 0xffff;
@@ -168,12 +170,12 @@ static int read_config_word(struct pci_c
 
 static int read_config_byte(struct pci_config_swap *swap,
 			    struct pci_bus *bus, unsigned int devfn,
-			    u8 * val)
+			    unsigned int where, u8 * val)
 {
 	int status;
 	u32 result;
 
-	status = read_config_dword(swap, bus, where & ~3, &result);
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
 	if (where & 1)
 		result >>= 8;
 	if (where & 2)
@@ -185,7 +187,7 @@ static int read_config_byte(struct pci_c
 
 static int write_config_dword(struct pci_config_swap *swap,
 			      struct pci_bus *bus, unsigned int devfn,
-			      u32 val)
+			      unsigned int where, u32 val)
 {
 	u32 busno, slot_num, func_num;
 	u32 base;
@@ -218,7 +220,7 @@ static int write_config_word(struct pci_
 
 	db_assert((where & 1) == 0);
 
-	status = read_config_dword(swap, dev, where & ~3, &result);
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
 	if (status != PCIBIOS_SUCCESSFUL)
 		return status;
 
@@ -226,7 +228,7 @@ static int write_config_word(struct pci_
 		shift += 16;
 	result &= ~(0xffff << shift);
 	result |= val << shift;
-	return write_config_dword(swap, dev, where & ~3, result);
+	return write_config_dword(swap, bus, devfn, where & ~3, result);
 }
 
 static int write_config_byte(struct pci_config_swap *swap,
@@ -236,7 +238,7 @@ static int write_config_byte(struct pci_
 	int status, shift = 0;
 	u32 result;
 
-	status = read_config_dword(swap, dev, where & ~3, &result);
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
 	if (status != PCIBIOS_SUCCESSFUL)
 		return status;
 
@@ -246,28 +248,28 @@ static int write_config_byte(struct pci_
 		shift += 8;
 	result &= ~(0xff << shift);
 	result |= val << shift;
-	return write_config_dword(swap, dev, where & ~3, result);
+	return write_config_dword(swap, bus, devfn, where & ~3, result);
 }
 
 /*
  * Dump solution for now so I don't break hw I can't test on ...
  */
-#define	MAKE_PCI_OPS(prefix, rw, unitname, unittype, pciswap) \
-static int prefix##_##rw##_config(struct pci_bus *bus, int where, int size, unittype val) \
+#define	MAKE_PCI_OPS(prefix, rw, pciswap, star) \
+static int prefix##_##rw##_config(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 star val) \
 { \
 	if (size == 1) \
-     		return rw##_config_byte(pciswap, bus, where, val); \
+     		return rw##_config_byte(pciswap, bus, devfn, where, (u8 star)val); \
 	else if (size == 2) \
-     		return rw##_config_word(pciswap, bus, where, val); \
+     		return rw##_config_word(pciswap, bus, devfn, where, (u16 star)val); \
 	/* Size must be 4 */ \
-     	return rw##_config_dword(pciswap, bus, where, val); \
+     	return rw##_config_dword(pciswap, bus, devfn, where, val); \
 }
 
-MAKE_PCI_OPS(extpci, read, &ext_pci_swap)
-    MAKE_PCI_OPS(extpci, write, &ext_pci_swap)
+MAKE_PCI_OPS(extpci, read, &ext_pci_swap, *)
+MAKE_PCI_OPS(extpci, write, &ext_pci_swap,)
 
-    MAKE_PCI_OPS(iopci, read, &io_pci_swap)
-    MAKE_PCI_OPS(iopci, write, &io_pci_swap)
+MAKE_PCI_OPS(iopci, read, &io_pci_swap, *)
+MAKE_PCI_OPS(iopci, write, &io_pci_swap,)
 
 struct pci_ops ddb5477_ext_pci_ops = {
 	.read = extpci_read_config,
Index: arch/mips/pci/pci.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pci/pci.c,v
retrieving revision 1.3
diff -u -p -r1.3 pci.c
--- arch/mips/pci/pci.c	22 Jun 2003 23:09:48 -0000	1.3
+++ arch/mips/pci/pci.c	18 Sep 2003 16:25:08 -0000
@@ -66,6 +66,8 @@
 extern void pcibios_fixup(void);
 extern void pcibios_fixup_irqs(void);
 
+#if 0
+
 void __init pcibios_fixup_irqs(void)
 {
 	struct pci_dev *dev = NULL;
@@ -126,6 +128,8 @@ void __init pcibios_fixup_resources(stru
 	}
 
 }
+
+#endif
 
 struct pci_fixup pcibios_fixups[] = {
 	{PCI_FIXUP_HEADER, PCI_ANY_ID, PCI_ANY_ID,
Index: include/asm-mips/addrspace.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/addrspace.h,v
retrieving revision 1.11
diff -u -p -r1.11 addrspace.h
--- include/asm-mips/addrspace.h	9 Aug 2003 21:16:38 -0000	1.11
+++ include/asm-mips/addrspace.h	18 Sep 2003 16:25:13 -0000
@@ -75,14 +75,14 @@
  * The compatibility segments use the full 64-bit sign extended value.  Note
  * the R8000 doesn't have them so don't reference these in generic MIPS code.
  */
-#define XKUSEG			0x0000000000000000
-#define XKSSEG			0x4000000000000000
-#define XKPHYS			0x8000000000000000
-#define XKSEG			0xc000000000000000
-#define CKSEG0			0xffffffff80000000
-#define CKSEG1			0xffffffffa0000000
-#define CKSSEG			0xffffffffc0000000
-#define CKSEG3			0xffffffffe0000000
+#define XKUSEG			0x0000000000000000ULL
+#define XKSSEG			0x4000000000000000ULL
+#define XKPHYS			0x8000000000000000ULL
+#define XKSEG			0xc000000000000000ULL
+#define CKSEG0			0xffffffff80000000ULL
+#define CKSEG1			0xffffffffa0000000ULL
+#define CKSSEG			0xffffffffc0000000ULL
+#define CKSEG3			0xffffffffe0000000ULL
 
 /*
  * Cache modes for XKPHYS address conversion macros
Index: include/asm-mips/timex.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/timex.h,v
retrieving revision 1.12
diff -u -p -r1.12 timex.h
--- include/asm-mips/timex.h	20 Aug 2003 16:18:54 -0000	1.12
+++ include/asm-mips/timex.h	18 Sep 2003 16:25:13 -0000
@@ -38,6 +38,8 @@
 #define CLOCK_TICK_RATE		1193182
 #elif defined(CONFIG_SOC_AU1X00)
 #define CLOCK_TICK_RATE         ((HZ * 100000UL) / 2)
+#elif defined(CONFIG_DDB5477)
+#define CLOCK_TICK_RATE		1000000
 #endif
 
 /*
Index: sound/oss/nec_vrc5477.c
===================================================================
RCS file: /home/cvs/linux/sound/oss/nec_vrc5477.c,v
retrieving revision 1.13
diff -u -p -r1.13 nec_vrc5477.c
--- sound/oss/nec_vrc5477.c	9 Sep 2003 16:41:09 -0000	1.13
+++ sound/oss/nec_vrc5477.c	18 Sep 2003 16:25:16 -0000
@@ -8,8 +8,6 @@
  *
  * VRA support Copyright 2001 Bradley D. LaRonde <brad@ltc.com>
  *
- * VRA support Copyright 2001 Bradley D. LaRonde <brad@ltc.com>
- *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -80,6 +78,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/uaccess.h>
@@ -399,44 +398,6 @@ static void set_dac_rate(struct vrc5477_
 	}
 }
 
-static int ac97_codec_not_present(struct ac97_codec *codec)
-{
-	struct vrc5477_ac97_state *s = 
-		(struct vrc5477_ac97_state *)codec->private_data;
-	unsigned long flags;
-	unsigned short count  = 0xffff; 
-
-	spin_lock_irqsave(&s->lock, flags);
-
-	/* wait until we can access codec registers */
-	do {
-	       if (!(inl(s->io + VRC5477_CODEC_WR) & 0x80000000))
-		       break;
-	} while (--count);
-
-	if (count == 0) {
-		spin_unlock_irqrestore(&s->lock, flags);
-		return -1;
-	}
-
-	/* write 0 to reset */
-	outl((AC97_RESET << 16) | 0, s->io + VRC5477_CODEC_WR);
-
-	/* test whether we get a response from ac97 chip */
-	count  = 0xffff; 
-	do { 
-	       if (!(inl(s->io + VRC5477_CODEC_WR) & 0x80000000))
-		       break;
-	} while (--count);
-
-	if (count == 0) {
-		spin_unlock_irqrestore(&s->lock, flags);
-		return -1;
-	}
-	spin_unlock_irqrestore(&s->lock, flags);
-	return 0;
-}
-
 /* --------------------------------------------------------------------- */
 
 extern inline void 
@@ -1901,13 +1862,6 @@ static int __devinit vrc5477_ac97_probe(
 
         }
 
-	/* test if get response from ac97, if not return */
-        if (ac97_codec_not_present(&(s->codec))) {
-		printk(KERN_ERR PFX "no ac97 codec\n");
-		goto err_region;
-
-        }
-
 	if (!request_region(s->io, pci_resource_len(pcidev,0),
 			    VRC5477_AC97_MODULE_NAME)) {
 		printk(KERN_ERR PFX "io ports %#lx->%#lx in use\n",
@@ -2005,7 +1959,7 @@ static int __devinit vrc5477_ac97_probe(
  err_irq:
 	release_region(s->io, pci_resource_len(pcidev,0));
  err_region:
- 	ac97_release_codec(codec);
+ 	ac97_release_codec(s->codec);
 	kfree(s);
 	return -1;
 }
