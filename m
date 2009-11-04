Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 17:03:43 +0100 (CET)
Received: from mx1.moondrake.net ([212.85.150.166]:57011 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1493355AbZKDQDg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 17:03:36 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 8247127C003; Wed,  4 Nov 2009 17:03:35 +0100 (CET)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id B5ED927C002;
	Wed,  4 Nov 2009 17:03:34 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 696B4828ED;
	Wed,  4 Nov 2009 17:15:02 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 9CC50FF855;
	Wed,  4 Nov 2009 17:03:35 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: Re: [PATCH 2/2] [loongson] fuloong: add RTC_LIB Support
References: <1257349784-21444-1-git-send-email-wuzhangjin@gmail.com>
Organization: Mandriva
Date:	Wed, 04 Nov 2009 17:03:35 +0100
In-Reply-To: <1257349784-21444-1-git-send-email-wuzhangjin@gmail.com> (Wu Zhangjin's message of "Wed,  4 Nov 2009 23:49:44 +0800")
Message-ID: <m31vketgyw.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> writes:
Hi,

> + *  Registration of Cobalt RTC platform device.

Of Cobalt platform device ? I thought we were on loongson :)

> + *
> + *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> + *  Copyright (C) 2009  Wu Zhangjin <wuzj@lemote.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/mc146818rtc.h>
> +#include <linux/platform_device.h>
> +
> +static struct resource rtc_cmos_resource[] = {
> +	{
> +		.start	= RTC_PORT(0),
> +		.end	= RTC_PORT(1),
> +		.flags	= IORESOURCE_IO,
> +	},
> +	{
> +		.start	= RTC_IRQ,
> +		.end	= RTC_IRQ,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device rtc_cmos_device = {
> +	.name		= "rtc_cmos",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(rtc_cmos_resource),
> +	.resource	= rtc_cmos_resource
> +};
> +
> +static __init int rtc_cmos_init(void)
> +{
> +	platform_device_register(&rtc_cmos_device);
> +
> +	return 0;

what about return platform_device_register(&rtc_cmos_device); ?


Arnaud
