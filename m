Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 12:21:47 +0000 (GMT)
Received: from erebor.lep.brno.cas.cz ([IPv6:::ffff:195.178.65.162]:40972 "EHLO
	erebor.lep.brno.cas.cz") by linux-mips.org with ESMTP
	id <S8225970AbTAHMVq>; Wed, 8 Jan 2003 12:21:46 +0000
Received: from ladis by erebor.lep.brno.cas.cz with local (Exim 3.12 #1 (Debian))
	id 18WFLZ-0004nO-00; Wed, 08 Jan 2003 13:30:13 +0100
Date: Wed, 8 Jan 2003 13:30:13 +0100
To: linux-mips <linux-mips@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>
Subject: Remove GIO interface
Message-ID: <20030108133013.A17162@erebor.psi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Ladislav Michl <ladis@psi.cz>
Return-Path: <ladis@psi.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@psi.cz
Precedence: bulk
X-list: linux-mips

Hi,

after many tests I decided to remove GIO interface from kernel...

Reasons:
* Due to hardware setup it is not possible to determine device in GFX slot.
  Even more it's not possible to say if there is any. (gio.ps Lie #1)
* Newport XL nor XZ doesn't provide GIO product identification word. In fact
  Newport is simply mapped from SLOT_BASE + 0xf0000. (gio.ps Lie #2)
* Even in case everything work as stated in documentation, we are unable
  to use this mechanism to detect Newport for console driver (the main
  reason why I created this interface was to provide neccessary
  informations to Xserver), because our DBE handling doesn't work until
  modules are initialized (in case we are building kernel with modules
  support).

Because we have only three (two on Indigo) slots and each type of device
can be located only in one (rarely two possitions), drivers will use
get_dbe for device probing (see my next post).

I think now is time to eat humble pie for my stupidity, I'll no more trust
any documentation and will always verify facts. I'm sorry.

	ladis

Index: include/asm-mips/sgi/sgigio.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/sgi/sgigio.h,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 sgigio.h
--- include/asm-mips/sgi/sgigio.h	5 Aug 2002 23:53:38 -0000	1.1.2.2
+++ include/asm-mips/sgi/sgigio.h	8 Jan 2003 11:10:37 -0000
@@ -12,6 +12,11 @@
 #define _ASM_SGI_SGIGIO_H
 
 /*
+ * GIO bus addresses
+ *
+ * The Indigo and Indy have two GIO bus connectors. Indigo2 (all models) have
+ * three physical connectors, but only two slots, GFX and EXP0.
+ * 
  * There is 10MB of GIO address space for GIO64 slot devices
  * slot#   slot type address range            size
  * -----   --------- ----------------------- -----
@@ -26,44 +31,56 @@
  * Following space is reserved and unused
  *   -     RESERVED  0x18000000 - 0x1effffff 112MB
  *
- * The GIO specification tends to use slot numbers while the MC specification
- * tends to use slot types.
+ * GIO bus IDs
+ *
+ * Each GIO bus device identifies itself to the system by answering a
+ * read with an "ID" value. IDs are either 8 or 32 bits long. IDs less
+ * than 128 are 8 bits long, with the most significant 24 bits read from
+ * the slot undefined.
+ *
+ * 32-bit IDs are divided into
+ *	bits 0:6        the product ID; ranges from 0x00 to 0x7F.
+ *	bit 7		0=GIO Product ID is 8 bits wide
+ *			1=GIO Product ID is 32 bits wide.
+ *	bits 8:15       manufacturer version for the product.
+ *	bit 16		0=GIO32 and GIO32-bis, 1=GIO64.
+ *	bit 17		0=no ROM present
+ *			1=ROM present on this board AND next three words
+ *			space define the ROM.
+ *	bits 18:31	up to manufacturer.
+ *
+ * IDs above 0x50/0xd0 are of 3rd party boards.
+ *
+ * 8-bit IDs
+ *	0x01		XPI low cost FDDI
+ *	0x02		GTR TokenRing
+ *	0x04		Synchronous ISDN
+ *	0x05		ATM board [*]
+ *	0x06		Canon Interface
+ *	0x07		16 bit SCSI Card [*]
+ *	0x08		JPEG (Double Wide)
+ *	0x09		JPEG (Single Wide)
+ *	0x0a		XPI mez. FDDI device 0
+ *	0x0b		XPI mez. FDDI device 1
+ *	0x0c		SMPTE 259M Video [*]
+ *	0x0d		Babblefish Compression [*]
+ *	0x0e		E-Plex 8-port Ethernet
+ *	0x30		Lyon Lamb IVAS
+ *	0xb8		GIO 100BaseTX Fast Ethernet (gfe)
+ *
+ * [*] Device provide 32-bit ID.
  *
- * slot0  - the "graphics" (GFX) slot but there is no requirement that
- *          a graphics dev may only use this slot
- * slot1  - this is the "expansion"-slot 0 (EXP0), do not confuse with
- *          slot 0 (GFX).
- * slot2  - this is the "expansion"-slot 1 (EXP1), do not confuse with
- *          slot 1 (EXP0).
  */
 
-#define GIO_SLOT_GFX	0
-#define GIO_SLOT_GIO1	1
-#define GIO_SLOT_GIO2	2
-#define GIO_NUM_SLOTS	3
-
-#define GIO_ANY_ID	0xff
-
-#define GIO_VALID_ID_ONLY	0x01
-#define GIO_IFACE_64		0x02
-#define GIO_HAS_ROM		0x04
-
-struct gio_dev {
-	unsigned char	device;
-	unsigned char	revision;
-	unsigned short	vendor;
-	unsigned char	flags;
-
-	unsigned char	slot_number;
-	unsigned long	base_addr;
-	unsigned int	map_size;
-
-	char		*name;
-	char		slot_name[5];
-};
-
-extern struct gio_dev* gio_find_device(unsigned char device, const struct gio_dev *from);
-
-extern void sgigio_init(void);
+#define GIO_ID(x)		(x & 0x7f)
+#define GIO_32BIT_ID		0x80
+#define GIO_REV(x)		((x >> 8) & 0xff)
+#define GIO_64BIT_IFACE		0x10000
+#define GIO_ROM_PRESENT		0x20000
+#define GIO_VENDOR_CODE(x)	((x >> 18) & 0x3fff)
+
+#define GIO_SLOT_GFX_BASE	0x1f000000
+#define GIO_SLOT_EXP0_BASE	0x1f400000
+#define GIO_SLOT_EXP1_BASE	0x1f600000
 
 #endif /* _ASM_SGI_SGIGIO_H */
Index: include/asm-mips64/sgi/sgigio.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/sgi/sgigio.h,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 sgigio.h
--- include/asm-mips64/sgi/sgigio.h	5 Aug 2002 23:53:40 -0000	1.1.2.2
+++ include/asm-mips64/sgi/sgigio.h	8 Jan 2003 11:10:37 -0000
@@ -12,6 +12,11 @@
 #define _ASM_SGI_SGIGIO_H
 
 /*
+ * GIO bus addresses
+ *
+ * The Indigo and Indy have two GIO bus connectors. Indigo2 (all models) have
+ * three physical connectors, but only two slots, GFX and EXP0.
+ * 
  * There is 10MB of GIO address space for GIO64 slot devices
  * slot#   slot type address range            size
  * -----   --------- ----------------------- -----
@@ -26,44 +31,56 @@
  * Following space is reserved and unused
  *   -     RESERVED  0x18000000 - 0x1effffff 112MB
  *
- * The GIO specification tends to use slot numbers while the MC specification
- * tends to use slot types.
+ * GIO bus IDs
+ *
+ * Each GIO bus device identifies itself to the system by answering a
+ * read with an "ID" value. IDs are either 8 or 32 bits long. IDs less
+ * than 128 are 8 bits long, with the most significant 24 bits read from
+ * the slot undefined.
+ *
+ * 32-bit IDs are divided into
+ *	bits 0:6        the product ID; ranges from 0x00 to 0x7F.
+ *	bit 7		0=GIO Product ID is 8 bits wide
+ *			1=GIO Product ID is 32 bits wide.
+ *	bits 8:15       manufacturer version for the product.
+ *	bit 16		0=GIO32 and GIO32-bis, 1=GIO64.
+ *	bit 17		0=no ROM present
+ *			1=ROM present on this board AND next three words
+ *			space define the ROM.
+ *	bits 18:31	up to manufacturer.
+ *
+ * IDs above 0x50/0xd0 are of 3rd party boards.
+ *
+ * 8-bit IDs
+ *	0x01		XPI low cost FDDI
+ *	0x02		GTR TokenRing
+ *	0x04		Synchronous ISDN
+ *	0x05		ATM board [*]
+ *	0x06		Canon Interface
+ *	0x07		16 bit SCSI Card [*]
+ *	0x08		JPEG (Double Wide)
+ *	0x09		JPEG (Single Wide)
+ *	0x0a		XPI mez. FDDI device 0
+ *	0x0b		XPI mez. FDDI device 1
+ *	0x0c		SMPTE 259M Video [*]
+ *	0x0d		Babblefish Compression [*]
+ *	0x0e		E-Plex 8-port Ethernet
+ *	0x30		Lyon Lamb IVAS
+ *	0xb8		GIO 100BaseTX Fast Ethernet (gfe)
+ *
+ * [*] Device provide 32-bit ID.
  *
- * slot0  - the "graphics" (GFX) slot but there is no requirement that
- *          a graphics dev may only use this slot
- * slot1  - this is the "expansion"-slot 0 (EXP0), do not confuse with
- *          slot 0 (GFX).
- * slot2  - this is the "expansion"-slot 1 (EXP1), do not confuse with
- *          slot 1 (EXP0).
  */
 
-#define GIO_SLOT_GFX	0
-#define GIO_SLOT_GIO1	1
-#define GIO_SLOT_GIO2	2
-#define GIO_NUM_SLOTS	3
-
-#define GIO_ANY_ID	0xff
-
-#define GIO_VALID_ID_ONLY	0x01
-#define GIO_IFACE_64		0x02
-#define GIO_HAS_ROM		0x04
-
-struct gio_dev {
-	unsigned char	device;
-	unsigned char	revision;
-	unsigned short	vendor;
-	unsigned char	flags;
-
-	unsigned char	slot_number;
-	unsigned long	base_addr;
-	unsigned int	map_size;
-
-	char		*name;
-	char		slot_name[5];
-};
-
-extern struct gio_dev* gio_find_device(unsigned char device, const struct gio_dev *from);
-
-extern void sgigio_init(void);
+#define GIO_ID(x)		(x & 0x7f)
+#define GIO_32BIT_ID		0x80
+#define GIO_REV(x)		((x >> 8) & 0xff)
+#define GIO_64BIT_IFACE		0x10000
+#define GIO_ROM_PRESENT		0x20000
+#define GIO_VENDOR_CODE(x)	((x >> 18) & 0x3fff)
+
+#define GIO_SLOT_GFX_BASE	0x1f000000
+#define GIO_SLOT_EXP0_BASE	0x1f400000
+#define GIO_SLOT_EXP1_BASE	0x1f600000
 
 #endif /* _ASM_SGI_SGIGIO_H */
Index: arch/mips/sgi-ip22/ip22-time.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-time.c,v
retrieving revision 1.1.2.11
diff -u -r1.1.2.11 ip22-time.c
--- arch/mips/sgi-ip22/ip22-time.c	18 Dec 2002 22:37:29 -0000	1.1.2.11
+++ arch/mips/sgi-ip22/ip22-time.c	8 Jan 2003 11:10:38 -0000
@@ -180,14 +180,6 @@
 		(int) (r4k_tick / 5000), (int) (r4k_tick % 5000) / 50);
 
 	mips_counter_frequency = r4k_tick * HZ;
-
-	/* HACK ALERT! This get's called after traps initialization
-	 * We piggyback the initialization of GIO bus here even though
-	 * it is technically not related with the timer in any way.
-	 * Doing it from ip22_setup wouldn't work since traps aren't
-	 * initialized yet.
-	 */
-	sgigio_init();
 }
 
 /* Generic SGI handler for (spurious) 8254 interrupts */
Index: arch/mips/sgi-ip22/ip22-setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 ip22-setup.c
--- arch/mips/sgi-ip22/ip22-setup.c	27 Sep 2002 16:45:04 -0000	1.1.2.14
+++ arch/mips/sgi-ip22/ip22-setup.c	8 Jan 2003 11:18:39 -0000
@@ -47,7 +47,6 @@
 extern struct rtc_ops indy_rtc_ops;
 extern void indy_reboot_setup(void);
 extern void sgi_volume_set(unsigned char);
-extern void create_gio_proc_entry(void);
 
 #define sgi_kh ((struct hpc_keyb *) &(hpc3mregs->kbdmouse0))
 
@@ -69,11 +68,6 @@
 	 * ip22_setup wouldn't work since kmalloc isn't initialized yet.
 	 */
 	indy_reboot_setup();
-
-	/* Ehm, well... once David used hack above, let's add yet another.
-	 * Register GIO bus proc entry here.
-	 */
-	create_gio_proc_entry();
 
 	return request_irq(SGI_KEYBD_IRQ, handler, 0, "keyboard", NULL);
 }
Index: arch/mips/sgi-ip22/ip22-gio.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-gio.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 ip22-gio.c
--- arch/mips/sgi-ip22/ip22-gio.c	18 Dec 2002 19:11:09 -0000	1.1.2.4
+++ arch/mips/sgi-ip22/ip22-gio.c	8 Jan 2003 12:14:53 -0000
@@ -1,137 +1,5 @@
 /*
- * ip22-gio.c: Support for GIO64 bus (inspired by PCI code)
- *
- * Copyright (C) 2002 Ladislav Michl
+ * ip22-gio.c: Support for GIO bus (add interrupt handling code here)
  */
 
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-
-#include <asm/addrspace.h>
-#include <asm/sgi/sgimc.h>
 #include <asm/sgi/sgigio.h>
-
-#define GIO_PIO_MAP_BASE	0x1f000000L
-#define GIO_PIO_MAP_SIZE	(16 * 1024*1024)
-
-#define GIO_ADDR_GFX		0x1f000000L
-#define GIO_ADDR_GIO1		0x1f400000L
-#define GIO_ADDR_GIO2		0x1f600000L
-
-#define GIO_GFX_MAP_SIZE	(4 * 1024*1024)
-#define GIO_GIO1_MAP_SIZE	(2 * 1024*1024)
-#define GIO_GIO2_MAP_SIZE	(4 * 1024*1024)
-
-#define GIO_NO_DEVICE		0x80
-
-static struct gio_dev gio_slot[GIO_NUM_SLOTS] = {{
-	.flags		= GIO_NO_DEVICE,
-	.slot_number	= GIO_SLOT_GFX,
-	.base_addr	= GIO_ADDR_GFX,
-	.map_size	= GIO_GFX_MAP_SIZE,
-	.slot_name	= "GFX",
-}, {
-	.flags		= GIO_NO_DEVICE,
-	.slot_number	= GIO_SLOT_GIO1,
-	.base_addr	= GIO_ADDR_GIO1,
-	.map_size	= GIO_GIO1_MAP_SIZE,
-	.slot_name	= "EXP0",
-}, {
-	.flags		= GIO_NO_DEVICE,
-	.slot_number	= GIO_SLOT_GIO2,
-	.base_addr	= GIO_ADDR_GIO2,
-	.map_size	= GIO_GIO2_MAP_SIZE,
-	.slot_name	= "EXP1"
-}};
-
-static int gio_read_proc(char *buf, char **start, off_t off,
-			 int count, int *eof, void *data)
-{
-	int i;
-	char *p = buf;
-
-	p += sprintf(p, "GIO devices found:\n");
-	for (i = 0; i < GIO_NUM_SLOTS; i++) {
-		if (gio_slot[i].flags & GIO_NO_DEVICE)
-			continue;
-		p += sprintf(p, "  Slot %s, DeviceId 0x%02x\n",
-			     gio_slot[i].slot_name, gio_slot[i].device);
-		p += sprintf(p, "    BaseAddr 0x%08lx, MapSize 0x%08x\n",
-			     gio_slot[i].base_addr, gio_slot[i].map_size);
-	}
-
-	return p - buf;
-}
-
-void create_gio_proc_entry(void)
-{
-	create_proc_read_entry("gio", 0, NULL, gio_read_proc, NULL);
-}
-
-/**
- * gio_find_device - begin or continue searching for a GIO device by device id
- * @device: GIO device id to match, or %GIO_ANY_ID to match all device ids
- * @from: Previous GIO device found in search, or %NULL for new search.
- *
- * Iterates through the list of known GIO devices. If a GIO device is found
- * with a matching @device, a pointer to its device structure is returned.
- * Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from next device.
- */
-struct gio_dev *
-gio_find_device(unsigned char device, const struct gio_dev *from)
-{
-	int i;
-
-	for (i = (from) ? from->slot_number : 0; i < GIO_NUM_SLOTS; i++)
-		if (!(gio_slot[i].flags & GIO_NO_DEVICE) &&
-		   (device == GIO_ANY_ID || device == gio_slot[i].device))
-			return &gio_slot[i];
-
-	return NULL;
-}
-
-#define GIO_IDCODE(x)		(x & 0x7f)
-#define GIO_ALL_BITS_VALID	0x80
-#define GIO_REV(x)		((x >> 8) & 0xff)
-#define GIO_GIO_SIZE_64		0x10000
-#define GIO_ROM_PRESENT		0x20000
-#define GIO_VENDOR_CODE(x)	((x >> 18) & 0x3fff)
-
-extern int ip22_baddr(unsigned int *val, unsigned long addr);
-
-/**
- * sgigio_init - scan the GIO space and figure out what hardware is actually
- * present.
- */
-void __init sgigio_init(void)
-{
-	unsigned int i, id, found = 0;
-
-	printk("GIO: Scanning for GIO cards...\n");
-	for (i = 0; i < GIO_NUM_SLOTS; i++) {
-		if (ip22_baddr(&id, KSEG1ADDR(gio_slot[i].base_addr)))
-			continue;
-
-		found = 1;
-		gio_slot[i].device = GIO_IDCODE(id);
-		if (id & GIO_ALL_BITS_VALID) {
-			gio_slot[i].revision = GIO_REV(id);
-			gio_slot[i].vendor = GIO_VENDOR_CODE(id);
-			gio_slot[i].flags =
-				(id & GIO_GIO_SIZE_64) ? GIO_IFACE_64 : 0 |
-				(id & GIO_ROM_PRESENT) ? GIO_HAS_ROM : 0;
-		} else
-			gio_slot[i].flags = GIO_VALID_ID_ONLY;
-
-		printk("GIO: Card 0x%02x @ 0x%08lx\n", gio_slot[i].device,
-			gio_slot[i].base_addr);
-	}
-
-	if (!found)
-		printk("GIO: No GIO cards present.\n");
-}
