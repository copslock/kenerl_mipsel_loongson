Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 07:25:38 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:39536 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491072AbZK3GZf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 07:25:35 +0100
Received: by pwi15 with SMTP id 15so2067166pwi.24
        for <multiple recipients>; Sun, 29 Nov 2009 22:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=WwnWM7e7FP6Pcte/NS0LGvYSoVuphCYuAvi3bM/c+KM=;
        b=WRWFZOkGepaHagmcGwJsbCjbIHcC9Z/dGbKALTQHMv+SqQYtYzpbqJWg3EnJsrHUoR
         90lNJYdz36evuzz1f5Ggvm7G3UOTH8eNQMRMB5dj0tS5AnJR3LNaGG0YC66uaul8j+C8
         9+mUq6XpSYszxVYI1QmcuybbgJS/sQuwpTW4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=GWtqQ2FxU8zIPsThuE7FX/dUfjItAAUdPMeXubPexnco9SBcyXOOyxX5Sz/TS5ktCq
         0t2QUA3V0AnqEHJgZF9m6xZGouASsUi+npObgjb5o7EcBUwZj6g3yNX434T7+FyZqfuH
         3m7MjnIYdZeHB8lehXTtWebnmD3cYqQw0Sujc=
Received: by 10.114.8.5 with SMTP id 5mr6643304wah.117.1259562326159;
        Sun, 29 Nov 2009 22:25:26 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm2780001pzk.15.2009.11.29.22.25.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 22:25:25 -0800 (PST)
Subject: Re: [PATCH v5 5/8] Loongson: YeeLoong: add hwmon driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, lm-sensors@lm-sensors.org
In-Reply-To: <1259558432.5516.8.camel@falcon.domain.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
         <1259558432.5516.8.camel@falcon.domain.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 14:24:54 +0800
Message-ID: <1259562294.5516.16.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-30 at 13:20 +0800, Wu Zhangjin wrote:
> On Sat, 2009-11-28 at 21:38 +0800, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds hwmon driver for managing the temperature of battery,
> > cpu and controlling the fan.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 +
> >  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
> >  .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    3 +
> >  .../loongson/lemote-2f/yeeloong_laptop/hwmon.c     |  241 ++++++++++++++++++++
> >  4 files changed, 254 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/hwmon.c
> > 
> > diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > index e284c91..56cb584 100644
> > --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > @@ -28,4 +28,13 @@ config YEELOONG_BATTERY
> >  	  This option adds APM emulated Battery Driver, which provides standard
> >  	  interface for user-space applications to manage the battery.
> >  
> > +config YEELOONG_HWMON
> > +	tristate "Hardware Monitor Driver"
> > +	select HWMON
> 
> Will use depend in the next version.
> 

Sorry, This must be select, there is no other way to select this stuff.

> Best Regards,
> 	Wu Zhangjin
