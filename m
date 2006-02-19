Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 23:41:25 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:29453 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133618AbWBSXlN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 23:41:13 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5D58664D3D; Sun, 19 Feb 2006 23:48:05 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5D6A88D5D; Sun, 19 Feb 2006 23:47:57 +0000 (GMT)
Date:	Sun, 19 Feb 2006 23:47:57 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:	stevel@mvista.com, wyldfier@iname.com, lachwani@pmc-sierra.com,
	dan@embeddededge.com, johuang@siliconmotion.com
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060219234757.GW10266@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219234318.GA16311@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Decrease delta between Linus and linux-mips tree: small changes

Decrease the delta between the Linus and linux-mips trees.  This
patch addresses some small differences where the Linus tree is right
and linux-mips should be changed accordingly.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 mtd/devices/Kconfig |    5 ---
 mtd/maps/lasat.c    |    4 +-
 net/declance.c      |    1
 scsi/dec_esp.c      |    2 -
 video/Kconfig       |    4 +-
 video/au1100fb.c    |   74 ++++++++++++++++++++++++++--------------------------
 video/au1100fb.h    |    6 ++--
 7 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 6acfa3d..dd628cb 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -47,11 +47,6 @@ config MTD_MS02NV
 	  accelerator.  Say Y here if you have a DECstation 5000/2x0 or a
 	  DECsystem 5900 equipped with such a module.
 
-	  If you want to compile this driver as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module will
-	  be called ms02-nv.o.
-
 config MTD_DATAFLASH
 	tristate "Support for AT45xxx DataFlash"
 	depends on MTD && SPI_MASTER && EXPERIMENTAL
diff --git a/drivers/mtd/maps/lasat.c b/drivers/mtd/maps/lasat.c
index 2a2efaa..c658d40 100644
--- a/drivers/mtd/maps/lasat.c
+++ b/drivers/mtd/maps/lasat.c
@@ -7,7 +7,7 @@
  * modify it under the terms of the GNU General Public License version
  * 2 as published by the Free Software Foundation.
  *
- * $Id: lasat.c,v 1.7 2004/07/12 21:59:44 dwmw2 Exp $
+ * $Id: lasat.c,v 1.9 2004/11/04 13:24:15 gleixner Exp $
  *
  */
 
@@ -50,7 +50,7 @@ static int __init init_lasat(void)
 	ENABLE_VPP((&lasat_map));
 
 	lasat_map.phys = lasat_flash_partition_start(LASAT_MTD_BOOTLOADER);
-	lasat_map.virt = (unsigned long)ioremap_nocache(
+	lasat_map.virt = ioremap_nocache(
 		        lasat_map.phys, lasat_board_info.li_flash_size);
 	lasat_map.size = lasat_board_info.li_flash_size;
 
diff --git a/drivers/net/declance.c b/drivers/net/declance.c
index d049129..6561575 100644
--- a/drivers/net/declance.c
+++ b/drivers/net/declance.c
@@ -1301,7 +1301,6 @@ static void __exit dec_lance_cleanup(voi
 	while (root_lance_dev) {
 		struct net_device *dev = root_lance_dev;
 		struct lance_private *lp = netdev_priv(dev);
-
 		unregister_netdev(dev);
 #ifdef CONFIG_TC
 		if (lp->slot >= 0)
diff --git a/drivers/scsi/dec_esp.c b/drivers/scsi/dec_esp.c
index e755664..4b86685 100644
--- a/drivers/scsi/dec_esp.c
+++ b/drivers/scsi/dec_esp.c
@@ -55,7 +55,7 @@
 
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static void dma_drain(struct NCR_ESP *esp);
-static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd * sp);
+static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
 static void dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
 static void dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length);
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7d7724c..7e63f15 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1336,8 +1336,8 @@ config FB_PMAGB_B
  	select FB_CFB_IMAGEBLIT
 	help
 	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
-	  in the MIPS-based DECstation series. The card is currently only 
-	  supported in 1280x1024x8 mode.  
+	  in the MIPS-based DECstation series. The card is currently only
+	  supported in 1280x1024x8 mode.
 
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer support"
diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index e821bba..11b87d5 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -3,7 +3,7 @@
  *	Au1100 LCD Driver.
  *
  * Rewritten for 2.6 by Embedded Alley Solutions
- * 	<source@embeddedalley.com>, based on submissions by 
+ * 	<source@embeddedalley.com>, based on submissions by
  *  	Karl Lessard <klessard@sunrisetelecom.com>
  *  	<c.pellegrin@exadron.com>
  *
@@ -57,7 +57,7 @@
 
 #include "au1100fb.h"
 
-/* 
+/*
  * Sanity check. If this is a new Au1100 based board, search for
  * the PB1100 ifdefs to make sure you modify the code accordingly.
  */
@@ -75,11 +75,11 @@
 #define to_au1100fb_device(_info) \
 	  (_info ? container_of(_info, struct au1100fb_device, info) : NULL);
 
-/* Bitfields format supported by the controller. Note that the order of formats 
+/* Bitfields format supported by the controller. Note that the order of formats
  * SHOULD be the same as in the LCD_CONTROL_SBPPF field, so we can retrieve the
  * right pixel format by doing rgb_bitfields[LCD_CONTROL_SBPPF_XXX >> LCD_CONTROL_SBPPF]
  */
-struct fb_bitfield rgb_bitfields[][4] = 
+struct fb_bitfield rgb_bitfields[][4] =
 {
   	/*     Red, 	   Green, 	 Blue, 	     Transp   */
 	{ { 10, 6, 0 }, { 5, 5, 0 }, { 0, 5, 0 }, { 0, 0, 0 } },
@@ -143,7 +143,7 @@ int au1100fb_setmode(struct au1100fb_dev
 			info->var.transp.msb_right = 0;
 
 			info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-			info->fix.line_length = info->var.xres_virtual / 
+			info->fix.line_length = info->var.xres_virtual /
 							(8/info->var.bits_per_pixel);
 		} else {
 			/* non-palettized */
@@ -163,7 +163,7 @@ int au1100fb_setmode(struct au1100fb_dev
 	}
 
 	info->screen_size = info->fix.line_length * info->var.yres_virtual;
-	
+
 	/* Determine BPP mode and format */
 	fbdev->regs->lcd_control = fbdev->panel->control_base |
 			    ((info->var.rotate/90) << LCD_CONTROL_SM_BIT);
@@ -184,7 +184,7 @@ int au1100fb_setmode(struct au1100fb_dev
 		 * otherwise display the same as the first panel */
 		if (info->var.yres_virtual >= (info->var.yres << 1)) {
 			fbdev->regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys +
-							  (info->fix.line_length * 
+							  (info->fix.line_length *
 						          (info->var.yres_virtual >> 1)));
 		} else {
 			fbdev->regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys);
@@ -202,7 +202,7 @@ int au1100fb_setmode(struct au1100fb_dev
 
 	fbdev->regs->lcd_pwmdiv = 0;
 	fbdev->regs->lcd_pwmhi = 0;
-   
+
 	/* Resume controller */
 	fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 
@@ -223,22 +223,22 @@ int au1100fb_fb_setcolreg(unsigned regno
 
 	if (fbi->var.grayscale) {
 		/* Convert color to grayscale */
-		red = green = blue = 
+		red = green = blue =
 			(19595 * red + 38470 * green + 7471 * blue) >> 16;
 	}
-   
+
 	if (fbi->fix.visual == FB_VISUAL_TRUECOLOR) {
 		/* Place color in the pseudopalette */
 		if (regno > 16)
 			return -EINVAL;
-   
+
 		palette = (u32*)fbi->pseudo_palette;
 
 		red   >>= (16 - fbi->var.red.length);
 		green >>= (16 - fbi->var.green.length);
 		blue  >>= (16 - fbi->var.blue.length);
-	
-		value = (red   << fbi->var.red.offset) 	|	
+
+		value = (red   << fbi->var.red.offset) 	|
 			(green << fbi->var.green.offset)|
 			(blue  << fbi->var.blue.offset);
 		value &= 0xFFFF;
@@ -250,8 +250,8 @@ int au1100fb_fb_setcolreg(unsigned regno
 
 	} else if (panel_is_color(fbdev->panel)) {
 		/* COLOR STN MODE */
-		value = (((panel_swap_rgb(fbdev->panel) ? blue : red) >> 12) & 0x000F) | 
-			((green >> 8) & 0x00F0) | 
+		value = (((panel_swap_rgb(fbdev->panel) ? blue : red) >> 12) & 0x000F) |
+			((green >> 8) & 0x00F0) |
 			(((panel_swap_rgb(fbdev->panel) ? red : blue) >> 4) & 0x0F00);
 		value &= 0xFFF;
 	} else {
@@ -261,7 +261,7 @@ int au1100fb_fb_setcolreg(unsigned regno
 	}
 
 	palette[regno] = value;
-	
+
 	return 0;
 }
 
@@ -282,8 +282,8 @@ int au1100fb_fb_blank(int blank_mode, st
 			fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
 			if (drv_info.panel_idx == 1) {
-				au_writew(au_readw(PB1100_G_CONTROL) 
-					  | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD), 
+				au_writew(au_readw(PB1100_G_CONTROL)
+					  | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
 			PB1100_G_CONTROL);
 			}
 #endif
@@ -297,14 +297,14 @@ int au1100fb_fb_blank(int blank_mode, st
 			fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
 			if (drv_info.panel_idx == 1) {
-				au_writew(au_readw(PB1100_G_CONTROL) 
+				au_writew(au_readw(PB1100_G_CONTROL)
 				  	  & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
 			PB1100_G_CONTROL);
 			}
 #endif
 		au_sync();
 		break;
-	default: 
+	default:
 		break;
 
 	}
@@ -329,7 +329,7 @@ int au1100fb_fb_pan_display(struct fb_va
 		/* No support for X panning for now! */
 		return -EINVAL;
 	}
-			
+
 	print_dbg("fb_pan_display 2 %p %p", var, fbi);
 	dy = var->yoffset - fbi->var.yoffset;
 	if (dy) {
@@ -389,7 +389,7 @@ int au1100fb_fb_mmap(struct fb_info *fbi
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
 		return -EINVAL;
 	}
-    
+
 	start = fbdev->fb_phys & PAGE_MASK;
 	len = PAGE_ALIGN((start & ~PAGE_MASK) + fbdev->fb_len);
 
@@ -406,7 +406,7 @@ int au1100fb_fb_mmap(struct fb_info *fbi
 	pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6
 
 	vma->vm_flags |= VM_IO;
-    
+
 	if (io_remap_page_range(vma, vma->vm_start, off,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
@@ -416,7 +416,7 @@ int au1100fb_fb_mmap(struct fb_info *fbi
 	return 0;
 }
 
-static struct fb_ops au1100fb_ops = 
+static struct fb_ops au1100fb_ops =
 {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= au1100fb_fb_setcolreg,
@@ -456,7 +456,7 @@ int au1100fb_drv_probe(struct device *de
 	dev_set_drvdata(dev, (void*)fbdev);
 
 	/* Allocate region for our registers and map them */
-	if (!(regs_res = platform_get_resource(to_platform_device(dev), 
+	if (!(regs_res = platform_get_resource(to_platform_device(dev),
 					IORESOURCE_MEM, 0))) {
 		print_err("fail to retrieve registers resource");
 		return -EFAULT;
@@ -465,9 +465,9 @@ int au1100fb_drv_probe(struct device *de
 	au1100fb_fix.mmio_start = regs_res->start;
 	au1100fb_fix.mmio_len = regs_res->end - regs_res->start + 1;
 
-	if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len, 
+	if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len,
 				DRIVER_NAME)) {
-		print_err("fail to lock memory region at 0x%08x", 
+		print_err("fail to lock memory region at 0x%08x",
 				au1100fb_fix.mmio_start);
 		return -EBUSY;
 	}
@@ -482,11 +482,11 @@ int au1100fb_drv_probe(struct device *de
 	/* Allocate the framebuffer to the maximum screen size * nbr of video buffers */
 	fbdev->fb_len = fbdev->panel->xres * fbdev->panel->yres *
 		  	(fbdev->panel->bpp >> 3) * AU1100FB_NBR_VIDEO_BUFFERS;
-	
-	fbdev->fb_mem = dma_alloc_coherent(dev, PAGE_ALIGN(fbdev->fb_len), 
+
+	fbdev->fb_mem = dma_alloc_coherent(dev, PAGE_ALIGN(fbdev->fb_len),
 					&fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate frambuffer (size: %dK))", 
+		print_err("fail to allocate frambuffer (size: %dK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
@@ -499,7 +499,7 @@ int au1100fb_drv_probe(struct device *de
 	 * since we'll be remapping normal memory.
 	 */
 	for (page = (unsigned long)fbdev->fb_mem;
-	     page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len); 
+	     page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len);
 	     page += PAGE_SIZE) {
 #if CONFIG_DMA_NONCOHERENT
 		SetPageReserved(virt_to_page(CAC_ADDR(page)));
@@ -616,11 +616,11 @@ static struct device_driver au1100fb_dri
 	.suspend	= au1100fb_drv_suspend,
         .resume		= au1100fb_drv_resume,
 };
-    
+
 /*-------------------------------------------------------------------------*/
 
 /* Kernel driver */
-    
+
 int au1100fb_setup(char *options)
 {
 	char* this_opt;
@@ -641,7 +641,7 @@ int au1100fb_setup(char *options)
 				this_opt += 6;
 				for (i = 0; i < num_panels; i++) {
 					if (!strncmp(this_opt,
-					      	     known_lcd_panels[i].name, 
+					      	     known_lcd_panels[i].name,
 							strlen(this_opt))) {
 						panel_idx = i;
 					break;
@@ -661,7 +661,7 @@ int au1100fb_setup(char *options)
 				print_warn("Unsupported option \"%s\"", this_opt);
 		}
 		}
-	} 
+	}
 
 	drv_info.panel_idx = panel_idx;
 	drv_info.opt_mode = mode;
@@ -677,9 +677,9 @@ int __init au1100fb_init(void)
 {
 	char* options;
 	int ret;
-	
+
 	print_info("" DRIVER_DESC "");
-	
+
 	memset(&drv_info, 0, sizeof(drv_info));
 
 	if (fb_get_options(DRIVER_NAME, &options))
diff --git a/drivers/video/au1100fb.h b/drivers/video/au1100fb.h
index 07c5298..2855534 100644
--- a/drivers/video/au1100fb.h
+++ b/drivers/video/au1100fb.h
@@ -78,7 +78,7 @@ struct au1100fb_panel
 	u32 	bpp;		/* Maximum depth supported */
 };
 
-struct au1100fb_regs 
+struct au1100fb_regs
 {
 	u32  lcd_control;
 	u32  lcd_intstatus;
@@ -255,7 +255,7 @@ struct au1100fb_device {
 
 /* List of panels known to work with the AU1100 LCD controller.
  * To add a new panel, enter the same specifications as the
- * Generic_TFT one, and MAKE SURE that it doesn't conflicts 
+ * Generic_TFT one, and MAKE SURE that it doesn't conflicts
  * with the controller restrictions. Restrictions are:
  *
  * STN color panels: max_bpp <= 12
@@ -272,7 +272,7 @@ static struct au1100fb_panel known_lcd_p
 		.xres = 800,
 		.yres = 600,
 		.bpp = 16,
-		.control_base =	0x0004886A | 
+		.control_base =	0x0004886A |
 			LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
 			LCD_CONTROL_BPP_16,
 		.clkcontrol_base = 0x00020000,

-- 
Martin Michlmayr
http://www.cyrius.com/
