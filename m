Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 16:20:28 +0100 (BST)
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:36020 "EHLO
	smtp239.poczta.interia.pl") by ftp.linux-mips.org with ESMTP
	id S20022262AbYHEPUW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 16:20:22 +0100
Received: by smtp239.poczta.interia.pl (INTERIA.PL, from userid 502)
	id 535EB296B48; Tue,  5 Aug 2008 17:20:21 +0200 (CEST)
Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 9495129645E;
	Tue,  5 Aug 2008 17:20:20 +0200 (CEST)
Received: by poczta.interia.pl (INTERIA.PL, from userid 502)
	id 90BA62BC175; Tue,  5 Aug 2008 17:20:20 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 0CF7C2BC150;
	Tue,  5 Aug 2008 17:20:14 +0200 (CEST)
Date:	Tue, 5 Aug 2008 17:25:47 +0200
From:	Krzysztof Helt <krzysztof.h1@poczta.fm>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-fbdev-devel@lists.sf.net, L-M-O <linux-mips@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] au1200fb: make framebuffer config
 runtime selectable.
Message-Id: <20080805172547.e81c35d3.krzysztof.h1@poczta.fm>
In-Reply-To: <20080805124522.GB27469@roarinelk.homelinux.net>
References: <20080805124221.GA27469@roarinelk.homelinux.net>
	<20080805124522.GB27469@roarinelk.homelinux.net>
X-Mailer: Sylpheed 2.4.3 (GTK+ 2.11.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-EMID:	5ae2b138
Return-Path: <krzysztof.h1@poczta.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzysztof.h1@poczta.fm
Precedence: bulk
X-list: linux-mips

On Tue, 5 Aug 2008 14:45:22 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Make the number of framebuffer windows and the window configuration
> selectable at the kernel commandline instead of hardcoding it
> in the kernel config.
> 
> This patch does not directly depend on the previous one ("au1200fb: fixup PM
> support"), but it only applies cleanly on top of it.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/video/au1200fb.c |   55 ++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
> index be945ab..7127aa7 100644
> --- a/drivers/video/au1200fb.c
> +++ b/drivers/video/au1200fb.c
> @@ -45,10 +45,6 @@
>  #include <asm/mach-au1x00/au1000.h>
>  #include "au1200fb.h"
>  
> -#ifndef CONFIG_FB_AU1200_DEVS
> -#define CONFIG_FB_AU1200_DEVS 4
> -#endif
> -
>  #define DRIVER_NAME "au1200fb"
>  #define DRIVER_DESC "LCD controller driver for AU1200 processors"
>  
> @@ -153,7 +149,7 @@ struct au1200fb_device {
>  	dma_addr_t    		fb_phys;
>  };
>  
> -static struct au1200fb_device _au1200fb_devices[CONFIG_FB_AU1200_DEVS];
> +static struct au1200fb_device _au1200fb_devices[4];

Please use the constant here.

>  /********************************************************************/
>  
>  /* LCD controller restrictions */
> @@ -166,10 +162,17 @@ static struct au1200fb_device _au1200fb_devices[CONFIG_FB_AU1200_DEVS];
>  /* Default number of visible screen buffer to allocate */
>  #define AU1200FB_NBR_VIDEO_BUFFERS 1
>  
> +/* Default number of fb devices to create */
> +#define DEFAULT_DEVICE_COUNT	4
> +

This one can be renamed to MAX_DEVICE_COUNT and used in the declaration
above and various checks. There is nothing wrong with the default value being
the maximum value.

> +/* Default window configuration entry to use (see windows[]) */
> +#define DEFAULT_WINDOW_INDEX	2
> +
>  /********************************************************************/
>  
>  static struct au1200_lcd *lcd = (struct au1200_lcd *) AU1200_LCD_ADDR;
> -static int window_index = 2; /* default is zero */
> +static int device_count = DEFAULT_DEVICE_COUNT;	/* number of fb devices to create */
> +static int window_index = DEFAULT_WINDOW_INDEX;	/* default is zero */
>  static int panel_index = 2; /* default is zero */
>  static struct window_settings *win;
>  static struct panel_settings *panel;
> @@ -682,7 +685,7 @@ static int fbinfo2index (struct fb_info *fb_info)
>  {
>  	int i;
>  
> -	for (i = 0; i < CONFIG_FB_AU1200_DEVS; ++i) {
> +	for (i = 0; i < device_count; ++i) {
>  		if (fb_info == (struct fb_info *)(&_au1200fb_devices[i].fb_info))
>  			return i;
>  	}
> @@ -1594,7 +1597,7 @@ static int au1200fb_drv_probe(struct platform_device *pdev)
>  	/* Kickstart the panel */
>  	au1200_setpanel(panel);
>  
> -	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) {
> +	for (plane = 0; plane < device_count; ++plane) {
>  		bpp = winbpp(win->w[plane].mode_winctrl1);
>  		if (win->w[plane].xres == 0)
>  			win->w[plane].xres = panel->Xres;
> @@ -1686,7 +1689,7 @@ static int au1200fb_drv_remove(struct platform_device *pdev)
>  	/* Turn off the panel */
>  	au1200_setpanel(NULL);
>  
> -	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane)
> +	for (plane = 0; plane < device_count; ++plane)
>  	{
>  		fbdev = &_au1200fb_devices[plane];
>  
> @@ -1727,7 +1730,7 @@ static int au1200fb_drv_resume(struct platform_device *pdev)
>  	/* Kickstart the panel */
>  	au1200_setpanel(panel);
>  
> -	for (i = 0; i < CONFIG_FB_AU1200_DEVS; i++) {
> +	for (i = 0; i < device_count; i++) {
>  		fbdev = &_au1200fb_devices[i];
>  		au1200fb_fb_set_par(&fbdev->fb_info);
>  	}
> @@ -1754,10 +1757,10 @@ static struct platform_driver au1200fb_driver = {
>  
>  /* Kernel driver */
>  
> -static void au1200fb_setup(void)
> +static int au1200fb_setup(void)
>  {
> -	char* options = NULL;
> -	char* this_opt;
> +	char *options = NULL;
> +	char *this_opt, *endptr;
>  	int num_panels = ARRAY_SIZE(known_lcd_panels);
>  	int panel_idx = -1;
>  
> @@ -1802,12 +1805,29 @@ static void au1200fb_setup(void)
>  				nohwcursor = 1;
>  			}
>  
> +			else if (strncmp(this_opt, "devices:", 8) == 0) {
> +				this_opt += 8;
> +				device_count = simple_strtol(this_opt, &endptr, 0);
> +				if ((device_count < 0) || (device_count > 4))
> +					device_count = DEFAULT_DEVICE_COUNT;
> +			}
> +
> +			else if (strncmp(this_opt, "wincfg:", 7) == 0) {
> +				this_opt += 7;
> +				window_index = simple_strtol(this_opt, &endptr, 0);
> +				if ((window_index < 0) || (window_index >= ARRAY_SIZE(windows)))
> +					window_index = DEFAULT_WINDOW_INDEX;
> +			}
> +
> +			else if (strncmp(this_opt, "off", 3) == 0)
> +				return 1;
>  			/* Unsupported option */
>  			else {
>  				print_warn("Unsupported option \"%s\"", this_opt);
>  			}
>  		}
>  	}
> +	return 0;
>  }
>  
>  static int __init au1200fb_init(void)
> @@ -1815,7 +1835,14 @@ static int __init au1200fb_init(void)
>  	print_info("" DRIVER_DESC "");
>  
>  	/* Setup driver with options */
> -	au1200fb_setup();
> +	if (au1200fb_setup())
> +		return -ENODEV;
> +
> +	if ((device_count < 0) || (device_count > 4))
> +		device_count = DEFAULT_DEVICE_COUNT;
> +

The au1200fb_setup does this check before so it is not needed
to repeat it.

The patch looks fine otherwise.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Te newsy nakreca Cie na caly dzien!
Sprawdz >>> http://link.interia.pl/f1e94
