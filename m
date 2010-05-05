Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 14:15:30 +0200 (CEST)
Received: from hull.simtec.co.uk ([78.105.113.97]:55871 "EHLO
        preston.local.simtec.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491199Ab0EEMP0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 14:15:26 +0200
Received: from [192.168.101.34]
        by preston.local.simtec.co.uk with esmtp (Exim 4.69)
        (envelope-from <ben@simtec.co.uk>)
        id 1O9dVZ-0002mE-8d; Wed, 05 May 2010 13:15:21 +0100
Message-ID: <4BE1614D.1090008@simtec.co.uk>
Date:   Wed, 05 May 2010 21:15:09 +0900
From:   Ben Dooks <ben@simtec.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
MIME-Version: 1.0
To:     yajin <yajinzhou@vm-kernel.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 10/12] add the sm501fb option to sm501 fb driver
References: <r2l180e2c241005040255mff483747jcef507aadea0cabd@mail.gmail.com>
In-Reply-To: <r2l180e2c241005040255mff483747jcef507aadea0cabd@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <ben@simtec.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@simtec.co.uk
Precedence: bulk
X-list: linux-mips

On 04/05/10 18:55, yajin wrote:
> Currently the sm501 mode can only be fetched from modedb.c.
> Unfortunately the modes in modedb.c are not complete. For example it
> lacks the resolution of 1024x600. So the sm501 fb driver should have
> the ability to accept the mode option from linux command line.

Why not get this added to the main mode database instead of
adding a new one into the sm501 driver?

Secondly, why isn't this on the framebuffer list or linux-kernel?

> Signed-off-by: yajin <yajin@vm-kernel.org>
> ---
>  drivers/video/sm501fb.c |   67 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
> index b7dc180..f2c69ca 100644
> --- a/drivers/video/sm501fb.c
> +++ b/drivers/video/sm501fb.c
> @@ -43,6 +43,37 @@
> 
>  #define NR_PALETTE	256
> 
> +static char *mode_option;
> +module_param_named(mode, mode_option, charp, 0);
> +MODULE_PARM_DESC(mode, "Initial mode");
> +
> +/*
> + * SM501 Mode
> + *    1024X600 is not defined in default mode(modedb.c).
> + */
> +static const struct fb_videomode sm501_modedb[] __initdata = {
> + {
> +	/* 1024x600-60 */
> +	NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
> +  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
> + },
> + {
> +	 /* 1024x600-70 */
> +	 NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
> +  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
> + },
> + {
> +	 /* 1024x600-75 */
> +	 NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
> +  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
> + },
> + {
> +	 /* 1024x600-85 */
> +	 NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
> +  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
> + }
> +};
> +
>  enum sm501_controller {
>  	HEAD_CRT	= 0,
>  	HEAD_PANEL	= 1,
> @@ -1729,8 +1760,16 @@ static int sm501fb_init_fb(struct fb_info *fb,
>  			fb->var.xres_virtual = fb->var.xres;
>  			fb->var.yres_virtual = fb->var.yres;
>  		} else {
> -			ret = fb_find_mode(&fb->var, fb,
> -					   NULL, NULL, 0, NULL, 8);
> +			if (mode_option) {
> +				dev_info(info->dev, "using user defined mode:"
> +						" %s\n", mode_option);
> +				ret = fb_find_mode(&fb->var, fb,
> +						mode_option, sm501_modedb,
> +						ARRAY_SIZE(sm501_modedb),
> +						NULL, fb->var.bits_per_pixel);
> +			} else
> +				ret = fb_find_mode(&fb->var, fb,
> +						NULL, NULL, 0, NULL, 8);
> 
>  			if (ret == 0 || ret == 4) {
>  				dev_err(info->dev,
> @@ -2136,8 +2175,32 @@ static struct platform_driver sm501fb_driver = {
>  	},
>  };
> 
> +#ifndef MODULE
> +static int  __devinit sm501fb_setup(char *options)
> +{
> +	char *this_opt;
> +
> +	if (!options || !*options)
> +		return 0;
> +
> +	while ((this_opt = strsep(&options, ",")) != NULL) {
> +		if (!*this_opt)
> +			continue;
> +		mode_option = this_opt;
> +	}
> +	return 0;
> +}
> +#endif
> +
>  static int __devinit sm501fb_init(void)
>  {
> +#ifndef MODULE
> +	char *option = NULL;
> +
> +	if (fb_get_options("sm501fb", &option))
> +		return -ENODEV;
> +	sm501fb_setup(option);
> +#endif
>  	return platform_driver_register(&sm501fb_driver);
>  }
> 
