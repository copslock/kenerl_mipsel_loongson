Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 22:06:04 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:46141 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491941Ab0FBUGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 22:06:00 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 6C1B19AE;
        Wed,  2 Jun 2010 22:05:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id V8NA+M-YuJRL; Wed,  2 Jun 2010 22:05:54 +0200 (CEST)
Received: from [192.168.37.31] (port-91163.pppoe.wtnet.de [84.46.68.144])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id DC0E19AD;
        Wed,  2 Jun 2010 22:05:41 +0200 (CEST)
Message-ID: <4C06B974.5010905@metafoo.de>
Date:   Wed, 02 Jun 2010 22:05:08 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [RFC][PATCH 16/26] fbdev: Add JZ4740 framebuffer driver
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505832-17185-8-git-send-email-lars@metafoo.de> <20100602123657.e197990b.akpm@linux-foundation.org>
In-Reply-To: <20100602123657.e197990b.akpm@linux-foundation.org>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1696

Andrew Morton wrote:
> On Wed,  2 Jun 2010 21:10:32 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>   
>> This patch adds support for the LCD controller on JZ4740 SoCs.
>>
>>
>> ...
>>
>> +struct jzfb_framedesc {
>> +	uint32_t next;
>> +	uint32_t addr;
>> +	uint32_t id;
>> +	uint32_t cmd;
>> +} __attribute__((packed));
>>     
>
> We have a little __packed helper.  
>
>   
Ok.
>> ...
>>
>> +static int jzfb_setcolreg(unsigned regno, unsigned red, unsigned green,
>> +			unsigned blue, unsigned transp, struct fb_info *fb)
>> +{
>> +	uint32_t color;
>> +
>> +	if (regno >= 16)
>> +		return -EINVAL;
>> +
>> +	color = jzfb_convert_color_to_hw(red, fb->var.red.length);
>> +	color |= jzfb_convert_color_to_hw(green, fb->var.green.length);
>> +	color |= jzfb_convert_color_to_hw(blue, fb->var.blue.length);
>> +	color |= jzfb_convert_color_to_hw(transp, fb->var.transp.length);
>> +
>> +	((uint32_t *)(fb->pseudo_palette))[regno] = color;
>>     
>
> The typecast apepars to be unneeded.  If it _was_ needed then this code
> would look rather fishy from an endianness POV.
>
>   
It is needed, because the pseudo_palette member of struct fb_info is a
void pointer.
>> +	return 0;
>> +}
>> +
>>
>> ...
>>
>> +static int __devinit jzfb_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct jzfb *jzfb;
>> +	struct fb_info *fb;
>> +	struct jz4740_fb_platform_data *pdata = pdev->dev.platform_data;
>> +	struct resource *mem;
>> +
>> +	if (!pdata) {
>> +		dev_err(&pdev->dev, "Missing platform data\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!mem) {
>> +		dev_err(&pdev->dev, "Failed to get register memory resource\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	mem = request_mem_region(mem->start, resource_size(mem), pdev->name);
>> +	if (!mem) {
>> +		dev_err(&pdev->dev, "Failed to request register memory region\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	fb = framebuffer_alloc(sizeof(struct jzfb), &pdev->dev);
>> +	if (!fb) {
>> +		dev_err(&pdev->dev, "Failed to allocate framebuffer device\n");
>> +		ret = -ENOMEM;
>> +		goto err_release_mem_region;
>> +	}
>> +
>> +	fb->fbops = &jzfb_ops;
>> +	fb->flags = FBINFO_DEFAULT;
>> +
>> +	jzfb = fb->par;
>> +	jzfb->pdev = pdev;
>> +	jzfb->pdata = pdata;
>> +	jzfb->mem = mem;
>> +
>> +	jzfb->ldclk = clk_get(&pdev->dev, "lcd");
>> +	if (IS_ERR(jzfb->ldclk)) {
>> +		ret = PTR_ERR(jzfb->ldclk);
>> +		dev_err(&pdev->dev, "Failed to get lcd clock: %d\n", ret);
>> +		goto err_framebuffer_release;
>> +	}
>> +
>> +	jzfb->lpclk = clk_get(&pdev->dev, "lcd_pclk");
>> +	if (IS_ERR(jzfb->lpclk)) {
>> +		ret = PTR_ERR(jzfb->lpclk);
>> +		dev_err(&pdev->dev, "Failed to get lcd pixel clock: %d\n", ret);
>> +		goto err_put_ldclk;
>> +	}
>> +
>> +	jzfb->base = ioremap(mem->start, resource_size(mem));
>> +
>> +	if (!jzfb->base) {
>> +		dev_err(&pdev->dev, "Failed to ioremap register memory region\n");
>> +		ret = -EBUSY;
>> +		goto err_put_lpclk;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, jzfb);
>> +
>> +	fb_videomode_to_modelist(pdata->modes, pdata->num_modes,
>> +				 &fb->modelist);
>> +	fb->mode = pdata->modes;
>> +
>> +	fb_videomode_to_var(&fb->var, fb->mode);
>> +	fb->var.bits_per_pixel = pdata->bpp;
>> +	jzfb_check_var(&fb->var, fb);
>> +
>> +	ret = jzfb_alloc_devmem(jzfb);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to allocate video memory\n");
>> +		goto err_iounmap;
>> +	}
>> +
>> +	fb->fix = jzfb_fix;
>> +	fb->fix.line_length = fb->var.bits_per_pixel * fb->var.xres / 8;
>> +	fb->fix.mmio_start = mem->start;
>> +	fb->fix.mmio_len = resource_size(mem);
>> +	fb->fix.smem_start = jzfb->vidmem_phys;
>> +	fb->fix.smem_len =  fb->fix.line_length * fb->var.yres;
>> +	fb->screen_base = jzfb->vidmem;
>> +	fb->pseudo_palette = jzfb->pseudo_palette;
>> +
>> +	fb_alloc_cmap(&fb->cmap, 256, 0);
>> +
>> +	mutex_init(&jzfb->lock);
>>     
>
> I'd suggest initializing the mutex much earlier.  THings like
> jzfb_check_var() and jzfb_alloc_devmem() don't currently take that
> lock, but who knows what might happen in the future..
>
>   
Hm, ok.
>> +	clk_enable(jzfb->ldclk);
>> +	jzfb->is_enabled = 1;
>> +
>> +	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
>> +	jzfb_set_par(fb);
>> +
>> +	jz_gpio_bulk_request(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
>> +	jz_gpio_bulk_request(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
>> +
>> +	ret = register_framebuffer(fb);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to register framebuffer: %d\n", ret);
>> +		goto err_free_devmem;
>> +	}
>> +
>> +	jzfb->fb = fb;
>> +
>> +	return 0;
>> +
>> +err_free_devmem:
>> +	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
>> +	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
>> +
>> +	fb_dealloc_cmap(&fb->cmap);
>> +	jzfb_free_devmem(jzfb);
>> +err_iounmap:
>> +	iounmap(jzfb->base);
>> +err_put_lpclk:
>> +	clk_put(jzfb->lpclk);
>> +err_put_ldclk:
>> +	clk_put(jzfb->ldclk);
>> +err_framebuffer_release:
>> +	framebuffer_release(fb);
>> +err_release_mem_region:
>> +	release_mem_region(mem->start, resource_size(mem));
>> +	return ret;
>> +}
>> +
>>
>> ...
>>
>>     
>
>   
