Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 07:58:04 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:38967 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491037AbZLHG57 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 07:57:59 +0100
Received: by gxk2 with SMTP id 2so4608412gxk.4
        for <multiple recipients>; Mon, 07 Dec 2009 22:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=VegzTiCpu8F50+DhLpnGs+6ehx7jQ+C3NPtp5EJL7Cw=;
        b=CQoyI5kw9bKQG97/pb3TFv9Q6x8raobsrhC+G7slm7Z9LC1XYlS92M15i+eFL2ebYp
         06qN8SVj4ZK3/iHPnsOa7uq3Q5XmRD98z6GFWdeop+zde/Pk7hof8WWc8K/WU1LAlELu
         eWBcIBQUmZNexiiBcljFo5YsEQel7PgoXPC64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=NFRM90g46VJ53OOqjTxgvMZYv/le3qNpTghaRcATD6yjIEVjMHvBY6YFGLnStUIq5+
         hc20i8CZU28cui8iR/Sly31Qvm0ak7+o5ObW82vHZ2+LEfZ0mG+Arip0r3DZ6gQX0XrI
         ksNVzO/h4Mi1oJA3u/kTFXz6DEfcDQnPe+Mfs=
Received: by 10.150.39.1 with SMTP id m1mr13314624ybm.100.1260255469668;
        Mon, 07 Dec 2009 22:57:49 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm2327962ywh.16.2009.12.07.22.57.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 22:57:48 -0800 (PST)
Subject: Re: [PATCH v7 4/8] Loongson: YeeLoong: add battery driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        zhangfx@lemote.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-laptop@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <059fa216d70771a6341edb2db4cc559e958273e9.1259932036.git.wuzhangjin@gmail.com>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
         <059fa216d70771a6341edb2db4cc559e958273e9.1259932036.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 14:57:17 +0800
Message-ID: <1260255437.3315.35.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Pavel

Seems you have reviewed this patch, can I get your Acked-by:?

Thanks!
	Wu Zhangjin

On Fri, 2009-12-04 at 21:34 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds APM emulated Battery Driver, it provides standard
> interface(/proc/apm) for user-space applications(e.g. kpowersave,
> gnome-power-manager) to manage the battery.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  drivers/platform/mips/Kconfig           |    2 +
>  drivers/platform/mips/yeeloong_laptop.c |  104 +++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
> index f7a3705..0c6b5ad 100644
> --- a/drivers/platform/mips/Kconfig
> +++ b/drivers/platform/mips/Kconfig
> @@ -18,6 +18,8 @@ config LEMOTE_YEELOONG2F
>  	tristate "Lemote YeeLoong Laptop"
>  	depends on LEMOTE_MACH2F
>  	select BACKLIGHT_CLASS_DEVICE
> +	select SYS_SUPPORTS_APM_EMULATION
> +	select APM_EMULATION
>  	default m
>  	help
>  	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
> diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
> index fbc4ebb..729e368 100644
> --- a/drivers/platform/mips/yeeloong_laptop.c
> +++ b/drivers/platform/mips/yeeloong_laptop.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/backlight.h>	/* for backlight subdriver */
>  #include <linux/fb.h>
> +#include <linux/apm-emulation.h>/* for battery subdriver */
>  
>  #include <ec_kb3310b.h>
>  
> @@ -83,6 +84,106 @@ static void yeeloong_backlight_exit(void)
>  	}
>  }
>  
> +/* battery subdriver */
> +
> +static void get_fixed_battery_info(void)
> +{
> +	int design_cap, full_charged_cap, design_vol, vendor, cell_count;
> +
> +	design_cap = (ec_read(REG_BAT_DESIGN_CAP_HIGH) << 8)
> +	    | ec_read(REG_BAT_DESIGN_CAP_LOW);
> +	full_charged_cap = (ec_read(REG_BAT_FULLCHG_CAP_HIGH) << 8)
> +	    | ec_read(REG_BAT_FULLCHG_CAP_LOW);
> +	design_vol = (ec_read(REG_BAT_DESIGN_VOL_HIGH) << 8)
> +	    | ec_read(REG_BAT_DESIGN_VOL_LOW);
> +	vendor = ec_read(REG_BAT_VENDOR);
> +	cell_count = ec_read(REG_BAT_CELL_COUNT);
> +
> +	if (vendor != 0) {
> +		pr_info("battery vendor(%s), cells count(%d), "
> +		       "with designed capacity(%d),designed voltage(%d),"
> +		       " full charged capacity(%d)\n",
> +		       (vendor ==
> +			FLAG_BAT_VENDOR_SANYO) ? "SANYO" : "SIMPLO",
> +		       (cell_count == FLAG_BAT_CELL_3S1P) ? 3 : 6,
> +		       design_cap, design_vol,
> +		       full_charged_cap);
> +	}
> +}
> +
> +#define APM_CRITICAL		5
> +
> +static void get_power_status(struct apm_power_info *info)
> +{
> +	unsigned char bat_status;
> +
> +	info->battery_status = APM_BATTERY_STATUS_UNKNOWN;
> +	info->battery_flag = APM_BATTERY_FLAG_UNKNOWN;
> +	info->units = APM_UNITS_MINS;
> +
> +	info->battery_life = (ec_read(REG_BAT_RELATIVE_CAP_HIGH) << 8) |
> +		(ec_read(REG_BAT_RELATIVE_CAP_LOW));
> +
> +	info->ac_line_status = (ec_read(REG_BAT_POWER) & BIT_BAT_POWER_ACIN) ?
> +		APM_AC_ONLINE : APM_AC_OFFLINE;
> +
> +	bat_status = ec_read(REG_BAT_STATUS);
> +
> +	if (!(bat_status & BIT_BAT_STATUS_IN)) {
> +		/* no battery inserted */
> +		info->battery_status = APM_BATTERY_STATUS_NOT_PRESENT;
> +		info->battery_flag = APM_BATTERY_FLAG_NOT_PRESENT;
> +		info->time = 0x00;
> +		return;
> +	}
> +
> +	/* adapter inserted */
> +	if (info->ac_line_status == APM_AC_ONLINE) {
> +		if (!(bat_status & BIT_BAT_STATUS_FULL)) {
> +			/* battery is not fully charged */
> +			info->battery_status = APM_BATTERY_STATUS_CHARGING;
> +			info->battery_flag = APM_BATTERY_FLAG_CHARGING;
> +		} else {
> +			/* battery is fully charged */
> +			info->battery_status = APM_BATTERY_STATUS_HIGH;
> +			info->battery_flag = APM_BATTERY_FLAG_HIGH;
> +			info->battery_life = 100;
> +		}
> +	} else {
> +		/* battery is too low */
> +		if (bat_status & BIT_BAT_STATUS_LOW) {
> +			info->battery_status = APM_BATTERY_STATUS_LOW;
> +			info->battery_flag = APM_BATTERY_FLAG_LOW;
> +			if (info->battery_life <= APM_CRITICAL) {
> +				/* we should power off the system now */
> +				info->battery_status =
> +					APM_BATTERY_STATUS_CRITICAL;
> +				info->battery_flag = APM_BATTERY_FLAG_CRITICAL;
> +			}
> +		} else {
> +			/* assume the battery is high enough. */
> +			info->battery_status = APM_BATTERY_STATUS_HIGH;
> +			info->battery_flag = APM_BATTERY_FLAG_HIGH;
> +		}
> +	}
> +	info->time = ((info->battery_life - 3) * 54 + 142) / 60;
> +}
> +
> +static int yeeloong_battery_init(void)
> +{
> +	get_fixed_battery_info();
> +
> +	apm_get_power_status = get_power_status;
> +
> +	return 0;
> +}
> +
> +static void yeeloong_battery_exit(void)
> +{
> +	if (apm_get_power_status == get_power_status)
> +		apm_get_power_status = NULL;
> +}
> +
>  static struct platform_device_id platform_device_ids[] = {
>  	{
>  		.name = "yeeloong_laptop",
> @@ -120,11 +221,14 @@ static int __init yeeloong_init(void)
>  		return ret;
>  	}
>  
> +	yeeloong_battery_init();
> +
>  	return 0;
>  }
>  
>  static void __exit yeeloong_exit(void)
>  {
> +	yeeloong_battery_exit();
>  	yeeloong_backlight_exit();
>  	platform_driver_unregister(&platform_driver);
>  
