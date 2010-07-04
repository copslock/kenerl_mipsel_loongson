Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 00:28:15 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57396 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491158Ab0GDW2I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 00:28:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id E339593C;
        Mon,  5 Jul 2010 00:28:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OYawNrv4TGYb; Mon,  5 Jul 2010 00:28:02 +0200 (CEST)
Received: from [192.168.37.31] (port-92973.pppoe.wtnet.de [84.46.75.169])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 1D82093B;
        Mon,  5 Jul 2010 00:27:43 +0200 (CEST)
Message-ID: <4C310ACD.6040604@metafoo.de>
Date:   Mon, 05 Jul 2010 00:27:25 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <1276924111-11158-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1276924111-11158-17-git-send-email-lars@metafoo.de>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Hi Andrew

v2 of this patch has been around for two weeks without any comments. I've fixed all
the issues you had with v1. If you this version is ok, an Acked-By would be nice :)

Thanks
- Lars

Lars-Peter Clausen wrote:
> This patch adds support for the LCD controller on JZ4740 SoCs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fbdev@vger.kernel.org
> 
> ---
> Changes since v1
> - Use __packed instead of __attribute__((packed))
> - Make jzfb_fix const
> - Only set mode in set_par if it has changed
> ---
>  drivers/video/Kconfig     |    9 +
>  drivers/video/Makefile    |    1 +
>  drivers/video/jz4740_fb.c |  817 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/jz4740_fb.h |   58 ++++
>  4 files changed, 885 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/jz4740_fb.c
>  create mode 100644 include/linux/jz4740_fb.h
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index a9f9e5e..eae4c8a 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2237,6 +2237,15 @@ config FB_BROADSHEET
>  	  and could also have been called by other names when coupled with
>  	  a bridge adapter.
>  
> +config FB_JZ4740
> +	tristate "JZ4740 LCD framebuffer support"
> +	depends on FB
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	help
> +	  Framebuffer support for the JZ4740 SoC.
> +
>  source "drivers/video/omap/Kconfig"
>  source "drivers/video/omap2/Kconfig"
>  
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 3c3bf86..fd2df57 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -132,6 +132,7 @@ obj-$(CONFIG_FB_CARMINE)          += carminefb.o
>  obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
>  obj-$(CONFIG_FB_MSM)              += msm/
>  obj-$(CONFIG_FB_NUC900)           += nuc900fb.o
> +obj-$(CONFIG_FB_JZ4740)		  += jz4740_fb.o
>  
>  # Platform or fallback drivers go here
>  obj-$(CONFIG_FB_UVESA)            += uvesafb.o
> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
> new file mode 100644
> index 0000000..8d03181
> --- /dev/null
> +++ b/drivers/video/jz4740_fb.c
> @@ -0,0 +1,817 @@
> +/*
> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> + *	JZ4740 SoC LCD framebuffer driver
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under  the terms of  the GNU General Public License as published by the
> + *  Free Software Foundation;  either version 2 of the License, or (at your
> + *  option) any later version.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +
> +#include <linux/console.h>
> +#include <linux/fb.h>
> +
> +#include <linux/dma-mapping.h>
> +
> +#include <linux/jz4740_fb.h>
> +#include <asm/mach-jz4740/gpio.h>
> +
> +#define JZ_REG_LCD_CFG		0x00
> +#define JZ_REG_LCD_VSYNC	0x04
> +#define JZ_REG_LCD_HSYNC	0x08
> +#define JZ_REG_LCD_VAT		0x0C
> +#define JZ_REG_LCD_DAH		0x10
> +#define JZ_REG_LCD_DAV		0x14
> +#define JZ_REG_LCD_PS		0x18
> +#define JZ_REG_LCD_CLS		0x1C
> +#define JZ_REG_LCD_SPL		0x20
> +#define JZ_REG_LCD_REV		0x24
> +#define JZ_REG_LCD_CTRL		0x30
> +#define JZ_REG_LCD_STATE	0x34
> +#define JZ_REG_LCD_IID		0x38
> +#define JZ_REG_LCD_DA0		0x40
> +#define JZ_REG_LCD_SA0		0x44
> +#define JZ_REG_LCD_FID0		0x48
> +#define JZ_REG_LCD_CMD0		0x4C
> +#define JZ_REG_LCD_DA1		0x50
> +#define JZ_REG_LCD_SA1		0x54
> +#define JZ_REG_LCD_FID1		0x58
> +#define JZ_REG_LCD_CMD1		0x5C
> +
> +#define JZ_LCD_CFG_SLCD			BIT(31)
> +#define JZ_LCD_CFG_PS_DISABLE		BIT(23)
> +#define JZ_LCD_CFG_CLS_DISABLE		BIT(22)
> +#define JZ_LCD_CFG_SPL_DISABLE		BIT(21)
> +#define JZ_LCD_CFG_REV_DISABLE		BIT(20)
> +#define JZ_LCD_CFG_HSYNCM		BIT(19)
> +#define JZ_LCD_CFG_PCLKM		BIT(18)
> +#define JZ_LCD_CFG_INV			BIT(17)
> +#define JZ_LCD_CFG_SYNC_DIR		BIT(16)
> +#define JZ_LCD_CFG_PS_POLARITY		BIT(15)
> +#define JZ_LCD_CFG_CLS_POLARITY		BIT(14)
> +#define JZ_LCD_CFG_SPL_POLARITY		BIT(13)
> +#define JZ_LCD_CFG_REV_POLARITY		BIT(12)
> +#define JZ_LCD_CFG_HSYNC_ACTIVE_LOW	BIT(11)
> +#define JZ_LCD_CFG_PCLK_FALLING_EDGE	BIT(10)
> +#define JZ_LCD_CFG_DE_ACTIVE_LOW	BIT(9)
> +#define JZ_LCD_CFG_VSYNC_ACTIVE_LOW	BIT(8)
> +#define JZ_LCD_CFG_18_BIT		BIT(7)
> +#define JZ_LCD_CFG_PDW			(BIT(5) | BIT(4))
> +#define JZ_LCD_CFG_MODE_MASK 0xf
> +
> +#define JZ_LCD_CTRL_BURST_4		(0x0 << 28)
> +#define JZ_LCD_CTRL_BURST_8		(0x1 << 28)
> +#define JZ_LCD_CTRL_BURST_16		(0x2 << 28)
> +#define JZ_LCD_CTRL_RGB555		BIT(27)
> +#define JZ_LCD_CTRL_OFUP		BIT(26)
> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_16	(0x0 << 24)
> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_4	(0x1 << 24)
> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_2	(0x2 << 24)
> +#define JZ_LCD_CTRL_PDD_MASK		(0xff << 16)
> +#define JZ_LCD_CTRL_EOF_IRQ		BIT(13)
> +#define JZ_LCD_CTRL_SOF_IRQ		BIT(12)
> +#define JZ_LCD_CTRL_OFU_IRQ		BIT(11)
> +#define JZ_LCD_CTRL_IFU0_IRQ		BIT(10)
> +#define JZ_LCD_CTRL_IFU1_IRQ		BIT(9)
> +#define JZ_LCD_CTRL_DD_IRQ		BIT(8)
> +#define JZ_LCD_CTRL_QDD_IRQ		BIT(7)
> +#define JZ_LCD_CTRL_REVERSE_ENDIAN	BIT(6)
> +#define JZ_LCD_CTRL_LSB_FISRT		BIT(5)
> +#define JZ_LCD_CTRL_DISABLE		BIT(4)
> +#define JZ_LCD_CTRL_ENABLE		BIT(3)
> +#define JZ_LCD_CTRL_BPP_1		0x0
> +#define JZ_LCD_CTRL_BPP_2		0x1
> +#define JZ_LCD_CTRL_BPP_4		0x2
> +#define JZ_LCD_CTRL_BPP_8		0x3
> +#define JZ_LCD_CTRL_BPP_15_16		0x4
> +#define JZ_LCD_CTRL_BPP_18_24		0x5
> +
> +#define JZ_LCD_CMD_SOF_IRQ BIT(15)
> +#define JZ_LCD_CMD_EOF_IRQ BIT(16)
> +#define JZ_LCD_CMD_ENABLE_PAL BIT(12)
> +
> +#define JZ_LCD_SYNC_MASK 0x3ff
> +
> +#define JZ_LCD_STATE_DISABLED BIT(0)
> +
> +struct jzfb_framedesc {
> +	uint32_t next;
> +	uint32_t addr;
> +	uint32_t id;
> +	uint32_t cmd;
> +} __packed;
> +
> +struct jzfb {
> +	struct fb_info *fb;
> +	struct platform_device *pdev;
> +	void __iomem *base;
> +	struct resource *mem;
> +	struct jz4740_fb_platform_data *pdata;
> +
> +	size_t vidmem_size;
> +	void *vidmem;
> +	dma_addr_t vidmem_phys;
> +	struct jzfb_framedesc *framedesc;
> +	dma_addr_t framedesc_phys;
> +
> +	struct clk *ldclk;
> +	struct clk *lpclk;
> +
> +	unsigned is_enabled:1;
> +	struct mutex lock;
> +
> +	uint32_t pseudo_palette[16];
> +};
> +
> +static const struct fb_fix_screeninfo jzfb_fix __devinitdata = {
> +	.id		= "JZ4740 FB",
> +	.type		= FB_TYPE_PACKED_PIXELS,
> +	.visual		= FB_VISUAL_TRUECOLOR,
> +	.xpanstep	= 0,
> +	.ypanstep	= 0,
> +	.ywrapstep	= 0,
> +	.accel		= FB_ACCEL_NONE,
> +};
> +
> +static const struct jz_gpio_bulk_request jz_lcd_ctrl_pins[] = {
> +	JZ_GPIO_BULK_PIN(LCD_PCLK),
> +	JZ_GPIO_BULK_PIN(LCD_HSYNC),
> +	JZ_GPIO_BULK_PIN(LCD_VSYNC),
> +	JZ_GPIO_BULK_PIN(LCD_DE),
> +	JZ_GPIO_BULK_PIN(LCD_PS),
> +	JZ_GPIO_BULK_PIN(LCD_REV),
> +};
> +
> +static const struct jz_gpio_bulk_request jz_lcd_data_pins[] = {
> +	JZ_GPIO_BULK_PIN(LCD_DATA0),
> +	JZ_GPIO_BULK_PIN(LCD_DATA1),
> +	JZ_GPIO_BULK_PIN(LCD_DATA2),
> +	JZ_GPIO_BULK_PIN(LCD_DATA3),
> +	JZ_GPIO_BULK_PIN(LCD_DATA4),
> +	JZ_GPIO_BULK_PIN(LCD_DATA5),
> +	JZ_GPIO_BULK_PIN(LCD_DATA6),
> +	JZ_GPIO_BULK_PIN(LCD_DATA7),
> +	JZ_GPIO_BULK_PIN(LCD_DATA8),
> +	JZ_GPIO_BULK_PIN(LCD_DATA9),
> +	JZ_GPIO_BULK_PIN(LCD_DATA10),
> +	JZ_GPIO_BULK_PIN(LCD_DATA11),
> +	JZ_GPIO_BULK_PIN(LCD_DATA12),
> +	JZ_GPIO_BULK_PIN(LCD_DATA13),
> +	JZ_GPIO_BULK_PIN(LCD_DATA14),
> +	JZ_GPIO_BULK_PIN(LCD_DATA15),
> +	JZ_GPIO_BULK_PIN(LCD_DATA16),
> +	JZ_GPIO_BULK_PIN(LCD_DATA17),
> +};
> +
> +static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
> +{
> +	unsigned int num;
> +
> +	switch (jzfb->pdata->lcd_type) {
> +	case JZ_LCD_TYPE_GENERIC_16_BIT:
> +		num = 4;
> +		break;
> +	case JZ_LCD_TYPE_GENERIC_18_BIT:
> +		num = 4;
> +		break;
> +	case JZ_LCD_TYPE_8BIT_SERIAL:
> +		num = 3;
> +		break;
> +	default:
> +		num = 0;
> +		break;
> +	}
> +	return num;
> +}
> +
> +static unsigned int jzfb_num_data_pins(struct jzfb *jzfb)
> +{
> +	unsigned int num;
> +
> +	switch (jzfb->pdata->lcd_type) {
> +	case JZ_LCD_TYPE_GENERIC_16_BIT:
> +		num = 16;
> +		break;
> +	case JZ_LCD_TYPE_GENERIC_18_BIT:
> +		num = 18;
> +		break;
> +	case JZ_LCD_TYPE_8BIT_SERIAL:
> +		num = 8;
> +		break;
> +	default:
> +		num = 0;
> +		break;
> +	}
> +	return num;
> +}
> +
> +/* Based on CNVT_TOHW macro from skeletonfb.c */
> +static inline uint32_t jzfb_convert_color_to_hw(unsigned val,
> +	struct fb_bitfield *bf)
> +{
> +	return (((val << bf->length) + 0x7FFF - val) >> 16) << bf->offset;
> +}
> +
> +static int jzfb_setcolreg(unsigned regno, unsigned red, unsigned green,
> +			unsigned blue, unsigned transp, struct fb_info *fb)
> +{
> +	uint32_t color;
> +
> +	if (regno >= 16)
> +		return -EINVAL;
> +
> +	color = jzfb_convert_color_to_hw(red, &fb->var.red);
> +	color |= jzfb_convert_color_to_hw(green, &fb->var.green);
> +	color |= jzfb_convert_color_to_hw(blue, &fb->var.blue);
> +	color |= jzfb_convert_color_to_hw(transp, &fb->var.transp);
> +
> +	((uint32_t *)(fb->pseudo_palette))[regno] = color;
> +
> +	return 0;
> +}
> +
> +static int jzfb_get_controller_bpp(struct jzfb *jzfb)
> +{
> +	switch (jzfb->pdata->bpp) {
> +	case 18:
> +	case 24:
> +		return 32;
> +	case 15:
> +		return 16;
> +	default:
> +		return jzfb->pdata->bpp;
> +	}
> +}
> +
> +static struct fb_videomode *jzfb_get_mode(struct jzfb *jzfb,
> +	struct fb_var_screeninfo *var)
> +{
> +	size_t i;
> +	struct fb_videomode *mode = jzfb->pdata->modes;
> +
> +	for (i = 0; i < jzfb->pdata->num_modes; ++i, ++mode) {
> +		if (mode->xres == var->xres && mode->yres == var->yres)
> +			return mode;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int jzfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb)
> +{
> +	struct jzfb *jzfb = fb->par;
> +	struct fb_videomode *mode;
> +
> +	if (var->bits_per_pixel != jzfb_get_controller_bpp(jzfb) &&
> +		var->bits_per_pixel != jzfb->pdata->bpp)
> +		return -EINVAL;
> +
> +	mode = jzfb_get_mode(jzfb, var);
> +	if (mode == NULL)
> +		return -EINVAL;
> +
> +	fb_videomode_to_var(var, mode);
> +
> +	switch (jzfb->pdata->bpp) {
> +	case 8:
> +		break;
> +	case 15:
> +		var->red.offset = 10;
> +		var->red.length = 5;
> +		var->green.offset = 6;
> +		var->green.length = 5;
> +		var->blue.offset = 0;
> +		var->blue.length = 5;
> +		break;
> +	case 16:
> +		var->red.offset = 11;
> +		var->red.length = 5;
> +		var->green.offset = 5;
> +		var->green.length = 6;
> +		var->blue.offset = 0;
> +		var->blue.length = 5;
> +		break;
> +	case 18:
> +		var->red.offset = 16;
> +		var->red.length = 6;
> +		var->green.offset = 8;
> +		var->green.length = 6;
> +		var->blue.offset = 0;
> +		var->blue.length = 6;
> +		var->bits_per_pixel = 32;
> +		break;
> +	case 32:
> +	case 24:
> +		var->transp.offset = 24;
> +		var->transp.length = 8;
> +		var->red.offset = 16;
> +		var->red.length = 8;
> +		var->green.offset = 8;
> +		var->green.length = 8;
> +		var->blue.offset = 0;
> +		var->blue.length = 8;
> +		var->bits_per_pixel = 32;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int jzfb_set_par(struct fb_info *info)
> +{
> +	struct jzfb *jzfb = info->par;
> +	struct fb_var_screeninfo *var = &info->var;
> +	struct fb_videomode *mode;
> +	uint16_t hds, vds;
> +	uint16_t hde, vde;
> +	uint16_t ht, vt;
> +	uint32_t ctrl;
> +	uint32_t cfg;
> +	unsigned long rate;
> +
> +	mode = jzfb_get_mode(jzfb, var);
> +	if (mode == NULL)
> +		return -EINVAL;
> +
> +	if (mode == info->mode)
> +		return 0;
> +
> +	info->mode = mode;
> +
> +	hds = mode->hsync_len + mode->left_margin;
> +	hde = hds + mode->xres;
> +	ht = hde + mode->right_margin;
> +
> +	vds = mode->vsync_len + mode->upper_margin;
> +	vde = vds + mode->yres;
> +	vt = vde + mode->lower_margin;
> +
> +	ctrl = JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16;
> +
> +	switch (jzfb->pdata->bpp) {
> +	case 1:
> +		ctrl |= JZ_LCD_CTRL_BPP_1;
> +		break;
> +	case 2:
> +		ctrl |= JZ_LCD_CTRL_BPP_2;
> +		break;
> +	case 4:
> +		ctrl |= JZ_LCD_CTRL_BPP_4;
> +		break;
> +	case 8:
> +		ctrl |= JZ_LCD_CTRL_BPP_8;
> +	break;
> +	case 15:
> +		ctrl |= JZ_LCD_CTRL_RGB555; /* Falltrough */
> +	case 16:
> +		ctrl |= JZ_LCD_CTRL_BPP_15_16;
> +		break;
> +	case 18:
> +	case 24:
> +	case 32:
> +		ctrl |= JZ_LCD_CTRL_BPP_18_24;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	cfg = JZ_LCD_CFG_PS_DISABLE | JZ_LCD_CFG_CLS_DISABLE |
> +		JZ_LCD_CFG_SPL_DISABLE | JZ_LCD_CFG_REV_DISABLE;
> +
> +	if (!(mode->sync & FB_SYNC_HOR_HIGH_ACT))
> +		cfg |= JZ_LCD_CFG_HSYNC_ACTIVE_LOW;
> +
> +	if (!(mode->sync & FB_SYNC_VERT_HIGH_ACT))
> +		cfg |= JZ_LCD_CFG_VSYNC_ACTIVE_LOW;
> +
> +	if (jzfb->pdata->pixclk_falling_edge)
> +		cfg |= JZ_LCD_CFG_PCLK_FALLING_EDGE;
> +
> +	if (jzfb->pdata->date_enable_active_low)
> +		cfg |= JZ_LCD_CFG_DE_ACTIVE_LOW;
> +
> +	if (jzfb->pdata->lcd_type == JZ_LCD_TYPE_GENERIC_18_BIT)
> +		cfg |= JZ_LCD_CFG_18_BIT;
> +
> +	cfg |= jzfb->pdata->lcd_type & 0xf;
> +
> +	if (mode->pixclock) {
> +		rate = PICOS2KHZ(mode->pixclock) * 1000;
> +		mode->refresh = rate / vt / ht;
> +	} else {
> +		if (jzfb->pdata->lcd_type == JZ_LCD_TYPE_8BIT_SERIAL)
> +			rate = mode->refresh * (vt + 2 * mode->xres) * ht;
> +		else
> +			rate = mode->refresh * vt * ht;
> +
> +		mode->pixclock = KHZ2PICOS(rate / 1000);
> +	}
> +
> +	mutex_lock(&jzfb->lock);
> +	if (!jzfb->is_enabled)
> +		clk_enable(jzfb->ldclk);
> +	else
> +		ctrl |= JZ_LCD_CTRL_ENABLE;
> +
> +	writel(mode->hsync_len, jzfb->base + JZ_REG_LCD_HSYNC);
> +	writel(mode->vsync_len, jzfb->base + JZ_REG_LCD_VSYNC);
> +
> +	writel((ht << 16) | vt, jzfb->base + JZ_REG_LCD_VAT);
> +
> +	writel((hds << 16) | hde, jzfb->base + JZ_REG_LCD_DAH);
> +	writel((vds << 16) | vde, jzfb->base + JZ_REG_LCD_DAV);
> +
> +	writel(cfg, jzfb->base + JZ_REG_LCD_CFG);
> +
> +	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
> +
> +	if (!jzfb->is_enabled)
> +		clk_disable(jzfb->ldclk);
> +
> +	mutex_unlock(&jzfb->lock);
> +
> +	clk_set_rate(jzfb->lpclk, rate);
> +	clk_set_rate(jzfb->ldclk, rate * 3);
> +
> +	return 0;
> +}
> +
> +static void jzfb_enable(struct jzfb *jzfb)
> +{
> +	uint32_t ctrl;
> +
> +	clk_enable(jzfb->ldclk);
> +
> +	jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> +	jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +
> +	writel(0, jzfb->base + JZ_REG_LCD_STATE);
> +
> +	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
> +
> +	ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
> +	ctrl |= JZ_LCD_CTRL_ENABLE;
> +	ctrl &= ~JZ_LCD_CTRL_DISABLE;
> +	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
> +}
> +
> +static void jzfb_disable(struct jzfb *jzfb)
> +{
> +	uint32_t ctrl;
> +
> +	ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
> +	ctrl |= JZ_LCD_CTRL_DISABLE;
> +	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
> +	do {
> +		ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
> +	} while (!(ctrl & JZ_LCD_STATE_DISABLED));
> +
> +	jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> +	jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +
> +	clk_disable(jzfb->ldclk);
> +}
> +
> +static int jzfb_blank(int blank_mode, struct fb_info *info)
> +{
> +	struct jzfb *jzfb = info->par;
> +
> +	switch (blank_mode) {
> +	case FB_BLANK_UNBLANK:
> +		mutex_lock(&jzfb->lock);
> +		if (jzfb->is_enabled) {
> +			mutex_unlock(&jzfb->lock);
> +			return 0;
> +		}
> +
> +		jzfb_enable(jzfb);
> +		jzfb->is_enabled = 1;
> +
> +		mutex_unlock(&jzfb->lock);
> +		break;
> +	default:
> +		mutex_lock(&jzfb->lock);
> +		if (!jzfb->is_enabled) {
> +			mutex_unlock(&jzfb->lock);
> +			return 0;
> +		}
> +
> +		jzfb_disable(jzfb);
> +		jzfb->is_enabled = 0;
> +
> +		mutex_unlock(&jzfb->lock);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int jzfb_alloc_devmem(struct jzfb *jzfb)
> +{
> +	int max_videosize = 0;
> +	struct fb_videomode *mode = jzfb->pdata->modes;
> +	void *page;
> +	int i;
> +
> +	for (i = 0; i < jzfb->pdata->num_modes; ++mode, ++i) {
> +		if (max_videosize < mode->xres * mode->yres)
> +			max_videosize = mode->xres * mode->yres;
> +	}
> +
> +	max_videosize *= jzfb_get_controller_bpp(jzfb) >> 3;
> +
> +	jzfb->framedesc = dma_alloc_coherent(&jzfb->pdev->dev,
> +					sizeof(*jzfb->framedesc),
> +					&jzfb->framedesc_phys, GFP_KERNEL);
> +
> +	if (!jzfb->framedesc)
> +		return -ENOMEM;
> +
> +	jzfb->vidmem_size = PAGE_ALIGN(max_videosize);
> +	jzfb->vidmem = dma_alloc_coherent(&jzfb->pdev->dev,
> +					jzfb->vidmem_size,
> +					&jzfb->vidmem_phys, GFP_KERNEL);
> +
> +	if (!jzfb->vidmem)
> +		goto err_free_framedesc;
> +
> +	for (page = jzfb->vidmem;
> +		 page < jzfb->vidmem + PAGE_ALIGN(jzfb->vidmem_size);
> +		 page += PAGE_SIZE) {
> +		SetPageReserved(virt_to_page(page));
> +	}
> +
> +	jzfb->framedesc->next = jzfb->framedesc_phys;
> +	jzfb->framedesc->addr = jzfb->vidmem_phys;
> +	jzfb->framedesc->id = 0xdeafbead;
> +	jzfb->framedesc->cmd = 0;
> +	jzfb->framedesc->cmd |= max_videosize / 4;
> +
> +	return 0;
> +
> +err_free_framedesc:
> +	dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
> +				jzfb->framedesc, jzfb->framedesc_phys);
> +	return -ENOMEM;
> +}
> +
> +static void jzfb_free_devmem(struct jzfb *jzfb)
> +{
> +	dma_free_coherent(&jzfb->pdev->dev, jzfb->vidmem_size,
> +				jzfb->vidmem, jzfb->vidmem_phys);
> +	dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
> +				jzfb->framedesc, jzfb->framedesc_phys);
> +}
> +
> +static struct  fb_ops jzfb_ops = {
> +	.owner = THIS_MODULE,
> +	.fb_check_var = jzfb_check_var,
> +	.fb_set_par = jzfb_set_par,
> +	.fb_blank = jzfb_blank,
> +	.fb_fillrect	= sys_fillrect,
> +	.fb_copyarea	= sys_copyarea,
> +	.fb_imageblit	= sys_imageblit,
> +	.fb_setcolreg = jzfb_setcolreg,
> +};
> +
> +static int __devinit jzfb_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct jzfb *jzfb;
> +	struct fb_info *fb;
> +	struct jz4740_fb_platform_data *pdata = pdev->dev.platform_data;
> +	struct resource *mem;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Missing platform data\n");
> +		return -ENOENT;
> +	}
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "Failed to get register memory resource\n");
> +		return -ENOENT;
> +	}
> +
> +	mem = request_mem_region(mem->start, resource_size(mem), pdev->name);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "Failed to request register memory region\n");
> +		return -EBUSY;
> +	}
> +
> +	fb = framebuffer_alloc(sizeof(struct jzfb), &pdev->dev);
> +	if (!fb) {
> +		dev_err(&pdev->dev, "Failed to allocate framebuffer device\n");
> +		ret = -ENOMEM;
> +		goto err_release_mem_region;
> +	}
> +
> +	fb->fbops = &jzfb_ops;
> +	fb->flags = FBINFO_DEFAULT;
> +
> +	jzfb = fb->par;
> +	jzfb->pdev = pdev;
> +	jzfb->pdata = pdata;
> +	jzfb->mem = mem;
> +
> +	jzfb->ldclk = clk_get(&pdev->dev, "lcd");
> +	if (IS_ERR(jzfb->ldclk)) {
> +		ret = PTR_ERR(jzfb->ldclk);
> +		dev_err(&pdev->dev, "Failed to get lcd clock: %d\n", ret);
> +		goto err_framebuffer_release;
> +	}
> +
> +	jzfb->lpclk = clk_get(&pdev->dev, "lcd_pclk");
> +	if (IS_ERR(jzfb->lpclk)) {
> +		ret = PTR_ERR(jzfb->lpclk);
> +		dev_err(&pdev->dev, "Failed to get lcd pixel clock: %d\n", ret);
> +		goto err_put_ldclk;
> +	}
> +
> +	jzfb->base = ioremap(mem->start, resource_size(mem));
> +	if (!jzfb->base) {
> +		dev_err(&pdev->dev, "Failed to ioremap register memory region\n");
> +		ret = -EBUSY;
> +		goto err_put_lpclk;
> +	}
> +
> +	platform_set_drvdata(pdev, jzfb);
> +
> +	mutex_init(&jzfb->lock);
> +
> +	fb_videomode_to_modelist(pdata->modes, pdata->num_modes,
> +				 &fb->modelist);
> +	fb_videomode_to_var(&fb->var, pdata->modes);
> +	fb->var.bits_per_pixel = pdata->bpp;
> +	jzfb_check_var(&fb->var, fb);
> +
> +	ret = jzfb_alloc_devmem(jzfb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate video memory\n");
> +		goto err_iounmap;
> +	}
> +
> +	fb->fix = jzfb_fix;
> +	fb->fix.line_length = fb->var.bits_per_pixel * fb->var.xres / 8;
> +	fb->fix.mmio_start = mem->start;
> +	fb->fix.mmio_len = resource_size(mem);
> +	fb->fix.smem_start = jzfb->vidmem_phys;
> +	fb->fix.smem_len =  fb->fix.line_length * fb->var.yres;
> +	fb->screen_base = jzfb->vidmem;
> +	fb->pseudo_palette = jzfb->pseudo_palette;
> +
> +	fb_alloc_cmap(&fb->cmap, 256, 0);
> +
> +	clk_enable(jzfb->ldclk);
> +	jzfb->is_enabled = 1;
> +
> +	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
> +
> +	fb->mode = NULL;
> +	jzfb_set_par(fb);
> +
> +	jz_gpio_bulk_request(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> +	jz_gpio_bulk_request(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +
> +	ret = register_framebuffer(fb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register framebuffer: %d\n", ret);
> +		goto err_free_devmem;
> +	}
> +
> +	jzfb->fb = fb;
> +
> +	return 0;
> +
> +err_free_devmem:
> +	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> +	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +
> +	fb_dealloc_cmap(&fb->cmap);
> +	jzfb_free_devmem(jzfb);
> +err_iounmap:
> +	iounmap(jzfb->base);
> +err_put_lpclk:
> +	clk_put(jzfb->lpclk);
> +err_put_ldclk:
> +	clk_put(jzfb->ldclk);
> +err_framebuffer_release:
> +	framebuffer_release(fb);
> +err_release_mem_region:
> +	release_mem_region(mem->start, resource_size(mem));
> +	return ret;
> +}
> +
> +static int __devexit jzfb_remove(struct platform_device *pdev)
> +{
> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
> +
> +	jzfb_blank(FB_BLANK_POWERDOWN, jzfb->fb);
> +
> +	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> +	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +
> +	iounmap(jzfb->base);
> +	release_mem_region(jzfb->mem->start, resource_size(jzfb->mem));
> +
> +	fb_dealloc_cmap(&jzfb->fb->cmap);
> +	jzfb_free_devmem(jzfb);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	clk_put(jzfb->lpclk);
> +	clk_put(jzfb->ldclk);
> +
> +	framebuffer_release(jzfb->fb);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +
> +static int jzfb_suspend(struct device *dev)
> +{
> +	struct jzfb *jzfb = dev_get_drvdata(dev);
> +
> +	acquire_console_sem();
> +	fb_set_suspend(jzfb->fb, 1);
> +	release_console_sem();
> +
> +	mutex_lock(&jzfb->lock);
> +	if (jzfb->is_enabled)
> +		jzfb_disable(jzfb);
> +	mutex_unlock(&jzfb->lock);
> +
> +	return 0;
> +}
> +
> +static int jzfb_resume(struct device *dev)
> +{
> +	struct jzfb *jzfb = dev_get_drvdata(dev);
> +	clk_enable(jzfb->ldclk);
> +
> +	mutex_lock(&jzfb->lock);
> +	if (jzfb->is_enabled)
> +		jzfb_enable(jzfb);
> +	mutex_unlock(&jzfb->lock);
> +
> +	acquire_console_sem();
> +	fb_set_suspend(jzfb->fb, 0);
> +	release_console_sem();
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops jzfb_pm_ops = {
> +	.suspend	= jzfb_suspend,
> +	.resume		= jzfb_resume,
> +	.poweroff	= jzfb_suspend,
> +	.restore	= jzfb_resume,
> +};
> +
> +#define JZFB_PM_OPS (&jzfb_pm_ops)
> +
> +#else
> +#define JZFB_PM_OPS NULL
> +#endif
> +
> +static struct platform_driver jzfb_driver = {
> +	.probe = jzfb_probe,
> +	.remove = __devexit_p(jzfb_remove),
> +	.driver = {
> +		.name = "jz4740-fb",
> +		.pm = JZFB_PM_OPS,
> +	},
> +};
> +
> +static int __init jzfb_init(void)
> +{
> +	return platform_driver_register(&jzfb_driver);
> +}
> +module_init(jzfb_init);
> +
> +static void __exit jzfb_exit(void)
> +{
> +	platform_driver_unregister(&jzfb_driver);
> +}
> +module_exit(jzfb_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("JZ4740 SoC LCD framebuffer driver");
> +MODULE_ALIAS("platform:jz4740-fb");
> diff --git a/include/linux/jz4740_fb.h b/include/linux/jz4740_fb.h
> new file mode 100644
> index 0000000..ab4c963
> --- /dev/null
> +++ b/include/linux/jz4740_fb.h
> @@ -0,0 +1,58 @@
> +/*
> + *  Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
> + *
> + *  This program is free software; you can redistribute	 it and/or modify it
> + *  under  the terms of	 the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the	License, or (at your
> + *  option) any later version.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#ifndef __LINUX_JZ4740_FB_H
> +#define __LINUX_JZ4740_FB_H
> +
> +#include <linux/fb.h>
> +
> +enum jz4740_fb_lcd_type {
> +	JZ_LCD_TYPE_GENERIC_16_BIT = 0,
> +	JZ_LCD_TYPE_GENERIC_18_BIT = 0 | (1 << 4),
> +	JZ_LCD_TYPE_SPECIAL_TFT_1 = 1,
> +	JZ_LCD_TYPE_SPECIAL_TFT_2 = 2,
> +	JZ_LCD_TYPE_SPECIAL_TFT_3 = 3,
> +	JZ_LCD_TYPE_NON_INTERLACED_CCIR656 = 5,
> +	JZ_LCD_TYPE_INTERLACED_CCIR656 = 7,
> +	JZ_LCD_TYPE_SINGLE_COLOR_STN = 8,
> +	JZ_LCD_TYPE_SINGLE_MONOCHROME_STN = 9,
> +	JZ_LCD_TYPE_DUAL_COLOR_STN = 10,
> +	JZ_LCD_TYPE_DUAL_MONOCHROME_STN = 11,
> +	JZ_LCD_TYPE_8BIT_SERIAL = 12,
> +};
> +
> +/*
> +* width: width of the lcd display in mm
> +* height: height of the lcd display in mm
> +* num_modes: size of modes
> +* modes: list of valid video modes
> +* bpp: bits per pixel for the lcd
> +* lcd_type: lcd type
> +*/
> +
> +struct jz4740_fb_platform_data {
> +	unsigned int width;
> +	unsigned int height;
> +
> +	size_t num_modes;
> +	struct fb_videomode *modes;
> +
> +	unsigned int bpp;
> +	enum jz4740_fb_lcd_type lcd_type;
> +
> +	unsigned pixclk_falling_edge:1;
> +	unsigned date_enable_active_low:1;
> +};
> +
> +#endif
