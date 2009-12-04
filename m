Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 15:48:08 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43136 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493126AbZLDOsC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 15:48:02 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7C59DF0463; Fri,  4 Dec 2009 15:48:01 +0100 (CET)
Date:   Fri, 4 Dec 2009 09:11:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org, luming.yu@intel.com
Subject: Re: [PATCH v7 6/8] Loongson: YeeLoong: add video output driver
Message-ID: <20091204081124.GC1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com> <5fd87c1f64a3c6d3e51fc6b0224cc1be3cb0d9d5.1259932036.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd87c1f64a3c6d3e51fc6b0224cc1be3cb0d9d5.1259932036.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Fri 2009-12-04 21:36:43, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds Video Output Driver, it provides standard
> interface(/sys/class/video_output) to turn on/off the video output of
> LCD, CRT.
> 

> diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
> index 9c8385c..4a89c01 100644
> --- a/drivers/platform/mips/Kconfig
> +++ b/drivers/platform/mips/Kconfig
> @@ -21,6 +21,7 @@ config LEMOTE_YEELOONG2F
>  	select SYS_SUPPORTS_APM_EMULATION
>  	select APM_EMULATION
>  	select HWMON
> +	select VIDEO_OUTPUT_CONTROL
>  	default m
>  	help
>  	  YeeLoong netbook is a mini laptop made by Lemote, which is basically

default m is evil.

> +	if (status == BIT_DISPLAY_LCD_ON) {
> +		/* Turn on LCD */
> +		outb(0x31, 0x3c4);
> +		value = inb(0x3c5);
> +		value = (value & 0xf8) | 0x03;
> +		outb(0x31, 0x3c4);
> +		outb(value, 0x3c5);
> +		/* Turn on backlight */
> +		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_ON);
> +	} else {
> +		/* Turn off backlight */
> +		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_OFF);
> +		/* Turn off LCD */
> +		outb(0x31, 0x3c4);
> +		value = inb(0x3c5);
> +		value = (value & 0xf8) | 0x02;
> +		outb(0x31, 0x3c4);
> +		outb(value, 0x3c5);
> +	}

IIRC this is opencoded in suspend support; should that get common
helpers?

> +	if (status == BIT_CRT_DETECT_PLUG) {
> +		if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_PLUG) {
> +			/* Turn on CRT */
> +			outb(0x21, 0x3c4);
> +			value = inb(0x3c5);
> +			value &= ~(1 << 7);
> +			outb(0x21, 0x3c4);
> +			outb(value, 0x3c5);
> +		}
> +	} else {
> +		/* Turn off CRT */
> +		outb(0x21, 0x3c4);
> +		value = inb(0x3c5);
> +		value |= (1 << 7);
> +		outb(0x21, 0x3c4);
> +		outb(value, 0x3c5);
> +	}

This looks suspiciously similar to one another and to code
above. Perhaps some more helpers?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
