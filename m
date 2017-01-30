Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2017 17:11:19 +0100 (CET)
Received: from mailout2.samsung.com ([203.254.224.25]:59295 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993869AbdA3QLKKR2Ag (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2017 17:11:10 +0100
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKL020MHOYEDB90@mailout2.samsung.com>; Tue,
 31 Jan 2017 01:11:02 +0900 (KST)
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53])
 by     epcas1p1.samsung.com (KnoxPortal)
 with ESMTP id  20170130161101epcas1p13dfa908b806b2d9fbc1bece37ad40cb8~emI3NlQ7L0372503725epcas1p1k;
        Mon, 30 Jan 2017 16:11:01 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45])
 by     epsmges1p1.samsung.com (Symantec Messaging Gateway)
 with SMTP id   EC.B2.06731.5956F885; Tue, 31 Jan 2017 01:11:01 +0900 (KST)
Received: from epcpsbgm1new.samsung.com
 (u26.gpu120.samsung.co.kr      [203.254.230.26])
 by epcas1p4.samsung.com (KnoxPortal)
 with ESMTP id  20170130161101epcas1p412e5363692ad7413b76f6fdfc628b01a~emI2223AT1119911199epcas1p4a;
        Mon, 30 Jan 2017 16:11:01 +0000 (GMT)
X-AuditID: b6c32a35-f79166d000001a4b-c1-588f659535ac
Received: from epmmp1.local.host ( [203.254.227.16])
 by     epcpsbgm1new.samsung.com (EPCPMTA) with SMTP id 70.79.06487.5956F885; Tue,
        31 Jan 2017 01:11:01 +0900 (KST)
Received: from amdc3058.localnet ([106.120.53.102])
 by mmp1.samsung.com    (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5  2014)) with ESMTPA id <0OKL00F3SOYCKS90@mmp1.samsung.com>; Tue,
 31 Jan 2017    01:11:01 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH v3 12/14] fbdev: jz4740-fb: Let the pinctrl driver
 configure the pins
Date:   Mon, 30 Jan 2017 17:10:59 +0100
Message-id: <4646116.fubHeuC3Nm@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20170125185207.23902-13-paul@crapouillou.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d3XrsPFbZqd1JKGPS1Le/BDIyoqLr0oCpLKdNVFJR9jV8Uk
        UntZIk3LIY1wqcvH0qJpNSstpqlYRq4yCGcGFfZS0axsZrXdCf73Oef3Pd/z4MeSymHan01I
        ThW0yepEFSOn7jQvWrpUL+iilp+uWoEf9ZdS2NjyjMYDJf0kNl0y0rhovJLA7ReGaFxnHEf4
        xb0rDC7QX5Thlr86hO+frJBhh8OM8EjVoAxfe91F4LdNt2RYV26nsP1BMD7T2CLDY/dKKNxW
        u3edL19TUoP46/Zchn9v6UJ8g8Eh4/MbniLeYj7P8D3dDxj+cXUtwdeZsnjTVxvN6791k/yI
        Zc5O733yNUeExIR0Qbtsbaw8Xm8pZjR9IRnfTDHZSBech7xY4FZCZf8EktgPnvfeZPKQnFVy
        VgTNf1o9QS4BL+uuM5MVPbYflIuVXCWClg5a4lEEb+wLXcxwEVCYa3a7+nILwfSp0V1LchU0
        GEoSXOzD7YeB8Rx3LcXNgxpnqVuj4BaB/fZzd34GtwXqm3IJF3txkfCy+iEtaabDr0u9lOQZ
        BE0P9bTES6Cz9QZyDQ2clYWyDgeZh9j/wWywPCKl+TdCUcU7D/vA57Z6mcQBYJ54Q0hcjOCu
        EySfOgTm+wUeUSQ0t3V5mk2DgdF8WvJXwLmzSknCQ0d1leei6+HcxzFCOmI7govjZ4gCFGSY
        soNhyg6GKTtcRaQZ+QkaMSlOEMM0YaGiOklMS44LPZySZEHun7h4lRUVPdtmQxyLVN6Kvs26
        KCWtThePJdkQsKTKV8Ec/p9SHFEfyxS0KTHatERBtKEAllLNVJTnREYpuTh1qnBUEDSCdvKV
        YL38s9HOypwIqzE9qPRDeuHddseefO/dafP7llsWnLKEDy8JPx3t3BSgidU/iUarW4O3rz7k
        a6y+PG2Xs1PuM/wF+4V0/hysrbhzIDgmsIDNGtp69Ld3fN7xg5syRofq5+KIssGJKmZmbOCH
        kFmHMkM/NuyY9z7V6oxu/H6iZkNxqvjqWvccFSXGq8MWk1pR/Q9aNENvhQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t9jAd2pqf0RBlP3SFsceLGQxWL+kXOs
        Fu/mvWC2WDJ5PqvFlD/LmSxO9H1gtdg8/w+jxeVdc9gsJkydxG5x5H8/o8XupmXsFnfvrmK0
        +LziPbvF0usXmSzu79vIbtG/+BKLxaU9Khate4+wW/zcNY/F4vjacAcRjzXz1jB6rL7Uzubx
        ZNNFRo+ds+6ye/TsPMPosWlVJ5vHnWt72DyOrlzL5LF5Sb3HkjeHWD2mvr3G7PF5k1wAT5Sb
        TUZqYkpqkUJqXnJ+SmZeuq1SaIibroWSQl5ibqqtUoSub0iQkkJZYk4pkGdkgAYcnAPcg5X0
        7RLcMqZums5W8EC74u2S+AbGfpUuRk4OCQETiTuHvrFA2GISF+6tZ+ti5OIQEljKKPHh5B1m
        COcro8ThpVtYQarYBKwkJravYgSxRQQ0JJa83AvWwSywjFVi0+bTYAlhgWiJd38awRpYBFQl
        1vxeyAZi8wpoSlzaegEsLirgJbFlXzsTiM0pYC1xZeV+sLiQwAlGiZsfVCHqBSV+TL4Hdh6z
        gLzEvv1TWSFsLYn1O48zTWAUmIWkbBaSsllIyhYwMq9ilEgtSC4oTkrPNcxLLdcrTswtLs1L
        10vOz93ECE4Tz6R2MB7c5X6IUYCDUYmHNwKYPoRYE8uKK3MPMUpwMCuJ8LIlA4V4UxIrq1KL
        8uOLSnNSiw8xmgI9OJFZSjQ5H5jC8kriDU3MTcyNDSzMLS1NjJTEeRtnPwsXEkhPLEnNTk0t
        SC2C6WPi4JRqYGyaG33lYtPvZed32zgtyG9QfPu07WRv9lLPSoOIlbKNMdtPP94oudXOcfP7
        NlHeuc9PFc1hsjXN37fwnOexB9u3/LzR6xwaHX8yz3varTnCpZ835XK0WFwXetYV1Pq1S64k
        U3VlcMHMB2/uyEwvMzzJLPnqZPnhnOWtWUu03Lb6xCnt8F7snK3EUpyRaKjFXFScCAC6stLu
        KQMAAA==
X-MTR:  20000000000000000@CPGS
X-CMS-MailID: 20170130161101epcas1p412e5363692ad7413b76f6fdfc628b01a
X-Msg-Generator: CA
X-Sender-IP: 203.254.230.26
X-Local-Sender: =?UTF-8?B?QmFydGxvbWllaiBab2xuaWVya2lld2ljehtTUlBPTC1LZXJu?=
        =?UTF-8?B?ZWwgKFRQKRvsgrzshLHsoITsnpAbU2VuaW9yIFNvZnR3YXJlIEVuZ2luZWVy?=
X-Global-Sender: =?UTF-8?B?QmFydGxvbWllaiBab2xuaWVya2lld2ljehtTUlBPTC1LZXJu?=
        =?UTF-8?B?ZWwgKFRQKRtTYW1zdW5nIEVsZWN0cm9uaWNzG1NlbmlvciBTb2Z0d2FyZSBF?=
        =?UTF-8?B?bmdpbmVlcg==?=
X-Sender-Code: =?UTF-8?B?QzEwG0VIURtDMTBDRDAyQ0QwMjczOTI=?=
CMS-TYPE: 101P
X-HopCount: 7
X-CMS-RootMailID: 20170125185254epcas5p15b40cad57649dc77afe8d2fd316687ff
X-RootMTR: 20170125185254epcas5p15b40cad57649dc77afe8d2fd316687ff
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <CGME20170125185254epcas5p15b40cad57649dc77afe8d2fd316687ff@epcas5p1.samsung.com>
 <20170125185207.23902-13-paul@crapouillou.net>
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: b.zolnierkie@samsung.com
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


Hi,

On Wednesday, January 25, 2017 07:52:05 PM Paul Cercueil wrote:
> Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
> the pins being properly configured before the driver probes.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/jz4740_fb.c | 104 ++--------------------------------------
>  1 file changed, 3 insertions(+), 101 deletions(-)
> 
> v2: No changes
> v3: No changes
> 
> diff --git a/drivers/video/fbdev/jz4740_fb.c b/drivers/video/fbdev/jz4740_fb.c
> index 87790e9644d0..b57df83fdbd3 100644
> --- a/drivers/video/fbdev/jz4740_fb.c
> +++ b/drivers/video/fbdev/jz4740_fb.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> @@ -27,7 +28,6 @@
>  #include <linux/dma-mapping.h>
>  
>  #include <asm/mach-jz4740/jz4740_fb.h>
> -#include <asm/mach-jz4740/gpio.h>
>  
>  #define JZ_REG_LCD_CFG		0x00
>  #define JZ_REG_LCD_VSYNC	0x04
> @@ -146,93 +146,6 @@ static const struct fb_fix_screeninfo jzfb_fix = {
>  	.accel		= FB_ACCEL_NONE,
>  };
>  
> -static const struct jz_gpio_bulk_request jz_lcd_ctrl_pins[] = {
> -	JZ_GPIO_BULK_PIN(LCD_PCLK),
> -	JZ_GPIO_BULK_PIN(LCD_HSYNC),
> -	JZ_GPIO_BULK_PIN(LCD_VSYNC),
> -	JZ_GPIO_BULK_PIN(LCD_DE),
> -	JZ_GPIO_BULK_PIN(LCD_PS),
> -	JZ_GPIO_BULK_PIN(LCD_REV),
> -	JZ_GPIO_BULK_PIN(LCD_CLS),
> -	JZ_GPIO_BULK_PIN(LCD_SPL),
> -};
> -
> -static const struct jz_gpio_bulk_request jz_lcd_data_pins[] = {
> -	JZ_GPIO_BULK_PIN(LCD_DATA0),
> -	JZ_GPIO_BULK_PIN(LCD_DATA1),
> -	JZ_GPIO_BULK_PIN(LCD_DATA2),
> -	JZ_GPIO_BULK_PIN(LCD_DATA3),
> -	JZ_GPIO_BULK_PIN(LCD_DATA4),
> -	JZ_GPIO_BULK_PIN(LCD_DATA5),
> -	JZ_GPIO_BULK_PIN(LCD_DATA6),
> -	JZ_GPIO_BULK_PIN(LCD_DATA7),
> -	JZ_GPIO_BULK_PIN(LCD_DATA8),
> -	JZ_GPIO_BULK_PIN(LCD_DATA9),
> -	JZ_GPIO_BULK_PIN(LCD_DATA10),
> -	JZ_GPIO_BULK_PIN(LCD_DATA11),
> -	JZ_GPIO_BULK_PIN(LCD_DATA12),
> -	JZ_GPIO_BULK_PIN(LCD_DATA13),
> -	JZ_GPIO_BULK_PIN(LCD_DATA14),
> -	JZ_GPIO_BULK_PIN(LCD_DATA15),
> -	JZ_GPIO_BULK_PIN(LCD_DATA16),
> -	JZ_GPIO_BULK_PIN(LCD_DATA17),
> -};
> -
> -static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
> -{
> -	unsigned int num;
> -
> -	switch (jzfb->pdata->lcd_type) {
> -	case JZ_LCD_TYPE_GENERIC_16_BIT:
> -		num = 4;
> -		break;
> -	case JZ_LCD_TYPE_GENERIC_18_BIT:
> -		num = 4;
> -		break;
> -	case JZ_LCD_TYPE_8BIT_SERIAL:
> -		num = 3;
> -		break;
> -	case JZ_LCD_TYPE_SPECIAL_TFT_1:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_2:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_3:
> -		num = 8;
> -		break;
> -	default:
> -		num = 0;
> -		break;
> -	}
> -	return num;
> -}
> -
> -static unsigned int jzfb_num_data_pins(struct jzfb *jzfb)
> -{
> -	unsigned int num;
> -
> -	switch (jzfb->pdata->lcd_type) {
> -	case JZ_LCD_TYPE_GENERIC_16_BIT:
> -		num = 16;
> -		break;
> -	case JZ_LCD_TYPE_GENERIC_18_BIT:
> -		num = 18;
> -		break;
> -	case JZ_LCD_TYPE_8BIT_SERIAL:
> -		num = 8;
> -		break;
> -	case JZ_LCD_TYPE_SPECIAL_TFT_1:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_2:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_3:
> -		if (jzfb->pdata->bpp == 18)
> -			num = 18;
> -		else
> -			num = 16;
> -		break;
> -	default:
> -		num = 0;
> -		break;
> -	}
> -	return num;
> -}
> -
>  /* Based on CNVT_TOHW macro from skeletonfb.c */
>  static inline uint32_t jzfb_convert_color_to_hw(unsigned val,
>  	struct fb_bitfield *bf)
> @@ -487,8 +400,7 @@ static void jzfb_enable(struct jzfb *jzfb)
>  
>  	clk_prepare_enable(jzfb->ldclk);
>  
> -	jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +	pinctrl_pm_select_default_state(&jzfb->pdev->dev);
>  
>  	writel(0, jzfb->base + JZ_REG_LCD_STATE);
>  
> @@ -511,8 +423,7 @@ static void jzfb_disable(struct jzfb *jzfb)
>  		ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
>  	} while (!(ctrl & JZ_LCD_STATE_DISABLED));
>  
> -	jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +	pinctrl_pm_select_sleep_state(&jzfb->pdev->dev);
>  
>  	clk_disable_unprepare(jzfb->ldclk);
>  }
> @@ -701,9 +612,6 @@ static int jzfb_probe(struct platform_device *pdev)
>  	fb->mode = NULL;
>  	jzfb_set_par(fb);
>  
> -	jz_gpio_bulk_request(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_request(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> -
>  	ret = register_framebuffer(fb);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register framebuffer: %d\n", ret);
> @@ -715,9 +623,6 @@ static int jzfb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_devmem:
> -	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> -
>  	fb_dealloc_cmap(&fb->cmap);
>  	jzfb_free_devmem(jzfb);
>  err_framebuffer_release:
> @@ -731,9 +636,6 @@ static int jzfb_remove(struct platform_device *pdev)
>  
>  	jzfb_blank(FB_BLANK_POWERDOWN, jzfb->fb);
>  
> -	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> -
>  	fb_dealloc_cmap(&jzfb->fb->cmap);
>  	jzfb_free_devmem(jzfb);
