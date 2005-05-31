Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 14:28:08 +0100 (BST)
Received: from RT-soft-1.Moscow.itn.ru ([IPv6:::ffff:80.240.96.90]:32655 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225784AbVEaN1r>; Tue, 31 May 2005 14:27:47 +0100
Received: from 192.168.1.226 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j4VDRXt04835;
	Tue, 31 May 2005 18:27:33 +0500
Subject: [PATCH] A video driver for Lynx3DM on NEC VR5701-SG2 Board.
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	adaplas@pol.net
Cc:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-GzVKVITUotwBchgfD2st"
Organization: MontaVista
Date:	Tue, 31 May 2005 17:27:51 +0400
Message-Id: <1117546071.5564.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-GzVKVITUotwBchgfD2st
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Antonio!

Attached is a video driver for Lynx3DM SM722, Silicon Motion Inc. It was
designed for NEC VR5701-SG2 Board, MIPS-CPU Vr5701. Please review it.

Best wishes,
Sergey Podstavin.

--=-GzVKVITUotwBchgfD2st
Content-Disposition: attachment; filename=community_mips_nec_vr5701_video_lynx3dm.patch
Content-Type: text/x-patch; name=community_mips_nec_vr5701_video_lynx3dm.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naurp --exclude=CVS linux_save/drivers/video/Kconfig linux_mips/drivers/video/Kconfig
--- linux_save/drivers/video/Kconfig	2005-05-19 16:08:32.000000000 +0400
+++ linux_mips/drivers/video/Kconfig	2005-05-31 17:00:36.000000000 +0400
@@ -1027,6 +1027,25 @@ config FB_ATY_GX
 	  is at
 	  <http://support.ati.com/products/pc/mach64/graphics_xpression.html>.
 
+config FB_SM
+	tristate "Silicon Motion SM722 support"
+	depends on FB && PCI
+	help
+	  SM722
+
+choice
+	prompt "Display size"
+	depends on FB_SM
+	default DISPLAY_640x480
+
+config DISPLAY_640x480
+	bool "640x480"
+
+config DISPLAY_1024x768
+	bool "1024x768"
+
+endchoice
+
 config FB_SAVAGE
 	tristate "S3 Savage support"
 	depends on FB && PCI && EXPERIMENTAL
diff -Naurp --exclude=CVS linux_save/drivers/video/Makefile linux_mips/drivers/video/Makefile
--- linux_save/drivers/video/Makefile	2005-05-19 16:08:32.000000000 +0400
+++ linux_mips/drivers/video/Makefile	2005-05-31 17:03:40.000000000 +0400
@@ -38,6 +38,7 @@ obj-$(CONFIG_FB_KYRO)             += kyr
 obj-$(CONFIG_FB_SAVAGE)		  += savage/
 obj-$(CONFIG_FB_GEODE)		  += geode/
 obj-$(CONFIG_FB_I810)             += vgastate.o
+obj-$(CONFIG_FB_SM)               += smi/ cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_RADEON_OLD)	  += radeonfb.o
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o vgastate.o
 obj-$(CONFIG_FB_VIRGE)            += virgefb.o
diff -Naurp --exclude=CVS linux_save/drivers/video/smi/Makefile linux_mips/drivers/video/smi/Makefile
--- linux_save/drivers/video/smi/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/drivers/video/smi/Makefile	2005-05-31 17:00:36.000000000 +0400
@@ -0,0 +1,9 @@
+#
+# Makefile for LynxEM+/EM4+(Silicon Motion Inc.) fb driver for VR5701-SG2
+# under Linux.
+#
+
+obj-$(CONFIG_FB_SM)	+= smfb.o
+
+smfb-objs	:= smi_base.o smi_hw.o 
+
diff -Naurp --exclude=CVS linux_save/drivers/video/smi/smi_base.c linux_mips/drivers/video/smi/smi_base.c
--- linux_save/drivers/video/smi/smi_base.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/drivers/video/smi/smi_base.c	2005-05-31 17:00:36.000000000 +0400
@@ -0,0 +1,532 @@
+/*
+ * drivers/video/smi/smi_base.c
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/selection.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/console.h>
+#include "../console/fbcon.h"
+#include "smifb.h"
+#include "smi_hw.h"
+
+/*
+ * Card Identification
+ *
+ */
+static struct pci_device_id smifb_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_SMI, PCI_DEVICE_ID_SMI_LYNX_EM_PLUS,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},	/* Lynx EM+/EM4+ */
+	{PCI_VENDOR_ID_SMI, PCI_DEVICE_ID_SMI_LYNX_3DM,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},	/* Lynx 3DM/3DM+/3DM4+ */
+	{0,}			/* terminate list */
+};
+
+MODULE_DEVICE_TABLE(pci, smifb_pci_tbl);
+
+/*
+ *
+ * global variables
+ *
+ */
+
+#ifdef CONFIG_DISPLAY_1024x768
+/* 1024x768, 16bpp, 60Hz */
+static struct fb_var_screeninfo smifb_default_var = {
+      xres:1024,
+      yres:768,
+      xres_virtual:1024,
+      yres_virtual:768,
+      xoffset:0,
+      yoffset:0,
+      bits_per_pixel:16,
+      grayscale:0,
+      red:{11, 5, 0},
+      green:{5, 6, 0},
+      blue:{0, 5, 0},
+      transp:{0, 0, 0},
+      nonstd:0,
+      activate:0,
+      height:-1,
+      width:-1,
+      accel_flags:0,
+      pixclock:39721,		/* D */
+      left_margin:138,
+      right_margin:24,
+      upper_margin:24,
+      lower_margin:4,
+      hsync_len:160,
+      vsync_len:6,
+      sync:0,
+      vmode:FB_VMODE_NONINTERLACED
+};
+#else
+/* 640x480, 16bpp, 60Hz */
+static struct fb_var_screeninfo smifb_default_var = {
+      xres:640,
+      yres:480,
+      xres_virtual:640,
+      yres_virtual:480,
+      xoffset:0,
+      yoffset:0,
+      bits_per_pixel:16,
+      grayscale:0,
+      red:{11, 5, 0},
+      green:{5, 6, 0},
+      blue:{0, 5, 0},
+      transp:{0, 0, 0},
+      nonstd:0,
+      activate:0,
+      height:-1,
+      width:-1,
+      accel_flags:0,
+      pixclock:39721,		/* D */
+      left_margin:82,
+      right_margin:16,
+      upper_margin:19,
+      lower_margin:1,
+      hsync_len:152,
+      vsync_len:4,
+      sync:0,
+      vmode:FB_VMODE_NONINTERLACED
+};
+#endif
+
+static char drvrname[] = "NEC video driver for SMI LynxEM+";
+
+/*
+ *
+ * general utility functions
+ *
+ */
+
+static void
+smi_load_video_mode(struct smifb_info *sinfo,
+		    struct fb_var_screeninfo *video_mode)
+{
+	int bpp, width, height;
+	int hDisplaySize, hDisplay, hStart, hEnd, hTotal;
+	int vDisplay, vStart, vEnd, vTotal;
+	int dotClock;
+
+	pr_debug("smi_load_video_mode: video_mode->xres = %d\n",
+		 video_mode->xres);
+	pr_debug("                   :             yres = %d\n",
+		 video_mode->yres);
+	pr_debug("                   :             xres_virtual = %d\n",
+		 video_mode->xres_virtual);
+	pr_debug("                   :             yres_virtual = %d\n",
+		 video_mode->yres_virtual);
+	pr_debug("                   :             xoffset = %d\n",
+		 video_mode->xoffset);
+	pr_debug("                   :             yoffset = %d\n",
+		 video_mode->yoffset);
+	pr_debug("                   :             bits_per_pixel = %d\n",
+		 video_mode->bits_per_pixel);
+
+	/* smifb_blank(1, (struct fb_info*)sinfo); */
+	bpp = video_mode->bits_per_pixel;
+	if (bpp == 16 && video_mode->green.length == 5)
+		bpp = 15;
+
+	/* horizontal params */
+	width = video_mode->xres_virtual;
+	hDisplaySize = video_mode->xres;	/* number of pixels for one horizontal line */
+	hDisplay = (hDisplaySize / 8) - 1;	/* number of character clocks */
+	hStart = (hDisplaySize + video_mode->right_margin) / 8 + 2;	/* h-blank start character clocks */
+	hEnd = (hDisplaySize + video_mode->right_margin + video_mode->hsync_len) / 8 - 1;	/* h-sync end */
+	hTotal = (hDisplaySize + video_mode->right_margin + video_mode->hsync_len + video_mode->left_margin) / 8 - 1;	/* character clock from h-sync to next h-sync */
+
+	/* vertical params */
+	height = video_mode->yres_virtual;
+	vDisplay = video_mode->yres - 1;	/* number of lines */
+	vStart = video_mode->yres + video_mode->lower_margin - 1;	/* v-sync pulse start */
+	vEnd = video_mode->yres + video_mode->lower_margin + video_mode->vsync_len - 1;	/* v-sync end */
+	vTotal = video_mode->yres + video_mode->lower_margin + video_mode->vsync_len + video_mode->upper_margin + 2;	/* number of scanlines (v-blank end) */
+
+	dotClock = 1000000000 / video_mode->pixclock;
+
+	smi_set_moderegs(sinfo, bpp, width, height,
+			 hDisplaySize,
+			 hDisplay, hStart, hEnd, hTotal,
+			 vDisplay, vStart, vEnd, vTotal,
+			 dotClock, video_mode->sync);
+}
+
+/*
+ *
+ * framebuffer operations
+ *
+ */
+static int
+smifb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
+{
+	struct smifb_info *sinfo = (struct smifb_info *)info;
+
+	pr_debug("smifb_get_fix");
+	fix->smem_start = sinfo->fb_base_phys;
+	fix->smem_len = sinfo->fbsize;
+	fix->mmio_start = sinfo->dpr_base_phys;
+	fix->mmio_len = sinfo->dpport_size;
+
+	fix->xpanstep = 0;	/* FIXME: no xpanstep for now */
+	fix->ypanstep = 1;	/* FIXME: no ypanstep for now */
+	fix->ywrapstep = 0;	/* FIXME: no ywrap for now */
+
+	return 0;
+}
+
+static int vgxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			   unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if (regno > 15)
+		return 1;
+
+	((u16 *) (info->pseudo_palette))[regno] =
+	    (red & 0xf800) | (green & 0xfc00 >> 5) | (blue & 0xf800 >> 11);
+	return 0;
+}
+
+/*
+ * Initialization helper functions
+ *
+ */
+/* kernel interface */
+static struct fb_ops smifb_ops = {
+	.owner = THIS_MODULE,
+	.fb_setcolreg = vgxfb_setcolreg,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_cursor = soft_cursor,
+};
+
+/*
+ * VGA registers
+ *
+ */
+static void Unlock(struct smifb_info *sinfo)
+{
+	pr_debug("Unlock");
+	regSR_write(sinfo->mmio, 0x33, regSR_read(sinfo->mmio, 0x33) & 0x20);
+}
+
+static void Lock(struct smifb_info *sinfo)
+{
+	pr_debug("Lock");
+}
+
+static void UnlockVGA(struct smifb_info *sinfo)
+{
+	pr_debug("UnlockVGA");
+	regCR_write(sinfo->mmio, 0x11, regCR_read(sinfo->mmio, 0x11) & 0x7f);
+}
+
+static void LockVGA(struct smifb_info *sinfo)
+{
+	pr_debug("LockVGA");
+	regCR_write(sinfo->mmio, 0x11, regCR_read(sinfo->mmio, 0x11) | 0x80);
+}
+
+static struct fb_fix_screeninfo vgxfb_fix = {
+	.id = "vgxFB",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_TRUECOLOR,
+#ifdef CONFIG_DISPLAY_1024x768
+	.line_length = 1024 * 2,
+#else
+	.line_length = 640 * 2,
+#endif
+	.accel = FB_ACCEL_NONE,
+};
+
+static u32 colreg[17];
+
+/*
+ * PCI bus
+ *
+ */
+static int __devinit
+smifb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
+{
+	int len;
+	int res;
+	u16 cmd;
+	struct smifb_info *sinfo;
+	struct fb_info *info;
+
+	pr_debug("smifb_probe");
+
+	pr_debug("vendor id        %04x\n", pd->vendor);
+	pr_debug("device id        %04x\n", pd->device);
+	pr_debug("sub vendor id    %04x\n", pd->subsystem_vendor);
+	pr_debug("sub device id    %04x\n", pd->subsystem_device);
+
+	pr_debug("base0 start addr %08x\n",
+		 (unsigned int)pci_resource_start(pd, 0));
+	pr_debug("base0 end   addr %08x\n",
+		 (unsigned int)pci_resource_end(pd, 0));
+	pr_debug("base0 region len %08x\n",
+		 (unsigned int)pci_resource_len(pd, 0));
+	pr_debug("base0 flags      %08x\n",
+		 (unsigned int)pci_resource_flags(pd, 0));
+
+	pci_read_config_word(pd, PCI_STATUS, &cmd);
+	pr_debug("PCI status      %04x\n", cmd);
+
+	pci_read_config_word(pd, PCI_COMMAND, &cmd);
+	pr_debug("PCI command      %04x\n", cmd);
+
+	cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_IO;
+	pci_write_config_word(pd, PCI_COMMAND, cmd);
+
+	pci_read_config_word(pd, PCI_STATUS, &cmd);
+	pr_debug("PCI status      %04x\n", cmd);
+	pci_read_config_word(pd, PCI_COMMAND, &cmd);
+	pr_debug("PCI command      %04x\n", cmd);
+
+	/* allocate memory resources */
+	sinfo = kmalloc(sizeof(struct smifb_info), GFP_KERNEL);
+	if (!sinfo) {
+		goto err_out;
+	}
+	memset(sinfo, 0, sizeof(struct smifb_info));
+
+	/* driver name */
+	sinfo->drvr_name = drvrname;
+
+	sinfo->pd = pd;
+	sinfo->base_phys = pci_resource_start(sinfo->pd, 0);	/* Frame Buffer base address */
+	len = pci_resource_len(sinfo->pd, 0);
+	pr_debug("len = %lX\n", len);
+	if (!request_mem_region(sinfo->base_phys, len, "smifb")) {
+		printk(KERN_ERR "cannot reserve FrameBuffer and MMIO region\n");
+		goto err_out_kfree;
+	}
+
+	if ((res = pci_enable_device(sinfo->pd)) < 0) {
+		printk(KERN_ERR "smifb: failed to enable -- err %d\n", res);
+		goto err_out_free_base;
+	}
+
+	pci_read_config_word(pd, PCI_COMMAND, &cmd);
+	pr_debug(KERN_INFO "PCI command      %04x\n", cmd);
+
+	{
+		unsigned int pseudo_io, pseudo_io_len;
+		unsigned char *pseudo_io_p;
+
+		*(unsigned long *)0xbe000610 = 0x10000012;	/* CHANGE to PCI IO ACCESS */
+		asm("sync");
+		pseudo_io = pci_resource_start(sinfo->pd, 0);
+		pseudo_io_len = pci_resource_len(sinfo->pd, 0);
+		pseudo_io_p = ioremap(pseudo_io, pseudo_io_len);
+
+		VGA_WRITE8(pseudo_io_p, 0x3c3, 0x40);
+		regSR_write(pseudo_io_p, 0x00, 0x00);
+		regSR_write(pseudo_io_p, 0x17, 0xe2);
+		regSR_write(pseudo_io_p, 0x18, 0xff);
+
+		iounmap(pseudo_io_p);
+		*(unsigned long *)0xbe000610 = 0x10000016;	/* PCI MEM ACCESS */
+		asm("sync");
+	}
+	sinfo->base = ioremap(sinfo->base_phys, len);	/* FB+DPD+DPR+VPR+CPR+MMIO */
+	if (!sinfo->base) {
+		goto err_out_free_base;
+	}
+	switch ((sinfo->pd)->device) {
+	case PCI_DEVICE_ID_SMI_LYNX_EM_PLUS:
+		sinfo->dpport = (caddr_t) (sinfo->base + DPPORT_BASE_OFFSET);
+		sinfo->dpr = (caddr_t) (sinfo->base + DP_BASE_OFFSET);
+		sinfo->vpr = (caddr_t) (sinfo->base + VP_BASE_OFFSET);
+		sinfo->cpr = (caddr_t) (sinfo->base + CP_BASE_OFFSET);
+		sinfo->mmio = (caddr_t) (sinfo->base + IO_BASE_OFFSET);
+		sinfo->fb_base = (caddr_t) (sinfo->base + 0);
+		break;
+	case PCI_DEVICE_ID_SMI_LYNX_3DM:
+		sinfo->dpport =
+		    (caddr_t) (sinfo->base + LYNX3DM_DPPORT_BASE_OFFSET);
+		sinfo->dpr = (caddr_t) (sinfo->base + LYNX3DM_DP_BASE_OFFSET);
+		sinfo->vpr = (caddr_t) (sinfo->base + LYNX3DM_VP_BASE_OFFSET);
+		sinfo->cpr = (caddr_t) (sinfo->base + LYNX3DM_CP_BASE_OFFSET);
+		sinfo->mmio = (caddr_t) (sinfo->base + LYNX3DM_IO_BASE_OFFSET);
+		sinfo->fb_base =
+		    (caddr_t) (sinfo->base + LYNX3DM_FB_BASE_OFFSET);
+		break;
+	}
+	regSR_write(sinfo->mmio, 0x18, 0x11);
+
+	pr_debug("sinfo->dpport = 0x%08x\n", (u_int32_t) sinfo->dpport);
+	pr_debug("sinfo->dpr  = 0x%08x, sinfo->vpr   = 0x%08x\n",
+		 (unsigned int)sinfo->dpr, (unsigned int)sinfo->vpr);
+	pr_debug("sinfo->cpr  = 0x%08x, sinfo->mmio  = 0x%08x\n",
+		 (unsigned int)sinfo->cpr, (unsigned int)sinfo->mmio);
+
+	/* Set the chip in color mode and unlock the registers */
+	VGA_WRITE8(sinfo->mmio, 0x3c2, 0x2b);	/* Miscellaneous Output Register ( write 0x3c2, read 0x3cc ) */
+
+	Unlock(sinfo);
+	UnlockVGA(sinfo);
+
+	/* save the current chip status */
+	switch ((sinfo->pd)->device) {
+	case PCI_DEVICE_ID_SMI_LYNX_EM_PLUS:
+		regSR_write(sinfo->mmio, 0x62, 0xff);
+		regSR_write(sinfo->mmio, 0x6a, 0x0c);
+		regSR_write(sinfo->mmio, 0x6b, 0x02);
+
+		*(u32 *) (sinfo->fb_base + 4) = 0xaa551133;
+		pr_debug("       *(u32 *)(sinfo->fb_base +4) = 0x%08x\n",
+			 *(u32 *) (sinfo->fb_base + 4));
+		if (*(u32 *) (sinfo->fb_base + 4) != 0xaa551133) {
+			/* Program the MCLK to 130MHz */
+			regSR_write(sinfo->mmio, 0x6a, 0x10);
+			regSR_write(sinfo->mmio, 0x6b, 0x02);
+			regSR_write(sinfo->mmio, 0x62, 0x3e);
+			sinfo->fbsize = 2 * 1024 * 1024;	/* LynxEM+ */
+			pr_debug
+			    ("ChipID = LynxEM+. Force the MCLK to 85MHz and the memory size to 2MiB\n");
+		} else {
+			sinfo->fbsize = 4 * 1024 * 1024;	/* LynxEM4+ */
+			pr_debug
+			    ("ChipID = LynxEM4+. Force the MCLK to 85MHz and the memory size to 4MiB\n");
+		}
+		sinfo->fb_base_phys = sinfo->base_phys;
+		break;
+	case PCI_DEVICE_ID_SMI_LYNX_3DM:
+		{
+			int tmp;
+			int mem_table[4] = { 8, 16, 0, 4 };
+			tmp = (regSR_read(sinfo->mmio, 0x76) & 0xff);
+			pr_debug("%02x\n", tmp);
+			sinfo->fbsize = mem_table[(tmp >> 6)] * 1024 * 1024;
+
+			regSR_write(sinfo->mmio, 0x62, 0xff);
+			regSR_write(sinfo->mmio, 0x6a, 0x0c);
+			regSR_write(sinfo->mmio, 0x6b, 0x02);
+
+			sinfo->fb_base_phys =
+			    sinfo->base_phys + LYNX3DM_FB_BASE_OFFSET;
+		}
+		break;
+	default:
+		/* this driver supports only LynxEM+/EM4+ */
+		goto err_out_free_base;
+	};
+
+	info = &(sinfo->info);
+	smifb_get_fix(&vgxfb_fix, -1, info);
+
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &smifb_ops;
+	info->var = smifb_default_var;
+	info->fix = vgxfb_fix;
+	info->pseudo_palette = colreg;
+	info->screen_base = sinfo->fb_base;
+
+	smi_load_video_mode(sinfo, &smifb_default_var);
+
+	if (register_framebuffer(&sinfo->info) < 0) {
+		goto err_out_free_base;
+	}
+	pci_set_drvdata(pd, sinfo);
+
+	printk(KERN_INFO "smifb: " "framebuffer (%s)\n", sinfo->drvr_name);
+
+	return 0;
+
+      err_out_free_base:
+	release_mem_region(sinfo->base_phys, len);
+      err_out_kfree:
+	kfree(sinfo);
+      err_out:
+	return -ENODEV;
+}
+
+static void __devexit smifb_remove(struct pci_dev *pd)
+{
+	struct smifb_info *sinfo = pci_get_drvdata(pd);
+	pr_debug("smifb_remove");
+
+	if (!sinfo)
+		return;
+
+	unregister_framebuffer(&sinfo->info);
+
+	/* stop the lynx chip */
+	release_mem_region(sinfo->base_phys, pci_resource_len(sinfo->pd, 0));
+	kfree(sinfo);
+	pci_set_drvdata(pd, NULL);
+}
+
+/*
+ * Initialization
+ *
+ */
+#ifndef MODULE
+int __init smifb_setup(char *options)
+{
+	pr_debug("smifb_setup");
+
+	if (!options || options)
+		return 0;
+	return 0;
+}
+#endif				/* not MODULE */
+
+static struct pci_driver smifb_driver = {
+	.name = "smifb",
+	.id_table = smifb_pci_tbl,
+	.probe = smifb_probe,
+	.remove = __devexit_p(smifb_remove),
+};
+
+/*
+ * Driver initialization
+ */
+int __init smifb_init(void)
+{
+	pr_debug("smifb_init");
+	return pci_module_init(&smifb_driver);
+}
+
+/*
+ * modularization
+ *
+ */
+#ifdef MODULE
+static void __exit smifb_exit(void)
+{
+	pci_unregister_driver(&smifb_driver);
+}
+
+module_init(smifb_init);
+module_exit(smifb_exit);
+
+#endif				/* MODULE */
+
+module_init(smifb_init);
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("Framebuffer driver for Silicon Motion Lynx 3DM+");
+MODULE_LICENSE("GPL");
diff -Naurp --exclude=CVS linux_save/drivers/video/smi/smifb.h linux_mips/drivers/video/smi/smifb.h
--- linux_save/drivers/video/smi/smifb.h	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/drivers/video/smi/smifb.h	2005-05-31 17:00:36.000000000 +0400
@@ -0,0 +1,89 @@
+/*
+ * drivers/video/smi/smifb.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __SMIFB_H__
+#define __SMIFB_H__
+
+#define FBCON_HAS_CFB16
+
+enum ScreenModes {
+	DISPLAY_640x480x16,
+	DISPLAY_800x600x16,
+	DISPLAY_1024x768x16,
+	DISPLAY_640x480x24,
+	DISPLAY_800x600x24,
+	DISPLAY_LCD_400x232x16,
+	modeNums,
+};
+
+#define SMI_DEFAULT_MODE	DISPLAY_640x480x16
+
+#define SIZE_SR00_SR04		(0x04 - 0x00 + 1)
+#define SIZE_SR10_SR24		(0x24 - 0x10 + 1)
+#define SIZE_SR30_SR75		(0x75 - 0x30 + 1)
+#define SIZE_SR80_SR93		(0x93 - 0x80 + 1)
+#define SIZE_SRA0_SRAF		(0xAF - 0xA0 + 1)
+#define SIZE_GR00_GR08		(0x08 - 0x00 + 1)
+#define SIZE_AR00_AR14		(0x14 - 0x00 + 1)
+#define SIZE_CR00_CR18		(0x18 - 0x00 + 1)
+#define SIZE_CR30_CR4D		(0x4D - 0x30 + 1)
+#define SIZE_CR90_CRA7		(0xA7 - 0x90 + 1)
+
+struct smi_mode_regs {
+	int mode;
+	u8 reg_MISC;
+	u8 reg_SR00_SR04[SIZE_SR00_SR04];	/* SEQ00--04 (SEQ) */
+	u8 reg_SR10_SR24[SIZE_SR10_SR24];	/* SCR10--1F, PDR20--24 (SYS),(PWR) */
+	u8 reg_SR30_SR75[SIZE_SR30_SR75];	/* FPR30--5A, MCR60--62, CCR65--6F  GPR70--75 (LCD),(MEM),(CLK),(GP) */
+	u8 reg_SR80_SR93[SIZE_SR80_SR93];	/* PHR80-81, POP82--86, HCR88-8D, POP90--93 (CURS),(ICON),(CURS),(ICON) */
+	u8 reg_SRA0_SRAF[SIZE_SRA0_SRAF];	/* FPRA0--AF (LCD) */
+	u8 reg_GR00_GR08[SIZE_GR00_GR08];	/* GR00--08 (GC) */
+	u8 reg_AR00_AR14[SIZE_AR00_AR14];	/* ATR00--14 (ATTR) */
+	u8 reg_CR00_CR18[SIZE_CR00_CR18];	/* CRT00--18 (CRTC) */
+	u8 reg_CR30_CR4D[SIZE_CR30_CR4D];	/* CRT30--3F, SVR40--4D (ECRTC),(SHADOW) */
+	u8 reg_CR90_CRA7[SIZE_CR90_CRA7];	/* CRT90--9B,9E,9F,A0--A5,A6,A7, (DDA),(EC2),(EC1)(VCLUT),(VC),(HC) */
+};
+
+typedef struct {
+	unsigned char red, green, blue, transp;
+} smi_cfb8_cmap_t;
+
+struct smifb_info;
+struct smifb_info {
+	struct fb_info info;	/* kernel framebuffer info */
+	const char *drvr_name;	/* Silicon Motion hardware board type */
+	struct pci_dev *pd;	/* descripbe the PCI device */
+	unsigned long base_phys;	/* physical base address                  */
+
+	/* PCI base physical addresses */
+	unsigned long fb_base_phys;	/* physical Frame Buffer base address                  */
+	unsigned long dpr_base_phys;	/* physical Drawing Processor base address             */
+	unsigned long vpr_base_phys;	/* physical Video Processor base address               */
+	unsigned long cpr_base_phys;	/* physical Capture Processor base address             */
+	unsigned long mmio_base_phys;	/* physical MMIO spase (VGA + SMI regs ?) base address */
+	unsigned long dpport_base_phys;	/* physical Drawing Processor Data Port base address   */
+	int dpport_size;	/* size of Drawin Processor Data Port memory space     */
+
+	/* PCI base virtual addresses */
+	caddr_t base;		/* address of base */
+	caddr_t fb_base;	/* address of frame buffer base */
+	caddr_t dpr;		/* Drawing Processor Registers  */
+	caddr_t vpr;		/* Video Processor Registers    */
+	caddr_t cpr;		/* Capture Processor Registers  */
+	caddr_t mmio;		/* Memory Mapped I/O Port       */
+	caddr_t dpport;		/* Drawing Processor Data       */
+
+	int fbsize;		/* Frame-Buffer memory size */
+};
+
+#endif				/* __SMIFB_H__ */
diff -Naurp --exclude=CVS linux_save/drivers/video/smi/smi_hw.c linux_mips/drivers/video/smi/smi_hw.c
--- linux_save/drivers/video/smi/smi_hw.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/drivers/video/smi/smi_hw.c	2005-05-31 17:00:36.000000000 +0400
@@ -0,0 +1,188 @@
+/*
+ * drivers/video/smi/smi_hw.c
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include "smifb.h"
+#include "smi_hw.h"
+#include "smi_params.h"
+
+/*
+ * set mode registers
+ */
+void
+smi_set_moderegs(struct smifb_info *sinfo,
+		 int bpp, int width, int height,
+		 int hDisplaySize,
+		 int hDisplay, int hStart, int hEnd, int hTotal,
+		 int vDisplay, int vStart, int vEnd, int vTotal,
+		 int dotClock, int sync)
+{
+	int i;
+	int tmp_mode = SMI_DEFAULT_MODE;
+	int lineLength;
+	struct smi_mode_regs curMode;
+
+	pr_debug("smi_set_moderegs");
+	pr_debug("bpp = %d, width = %d, height = %d\n", bpp, width, height);
+	pr_debug("hDisplaySize = %d\n", hDisplaySize);
+	pr_debug("hDisplay = %d, hStart = %d, hEnd = %d, hTotal = %d\n",
+		 hDisplay, hStart, hEnd, hTotal);
+	pr_debug("vDisplay = %d, vStart = %d, vEnd = %d, vTotal = %d\n",
+		 vDisplay, vStart, vEnd, vTotal);
+	pr_debug("dotClock = %d\n", dotClock);
+
+	lineLength = width * bpp / 8;
+
+	switch (bpp) {
+#ifdef FBCON_HAS_CFB8
+	case 8:
+		if (hDisplaySize <= 640)
+			tmp_mode = DISPLAY_640x480x8;
+		else if (width <= 800)
+			tmp_mode = DISPLAY_800x600x8;
+		else if (width <= 1024)
+			tmp_mode = DISPLAY_1024x768x8;
+		else if (width <= 1280)
+			tmp_mode = DISPLAY_1280x1024x8;
+		reg_DPR10(sinfo) = (lineLength << 16) | lineLength;	/* RowPitch */
+		reg_DPR1E(sinfo) = 0x0005;
+		reg_DPR3C(sinfo) = (lineLength << 16) | lineLength;	/* Dst & Src Window Width */
+		reg_VPR00(sinfo) = 0x0 << 16;
+		break;
+#endif
+#ifdef FBCON_HAS_CFB16
+	case 16:
+		if (hDisplaySize <= 400)
+			tmp_mode = DISPLAY_LCD_400x232x16;
+		if (hDisplaySize <= 640)
+			tmp_mode = DISPLAY_640x480x16;
+		else if (width <= 800)
+			tmp_mode = DISPLAY_800x600x16;
+		else if (width <= 1024)
+			tmp_mode = DISPLAY_1024x768x16;
+		reg_DPR10(sinfo) = (lineLength / 2 << 16) | lineLength / 2;	/* RowPitch */
+		reg_DPR1E(sinfo) = 0x0015;
+		reg_DPR3C(sinfo) = (lineLength / 2 << 16) | lineLength / 2;	/* Dst & Src Window Width */
+		reg_VPR00(sinfo) = 0x2 << 16;
+		break;
+#endif
+#ifdef FBCON_HAS_CFB24
+	case 24:
+		if (hDisplaySize <= 640)
+			tmp_mode = DISPLAY_640x480x24;
+		else if (width <= 800)
+			tmp_mode = DISPLAY_800x600x24;
+		reg_DPR10(sinfo) = (lineLength / 3 << 16) | lineLength / 3;	/* RowPitch */
+		reg_DPR1E(sinfo) = 0x0035;
+		reg_DPR3C(sinfo) = (lineLength / 3 << 16) | lineLength / 3;	/* Dst & Src Window Width */
+		reg_VPR00(sinfo) = 0x4 << 16;
+		break;
+#endif
+	};
+
+	for (i = 0; i < modeNums; i++) {
+		if (ModeInitParams[i].mode == tmp_mode)
+			break;
+	}
+	if (i == modeNums)
+		tmp_mode = SMI_DEFAULT_MODE;
+
+	memcpy(&curMode, &ModeInitParams[tmp_mode],
+	       sizeof(struct smi_mode_regs));
+
+	/*
+	 * Override some Mode Params
+	 */
+	/* MISC Reg */
+	curMode.reg_MISC = 0x30 | (hDisplay == 640) ? 0x03 : 0x0b;
+	if (sync & FB_SYNC_HOR_HIGH_ACT)
+		curMode.reg_MISC |= 0x40;
+	if (sync & FB_SYNC_VERT_HIGH_ACT)
+		curMode.reg_MISC |= 0x80;
+
+	/* CRTC */
+	curMode.reg_CR00_CR18[0x00] = (u8) (hTotal - 4);
+	curMode.reg_CR00_CR18[0x01] = (u8) hDisplay;
+	curMode.reg_CR00_CR18[0x02] = (u8) hDisplay;
+	curMode.reg_CR00_CR18[0x03] = 0x00;
+	curMode.reg_CR00_CR18[0x04] = (u8) hStart;
+	curMode.reg_CR00_CR18[0x05] = (hEnd & 0x1f);
+	curMode.reg_CR00_CR18[0x06] = (u8) (vTotal & 0xff);
+	curMode.reg_CR00_CR18[0x07] = (u8) (((vStart >> 9) & 0x01) << 7)
+	    | (u8) (((vDisplay >> 9) & 0x01) << 6)
+	    | (u8) (((vTotal >> 9) & 0x01) << 5)
+	    | 1 << 4		/* D (LC) */
+	    | (u8) (((vStart >> 8) & 0x01) << 2)
+	    | (u8) (((vDisplay >> 8) & 0x01) << 1)
+	    | (u8) ((vTotal >> 8) & 0x01);
+
+	curMode.reg_CR00_CR18[0x09] = (u8) (vDisplay >> 9) << 5 | 1 << 6;	/* D (LC bit9) */
+	curMode.reg_CR00_CR18[0x10] = (u8) (vStart & 0xff);
+	curMode.reg_CR00_CR18[0x11] = (u8) (vEnd & 0xf);
+	curMode.reg_CR00_CR18[0x12] = (u8) (vDisplay & 0xff);
+	curMode.reg_CR00_CR18[0x13] = ((width / 8) * ((bpp + 1) / 8)) & 0xFF;
+	curMode.reg_CR00_CR18[0x15] = (u8) (vDisplay & 0xff);
+	curMode.reg_CR00_CR18[0x16] = 0x00;
+	curMode.reg_CR00_CR18[0x14] = (hDisplaySize > 1024) ? 0x00 : 0x40;	/* D *//* Underline Location */
+
+	/* Extended CRTC */
+	curMode.reg_CR30_CR4D[0x30 - 0x30] = (u8) (((vTotal >> 10) & 0x01) << 3)
+	    | (u8) (((vDisplay >> 10) & 0x01) << 1)
+	    | (u8) ((vStart >> 10) & 0x1);	/* D (CRTD) (CVDER) */
+
+	curMode.reg_SR30_SR75[0x32] = 0xff;	/* (Memory Type and Timig Control Reg) */
+
+	for (i = 0; i <= SIZE_SR00_SR04; i++)
+		regSR_write(sinfo->mmio, 0x00 + i, curMode.reg_SR00_SR04[i]);
+	for (i = 0; i <= SIZE_SR10_SR24; i++)
+		regSR_write(sinfo->mmio, 0x10 + i, curMode.reg_SR10_SR24[i]);
+	for (i = 0; i <= SIZE_SR30_SR75; i++) {
+		regSR_write(sinfo->mmio, 0x30 + i, curMode.reg_SR30_SR75[i]);
+	}
+	for (i = 0; i <= SIZE_SR80_SR93; i++)
+		regSR_write(sinfo->mmio, 0x80 + i, curMode.reg_SR80_SR93[i]);
+	for (i = 0; i <= SIZE_SRA0_SRAF; i++)
+		regSR_write(sinfo->mmio, 0xA0 + i, curMode.reg_SRA0_SRAF[i]);
+	for (i = 0; i <= SIZE_GR00_GR08; i++)
+		regGR_write(sinfo->mmio, 0x00 + i, curMode.reg_GR00_GR08[i]);
+	for (i = 0; i <= SIZE_AR00_AR14; i++)
+		regAR_write(sinfo->mmio, 0x00 + i, curMode.reg_AR00_AR14[i]);
+	for (i = 0; i <= SIZE_CR00_CR18; i++)
+		regCR_write(sinfo->mmio, 0x00 + i, curMode.reg_CR00_CR18[i]);
+	for (i = 0; i <= SIZE_CR30_CR4D; i++)
+		regCR_write(sinfo->mmio, 0x30 + i, curMode.reg_CR30_CR4D[i]);
+	for (i = 0; i <= SIZE_CR90_CRA7; i++)
+		regCR_write(sinfo->mmio, 0x90 + i, curMode.reg_CR90_CRA7[i]);
+
+	/* SetMemoryMapRegisters */
+	reg_DPR14(sinfo) = 0xffffffff;	/* FG color */
+	reg_DPR18(sinfo) = 0x00000000;	/* BG color */
+	reg_DPR24(sinfo) = 0xffffffff;	/* Color Mask */
+	reg_DPR28(sinfo) = 0xffff;	/* Masks */
+	reg_DPR2C(sinfo) = 0;
+	reg_DPR30(sinfo) = 0;
+	reg_DPR34(sinfo) = 0xffffffff;
+	reg_DPR38(sinfo) = 0xffffffff;
+	reg_DPR40(sinfo) = 0;
+	reg_DPR44(sinfo) = 0;
+	reg_VPR0C(sinfo) = 0;
+	reg_VPR10(sinfo) = ((lineLength / 8 + 2) << 16) | (lineLength / 8);
+	reg_VPR40(sinfo) = 0;
+	reg_VPR28(sinfo) = 0x00000000;
+	reg_VPR2C(sinfo) = ((hDisplaySize - 1) << 16) | (vDisplay);
+	reg_VPR30(sinfo) = 0x00000000;
+	reg_VPR34(sinfo) = (lineLength << 16) | lineLength;
+}
diff -Naurp --exclude=CVS linux_save/drivers/video/smi/smi_hw.h linux_mips/drivers/video/smi/smi_hw.h
--- linux_save/drivers/video/smi/smi_hw.h	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/drivers/video/smi/smi_hw.h	2005-05-31 17:00:36.000000000 +0400
@@ -0,0 +1,197 @@
+/*
+ * drivers/video/smi/smi_hw.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __SMI_HW_H__
+#define __SMI_HW_H__
+
+#include "smifb.h"
+
+#define DPPORT_BASE_OFFSET		0x400000
+#define DP_BASE_OFFSET			0x408000
+#define VP_BASE_OFFSET			0x40c000
+#define CP_BASE_OFFSET			0x40e000
+#define IO_BASE_OFFSET			0x700000
+
+#define DPPORT_REGION_SIZE		(32*1024)
+#define DPREG_REGION_SIZE		(16*1024)
+#define VPREG_REGION_SIZE		(8*1024)
+#define CPREG_REGION_SIZE		(8*1024)
+#define MMIO_REGION_SIZE		(1*1024*1024)
+
+#define LYNX3DM_DPPORT_BASE_OFFSET		0x100000
+#define LYNX3DM_DP_BASE_OFFSET			0x000000
+#define LYNX3DM_VP_BASE_OFFSET			0x000800
+#define LYNX3DM_CP_BASE_OFFSET			0x001000
+#define LYNX3DM_IO_BASE_OFFSET			0x0c0000
+#define LYNX3DM_FB_BASE_OFFSET			0x200000
+
+#define LYNX3DM_DPPORT_REGION_SIZE		(1024*1024)
+#define LYNX3DM_DPREG_REGION_SIZE		(2*1024)
+#define LYNX3DM_VPREG_REGION_SIZE		(2*1024)
+#define LYNX3DM_CPREG_REGION_SIZE		(2*1024)
+#define LYNX3DM_MMIO_REGION_SIZE		(256*1024)
+
+extern void smi_set_moderegs(struct smifb_info *sinfo,
+			     int bpp, int width, int height,
+			     int hDisplaySize,
+			     int hDisplay, int hStart, int hEnd, int hTotal,
+			     int vDisplay, int vStart, int vEnd, int vTotal,
+			     int dotClock, int sync);
+
+#define MMIO_OUT8(p, r, d)	(((volatile u8 *)(p))[r] = (d))
+#define MMIO_OUT16(p, r, d)	(((volatile u16 *)(p))[(r)>>1] = (d))
+#define MMIO_OUT32(p, r, d)	(((volatile u32 *)(p))[(r)>>2] = (d))
+#define MMIO_IN8(p, r)		(((volatile u8 *)(p))[(r)])
+#define MMIO_IN16(p, r)		(((volatile u16 *)(p))[(r)>>1])
+#define MMIO_IN32(p, r)		(((volatile u32 *)(p))[(r)>>2])
+
+static inline u8 VGA_READ8(u8 * base, uint reg)
+{
+	return MMIO_IN8(base, reg);
+}
+
+static inline void VGA_WRITE8(u8 * base, uint reg, u8 data)
+{
+	MMIO_OUT8(base, reg, data);
+}
+
+static inline u8 VGA_READ8_INDEX(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	return VGA_READ8(base, 0x3c5);
+}
+
+static inline void VGA_WRITE8_INDEX(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	VGA_WRITE8(base, 0x3c5, data);
+}
+
+static inline u8 regSR_read(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	return VGA_READ8(base, 0x3c5);
+}
+
+static inline void regSR_write(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	VGA_WRITE8(base, 0x3c5, data);
+}
+
+static inline u8 regCR_read(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3d4, index);
+	return VGA_READ8(base, 0x3d5);
+}
+
+static inline void regCR_write(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3d4, index);
+	VGA_WRITE8(base, 0x3d5, data);
+}
+
+static inline u8 regGR_read(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3ce, index);
+	return VGA_READ8(base, 0x3cf);
+}
+
+static inline void regGR_write(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3ce, index);
+	VGA_WRITE8(base, 0x3cf, data);
+}
+
+static inline u8 regAR_read(u8 * base, u8 index)
+{
+	(void)VGA_READ8(base, 0x3da);	/* reset flip-flop */
+	VGA_WRITE8(base, 0x3c0, index);
+	return VGA_READ8(base, 0x3c1);
+}
+
+static inline void regAR_write(u8 * base, u8 index, u8 data)
+{
+	(void)VGA_READ8(base, 0x3da);	/* reset flip-flop */
+	VGA_WRITE8(base, 0x3c0, index);
+	VGA_WRITE8(base, 0x3c0, data);
+}
+
+/*
+ * LynxEM+ registers
+ */
+
+/* Drawing Engine Control Registers */
+#define reg_DPR00(x)	*(u16 *)((x)->dpr+0x00)	/* Source Y or K2                                       */
+#define reg_DPR02(x)	*(u16 *)((x)->dpr+0x02)	/* Source X or K1                                       */
+#define reg_DPR04(x)	*(u16 *)((x)->dpr+0x04)	/* Destination Y or Start Y                             */
+#define reg_DPR06(x)	*(u16 *)((x)->dpr+0x06)	/* Destination X or Start X                             */
+#define reg_DPR08(x)	*(u16 *)((x)->dpr+0x08)	/* Dimension Y or Error Term                            */
+#define reg_DPR0A(x)	*(u16 *)((x)->dpr+0x0A)	/* Dimension X or Vector Length                         */
+#define reg_DPR0C(x)	*(u16 *)((x)->dpr+0x0C)	/* ROP and Miscellaneous Control                        */
+#define reg_DPR0E(x)	*(u16 *)((x)->dpr+0x0E)	/* Drawing Engine Commands and Control                  */
+#define reg_DPR10(x)	*(u16 *)((x)->dpr+0x10)	/* Source Row Pitch                                     */
+#define reg_DPR12(x)	*(u16 *)((x)->dpr+0x12)	/* Destination Row Picth                                */
+#define reg_DPR14(x)	*(u32 *)((x)->dpr+0x14)	/* Foreground Colors                                    */
+#define reg_DPR18(x)	*(u32 *)((x)->dpr+0x18)	/* Background Colors                                    */
+#define reg_DPR1C(x)	*(u16 *)((x)->dpr+0x1C)	/* Stretch Source Height Y                              */
+#define reg_DPR1E(x)	*(u16 *)((x)->dpr+0x1E)	/* Drawing Engine DataFormat and Location Format Select */
+#define reg_DPR20(x)	*(u32 *)((x)->dpr+0x20)	/* Color Compare                                        */
+#define reg_DPR24(x)	*(u32 *)((x)->dpr+0x24)	/* Color Compare Mask                                   */
+#define reg_DPR28(x)	*(u16 *)((x)->dpr+0x28)	/* Bit Mask                                             */
+#define reg_DPR2A(x)	*(u16 *)((x)->dpr+0x2A)	/* Byte Mask Enable                                     */
+#define reg_DPR2C(x)	*(u16 *)((x)->dpr+0x2C)	/* Scisors Left and Control                             */
+#define reg_DPR2E(x)	*(u16 *)((x)->dpr+0x2E)	/* Scisors Top                                          */
+#define reg_DPR30(x)	*(u16 *)((x)->dpr+0x30)	/* Scisors Right                                        */
+#define reg_DPR32(x)	*(u16 *)((x)->dpr+0x32)	/* Scisors Bottom                                       */
+#define reg_DPR34(x)	*(u32 *)((x)->dpr+0x34)	/* Mono Pattern Low                                     */
+#define reg_DPR38(x)	*(u32 *)((x)->dpr+0x38)	/* Mono Pattern High                                    */
+#define reg_DPR3C(x)	*(u32 *)((x)->dpr+0x3C)	/* XY Addressing Destination & Source Window Widths     */
+#define reg_DPR40(x)	*(u32 *)((x)->dpr+0x40)	/* Source Base Address                                  */
+#define reg_DPR44(x)	*(u32 *)((x)->dpr+0x44)	/* Destination Base Address                             */
+
+/* Video Processor Control Registers */
+#define reg_VPR00(x)	*(u32 *)((x)->vpr+0x00)	/* Miscellaneous Graphics and Video Control                 */
+#define reg_VPR04(x)	*(u32 *)((x)->vpr+0x04)	/* Color Keys                                               */
+#define reg_VPR08(x)	*(u32 *)((x)->vpr+0x08)	/* Color Key Masks                                          */
+#define reg_VPR0C(x)	*(u32 *)((x)->vpr+0x0C)	/* Data Source Start Address for Extended Graphics Modes    */
+#define reg_VPR10(x)	*(u32 *)((x)->vpr+0x10)	/* Data Source Width and Offset for Extended Graphics Modes */
+#define reg_VPR14(x)	*(u32 *)((x)->vpr+0x14)	/* Video Window I Left and Top Boundaries                   */
+#define reg_VPR18(x)	*(u32 *)((x)->vpr+0x18)	/* Video Window I Right and Bottom Boundaries               */
+#define reg_VPR1C(x)	*(u32 *)((x)->vpr+0x1C)	/* Video Window I Source Start Address                      */
+#define reg_VPR20(x)	*(u32 *)((x)->vpr+0x20)	/* Video Window I Source Width and Offset                   */
+#define reg_VPR24(x)	*(u32 *)((x)->vpr+0x24)	/* Video Window I Stretch Factor                            */
+#define reg_VPR28(x)	*(u32 *)((x)->vpr+0x28)	/* Video Window II Left and Top Boundaries              */
+#define reg_VPR2C(x)	*(u32 *)((x)->vpr+0x2C)	/* Video Window II Right and Bottom Boundaries              */
+#define reg_VPR30(x)	*(u32 *)((x)->vpr+0x30)	/* Video Window II Source Start Address                     */
+#define reg_VPR34(x)	*(u32 *)((x)->vpr+0x34)	/* Video Window II Source Width and Offset                  */
+#define reg_VPR38(x)	*(u32 *)((x)->vpr+0x38)	/* Video Window II Stretch Factor                           */
+#define reg_VPR3C(x)	*(u32 *)((x)->vpr+0x3C)	/* Graphics and Video Controll II                           */
+#define reg_VPR40(x)	*(u32 *)((x)->vpr+0x40)	/* Graphic Scale Factor                                     */
+#define reg_VPR54(x)	*(u32 *)((x)->vpr+0x54)	/* FIFO Priority Control                                    */
+#define reg_VPR58(x)	*(u32 *)((x)->vpr+0x58)	/* FIFO Empty Request level Control                         */
+#define reg_VPR5C(x)	*(u32 *)((x)->vpr+0x5C)	/* YUV to RGB Conversion Constant                           */
+#define reg_VPR60(x)	*(u32 *)((x)->vpr+0x60)	/* Current Scan Line Position                               */
+#define reg_VPR64(x)	*(u32 *)((x)->vpr+0x64)	/* Signature Analyzer Control and Status                    */
+#define reg_VPR68(x)	*(u32 *)((x)->vpr+0x68)	/* Video Window I Stretch Factor                            */
+#define reg_VPR6C(x)	*(u32 *)((x)->vpr+0x6C)	/* Video Window II Stretch Factor                           */
+
+/* Capture Processor Control Registers */
+#define reg_CPR00(x)	*(u32 *)((x)->cpr+0x00)	/* Capture Port Control                        */
+#define reg_CPR04(x)	*(u32 *)((x)->cpr+0x04)	/* Video Source Clipping Control               */
+#define reg_CPR08(x)	*(u32 *)((x)->cpr+0x08)	/* Video Source Capture Size Control           */
+#define reg_CPR0C(x)	*(u32 *)((x)->cpr+0x0C)	/* Capture Port Buffer I Source Start Address  */
+#define reg_CPR10(x)	*(u32 *)((x)->cpr+0x10)	/* Capture Port Buffer II Source Start Address */
+#define reg_CPR14(x)	*(u32 *)((x)->cpr+0x14)	/* Capture Port Source Offset Address          */
+#define reg_CPR18(x)	*(u32 *)((x)->cpr+0x18)	/* Capture FIFO Empty Request level Control    */
+
+#endif				/* __SMI_HW_H__ */
diff -Naurp --exclude=CVS linux_save/drivers/video/smi/smi_params.h linux_mips/drivers/video/smi/smi_params.h
--- linux_save/drivers/video/smi/smi_params.h	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/drivers/video/smi/smi_params.h	2005-05-31 17:00:36.000000000 +0400
@@ -0,0 +1,442 @@
+/*
+ * drivers/video/smi/smi_params.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __SMI_REGS_H__
+#define __SMI_REGS_H__
+
+/* register settings */
+struct smi_mode_regs ModeInitParams[modeNums] = {
+	/* mode#4 640 x 480 16Bpp 60Hz */
+	{
+	 DISPLAY_640x480x16,
+	 /* reg_MISC */
+	 0xE3,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0x03, 0x00, 0x00, 0x00, 0x00, 0x0E, 0x10, 0x2C,
+	  0x59, 0x00, 0x20, 0x00, 0x00, 0x0F, 0x0F, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+
+	 /* reg_SR30_SR75 */
+	 {
+	  0xAA, 0x03, 0xA0, 0x89, 0xC0, 0xAA, 0xAA, 0xAA,
+	  0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x38, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0xAA,
+	  0x04, 0x24, 0x63, 0x4F, 0x52, 0x0B, 0xDF, 0xEA,
+	  0x04, 0x50, 0x19, 0xAA, 0xAA, 0x00, 0x00, 0xAA,
+	  0x01, 0x80, 0xFF, 0x1A, 0x1A, 0x00, 0x03, 0x00,
+	  0x50, 0x03, 0x0D, 0x02, 0x07, 0x82, 0x07, 0x04,
+	  0x00, 0x45, 0x30, 0x0C, 0x40, 0x30,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0xAA,
+	  0x40, 0x01, 0xF0, 0x00, 0xFF, 0x00, 0xAA, 0xAA,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xFF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x3F, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x10, 0x00, 0x12, 0x00, 0x04,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x5F, 0x4F, 0x4F, 0x00, 0x53, 0x1F, 0x0B, 0x3E,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xEA, 0x0C, 0xDF, 0x50, 0x40, 0xDF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xFF, 0xFD,
+	  0x5F, 0x4F, 0x00, 0x54, 0x00, 0x0B, 0xDF, 0x00,
+	  0xEA, 0x0C, 0x2E, 0x00, 0x4F, 0xDF,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0xDD, 0x5E, 0xEA, 0x87, 0x44, 0x8F, 0x55,
+	  0x0A, 0x8F, 0x55, 0x0A, 0x00, 0x00, 0x18, 0x00,
+	  0x11, 0x10, 0x0B, 0x0A, 0x0A, 0x0A, 0x0A, 0x00,
+	  },
+	 },
+	/* mode#5 800 x 600 16Bpp 60Hz */
+	{
+	 DISPLAY_800x600x16,
+	 /* reg_MISC */
+	 0x2B,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0xFF, 0xBE, 0xEE, 0xFF, 0x00, 0x0E, 0x17, 0xe2,
+	  0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0x36, 0x03, 0x20, 0x09, 0xC0, 0x36, 0x36, 0x36,
+	  0x36, 0x36, 0x36, 0x36, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x36, 0x36, 0x36,
+	  0x04, 0x48, 0x83, 0x63, 0x68, 0x72, 0x57, 0x58,
+	  0x04, 0x55, 0x59, 0x36, 0x36, 0x00, 0x00, 0x36,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x1C, 0x85, 0x35, 0x13,
+	  0x02, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x36,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x36, 0x36,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x7F, 0x63, 0x63, 0x00, 0x68, 0x18, 0x72, 0xF0,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x58, 0x0C, 0x57, 0x64, 0x40, 0x57, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xBF, 0xFD,
+	  0x7F, 0x63, 0x00, 0x69, 0x18, 0x72, 0x57, 0x00,
+	  0x58, 0x0C, 0xE0, 0x20, 0x63, 0x57,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0x00, 0x00, 0x18, 0x00,
+	  0x20, 0x1F, 0x1A, 0x19, 0x0F, 0x0F, 0x0F, 0x00,
+	  },
+	 },
+	/* mode#6 1024 x 768 16Bpp 60Hz * */
+	{
+	 DISPLAY_1024x768x16,
+	 /* reg_MISC */
+	 0xEB,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0x03, 0x00, 0x00, 0x00, 0x00, 0x0E, 0x10, 0x2c,
+	  0x59, 0x02, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0xAA, 0x03, 0x20, 0x89, 0xC0, 0xAA, 0xAA, 0xAA,
+	  0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x38, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0xAA,
+	  0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+	  0x00, 0x60, 0x59, 0xAA, 0xAA, 0x00, 0x00, 0xAA,
+	  0x01, 0x80, 0xFF, 0x1A, 0x1A, 0x00, 0x03, 0x00,
+	  0x50, 0x03, 0x0D, 0x02, 0x12, 0x82, 0x09, 0x02,
+	  0x04, 0x45, 0x30, 0x0C, 0x40, 0x20,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xAA,
+	  0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xAA, 0xAA,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+	  0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x11, 0x0F, 0x13, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+	  0xA3, 0x7F, 0x00, 0x86, 0x15, 0x24, 0xFF, 0x00,
+	  0x01, 0x07, 0xE5, 0x20, 0x7F, 0xFF,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+	  0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+	  0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+	  },
+	 },
+	/* mode#7 640 x 480 24Bpp 60Hz */
+	{
+	 DISPLAY_640x480x24,
+	 /* reg_MISC */
+	 0xE3,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0xFF, 0xBE, 0xEF, 0xFF, 0x00, 0x0E, 0x17, 0xe2,
+	  0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0x32, 0x03, 0xA0, 0x09, 0xC0, 0x32, 0x32, 0x32,
+	  0x32, 0x32, 0x32, 0x32, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x32, 0x32, 0x32,
+	  0x04, 0x24, 0x63, 0x4F, 0x52, 0x0B, 0xDF, 0xEA,
+	  0x04, 0x50, 0x19, 0x32, 0x32, 0x00, 0x00, 0x32,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x07, 0x82, 0x07, 0x04,
+	  0x00, 0x45, 0x30, 0x30, 0x40, 0x30,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x32,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x32, 0x32,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xFF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x5F, 0x4F, 0x4F, 0x00, 0x53, 0x1F, 0x0B, 0x3E,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xEA, 0x0C, 0xDF, 0x50, 0x40, 0xDF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xFF, 0xFD,
+	  0x5F, 0x4F, 0x00, 0x54, 0x00, 0x0B, 0xDF, 0x00,
+	  0xEA, 0x0C, 0x2E, 0x00, 0x4F, 0xDF,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0xDD, 0x5E, 0xEA, 0x87, 0x44, 0x8F, 0x55,
+	  0x0A, 0x8F, 0x55, 0x0A, 0x00, 0x00, 0x18, 0x00,
+	  0x11, 0x10, 0x0B, 0x0A, 0x0A, 0x0A, 0x0A, 0x00,
+	  },
+	 },
+	/* mode#8 800 x 600 24Bpp 60Hz */
+	{
+	 DISPLAY_800x600x24,
+	 /* reg_MISC */
+	 0x2B,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0xFF, 0xBE, 0xEE, 0xFF, 0x00, 0x0E, 0x17, 0xe2,
+	  0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0x36, 0x03, 0x20, 0x09, 0xC0, 0x36, 0x36, 0x36,
+	  0x36, 0x36, 0x36, 0x36, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x36, 0x36, 0x36,
+	  0x04, 0x48, 0x83, 0x63, 0x68, 0x72, 0x57, 0x58,
+	  0x04, 0x55, 0x59, 0x36, 0x36, 0x00, 0x00, 0x36,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x1C, 0x85, 0x35, 0x13,
+	  0x02, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x36,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x36, 0x36,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x7F, 0x63, 0x63, 0x00, 0x68, 0x18, 0x72, 0xF0,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x58, 0x0C, 0x57, 0x64, 0x40, 0x57, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xBF, 0xFD,
+	  0x7F, 0x63, 0x00, 0x69, 0x18, 0x72, 0x57, 0x00,
+	  0x58, 0x0C, 0xE0, 0x20, 0x63, 0x57,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0x00, 0x00, 0x18, 0x00,
+	  0x20, 0x1F, 0x1A, 0x19, 0x0F, 0x0F, 0x0F, 0x00,
+	  },
+	 },
+	/* mode#9 400 x 232 16Bpp 60Hz */
+	{
+	 DISPLAY_LCD_400x232x16,
+	 /* reg_MISC */
+	 0x2B,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0x03, 0x00, 0x00, 0x00, 0x00, 0x08, 0x10, 0x2C,
+	  0x59, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00,
+	  0x84, 0x00, 0x02, 0x00, 0x31,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0xB7, 0x43, 0x98, 0x01, 0xC0, 0xB7, 0xB7, 0xB7,
+	  0xB7, 0xB7, 0xB7, 0xB7, 0x00, 0x00, 0x85, 0x2C,
+	  0xC0, 0xE1, 0x00, 0x00, 0x40, 0xF0, 0x80, 0xC4,
+	  0x40, 0x3C, 0xA1, 0x40, 0x00, 0x00, 0x01, 0xB7,
+	  0x02, 0x24, 0xD9, 0xC7, 0xCC, 0x31, 0x2C, 0x2D,
+	  0x07, 0x57, 0x19, 0xB7, 0xB7, 0x00, 0x00, 0xB7,
+	  0x01, 0x00, 0xFF, 0x1A, 0x1A, 0x01, 0x03, 0x00,
+	  0xD4, 0x07, 0x0D, 0x02, 0x23, 0x3F, 0x35, 0x13,
+	  0x83, 0xDD, 0x02, 0x0C, 0x05, 0x00,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x09, 0xB7,
+	  0x48, 0x00, 0x36, 0x00, 0xFF, 0x00, 0xB7, 0xB7,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x02, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x10, 0x00, 0x12, 0x00, 0x04,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x3B, 0x31, 0x31, 0x00, 0x3A, 0x00, 0x06, 0x11,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xF1, 0x85, 0xE9, 0x32, 0x40, 0xE9, 0x00, 0xEB,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x88, 0x02, 0x10,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0x20, 0x00, 0x00,
+	  0x3B, 0x31, 0x00, 0x3A, 0x00, 0x06, 0xEA, 0x00,
+	  0xF2, 0x05, 0x01, 0x00, 0x31, 0xE9,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0xFF, 0xFF, 0x1B, 0x00,
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  },
+	 },
+};
+
+#endif				/* __SMI_REGS_H__ */

--=-GzVKVITUotwBchgfD2st--
