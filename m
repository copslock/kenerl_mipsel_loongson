Received:  by oss.sgi.com id <S42285AbQFTLWP>;
	Tue, 20 Jun 2000 04:22:15 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:34061 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42229AbQFTLWA>;
	Tue, 20 Jun 2000 04:22:00 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA00536
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 04:17:02 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA07969
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 04:21:27 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA03079
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 04:21:18 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA24047;
	Tue, 20 Jun 2000 13:21:10 +0200 (MET DST)
Date:   Tue, 20 Jun 2000 13:21:10 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Linux kernel <linux-kernel@vger.rutgers.edu>
cc:     Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Proposal: non-PC ISA bus support
Message-ID: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


The following patch fixes 2 problems related to ISA bus access on non-PC
platforms:

 1. ISA I/O space is memory mapped on many platforms (e.g. PPC and MIPS). To
    access it from user space, you cannot plainly use inb() and friends like on
    PC, but you have to mmap() the correct region of /dev/mem first. This
    region depends on the machine type and currently there's no simple way to
    find out from user space.

 2. ISA memory is not located at physical address 0 on many platforms (e.g. PPC
    and some MIPS boxes). This means you cannot e.g. use
    request_mem_region(0xa0000, 65536) to request the legacy VGA region.

Solutions:

 1. Provide /proc/bus/isa/map, which contains the ISA I/O and memory space
    mappings on machines where these are memory mapped.
    
    Example (on PPC CHRP LongTrail):
  
	callisto$ cat /proc/bus/isa/map 
	f8000000	01000000	IO
	f7000000	01000000	MEM
	callisto$

    The region marked `IO' is ISA (also PCI) I/O space, while the region marked
    `MEM' is ISA memory space. Of course on a PC the first one is not
    available because there are separate I/O and memory spaces on ia32.

 2. Provide new resource management functions for ISA memory space:

	isa_request_mem_region()
	isa_check_mem_region()
	isa_release_mem_region()

    On ia32, these are identical to the normal memory resource management
    functions.

    [ Alternatively we could add tests to the *_mem_region() functions to test
      whether the requested region is < 16 MB (and thus in ISA memory space)
      and add the required offset. But this affects the common resource code
      and may cause problems on machines where there is no ISA space in the
      first 16 MB of memory space. ]

The patch contains support for ia32, PPC and MIPS (limited to DDB Vrc-5074).
It was tested on PPC only.

Comments are welcomed!


diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/Makefile geert-isa-2.4.0-test1-ac21/Makefile
--- alan-2.4.0-test1-ac21/Makefile	Sun Jun 18 21:14:12 2000
+++ geert-isa-2.4.0-test1-ac21/Makefile	Tue Jun 20 11:37:11 2000
@@ -152,6 +152,7 @@
 
 DRIVERS-$(CONFIG_SOUND) += drivers/sound/sounddrivers.o
 DRIVERS-$(CONFIG_PCI) += drivers/pci/pci.a
+DRIVERS-$(CONFIG_ISA) += drivers/isa/isa.o
 DRIVERS-$(CONFIG_PCMCIA) += drivers/pcmcia/pcmcia.o
 DRIVERS-$(CONFIG_PCMCIA_NETCARD) += drivers/net/pcmcia/pcmcia_net.o
 DRIVERS-$(CONFIG_PCMCIA_CHRDEV) += drivers/char/pcmcia/pcmcia_char.o
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/arch/ppc/config.in geert-isa-2.4.0-test1-ac21/arch/ppc/config.in
--- alan-2.4.0-test1-ac21/arch/ppc/config.in	Sun Jun 18 21:14:15 2000
+++ geert-isa-2.4.0-test1-ac21/arch/ppc/config.in	Tue Jun 20 11:30:40 2000
@@ -88,7 +88,11 @@
 mainmenu_option next_comment
 comment 'General setup'
 
-define_bool CONFIG_ISA n
+if [ "$CONFIG_ALL_PPC" ]; then
+    define_bool CONFIG_ISA y
+else
+    define_bool CONFIG_ISA n
+fi
 define_bool CONFIG_SBUS n
 
 if [ "$CONFIG_APUS" = "y" -o "$CONFIG_4xx" = "y" -o \
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/drivers/Makefile geert-isa-2.4.0-test1-ac21/drivers/Makefile
--- alan-2.4.0-test1-ac21/drivers/Makefile	Wed Mar 15 19:50:30 2000
+++ geert-isa-2.4.0-test1-ac21/drivers/Makefile	Sun Jun 18 21:35:06 2000
@@ -11,7 +11,7 @@
 MOD_SUB_DIRS := $(SUB_DIRS)
 ALL_SUB_DIRS := $(SUB_DIRS) pci sgi ide scsi sbus cdrom isdn pnp i2o \
 				ieee1394 macintosh video dio zorro fc4 \
-				usb nubus tc atm pcmcia i2c telephony
+				usb nubus tc atm pcmcia i2c telephony isa
 
 ifdef CONFIG_DIO
 SUB_DIRS += dio
@@ -20,6 +20,10 @@
 
 ifdef CONFIG_PCI
 SUB_DIRS += pci
+endif
+
+ifdef CONFIG_ISA
+SUB_DIRS += isa
 endif
 
 ifeq ($(CONFIG_PCMCIA),y)
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/drivers/isa/Makefile geert-isa-2.4.0-test1-ac21/drivers/isa/Makefile
--- alan-2.4.0-test1-ac21/drivers/isa/Makefile	Thu Jan  1 01:00:00 1970
+++ geert-isa-2.4.0-test1-ac21/drivers/isa/Makefile	Tue Jun 20 11:38:14 2000
@@ -0,0 +1,19 @@
+#
+# Makefile for the ISA bus specific drivers.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definition is now inherited from the
+# parent makefile.
+#
+
+O_TARGET := isa.o
+
+ifdef CONFIG_PROC_FS
+O_OBJS   += proc.o
+endif
+
+include $(TOPDIR)/Rules.make
+
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/drivers/isa/proc.c geert-isa-2.4.0-test1-ac21/drivers/isa/proc.c
--- alan-2.4.0-test1-ac21/drivers/isa/proc.c	Thu Jan  1 01:00:00 1970
+++ geert-isa-2.4.0-test1-ac21/drivers/isa/proc.c	Tue Jun 20 11:37:11 2000
@@ -0,0 +1,42 @@
+/*
+ *	Procfs interface for the ISA bus.
+ *
+ *	Copyright (c) 2000 Geert Uytterhoeven <geert@linux-m68k.org>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+
+static int get_isa_map_info(char *buf, char **start, off_t pos, int count)
+{
+	int len = 0, cnt = 0;
+
+	if (proc_bus_isa_io_size)
+		len += sprintf(buf+len, "%p\t%p\tIO\n",
+			       (void *)proc_bus_isa_io_base,
+			       (void *)proc_bus_isa_io_size);
+	if (proc_bus_isa_mem_size)
+		len += sprintf(buf+len, "%p\t%p\tMEM\n",
+			       (void *)proc_bus_isa_mem_base,
+			       (void *)proc_bus_isa_mem_size);
+	if (pos <= len) {
+		*start = buf+pos;
+		cnt = len-pos;
+	}
+	return (count > cnt) ? cnt : count;
+}
+
+static struct proc_dir_entry *proc_bus_isa_dir;
+
+static int __init isa_proc_init(void)
+{
+	proc_bus_isa_dir = proc_mkdir("isa", proc_bus);
+	create_proc_info_entry("map", 0, proc_bus_isa_dir, get_isa_map_info);
+	return 0;
+}
+
+__initcall(isa_proc_init);
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/drivers/video/clgenfb.c geert-isa-2.4.0-test1-ac21/drivers/video/clgenfb.c
--- alan-2.4.0-test1-ac21/drivers/video/clgenfb.c	Sun Jun 18 21:14:44 2000
+++ geert-isa-2.4.0-test1-ac21/drivers/video/clgenfb.c	Sun Jun 18 21:33:38 2000
@@ -2541,7 +2541,7 @@
 	release_mem_region(info->fbmem_phys, info->size);
 
 #if 0 /* if system didn't claim this region, we would... */
-	release_mem_region(0xA0000, 65535);
+	isa_release_mem_region(0xA0000, 65535);
 #endif
 
 	if (release_io_ports)
@@ -2624,7 +2624,7 @@
 		return -1;
 	}
 #if 0 /* if the system didn't claim this region, we would... */
-	if (!request_mem_region(0xA0000, 65535, "clgenfb")) {
+	if (!isa_request_mem_region(0xA0000, 65535, "clgenfb")) {
 		pci_write_config_word (pdev, PCI_COMMAND, tmp16);
 		printk(KERN_ERR "clgen: cannot reserve region 0x%lx, abort\n",
 		       0xA0000L);
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/include/asm-i386/io.h geert-isa-2.4.0-test1-ac21/include/asm-i386/io.h
--- alan-2.4.0-test1-ac21/include/asm-i386/io.h	Tue Feb 15 21:49:25 2000
+++ geert-isa-2.4.0-test1-ac21/include/asm-i386/io.h	Tue Jun 20 13:10:11 2000
@@ -195,6 +195,11 @@
  */
 #define __ISA_IO_base ((char *)(PAGE_OFFSET))
 
+#define proc_bus_isa_io_base	(0)	/* no MMIO */
+#define proc_bus_isa_io_size	(0)	/* no MMIO */
+#define proc_bus_isa_mem_base	(0x00000000)
+#define proc_bus_isa_mem_size	(0x01000000)
+
 #define isa_readb(a) readb(__ISA_IO_base + (a))
 #define isa_readw(a) readw(__ISA_IO_base + (a))
 #define isa_readl(a) readl(__ISA_IO_base + (a))
@@ -204,6 +209,10 @@
 #define isa_memset_io(a,b,c)		memset_io(__ISA_IO_base + (a),(b),(c))
 #define isa_memcpy_fromio(a,b,c)	memcpy_fromio((a),__ISA_IO_base + (b),(c))
 #define isa_memcpy_toio(a,b,c)		memcpy_toio(__ISA_IO_base + (a),(b),(c))
+
+#define isa_request_mem_region	request_mem_region
+#define isa_check_mem_region	check_mem_region
+#define isa_release_mem_region	release_mem_region
 
 
 /*
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/include/asm-mips/io.h geert-isa-2.4.0-test1-ac21/include/asm-mips/io.h
--- alan-2.4.0-test1-ac21/include/asm-mips/io.h	Fri Mar  3 18:22:38 2000
+++ geert-isa-2.4.0-test1-ac21/include/asm-mips/io.h	Mon Jun 19 20:39:24 2000
@@ -16,6 +16,7 @@
  */
 #undef CONF_SLOWDOWN_IO
 
+#include <linux/config.h>
 #include <asm/addrspace.h>
 
 /*
@@ -112,6 +113,24 @@
  * for the processor.
  */
 extern unsigned long isa_slot_offset;
+
+#define proc_bus_isa_io_base	mips_io_port_base
+#define proc_bus_isa_mem_base	isa_slot_offset
+
+#if defined(CONFIG_DDB5074)	/* and a few others... */
+#define proc_bus_isa_io_size	(0x01000000)
+#define proc_bus_isa_mem_size	(0x01000000)
+#else
+#define proc_bus_isa_io_size	(0)
+#define proc_bus_isa_mem_size	(0)
+#endif
+
+#define isa_request_mem_region(start,n,name)	\
+    request_mem_region(isa_slot_offset+(start),(n),(name))
+#define isa_check_mem_region(start,n)	\
+    check_mem_region(isa_slot_offset+(start),(n))
+#define isa_release_mem_region(start,n)	\
+    release_mem_region(isa_slot_offset+(start),(n))
 
 /*
  * readX/writeX() are used to access memory mapped devices. On some
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file alan-2.4.0-test1-ac21/include/asm-ppc/io.h geert-isa-2.4.0-test1-ac21/include/asm-ppc/io.h
--- alan-2.4.0-test1-ac21/include/asm-ppc/io.h	Sun Jun 18 21:14:53 2000
+++ geert-isa-2.4.0-test1-ac21/include/asm-ppc/io.h	Mon Jun 19 20:13:07 2000
@@ -30,6 +30,10 @@
 #define _IO_BASE 0
 #define _ISA_MEM_BASE 0
 #define PCI_DRAM_OFFSET 0
+#define proc_bus_isa_io_base	(0)
+#define proc_bus_isa_io_size	(0)
+#define proc_bus_isa_mem_base	(0)
+#define proc_bus_isa_mem_size	(0)
 #else
 extern unsigned long isa_io_base;
 extern unsigned long isa_mem_base;
@@ -37,6 +41,10 @@
 #define _IO_BASE	isa_io_base
 #define _ISA_MEM_BASE	isa_mem_base
 #define PCI_DRAM_OFFSET	pci_dram_offset
+#define proc_bus_isa_io_base	isa_io_base
+#define proc_bus_isa_io_size	(0x01000000)
+#define proc_bus_isa_mem_base	isa_mem_base
+#define proc_bus_isa_mem_size	(0x01000000)
 #endif /* CONFIG_APUS */
 #endif
 
@@ -53,6 +61,23 @@
 #define writew(b,addr) out_le16((volatile u16 *)(addr),(b))
 #define writel(b,addr) out_le32((volatile u32 *)(addr),(b))
 #endif
+
+#define isa_readb(a)			readb(isa_mem_base+(a))
+#define isa_readw(a)			readw(isa_mem_base+(a))
+#define isa_readl(a)			readl(isa_mem_base+(a))
+#define isa_writeb(b,a)			writeb(b,isa_mem_base+(a))
+#define isa_writew(w,a)			writeb(w,isa_mem_base+(a))
+#define isa_writel(l,a)			writeb(l,isa_mem_base+(a))
+#define isa_memset_io(a,b,c)		memset_io(isa_mem_base+(a),(b),(c))
+#define isa_memcpy_fromio(a,b,c)	memcpy_fromio((a),isa_mem_base+(b),(c))
+#define isa_memcpy_toio(a,b,c)		memcpy_toio(isa_mem_base+(a),(b),(c))
+
+#define isa_request_mem_region(start,n,name)	\
+    request_mem_region(isa_mem_base+(start),(n),(name))
+#define isa_check_mem_region(start,n)	\
+    check_mem_region(isa_mem_base+(start),(n))
+#define isa_release_mem_region(start,n)	\
+    release_mem_region(isa_mem_base+(start),(n))
 
 /*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
