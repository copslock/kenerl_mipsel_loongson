Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 01:37:37 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:35388 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494099AbZKEAha (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 01:37:30 +0100
Received: by ywh3 with SMTP id 3so8006957ywh.22
        for <multiple recipients>; Wed, 04 Nov 2009 16:37:22 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=qlyOp/tMpKSzF2liOHuc9GT7/qcuKuT/k5VVbnEiiEs=;
        b=t5OH9EletdWzU7ueg2uTtPN32yp5spzSzRdHMxCUrxeZC6PqNsV94vl3eA+ExlTdEZ
         jJsYnZNKc1qJ2gzd30QAUmkAKW2dYzd7g8jhyvL/yF9e4ylSVMAgnM7O2xxsvt3jSjPl
         ijN/+pyq8QjE2Y/HlCILEBqN4edTboDXh/JlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=SGcByZXWn0BprzcoS1YPfEraVhtIJL8R25PtxN+QO52Vu1UQX1rvABsy4nVWg9smgq
         nVMOmjTtoOJNGD23IOdfMCz/Ig3/+6aOVUJkij8e21SbA4YkZAQofMqClFkM7YVdQ/7A
         6RlLduzNV4b0Cl9HCiYR8GbicqULBPJAr7GUs=
Received: by 10.91.28.2 with SMTP id f2mr4638848agj.16.1257381442175;
        Wed, 04 Nov 2009 16:37:22 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 7sm711587yxd.26.2009.11.04.16.37.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 16:37:21 -0800 (PST)
Subject: Re: [PATCH 2/2] [loongson] fuloong: add RTC_LIB Support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
In-Reply-To: <m31vketgyw.fsf@anduin.mandriva.com>
References: <1257349784-21444-1-git-send-email-wuzhangjin@gmail.com>
	 <m31vketgyw.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Thu, 05 Nov 2009 08:37:23 +0800
Message-ID: <1257381443.16033.6.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-04 at 17:03 +0100, Arnaud Patard wrote:
> Wu Zhangjin <wuzhangjin@gmail.com> writes:
> Hi,
> 
> > + *  Registration of Cobalt RTC platform device.
> 
> Of Cobalt platform device ? I thought we were on loongson :)
> 

Ooh, I just copied the header ;) will remove it later.

> > + *
> > + *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > + *  Copyright (C) 2009  Wu Zhangjin <wuzj@lemote.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/ioport.h>
> > +#include <linux/mc146818rtc.h>
> > +#include <linux/platform_device.h>
> > +
> > +static struct resource rtc_cmos_resource[] = {
> > +	{
> > +		.start	= RTC_PORT(0),
> > +		.end	= RTC_PORT(1),
> > +		.flags	= IORESOURCE_IO,
> > +	},
> > +	{
> > +		.start	= RTC_IRQ,
> > +		.end	= RTC_IRQ,
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static struct platform_device rtc_cmos_device = {
> > +	.name		= "rtc_cmos",
> > +	.id		= -1,
> > +	.num_resources	= ARRAY_SIZE(rtc_cmos_resource),
> > +	.resource	= rtc_cmos_resource
> > +};
> > +
> > +static __init int rtc_cmos_init(void)
> > +{
> > +	platform_device_register(&rtc_cmos_device);
> > +
> > +	return 0;
> 
> what about return platform_device_register(&rtc_cmos_device); ?
> 
> 

Okay, later.

Regards,
	Wu Zhangjin
