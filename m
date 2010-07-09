Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jul 2010 03:26:48 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:39456 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492130Ab0GIB0k convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jul 2010 03:26:40 +0200
Received: by iwn40 with SMTP id 40so1819204iwn.36
        for <multiple recipients>; Thu, 08 Jul 2010 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IYSfeyTEohEhStk/lxk6xWqlOnIxS96XIuF72z6J6t8=;
        b=CfCRlnuq2fVPmTka1cYYY3v48cje285y+Opa1oHxcZjzQphAp17ktDC61FidJ61ojW
         XliZU342g/ze1bbk1bWkvCKSwHFDs1b5Vvk5ba9AdgutFJ5iF3n90zk21aGln8c87UJf
         1Wo3/N7gzLPZdTm4fr+MnwBAa106Dmn4nCeXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YOwnsMjQEotqxtiNNaKYZkc4tdGB1Z1wayhtMn/1zXZAHr8L2fyyufbQC726CbW6iZ
         UC3c5SZ33l6PI14ft02x/OrTMM47LYhX/ZRqAPT6u/2nxqfdjgcFWNxCQRsYor+BUr7B
         tCQT8uDSM/Bdn4na2j07CNJ+R/XUU4dKAMWlo=
MIME-Version: 1.0
Received: by 10.231.148.73 with SMTP id o9mr9400619ibv.21.1278638799057; Thu, 
        08 Jul 2010 18:26:39 -0700 (PDT)
Received: by 10.231.41.28 with HTTP; Thu, 8 Jul 2010 18:26:38 -0700 (PDT)
In-Reply-To: <4C310ACD.6040604@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
        <1276924111-11158-17-git-send-email-lars@metafoo.de>
        <4C310ACD.6040604@metafoo.de>
Date:   Fri, 9 Jul 2010 09:26:38 +0800
Message-ID: <AANLkTikwGwXeCpwL8KfLVB3b9IoWoUJwaTStTwr8iR8z@mail.gmail.com>
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
From:   Jaya Kumar <jayakumar.lkml@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <jayakumar.lkml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayakumar.lkml@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Jul 5, 2010 at 6:27 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi Andrew
>
> v2 of this patch has been around for two weeks without any comments. I've fixed all
> the issues you had with v1. If you this version is ok, an Acked-By would be nice :)
>
> Thanks
> - Lars
>
> Lars-Peter Clausen wrote:
>> This patch adds support for the LCD controller on JZ4740 SoCs.

Hi Lars, Andrew,

I think this driver looks okay but I had some quick questions:

>> +config FB_JZ4740
>> +     tristate "JZ4740 LCD framebuffer support"
>> +     depends on FB
>> +     select FB_SYS_FILLRECT
>> +     select FB_SYS_COPYAREA
>> +     select FB_SYS_IMAGEBLIT

Out of curiosity, why FB_SYS and not FB_CFB? The users of FB_SYS are
drivers that use virtual memory for their framebuffer. I didn't see
any vmalloc in this driver.

>> +     help
>> +       Framebuffer support for the JZ4740 SoC.
>> +
>>  source "drivers/video/omap/Kconfig"
>>  source "drivers/video/omap2/Kconfig"
>>
>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>> index 3c3bf86..fd2df57 100644
>> --- a/drivers/video/Makefile
>> +++ b/drivers/video/Makefile
>> @@ -132,6 +132,7 @@ obj-$(CONFIG_FB_CARMINE)          += carminefb.o
>>  obj-$(CONFIG_FB_MB862XX)       += mb862xx/
>>  obj-$(CONFIG_FB_MSM)              += msm/
>>  obj-$(CONFIG_FB_NUC900)           += nuc900fb.o
>> +obj-$(CONFIG_FB_JZ4740)                += jz4740_fb.o

Just a minor nit, the typical naming in fbdev appears to be
controllerfb.c as opposed to controller_fb.c .

>>
>>  # Platform or fallback drivers go here
>>  obj-$(CONFIG_FB_UVESA)            += uvesafb.o
>> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
>> new file mode 100644
>> index 0000000..8d03181
>> --- /dev/null
>> +++ b/drivers/video/jz4740_fb.c
>> @@ -0,0 +1,817 @@
>> +/*
>> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
>> + *   JZ4740 SoC LCD framebuffer driver
>> + *
>> + *  This program is free software; you can redistribute it and/or modify it
>> + *  under  the terms of  the GNU General Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the License, or (at your
>> + *  option) any later version.
>> + *
>> + *  You should have received a copy of the GNU General Public License along
>> + *  with this program; if not, write to the Free Software Foundation, Inc.,
>> + *  675 Mass Ave, Cambridge, MA 02139, USA.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +
>> +#include <linux/console.h>
>> +#include <linux/fb.h>
>> +
>> +#include <linux/dma-mapping.h>
>> +
>> +#include <linux/jz4740_fb.h>

I see a lot of register defines below. Is there any reason why they
shouldn't go in above j*fb.h? Also, I'm not sure if linux/j*.h is the
best place. I think most fbdev drivers place their headers in
drivers/video itself unless they need to share something driver
specific with userspace which is rare. Is there a specific reason why
you put it in include/linux?


>> +#include <asm/mach-jz4740/gpio.h>
>> +
>> +#define JZ_REG_LCD_CFG               0x00
>> +#define JZ_REG_LCD_VSYNC     0x04
>> +#define JZ_REG_LCD_HSYNC     0x08
>> +#define JZ_REG_LCD_VAT               0x0C
>> +#define JZ_REG_LCD_DAH               0x10
>> +#define JZ_REG_LCD_DAV               0x14
>> +#define JZ_REG_LCD_PS                0x18
>> +#define JZ_REG_LCD_CLS               0x1C
>> +#define JZ_REG_LCD_SPL               0x20
>> +#define JZ_REG_LCD_REV               0x24
>> +#define JZ_REG_LCD_CTRL              0x30
>> +#define JZ_REG_LCD_STATE     0x34
>> +#define JZ_REG_LCD_IID               0x38
>> +#define JZ_REG_LCD_DA0               0x40
>> +#define JZ_REG_LCD_SA0               0x44
>> +#define JZ_REG_LCD_FID0              0x48
>> +#define JZ_REG_LCD_CMD0              0x4C
>> +#define JZ_REG_LCD_DA1               0x50
>> +#define JZ_REG_LCD_SA1               0x54
>> +#define JZ_REG_LCD_FID1              0x58
>> +#define JZ_REG_LCD_CMD1              0x5C
>> +
>> +#define JZ_LCD_CFG_SLCD                      BIT(31)
>> +#define JZ_LCD_CFG_PS_DISABLE                BIT(23)
>> +#define JZ_LCD_CFG_CLS_DISABLE               BIT(22)
>> +#define JZ_LCD_CFG_SPL_DISABLE               BIT(21)
>> +#define JZ_LCD_CFG_REV_DISABLE               BIT(20)
>> +#define JZ_LCD_CFG_HSYNCM            BIT(19)
>> +#define JZ_LCD_CFG_PCLKM             BIT(18)
>> +#define JZ_LCD_CFG_INV                       BIT(17)
>> +#define JZ_LCD_CFG_SYNC_DIR          BIT(16)
>> +#define JZ_LCD_CFG_PS_POLARITY               BIT(15)
>> +#define JZ_LCD_CFG_CLS_POLARITY              BIT(14)
>> +#define JZ_LCD_CFG_SPL_POLARITY              BIT(13)
>> +#define JZ_LCD_CFG_REV_POLARITY              BIT(12)
>> +#define JZ_LCD_CFG_HSYNC_ACTIVE_LOW  BIT(11)
>> +#define JZ_LCD_CFG_PCLK_FALLING_EDGE BIT(10)
>> +#define JZ_LCD_CFG_DE_ACTIVE_LOW     BIT(9)
>> +#define JZ_LCD_CFG_VSYNC_ACTIVE_LOW  BIT(8)
>> +#define JZ_LCD_CFG_18_BIT            BIT(7)
>> +#define JZ_LCD_CFG_PDW                       (BIT(5) | BIT(4))
>> +#define JZ_LCD_CFG_MODE_MASK 0xf
>> +
>> +#define JZ_LCD_CTRL_BURST_4          (0x0 << 28)
>> +#define JZ_LCD_CTRL_BURST_8          (0x1 << 28)
>> +#define JZ_LCD_CTRL_BURST_16         (0x2 << 28)
>> +#define JZ_LCD_CTRL_RGB555           BIT(27)
>> +#define JZ_LCD_CTRL_OFUP             BIT(26)
>> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_16 (0x0 << 24)
>> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_4  (0x1 << 24)
>> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_2  (0x2 << 24)
>> +#define JZ_LCD_CTRL_PDD_MASK         (0xff << 16)
>> +#define JZ_LCD_CTRL_EOF_IRQ          BIT(13)
>> +#define JZ_LCD_CTRL_SOF_IRQ          BIT(12)
>> +#define JZ_LCD_CTRL_OFU_IRQ          BIT(11)
>> +#define JZ_LCD_CTRL_IFU0_IRQ         BIT(10)
>> +#define JZ_LCD_CTRL_IFU1_IRQ         BIT(9)
>> +#define JZ_LCD_CTRL_DD_IRQ           BIT(8)
>> +#define JZ_LCD_CTRL_QDD_IRQ          BIT(7)
>> +#define JZ_LCD_CTRL_REVERSE_ENDIAN   BIT(6)
>> +#define JZ_LCD_CTRL_LSB_FISRT                BIT(5)
>> +#define JZ_LCD_CTRL_DISABLE          BIT(4)
>> +#define JZ_LCD_CTRL_ENABLE           BIT(3)
>> +#define JZ_LCD_CTRL_BPP_1            0x0
>> +#define JZ_LCD_CTRL_BPP_2            0x1
>> +#define JZ_LCD_CTRL_BPP_4            0x2
>> +#define JZ_LCD_CTRL_BPP_8            0x3
>> +#define JZ_LCD_CTRL_BPP_15_16                0x4
>> +#define JZ_LCD_CTRL_BPP_18_24                0x5
>> +
>> +#define JZ_LCD_CMD_SOF_IRQ BIT(15)
>> +#define JZ_LCD_CMD_EOF_IRQ BIT(16)
>> +#define JZ_LCD_CMD_ENABLE_PAL BIT(12)
>> +
>> +#define JZ_LCD_SYNC_MASK 0x3ff
>> +
>> +#define JZ_LCD_STATE_DISABLED BIT(0)
>> +
>> +struct jzfb_framedesc {
>> +     uint32_t next;
>> +     uint32_t addr;
>> +     uint32_t id;
>> +     uint32_t cmd;
>> +} __packed;
>> +
>> +struct jzfb {
>> +     struct fb_info *fb;
>> +     struct platform_device *pdev;
>> +     void __iomem *base;
>> +     struct resource *mem;
>> +     struct jz4740_fb_platform_data *pdata;
>> +
>> +     size_t vidmem_size;
>> +     void *vidmem;
>> +     dma_addr_t vidmem_phys;
>> +     struct jzfb_framedesc *framedesc;
>> +     dma_addr_t framedesc_phys;
>> +
>> +     struct clk *ldclk;
>> +     struct clk *lpclk;
>> +
>> +     unsigned is_enabled:1;

Out of curiosity, why the bitfield?

>> +     struct mutex lock;
>> +
>> +     uint32_t pseudo_palette[16];
>> +};
>> +
>> +static const struct fb_fix_screeninfo jzfb_fix __devinitdata = {
>> +     .id             = "JZ4740 FB",
>> +     .type           = FB_TYPE_PACKED_PIXELS,
>> +     .visual         = FB_VISUAL_TRUECOLOR,
>> +     .xpanstep       = 0,
>> +     .ypanstep       = 0,
>> +     .ywrapstep      = 0,
>> +     .accel          = FB_ACCEL_NONE,
>> +};
>> +
>> +static const struct jz_gpio_bulk_request jz_lcd_ctrl_pins[] = {
>> +     JZ_GPIO_BULK_PIN(LCD_PCLK),
>> +     JZ_GPIO_BULK_PIN(LCD_HSYNC),
>> +     JZ_GPIO_BULK_PIN(LCD_VSYNC),
>> +     JZ_GPIO_BULK_PIN(LCD_DE),
>> +     JZ_GPIO_BULK_PIN(LCD_PS),
>> +     JZ_GPIO_BULK_PIN(LCD_REV),
>> +};
>> +
>> +static const struct jz_gpio_bulk_request jz_lcd_data_pins[] = {
>> +     JZ_GPIO_BULK_PIN(LCD_DATA0),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA1),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA2),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA3),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA4),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA5),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA6),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA7),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA8),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA9),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA10),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA11),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA12),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA13),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA14),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA15),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA16),
>> +     JZ_GPIO_BULK_PIN(LCD_DATA17),
>> +};
>> +
>> +static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
>> +{
>> +     unsigned int num;
>> +
>> +     switch (jzfb->pdata->lcd_type) {
>> +     case JZ_LCD_TYPE_GENERIC_16_BIT:
>> +             num = 4;
>> +             break;
>> +     case JZ_LCD_TYPE_GENERIC_18_BIT:
>> +             num = 4;
>> +             break;
>> +     case JZ_LCD_TYPE_8BIT_SERIAL:
>> +             num = 3;
>> +             break;

The lcd type serial looks interesting to me. It'd be nice to have some
descriptive comments so that we know what its used with.

>> +     default:
>> +             num = 0;
>> +             break;
>> +     }
>> +     return num;
>> +}
>> +
>> +static unsigned int jzfb_num_data_pins(struct jzfb *jzfb)
>> +{
>> +     unsigned int num;
>> +
>> +     switch (jzfb->pdata->lcd_type) {
>> +     case JZ_LCD_TYPE_GENERIC_16_BIT:
>> +             num = 16;
>> +             break;
>> +     case JZ_LCD_TYPE_GENERIC_18_BIT:
>> +             num = 18;
>> +             break;
>> +     case JZ_LCD_TYPE_8BIT_SERIAL:
>> +             num = 8;
>> +             break;
>> +     default:
>> +             num = 0;
>> +             break;
>> +     }
>> +     return num;
>> +}
>> +
>> +/* Based on CNVT_TOHW macro from skeletonfb.c */
>> +static inline uint32_t jzfb_convert_color_to_hw(unsigned val,
>> +     struct fb_bitfield *bf)
>> +{
>> +     return (((val << bf->length) + 0x7FFF - val) >> 16) << bf->offset;
>> +}
>> +
>> +static int jzfb_setcolreg(unsigned regno, unsigned red, unsigned green,
>> +                     unsigned blue, unsigned transp, struct fb_info *fb)
>> +{
>> +     uint32_t color;
>> +
>> +     if (regno >= 16)
>> +             return -EINVAL;
>> +
>> +     color = jzfb_convert_color_to_hw(red, &fb->var.red);
>> +     color |= jzfb_convert_color_to_hw(green, &fb->var.green);
>> +     color |= jzfb_convert_color_to_hw(blue, &fb->var.blue);
>> +     color |= jzfb_convert_color_to_hw(transp, &fb->var.transp);
>> +
>> +     ((uint32_t *)(fb->pseudo_palette))[regno] = color;
>> +
>> +     return 0;
>> +}
>> +
>> +static int jzfb_get_controller_bpp(struct jzfb *jzfb)
>> +{
>> +     switch (jzfb->pdata->bpp) {
>> +     case 18:
>> +     case 24:
>> +             return 32;
>> +     case 15:
>> +             return 16;
>> +     default:
>> +             return jzfb->pdata->bpp;
>> +     }
>> +}
>> +
>> +static struct fb_videomode *jzfb_get_mode(struct jzfb *jzfb,
>> +     struct fb_var_screeninfo *var)
>> +{
>> +     size_t i;
>> +     struct fb_videomode *mode = jzfb->pdata->modes;
>> +
>> +     for (i = 0; i < jzfb->pdata->num_modes; ++i, ++mode) {
>> +             if (mode->xres == var->xres && mode->yres == var->yres)
>> +                     return mode;
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static int jzfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb)
>> +{
>> +     struct jzfb *jzfb = fb->par;
>> +     struct fb_videomode *mode;
>> +
>> +     if (var->bits_per_pixel != jzfb_get_controller_bpp(jzfb) &&
>> +             var->bits_per_pixel != jzfb->pdata->bpp)
>> +             return -EINVAL;
>> +
>> +     mode = jzfb_get_mode(jzfb, var);
>> +     if (mode == NULL)
>> +             return -EINVAL;
>> +
>> +     fb_videomode_to_var(var, mode);
>> +
>> +     switch (jzfb->pdata->bpp) {
>> +     case 8:
>> +             break;
>> +     case 15:
>> +             var->red.offset = 10;
>> +             var->red.length = 5;
>> +             var->green.offset = 6;
>> +             var->green.length = 5;
>> +             var->blue.offset = 0;
>> +             var->blue.length = 5;
>> +             break;
>> +     case 16:
>> +             var->red.offset = 11;
>> +             var->red.length = 5;
>> +             var->green.offset = 5;
>> +             var->green.length = 6;
>> +             var->blue.offset = 0;
>> +             var->blue.length = 5;
>> +             break;
>> +     case 18:
>> +             var->red.offset = 16;
>> +             var->red.length = 6;
>> +             var->green.offset = 8;
>> +             var->green.length = 6;
>> +             var->blue.offset = 0;
>> +             var->blue.length = 6;
>> +             var->bits_per_pixel = 32;
>> +             break;
>> +     case 32:
>> +     case 24:
>> +             var->transp.offset = 24;
>> +             var->transp.length = 8;
>> +             var->red.offset = 16;
>> +             var->red.length = 8;
>> +             var->green.offset = 8;
>> +             var->green.length = 8;
>> +             var->blue.offset = 0;
>> +             var->blue.length = 8;
>> +             var->bits_per_pixel = 32;
>> +             break;
>> +     default:
>> +             break;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int jzfb_set_par(struct fb_info *info)
>> +{
>> +     struct jzfb *jzfb = info->par;
>> +     struct fb_var_screeninfo *var = &info->var;
>> +     struct fb_videomode *mode;
>> +     uint16_t hds, vds;
>> +     uint16_t hde, vde;
>> +     uint16_t ht, vt;
>> +     uint32_t ctrl;
>> +     uint32_t cfg;
>> +     unsigned long rate;
>> +
>> +     mode = jzfb_get_mode(jzfb, var);
>> +     if (mode == NULL)
>> +             return -EINVAL;
>> +
>> +     if (mode == info->mode)
>> +             return 0;
>> +
>> +     info->mode = mode;
>> +
>> +     hds = mode->hsync_len + mode->left_margin;
>> +     hde = hds + mode->xres;
>> +     ht = hde + mode->right_margin;
>> +
>> +     vds = mode->vsync_len + mode->upper_margin;
>> +     vde = vds + mode->yres;
>> +     vt = vde + mode->lower_margin;
>> +
>> +     ctrl = JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16;
>> +
>> +     switch (jzfb->pdata->bpp) {
>> +     case 1:
>> +             ctrl |= JZ_LCD_CTRL_BPP_1;
>> +             break;
>> +     case 2:
>> +             ctrl |= JZ_LCD_CTRL_BPP_2;
>> +             break;
>> +     case 4:
>> +             ctrl |= JZ_LCD_CTRL_BPP_4;
>> +             break;
>> +     case 8:
>> +             ctrl |= JZ_LCD_CTRL_BPP_8;
>> +     break;
>> +     case 15:
>> +             ctrl |= JZ_LCD_CTRL_RGB555; /* Falltrough */
>> +     case 16:
>> +             ctrl |= JZ_LCD_CTRL_BPP_15_16;
>> +             break;
>> +     case 18:
>> +     case 24:
>> +     case 32:
>> +             ctrl |= JZ_LCD_CTRL_BPP_18_24;
>> +             break;
>> +     default:
>> +             break;
>> +     }
>> +
>> +     cfg = JZ_LCD_CFG_PS_DISABLE | JZ_LCD_CFG_CLS_DISABLE |
>> +             JZ_LCD_CFG_SPL_DISABLE | JZ_LCD_CFG_REV_DISABLE;
>> +
>> +     if (!(mode->sync & FB_SYNC_HOR_HIGH_ACT))
>> +             cfg |= JZ_LCD_CFG_HSYNC_ACTIVE_LOW;
>> +
>> +     if (!(mode->sync & FB_SYNC_VERT_HIGH_ACT))
>> +             cfg |= JZ_LCD_CFG_VSYNC_ACTIVE_LOW;
>> +
>> +     if (jzfb->pdata->pixclk_falling_edge)
>> +             cfg |= JZ_LCD_CFG_PCLK_FALLING_EDGE;
>> +
>> +     if (jzfb->pdata->date_enable_active_low)
>> +             cfg |= JZ_LCD_CFG_DE_ACTIVE_LOW;
>> +
>> +     if (jzfb->pdata->lcd_type == JZ_LCD_TYPE_GENERIC_18_BIT)
>> +             cfg |= JZ_LCD_CFG_18_BIT;
>> +
>> +     cfg |= jzfb->pdata->lcd_type & 0xf;
>> +
>> +     if (mode->pixclock) {
>> +             rate = PICOS2KHZ(mode->pixclock) * 1000;
>> +             mode->refresh = rate / vt / ht;
>> +     } else {
>> +             if (jzfb->pdata->lcd_type == JZ_LCD_TYPE_8BIT_SERIAL)
>> +                     rate = mode->refresh * (vt + 2 * mode->xres) * ht;
>> +             else
>> +                     rate = mode->refresh * vt * ht;
>> +
>> +             mode->pixclock = KHZ2PICOS(rate / 1000);
>> +     }
>> +
>> +     mutex_lock(&jzfb->lock);
>> +     if (!jzfb->is_enabled)
>> +             clk_enable(jzfb->ldclk);
>> +     else
>> +             ctrl |= JZ_LCD_CTRL_ENABLE;
>> +
>> +     writel(mode->hsync_len, jzfb->base + JZ_REG_LCD_HSYNC);
>> +     writel(mode->vsync_len, jzfb->base + JZ_REG_LCD_VSYNC);
>> +
>> +     writel((ht << 16) | vt, jzfb->base + JZ_REG_LCD_VAT);
>> +
>> +     writel((hds << 16) | hde, jzfb->base + JZ_REG_LCD_DAH);
>> +     writel((vds << 16) | vde, jzfb->base + JZ_REG_LCD_DAV);
>> +
>> +     writel(cfg, jzfb->base + JZ_REG_LCD_CFG);
>> +
>> +     writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
>> +
>> +     if (!jzfb->is_enabled)
>> +             clk_disable(jzfb->ldclk);
>> +
>> +     mutex_unlock(&jzfb->lock);
>> +
>> +     clk_set_rate(jzfb->lpclk, rate);
>> +     clk_set_rate(jzfb->ldclk, rate * 3);
>> +
>> +     return 0;
>> +}
>> +
>> +static void jzfb_enable(struct jzfb *jzfb)
>> +{
>> +     uint32_t ctrl;
>> +
>> +     clk_enable(jzfb->ldclk);
>> +
>> +     jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
>> +     jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
>> +
>> +     writel(0, jzfb->base + JZ_REG_LCD_STATE);
>> +
>> +     writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
>> +
>> +     ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
>> +     ctrl |= JZ_LCD_CTRL_ENABLE;
>> +     ctrl &= ~JZ_LCD_CTRL_DISABLE;
>> +     writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
>> +}
>> +
>> +static void jzfb_disable(struct jzfb *jzfb)
>> +{
>> +     uint32_t ctrl;
>> +
>> +     ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
>> +     ctrl |= JZ_LCD_CTRL_DISABLE;
>> +     writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
>> +     do {
>> +             ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
>> +     } while (!(ctrl & JZ_LCD_STATE_DISABLED));
>> +
>> +     jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
>> +     jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
>> +
>> +     clk_disable(jzfb->ldclk);
>> +}
>> +
>> +static int jzfb_blank(int blank_mode, struct fb_info *info)
>> +{
>> +     struct jzfb *jzfb = info->par;
>> +
>> +     switch (blank_mode) {
>> +     case FB_BLANK_UNBLANK:
>> +             mutex_lock(&jzfb->lock);
>> +             if (jzfb->is_enabled) {
>> +                     mutex_unlock(&jzfb->lock);
>> +                     return 0;
>> +             }
>> +
>> +             jzfb_enable(jzfb);
>> +             jzfb->is_enabled = 1;
>> +
>> +             mutex_unlock(&jzfb->lock);
>> +             break;
>> +     default:
>> +             mutex_lock(&jzfb->lock);
>> +             if (!jzfb->is_enabled) {
>> +                     mutex_unlock(&jzfb->lock);
>> +                     return 0;
>> +             }
>> +
>> +             jzfb_disable(jzfb);
>> +             jzfb->is_enabled = 0;
>> +
>> +             mutex_unlock(&jzfb->lock);
>> +             break;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int jzfb_alloc_devmem(struct jzfb *jzfb)
>> +{
>> +     int max_videosize = 0;
>> +     struct fb_videomode *mode = jzfb->pdata->modes;
>> +     void *page;
>> +     int i;
>> +
>> +     for (i = 0; i < jzfb->pdata->num_modes; ++mode, ++i) {
>> +             if (max_videosize < mode->xres * mode->yres)
>> +                     max_videosize = mode->xres * mode->yres;
>> +     }
>> +
>> +     max_videosize *= jzfb_get_controller_bpp(jzfb) >> 3;
>> +
>> +     jzfb->framedesc = dma_alloc_coherent(&jzfb->pdev->dev,
>> +                                     sizeof(*jzfb->framedesc),
>> +                                     &jzfb->framedesc_phys, GFP_KERNEL);
>> +
>> +     if (!jzfb->framedesc)
>> +             return -ENOMEM;
>> +
>> +     jzfb->vidmem_size = PAGE_ALIGN(max_videosize);
>> +     jzfb->vidmem = dma_alloc_coherent(&jzfb->pdev->dev,
>> +                                     jzfb->vidmem_size,
>> +                                     &jzfb->vidmem_phys, GFP_KERNEL);
>> +
>> +     if (!jzfb->vidmem)
>> +             goto err_free_framedesc;
>> +
>> +     for (page = jzfb->vidmem;
>> +              page < jzfb->vidmem + PAGE_ALIGN(jzfb->vidmem_size);
>> +              page += PAGE_SIZE) {
>> +             SetPageReserved(virt_to_page(page));
>> +     }

It'd be nice to know the reasoning for the SetPageReserved.

Thanks,
jaya
