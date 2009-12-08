Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 07:54:54 +0100 (CET)
Received: from mail-iw0-f180.google.com ([209.85.223.180]:38911 "EHLO
        mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491036AbZLHGyv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 07:54:51 +0100
Received: by iwn10 with SMTP id 10so3633109iwn.22
        for <multiple recipients>; Mon, 07 Dec 2009 22:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ERSqZNqGRLDEztAuCsjgwAa6Elbvg8DH51MUNB+ANCE=;
        b=x0RKevPUTEstUql19qwS1uA1FmTrAag64MkfZ5NGY7L24k70mSrR1LhmVNmE9gVLia
         ZLUt7Hwa1oBBEMfVfYhaOv/3gjlyWLWhbj0ofJXaSv4ejDLOniYcezqgxqlNhSVsnArx
         gjtrxzIes+V8cmTCQZx4HxAB+y7Dz+I+6ctEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Wf6EDkUL+Ca3/OrrN9m7sGkODkDYhCekuC5YmorgnFyyE7N7rR0Rb1IWaUvotRl6bQ
         o2xtwL46HhrBKGnFqiKD+x7SI5t3EpbQdbG31poqYsKnulpDZtb+szspFlOifzEyi4B1
         n5gpIXsXq+qBlGiU/AD2SWKvzQav/6JgD0Bxg=
Received: by 10.231.20.230 with SMTP id g38mr192267ibb.49.1260255280571;
        Mon, 07 Dec 2009 22:54:40 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3959054iwn.13.2009.12.07.22.54.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 22:54:39 -0800 (PST)
Subject: Re: [PATCH v7 6/8] Loongson: YeeLoong: add video output driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        zhangfx@lemote.com, linux-laptop@vger.kernel.org,
        luming.yu@intel.com
In-Reply-To: <5fd87c1f64a3c6d3e51fc6b0224cc1be3cb0d9d5.1259932036.git.wuzhangjin@gmail.com>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
         <5fd87c1f64a3c6d3e51fc6b0224cc1be3cb0d9d5.1259932036.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 14:54:08 +0800
Message-ID: <1260255248.3315.28.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Pavel

Can I get your Acked-by: for this patch?

Thanks!
	Wu Zhangjin

On Fri, 2009-12-04 at 21:36 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds Video Output Driver, it provides standard
> interface(/sys/class/video_output) to turn on/off the video output of
> LCD, CRT.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  drivers/platform/mips/Kconfig           |    1 +
>  drivers/platform/mips/yeeloong_laptop.c |  147 +++++++++++++++++++++++++++++++
>  2 files changed, 148 insertions(+), 0 deletions(-)
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
> diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
> index 644aaa7..8378926 100644
> --- a/drivers/platform/mips/yeeloong_laptop.c
> +++ b/drivers/platform/mips/yeeloong_laptop.c
> @@ -16,6 +16,7 @@
>  #include <linux/apm-emulation.h>/* for battery subdriver */
>  #include <linux/hwmon.h>	/* for hwmon subdriver */
>  #include <linux/hwmon-sysfs.h>
> +#include <linux/video_output.h>	/* for video output subdriver */
>  
>  #include <ec_kb3310b.h>
>  
> @@ -397,6 +398,144 @@ static void yeeloong_hwmon_exit(void)
>  	}
>  }
>  
> +/* video output subdriver */
> +
> +static int lcd_video_output_get(struct output_device *od)
> +{
> +	return ec_read(REG_DISPLAY_LCD);
> +}
> +
> +static int lcd_video_output_set(struct output_device *od)
> +{
> +	int value;
> +	unsigned long status;
> +
> +	status = !!od->request_state;
> +
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
> +
> +	return 0;
> +}
> +
> +static struct output_properties lcd_output_properties = {
> +	.set_state = lcd_video_output_set,
> +	.get_status = lcd_video_output_get,
> +};
> +
> +static int crt_video_output_get(struct output_device *od)
> +{
> +	return ec_read(REG_CRT_DETECT);
> +}
> +
> +static int crt_video_output_set(struct output_device *od)
> +{
> +	int value;
> +	unsigned long status;
> +
> +	status = !!od->request_state;
> +
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
> +
> +	return 0;
> +}
> +
> +static struct output_properties crt_output_properties = {
> +	.set_state = crt_video_output_set,
> +	.get_status = crt_video_output_get,
> +};
> +
> +static struct output_device *lcd_output_dev, *crt_output_dev;
> +
> +static void yeeloong_lcd_vo_set(int status)
> +{
> +	lcd_output_dev->request_state = status;
> +	lcd_video_output_set(lcd_output_dev);
> +}
> +
> +static void yeeloong_crt_vo_set(int status)
> +{
> +	crt_output_dev->request_state = status;
> +	crt_video_output_set(crt_output_dev);
> +}
> +
> +static int yeeloong_vo_init(void)
> +{
> +	int ret;
> +
> +	/* Register video output device: lcd, crt */
> +	lcd_output_dev = video_output_register("LCD", NULL, NULL,
> +			&lcd_output_properties);
> +
> +	if (IS_ERR(lcd_output_dev)) {
> +		ret = PTR_ERR(lcd_output_dev);
> +		lcd_output_dev = NULL;
> +		return ret;
> +	}
> +	/* Ensure LCD is on by default */
> +	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
> +
> +	crt_output_dev = video_output_register("CRT", NULL, NULL,
> +			&crt_output_properties);
> +
> +	if (IS_ERR(crt_output_dev)) {
> +		ret = PTR_ERR(crt_output_dev);
> +		crt_output_dev = NULL;
> +		return ret;
> +	}
> +
> +	/* Turn off CRT by default, and will be enabled when the CRT
> +	 * connectting event reported by SCI */
> +	yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
> +
> +	return 0;
> +}
> +
> +static void yeeloong_vo_exit(void)
> +{
> +	if (lcd_output_dev) {
> +		video_output_unregister(lcd_output_dev);
> +		lcd_output_dev = NULL;
> +	}
> +	if (crt_output_dev) {
> +		video_output_unregister(crt_output_dev);
> +		crt_output_dev = NULL;
> +	}
> +}
> +
>  static struct platform_device_id platform_device_ids[] = {
>  	{
>  		.name = "yeeloong_laptop",
> @@ -443,11 +582,19 @@ static int __init yeeloong_init(void)
>  		return ret;
>  	}
>  
> +	ret = yeeloong_vo_init();
> +	if (ret) {
> +		pr_err("Fail to register yeeloong video output driver.\n");
> +		yeeloong_vo_exit();
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
>  static void __exit yeeloong_exit(void)
>  {
> +	yeeloong_vo_exit();
>  	yeeloong_hwmon_exit();
>  	yeeloong_battery_exit();
>  	yeeloong_backlight_exit();
