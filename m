Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 22:25:57 +0000 (GMT)
Received: from p508B7C81.dip.t-dialin.net ([80.139.124.129]:45991 "EHLO
	p508B7C81.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225241AbSLKWZz>; Wed, 11 Dec 2002 22:25:55 +0000
Received: from mallaury.noc.nerim.net ([IPv6:::ffff:62.4.17.82]:15366 "EHLO
	mallaury.noc.nerim.net") by ralf.linux-mips.org with ESMTP
	id <S868621AbSLKWZu>; Wed, 11 Dec 2002 23:25:50 +0100
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id DB2FC62E3C; Wed, 11 Dec 2002 23:25:39 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18MFIX-00020s-00; Wed, 11 Dec 2002 23:25:45 +0100
Date: Wed, 11 Dec 2002 23:25:44 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Ilya Volynets <ilya@theIlya.com>
Subject: [PATCH 2.5] SGI O2 framebuffer driver
In-Reply-To: <20020903205816.A25897@linux-mips.org>
Message-ID: <Pine.LNX.4.21.0212112252410.2300-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	Here's a patch to add support for the framebuffer on the SGI
O2. It has support for both static (bootmem) and dynamic video memory
allocation (limited to 2MB due to the small number of available vmalloc
mappings in the current mips64 kernel). 

Vivien.

--- arch/mips/sgi-ip32/ip32-setup.c	2002-10-09 23:12:44.000000000 +0200
+++ arch/mips/sgi-ip32/ip32-setup.c	2002-12-09 23:35:49.000000000 +0100
@@ -13,6 +13,8 @@
 #include <linux/mc146818rtc.h>
 #include <linux/param.h>
 #include <linux/init.h>
+#include <linux/console.h>
+#include <linux/bootmem.h>

 #include <asm/time.h>
 #include <asm/mipsregs.h>
@@ -21,6 +21,7 @@
 #include <asm/ip32/crime.h>
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
+#include <asm/ip32/tile.h>
 #include <asm/sgialib.h>
 
 extern struct rtc_ops ip32_rtc_ops;
@@ -58,6 +59,18 @@
 }
 #endif
 
+void __init ip32_devsetup(void)
+{
+#if defined(CONFIG_FB_SGIO2) && !defined(CONFIG_FB_SGIO2_DYNAMIC)
+	{
+		extern void *sgio2fb_mem;
+
+		sgio2fb_mem = __alloc_bootmem(CONFIG_FB_SGIO2_MEM*1024*1024,
+					      TILE_SIZE,__pa(MAX_DMA_ADDRESS));
+	}
+#endif
+}
+
 extern void ip32_time_init(void);
 extern void ip32_reboot_setup(void);
 
--- arch/mips64/kernel/setup.c	2002-11-09 16:10:14.000000000 +0100
+++ arch/mips64/kernel/setup.c	2002-12-09 23:36:07.000000000 +0100
@@ -451,6 +451,10 @@
 
 	bootmem_init();
 
+#ifdef CONFIG_SGI_IP32
+	ip32_devsetup();
+#endif
+
 	paging_init();
 
 	resource_init();
--- arch/mips/sgi-ip32/ip32-reset.c	2002-07-25 22:10:08.000000000 +0200
+++ arch/mips/sgi-ip32/ip32-reset.c	2002-12-08 13:25:07.000000000 +0100
@@ -10,14 +10,26 @@
 
 #include <asm/reboot.h>
 #include <asm/sgialib.h>
+#include <asm/addrspace.h>
+#include <asm/types.h>
+
+#ifdef CONFIG_FB_SGIO2
+extern void gbe_turn_off(void);
+#endif
 
 static void ip32_machine_restart(char *cmd)
 {
+#ifdef CONFIG_FB_SGIO2
+	gbe_turn_off();
+#endif 
 	ArcReboot();
 }
 
 static inline void ip32_machine_halt(void)
 {
+#ifdef CONFIG_FB_SGIO2
+	gbe_turn_off();
+#endif 
 	ArcEnterInteractiveMode();
 }

--- include/video/fbcon.h	2002-11-09 16:17:44.000000000 +0100
+++ include/video/fbcon.h	2002-12-08 02:02:58.000000000 +0100
@@ -214,9 +214,11 @@
 #define fb_readb(addr) (*(volatile u8 *) (addr))
 #define fb_readw(addr) (*(volatile u16 *) (addr))
 #define fb_readl(addr) (*(volatile u32 *) (addr))
+#define fb_readq(addr) (*(volatile u64 *) (addr))
 #define fb_writeb(b,addr) (*(volatile u8 *) (addr) = (b))
 #define fb_writew(b,addr) (*(volatile u16 *) (addr) = (b))
 #define fb_writel(b,addr) (*(volatile u32 *) (addr) = (b))
+#define fb_writeq(b,addr) (*(volatile u64 *) (addr) = (b))
 #define fb_memset memset
 
 #endif
--- drivers/video/Kconfig	2002-11-05 16:18:22.000000000 +0100
+++ drivers/video/Kconfig	2002-12-08 01:59:08.000000000 +0100
@@ -400,6 +400,30 @@
 	help
 	  SGI Visual Workstation support for framebuffer graphics.
 
+config FB_SGIO2
+	bool "SGI O2 frame buffer support"
+	depends on FB && SGI_IP32
+	help
+	  SGI O2 workstation framebuffer support. You probably
+	  want to enable this, unless you are using serial console.
+	  Even with serial console, this shouldn't hurt (much).
+
+config FB_SGIO2_MEM
+	int "Video memory size in MB"
+	depends on FB_SGIO2
+        default 8
+	help
+	  This is the amount of memory reserved for the framebuffer,
+	  which can be any value between 1MB and 8MB.
+
+config FB_SGIO2_DYNAMIC
+	bool "Dynamic video memory allocation (EXPERIMENTAL)"
+	depends on FB_SGIO2
+	default n
+	help
+	  Saying Y here allows the video memory to scale with the
+	  resolution of the framebuffer.
+
 config BUS_I2C
 	bool
 	depends on FB && VISWS
@@ -976,7 +1000,7 @@
 	tristate "8 bpp packed pixels support" if FBCON_ADVANCED
 	depends on FB
 	default m if !FBCON_ADVANCED && !FB_ACORN && !FB_ATARI && !FB_P9100 && FB_CYBER2000!=y && FB_RADEON!=y && FB_TGA!=y && FB_SIS!=y && FB_PM3!=y && !FB_TCX && !FB_CGTHREE && !FB_CONTROL && FB_CLGEN!=y && !FB_CGFOURTEEN && FB_TRIDENT!=y && !FB_VIRGE && FB_CYBER!=y && !FB_VALKYRIE && !FB_PLATINUM && !FB_IGA && FB_MATROX!=y && !FB_CT65550 && FB_PM2!=y && !FB_SA1100 && (FB_CYBER2000=m || FB_RADEON=m || FB_TGA=m || FB_SIS=m || FB_PM3=m || FB_CLGEN=m || FB_TRIDENT=m || FB_CYBER=m || FB_MATROX=m || FB_PM2=m)
-	default y if !FBCON_ADVANCED && (FB_ACORN || FB_ATARI || FB_P9100 || FB_CYBER2000=y || FB_RADEON=y || FB_TGA=y || FB_SIS=y || FB_PM3=y || FB_TCX || FB_CGTHREE || FB_CONTROL || FB_CLGEN=y || FB_CGFOURTEEN || FB_TRIDENT=y || FB_VIRGE || FB_CYBER=y || FB_VALKYRIE || FB_PLATINUM || FB_IGA || FB_MATROX=y || FB_CT65550 || FB_PM2=y || FB_SA1100)
+	default y if !FBCON_ADVANCED && (FB_ACORN || FB_ATARI || FB_P9100 || FB_CYBER2000=y || FB_RADEON=y || FB_TGA=y || FB_SIS=y || FB_PM3=y || FB_TCX || FB_CGTHREE || FB_CONTROL || FB_CLGEN=y || FB_CGFOURTEEN || FB_TRIDENT=y || FB_VIRGE || FB_CYBER=y || FB_VALKYRIE || FB_PLATINUM || FB_IGA || FB_MATROX=y || FB_CT65550 || FB_PM2=y || FB_SA1100 || FB_SGIO2=y)
 	help
 	  This is the low level frame buffer console driver for 8 bits per
 	  pixel (256 colors) packed pixels.
@@ -985,7 +1009,7 @@
 	tristate "16 bpp packed pixels support" if FBCON_ADVANCED
 	depends on FB
 	default m if !FBCON_ADVANCED && !FB_ATARI && FB_PM3!=y && FB_SIS!=y && FB_PVR2!=y && FB_TRIDENT!=y && !FB_TBOX && FB_VOODOO1!=y && FB_RADEON!=y && !FB_CONTROL && FB_CLGEN!=y && !FB_VIRGE && FB_CYBER!=y && !FB_VALKYRIE && !FB_PLATINUM && !FB_CT65550 && FB_MATROX!=y && FB_PM2!=y && FB_CYBER2000!=y && !FB_SA1100 && (FB_SIS=m || FB_RADEON=m || FB_PVR2=m || FB_TRIDENT=m || FB_VOODOO1=m || FB_PM3=m || FB_CLGEN=m || FB_CYBER=m || FB_MATROX=m || FB_PM2=m || FB_CYBER2000=m || FB_SA1100)
-	default y if !FBCON_ADVANCED && (FB_ATARI || FB_PM3=y || FB_SIS=y || FB_PVR2=y || FB_TRIDENT=y || FB_TBOX || FB_VOODOO1=y || FB_RADEON=y || FB_CONTROL || FB_CLGEN=y || FB_VIRGE || FB_CYBER=y || FB_VALKYRIE || FB_PLATINUM || FB_CT65550 || FB_MATROX=y || FB_PM2=y || FB_CYBER2000=y || FB_SA1100)
+	default y if !FBCON_ADVANCED && (FB_ATARI || FB_PM3=y || FB_SIS=y || FB_PVR2=y || FB_TRIDENT=y || FB_TBOX || FB_VOODOO1=y || FB_RADEON=y || FB_CONTROL || FB_CLGEN=y || FB_VIRGE || FB_CYBER=y || FB_VALKYRIE || FB_PLATINUM || FB_CT65550 || FB_MATROX=y || FB_PM2=y || FB_CYBER2000=y || FB_SA1100 || FB_SGIO2=y)
 	help
 	  This is the low level frame buffer console driver for 15 or 16 bits
 	  per pixel (32K or 64K colors, also known as `hicolor') packed
@@ -1005,7 +1029,7 @@
 	tristate "32 bpp packed pixels support" if FBCON_ADVANCED
 	depends on FB
 	default m if !FBCON_ADVANCED && !FB_ATARI && FB_RADEON!=y && FB_VOODOO1!=y && FB_TRIDENT!=y && !FB_CONTROL && FB_CLGEN!=y && FB_TGA!=y && !FB_PLATINUM && FB_MATROX!=y && FB_PM2!=y && FB_PVR2!=y && FB_PM3!=y && FB_SIS!=y && (FB_RADEON=m || FB_VOODOO1=m || FB_TRIDENT=m || FB_CLGEN=m || FB_TGA=m || FB_MATROX=m || FB_PM2=m || FB_SIS=m || FB_PVR2=m || FB_PM3=m)
-	default y if !FBCON_ADVANCED && (FB_ATARI || FB_RADEON=y || FB_VOODOO1=y || FB_TRIDENT=y || FB_CONTROL || FB_CLGEN=y || FB_TGA=y || FB_PLATINUM || FB_MATROX=y || FB_PM2=y || FB_PVR2=y || FB_PM3=y || FB_SIS=y)
+	default y if !FBCON_ADVANCED && (FB_ATARI || FB_RADEON=y || FB_VOODOO1=y || FB_TRIDENT=y || FB_CONTROL || FB_CLGEN=y || FB_TGA=y || FB_PLATINUM || FB_MATROX=y || FB_PM2=y || FB_PVR2=y || FB_PM3=y || FB_SIS=y || FB_SGIO2=y)
 	help
 	  This is the low level frame buffer console driver for 32 bits per
 	  pixel (16M colors, also known as `truecolor') sparse packed pixels.
--- drivers/video/Makefile	2002-11-09 16:14:42.000000000 +0100
+++ drivers/video/Makefile	2002-12-08 00:59:28.000000000 +0100
@@ -56,6 +56,7 @@
 obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CYBER)            += cyberfb.o
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o
+obj-$(CONFIG_FB_SGIO2)            += sgio2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
--- drivers/video/fbmem.c	2002-11-24 16:40:50.000000000 +0100
+++ drivers/video/fbmem.c	2002-12-08 00:59:28.000000000 +0100
@@ -118,6 +118,8 @@
 extern int sun3fb_setup(char *);
 extern int sgivwfb_init(void);
 extern int sgivwfb_setup(char*);
+extern int sgio2fb_init(void);
+extern int sgio2fb_setup(char*);
 extern int rivafb_init(void);
 extern int rivafb_setup(char*);
 extern int tdfxfb_init(void);
@@ -262,6 +264,9 @@
 #ifdef CONFIG_FB_SGIVW
 	{ "sgivw", sgivwfb_init, sgivwfb_setup },
 #endif
+#ifdef CONFIG_FB_SGIO2
+	{ "sgio2", sgio2fb_init, sgio2fb_setup },
+#endif
 #ifdef CONFIG_FB_ACORN
 	{ "acorn", acornfb_init, acornfb_setup },
 #endif
--- drivers/video/sgio2fb.c	1970-01-01 01:00:00.000000000 +0100
+++ drivers/video/sgio2fb.c	2002-12-08 02:00:01.000000000 +0100
@@ -0,0 +1,1446 @@
+/*
+ *  linux/drivers/video/sgio2fb.c -- SGI O2 GBE frame buffer device
+ *
+ *      Copyright (C) 2002 Vivien Chappelier, vivien.chappelier@linux-mips.org 
+ *	 Derived from sgivwfb.c by Jeffrey Newquist
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <asm/uaccess.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/addrspace.h>
+#include <asm/byteorder.h>
+#include <asm/ip32/tile.h>
+#include <linux/wrapper.h>
+#include <linux/vmalloc.h>
+#include <linux/bootmem.h>
+
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-cfb8.h>
+#include <video/fbcon-cfb16.h>
+#include <video/fbcon-cfb32.h>
+
+#define GBE_REG_BASE regs
+#include "sgio2fb.h"
+
+struct sgio2fb_par {
+	struct fb_var_screeninfo var;
+	struct gbe_timing_info timing;
+	int valid;
+};
+
+/*
+ *  RAM we reserve for the frame buffer. This defines the maximum screen
+ *  size
+ */
+
+#if CONFIG_FB_SGIO2_MEM > 8
+#error SGIO2 Framebuffer cannot use more than 8MB of memory
+#endif
+
+#if defined(CONFIG_FB_SGIO2_DYNAMIC) && CONFIG_FB_SGIO2_MEM > 2
+#error Cannot use more than a 2MB virtual framebuffer until vmalloc mess is cleaned up
+#endif
+
+void *sgio2fb_mem;
+static u16 *sgio2fb_tiles_table;
+static u_long sgio2fb_mem_size = CONFIG_FB_SGIO2_MEM * 1024 * 1024;
+
+static asregs *regs;
+static struct fb_info fb_info;
+static struct {
+	u_char red, green, blue, pad;
+} palette[256];
+static char sgio2fb_name[16] = "SGI O2 FB";
+static int ypan = 0;
+static int ywrap = 0;
+static int video_bpp;
+
+/* console related variables */
+static struct display disp;
+
+static u32 pseudo_palette[256];
+
+static char *mode_option __initdata = NULL;
+
+/* default mode */
+static struct fb_var_screeninfo default_var __initdata = {
+	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
+	640, 480, 640, 480, 0, 0, 8, 0,
+	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
+	0, 0, -1, -1, 0, 39722, 48, 16, 33, 10, 96, 2,
+	0, FB_VMODE_NONINTERLACED
+};
+
+/* default modedb mode */
+/* 640x480, 60 Hz, Non-Interlaced (25.172 MHz dotclock) */
+static struct fb_videomode defaultmode __initdata = {
+	refresh:60,
+	xres:640,
+	yres:480,
+	pixclock:39722,
+	left_margin:48,
+	right_margin:16,
+	upper_margin:33,
+	lower_margin:10,
+	hsync_len:96,
+	vsync_len:2,
+	sync:0,
+	vmode:FB_VMODE_NONINTERLACED
+};
+
+static struct sgio2fb_par par_current;
+
+/*
+ *  Internal routines
+ */
+static u_long get_line_length(int xres_virtual, int bpp);
+static unsigned long bytes_per_pixel(int bpp);
+static void activate_par(struct sgio2fb_par *par);
+static void sgio2fb_encode_fix(struct fb_fix_screeninfo *fix,
+			       struct fb_var_screeninfo *var);
+static int sgio2fb_setcolreg(u_int regno, u_int red, u_int green,
+			     u_int blue, u_int transp,
+			     struct fb_info *info);
+
+
+/*
+ *  Interface to the low level console driver
+ */
+int sgio2fb_init(void);
+static int sgio2fbcon_blank(int blank, struct fb_info *info);
+
+/*
+ *  Interface used by the world
+ */
+int sgio2fb_setup(char *);
+
+static int sgio2fb_set_var(struct fb_var_screeninfo *var, int con,
+			   struct fb_info *info);
+static void sgio2fb_fillrect(struct fb_info *p,
+			     struct fb_fillrect *region);
+static void sgio2fb_copyarea(struct fb_info *p, struct fb_copyarea *area);
+static void sgio2fb_imageblit(struct fb_info *p, struct fb_image *image);
+static int sgio2fb_mmap(struct fb_info *info, struct file *file,
+			struct vm_area_struct *vma);
+
+static struct fb_ops sgio2fb_ops = {
+	owner:THIS_MODULE,
+	fb_set_var:sgio2fb_set_var,
+	fb_get_cmap:gen_get_cmap,
+	fb_set_cmap:gen_set_cmap,
+	fb_setcolreg:sgio2fb_setcolreg,
+	fb_mmap:sgio2fb_mmap,
+	fb_blank:sgio2fbcon_blank,
+/*	fb_fillrect:    sgio2fb_fillrect,
+	fb_copyarea:    sgio2fb_copyarea,
+	fb_imageblit:   sgio2fb_imagebilt,*/
+	fb_fillrect:cfb_fillrect,
+	fb_copyarea:cfb_copyarea,
+	fb_imageblit:cfb_imageblit,
+};
+
+/*
+ * Interface used for mmap
+ */
+
+void sgio2fb_vma_open(struct vm_area_struct *vma);
+void sgio2fb_vma_close(struct vm_area_struct *vma);
+
+static struct vm_operations_struct sgio2fb_vm_ops = {
+	open:sgio2fb_vma_open,
+	close:sgio2fb_vma_close,
+};
+
+
+static unsigned long get_line_length(int xres_virtual, int bpp)
+{
+	return (xres_virtual * bytes_per_pixel(bpp));
+}
+
+static unsigned long bytes_per_pixel(int bpp)
+{
+	unsigned long length;
+
+	switch (bpp) {
+	case 8:
+		length = 1;
+		break;
+	case 16:
+		length = 2;
+		break;
+	case 32:
+		length = 4;
+		break;
+	default:
+		printk(KERN_INFO "sgio2fb: unsupported bpp=%d\n", bpp);
+		length = 0;
+		break;
+	}
+	return (length);
+}
+
+/*
+ * Kernel remapping routines
+ * XXX: This is to be moved to a more generic tile allocator
+ */
+
+#ifdef CONFIG_FB_SGIO2_DYNAMIC
+
+static int alloc_tile(void)
+{
+	void *addr;
+	struct page *page;
+
+	if (!
+	    (addr =
+	     (void *) __get_free_pages(GFP_KERNEL, get_order(TILE_SIZE))))
+		return -ENOMEM;
+
+	/* Make sure memory won't be swapped out */
+	for (page = virt_to_page(addr);
+	     page < virt_to_page(addr + TILE_SIZE); page++)
+		mem_map_reserve(page);
+
+	return (virt_to_bus(addr) >> TILE_SHIFT);
+}
+
+static void free_tile(u16 tile)
+{
+	void *addr;
+	struct page *page;
+
+	addr = bus_to_virt(tile << TILE_SHIFT);
+	for (page = virt_to_page(addr);
+	     page < virt_to_page(addr + TILE_SIZE); page++)
+		mem_map_unreserve(page);
+	page = virt_to_page(addr);
+	__free_pages(page, get_order(TILE_SIZE));
+}
+
+static int map_tile(unsigned long address, u16 tile, unsigned long flags)
+{
+	int error;
+	pgd_t *dir;
+	pmd_t *pmd;
+	pte_t *pte;
+	phys_t phys_addr, end;
+	unsigned long pfn;
+	pgprot_t pgprot =
+	    __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | __READABLE |
+		     __WRITEABLE | flags);
+
+	dir = pgd_offset_k(address);
+	spin_lock(&init_mm.page_table_lock);
+	error = -ENOMEM;
+	pmd = pmd_alloc(&init_mm, dir, address);
+	if (!pmd)
+		goto exit;
+	pte = pte_alloc_kernel(&init_mm, pmd, address);
+	if (!pte)
+		goto exit;
+	phys_addr = ((phys_t) tile) << TILE_SHIFT;
+	end = address + TILE_SIZE;
+	pfn = phys_addr >> PAGE_SHIFT;
+	do {
+		if (!pte_none(*pte)) {
+			printk("remap_area_pte: page already exists\n");
+			BUG();
+		}
+		set_pte(pte, pfn_pte(pfn, pgprot));
+		address += PAGE_SIZE;
+		pfn++;
+		pte++;
+	} while (address && (address < end));
+	error = 0;
+      exit:
+	spin_unlock(&init_mm.page_table_lock);
+	flush_cache_all();
+	return error;
+}
+
+static void unmap_tile(unsigned long address)
+{
+	pgd_t *dir;
+	pmd_t *pmd;
+	pte_t *pte;
+	phys_t end;
+
+	dir = pgd_offset_k(address);
+	end = address + TILE_SIZE;
+	flush_cache_all();
+	if (pgd_none(*dir))
+		goto exit;
+	if (pgd_bad(*dir)) {
+		pgd_ERROR(*dir);
+		pgd_clear(dir);
+		goto exit;
+	}
+	pmd = pmd_offset(dir, address);
+	if (pmd_none(*pmd))
+		goto exit;
+	if (pmd_bad(*pmd)) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
+		goto exit;
+	}
+	pte = pte_offset_kernel(pmd, address);
+
+	do {
+		pte_t page;
+		page = ptep_get_and_clear(pte);
+		address += PAGE_SIZE;
+		pte++;
+		if (pte_none(page))
+			continue;
+		if (pte_present(page))
+			continue;
+		printk(KERN_CRIT
+		       "Whee.. Swapped out page in kernel page table\n");
+	} while (address < end);
+      exit:
+	flush_tlb_kernel_range(address, end);
+	return;
+}
+
+static void *alloc_fb(int size)
+{
+	struct vm_struct *area;
+
+	area =
+	    get_vm_area((size + TILE_SIZE - 1) & (~TILE_MASK), VM_IOREMAP);
+	if (!area) {
+		printk(KERN_ERR
+		       "sgio2fb: couln't allocate vm_area for framebuffer remapping\n");
+		return NULL;
+	}
+	return (area->addr);
+}
+
+static void free_fb(void *addr)
+{
+	return vfree((void *) (PAGE_MASK & (unsigned long) addr));
+}
+
+static int resize_fb(int size)
+{
+	int i;
+	int end;
+	int tile;
+	void *addr;
+	int flags;
+
+	size = (size + TILE_SIZE - 1) >> TILE_SHIFT;
+	end = sgio2fb_mem_size >> TILE_SHIFT;
+	if (size > end)
+		return (-ENOMEM);
+
+	addr = sgio2fb_mem;
+	flags = (pgprot_val(PAGE_KERNEL) & (~_CACHE_MASK)) |
+	    _CACHE_CACHABLE_NO_WA;
+	for (i = 0; i < end; i++) {
+		if (sgio2fb_tiles_table[i] && !size) {
+			unmap_tile(VMALLOC_VMADDR(addr));
+			free_tile(sgio2fb_tiles_table[i]);
+			sgio2fb_tiles_table[i] = 0;
+		}
+		if (!sgio2fb_tiles_table[i] && size) {
+			if ((tile = alloc_tile()) < 0)
+				return (-ENOMEM);
+			if (map_tile(VMALLOC_VMADDR(addr), tile, flags) <
+			    0)
+				return (-ENOMEM);
+			sgio2fb_tiles_table[i] = tile;
+		}
+		if (size)
+			size--;
+		addr += TILE_SIZE;
+	}
+
+	return (0);
+}
+
+#endif				/* CONFIG_FB_SGIO2_DYNAMIC */
+
+/*
+ *      prepare_fb - setup virtual space for the framebuffer
+ *
+ *      @size:           size of the virtual space (maximum mappable size)
+ *
+ *      Allocate a region of @size bytes in virtual space for the framebuffer.
+ *      Also allocate and setup tiles table and maximum video memory size.
+ */
+
+static int prepare_fb(int size)
+{
+	int i;
+
+	sgio2fb_mem_size = (size + TILE_SIZE - 1) & (~TILE_MASK);
+
+	if (!(sgio2fb_tiles_table = (u16 *) __get_free_page(GFP_DMA))) {
+		printk("sgio2fb: could not allocate tiles table\n");
+		return -ENOMEM;
+	}
+
+	/* Make sure access to tiles is uncached */
+	sgio2fb_tiles_table = (u16 *) KSEG1ADDR(sgio2fb_tiles_table);
+
+	/* Clear tiles table */
+	memset(sgio2fb_tiles_table, 0, sizeof(u16) * GBE_TLB_SIZE);
+
+#ifdef CONFIG_FB_SGIO2_DYNAMIC
+	/* memory is dynamically allocated during fb_set_var */
+	if ((sgio2fb_mem = alloc_fb(size)) < 0)
+		return -ENOMEM;
+	for (i = 0; i < (sgio2fb_mem_size >> TILE_SHIFT); i++) {
+		sgio2fb_tiles_table[i] = 0;
+	}
+#else
+	/* sgio2fb_mem is initialized during bootup with __alloc_bootmem */
+	if (!sgio2fb_mem)
+		return -ENOMEM;
+
+	for (i = 0; i < (sgio2fb_mem_size >> TILE_SHIFT); i++) {
+		sgio2fb_tiles_table[i] =
+		    (virt_to_bus(sgio2fb_mem) >> TILE_SHIFT) + i;
+	}
+
+	/* make access to framebuffer uncached */
+	sgio2fb_mem = (void *) KSEG1ADDR(sgio2fb_mem);
+#endif
+	return 0;
+}
+
+static void gbe_reset(void)
+{
+	/* Turn on dotclock PLL */
+	GBE_SETREG(ctrlstat, 0x300aa000);
+}
+
+
+/*
+ * Function:	gbe_turn_off
+ * Parameters:	(None)
+ * Description:	This should turn off the monitor and gbe.  This is used
+ *              when switching between the serial console and the graphics
+ *              console.
+ */
+
+void gbe_turn_off(void)
+{
+	int i;
+	unsigned int readVal, x, y, vpixen_off;
+
+	/* check if pixel counter is on */
+	GBE_GETREG(vt_xy, readVal);
+	if (GET_GBE_FIELD(VT_XY, VT_FREEZE, readVal) == 1)
+		return;
+
+	/* turn off DMA */
+	GBE_GETREG(ovr_control, readVal);
+	SET_GBE_FIELD(OVR_CONTROL, OVR_DMA_ENABLE, readVal, 0);
+	GBE_SETREG(ovr_control, readVal);
+	udelay(1000);
+	GBE_GETREG(frm_control, readVal);
+	SET_GBE_FIELD(FRM_CONTROL, FRM_DMA_ENABLE, readVal, 0);
+	GBE_SETREG(frm_control, readVal);
+	udelay(1000);
+	GBE_GETREG(did_control, readVal);
+	SET_GBE_FIELD(DID_CONTROL, DID_DMA_ENABLE, readVal, 0);
+	GBE_SETREG(did_control, readVal);
+	udelay(1000);
+
+	/* We have to wait through two vertical retrace periods before the pixel */
+	/* DMA is turned off for sure. */
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(frm_inhwctrl, readVal);
+		if (GET_GBE_FIELD(FRM_INHWCTRL, FRM_DMA_ENABLE, readVal) !=
+		    0) {
+			udelay(10);
+		} else {
+			GBE_GETREG(ovr_inhwctrl, readVal);
+			if (GET_GBE_FIELD
+			    (OVR_INHWCTRL, OVR_DMA_ENABLE, readVal) != 0) {
+				udelay(10);
+			} else {
+				GBE_GETREG(did_inhwctrl, readVal);
+				if (GET_GBE_FIELD
+				    (DID_INHWCTRL, DID_DMA_ENABLE,
+				     readVal) != 0) {
+					udelay(10);
+				} else
+					break;
+			}
+		}
+	}
+	if (i == 10000)
+		printk(KERN_ERR "sgio2fb: turn off DMA timed out\n");
+
+	/* wait for vpixen_off */
+	GBE_GETREG(vt_vpixen, readVal);
+	vpixen_off = GET_GBE_FIELD(VT_VPIXEN, VT_VPIXEN_OFF, readVal);
+
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(vt_xy, readVal);
+		x = GET_GBE_FIELD(VT_XY, VT_X, readVal);
+		y = GET_GBE_FIELD(VT_XY, VT_Y, readVal);
+		if (y < vpixen_off)
+			break;
+		else
+			udelay(1);
+	}
+	if (i == 10000)
+		printk(KERN_ERR
+		       "sgio2fb: wait for vpixen_off timed out\n");
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(vt_xy, readVal);
+		x = GET_GBE_FIELD(VT_XY, VT_X, readVal);
+		y = GET_GBE_FIELD(VT_XY, VT_Y, readVal);
+		if (y > vpixen_off)
+			break;
+		else
+			udelay(1);
+	}
+	if (i == 10000)
+		printk(KERN_ERR
+		       "sgio2fb: wait for vpixen_off timed out\n");
+
+	/* turn off pixel counter */
+	readVal = 0;
+	SET_GBE_FIELD(VT_XY, VT_FREEZE, readVal, 1);
+	GBE_SETREG(vt_xy, readVal);
+	udelay(10000);
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(vt_xy, readVal);
+		if (GET_GBE_FIELD(VT_XY, VT_FREEZE, readVal) != 1)
+			udelay(10);
+		else
+			break;
+	}
+	if (i == 10000)
+		printk(KERN_ERR
+		       "sgio2fb: turn off pixel clock timed out\n");
+
+	/* turn off dot clock */
+	GBE_GETREG(dotclock, readVal);
+	SET_GBE_FIELD(DOTCLK, RUN, readVal, 0);
+	GBE_SETREG(dotclock, readVal);
+	udelay(10000);
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(dotclock, readVal);
+		if (GET_GBE_FIELD(DOTCLK, RUN, readVal) != 0)
+			udelay(10);
+		else
+			break;
+	}
+	if (i == 10000)
+		printk(KERN_ERR "sgio2fb: turn off dotclock timed out\n");
+}
+
+static void gbe_turn_on(void)
+{
+	unsigned int readVal, i;
+
+	/* check if pixel counter is off */
+	GBE_GETREG(vt_xy, readVal);
+	if (GET_GBE_FIELD(VT_XY, VT_FREEZE, readVal) == 0)
+		return;
+
+	/* turn on dot clock */
+	GBE_GETREG(dotclock, readVal);
+	SET_GBE_FIELD(DOTCLK, RUN, readVal, 1);
+	GBE_SETREG(dotclock, readVal);
+	udelay(10000);
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(dotclock, readVal);
+		if (GET_GBE_FIELD(DOTCLK, RUN, readVal) != 1)
+			udelay(10);
+		else
+			break;
+	}
+	if (i == 10000)
+		printk(KERN_ERR "sgio2fb: turn on dotclock timed out\n");
+
+	/* turn on pixel counter */
+	readVal = 0;
+	SET_GBE_FIELD(VT_XY, VT_FREEZE, readVal, 0);
+	GBE_SETREG(vt_xy, readVal);
+	udelay(10000);
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(vt_xy, readVal);
+		if (GET_GBE_FIELD(VT_XY, VT_FREEZE, readVal) != 0)
+			udelay(10);
+		else
+			break;
+	}
+	if (i == 10000)
+		printk(KERN_ERR
+		       "sgio2fb: turn on pixel clock timed out\n");
+
+	/* turn on DMA */
+	GBE_GETREG(frm_control, readVal);
+	SET_GBE_FIELD(FRM_CONTROL, FRM_DMA_ENABLE, readVal, 1);
+	GBE_SETREG(frm_control, readVal);
+	udelay(1000);
+	for (i = 0; i < 10000; i++) {
+		GBE_GETREG(frm_inhwctrl, readVal);
+		if (GET_GBE_FIELD(FRM_INHWCTRL, FRM_DMA_ENABLE, readVal) !=
+		    1)
+			udelay(10);
+		else
+			break;
+	}
+	if (i == 10000)
+		printk(KERN_ERR "sgio2fb: turn on DMA timed out\n");
+}
+
+static void gbe_set_timing_info(gbe_timing_info_t * timing)
+{
+	int temp;
+	u32 val;
+
+	/* setup dot clock PLL */
+	val = 0;
+	SET_GBE_FIELD(DOTCLK, M, val, timing->pll_m - 1);
+	SET_GBE_FIELD(DOTCLK, N, val, timing->pll_n - 1);
+	SET_GBE_FIELD(DOTCLK, P, val, timing->pll_p);
+	SET_GBE_FIELD(DOTCLK, RUN, val, 0);	/* do not start yet */
+	GBE_SETREG(dotclock, val);
+	udelay(10000);
+
+	/* setup pixel counter */
+	val = 0;
+	SET_GBE_FIELD(VT_XYMAX, VT_MAXX, val, timing->htotal);
+	SET_GBE_FIELD(VT_XYMAX, VT_MAXY, val, timing->vtotal);
+	GBE_SETREG(vt_xymax, val);
+
+	/* setup video timing signals */
+	val = 0;
+	SET_GBE_FIELD(VT_VSYNC, VT_VSYNC_ON, val, timing->vsync_start);
+	SET_GBE_FIELD(VT_VSYNC, VT_VSYNC_OFF, val, timing->vsync_end);
+	GBE_SETREG(vt_vsync, val);
+	val = 0;
+	SET_GBE_FIELD(VT_HSYNC, VT_HSYNC_ON, val, timing->hsync_start);
+	SET_GBE_FIELD(VT_HSYNC, VT_HSYNC_OFF, val, timing->hsync_end);
+	GBE_SETREG(vt_hsync, val);
+	val = 0;
+	SET_GBE_FIELD(VT_VBLANK, VT_VBLANK_ON, val, timing->vblank_start);
+	SET_GBE_FIELD(VT_VBLANK, VT_VBLANK_OFF, val, timing->vblank_end);
+	GBE_SETREG(vt_vblank, val);
+	val = 0;
+	SET_GBE_FIELD(VT_HBLANK, VT_HBLANK_ON, val,
+		      timing->hblank_start - 5);
+	SET_GBE_FIELD(VT_HBLANK, VT_HBLANK_OFF, val,
+		      timing->hblank_end - 3);
+	GBE_SETREG(vt_hblank, val);
+
+	/* setup internal timing signals */
+	val = 0;
+	SET_GBE_FIELD(VT_VCMAP, VT_VCMAP_ON, val, timing->vblank_start);
+	SET_GBE_FIELD(VT_VCMAP, VT_VCMAP_OFF, val, timing->vblank_end);
+	GBE_SETREG(vt_vcmap, val);
+	val = 0;
+	SET_GBE_FIELD(VT_HCMAP, VT_HCMAP_ON, val, timing->hblank_start);
+	SET_GBE_FIELD(VT_HCMAP, VT_HCMAP_OFF, val, timing->hblank_end);
+	GBE_SETREG(vt_hcmap, val);
+
+	val = 0;
+	temp = timing->vblank_start - timing->vblank_end - 1;
+	if (temp > 0)
+		temp = -temp;
+
+	SET_GBE_FIELD(DID_START_XY, DID_STARTY, val, (u32) temp);
+	if (timing->hblank_end >= 20)
+		SET_GBE_FIELD(DID_START_XY, DID_STARTX, val,
+			      timing->hblank_end - 20);
+	else
+		SET_GBE_FIELD(DID_START_XY, DID_STARTX, val,
+			      timing->htotal - (20 - timing->hblank_end));
+	GBE_SETREG(did_start_xy, val);
+
+	val = 0;
+	SET_GBE_FIELD(CRS_START_XY, CRS_STARTY, val, (u32) (temp + 1));
+	if (timing->hblank_end >= GBE_CRS_MAGIC)
+		SET_GBE_FIELD(CRS_START_XY, CRS_STARTX, val,
+			      timing->hblank_end - GBE_CRS_MAGIC);
+	else
+		SET_GBE_FIELD(CRS_START_XY, CRS_STARTX, val,
+			      timing->htotal - (GBE_CRS_MAGIC -
+						timing->hblank_end));
+	GBE_SETREG(crs_start_xy, val);
+
+	val = 0;
+	SET_GBE_FIELD(VC_START_XY, VC_STARTY, val, (u32) temp);
+	SET_GBE_FIELD(VC_START_XY, VC_STARTX, val, timing->hblank_end - 4);
+	GBE_SETREG(vc_start_xy, val);
+
+	val = 0;
+	temp = timing->hblank_end - GBE_PIXEN_MAGIC_ON;
+	if (temp < 0)
+		temp += timing->htotal;	/* allow blank to wrap around */
+
+	SET_GBE_FIELD(VT_HPIXEN, VT_HPIXEN_ON, val, temp);
+	SET_GBE_FIELD(VT_HPIXEN, VT_HPIXEN_OFF, val,
+		      ((temp + timing->width -
+			GBE_PIXEN_MAGIC_OFF) % timing->htotal));
+	GBE_SETREG(vt_hpixen, val);
+
+	val = 0;
+	SET_GBE_FIELD(VT_VPIXEN, VT_VPIXEN_ON, val, timing->vblank_end);
+	SET_GBE_FIELD(VT_VPIXEN, VT_VPIXEN_OFF, val, timing->vblank_start);
+	GBE_SETREG(vt_vpixen, val);
+
+	/* turn off sync on green */
+	val = 0;
+	SET_GBE_FIELD(VT_FLAGS, VT_SYNC_LOW, val, 1);
+	GBE_SETREG(vt_flags, val);
+}
+
+/*
+ *  Set the hardware according to 'par'.
+ */
+static void activate_par(struct sgio2fb_par *par)
+{
+	int i;
+	u32 val;
+	int wholeTilesX, partTilesX, maxPixelsPerTileX;
+	int height_pix;
+	int xpmax, ypmax;	/* Monitor resolution */
+	int bytesPerPixel;	/* Bytes per pixel */
+
+	bytesPerPixel = bytes_per_pixel(par->var.bits_per_pixel);
+	xpmax = par->timing.width;
+	ypmax = par->timing.height;
+
+	/* turn off GBE */
+	gbe_turn_off();
+
+	/* set timing info */
+	gbe_set_timing_info(&par->timing);
+
+	/* initialize DIDs */
+	val = 0;
+	switch (bytesPerPixel) {
+	case 1:
+		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_I8);
+		break;
+	case 2:
+		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_ARGB5);
+		break;
+	case 4:
+		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_RGB8);
+		break;
+	}
+	SET_GBE_FIELD(WID, BUF, val, GBE_BMODE_BOTH);
+
+	for (i = 0; i < 32; i++) {
+		GBE_ISETREG(mode_regs, i, val);
+	}
+
+	/* Initialize interrupts */
+	GBE_SETREG(vt_intr01, 0xffffffff);
+	GBE_SETREG(vt_intr23, 0xffffffff);
+
+	/* HACK:
+	   The GBE hardware uses a tiled memory to screen mapping. Tiles are 
+	   blocks of 512x128, 256x128 or 128x128 pixels, respectively for 8bit,
+	   16bit and 32 bit modes (64 kB). They cover the screen with partial
+	   tiles on the right and/or bottom of the screen if needed.
+	   For exemple in 640x480 8 bit mode the mapping is:
+
+	   <-------- 640 ----->
+	   <---- 512 ----><128|384 offscreen>
+	   ^  ^
+	   | 128    [tile 0]        [tile 1]
+	   |  v
+	   ^
+	   4 128    [tile 2]        [tile 3]
+	   8  v
+	   0  ^
+	   128    [tile 4]        [tile 5]
+	   |  v
+	   |  ^
+	   v  96    [tile 6]        [tile 7]
+	   32 offscreen
+
+	   Tiles have the advantage that they can be allocated individually in
+	   memory. However, this mapping is not linear at all, which is not 
+	   really convienient. In order to support linear addressing, the GBE 
+	   DMA hardware is fooled into thinking the screen is only one tile 
+	   large and but has a greater height, so that the DMA transfer covers
+	   the same region.
+	   Tiles are still allocated as independent chunks of 64KB of 
+	   continuous physical memory and remapped so that the kernel sees the
+	   framebuffer as a continuous virtual memory. The GBE tile table is 
+	   set up so that each tile references one of these 64k blocks:
+
+	   GBE -> tile list    framebuffer           TLB   <------------ CPU
+	   [ tile 0 ] -> [ 64KB ]  <- [ 16x 4KB page entries ]     ^
+	   ...           ...              ...       linear virtual FB
+	   [ tile n ] -> [ 64KB ]  <- [ 16x 4KB page entries ]     v
+
+
+	   The GBE hardware is then told that the buffer is 512xtweaked_height,
+	   with tweaked_height = real_widthxreal_height/pixels_per_tile.
+	   Thus the GBE hardware will scan the first tile, filing the first 64k
+	   covered region of the screen, and then will proceed to the next
+	   tile, until the whole screen is covered.
+
+	   Here is what would happen at 640x480 8bit:
+
+	   normal tiling               linear
+	   ^   11111111111111112222    11111111111111111111  ^
+	   128 11111111111111112222    11111111111111111111 102 lines
+	   11111111111111112222    11111111111111111111  v
+	   V   11111111111111112222    11111111222222222222
+	   33333333333333334444    22222222222222222222
+	   33333333333333334444    22222222222222222222
+	   <      512     >        <  256 >               102*640+256 = 64k
+
+	   NOTE: The only mode for which this is not working is 800x600 8bit,
+	   as 800*600/512 = 937.5 which is not integer and thus causes 
+	   flickering.
+	   I guess this is not so important as one can use 640x480 8bit or
+	   800x600 16bit anyway.
+	 */
+
+	/* Tell gbe about the tiles table location */
+	/* tile_ptr -> [ tile 1 ] -> FB mem */
+	/*             [ tile 2 ] -> FB mem */
+	/*               ...                */
+	val = 0;
+	SET_GBE_FIELD(FRM_CONTROL, FRM_TILE_PTR, val,
+		      ((u32) PHYSADDR(sgio2fb_tiles_table)) >> 9);
+	SET_GBE_FIELD(FRM_CONTROL, FRM_DMA_ENABLE, val, 0);	/* do not start yet */
+	GBE_SETREG(frm_control, val);
+
+	maxPixelsPerTileX = 512 / bytesPerPixel;
+	wholeTilesX = 1;
+	partTilesX = 0;
+
+	/* Initialize the framebuffer */
+	val = 0;
+	SET_GBE_FIELD(FRM_SIZE_TILE, FRM_WIDTH_TILE, val, wholeTilesX);
+	SET_GBE_FIELD(FRM_SIZE_TILE, FRM_RHS, val, partTilesX);
+
+	switch (bytesPerPixel) {
+	case 1:
+		SET_GBE_FIELD(FRM_SIZE_TILE, FRM_DEPTH, val,
+			      GBE_FRM_DEPTH_8);
+		break;
+	case 2:
+		SET_GBE_FIELD(FRM_SIZE_TILE, FRM_DEPTH, val,
+			      GBE_FRM_DEPTH_16);
+		break;
+	case 4:
+		SET_GBE_FIELD(FRM_SIZE_TILE, FRM_DEPTH, val,
+			      GBE_FRM_DEPTH_32);
+		break;
+	}
+	GBE_SETREG(frm_size_tile, val);
+
+	/* Compute tweaked height = real width x real height / pixels per tile */
+	height_pix = xpmax * ypmax / maxPixelsPerTileX;
+
+	if (height_pix * maxPixelsPerTileX != xpmax * ypmax)
+		printk(KERN_ERR
+		       "sgio2fb: this mode cannot be mapped linearly. Please use another one.\n");
+
+	val = 0;
+	SET_GBE_FIELD(FRM_SIZE_PIXEL, FB_HEIGHT_PIX, val, height_pix);
+	GBE_SETREG(frm_size_pixel, val);
+
+	/* reset the frame DMA FIFO */
+	GBE_GETREG(frm_size_tile, val);
+	SET_GBE_FIELD(FRM_SIZE_TILE, FRM_FIFO_RESET, val, 1);
+	GBE_SETREG(frm_size_tile, val);
+	SET_GBE_FIELD(FRM_SIZE_TILE, FRM_FIFO_RESET, val, 0);
+	GBE_SETREG(frm_size_tile, val);
+
+	/* turn off DID and overlay DMA */
+	GBE_SETREG(did_control, 0);
+	GBE_SETREG(ovr_width_tile, 0);
+
+	/* Turn off mouse cursor */
+	regs->crs_ctl = 0;
+
+	/* Turn on GBE */
+	gbe_turn_on();
+
+	/* Initialize the gamma map */
+	udelay(10);
+	for (i = 0; i < 256; i++)
+		GBE_ISETREG(gmap, i, (i << 24) | (i << 16) | (i << 8));
+
+	/* Initialize the color map */
+	for (i = 0; i < 256; i++) {
+		int j;
+
+		for (j = 0; j < 1000 && regs->cm_fifo >= 63; j++)
+			udelay(10);
+		if (j == 1000)
+			printk(KERN_ERR "sgio2fb: cmap FIFO timeout\n");
+
+		regs->cmap[i] = (i << 8) | (i << 16) | (i << 24);
+	}
+}
+
+static void sgio2fb_encode_fix(struct fb_fix_screeninfo *fix,
+			       struct fb_var_screeninfo *var)
+{
+	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+	strcpy(fix->id, sgio2fb_name);
+	fix->smem_start = (u_long) sgio2fb_mem;
+	fix->smem_len = sgio2fb_mem_size;
+	fix->type = FB_TYPE_PACKED_PIXELS;
+	fix->type_aux = 0;
+	fix->accel = FB_ACCEL_NONE;
+	switch (var->bits_per_pixel) {
+	case 8:
+		fix->visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	default:
+		fix->visual = FB_VISUAL_TRUECOLOR;
+		break;
+	}
+	fix->ywrapstep = 0;
+	fix->xpanstep = 0;
+	fix->ypanstep = 0;
+	fix->line_length =
+	    get_line_length(var->xres_virtual, var->bits_per_pixel);
+	fix->mmio_start = GBE_REG_PHYS;
+	fix->mmio_len = GBE_REG_SIZE;
+}
+
+/*
+ *  Set a single color register. The values supplied are already
+ *  rounded down to the hardware's capabilities (according to the
+ *  entries in the var structure). Return != 0 for invalid regno.
+ */
+
+static int sgio2fb_setcolreg(u_int regno, u_int red, u_int green,
+			     u_int blue, u_int transp,
+			     struct fb_info *info)
+{
+	int i;
+
+	if (regno > 255)
+		return 1;
+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
+	palette[regno].red = red;
+	palette[regno].green = green;
+	palette[regno].blue = blue;
+
+	switch (video_bpp) {
+#ifdef CONFIG_FBCON_CFB8
+	case 8:
+		/* wait for the color map FIFO to have a free entry */
+		for (i = 0; i < 1000 && regs->cm_fifo >= 63; i++)
+			udelay(10);
+		if (i == 1000) {
+			printk(KERN_ERR "sgio2fb: cmap FIFO timeout\n");
+			return 1;
+		}
+		regs->cmap[regno] =
+		    (red << 24) | (green << 16) | (blue << 8);
+		break;
+#endif
+#ifdef CONFIG_FBCON_CFB16
+	case 15:
+	case 16:
+		red >>= 3;
+		green >>= 3;
+		blue >>= 3;
+		pseudo_palette[regno] =
+		    (red << info->var.red.offset) |
+		    (green << info->var.green.offset) |
+		    (blue << info->var.blue.offset);
+		break;
+#endif
+#ifdef CONFIG_FBCON_CFB32
+	case 32:
+		pseudo_palette[regno] =
+		    (red << info->var.red.offset) |
+		    (green << info->var.green.offset) |
+		    (blue << info->var.blue.offset);
+		break;
+#endif
+	}
+
+	return 0;
+}
+
+static void sgio2fb_set_disp(int con, struct fb_info *info)
+{
+	struct display *display =
+	    (con < 0) ? info->disp : (fb_display + con);
+	display->can_soft_blank = 1;
+	display->dispsw_data = info->pseudo_palette;
+	display->var = info->var;
+
+	/*
+	 * If we are setting all the virtual consoles, also set
+	 * the defaults used to create new consoles
+	 */
+	if (con < 0 || info->var.activate & FB_ACTIVATE_ALL)
+		info->disp->var = info->var;
+
+	display->scrollmode = SCROLL_YREDRAW;
+
+	switch (info->var.bits_per_pixel) {
+#ifdef CONFIG_FBCON_CFB8
+	case 8:
+		display->dispsw = &fbcon_cfb8;
+		break;
+#endif
+#ifdef CONFIG_FBCON_CFB16
+	case 15:
+	case 16:
+		display->dispsw = &fbcon_cfb16;
+		break;
+#endif
+#ifdef CONFIG_FBCON_CFB24
+	case 24:
+		display->dispsw = &fbcon_cfb24;
+		break;
+#endif
+#ifdef CONFIG_FBCON_CFB32
+	case 32:
+		display->dispsw = &fbcon_cfb32;
+		break;
+#endif
+	default:
+		display->dispsw = &fbcon_dummy;
+		break;
+	}
+}
+
+/*
+ *  Set the User Defined Part of the Display. Again if par use it to get
+ *  real video mode.
+ */
+static int sgio2fb_set_var(struct fb_var_screeninfo *var, int con,
+			   struct fb_info *info)
+{
+	int err, activate = var->activate;
+	int pll_m, pll_n, pll_p, error, best_m, best_n, best_p, best_error;
+	int oldxres, oldyres, oldvxres, oldvyres, oldbpp;
+	u_long line_length;
+
+	struct gbe_timing_info *timing;
+
+	struct display *display;
+
+	if (con >= 0)
+		display = &fb_display[con];
+	else
+		display = &disp;	/* used during initialization */
+
+	/*
+	 *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
+	 *  as FB_VMODE_SMOOTH_XPAN is only used internally
+	 */
+
+	if (var->vmode & FB_VMODE_CONUPDATE) {
+		var->xoffset = display->var.xoffset;
+		var->yoffset = display->var.yoffset;
+	}
+
+	/* XXX FIXME - forcing var's */
+	var->xoffset = 0;
+	var->yoffset = 0;
+
+	/* Limit bpp to 8, 16, and 32 */
+	if (var->bits_per_pixel <= 8)
+		var->bits_per_pixel = 8;
+	else if (var->bits_per_pixel <= 16)
+		var->bits_per_pixel = 16;
+	else if (var->bits_per_pixel <= 32)
+		var->bits_per_pixel = 32;
+	else
+		return -EINVAL;
+
+	video_bpp = var->bits_per_pixel;
+
+	var->grayscale = 0;	/* No grayscale for now */
+
+	/* Determine valid resolution and timing */
+	/* GBE crystal runs at 20Mhz */
+	/* pll_m, pll_n, pll_p define the following frequencies */
+	/* fvco = pll_m * 20Mhz / pll_n */
+	/* fout = fvco / (2**pll_p) */
+	best_error = 1000000000;
+	best_n = best_m = best_p = 0;
+	for (pll_p = 0; pll_p < 4; pll_p++)
+		for (pll_m = 1; pll_m < 256; pll_m++)
+			for (pll_n = 1; pll_n < 64; pll_n++) {
+				error =
+				    var->pixclock -
+				    (1000000 / GBE_CLOCK_RATE) *
+				    (pll_n << pll_p) / pll_m;
+				if (error < 0)
+					error = -error;
+				if (error < best_error && pll_m / pll_n > 4
+				    && pll_m / pll_n < 11) {
+					/* fvco must be within [80-220] Mhz */
+					best_error = error;
+					best_m = pll_m;
+					best_n = pll_n;
+					best_p = pll_p;
+				}
+			}
+
+	if (!best_n || !best_m)
+		return -EINVAL;	/* Resolution to high */
+
+	/* Adjust virtual resolution, if necessary */
+	if (var->xres > var->xres_virtual || (!ywrap && !ypan))
+		var->xres_virtual = var->xres;
+	if (var->yres > var->yres_virtual || (!ywrap && !ypan))
+		var->yres_virtual = var->yres;
+
+	/*
+	 *  Scale memory
+	 */
+	line_length =
+	    get_line_length(var->xres_virtual, var->bits_per_pixel);
+	if (line_length * var->yres_virtual > sgio2fb_mem_size)
+		return -ENOMEM;	/* Virtual resolution too high */
+#ifdef CONFIG_FB_SGIO2_DYNAMIC
+	if (resize_fb(line_length * var->yres_virtual))
+		return -ENOMEM;	/* Couldn't resize framebuffer */
+#endif
+
+	switch (var->bits_per_pixel) {
+	case 8:
+		var->red.offset = 0;
+		var->red.length = 8;
+		var->green.offset = 0;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 16:		/* RGB 1555 */
+		var->red.offset = 10;
+		var->red.length = 5;
+		var->green.offset = 5;
+		var->green.length = 5;
+		var->blue.offset = 0;
+		var->blue.length = 5;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 32:		/* RGB 8888 */
+		var->red.offset = 24;
+		var->red.length = 8;
+		var->green.offset = 16;
+		var->green.length = 8;
+		var->blue.offset = 8;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 8;
+		break;
+	}
+	var->red.msb_right = 0;
+	var->green.msb_right = 0;
+	var->blue.msb_right = 0;
+	var->transp.msb_right = 0;
+
+	if ((activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
+		/* set video timing information */
+		timing = &par_current.timing;
+		timing->width = var->xres;
+		timing->height = var->yres;
+		timing->pll_m = best_m;
+		timing->pll_n = best_n;
+		timing->pll_p = best_p;
+		timing->cfreq =
+		    20000 * timing->pll_m /
+		    (timing->pll_n << timing->pll_p);
+		timing->htotal =
+		    var->left_margin + var->xres + var->right_margin +
+		    var->hsync_len;
+		timing->vtotal =
+		    var->upper_margin + var->yres + var->lower_margin +
+		    var->vsync_len;
+		timing->fields_sec =
+		    1000 * timing->cfreq / timing->htotal * 1000 /
+		    timing->vtotal;
+		timing->hblank_start = var->xres;
+		timing->vblank_start = var->yres;
+		timing->hblank_end = timing->htotal;
+		timing->hsync_start = var->xres + var->right_margin + 1;
+		timing->hsync_end = timing->hsync_start + var->hsync_len;
+		timing->vblank_end = timing->vtotal;
+		timing->vsync_start = var->yres + var->lower_margin + 1;
+		timing->vsync_end = timing->vsync_start + var->vsync_len;
+
+		printk(KERN_DEBUG "sgio2fb: granted dot-clock=%d KHz\n",
+		       timing->cfreq);
+
+		oldxres = display->var.xres;
+		oldyres = display->var.yres;
+		oldvxres = display->var.xres_virtual;
+		oldvyres = display->var.yres_virtual;
+		oldbpp = display->var.bits_per_pixel;
+		display->var = *var;
+		par_current.var = *var;
+
+		if (oldxres != var->xres || oldyres != var->yres ||
+		    oldvxres != var->xres_virtual
+		    || oldvyres != var->yres_virtual
+		    || oldbpp != var->bits_per_pixel
+		    || !par_current.valid) {
+			struct fb_fix_screeninfo fix;
+			printk(KERN_DEBUG
+			       "sgio2fb: new video mode xres=%d yres=%d bpp=%d\n",
+			       var->xres, var->yres, var->bits_per_pixel);
+			activate_par(&par_current);
+			sgio2fb_encode_fix(&fix, var);
+
+			display->can_soft_blank = 1;
+			display->inverse = 0;
+			if (oldbpp != var->bits_per_pixel
+			    || !par_current.valid) {
+				if ((err =
+				     fb_alloc_cmap(&display->cmap, 0, 0)))
+					return err;
+				do_install_cmap(con, info);
+			}
+			sgio2fb_set_disp(con, info);
+			par_current.valid = 1;
+			if (fb_info.changevar)
+				(*fb_info.changevar) (con);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * (Supposedly) Accelerated routines.
+ * FIXME: Needs to be written, currently use cfb
+ */
+static void sgio2fb_fillrect(struct fb_info *p, struct fb_fillrect *region)
+{
+}
+static void sgio2fb_copyarea(struct fb_info *p, struct fb_copyarea *area)
+{
+}
+static void sgio2fb_imageblit(struct fb_info *p, struct fb_image *image)
+{
+}
+
+void sgio2fb_vma_open(struct vm_area_struct *vma)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void sgio2fb_vma_close(struct vm_area_struct *vma)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+static int sgio2fb_mmap(struct fb_info *info, struct file *file,
+			struct vm_area_struct *vma)
+{
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long addr;
+	unsigned long phys_addr, phys_size;
+	u16 *tile;
+
+	/* check range */
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+	if (offset + size > sgio2fb_mem_size)
+		return -EINVAL;
+	/* map cacheable write-through no write allocate */
+	/* XXX: try UNCACHED_ACCELERATED on R10000 */
+	pgprot_val(vma->vm_page_prot) =
+	    (pgprot_val(vma->vm_page_prot) & (~_CACHE_MASK)) |
+	    _CACHE_CACHABLE_NO_WA;
+	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_ops = &sgio2fb_vm_ops;
+	vma->vm_file = file;
+	sgio2fb_vma_open(vma);
+
+	/* look for the starting tile */
+	tile = &sgio2fb_tiles_table[offset >> TILE_SHIFT];
+	addr = vma->vm_start;
+	offset &= TILE_MASK;
+
+	/* map tiles */
+	do {
+		phys_addr =
+		    (((unsigned long) (*tile)) << TILE_SHIFT) + offset;
+		if ((offset + size) < TILE_SIZE)
+			phys_size = size;
+		else
+			phys_size = TILE_SIZE - offset;
+
+		if (remap_page_range
+		    (vma, addr, phys_addr, phys_size, vma->vm_page_prot))
+			return -EAGAIN;
+
+		offset = 0;
+		size -= phys_size;
+		addr += phys_size;
+		tile++;
+	} while (size);
+
+	printk(KERN_DEBUG "sgio2fb: mmap framebuffer P(%lx)->V(%lx)\n",
+	       offset, vma->vm_start);
+
+	return 0;
+}
+
+/*
+ * Initialization
+ */
+
+int __init sgio2fb_setup(char *options)
+{
+	char *this_opt;
+
+	fb_info.fontname[0] = '\0';
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!strncmp(this_opt, "font:", 5))
+			strcpy(fb_info.fontname, this_opt + 5);
+		else if (!strncmp(this_opt, "mem:", 4)) {
+			sgio2fb_mem_size =
+			    memparse(this_opt + 4, &this_opt);
+			if (sgio2fb_mem_size >
+			    CONFIG_FB_SGIO2_MEM * 1024 * 1024)
+				sgio2fb_mem_size =
+				    CONFIG_FB_SGIO2_MEM * 1024 * 1024;
+			if (sgio2fb_mem_size < TILE_SIZE)
+				sgio2fb_mem_size = TILE_SIZE;
+		} else
+			mode_option = this_opt;
+	}
+	return 0;
+}
+
+int __init sgio2fb_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "sgio2fb: initializing\n");
+
+	if ((ret = prepare_fb(sgio2fb_mem_size)) < 0) {
+		printk(KERN_ERR
+		       "sgio2fb: couldn't initialize framebuffer\n");
+		return ret;
+	}
+
+	printk(KERN_INFO "sgio2fb: I/O at 0x%08lx\n", GBE_REG_PHYS);
+	printk(KERN_INFO "sgio2fb: tiles at %p\n", sgio2fb_tiles_table);
+	printk(KERN_INFO "sgio2fb: framebuffer at %p\n", sgio2fb_mem);
+	printk(KERN_INFO "sgio2fb: %ldkB memory\n",
+	       sgio2fb_mem_size >> 10);
+
+	regs = (asregs *) GBE_REG_PHYS;
+
+	strcpy(fb_info.modename, sgio2fb_name);
+	fb_info.changevar = NULL;
+	fb_info.currcon = -1;
+	fb_info.node = mk_kdev(FB_MAJOR, 0);
+	fb_info.fbops = &sgio2fb_ops;
+	fb_info.pseudo_palette = pseudo_palette;
+	fb_info.disp = &disp;
+	fb_info.switch_con = gen_switch;
+	fb_info.updatevar = gen_update_var;
+	fb_info.flags = FBINFO_FLAG_DEFAULT;
+
+	fb_info.var = default_var;
+	sgio2fb_encode_fix(&fb_info.fix, &fb_info.var);
+
+	fb_info.screen_base = sgio2fb_mem;
+
+	/* reset GBE */
+	gbe_reset();
+
+	/* turn on default video mode */
+	if (fb_find_mode(&par_current.var, &fb_info, mode_option, NULL, 0,
+			 &defaultmode, 8) == 0)
+		par_current.var = default_var;
+	sgio2fb_set_var(&par_current.var, -1, &fb_info);
+	sgio2fb_set_disp(-1, &fb_info);
+
+	if (register_framebuffer(&fb_info) < 0) {
+		printk(KERN_ERR
+		       "sgio2fb: couldn't register framebuffer\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+/*
+ *  Blank the display.
+ */
+static int sgio2fbcon_blank(int blank, struct fb_info *info)
+{
+	/* 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off */
+	switch (blank) {
+	case 0:		/* unblank */
+		gbe_turn_on();
+		break;
+
+	case 1:		/* blank */
+		gbe_turn_off();
+		break;
+
+	default:
+		/* Nothing */
+		break;
+	}
+	return 0;
+}
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return sgio2fb_init();
+}
+
+void cleanup_module(void)
+{
+	unregister_framebuffer(&fb_info);
+	gbe_turn_off();
+#ifdef CONFIG_FB_SGIO2_DYNAMIC
+	free_fb(fbmem);
+#endif
+}
+
+#endif				/* MODULE */
--- drivers/video/sgio2fb.h	1970-01-01 01:00:00.000000000 +0100
+++ drivers/video/sgio2fb.h	2002-12-08 02:00:02.000000000 +0100
@@ -0,0 +1,333 @@
+/*
+ *  linux/drivers/video/sgio2fb.h -- SGI GBE frame buffer device header
+ *
+ *      Copyright (C) 2002 Vivien Chappelier, vivien.chappelier@linux-mips.org
+ *	 Derived from sgivwfb.h by Jeffrey Newquist
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef __SGIO2FB_H__
+#define __SGIO2FB_H__
+
+#include <asm/ip32/crime.h>
+#include <asm/addrspace.h>
+
+#define GBE_GETREG(reg, dest)       ((dest) = GBE_REG_BASE->##reg)
+#define GBE_SETREG(reg, src)        (GBE_REG_BASE->##reg = (src))
+#define GBE_IGETREG(reg, idx, dest) ((dest) = GBE_REG_BASE->##reg##[idx])
+#define GBE_ISETREG(reg, idx, src)  (GBE_REG_BASE->##reg##[idx] = (src))
+
+#define MASK(msb, lsb)          ( (((u32)1<<((msb)-(lsb)+1))-1) << (lsb) )
+#define GET(v, msb, lsb)        ( ((u32)(v) & MASK(msb,lsb)) >> (lsb) )
+#define SET(v, f, msb, lsb)     ( (v) = ((v)&~MASK(msb,lsb)) | (( (u32)(f)<<(lsb) ) & MASK(msb,lsb)) )
+
+#define GET_GBE_FIELD(reg, field, v)        GET((v), GBE_##reg##_##field##_MSB, GBE_##reg##_##field##_LSB)
+#define SET_GBE_FIELD(reg, field, v, f)     SET((v), (f), GBE_##reg##_##field##_MSB, GBE_##reg##_##field##_LSB)
+
+/* NOTE: All loads/stores must be 32 bits and uncached */
+
+#define GBE_REG_PHYS	KSEG1ADDR(0x16000000)
+#define GBE_REG_SIZE    0x01000000
+
+typedef struct {
+	volatile u32 ctrlstat;	/* 0x000000 general control */
+	volatile u32 dotclock;	/* 0x000004 dot clock PLL control */
+	volatile u32 i2c;	/* 0x000008 crt I2C control */
+	volatile u32 sysclk;	/* 0x00000c system clock PLL control */
+	volatile u32 i2cfp;	/* 0x000010 flat panel I2C control */
+	volatile u32 id;	/* 0x000014 device id/chip revision */
+
+	char _pad0[0x010000 - 0x000018];
+
+	volatile u32 vt_xy;	/* 0x010000 current dot coords */
+	volatile u32 vt_xymax;	/* 0x010004 maximum dot coords */
+	volatile u32 vt_vsync;	/* 0x010008 vsync on/off */
+	volatile u32 vt_hsync;	/* 0x01000c hsync on/off */
+	volatile u32 vt_vblank;	/* 0x010010 vblank on/off */
+	volatile u32 vt_hblank;	/* 0x010014 hblank on/off */
+	volatile u32 vt_flags;	/* 0x010018 polarity of vt signals */
+	volatile u32 vt_f2rf_lock;	/* 0x01001c f2rf & framelck y coord */
+	volatile u32 vt_intr01;	/* 0x010020 intr 0,1 y coords */
+	volatile u32 vt_intr23;	/* 0x010024 intr 2,3 y coords */
+	volatile u32 fp_hdrv;	/* 0x010028 flat panel hdrv on/off */
+	volatile u32 fp_vdrv;	/* 0x01002c flat panel vdrv on/off */
+	volatile u32 fp_de;	/* 0x010030 flat panel de on/off */
+	volatile u32 vt_hpixen;	/* 0x010034 intrnl horiz pixel on/off */
+	volatile u32 vt_vpixen;	/* 0x010038 intrnl vert pixel on/off */
+	volatile u32 vt_hcmap;	/* 0x01003c cmap write (horiz) */
+	volatile u32 vt_vcmap;	/* 0x010040 cmap write (vert) */
+	volatile u32 did_start_xy;	/* 0x010044 eol/f did/xy reset val */
+	volatile u32 crs_start_xy;	/* 0x010048 eol/f crs/xy reset val */
+	volatile u32 vc_start_xy;	/* 0x01004c eol/f vc/xy reset val */
+
+	char _pad1[0x020000 - 0x010050];
+
+	volatile u32 ovr_width_tile;	/* 0x020000 overlay plane ctrl 0 */
+	volatile u32 ovr_inhwctrl;	/* 0x020004 overlay plane ctrl 1 */
+	volatile u32 ovr_control;	/* 0x020008 overlay plane ctrl 1 */
+
+	char _pad2[0x030000 - 0x02000C];
+
+	volatile u32 frm_size_tile;	/* 0x030000 normal plane ctrl 0 */
+	volatile u32 frm_size_pixel;	/* 0x030004 normal plane ctrl 1 */
+	volatile u32 frm_inhwctrl;	/* 0x030008 normal plane ctrl 2 */
+	volatile u32 frm_control;	/* 0x03000C normal plane ctrl 3 */
+
+	char _pad3[0x040000 - 0x030010];
+
+	volatile u32 did_inhwctrl;	/* 0x040000 DID control */
+	volatile u32 did_control;	/* 0x040004 DID shadow */
+
+	char _pad4[0x048000 - 0x040008];
+
+	volatile u32 mode_regs[32];	/* 0x048000 - 0x04807c WID table */
+
+	char _pad5[0x050000 - 0x048080];
+
+	volatile u32 cmap[6144];	/* 0x050000 - 0x055ffc color map */
+
+	char _pad6[0x058000 - 0x056000];
+
+	volatile u32 cm_fifo;	/* 0x058000 color map fifo status */
+
+	char _pad7[0x060000 - 0x058004];
+
+	volatile u32 gmap[256];	/* 0x060000 - 0x0603fc gamma map */
+
+	char _pad8[0x068000 - 0x060400];
+
+	volatile u32 gmap10[1024];	/* 0x068000 - 0x068ffc gamma map */
+
+	char _pad9[0x070000 - 0x069000];
+
+	volatile u32 crs_pos;	/* 0x070000 cusror control 0 */
+	volatile u32 crs_ctl;	/* 0x070004 cusror control 1 */
+	volatile u32 crs_cmap[3];	/* 0x070008 - 0x070010 crs cmap */
+
+	char _pad10[0x078000 - 0x070014];
+
+	volatile u32 crs_glyph[64];	/* 0x078000 - 0x0780fc crs glyph */
+
+	char _pad11[0x080000 - 0x078100];
+
+	volatile u32 vc_0;	/* 0x080000 video capture crtl 0 */
+	volatile u32 vc_1;	/* 0x080004 video capture crtl 1 */
+	volatile u32 vc_2;	/* 0x080008 video capture crtl 2 */
+	volatile u32 vc_3;	/* 0x08000c video capture crtl 3 */
+	volatile u32 vc_4;	/* 0x080010 video capture crtl 4 */
+	volatile u32 vc_5;	/* 0x080014 video capture crtl 5 */
+	volatile u32 vc_6;	/* 0x080018 video capture crtl 6 */
+	volatile u32 vc_7;	/* 0x08001c video capture crtl 7 */
+	volatile u32 vc_8;	/* 0x080020 video capture crtl 8 */
+} asregs;
+
+/* Bit mask information */
+
+#define GBE_CTRLSTAT_CHIPID_MSB     3
+#define GBE_CTRLSTAT_CHIPID_LSB     0
+#define GBE_CTRLSTAT_SENSE_N_MSB    4
+#define GBE_CTRLSTAT_SENSE_N_LSB    4
+#define GBE_CTRLSTAT_PCLKSEL_MSB    29
+#define GBE_CTRLSTAT_PCLKSEL_LSB    28
+
+#define GBE_DOTCLK_M_MSB            7
+#define GBE_DOTCLK_M_LSB            0
+#define GBE_DOTCLK_N_MSB            13
+#define GBE_DOTCLK_N_LSB            8
+#define GBE_DOTCLK_P_MSB            15
+#define GBE_DOTCLK_P_LSB            14
+#define GBE_DOTCLK_RUN_MSB          20
+#define GBE_DOTCLK_RUN_LSB          20
+
+#define GBE_VT_XY_VT_Y_MSB     23
+#define GBE_VT_XY_VT_Y_LSB     12
+#define GBE_VT_XY_VT_X_MSB     11
+#define GBE_VT_XY_VT_X_LSB     0
+#define GBE_VT_XY_VT_FREEZE_MSB     31
+#define GBE_VT_XY_VT_FREEZE_LSB     31
+
+#define GBE_VT_VSYNC_VT_VSYNC_ON_MSB        23
+#define GBE_VT_VSYNC_VT_VSYNC_ON_LSB        12
+#define GBE_VT_VSYNC_VT_VSYNC_OFF_MSB       11
+#define GBE_VT_VSYNC_VT_VSYNC_OFF_LSB       0
+
+#define GBE_VT_HSYNC_VT_HSYNC_ON_MSB        23
+#define GBE_VT_HSYNC_VT_HSYNC_ON_LSB        12
+#define GBE_VT_HSYNC_VT_HSYNC_OFF_MSB       11
+#define GBE_VT_HSYNC_VT_HSYNC_OFF_LSB       0
+
+#define GBE_VT_VBLANK_VT_VBLANK_ON_MSB        23
+#define GBE_VT_VBLANK_VT_VBLANK_ON_LSB        12
+#define GBE_VT_VBLANK_VT_VBLANK_OFF_MSB       11
+#define GBE_VT_VBLANK_VT_VBLANK_OFF_LSB       0
+
+#define GBE_VT_HBLANK_VT_HBLANK_ON_MSB        23
+#define GBE_VT_HBLANK_VT_HBLANK_ON_LSB        12
+#define GBE_VT_HBLANK_VT_HBLANK_OFF_MSB       11
+#define GBE_VT_HBLANK_VT_HBLANK_OFF_LSB       0
+
+#define GBE_VT_FLAGS_VT_F2RF_HIGH_MSB    6
+#define GBE_VT_FLAGS_VT_F2RF_HIGH_LSB    6
+#define GBE_VT_FLAGS_VT_SYNC_LOW_MSB     5
+#define GBE_VT_FLAGS_VT_SYNC_LOW_LSB     5
+#define GBE_VT_FLAGS_VT_SYNC_HIGH_MSB    4
+#define GBE_VT_FLAGS_VT_SYNC_HIGH_LSB    4
+#define GBE_VT_FLAGS_VT_HDRV_LOW_MSB     3
+#define GBE_VT_FLAGS_VT_HDRV_LOW_LSB     3
+#define GBE_VT_FLAGS_VT_HDRV_INVERT_MSB  2
+#define GBE_VT_FLAGS_VT_HDRV_INVERT_LSB  2
+#define GBE_VT_FLAGS_VT_VDRV_LOW_MSB     1
+#define GBE_VT_FLAGS_VT_VDRV_LOW_LSB     1
+#define GBE_VT_FLAGS_VT_VDRV_INVERT_MSB  0
+#define GBE_VT_FLAGS_VT_VDRV_INVERT_LSB  0
+
+#define GBE_VT_VCMAP_VT_VCMAP_ON_MSB        23
+#define GBE_VT_VCMAP_VT_VCMAP_ON_LSB        12
+#define GBE_VT_VCMAP_VT_VCMAP_OFF_MSB       11
+#define GBE_VT_VCMAP_VT_VCMAP_OFF_LSB       0
+
+#define GBE_VT_HCMAP_VT_HCMAP_ON_MSB        23
+#define GBE_VT_HCMAP_VT_HCMAP_ON_LSB        12
+#define GBE_VT_HCMAP_VT_HCMAP_OFF_MSB       11
+#define GBE_VT_HCMAP_VT_HCMAP_OFF_LSB       0
+
+#define GBE_VT_XYMAX_VT_MAXX_MSB    11
+#define GBE_VT_XYMAX_VT_MAXX_LSB    0
+#define GBE_VT_XYMAX_VT_MAXY_MSB    23
+#define GBE_VT_XYMAX_VT_MAXY_LSB    12
+
+#define GBE_VT_HPIXEN_VT_HPIXEN_ON_MSB      23
+#define GBE_VT_HPIXEN_VT_HPIXEN_ON_LSB      12
+#define GBE_VT_HPIXEN_VT_HPIXEN_OFF_MSB     11
+#define GBE_VT_HPIXEN_VT_HPIXEN_OFF_LSB     0
+
+#define GBE_VT_VPIXEN_VT_VPIXEN_ON_MSB      23
+#define GBE_VT_VPIXEN_VT_VPIXEN_ON_LSB      12
+#define GBE_VT_VPIXEN_VT_VPIXEN_OFF_MSB     11
+#define GBE_VT_VPIXEN_VT_VPIXEN_OFF_LSB     0
+
+#define GBE_OVR_CONTROL_OVR_DMA_ENABLE_MSB  0
+#define GBE_OVR_CONTROL_OVR_DMA_ENABLE_LSB  0
+
+#define GBE_OVR_INHWCTRL_OVR_DMA_ENABLE_MSB 0
+#define GBE_OVR_INHWCTRL_OVR_DMA_ENABLE_LSB 0
+
+#define GBE_OVR_WIDTH_TILE_OVR_FIFO_RESET_MSB       13
+#define GBE_OVR_WIDTH_TILE_OVR_FIFO_RESET_LSB       13
+
+#define GBE_FRM_CONTROL_FRM_DMA_ENABLE_MSB  0
+#define GBE_FRM_CONTROL_FRM_DMA_ENABLE_LSB  0
+#define GBE_FRM_CONTROL_FRM_TILE_PTR_MSB    31
+#define GBE_FRM_CONTROL_FRM_TILE_PTR_LSB    9
+#define GBE_FRM_CONTROL_FRM_LINEAR_MSB      1
+#define GBE_FRM_CONTROL_FRM_LINEAR_LSB      1
+
+#define GBE_FRM_INHWCTRL_FRM_DMA_ENABLE_MSB 0
+#define GBE_FRM_INHWCTRL_FRM_DMA_ENABLE_LSB 0
+
+#define GBE_FRM_SIZE_TILE_FRM_WIDTH_TILE_MSB        12
+#define GBE_FRM_SIZE_TILE_FRM_WIDTH_TILE_LSB        5
+#define GBE_FRM_SIZE_TILE_FRM_RHS_MSB       4
+#define GBE_FRM_SIZE_TILE_FRM_RHS_LSB       0
+#define GBE_FRM_SIZE_TILE_FRM_DEPTH_MSB     14
+#define GBE_FRM_SIZE_TILE_FRM_DEPTH_LSB     13
+#define GBE_FRM_SIZE_TILE_FRM_FIFO_RESET_MSB        15
+#define GBE_FRM_SIZE_TILE_FRM_FIFO_RESET_LSB        15
+
+#define GBE_FRM_SIZE_PIXEL_FB_HEIGHT_PIX_MSB        31
+#define GBE_FRM_SIZE_PIXEL_FB_HEIGHT_PIX_LSB        16
+
+#define GBE_DID_CONTROL_DID_DMA_ENABLE_MSB  0
+#define GBE_DID_CONTROL_DID_DMA_ENABLE_LSB  0
+#define GBE_DID_INHWCTRL_DID_DMA_ENABLE_MSB 0
+#define GBE_DID_INHWCTRL_DID_DMA_ENABLE_LSB 0
+
+#define GBE_DID_START_XY_DID_STARTY_MSB     23
+#define GBE_DID_START_XY_DID_STARTY_LSB     12
+#define GBE_DID_START_XY_DID_STARTX_MSB     11
+#define GBE_DID_START_XY_DID_STARTX_LSB     0
+
+#define GBE_CRS_START_XY_CRS_STARTY_MSB     23
+#define GBE_CRS_START_XY_CRS_STARTY_LSB     12
+#define GBE_CRS_START_XY_CRS_STARTX_MSB     11
+#define GBE_CRS_START_XY_CRS_STARTX_LSB     0
+
+#define GBE_WID_AUX_MSB    12
+#define GBE_WID_AUX_LSB    11
+#define GBE_WID_GAMMA_MSB  10
+#define GBE_WID_GAMMA_LSB  10
+#define GBE_WID_CM_MSB      9
+#define GBE_WID_CM_LSB      5
+#define GBE_WID_TYP_MSB     4
+#define GBE_WID_TYP_LSB     2
+#define GBE_WID_BUF_MSB     1
+#define GBE_WID_BUF_LSB     0
+
+#define GBE_VC_START_XY_VC_STARTY_MSB       23
+#define GBE_VC_START_XY_VC_STARTY_LSB       12
+#define GBE_VC_START_XY_VC_STARTX_MSB       11
+#define GBE_VC_START_XY_VC_STARTX_LSB       0
+
+/* Constants */
+
+#define GBE_FRM_DEPTH_8     0
+#define GBE_FRM_DEPTH_16    1
+#define GBE_FRM_DEPTH_32    2
+
+#define GBE_CMODE_I8        0
+#define GBE_CMODE_I12       1
+#define GBE_CMODE_RG3B2     2
+#define GBE_CMODE_RGB4      3
+#define GBE_CMODE_ARGB5     4
+#define GBE_CMODE_RGB8      5
+#define GBE_CMODE_RGBA5     6
+#define GBE_CMODE_RGB10     7
+
+#define GBE_BMODE_BOTH      3
+
+#define GBE_CRS_MAGIC       54
+#define GBE_PIXEN_MAGIC_ON  19
+#define GBE_PIXEN_MAGIC_OFF  2
+
+#define GBE_CLOCK_RATE      20	/* PLL Clock runs at 20Mhz */
+
+#define GBE_TLB_SIZE       128
+
+/*
+ * Crime Video Timing Data Structure
+ */
+
+typedef struct gbe_timing_info {
+	int flags;
+	short width;		/* Monitor resolution               */
+	short height;
+	int fields_sec;		/* fields/sec  (Hz -3 dec. places */
+	int cfreq;		/* pixel clock frequency (MHz -3 dec. places) */
+	short htotal;		/* Horizontal total pixels  */
+	short hblank_start;	/* Horizontal blank start   */
+	short hblank_end;	/* Horizontal blank end             */
+	short hsync_start;	/* Horizontal sync start    */
+	short hsync_end;	/* Horizontal sync end              */
+	short vtotal;		/* Vertical total lines             */
+	short vblank_start;	/* Vertical blank start             */
+	short vblank_end;	/* Vertical blank end               */
+	short vsync_start;	/* Vertical sync start              */
+	short vsync_end;	/* Vertical sync end                */
+	short pll_m;		/* PLL M parameter          */
+	short pll_n;		/* PLL P parameter          */
+	short pll_p;		/* PLL N parameter          */
+} gbe_timing_info_t;
+
+/* Defines for gbe_vof_info_t flags */
+
+#define GBE_VOF_UNKNOWNMON    1
+#define GBE_VOF_STEREO        2
+#define GBE_VOF_DO_GENSYNC    4	/* enable incoming sync */
+#define GBE_VOF_SYNC_ON_GREEN 8	/* sync on green */
+#define GBE_VOF_FLATPANEL     0x1000	/* FLATPANEL Timing */
+#define GBE_VOF_MAGICKEY      0x2000	/* Backdoor key */
+
+#endif				// ! __SGIO2FB_H__
--- include/asm-mips64/ip32/tile.h	1970-01-01 01:00:00.000000000 +0100
+++ include/asm-mips64/ip32/tile.h	2002-12-08 00:56:09.000000000 +0100
@@ -0,0 +1,18 @@
+/*
+ * Definitions for the SGI O2 tiles
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002 Vivien Chappelier
+ */
+
+#ifndef __ASM_IP32_TILE_H__
+#define __ASM_IP32_TILE_H__
+
+#define TILE_SHIFT 16 
+#define TILE_SIZE (1 << TILE_SHIFT)
+#define TILE_MASK (TILE_SIZE - 1)
+
+#endif /* __ASM_IP32_TILE_H__ */
