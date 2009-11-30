Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 06:21:05 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:35942 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065AbZK3FVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 06:21:02 +0100
Received: by pzk35 with SMTP id 35so2308235pzk.22
        for <multiple recipients>; Sun, 29 Nov 2009 21:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=nxagfkIO0WjkhzwxQ0XY2Sp4FHOFFCp383dy1SO5B50=;
        b=xinpe2CJ3C3sR6Wt8wpXZlyD9Z96jA89CQ82rpEmOPh3qV+dSXYQSwEXSkDmCCaT2V
         tNvsqdZ5WsPEAe2orJz89AeEW2LN05BC4nYJ7O/v5Byiq0tDaTcLHAmTv8HMZDPgMAlP
         DUClTAuBk4zeIa0HMW3nzaeEYtrXTzDcXAC4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=erj8h4RfFp/wRbWyVOTazEyr7zEZYrTDD68H9m9qU7MDfJZ60eGe5VEhTKrgWqudUt
         HbU54erEcSugTQKdTtrL2agXRgF9B3kv1uwFH85j55k9p20rMJqtMk0oAMhWxr7cbh3V
         /yYjFVD3zZwdiXftFCSzetX93Rzv3f5kMTJYs=
Received: by 10.114.189.8 with SMTP id m8mr6419954waf.180.1259558454725;
        Sun, 29 Nov 2009 21:20:54 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm2655500pxi.1.2009.11.29.21.20.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 21:20:54 -0800 (PST)
Subject: Re: [PATCH v5 5/8] Loongson: YeeLoong: add hwmon driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, lm-sensors@lm-sensors.org
In-Reply-To: <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 13:20:32 +0800
Message-ID: <1259558432.5516.8.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-28 at 21:38 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds hwmon driver for managing the temperature of battery,
> cpu and controlling the fan.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 +
>  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
>  .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    3 +
>  .../loongson/lemote-2f/yeeloong_laptop/hwmon.c     |  241 ++++++++++++++++++++
>  4 files changed, 254 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/hwmon.c
> 
> diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> index e284c91..56cb584 100644
> --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> @@ -28,4 +28,13 @@ config YEELOONG_BATTERY
>  	  This option adds APM emulated Battery Driver, which provides standard
>  	  interface for user-space applications to manage the battery.
>  
> +config YEELOONG_HWMON
> +	tristate "Hardware Monitor Driver"
> +	select HWMON

Will use depend in the next version.

Best Regards,
	Wu Zhangjin
