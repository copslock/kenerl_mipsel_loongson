Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 10:31:27 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.188]:26346
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224850AbVDFJbI>; Wed, 6 Apr 2005 10:31:08 +0100
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DJ6sM-0005Bh-00
	for linux-mips@linux-mips.org; Wed, 06 Apr 2005 11:31:06 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DJ6sM-0002YL-00
	for linux-mips@linux-mips.org; Wed, 06 Apr 2005 11:31:07 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Au1100 FB driver uplift for 2.6
Date:	Wed, 6 Apr 2005 11:31:37 +0200
User-Agent: KMail/1.7.2
References: <200504041717.29098.eckhardt@satorlaser.com> <de11cd376cdc88e9c292ae7e204e2de9@embeddededge.com>
In-Reply-To: <de11cd376cdc88e9c292ae7e204e2de9@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061131.38457.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Dan Malek wrote:
> On Apr 4, 2005, at 11:17 AM, Ulrich Eckhardt wrote:
> > Am I on the wrong way or should I just reimplement it and send a patch?
>
> If you an test it, do it and send a patch.

There will be two patches, this one doesn't reimplement the mentioned 
feature but fixes a few other bugs. 

There are two questions left in that patch, apart from the handling of the 
WWPC display as mentioned in the header. One is, if there was a reason to 
use a fixed-size char array for the panelname. 

The other is about the use of au1100fb_fix and au1100fb_var. Is the 
explanation in the patch accurate? Would it make more sense to write 
directly into fbdev->info.var and fbdev->info.fixed? Also, couldn't 
au1100fb_drv_probe() be declared as __init? After all, a late call to 
au1100fb_drv_probe() will probably have fatal consequences anyway because 
it depends on the above and they are declared __initdata.

Uli

Changes:
 * fixed typos, inconsistent formatting and trailing whitespace
 * added a check to a kalloc() call
 * fixed possible resource leak in au1100fb_drv_probe()
 * replaced the fixed-size panel name with a char pointer 
 * added a few 'const'
 * added display data for PrimeView PD104SL5

---
Index: drivers/video/au1100fb.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/au1100fb.c,v
retrieving revision 1.6
diff -u -r1.6 au1100fb.c
--- drivers/video/au1100fb.c 4 Apr 2005 01:06:20 -0000 1.6
+++ drivers/video/au1100fb.c 6 Apr 2005 09:03:54 -0000
@@ -3,7 +3,7 @@
  * Au1100 LCD Driver.
  *
  * Rewritten for 2.6 by Embedded Alley Solutions
- *  <source@embeddedalley.com>, based on submissions by 
+ *  <source@embeddedalley.com>, based on submissions by
  *   Karl Lessard <klessard@sunrisetelecom.com>
  *   <c.pellegrin@exadron.com>
  *
@@ -56,7 +56,7 @@
 
 #include "au1100fb.h"
 
-/* 
+/*
  * Sanity check. If this is a new Au1100 based board, search for
  * the PB1100 ifdefs to make sure you modify the code accordingly.
  */
@@ -74,11 +74,11 @@
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
    /*     Red,     Green,   Blue,       Transp   */
  { { 10, 6, 0 }, { 5, 5, 0 }, { 0, 5, 0 }, { 0, 0, 0 } },
@@ -91,6 +91,8 @@
  { { 8, 4, 0 },  { 4, 4, 0 }, { 0, 4, 0 }, { 0, 0, 0 } },
 };
 
+/* au1100fb_fix and au1100fb_var are local vars of au1100fb_drv_probe() but
+defined here in order to not exhaust the stack. */
 static struct fb_fix_screeninfo au1100fb_fix __initdata = {
  .id  = "AU1100 FB",
  .xpanstep  = 1,
@@ -111,7 +113,7 @@
 /*
  * Set hardware with var settings. This will enable the controller with a specific
  * mode, normally validated with the fb_check_var method
-  */
+ */
 int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
  struct fb_info *info = &fbdev->info;
@@ -142,7 +144,7 @@
    info->var.transp.msb_right = 0;
 
    info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-   info->fix.line_length = info->var.xres_virtual / 
+   info->fix.line_length = info->var.xres_virtual /
        (8/info->var.bits_per_pixel);
   } else {
    /* non-palettized */
@@ -154,7 +156,7 @@
 
    info->fix.visual = FB_VISUAL_TRUECOLOR;
    info->fix.line_length = info->var.xres_virtual << 1; /* depth=16 */
- }
+  }
  } else {
   /* mono */
   info->fix.visual = FB_VISUAL_MONO10;
@@ -162,7 +164,7 @@
  }
 
  info->screen_size = info->fix.line_length * info->var.yres_virtual;
- 
+
  /* Determine BPP mode and format */
  fbdev->regs->lcd_control = fbdev->panel->control_base |
        ((info->var.rotate/90) << LCD_CONTROL_SM_BIT);
@@ -183,8 +185,8 @@
    * otherwise display the same as the first panel */
   if (info->var.yres_virtual >= (info->var.yres << 1)) {
    fbdev->regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys +
-         (info->fix.line_length * 
-                (info->var.yres_virtual >> 1)));
+         (info->fix.line_length *
+         (info->var.yres_virtual >> 1)));
   } else {
    fbdev->regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys);
   }
@@ -201,7 +203,7 @@
 
  fbdev->regs->lcd_pwmdiv = 0;
  fbdev->regs->lcd_pwmhi = 0;
-   
+
  /* Resume controller */
  fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 
@@ -222,22 +224,22 @@
 
  if (fbi->var.grayscale) {
   /* Convert color to grayscale */
-  red = green = blue = 
+  red = green = blue =
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
-  value = (red   << fbi->var.red.offset)  | 
+
+  value = (red   << fbi->var.red.offset)  |
    (green << fbi->var.green.offset)|
    (blue  << fbi->var.blue.offset);
   value &= 0xFFFF;
@@ -249,8 +251,8 @@
 
  } else if (panel_is_color(fbdev->panel)) {
   /* COLOR STN MODE */
-  value = (((panel_swap_rgb(fbdev->panel) ? blue : red) >> 12) & 0x000F) | 
-   ((green >> 8) & 0x00F0) | 
+  value = (((panel_swap_rgb(fbdev->panel) ? blue : red) >> 12) & 0x000F) |
+   ((green >> 8) & 0x00F0) |
    (((panel_swap_rgb(fbdev->panel) ? red : blue) >> 4) & 0x0F00);
   value &= 0xFFF;
  } else {
@@ -260,7 +262,7 @@
  }
 
  palette[regno] = value;
- 
+
  return 0;
 }
 
@@ -277,14 +279,14 @@
  switch (blank_mode) {
 
  case VESA_NO_BLANKING:
-   /* Turn on panel */
-   fbdev->regs->lcd_control |= LCD_CONTROL_GO;
+  /* Turn on panel */
+  fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-   if (drv_info.panel_idx == 1) {
-    au_writew(au_readw(PB1100_G_CONTROL) 
-       | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD), 
-   PB1100_G_CONTROL);
-   }
+  if (drv_info.panel_idx == 1) {
+   au_writew(au_readw(PB1100_G_CONTROL)
+     | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
+    PB1100_G_CONTROL);
+  }
 #endif
   au_sync();
   break;
@@ -292,20 +294,20 @@
  case VESA_VSYNC_SUSPEND:
  case VESA_HSYNC_SUSPEND:
  case VESA_POWERDOWN:
-   /* Turn off panel */
-   fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
+  /* Turn off panel */
+  fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-   if (drv_info.panel_idx == 1) {
-    au_writew(au_readw(PB1100_G_CONTROL) 
-         & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
-   PB1100_G_CONTROL);
-   }
+  if (drv_info.panel_idx == 1) {
+   au_writew(au_readw(PB1100_G_CONTROL)
+     & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
+    PB1100_G_CONTROL);
+  }
 #endif
   au_sync();
   break;
- default: 
-  break;
 
+ default:
+  break;
  }
  return 0;
 }
@@ -328,7 +330,7 @@
   /* No support for X panning for now! */
   return -EINVAL;
  }
-   
+
  print_dbg("fb_pan_display 2 %p %p", var, fbi);
  dy = var->yoffset - fbi->var.yoffset;
  if (dy) {
@@ -340,14 +342,14 @@
   dmaaddr = fbdev->regs->lcd_dmaaddr0;
   dmaaddr += (fbi->fix.line_length * dy);
 
-  /* TODO: Wait for current frame to finished */
+  /* TODO: Wait for current frame to be finished */
   fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
 
   if (panel_is_dual(fbdev->panel)) {
    dmaaddr = fbdev->regs->lcd_dmaaddr1;
    dmaaddr += (fbi->fix.line_length * dy);
    fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
- }
+  }
  }
  print_dbg("fb_pan_display 3 %p %p", var, fbi);
 
@@ -388,7 +390,7 @@
  if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
   return -EINVAL;
  }
-    
+
  start = fbdev->fb_phys & PAGE_MASK;
  len = PAGE_ALIGN((start & ~PAGE_MASK) + fbdev->fb_len);
 
@@ -405,7 +407,7 @@
  pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6
 
  vma->vm_flags |= VM_IO;
-    
+
  if (io_remap_page_range(vma, vma->vm_start, off,
     vma->vm_end - vma->vm_start,
     vma->vm_page_prot)) {
@@ -415,7 +417,7 @@
  return 0;
 }
 
-static struct fb_ops au1100fb_ops = 
+static struct fb_ops au1100fb_ops =
 {
  .owner   = THIS_MODULE,
  .fb_setcolreg  = au1100fb_fb_setcolreg,
@@ -440,13 +442,14 @@
  struct resource *regs_res;
  unsigned long page;
  u32 sys_clksrc;
+ int res = 0;
 
  if (!dev)
-   return -EINVAL;
+  return -EINVAL;
 
  /* Allocate new device private */
  if (!(fbdev = kmalloc(sizeof(struct au1100fb_device), GFP_KERNEL))) {
-  print_err("fail to allocate device private record");
+  print_err("failed to allocate device private record");
   return -ENOMEM;
  }
  memset((void*)fbdev, 0, sizeof(struct au1100fb_device));
@@ -456,20 +459,22 @@
  dev_set_drvdata(dev, (void*)fbdev);
 
  /* Allocate region for our registers and map them */
- if (!(regs_res = platform_get_resource(to_platform_device(dev), 
+ if (!(regs_res = platform_get_resource(to_platform_device(dev),
      IORESOURCE_MEM, 0))) {
-  print_err("fail to retrieve registers resource");
-  return -EFAULT;
+  print_err("failed to retrieve registers resource");
+  res = -EFAULT;
+  goto failed;
  }
 
  au1100fb_fix.mmio_start = regs_res->start;
  au1100fb_fix.mmio_len = regs_res->end - regs_res->start + 1;
 
- if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len, 
+ if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len,
     DRIVER_NAME)) {
-  print_err("fail to lock memory region at 0x%08x", 
+  print_err("failed to lock memory region at 0x%08x",
     au1100fb_fix.mmio_start);
-  return -EBUSY;
+  res = -EBUSY;
+  goto failed;
  }
 
  fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(au1100fb_fix.mmio_start);
@@ -478,17 +483,17 @@
  print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
 
 
-
  /* Allocate the framebuffer to the maximum screen size * nbr of video buffers */
  fbdev->fb_len = fbdev->panel->xres * fbdev->panel->yres *
      (fbdev->panel->bpp >> 3) * AU1100FB_NBR_VIDEO_BUFFERS;
- 
- fbdev->fb_mem = dma_alloc_coherent(dev, PAGE_ALIGN(fbdev->fb_len), 
+
+ fbdev->fb_mem = dma_alloc_coherent(dev, PAGE_ALIGN(fbdev->fb_len),
      &fbdev->fb_phys, GFP_KERNEL);
  if (!fbdev->fb_mem) {
-  print_err("fail to allocate frambuffer (size: %dK))", 
+  print_err("failed to allocate frambuffer (size: %dKiB))",
      fbdev->fb_len / 1024);
-  return -ENOMEM;
+  res = -ENOMEM;
+  goto failed;
  }
 
  au1100fb_fix.smem_start = fbdev->fb_phys;
@@ -499,7 +504,7 @@
   * since we'll be remapping normal memory.
   */
  for (page = (unsigned long)fbdev->fb_mem;
-      page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len); 
+      page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len);
       page += PAGE_SIZE) {
 #if CONFIG_DMA_NONCOHERENT
   SetPageReserved(virt_to_page(CAC_ADDR(page)));
@@ -527,15 +532,17 @@
  fbdev->info.fix = au1100fb_fix;
 
  if (!(fbdev->info.pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL))) {
-  return -ENOMEM;
+  print_err("failed to allocate pseudo palette");
+  res = -ENOMEM;
+  goto failed;
  }
  memset(fbdev->info.pseudo_palette, 0, sizeof(u32) * 16);
 
  if (fb_alloc_cmap(&fbdev->info.cmap, AU1100_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
-  print_err("Fail to allocate colormap (%d entries)",
+  print_err("failed to allocate colormap (%d entries)",
       AU1100_LCD_NBR_PALETTE_ENTRIES);
-  kfree(fbdev->info.pseudo_palette);
-  return -EFAULT;
+  res = -EFAULT;
+  goto failed;
  }
 
  fbdev->info.var = au1100fb_var;
@@ -546,25 +553,30 @@
  /* Register new framebuffer */
  if (register_framebuffer(&fbdev->info) < 0) {
   print_err("cannot register new framebuffer");
+  res = -EFAULT;
   goto failed;
  }
 
  return 0;
 
 failed:
- if (fbdev->regs) {
-  release_mem_region(fbdev->regs_phys, fbdev->regs_len);
+ /** Failure. Release all resources in opposite order of allocation. */
+ if (fbdev->info.cmap.len != 0) {
+  fb_dealloc_cmap(&fbdev->info.cmap);
+ }
+ if (fbdev->info.pseudo_palette){
+  kfree(fbdev->info.pseudo_palette);
  }
  if (fbdev->fb_mem) {
   dma_free_noncoherent(dev, fbdev->fb_len, fbdev->fb_mem, fbdev->fb_phys);
  }
- if (fbdev->info.cmap.len != 0) {
-  fb_dealloc_cmap(&fbdev->info.cmap);
+ if (fbdev->regs) {
+  release_mem_region(fbdev->regs_phys, fbdev->regs_len);
  }
- kfree(fbdev);
  dev_set_drvdata(dev, NULL);
+ kfree(fbdev);
 
- return 0;
+ return res;
 }
 
 int au1100fb_drv_remove(struct device *dev)
@@ -610,17 +622,16 @@
 static struct device_driver au1100fb_driver = {
  .name  = "au1100-lcd",
  .bus  = &platform_bus_type,
-
  .probe  = au1100fb_drv_probe,
-        .remove  = au1100fb_drv_remove,
+ .remove  = au1100fb_drv_remove,
  .suspend = au1100fb_drv_suspend,
-        .resume  = au1100fb_drv_resume,
+ .resume  = au1100fb_drv_resume,
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
@@ -631,44 +642,48 @@
  if (num_panels <= 0) {
   print_err("No LCD panels supported by driver!");
   return -EFAULT;
-   }
+ }
 
  if (options) {
   while ((this_opt = strsep(&options,",")) != NULL) {
+   size_t len = strlen(this_opt);
    /* Panel option */
-  if (!strncmp(this_opt, "panel:", 6)) {
+   if (!strncmp(this_opt, "panel:", 6)) {
     int i;
     this_opt += 6;
     for (i = 0; i < num_panels; i++) {
      if (!strncmp(this_opt,
-                 known_lcd_panels[i].name, 
-       strlen(this_opt))) {
+                 known_lcd_panels[i].name,
+                  len)) {
       panel_idx = i;
-     break;
+      break;
+     }
     }
-   }
     if (i >= num_panels) {
       print_warn("Panel %s not supported!", this_opt);
+     return -ENOTSUPP;
     }
    }
    /* Mode option (only option that start with digit) */
    else if (isdigit(this_opt[0])) {
-    mode = kmalloc(strlen(this_opt) + 1, GFP_KERNEL);
-    strncpy(mode, this_opt, strlen(this_opt) + 1);
+    mode = kmalloc(len+1, GFP_KERNEL);
+    if(!mode)
+     return -ENOMEM;
+    strncpy(mode, this_opt, len);
    }
    /* Unsupported option */
    else {
     print_warn("Unsupported option \"%s\"", this_opt);
+   }
   }
-  }
- } 
+ }
 
  drv_info.panel_idx = panel_idx;
  drv_info.opt_mode = mode;
 
  print_info("Panel=%s Mode=%s",
    known_lcd_panels[drv_info.panel_idx].name,
-         drv_info.opt_mode ? drv_info.opt_mode : "default");
+   drv_info.opt_mode ? drv_info.opt_mode : "default");
 
  return 0;
 }
@@ -677,9 +692,9 @@
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
@@ -688,7 +703,7 @@
  /* Setup driver with options */
  ret = au1100fb_setup(options);
  if (ret < 0) {
-  print_err("Fail to setup driver");
+  print_err("Failed to setup driver");
   return ret;
  }
 
Index: drivers/video/au1100fb.h
===================================================================
RCS file: /home/cvs/linux/drivers/video/au1100fb.h,v
retrieving revision 1.2
diff -u -r1.2 au1100fb.h
--- drivers/video/au1100fb.h 4 Apr 2005 01:06:20 -0000 1.2
+++ drivers/video/au1100fb.h 6 Apr 2005 09:03:54 -0000
@@ -65,20 +65,20 @@
 
 struct au1100fb_panel
 {
- const char name[25];  /* Full name <vendor>_<model> */
+ const char* name;  /* Full name <vendor>_<model> */
 
- u32    control_base;  /* Mode-independent control values */
+ u32 control_base;  /* Mode-independent control values */
  u32 clkcontrol_base; /* Panel pixclock preferences */
 
  u32 horztiming;
  u32 verttiming;
 
  u32 xres;  /* Maximum horizontal resolution */
- u32  yres;  /* Maximum vertical resolution */
- u32  bpp;  /* Maximum depth supported */
+ u32 yres;  /* Maximum vertical resolution */
+ u32 bpp;  /* Maximum depth supported */
 };
 
-struct au1100fb_regs 
+struct au1100fb_regs
 {
  u32  lcd_control;
  u32  lcd_intstatus;
@@ -99,7 +99,7 @@
 
  struct fb_info info;   /* FB driver info record */
 
- struct au1100fb_panel  *panel;  /* Panel connected to this device */
+ const struct au1100fb_panel  *panel;  /* Panel connected to this device */
 
  struct au1100fb_regs*  regs;  /* Registers memory map */
  size_t         regs_len;
@@ -255,7 +255,7 @@
 
 /* List of panels known to work with the AU1100 LCD controller.
  * To add a new panel, enter the same specifications as the
- * Generic_TFT one, and MAKE SURE that it doesn't conflicts 
+ * Generic_TFT one, and MAKE SURE that it doesn't conflicts
  * with the controller restrictions. Restrictions are:
  *
  * STN color panels: max_bpp <= 12
@@ -264,7 +264,7 @@
  * max_xres <= 800
  * max_yres <= 600
  */
-static struct au1100fb_panel known_lcd_panels[] =
+static const struct au1100fb_panel known_lcd_panels[] =
 {
  /* 800x600x16bpp CRT */
  [0] = {
@@ -272,14 +272,24 @@
   .xres = 800,
   .yres = 600,
   .bpp = 16,
-  .control_base = 0x0004886A | 
+  .control_base = 0x0004886A |
    LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
    LCD_CONTROL_BPP_16,
   .clkcontrol_base = 0x00020000,
   .horztiming = 0x005aff1f,
   .verttiming = 0x16000e57,
  },
- /* just the standard LCD */
+
+ /* just the standard LCD
+ TODO: There is only one case where the index in this array is checked,
+ and that also only on PB1100 boards. Clarify when exactly this is used
+ and why, and possibly integrate this differently.
+
+ Also, I'm not sure the code is right: in older versions, WWPC had this
+ display hard-coded in, and for PB1100 and DB1100, there was a way to
+ select a display by reading the BCSR. Now, there seems to be a special
+ way of blanking/unblanking this particular display.
+ */
  [1] = {
   .name = "WWPC LCD",
   .xres = 240,
@@ -290,6 +300,7 @@
   .verttiming = 0x0301013F,
   .clkcontrol_base = 0x00018001,
  },
+
  /* Sharp 320x240 TFT panel */
  [2] = {
   .name = "Sharp_LQ038Q5DR01",
@@ -351,7 +362,7 @@
   .clkcontrol_base = LCD_CLKCONTROL_PCD_N(1),
  },
 
-  /* Pb1100 LCDB 640x480 PrimeView TFT panel */
+ /* Pb1100 LCDB 640x480 PrimeView TFT panel */
  [5] = {
   .name = "PrimeView_640x480_16",
   .xres = 640,
@@ -362,6 +373,37 @@
   .verttiming = 0x210805df,
   .clkcontrol_base = 0x00038001,
  },
+
+ /* PrimeView PD104SL5 , a 800x600 16BPP color LCD */
+ [6] = {
+  .name = "PrimeView_PD104SL5",
+  .xres = 800,
+  .yres = 640,
+  .bpp = 16,
+  .control_base =
+   ( LCD_CONTROL_SBPPF_565
+   | LCD_CONTROL_C
+   | LCD_CONTROL_SM_0
+   | LCD_CONTROL_DEFAULT_PO
+   | LCD_CONTROL_CCO
+   | LCD_CONTROL_PT
+   | LCD_CONTROL_PC
+   | LCD_CONTROL_BPP_16 ),
+  .horztiming =
+   ( LCD_HORZTIMING_HN2_N(30)
+   | LCD_HORZTIMING_HN1_N(30)
+   | LCD_HORZTIMING_HPW_N(60)
+   | LCD_HORZTIMING_PPL_N(800) ),
+  .verttiming =
+   ( LCD_VERTTIMING_VN2_N(1)
+   | LCD_VERTTIMING_VN1_N(1)
+   | LCD_VERTTIMING_VPW_N(2)
+   | LCD_VERTTIMING_LPP_N(600) ),
+  .clkcontrol_base =
+   ( LCD_CLKCONTROL_IH
+   | LCD_CLKCONTROL_IV
+   | LCD_CLKCONTROL_PCD_N(1)),
+ }
 };
 
 struct au1100fb_drv_info {
