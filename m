Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 17:30:27 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:46929 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab1FJPaY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2011 17:30:24 +0200
Received: by wyb28 with SMTP id 28so2624277wyb.36
        for <linux-mips@linux-mips.org>; Fri, 10 Jun 2011 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=ZKKnTVMzMz79HTn0QkhyyXytmx0I3C8517LYn16b6kA=;
        b=YhkmRA7VzZBuqN7KuOOHr4zdjj4tx/Trw45EX2ii5kFiadfX6dDy0E5YJJ1peqoEGt
         Z8Nfk5bsrtJQtP6yGYy+Fot9pvwl8tnzPyIQwZFGa1yw/5Y6/wxSa04t5/CbYR33YhrE
         7T3bVYbjxN71kxXxENdWcGOazQVTv7Q5pf1Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=ItXlKMH0E++5MZmBsm2RUVVgx7V7P4iGO3KGiVfceXD9GZW3UrEd9j7M+Y4MtZ+YfR
         Bs76aauZhUdkN6ppsavXnIYJL+fbSyXqKU0mbXGBiZI7lVlRZ7p4FYfP4Kw+K/Gpz3WX
         LmBu+elWf9l35sNf8lBH3BCgqi0HT8VRishdg=
Received: by 10.227.37.7 with SMTP id v7mr2387183wbd.41.1307719817248;
        Fri, 10 Jun 2011 08:30:17 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id et5sm2112370wbb.33.2011.06.10.08.30.15
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 08:30:15 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 2/3] WATCHDOG: mtx1-wdt: request gpio before using it
Date:   Fri, 10 Jun 2011 17:34:34 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>, stable@kernel.org
References: <201106021454.20111.florian@openwrt.org> <20110607095847.GB21174@pulham.picochip.com>
In-Reply-To: <20110607095847.GB21174@pulham.picochip.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106101734.35048.florian@openwrt.org>
X-archive-position: 30320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9309

Hello Jamie,

On Tuesday 07 June 2011 11:58:47 Jamie Iles wrote:
> On Thu, Jun 02, 2011 at 02:54:20PM +0200, Florian Fainelli wrote:
> > Otherwise, the gpiolib autorequest feature will produce a WARN_ON():
> > 
> > WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
> > autorequest GPIO-215
> > [...]
> > 
> > CC: stable@kernel.org
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> > index 63df28c..16086f8 100644
> > --- a/drivers/watchdog/mtx-1_wdt.c
> > +++ b/drivers/watchdog/mtx-1_wdt.c
> > @@ -214,6 +214,11 @@ static int __devinit mtx1_wdt_probe(struct
> > platform_device *pdev)
> > 
> >  	int ret;
> >  	
> >  	mtx1_wdt_device.gpio = pdev->resource[0].start;
> > 
> > +	ret = gpio_request(mtx1_wdt_device.gpio, "mtx1-wdt");
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to request gpio");
> > +		return ret;
> > +	}
> 
> Could you use gpio_request_one() here to make sure the GPIO is in the
> correct direction first?

Makes sense, I will respin a v2 of these.
--
Florian
