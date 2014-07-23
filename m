Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:46:38 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:50988 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842561AbaGWOheQzi5e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:34 +0200
Received: by mail-wg0-f43.google.com with SMTP id l18so1263751wgh.14
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PdbbXP+vnBVSJyLzUdqqkjJTq2qSArCz6U3PE3qR+DQ=;
        b=AkhVodf9KV8sTHM+xH59PgGf8VCFSduiA8CofMAJl7HoBj/u5a72jJdmS4ZliXX/6Z
         xSq7bG0cv0AohE2AMyy6GHbd/dolFN6piyaBmRvN35TUP+coGzVKyAUtILHm8KHjjdGJ
         jEI8cJip41p2R7rP/kyVMuj9NL2RfjWM89TdTr+tBB8ZoYsgR5Xroq3NsPVpzn7spzgf
         XqSmUPeUqzQknvQq+TNFTtr739mQcd5KoMWs3JFZHQzibMYlb34Bx1s8lx9Jl+b9spAK
         TA8/ZCkIGLvU45ZX0Pd2PcRL7V7BMrSuG01yT43W1njtYuAmptbFaV3bz58Y12Y93nt5
         Jllw==
X-Received: by 10.195.18.8 with SMTP id gi8mr2268049wjd.75.1406126241877;
        Wed, 23 Jul 2014 07:37:21 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:21 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 07/10] MIPS: Alchemy: au1100fb: use clk framework
Date:   Wed, 23 Jul 2014 16:36:54 +0200
Message-Id: <1406126217-471265-8-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Use the clock framework to en/disable the clock to the au1100
framebuffer device.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1000.c | 14 ++++++++++++++
 drivers/video/fbdev/au1100fb.c       | 36 ++++++++++++++++++++++--------------
 drivers/video/fbdev/au1100fb.h       |  1 +
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 8201f00..001102e 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -496,6 +497,7 @@ int __init db1000_dev_setup(void)
 	int board = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
 	int c0, c1, d0, d1, s0, s1, flashsize = 32,  twosocks = 1;
 	unsigned long pfc;
+	struct clk *c, *p;
 
 	if (board == BCSR_WHOAMI_DB1500) {
 		c0 = AU1500_GPIO2_INT;
@@ -525,6 +527,18 @@ int __init db1000_dev_setup(void)
 		spi_register_board_info(db1100_spi_info,
 					ARRAY_SIZE(db1100_spi_info));
 
+		/* link LCD clock to AUXPLL */
+		p = clk_get(NULL, "auxpll_clk");
+		c = clk_get(NULL, "lcd_intclk");
+		if (!IS_ERR(c) && !IS_ERR(p)) {
+			clk_set_parent(c, p);
+			clk_set_rate(c, clk_get_rate(p));
+		}
+		if (!IS_ERR(c))
+			clk_put(c);
+		if (!IS_ERR(p))
+			clk_put(p);
+
 		platform_add_devices(db1100_devs, ARRAY_SIZE(db1100_devs));
 		platform_device_register(&db1100_spi_dev);
 	} else if (board == BCSR_WHOAMI_DB1000) {
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index c163424..0676746e 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -41,6 +41,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -434,7 +435,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	struct au1100fb_device *fbdev = NULL;
 	struct resource *regs_res;
 	unsigned long page;
-	u32 sys_clksrc;
+	struct clk *c;
 
 	/* Allocate new device private */
 	fbdev = devm_kzalloc(&dev->dev, sizeof(struct au1100fb_device),
@@ -473,6 +474,13 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	print_dbg("Register memory map at %p", fbdev->regs);
 	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
 
+	c = clk_get(NULL, "lcd_intclk");
+	if (!IS_ERR(c)) {
+		fbdev->lcdclk = c;
+		clk_set_rate(c, 48000000);
+		clk_prepare_enable(c);
+	}
+
 	/* Allocate the framebuffer to the maximum screen size * nbr of video buffers */
 	fbdev->fb_len = fbdev->panel->xres * fbdev->panel->yres *
 		  	(fbdev->panel->bpp >> 3) * AU1100FB_NBR_VIDEO_BUFFERS;
@@ -506,11 +514,6 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
 	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
-	/* Setup LCD clock to AUX (48 MHz) */
-	sys_clksrc = alchemy_rdsys(AU1000_SYS_CLKSRC);
-	sys_clksrc &= ~(SYS_CS_ML_MASK | SYS_CS_DL | SYS_CS_CL);
-	alchemy_wrsys((sys_clksrc | (1 << SYS_CS_ML_BIT)), AU1000_SYS_CLKSRC);
-
 	/* load the panel info into the var struct */
 	au1100fb_var.bits_per_pixel = fbdev->panel->bpp;
 	au1100fb_var.xres = fbdev->panel->xres;
@@ -547,6 +550,10 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	return 0;
 
 failed:
+	if (fbdev->lcdclk) {
+		clk_disable_unprepare(fbdev->lcdclk);
+		clk_put(fbdev->lcdclk);
+	}
 	if (fbdev->fb_mem) {
 		dma_free_noncoherent(&dev->dev, fbdev->fb_len, fbdev->fb_mem,
 				     fbdev->fb_phys);
@@ -577,11 +584,15 @@ int au1100fb_drv_remove(struct platform_device *dev)
 
 	fb_dealloc_cmap(&fbdev->info.cmap);
 
+	if (fbdev->lcdclk) {
+		clk_disable_unprepare(fbdev->lcdclk);
+		clk_put(fbdev->lcdclk);
+	}
+
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static u32 sys_clksrc;
 static struct au1100fb_regs fbregs;
 
 int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
@@ -591,14 +602,11 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 	if (!fbdev)
 		return 0;
 
-	/* Save the clock source state */
-	sys_clksrc = alchemy_rdsys(AU1000_SYS_CLKSRC);
-
 	/* Blank the LCD */
 	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
 
-	/* Stop LCD clocking */
-	alchemy_wrsys(sys_clksrc & ~SYS_CS_ML_MASK, AU1000_SYS_CLKSRC);
+	if (fbdev->lcdclk)
+		clk_disable(fbdev->lcdclk);
 
 	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
 
@@ -614,8 +622,8 @@ int au1100fb_drv_resume(struct platform_device *dev)
 
 	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
 
-	/* Restart LCD clocking */
-	alchemy_wrsys(sys_clksrc, AU1000_SYS_CLKSRC);
+	if (fbdev->lcdclk)
+		clk_enable(fbdev->lcdclk);
 
 	/* Unblank the LCD */
 	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 12d9642..9af1993 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -109,6 +109,7 @@ struct au1100fb_device {
 	size_t	      		fb_len;
 	dma_addr_t    		fb_phys;
 	int			panel_idx;
+	struct clk		*lcdclk;
 };
 
 /********************************************************************/
-- 
2.0.1
