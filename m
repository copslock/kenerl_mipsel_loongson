Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Sep 2011 13:15:55 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:58444 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491009Ab1IKLPl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Sep 2011 13:15:41 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id 92CEC2D505;
        Sun, 11 Sep 2011 13:15:27 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id p8BCrTAq001120;
        Sun, 11 Sep 2011 12:53:29 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
        by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id p8BBEVL5004163;
        Sun, 11 Sep 2011 13:14:31 +0200
Received: from localhost (pf@localhost)
        by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id p8BBEVxP004160;
        Sun, 11 Sep 2011 13:14:31 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:   Sun, 11 Sep 2011 13:14:31 +0200 (CEST)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     attilio.fiandrotti@gmail.com
Subject: [PATCH] Impact video driver for SGI Indigo2
Message-ID: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-archive-position: 31057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5434



Here's an attempt to bloat the linux source a bit more ;-)

This patch brings, yet missing, parts that make a Linux-driven Indigo2
Impact (IP28 and most probably IP22-Impact) an usable desktop-machine
"out of the box".
The driver provides the framebuffer console and an interface for the
Xserver (mmap'ing a DMA-pool to the shadow framebuffer and doing the
necessary cacheflush).
Meanwhile only a few files are affected and obviously no side-effects
to other parts of the kernel are to be expected.

BTW: it would be appreciated, if someone could verify, that this driver
also works for IP22 Impact.


Signed-off-by: peter fuerst <post@pfrst.de>

---

1) Preparation

  drivers/video/Kconfig            |    6 ++++++
  drivers/video/Makefile           |    1 +
  drivers/video/logo/Kconfig       |    2 +-
  arch/mips/sgi-ip22/ip22-setup.c  |   37 +++++++++++++++++++++++++++++++++++++
  arch/mips/configs/ip28_defconfig |    1 +
  5 files changed, 46 insertions(+), 1 deletions(-)


diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 549b960..43dbc9f 100644
--- a/drivers/video/Kconfig	Thu Jan  1 00:00:00 1970
+++ b/drivers/video/Kconfig	Thu Mar 10 23:37:58 2011
@@ -2383,6 +2383,12 @@ config FB_PUV3_UNIGFX
  	  Choose this option if you want to use the Unigfx device as a
  	  framebuffer device. Without the support of PCI & AGP.

+config FB_IMPACT
+	tristate "SGI Indigo2 Impact graphics support"
+	depends on FB && (SGI_IP22 || SGI_IP28 || SGI_IP30)
+	help
+	  SGI Indigo2 Impact (SI/HI/MI) graphics card support.
+
  source "drivers/video/omap/Kconfig"
  source "drivers/video/omap2/Kconfig"



diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 8b83129..278c8fa 100644
--- a/drivers/video/Makefile	Thu Jan  1 00:00:00 1970
+++ b/drivers/video/Makefile	Thu Mar 10 23:44:40 2011
@@ -141,6 +141,7 @@ obj-$(CONFIG_FB_MSM)              += msm/
  obj-$(CONFIG_FB_NUC900)           += nuc900fb.o
  obj-$(CONFIG_FB_JZ4740)		  += jz4740_fb.o
  obj-$(CONFIG_FB_PUV3_UNIGFX)      += fb-puv3.o
+obj-$(CONFIG_FB_IMPACT)		  += impact.o

  # Platform or fallback drivers go here
  obj-$(CONFIG_FB_UVESA)            += uvesafb.o


diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index 39ac49e..3ac6da4 100644
--- a/drivers/video/logo/Kconfig	Thu Jan  1 00:00:00 1970
+++ b/drivers/video/logo/Kconfig	Fri May  8 00:51:01 2009
@@ -54,7 +54,7 @@ config LOGO_PARISC_CLUT224

  config LOGO_SGI_CLUT224
  	bool "224-color SGI Linux logo"
-	depends on SGI_IP22 || SGI_IP27 || SGI_IP32 || X86_VISWS
+	depends on SGI_IP22 || SGI_IP27 || SGI_IP28 || SGI_IP30 || SGI_IP32 || X86_VISWS
  	default y

  config LOGO_SUN_CLUT224


diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index 5e66213..085b612 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c	Thu Jan  1 00:00:00 1970
+++ b/arch/mips/sgi-ip22/ip22-setup.c	Fri May  8 01:05:13 2009
@@ -96,4 +96,41 @@ void __init plat_mem_setup(void)
  		}
  	}
  #endif
+#if defined(CONFIG_FB_IMPACT)
+	{
+		extern void setup_impact_earlycons(void);
+		/*
+		 * Get graphics info before it is overwritten...
+		 * E.g. @ 9000000020f02f78: ffffffff9fc6d770,900000001f000000
+		 */
+#ifdef CONFIG_ARC64
+		ULONG * (*__vec)(void) = (typeof(__vec))
+			((ULONG*)PROMBLOCK->pvector)[8];
+		ULONG *gfxinfo = (*__vec)();
+#else
+		/* supposed to work on both 32/64-bit kernels. */
+		int (*__vec)(void) = (typeof(__vec))
+			(long) ((int*)PROMBLOCK->pvector)[8];
+		int *gfxinfo = (typeof(gfxinfo)) (*__vec)();
+#endif
+		/* See note on __pa() in impact.c */
+		sgi_gfxaddr = __pa((void*)gfxinfo[1]);
+		if (sgi_gfxaddr < 0x1f000000 || 0x1fa00000 <= sgi_gfxaddr)
+			sgi_gfxaddr = 0;
+		/*
+		 * Early params are not yet avaialble, so this setting
+		 * must be done in the ARCS environment.
+		 */
+		ctype = ArcGetEnvironmentVariable("OSLoadOptions");
+		if (!ctype || !strstr(ctype, "impact=noearly"))
+#ifndef CONFIG_EARLY_PRINTK
+		if (ctype && strstr(ctype, "impact=early"))
+#endif
+			setup_impact_earlycons();
+
+		printk(KERN_DEBUG "ARCS gfx info @ %p: %p,%p\n",
+				gfxinfo, (void*)gfxinfo[0], (void*)gfxinfo[1]);
+		printk(KERN_INFO "SGI graphics system @ 0x%08lx\n", sgi_gfxaddr);
+	}
+#endif
  }


diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index 4dbf626..b316c86 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -78,3 +78,4 @@ CONFIG_MAGIC_SYSRQ=y
  CONFIG_CRYPTO_MANAGER=y
  # CONFIG_CRYPTO_HW is not set
  # CONFIG_CRC32 is not set
+CONFIG_FB_IMPACT=y


2) The driver

  drivers/video/impact.c | 1154 ++++++++++++++++++++++++++++++++++++++++++++++++
  include/video/impact.h |  210 +++++++++
  2 files changed, 1364 insertions(+), 0 deletions(-)


diff --git a/drivers/video/impact.c b/drivers/video/impact.c
new file mode 100644
index 0000000..5ffc948
--- /dev/null	Wed Dec  8 00:46:04 2004
+++ b/drivers/video/impact.c	Mon Jul 25 00:06:58 2011
@@ -0,0 +1,1154 @@
+/*
+ * linux/drivers/video/impactsr.c -- SGI Octane MardiGras (IMPACTSR) graphics
+ * linux/drivers/video/impact.c   -- SGI Indigo2 MardiGras (IMPACT) graphics
+ *
+ *  Copyright (c) 2004-2006 by Stanislaw Skowronek	(skylark@linux-mips.org)
+ *  Adapted to Indigo2 by pf, 2005,2006,2009,2011	(post@pfrst.de)
+ *
+ *  Based on linux/drivers/video/skeletonfb.c
+ *
+ *  This driver, as most of the IP30 (SGI Octane) port, is a result of massive
+ *  amounts of reverse engineering and trial-and-error. If anyone is interested
+ *  in helping with it, please contact me: <skylark@linux-mips.org>.
+ *
+ *  The basic functions of this driver are filling and blitting rectangles.
+ *  To achieve the latter, two DMA operations are used on Impact. It is unclear
+ *  to me, why is it so, but even Xsgi (the IRIX X11 server) does it this way.
+ *  It seems that fb->fb operations are not operational on these cards.
+ *
+ *  For this purpose, a kernel DMA pool is allocated (pool number 0). This pool
+ *  is (by default) 64kB in size. An ioctl could be used to set the value at
+ *  run-time. Applications can use this pool, however proper locking has to be
+ *  guaranteed. Kernel should be locked out from this pool by an ioctl.
+ *
+ *  The IMPACTSR is quite well worked-out currently, except for the Geometry
+ *  Engines (GE11). Any information about use of those devices would be very
+ *  useful. It would enable a Linux OpenGL driver, as most of OpenGL calls are
+ *  supported directly by the hardware. So far, I can't initialize the GE11.
+ *  Verification of microcode crashes the graphics.
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/font.h>
+#include <linux/platform_device.h>
+#include <linux/console.h>
+#include <linux/version.h>
+
+#ifndef CONFIG_64BIT
+#error (S)he, who can afford Impact-graphics, shall afford a 64bit-kernel also!
+#endif
+#ifdef CONFIG_SGI_IP30
+# include <asm/mach-ip30/xtalk.h>
+# define IPNR 30
+#else
+# if defined(CONFIG_SGI_IP22)
+#  define IPNR 22
+# elif defined(CONFIG_SGI_IP26)
+#  define IPNR 26
+# else
+#  define IPNR 28
+# endif
+#endif
+#define isSR (IPNR > 28)	/* avoid nasty #if... where possible. */
+#include <video/impact.h>
+
+/* Some fixed register values. */
+
+#if isSR	/* ImpactSR (HQ4) registers */
+#define VAL_CFIFO_HW	0x47
+#define VAL_CFIFO_LW	0x14
+#define VAL_CFIFO_DELAY	0x64
+#define VAL_DFIFO_HW	0x40
+#define VAL_DFIFO_LW	0x10
+#define VAL_DFIFO_DELAY	0
+#define MSK_CFIFO_CNT	0xff
+#define USEPOOLS	5
+#else	/* Impact (HQ3) registers */
+#define VAL_CFIFO_HW	0x20 /* 0x18 ? */
+#define VAL_CFIFO_LW	0x14
+#define VAL_CFIFO_DELAY	0x64
+#define VAL_DFIFO_HW	0x28
+#define VAL_DFIFO_LW	0x14
+#define VAL_DFIFO_DELAY	0xfff
+#define MSK_CFIFO_CNT	0x7f
+#define USEPOOLS	4
+#endif
+#define POOLS	5
+
+#define IMPACT_KPOOL_SIZE	65536
+
+struct impact_par {
+	/* physical mmio base in HEART XTalk space */
+	unsigned long mmio_base;
+	/* virtual mmio base in kernel space */
+	unsigned long mmio_virt;
+	struct {
+		/* DMA pool management, txtbl[0..num-1] passed to card */
+		unsigned int *txtbl;  /* txtbl[i] = pgidx(phys[i]) */
+		unsigned int txnum;   /* valid: txtbl[0..txnum-1] */
+		unsigned int txmax;   /* alloc: txtbl[0..txmax-1] */
+		unsigned long txphys; /* txphys = dma_addr(txtbl) */
+		/* kernel DMA pools, the actual DMA-buffers */
+		void*         *virt;  /* virt[0..txnum-1]: dma-page-addresses */
+		unsigned long *phys;  /* phys[i] = dma_addr(virt[i]) */
+		unsigned int size;
+		unsigned long uaddr;  /* DMA-buffer's userland-address */
+	} pools[POOLS];
+	/* board config */
+	unsigned int num_ge, num_rss;
+	/* locks to prevent simultaneous user and kernel access */
+	int open_flag;
+	int mmap_flag;
+	spinlock_t lock;
+	unsigned xoffset; /* fb_var_screeninfo.[xy]offset, are ... */
+	unsigned yoffset; /* ...used inconsistently (at the best). */
+};
+
+static struct fb_fix_screeninfo impact_fix = {
+	.id =		"ImpactSR 0RSS",
+	.smem_start = 	0,
+	.smem_len =	0,
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_TRUECOLOR,
+	.xpanstep =	0,
+	.ypanstep =	0,
+	.ywrapstep =	0,
+	.line_length =	0,
+	.accel =	FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo impact_var = {
+	.xres =		960,
+	.yres =		960,
+	.xres_virtual =	1280,
+	.yres_virtual =	1024,
+	.bits_per_pixel = 24,
+	.red =		{ .offset = 0,  .length = 8 },
+	.green =	{ .offset = 8,  .length = 8 },
+	.blue =		{ .offset = 16, .length = 8 },
+	.transp =	{ .offset = 24, .length = 8 },
+};
+
+static struct fb_info info;
+
+static unsigned int pseudo_palette[256];
+
+static struct impact_par current_par;
+
+/* --------------------- Gory Details --------------------- */
+#define PAR(p)  (*((struct impact_par *)(p)->par))
+#define MMIO(p) (PAR(p).mmio_virt)
+
+static void impact_wait_cfifo(unsigned long mmio, int nslots)
+{
+	while ((IMPACT_FIFOSTATUS(mmio) & MSK_CFIFO_CNT) > (IMPACT_CFIFO_MAX-nslots));
+}
+static void impact_wait_cfifo_empty(unsigned long mmio)
+{
+	while (IMPACT_FIFOSTATUS(mmio) & MSK_CFIFO_CNT);
+}
+static void impact_wait_bfifo(unsigned long mmio, int nslots)
+{
+	while ((IMPACT_GIOSTATUS(mmio) & 0x1f) > (IMPACT_BFIFO_MAX-nslots));
+}
+static void impact_wait_bfifo_empty(unsigned long mmio)
+{
+	while (IMPACT_GIOSTATUS(mmio) & 0x1f);
+}
+static void impact_wait_dma(unsigned long mmio)
+{
+	while (IMPACT_DMABUSY(mmio) & 0x1f);
+	while (!(IMPACT_STATUS(mmio) & 1));
+	while (!(IMPACT_STATUS(mmio) & 2));
+	while (!(IMPACT_RESTATUS(mmio) & 0x100));
+}
+static void impact_wait_dmaready(unsigned long mmio)
+{
+	IMPACT_CFIFOW(mmio) = 0x000e0100;
+	while (IMPACT_DMABUSY(mmio) & 0x1eff);
+	while (!(IMPACT_STATUS(mmio) & 2));
+}
+#define impact_wait_rss_idle impact_wait_dmaready
+
+static void impact_inithq(unsigned long mmio)
+{
+	/* Not really needed, the friendly PROM did this already for us... */
+	/* CFIFO parameters */
+	IMPACT_CFIFO_HW(mmio) = VAL_CFIFO_HW;
+	IMPACT_CFIFO_LW(mmio) = VAL_CFIFO_LW;
+	IMPACT_CFIFO_DELAY(mmio) = VAL_CFIFO_DELAY;
+	/* DFIFO parameters */
+	IMPACT_DFIFO_HW(mmio) = VAL_DFIFO_HW;
+	IMPACT_DFIFO_LW(mmio) = VAL_DFIFO_LW;
+	IMPACT_DFIFO_DELAY(mmio) = VAL_DFIFO_DELAY;
+}
+
+static void impact_initrss(unsigned long mmio)
+{
+	volatile typeof(IMPACT_CFIFO(0)) *cfifo = &IMPACT_CFIFO(mmio);
+	/* transfer mask registers */
+	*cfifo = IMPACT_CMD_COLORMASKLSBSA(0xffffff);
+	*cfifo = IMPACT_CMD_COLORMASKLSBSB(0xffffff);
+	*cfifo = IMPACT_CMD_COLORMASKMSBS(0);
+	*cfifo = IMPACT_CMD_XFRMASKLO(0xffffff);
+	*cfifo = IMPACT_CMD_XFRMASKHI(0xffffff);
+	/* use the main plane */
+	*cfifo = IMPACT_CMD_DRBPOINTERS(0xc8240);
+	/* set the RE into vertical flip mode */
+	*cfifo = IMPACT_CMD_CONFIG(0xcac);
+	*cfifo = IMPACT_CMD_XYWIN(0, 0x3ff);
+}
+
+static void impact_initxmap(unsigned long mmio)
+{
+	/* set XMAP into 24-bpp mode */
+	IMPACT_XMAP_PP1SELECT(mmio) = 0x01;
+	IMPACT_XMAP_INDEX(mmio) = 0x00;
+	IMPACT_XMAP_MAIN_MODE(mmio) = 0x07a4;
+}
+
+static void impact_initvc3(unsigned long mmio)
+{
+	/* cursor-b-gone (disable DISPLAY bit) */
+	IMPACT_VC3_INDEXDATA(mmio) = 0x1d000100;
+}
+
+static void impact_detachtxtbl(unsigned long mmio, unsigned long pool)
+{
+	volatile typeof(IMPACT_CFIFOP(0)) *cfifop = &IMPACT_CFIFOP(mmio);
+	/* clear DMA pool */
+	impact_wait_cfifo_empty(mmio);
+	impact_wait_dma(mmio);
+	IMPACT_CFIFOPW1(mmio) = IMPACT_CMD_HQ_TXBASE(pool);
+	*cfifop = 9;
+	*cfifop = IMPACT_CMD_HQ_TXMAX(pool, 0);
+	*cfifop = IMPACT_CMD_HQ_PGBITS(pool, 0);
+	if (isSR)
+		*cfifop = IMPACT_CMD_HQ_484B(pool, 0x00080000);
+	impact_wait_cfifo_empty(mmio);
+	impact_wait_dmaready(mmio);
+}
+
+static void impact_initdma(struct fb_info *p)
+{
+	volatile typeof(IMPACT_CFIFOPW(0)) *cfifopw = &IMPACT_CFIFOPW(MMIO(p));
+	volatile typeof(IMPACT_CFIFOP(0)) *cfifop = &IMPACT_CFIFOP(MMIO(p));
+	int pool;
+	/* clear DMA pools */
+	for (pool = 0; pool < POOLS; pool++) {
+		impact_detachtxtbl(MMIO(p), pool);
+		PAR(p).pools[pool].txmax = 0;
+		PAR(p).pools[pool].txnum = 0;
+	}
+	/* set DMA parameters */
+	impact_wait_cfifo_empty(MMIO(p));
+	*cfifop = IMPACT_CMD_HQ_PGSIZE(0);
+	*cfifop = IMPACT_CMD_HQ_STACKPTR(0);
+	if (isSR)
+		*cfifop = IMPACT_CMD_HQ_484A(0, 0x00180000);
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	if (isSR) {
+		IMPACT_REG32(MMIO(p), 0x40918) = 0x00680000;
+		IMPACT_REG32(MMIO(p), 0x40920) = 0x80280000;
+		IMPACT_REG32(MMIO(p), 0x40928) = 0x00000000;
+	}
+}
+
+static void impact_alloctxtbl(struct fb_info *p, int pool, int pages)
+{
+	/* realloc array of pool's page-indices to be passed to the card. */
+	dma_addr_t dma_handle;
+	int alloc_count;
+	if (pages > PAR(p).pools[pool].txmax) { /* grow the pool - unlikely but supported */
+		alloc_count = pages;
+		if (alloc_count < 1024)
+			alloc_count = 1024;
+		if (PAR(p).pools[pool].txmax)
+			dma_free_noncoherent(NULL, PAR(p).pools[pool].txmax*4,
+				PAR(p).pools[pool].txtbl, PAR(p).pools[pool].txphys);
+		PAR(p).pools[pool].txtbl =
+			dma_alloc_noncoherent(NULL, alloc_count*4, &dma_handle, GFP_KERNEL);
+		PAR(p).pools[pool].txphys = dma_handle;
+		PAR(p).pools[pool].txmax = alloc_count;
+	}
+	PAR(p).pools[pool].txnum = pages;
+}
+
+static void impact_writetxtbl(struct fb_info *p, int pool)
+{
+	volatile typeof(IMPACT_CFIFOPW(0)) *cfifopw = &IMPACT_CFIFOPW(MMIO(p));
+	volatile typeof(IMPACT_CFIFOP(0)) *cfifop = &IMPACT_CFIFOP(MMIO(p));
+	impact_wait_cfifo_empty(MMIO(p));
+	impact_wait_dma(MMIO(p));
+	/* inform the card about a new DMA pool */
+	IMPACT_CFIFOPW1(MMIO(p)) = IMPACT_CMD_HQ_TXBASE(pool);
+	*cfifop = PAR(p).pools[pool].txphys;
+	*cfifop = IMPACT_CMD_HQ_TXMAX(pool, PAR(p).pools[pool].txnum);
+	*cfifop = IMPACT_CMD_HQ_PGBITS(pool, 0x0a);
+	if (isSR)
+		*cfifop = IMPACT_CMD_HQ_484B(pool, 0x00180000);
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	*cfifopw = 0x000e0100;
+	impact_wait_cfifo_empty(MMIO(p));
+	impact_wait_dmaready(MMIO(p));
+}
+
+static void
+impact_settxtbl(struct fb_info *p, int pool, unsigned *txtbl, int txmax)
+{
+	impact_alloctxtbl(p, pool, txmax);
+	memcpy(PAR(p).pools[pool].txtbl, txtbl, txmax*4);
+	dma_cache_wback_inv((unsigned long)PAR(p).pools[pool].txtbl, txmax*4);
+	impact_writetxtbl(p, pool);
+}
+
+/*
+ * Screw the vaddress, or this damned virt_to_page() will blow up the
+ * driver for DMA_NONCOHERENT (i.e. on any Indigo2).
+ * (For 64Bit, though not for 32Bit, __pa() now does the right thing,
+ * and with a bit of luck there will be no regression...)
+ */
+static inline struct page *dma_virt_to_page(void *virt)
+{
+	return virt_to_page(phys_to_virt(__pa(virt)));
+}
+
+static void
+impact_resizekpool(struct fb_info *p, int pool, int size, int growonly)
+{
+	int pages;
+	int i;
+	dma_addr_t dma_handle;
+	if (growonly && PAR(p).pools[pool].size >= size)
+		return;
+	if (size < 8192)	/* single line smallcopy (1280*4) *must* work */
+		size = 8192;
+	pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	/* before manipulating the tbl, make it unknown to the card! */
+	impact_detachtxtbl(MMIO(p), pool);
+	if (PAR(p).pools[pool].size > 0) {
+		for (i = 0; i < PAR(p).pools[pool].txnum; i++) {
+			ClearPageReserved(dma_virt_to_page(PAR(p).pools[pool].virt[i]));
+			dma_free_coherent(NULL, PAGE_SIZE, PAR(p).pools[pool].virt[i],
+					PAR(p).pools[pool].phys[i]);
+		}
+		vfree(PAR(p).pools[pool].phys);
+		vfree(PAR(p).pools[pool].virt);
+	}
+	impact_alloctxtbl(p, pool, pages);
+	PAR(p).pools[pool].virt = vmalloc(pages*sizeof(unsigned long));
+	PAR(p).pools[pool].phys = vmalloc(pages*sizeof(unsigned long));
+	for (i = 0; i < PAR(p).pools[pool].txnum; i++) {
+		PAR(p).pools[pool].virt[i] =
+			dma_alloc_coherent(NULL, PAGE_SIZE, &dma_handle, GFP_KERNEL);
+		SetPageReserved(dma_virt_to_page(PAR(p).pools[pool].virt[i]));
+		PAR(p).pools[pool].phys[i] = dma_handle;
+		PAR(p).pools[pool].txtbl[i] = dma_handle >> PAGE_SHIFT;
+	}
+	i = sizeof(*PAR(p).pools[pool].txtbl) * PAR(p).pools[pool].txnum;
+	dma_cache_wback_inv((unsigned long)PAR(p).pools[pool].txtbl, i);
+	impact_writetxtbl(p, pool); /* finally attach the tbl to the card. */
+	PAR(p).pools[pool].size = pages * PAGE_SIZE;
+}
+
+static void
+impact_rect(unsigned long mmio, int x, int y, int w, int h, unsigned c, int lo)
+{
+	volatile typeof(IMPACT_CFIFO(0)) *cfifo = &IMPACT_CFIFO(mmio);
+	unsigned mode = lo != IMPACT_LO_COPY ? 0x6304:0x6300;
+	impact_wait_cfifo_empty(mmio);
+	impact_wait_rss_idle(mmio);
+	*cfifo = IMPACT_CMD_PP1FILLMODE(mode, lo);
+	*cfifo = IMPACT_CMD_FILLMODE(0);
+	*cfifo = IMPACT_CMD_PACKEDCOLOR(c);
+	*cfifo = IMPACT_CMD_BLOCKXYSTARTI(x, y);
+	*cfifo = IMPACT_CMD_BLOCKXYENDI(x+w-1, y+h-1);
+	*cfifo = IMPACT_CMD_IR_ALIAS(0x18);
+}
+
+static void
+impact_framerect(unsigned long mmio, int x, int y, int w, int h,
+	int bx, int by, unsigned c)
+{
+	impact_rect(mmio, x, y, w, by, c, IMPACT_LO_COPY);
+	impact_rect(mmio, x, y+h-by, w, by, c, IMPACT_LO_COPY);
+	impact_rect(mmio, x, y, bx, h, c, IMPACT_LO_COPY);
+	impact_rect(mmio, x+w-bx, y, bx, h, c, IMPACT_LO_COPY);
+}
+
+static unsigned long dcntr;
+static void impact_debug(struct fb_info *p, int v)
+{
+	int i;
+	IMPACT_CFIFO(MMIO(p)) = IMPACT_CMD_PIXCMD(3);
+	IMPACT_CFIFO(MMIO(p)) = IMPACT_CMD_HQ_PIXELFORMAT(0xe00);
+	switch(v) {
+	case 0:
+		for (i = 0; i < 64; i++)
+			impact_rect(MMIO(p), 4*(i&7), 28-4*(i>>3), 4, 4,
+				dcntr & (1L<<i) ? 0xa080ff:0x100030, IMPACT_LO_COPY);
+		break;
+	case 1:
+		dcntr++;
+		for (i = 0; i < 64; i++)
+			impact_rect(MMIO(p), 4*(i&7), 28-4*(i>>3), 4, 4,
+				dcntr & (1L<<i) ? 0xff80a0:0x300010, IMPACT_LO_COPY);
+		break;
+	case 2:
+		for (i = 0; i < 64; i++)
+			impact_rect(MMIO(p), 4*(i&7), 28-4*(i>>3), 4, 4,
+				dcntr & (1L<<i) ? 0xa0ff80:0x103000, IMPACT_LO_COPY);
+	}
+}
+
+static void impact_smallcopy(struct fb_info *p, unsigned sx, unsigned sy,
+				unsigned dx, unsigned dy, unsigned w, unsigned h)
+{
+	volatile typeof(IMPACT_CFIFO(0)) *cfifo = &IMPACT_CFIFO(MMIO(p));
+	if (w < 1 || h < 1)
+		return;
+	w = (w+1) & ~1;
+	impact_wait_cfifo_empty(MMIO(p));
+	/* setup and perform DMA from RE to HOST */
+	impact_wait_dma(MMIO(p));
+	if (PAR(p).num_rss == 2 && (sy & 1))
+		*cfifo = IMPACT_CMD_CONFIG(0xca5);
+	else /* Beware, only I2 MaxImpact has 2 REs, SI, HI will hang ! */
+		*cfifo = IMPACT_CMD_CONFIG(0xca4);
+	*cfifo = IMPACT_CMD_PIXCMD(2);
+	*cfifo = IMPACT_CMD_PP1FILLMODE(0x2200, IMPACT_LO_COPY);
+	*cfifo = IMPACT_CMD_COLORMASKLSBSA(0xffffff);
+	*cfifo = IMPACT_CMD_COLORMASKLSBSB(0xffffff);
+	*cfifo = IMPACT_CMD_COLORMASKMSBS(0);
+	*cfifo = IMPACT_CMD_DRBPOINTERS(0xc8240);
+	*cfifo = IMPACT_CMD_BLOCKXYSTARTI(sx, sy+h-1);
+	*cfifo = IMPACT_CMD_BLOCKXYENDI(sx+w-1, sy);
+	*cfifo = IMPACT_CMD_XFRMASKLO(0xffffff);
+	*cfifo = IMPACT_CMD_XFRMASKHI(0xffffff);
+	*cfifo = IMPACT_CMD_XFRSIZE(w, h);
+	*cfifo = IMPACT_CMD_XFRCOUNTERS(w, h);
+	*cfifo = IMPACT_CMD_XFRMODE(0x00080);
+	*cfifo = IMPACT_CMD_FILLMODE(0x01000000);
+	*cfifo = IMPACT_CMD_HQ_PIXELFORMAT(0x200);
+	*cfifo = IMPACT_CMD_HQ_SCANWIDTH(w << 2);
+	*cfifo = IMPACT_CMD_HQ_DMATYPE(0x0a);
+	*cfifo = IMPACT_CMD_HQ_PG_LIST_0(0x80000000);
+	*cfifo = IMPACT_CMD_HQ_PG_WIDTH(w << 2);
+	*cfifo = IMPACT_CMD_HQ_PG_OFFSET(0);
+	*cfifo = IMPACT_CMD_HQ_PG_STARTADDR(0);
+	*cfifo = IMPACT_CMD_HQ_PG_LINECNT(h);
+	*cfifo = IMPACT_CMD_HQ_PG_WIDTHA(w << 2);
+	*cfifo = IMPACT_CMD_XFRCONTROL(8);
+	*cfifo = IMPACT_CMD_GLINE_XSTARTF(1);
+	*cfifo = IMPACT_CMD_IR_ALIAS(0x18);
+	*cfifo = IMPACT_CMD_HQ_DMACTRL_0(8);
+	*cfifo = IMPACT_CMD_XFRCONTROL(9);
+	impact_wait_dmaready(MMIO(p));
+	*cfifo = IMPACT_CMD_GLINE_XSTARTF(0);
+	*cfifo = IMPACT_CMD_RE_TOGGLECNTX(0);
+	*cfifo = IMPACT_CMD_XFRCOUNTERS(0, 0);
+	/* setup and perform DMA from HOST to RE */
+	impact_wait_dma(MMIO(p));
+	*cfifo = IMPACT_CMD_CONFIG(0xca4);
+	*cfifo = IMPACT_CMD_PP1FILLMODE(0x6200, IMPACT_LO_COPY);
+	*cfifo = IMPACT_CMD_BLOCKXYSTARTI(dx, dy+h-1);
+	*cfifo = IMPACT_CMD_BLOCKXYENDI(dx+w-1, dy);
+	*cfifo = IMPACT_CMD_FILLMODE(0x01400000);
+	*cfifo = IMPACT_CMD_XFRMODE(0x00080);
+	*cfifo = IMPACT_CMD_HQ_PIXELFORMAT(0x600);
+	*cfifo = IMPACT_CMD_HQ_SCANWIDTH(w << 2);
+	*cfifo = IMPACT_CMD_HQ_DMATYPE(0x0c);
+	*cfifo = IMPACT_CMD_PIXCMD(3);
+	*cfifo = IMPACT_CMD_XFRSIZE(w, h);
+	*cfifo = IMPACT_CMD_XFRCOUNTERS(w, h);
+	*cfifo = IMPACT_CMD_GLINE_XSTARTF(1);
+	*cfifo = IMPACT_CMD_IR_ALIAS(0x18);
+	*cfifo = IMPACT_CMD_XFRCONTROL(1);
+	*cfifo = IMPACT_CMD_HQ_PG_LIST_0(0x80000000);
+	*cfifo = IMPACT_CMD_HQ_PG_OFFSET(0);
+	*cfifo = IMPACT_CMD_HQ_PG_STARTADDR(0);
+	*cfifo = IMPACT_CMD_HQ_PG_LINECNT(h);
+	*cfifo = IMPACT_CMD_HQ_PG_WIDTHA(w << 2);
+	*cfifo = IMPACT_CMD_HQ_DMACTRL_0(0);
+	IMPACT_CFIFOW1(MMIO(p)) = 0x000e0400;
+	impact_wait_dma(MMIO(p));
+	*cfifo = IMPACT_CMD_GLINE_XSTARTF(0);
+	*cfifo = IMPACT_CMD_RE_TOGGLECNTX(0);
+	*cfifo = IMPACT_CMD_XFRCOUNTERS(0, 0);
+}
+
+static unsigned impact_getpalreg(struct fb_info *p, unsigned i)
+{
+	return ((unsigned *)p->pseudo_palette)[i];
+}
+
+/* ------------ Accelerated Functions --------------------- */
+
+static void impact_fillrect(struct fb_info *p, const struct fb_fillrect *region)
+{
+	unsigned long flags;
+	unsigned x = region->dx+PAR(p).xoffset;
+	unsigned y = region->dy+PAR(p).yoffset;
+	spin_lock_irqsave(&PAR(p).lock, flags);
+	if (!PAR(p).open_flag)
+		switch(region->rop) {
+		case ROP_XOR:
+			impact_rect(MMIO(p), x, y, region->width, region->height,
+				impact_getpalreg(p, region->color), IMPACT_LO_XOR);
+			break;
+		case ROP_COPY:
+		default:
+			impact_rect(MMIO(p), x, y, region->width, region->height,
+				impact_getpalreg(p, region->color), IMPACT_LO_COPY);
+			break;
+		}
+	spin_unlock_irqrestore(&PAR(p).lock, flags);
+}
+
+static void impact_copyarea(struct fb_info *p, const struct fb_copyarea *area)
+{
+	volatile typeof(IMPACT_CFIFO(0)) *cfifo = &IMPACT_CFIFO(MMIO(p));
+	unsigned sx, sy, dx, dy, w, h;
+	unsigned th, ah;
+	unsigned long flags;
+	w = area->width;
+	h = area->height;
+	if (w < 1 || h < 1)
+		return;
+	spin_lock_irqsave(&PAR(p).lock, flags);
+	if (PAR(p).open_flag) {
+		spin_unlock_irqrestore(&PAR(p).lock, flags);
+		return;
+	}
+	sx = area->sx + PAR(p).xoffset;
+	sy = 0x3ff - (area->sy + h - 1 + PAR(p).yoffset);
+	dx = area->dx + PAR(p).xoffset;
+	dy = 0x3ff - (area->dy + h - 1 + PAR(p).yoffset);
+	th = PAR(p).pools[0].size / (w*4);
+	*cfifo = IMPACT_CMD_XYWIN(0, 0);
+	if (dy > sy) {
+		dy += h;
+		sy += h;
+		while (h > 0) {
+			ah = th > h ? h:th;
+			impact_smallcopy(p, sx, sy-ah, dx, dy-ah, w, ah);
+			dy -= ah;
+			sy -= ah;
+			h -= ah;
+		}
+	} else {
+		while (h > 0) {
+			ah = th > h ? h:th;
+			impact_smallcopy(p, sx, sy, dx, dy, w, ah);
+			dy += ah;
+			sy += ah;
+			h -= ah;
+		}
+	}
+	*cfifo = IMPACT_CMD_PIXCMD(0);
+	*cfifo = IMPACT_CMD_HQ_PIXELFORMAT(0xe00);
+	*cfifo = IMPACT_CMD_CONFIG(0xcac);
+	*cfifo = IMPACT_CMD_XYWIN(0, 0x3ff);
+	spin_unlock_irqrestore(&PAR(p).lock, flags);
+}
+
+/* 8-bpp blits are done as PIO draw operation; the pixels are unpacked into
+   32-bpp values from the current palette in software */
+static void
+impact_imageblit_8bpp(struct fb_info *p, const struct fb_image *image)
+{
+	volatile typeof(IMPACT_CFIFO(0)) *cfifo = &IMPACT_CFIFO(MMIO(p));
+	int i, u, v;
+	const unsigned char *dp;
+	unsigned pix;
+	unsigned pal[256];
+	unsigned x = image->dx + PAR(p).xoffset;
+	unsigned y = image->dy + PAR(p).yoffset;
+	/* setup PIO to RE */
+	impact_wait_cfifo_empty(MMIO(p));
+	impact_wait_rss_idle(MMIO(p));
+	*cfifo = IMPACT_CMD_PP1FILLMODE(0x6300, IMPACT_LO_COPY);
+	*cfifo = IMPACT_CMD_BLOCKXYSTARTI(x, y);
+	*cfifo = IMPACT_CMD_BLOCKXYENDI(x+image->width-1, y+image->height-1);
+	*cfifo = IMPACT_CMD_FILLMODE(0x00c00000);
+	*cfifo = IMPACT_CMD_XFRMODE(0x00080);
+	*cfifo = IMPACT_CMD_XFRSIZE(image->width, image->height);
+	*cfifo = IMPACT_CMD_XFRCOUNTERS(image->width, image->height);
+	*cfifo = IMPACT_CMD_GLINE_XSTARTF(1);
+	*cfifo = IMPACT_CMD_IR_ALIAS(0x18);
+	/* another workaround.. 33 writes to alpha... hmm... */
+	for (i = 0; i < 33; i++)
+		*cfifo = IMPACT_CMD_ALPHA(0);
+	*cfifo = IMPACT_CMD_XFRCONTROL(2);
+	/* pairs of pixels are sent in two writes to the RE */
+	i = 0;
+	dp = image->data;
+	for (v = 0; v < 256; v++)
+		pal[v] = impact_getpalreg(p, v);
+	for (v = 0; v < image->height; v++) {
+		for (u = 0; u < image->width; u++) {
+			pix = pal[*(dp++)];
+			if (i)
+				*cfifo = IMPACT_CMD_CHAR_L(pix);
+			else
+				*cfifo = IMPACT_CMD_CHAR_H(pix);
+			i ^= 1;
+		}
+	}
+	if (i)
+		*cfifo = IMPACT_CMD_CHAR_L(0);
+	*cfifo = IMPACT_CMD_GLINE_XSTARTF(0);
+	*cfifo = IMPACT_CMD_RE_TOGGLECNTX(0);
+	*cfifo = IMPACT_CMD_XFRCOUNTERS(0, 0);
+}
+
+/* 1-bpp blits are done as character drawing; the bitmaps are drawn as 8-bit wide
+   strips; technically, Impact supports 16-pixel wide characters, but Linux bitmap
+   alignment is 8 bits and most draws are 8 pixels wide (font width), anyway */
+static void
+impact_imageblit_1bpp(struct fb_info *p, const struct fb_image *image)
+{
+	volatile typeof(IMPACT_CFIFO(0)) *cfifo = &IMPACT_CFIFO(MMIO(p));
+	int x, y, w, h, b;
+	int u, v, a;
+	const unsigned char *d;
+	impact_wait_cfifo_empty(MMIO(p));
+	impact_wait_rss_idle(MMIO(p));
+	*cfifo = IMPACT_CMD_PP1FILLMODE(0x6300, IMPACT_LO_COPY);
+	*cfifo = IMPACT_CMD_FILLMODE(0x400018);
+	a = impact_getpalreg(p, image->fg_color);
+	*cfifo = IMPACT_CMD_PACKEDCOLOR(a);
+	a = impact_getpalreg(p, image->bg_color);
+	/* Hmm, only the lower 4 bits are taken from red and blue. */
+	if (!isSR) a = (a>>4) & 0x0f000f | a & 0x00ff00;
+	*cfifo = IMPACT_CMD_BKGRD_RG(a & 0xffff);
+	*cfifo = IMPACT_CMD_BKGRD_BA((a & 0xff0000) >> 16);
+	x = image->dx + PAR(p).xoffset;
+	y = image->dy + PAR(p).yoffset;
+	w = image->width;
+	h = image->height;
+	b = (w+7) / 8;
+	for (u = 0; u < b; u++) {
+		impact_wait_cfifo_empty(MMIO(p));
+		a = (w<8) ? w:8;
+		d = image->data+u;
+		*cfifo = IMPACT_CMD_BLOCKXYSTARTI(x, y);
+		*cfifo = IMPACT_CMD_BLOCKXYENDI(x+a-1, y+h-1);
+		*cfifo = IMPACT_CMD_IR_ALIAS(0x18);
+		for (v = 0; v < h; v++) {
+			*cfifo = IMPACT_CMD_CHAR(*d << 24);
+			d += b;
+		}
+		w -= a;
+		x += a;
+	}
+}
+
+static void impact_imageblit(struct fb_info *p, const struct fb_image *image)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR(p).lock, flags);
+	if (!PAR(p).open_flag)
+		switch(image->depth) {
+		case 1:
+			impact_imageblit_1bpp(p, image);
+			break;
+		case 8:
+			impact_imageblit_8bpp(p, image);
+			break;
+		}
+	spin_unlock_irqrestore(&PAR(p).lock, flags);
+}
+
+static int impact_sync(struct fb_info *info)
+{
+	return 0;
+}
+
+static int impact_blank(int blank_mode, struct fb_info *info)
+{
+	/* TODO */
+	return 0;
+}
+
+static int impact_setcolreg(unsigned regno, unsigned red, unsigned green,
+			unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if (regno > 255)
+		return 1;
+	((unsigned *)info->pseudo_palette)[regno] =
+		(red >> 8) | (green & 0xff00) | ((blue << 8) & 0xff0000);
+	return 0;
+}
+
+/* ------------------- Framebuffer Access -------------------- */
+
+static ssize_t
+impact_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static ssize_t
+impact_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+/* --------------------- Userland Access --------------------- */
+
+static int
+impact_cacheflush(struct fb_info *p, int pool, const struct impact_cf_args *arg)
+{
+	unsigned short w = arg->box.ws_xpixel << 2;
+	unsigned short h = arg->box.ws_ypixel;
+
+	if (w && h)
+	{	unsigned long a = arg->bpitch*arg->box.ws_row + (arg->box.ws_col << 2);
+		unsigned long b = arg->base + PAR(p).pools[pool].size - w;
+
+		for (a += arg->base; h; h--, a += arg->bpitch)
+		{	if (!access_ok(VERIFY_WRITE, (void __user*)a, w))
+				return -EFAULT;
+			if (b <= a)
+				return -EINVAL;
+			(*_dma_cache_wback_inv)(a, w);
+		}
+	}
+	return 0;
+}
+
+static int
+impact_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
+{
+	if (!isSR && IPNR != 22 && TCFLSH == cmd) {
+		static struct impact_cf_args cfpar;
+		int i;
+
+		if ( copy_from_user(&cfpar,(void __user*)arg,sizeof(cfpar)) )
+			return -EFAULT;
+
+		if (!cfpar.base)
+			return -EINVAL;
+
+		for (i = 0; i < POOLS; i++)
+			if (cfpar.base == PAR(info).pools[i].uaddr) {
+				int r = impact_cacheflush(info, i, &cfpar);
+				/* Might be munmapped behind our back. */
+				if (-EFAULT == r) {
+					printk(KERN_INFO "impact_ioctl: shut down user"
+						" cache-flush for DMA-pool %d (%p)\n",
+						i, cfpar.base);
+					PAR(info).pools[i].uaddr = 0;
+				}
+				return r;
+			}
+	}
+	return -EINVAL;
+}
+
+static int impact_mmap(struct fb_info *p, struct vm_area_struct *vma)
+{
+	unsigned pool, i, n;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long start;
+
+	switch(offset) {
+	case 0x0000000: /* map Impact-registers */
+		if (size > (isSR ? 0x200000:0x400000))
+			return -EINVAL;
+		if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+			return -EINVAL;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		vma->vm_flags |= VM_IO;
+		if (remap_pfn_range(vma, vma->vm_start, (MMIO(p)+offset)>>PAGE_SHIFT,
+				size, vma->vm_page_prot))
+			return -EAGAIN;
+		PAR(p).mmap_flag = 1;
+		break;
+	case 0x1000000: /* map e.g. shadow-frame-buffer */
+	case 0x2000000:
+	case 0x3000000:
+	case 0x8000000:
+	case 0x9000000:
+	case 0xa000000:
+	case 0xb000000:
+		if (size > (isSR ? 0x1000000:0xc00000))
+			return -EINVAL;
+		pool = (offset >> 24) & 3; /* growonly = (offset>>24) & 8 */
+		n = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		if (n*PAGE_SIZE != PAR(p).pools[pool].size)
+			impact_resizekpool(p, pool, size, offset & 0x8000000);
+		if (22 == IPNR) /* IP22 memory may be written uncached */
+			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		for (start = vma->vm_start, i = 0; i < n; i++) {
+			if (remap_pfn_range(vma, start,
+					PAR(p).pools[pool].phys[i] >> PAGE_SHIFT,
+					PAGE_SIZE, vma->vm_page_prot)) {
+				PAR(p).pools[pool].uaddr = 0;
+				return -EAGAIN;
+			}
+			start += PAGE_SIZE;
+		}
+		PAR(p).pools[pool].uaddr = vma->vm_start;
+		PAR(p).mmap_flag = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int impact_open(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR(p).lock, flags);
+	if (user)
+		PAR(p).open_flag++;
+	spin_unlock_irqrestore(&PAR(p).lock, flags);
+	return 0;
+}
+
+static int impact_release(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR(p).lock, flags);
+	if (user && PAR(p).open_flag)
+		PAR(p).open_flag--;
+	spin_unlock_irqrestore(&PAR(p).lock, flags);
+	return 0;
+}
+
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Frame buffer operations
+     */
+
+static struct fb_ops impact_ops = {
+	.owner		= THIS_MODULE,
+	.fb_read	= impact_read,
+	.fb_write	= impact_write,
+	.fb_blank	= impact_blank,
+	.fb_fillrect	= impact_fillrect,
+	.fb_copyarea	= impact_copyarea,
+	.fb_imageblit	= impact_imageblit,
+	.fb_sync	= impact_sync,
+	.fb_ioctl	= impact_ioctl,
+	.fb_setcolreg	= impact_setcolreg,
+	.fb_mmap	= impact_mmap,
+	.fb_open	= impact_open,
+	.fb_release	= impact_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Private early console
+     */
+
+#define MMIO_FIXED	(isSR ? 0x900000001c000000LL:0x900000001f000000LL)
+
+static inline void impact_earlyrect(int x, int y, int w, int h, unsigned c)
+{
+	impact_rect(MMIO_FIXED, x, y, w, h, c, IMPACT_LO_COPY);
+}
+
+static void
+impact_paintchar(int x, int y, unsigned char *b, unsigned c, unsigned a)
+{
+	volatile typeof(IMPACT_CFIFO(0)) *cfifo = &IMPACT_CFIFO(MMIO_FIXED);
+	int v;
+	/* Hmm, only the lower 4 bits are taken from red and blue. */
+	if (!isSR) a = (a>>4) & 0x0f000f | a & 0x00ff00;
+	impact_wait_cfifo_empty(MMIO_FIXED);
+	*cfifo = IMPACT_CMD_PP1FILLMODE(0x6300, IMPACT_LO_COPY);
+	*cfifo = IMPACT_CMD_FILLMODE(0x400018);
+	*cfifo = IMPACT_CMD_PACKEDCOLOR(c);
+	*cfifo = IMPACT_CMD_BKGRD_RG(a & 0xffff);
+	*cfifo = IMPACT_CMD_BKGRD_BA((a & 0xff0000) >> 16);
+	*cfifo = IMPACT_CMD_BLOCKXYSTARTI(x, y);
+	*cfifo = IMPACT_CMD_BLOCKXYENDI(x+7, y+15);
+	*cfifo = IMPACT_CMD_IR_ALIAS(0x18);
+	for (v = 0; v < 16; v++)
+		*cfifo = IMPACT_CMD_CHAR(*b++ << 24);
+}
+static void impact_earlyhwinit(void)
+{
+	impact_inithq(MMIO_FIXED);
+	impact_initrss(MMIO_FIXED);
+	impact_initxmap(MMIO_FIXED);
+	impact_initvc3(MMIO_FIXED);
+}
+
+static inline unsigned char *p8x16(unsigned char c)
+{
+	return ((unsigned char(*)[16])font_vga_8x16.data)[c];
+}
+
+static void impact_earlywrite(struct console*, const char*, unsigned);
+enum {
+	LightBlue = (230<<16)|(216<<8)|173,
+	DarkViolet2 = (105<<16)|74, LightGoldenrod = (130<<16)|(221<<8)|238,
+};
+#define EARLYBG 0x3f3f3f
+
+static struct {
+	int posx, posy;
+	spinlock_t lock;
+	struct console console;
+}
+early = {
+	.posx = -1,
+	.lock = __SPIN_LOCK_UNLOCKED(early.lock),
+	.console = {
+		.name = "earlyimpact",
+		.write = impact_earlywrite,
+		/*
+		 * Omit CON_BOOT, so 'early' shall persist until fbcon takes over!
+		 * Add CON_CONSDEV to detach a possibly active arc boot-console.
+		 */
+		.flags = CON_CONSDEV | CON_PRINTBUFFER,
+		.index = -1,
+	},
+};
+
+void impact_earlychar(unsigned char c)
+{
+	if (early.posx != -1) {
+		unsigned long flags;
+		spin_lock_irqsave(&early.lock, flags);
+		if (c == '\n') {
+			early.posy += 16;
+			if (early.posy >= 800)
+				early.posy = 0;
+			early.posx = 0;
+			goto out;
+		}
+		if (early.posx == 0) {
+			impact_earlyrect(240, 112+early.posy, 800, 16, EARLYBG);
+			if (early.posy+16*2 < 800)
+				impact_earlyrect(240, 112+16+early.posy, 800, 16, EARLYBG);
+		}
+		impact_paintchar(240+early.posx, 112+early.posy, p8x16(c), 0xffffff, EARLYBG);
+		early.posx += 8;
+		if (early.posx >= 800) {
+			early.posx = 0;
+			early.posy += 16;
+			if (early.posy >= 800)
+				early.posy = 0;
+		}
+out:
+		spin_unlock_irqrestore(&early.lock, flags);
+	}
+}
+void impact_earlystring(char *s)
+{
+	while (*s)
+		impact_earlychar(*s++);
+}
+static void impact_earlywrite(struct console *con, const char *s, unsigned n)
+{
+	while (n-- && *s)
+		impact_earlychar(*s++);
+}
+void __init impact_earlyinit(void)
+{
+	static int up;
+	if (!up) {
+		impact_earlyhwinit();
+		impact_framerect(MMIO_FIXED, 0, 0, 1280, 1024, 240, 112, LightBlue);
+		impact_framerect(MMIO_FIXED, 240-4, 112-4, 800+8, 800+8, 4, 4, LightGoldenrod);
+		impact_earlyrect(240, 112, 800, 800, EARLYBG);
+		early.posx = 0;
+		early.posy = 0;
+		impact_earlystring("ImpactSR early console ready.\n");
+		up++;
+	}
+}
+void __init setup_impact_earlycons(void)
+{
+	static int up;
+	if (!up) {
+		impact_earlyinit();
+		register_console(&early.console);
+		up++;
+	}
+}
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Initialization
+     */
+
+static inline unsigned long gfxphysaddr(void)
+{
+#if isSR
+	/* first card in Octane? */
+	int xwid = ip30_xtalk_find(IMPACT_XTALK_MFGR, IMPACT_XTALK_PART,
+					IP30_XTALK_NUM_WID);
+	return xwid == -1 ? 0:ip30_xtalk_swin(xwid);
+#else
+	extern unsigned long sgi_gfxaddr; 	/* provided by ARCS */
+	return sgi_gfxaddr;
+#endif
+}
+
+static void __init impact_hwinit(struct fb_info *info)
+{
+	early.posx = -1;
+	/* initialize hardware */
+	impact_inithq(MMIO(info));
+	impact_initvc3(MMIO(info));
+	impact_initrss(MMIO(info));
+	impact_initxmap(MMIO(info));
+	impact_initdma(info);
+}
+
+static int __init impact_devinit(void)
+{
+	int i, x, y;
+	current_par.open_flag = 0;
+	current_par.mmap_flag = 0;
+	current_par.lock = __SPIN_LOCK_UNLOCKED(current_par.lock);
+
+	current_par.mmio_base = gfxphysaddr();
+	if (!current_par.mmio_base) {
+		printk(KERN_INFO "impact_devinit: !gfxaddr\n");
+		return -EINVAL;
+	}
+	current_par.mmio_virt = (unsigned long)
+		ioremap(current_par.mmio_base, 0x200000);
+	impact_fix.mmio_start = current_par.mmio_base;
+	impact_fix.mmio_len = 0x200000;
+
+	/* get board config */
+	current_par.num_ge = IMPACT_BDVERS1(current_par.mmio_virt) & 3;
+	if (!isSR) {
+		/* To do: desirably remove "... = 1; ". BDVERS1 fits on
+		 * Solid-Impact, but couldn't check High-/Max- yet.
+		 */
+		current_par.num_ge = 1;
+		/* Caveat: XImpact depends on the 'S' in id[6] to distinguish
+		 * between ImpactSR and Impact by examining /proc/fb!
+		 */
+		impact_fix.id[6] = '2';
+		impact_fix.id[7] = '0' + IPNR - 20;
+	}
+	current_par.num_rss = current_par.num_ge;
+	impact_fix.id[9] = '0' + current_par.num_rss;
+
+	info.flags = FBINFO_FLAG_DEFAULT;
+	info.screen_base = NULL;
+	info.fbops = &impact_ops;
+	info.fix = impact_fix;
+	info.var = impact_var;
+	info.par = &current_par;
+	info.pseudo_palette = pseudo_palette;
+
+	/* Can't wait any longer to switch off the early stuff */
+	unregister_console(&early.console);
+
+	impact_hwinit(&info);
+	/* initialize buffers */
+	impact_resizekpool(&info, 0, 65536, 0);
+	for (i = 1; i < USEPOOLS; ++i)
+		impact_resizekpool(&info, i, 8192, 0);
+
+	/* This has to been done !!! */
+	fb_alloc_cmap(&info.cmap, 256, 0);
+
+	if (register_framebuffer(&info) < 0) {
+		fb_dealloc_cmap(&info.cmap);
+		return -EINVAL;
+	}
+	x = (1280 - impact_var.xres) / 2;
+	y = (1024 - impact_var.yres) / 2;
+
+	/* Now we can take care of the nice-to-have stuff :-) */
+	impact_framerect(MMIO(&info), 0, 0, 1280, 1024, x, y, DarkViolet2);
+	impact_framerect(MMIO(&info), x-4, y-4, impact_var.xres+8,
+		impact_var.yres+8, 4, 4, LightGoldenrod);
+
+#if defined(CONFIG_LOGO)
+	if (fb_prepare_logo(&info, 0)) {
+		fb_set_cmap(&info.cmap, &info);
+		fb_show_logo(&info, 0);
+	}
+#endif
+	current_par.xoffset = x;
+	current_par.yoffset = y;
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node, info.fix.id);
+	return 0;
+}
+
+static int __init impact_probe(struct device *dev)
+{
+	return impact_devinit();
+}
+
+static struct platform_driver impact_driver = {
+	.driver = {
+		.name = (isSR ? "impactsr":"impact"),
+		.bus = &platform_bus_type,
+		.probe = impact_probe,
+		/* add remove someday */
+	},
+};
+
+static struct platform_device impact_device = {
+	.name = (isSR ? "impactsr":"impact"),
+};
+
+static int __init impact_init(void)
+{
+	int ret = driver_register(&impact_driver.driver);
+	if (!ret) {
+		ret = platform_device_register(&impact_device);
+		if (ret)
+			driver_unregister(&impact_driver.driver);
+	}
+	return ret;
+}
+
+static void __exit impact_exit(void)
+{
+	 driver_unregister(&impact_driver.driver);
+}
+
+module_init(impact_init);
+module_exit(impact_exit);
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>, "\
+	"Indigo2-adaption: pf <post@pfrst.de>");
+MODULE_DESCRIPTION("SGI Octane ImpactSR HQ4, Indigo2 Impact HQ3 Video Driver");
+MODULE_VERSION("R28/R1.7");
+MODULE_LICENSE("GPL");


diff --git a/include/video/impact.h b/include/video/impact.h
new file mode 100644
index 0000000..e4b013c
--- /dev/null	Wed Dec  8 00:46:04 2004
+++ b/include/video/impact.h	Mon Jul 25 00:06:58 2011
@@ -0,0 +1,210 @@
+/*
+ *  linux/drivers/video/impactsr.h -- SGI Octane MardiGras (IMPACTSR) graphics
+ *  linux/include/video/impact.h   -- SGI Indigo2 MardiGras (IMPACT) graphics
+ *
+ *  Copyright (c) 2004-2006 by Stanislaw Skowronek	(skylark@linux-mips.org)
+ *  Adapted to Indigo2 by pf, 2005,2006,2009	(post@pfrst.de)
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef IMPACT_H
+#define IMPACT_H
+
+/* Convenient access macros */
+#define IMPACT_REG64(vma,off)	(*(volatile unsigned long long *)((vma)+(off)))
+#define IMPACT_REG32(vma,off)	(*(volatile unsigned int *)((vma)+(off)))
+#define IMPACT_REG16(vma,off)	(*(volatile unsigned short *)((vma)+(off)))
+#define IMPACT_REG8(vma,off)	(*(volatile unsigned char *)((vma)+(off)))
+
+#if defined(CONFIG_SGI_IP30)	/* Octane: Impact for "SpeedRacer"	*/
+
+/* Xtalk */
+#define IMPACTSR_XTALK_MFGR		0x2aa
+#define IMPACTSR_XTALK_PART		0xc003
+
+/* ImpactSR (HQ4) register offsets */
+#define IMPACT_CFIFO(vma)		IMPACT_REG64(vma,0x20400)
+#define IMPACT_CFIFOW(vma)		IMPACT_REG32(vma,0x20400)
+#define IMPACT_CFIFOW1			IMPACT_CFIFOW /* ? ? ? */
+#define IMPACT_CFIFOP(vma)		IMPACT_REG64(vma,0x130400)
+#define IMPACT_CFIFOPW(vma)		IMPACT_REG32(vma,0x130400)
+#define IMPACT_CFIFOPW1			IMPACT_CFIFOPW /* ? ? ? */
+
+#define IMPACT_STATUS(vma)		IMPACT_REG32(vma,0x20000)
+#define IMPACT_FIFOSTATUS(vma)	IMPACT_REG32(vma,0x20008)
+#define IMPACT_GIOSTATUS(vma)		IMPACT_REG32(vma,0x20100)
+#define IMPACT_DMABUSY(vma)		IMPACT_REG32(vma,0x20200)
+
+#define IMPACT_CFIFO_HW(vma)		IMPACT_REG32(vma,0x40000)
+#define IMPACT_CFIFO_LW(vma)		IMPACT_REG32(vma,0x40008)
+#define IMPACT_CFIFO_DELAY(vma)	IMPACT_REG32(vma,0x40010)
+#define IMPACT_DFIFO_HW(vma)		IMPACT_REG32(vma,0x40020)
+#define IMPACT_DFIFO_LW(vma)		IMPACT_REG32(vma,0x40028)
+#define IMPACT_DFIFO_DELAY(vma)	IMPACT_REG32(vma,0x40030)
+
+#define IMPACT_XMAP_OFF(off)	(0x71c00+(off))
+#define IMPACT_VC3_OFF(off)	(0x72000+(off))
+#define IMPACT_RSS_OFF(off)	(0x2c000+(off))
+
+#else /* Indigo2: IP28, IP26, IP22: Impact graphics	*/
+
+/* Impact (HQ3) register offsets */
+#define IMPACT_CFIFO(vma)		IMPACT_REG64(vma,0x70080)
+#define IMPACT_CFIFOW(vma)		IMPACT_REG32(vma,0x70080)
+#define IMPACT_CFIFOW1(vma)		IMPACT_REG32(vma,0x70084)
+#define IMPACT_CFIFOP(vma)		IMPACT_REG64(vma,0x50080)
+#define IMPACT_CFIFOPW(vma)		IMPACT_REG32(vma,0x50080)
+#define IMPACT_CFIFOPW1(vma)		IMPACT_REG32(vma,0x50084)
+
+#define IMPACT_STATUS(vma)		IMPACT_REG32(vma,0x70000)
+#define IMPACT_FIFOSTATUS(vma)	IMPACT_REG32(vma,0x70004)
+#define IMPACT_GIOSTATUS(vma)		IMPACT_REG32(vma,0x70100)
+#define IMPACT_DMABUSY(vma)		IMPACT_REG32(vma,0x70104)
+
+#define IMPACT_CFIFO_HW(vma)		IMPACT_REG32(vma,0x50020)
+#define IMPACT_CFIFO_LW(vma)		IMPACT_REG32(vma,0x50024)
+#define IMPACT_CFIFO_DELAY(vma)	IMPACT_REG32(vma,0x50028)
+#define IMPACT_DFIFO_HW(vma)		IMPACT_REG32(vma,0x5002c)
+#define IMPACT_DFIFO_LW(vma)		IMPACT_REG32(vma,0x50030)
+#define IMPACT_DFIFO_DELAY(vma)	IMPACT_REG32(vma,0x50034)
+
+#define IMPACT_XMAP_OFF(off)	(0x61c00+(off))
+#define IMPACT_VC3_OFF(off)	(0x62000+(off))
+#define IMPACT_RSS_OFF(off)	(0x7c000+(off))
+
+#endif
+
+#define IMPACT_RESTATUS(vma)		IMPACT_REG32(vma,IMPACT_RSS_OFF(0x578))
+
+#define IMPACT_XMAP_PP1SELECT(vma)	IMPACT_REG8(vma,IMPACT_XMAP_OFF(0x008))
+#define IMPACT_XMAP_INDEX(vma)	IMPACT_REG8(vma,IMPACT_XMAP_OFF(0x088))
+#define IMPACT_XMAP_CONFIG(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x100))
+#define IMPACT_XMAP_CONFIGB(vma)	IMPACT_REG8(vma,IMPACT_XMAP_OFF(0x108))
+#define IMPACT_XMAP_BUF_SELECT(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x180))
+#define IMPACT_XMAP_MAIN_MODE(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x200))
+#define IMPACT_XMAP_OVERLAY_MODE(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x280))
+#define IMPACT_XMAP_DIB(vma)		IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x300))
+#define IMPACT_XMAP_DIB_DW(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x340))
+#define IMPACT_XMAP_RE_RAC(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x380))
+
+#define IMPACT_VC3_INDEX(vma)		IMPACT_REG8(vma,IMPACT_VC3_OFF(0x008))
+#define IMPACT_VC3_INDEXDATA(vma)	IMPACT_REG32(vma,IMPACT_VC3_OFF(0x038))
+#define IMPACT_VC3_DATA(vma)		IMPACT_REG16(vma,IMPACT_VC3_OFF(0x0b0))
+#define IMPACT_VC3_RAM(vma)		IMPACT_REG16(vma,IMPACT_VC3_OFF(0x190))
+
+#define IMPACT_BDVERS0(vma)		IMPACT_REG8(vma,IMPACT_VC3_OFF(0x408))
+#define IMPACT_BDVERS1(vma)		IMPACT_REG8(vma,IMPACT_VC3_OFF(0x488))
+
+/* FIFO status */
+#if defined(CONFIG_SGI_IP30)
+#define IMPACT_CFIFO_MAX		128
+#else
+#define IMPACT_CFIFO_MAX		64
+#endif
+#define IMPACT_BFIFO_MAX		16
+
+/* Commands for CFIFO */
+static __inline__
+unsigned long long ImpactCmdCFifo64( unsigned cmd, unsigned reg, unsigned val )
+{
+	return (unsigned long long)(cmd | reg<<8) << 32 | val;
+}
+static __inline__
+unsigned long long ImpactCmdWriteRSS( unsigned reg, unsigned val )
+{
+	return (0x00180004LL | reg<<8) << 32 | val;
+}
+static __inline__
+unsigned long long ImpactCmdExecRSS( unsigned reg, unsigned val )
+{
+	return (0x001c0004LL | reg<<8) << 32 | val;
+}
+
+#define IMPACT_CMD_GLINE_XSTARTF(v)	ImpactCmdWriteRSS(0x00c,v)
+#define IMPACT_CMD_IR_ALIAS(v)		ImpactCmdExecRSS(0x045,v)
+#define IMPACT_CMD_BLOCKXYSTARTI(x,y)	ImpactCmdWriteRSS(0x046,((x)<<16)|(y))
+#define IMPACT_CMD_BLOCKXYENDI(x,y)	ImpactCmdWriteRSS(0x047,((x)<<16)|(y))
+#define IMPACT_CMD_PACKEDCOLOR(v)	ImpactCmdWriteRSS(0x05b,v)
+#define IMPACT_CMD_RED(v)		ImpactCmdWriteRSS(0x05c,v)
+#define IMPACT_CMD_ALPHA(v)		ImpactCmdWriteRSS(0x05f,v)
+#define IMPACT_CMD_CHAR(v)		ImpactCmdExecRSS(0x070,v)
+#define IMPACT_CMD_CHAR_H(v)		ImpactCmdWriteRSS(0x070,v)
+#define IMPACT_CMD_CHAR_L(v)		ImpactCmdExecRSS(0x071,v)
+#define IMPACT_CMD_XFRCONTROL(v)	ImpactCmdWriteRSS(0x102,v)
+#define IMPACT_CMD_FILLMODE(v)		ImpactCmdWriteRSS(0x110,v)
+#define IMPACT_CMD_CONFIG(v)		ImpactCmdWriteRSS(0x112,v)
+#define IMPACT_CMD_XYWIN(x,y)		ImpactCmdWriteRSS(0x115,((y)<<16)|(x))
+#define IMPACT_CMD_BKGRD_RG(v)		ImpactCmdWriteRSS(0x140,((v)<<8))
+#define IMPACT_CMD_BKGRD_BA(v)		ImpactCmdWriteRSS(0x141,((v)<<8))
+#define IMPACT_CMD_WINMODE(v)		ImpactCmdWriteRSS(0x14f,v)
+#define IMPACT_CMD_XFRSIZE(x,y)		ImpactCmdWriteRSS(0x153,((y)<<16)|(x))
+#define IMPACT_CMD_XFRMASKLO(v)		ImpactCmdWriteRSS(0x156,v)
+#define IMPACT_CMD_XFRMASKHI(v)		ImpactCmdWriteRSS(0x157,v)
+#define IMPACT_CMD_XFRCOUNTERS(x,y)	ImpactCmdWriteRSS(0x158,((y)<<16)|(x))
+#define IMPACT_CMD_XFRMODE(v)		ImpactCmdWriteRSS(0x159,v)
+#define IMPACT_CMD_RE_TOGGLECNTX(v)	ImpactCmdWriteRSS(0x15f,v)
+#define IMPACT_CMD_PIXCMD(v)		ImpactCmdWriteRSS(0x160,v)
+#define IMPACT_CMD_PP1FILLMODE(m,o)	ImpactCmdWriteRSS(0x161,(m)|(o<<26))
+#define IMPACT_CMD_COLORMASKMSBS(v)	ImpactCmdWriteRSS(0x162,v)
+#define IMPACT_CMD_COLORMASKLSBSA(v)	ImpactCmdWriteRSS(0x163,v)
+#define IMPACT_CMD_COLORMASKLSBSB(v)	ImpactCmdWriteRSS(0x164,v)
+#define IMPACT_CMD_BLENDFACTOR(v)	ImpactCmdWriteRSS(0x165,v)
+#define IMPACT_CMD_DRBPOINTERS(v)	ImpactCmdWriteRSS(0x16d,v)
+
+#define IMPACT_CMD_HQ_PIXELFORMAT(v)	ImpactCmdCFifo64(0x000c0004,0,v)
+#define IMPACT_CMD_HQ_SCANWIDTH(v)	ImpactCmdCFifo64(0x000a0204,0,v)
+#define IMPACT_CMD_HQ_DMATYPE(v)	ImpactCmdCFifo64(0x000a0604,0,v)
+#define IMPACT_CMD_HQ_PG_LIST_0(v)	ImpactCmdCFifo64(0x00080004,0,v)
+#define IMPACT_CMD_HQ_PG_WIDTH(v)	ImpactCmdCFifo64(0x00080404,0,v)
+#define IMPACT_CMD_HQ_PG_OFFSET(v)	ImpactCmdCFifo64(0x00080504,0,v)
+#define IMPACT_CMD_HQ_PG_STARTADDR(v)	ImpactCmdCFifo64(0x00080604,0,v)
+#define IMPACT_CMD_HQ_PG_LINECNT(v)	ImpactCmdCFifo64(0x00080704,0,v)
+#define IMPACT_CMD_HQ_PG_WIDTHA(v)	ImpactCmdCFifo64(0x00080804,0,v)
+#define IMPACT_CMD_HQ_DMACTRL_0(v)	(0x00080b04000000b1LL|(v)&8)
+#define IMPACT_CMD_HQ_TXBASE(p)		(0x00482008|((p)<<9))
+#define IMPACT_CMD_HQ_TXMAX(p,v)	ImpactCmdCFifo64(0x00483004,p,v)
+#define IMPACT_CMD_HQ_PGBITS(p,v)	ImpactCmdCFifo64(0x00482b04,p,v)
+#define IMPACT_CMD_HQ_PGSIZE(v)		ImpactCmdCFifo64(0x00482a04,0,v)
+#define IMPACT_CMD_HQ_STACKPTR(v)	ImpactCmdCFifo64(0x00483a04,0,v)
+#define IMPACT_CMD_HQ_484A(p,v)		ImpactCmdCFifo64(0x00484a04,p,v)
+#define IMPACT_CMD_HQ_484B(p,v)		ImpactCmdCFifo64(0x00484b04,p,v)
+
+/* Logic operations for the PP1 (SI=source invert, DI=dest invert, RI=result invert) */
+#define IMPACT_LO_CLEAR	0
+#define IMPACT_LO_AND		1
+#define IMPACT_LO_DIAND	2
+#define IMPACT_LO_COPY	3
+#define IMPACT_LO_SIAND	4
+#define IMPACT_LO_NOP		5
+#define IMPACT_LO_XOR		6
+#define IMPACT_LO_OR		7
+#define IMPACT_LO_RIOR	8
+#define IMPACT_LO_RIXOR	9
+#define IMPACT_LO_RINOP	10
+#define IMPACT_LO_DIOR	11
+#define IMPACT_LO_RICOPY	12
+#define IMPACT_LO_SIOR	13
+#define IMPACT_LO_RIAND	14
+#define IMPACT_LO_SET		15
+
+/* Blending factors */
+#define IMPACT_BLEND_ALPHA	0x0704c900
+
+#ifdef  __KERNEL__
+extern void impact_earlychar(unsigned char c);
+extern void impact_earlystring(char *s);
+extern void impact_earlyinit(void);
+extern void setup_impact_earlycons(void);
+#endif
+
+struct impact_cf_args
+{
+	struct winsize box;	/* termios.h */
+	unsigned long long base;
+	unsigned bpitch;
+};
+
+#endif /* IMPACT_H */
