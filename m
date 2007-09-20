Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 17:40:23 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:202 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023048AbXITQkV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 17:40:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8KGeKHU003310;
	Thu, 20 Sep 2007 17:40:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8KGeK7A003309;
	Thu, 20 Sep 2007 17:40:20 +0100
Date:	Thu, 20 Sep 2007 17:40:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][5/6] led: add Cobalt Qube series front LED support to
	platform register
Message-ID: <20070920164020.GF5522@linux-mips.org>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp> <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp> <20070920230513.1dbb1d6d.yoichi_yuasa@tripeaks.co.jp> <20070920230656.640886f5.yoichi_yuasa@tripeaks.co.jp> <20070920230841.5e4b0a05.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070920230841.5e4b0a05.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 20, 2007 at 11:08:41PM +0900, Yoichi Yuasa wrote:

> Add Cobalt Qube series front LED support to platform register.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/led.c mips/arch/mips/cobalt/led.c
> --- mips-orig/arch/mips/cobalt/led.c	2007-09-12 13:48:40.740621250 +0900
> +++ mips/arch/mips/cobalt/led.c	2007-09-12 13:47:59.474042250 +0900
> @@ -22,6 +22,8 @@
>  #include <linux/ioport.h>
>  #include <linux/platform_device.h>
>  
> +#include <cobalt.h>
> +
>  static struct resource cobalt_led_resource __initdata = {
>  	.start	= 0x1c000000,
>  	.end	= 0x1c000000,
> @@ -33,7 +35,11 @@ static __init int cobalt_led_add(void)
>  	struct platform_device *pdev;
>  	int retval;
>  
> -	pdev = platform_device_alloc("Cobalt Raq LEDs", -1);
> +	if (cobalt_board_id == COBALT_BRD_ID_QUBE1 ||
> +	    cobalt_board_id == COBALT_BRD_ID_QUBE2)
> +		pdev = platform_device_alloc("Cobalt Qube LEDs", -1);
> +	else
> +		pdev = platform_device_alloc("Cobalt Raq LEDs", -1);

Same thing - can you make that string something all lowercase without
spaces?

>  
>  	if (!pdev)
>  		return -ENOMEM;

  Ralf
