Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 17:31:30 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:58638 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab1FJPb1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2011 17:31:27 +0200
Received: by wwi18 with SMTP id 18so875029wwi.0
        for <linux-mips@linux-mips.org>; Fri, 10 Jun 2011 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=LRs7gGO/luhcAbU0Yly9ZF3iurtzT6QEAZeATZqjkA4=;
        b=IMunW2YbHGtX92JyqC76WUvYGlQjgy54UdpIGoz13Xe6ZYChr2z0nih+w+iILxY8HJ
         q85jIDVGLS+mLWpeSBE3GT+sTiNhU4jC972NBcSYMJsjblpIELt69uehoVxMcKof2MZr
         12brDo1v2k4KbNMU0OJH+Rby4Gg5Ij1KIjzIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=HoDWovox1p5B5isNJcNvkPgaxe4F27zEwev/Cx3gbbqaSUl20K/Lr7XBoitGXimmXt
         zi4tFhPB9veNZkUAI3PGuawsT2BkS6rlVIDuC2utGXKOfxBwK/GYVMhpk7Oqp8FdXuC2
         OSf90E87CaDikm7bfXF3iHiRdMh59DTZbsgyc=
Received: by 10.216.61.135 with SMTP id w7mr7884896wec.19.1307719882157;
        Fri, 10 Jun 2011 08:31:22 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id n20sm1465014weq.39.2011.06.10.08.31.20
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 08:31:21 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 3/3] WATCHDOG: mtx1-wdt: fix GPIO toggling
Date:   Fri, 10 Jun 2011 17:35:40 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>, stable@kernel.org
References: <201106021454.21827.florian@openwrt.org> <20110607095932.GC21174@pulham.picochip.com>
In-Reply-To: <20110607095932.GC21174@pulham.picochip.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106101735.40335.florian@openwrt.org>
X-archive-position: 30321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9310

On Tuesday 07 June 2011 11:59:32 Jamie Iles wrote:
> On Thu, Jun 02, 2011 at 02:54:21PM +0200, Florian Fainelli wrote:
> > Commit e391be76 (MIPS: Alchemy: Clean up GPIO registers and accessors)
> > changed the way the GPIO was toggled. Prior to this patch, we would
> > always actively drive the GPIO output to either 0 or 1, this patch
> > drove the GPIO active to 0, and put the GPIO in tristate to drive it
> > to 1, unfortunately this does not work, revert back to active driving.
> > 
> > Using a signed variable (gstate) to hold the gpio state and using a bit-
> > wise operation on it also resulted in toggling value from 1 to -2 since
> > the variable is signed. This value was then passed on to gpio_direction_
> > output, which always perform a if (value) ... to set the value to the
> > gpio, so we were always writing a 1 to this GPIO instead of 1 -> 0 -> 1
> > ...
> > 
> > CC: stable@kernel.org
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> > index 16086f8..9756da9 100644
> > --- a/drivers/watchdog/mtx-1_wdt.c
> > +++ b/drivers/watchdog/mtx-1_wdt.c
> > @@ -66,7 +66,7 @@ static struct {
> > 
> >  	int default_ticks;
> >  	unsigned long inuse;
> >  	unsigned gpio;
> > 
> > -	int gstate;
> > +	unsigned int gstate;
> > 
> >  } mtx1_wdt_device;
> >  
> >  static void mtx1_wdt_trigger(unsigned long unused)
> > 
> > @@ -78,11 +78,8 @@ static void mtx1_wdt_trigger(unsigned long unused)
> > 
> >  		ticks--;
> >  	
> >  	/* toggle wdt gpio */
> > 
> > -	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
> > -	if (mtx1_wdt_device.gstate)
> > -		gpio_direction_output(mtx1_wdt_device.gpio, 1);
> > -	else
> > -		gpio_direction_input(mtx1_wdt_device.gpio);
> > +	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
> > +	gpio_direction_output(mtx1_wdt_device.gpio, mtx1_wdt_device.gstate);
> 
> Would gpio_set_value() be more appropriate here?  Isn't the gpio always
> an output after the first call?

I wanted to first get it fixed, then eventually correctly updated. Makes sense 
to have this merged in the patch to match the comment of my patch.
--
Florian
