Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 17:19:31 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:54658
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992334AbdKNQTXPDlQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 17:19:23 +0100
Received: by mail-pg0-x244.google.com with SMTP id c123so7690416pga.11;
        Tue, 14 Nov 2017 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=enRMfFXJMQHMhPAmOzGk2d2k/M5it70d9s/B8YSyQqQ=;
        b=uh4BYrI12fxe5SpYM2ATTaXZMmgoNpmYLK+z6foFxzkiGTtsfoWuKYG9K3/dciLHbM
         cYeRL/p9ja7FUrt8PeHoFLXESEyfBfBNepvQA8sx0mJ11cdaV2y4PMMFY0IduUIo4e3x
         sB25W84cgeenETzLo1QQpzS6Y8PF1vcy2M+JQyiRQlC8rP5mj7/IgGjZiOLQ5dpq3gUt
         nwd/C70h2AvFQCLEgLAR/4eB2m4HW7jyIzIaMNJyWxSeUpoCgUlIbesoaaz4cchxDnCC
         tv4QqmJ3IpYLkrGa9L87eDzLEaZ96BTkZIKX140wKTLRV2s4Vzbo03cxPr/oYTYzZd/m
         +aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=enRMfFXJMQHMhPAmOzGk2d2k/M5it70d9s/B8YSyQqQ=;
        b=WzFPU5pbax5O74klNIVmy2V4FFDAcMCr7B+lIPWqU6f+Dt4DAEgoBinXKCqtIXvSmv
         JQWajFK40CtCj3rSYVbwGtHpo/ex01G58tAf+i+Ggl2CCyls1LFVQsRBExFSBDMVq8B4
         hmlZk3Mf6GAlqMlkakmRyZS4brVKMcQGeygr+nD624QmejLtVBVhBYQHeI1hFO0rMgOE
         wZJtRzGYpWHTK98lwzGT1bF8RsPh7lRBvBjqQRjSIniDt3g5KEeBiMunZ3gtnLqZDBYW
         fKW+WGmfwydCM6p2oCSZYhgfJYDjMp1PtK7CfeCzCmZkWQ4FBFKhPzJJ48T3bFz1e2cB
         tWyQ==
X-Gm-Message-State: AJaThX4qjLLyhAjZSHqh/jxmS6cPwlnWoZkzUmSD4kHKYGA+vG7TeDPK
        bnzxCOOpVKjmR2b/aJzZ+zS4Gg==
X-Google-Smtp-Source: AGs4zMZmZfCXQ9DoyLgpTeQPZt8mMLAn03QHLyMEyWW9E2yt0sB/DCcAsSYdGWVL8SoyCoH9gAxxsQ==
X-Received: by 10.98.189.23 with SMTP id a23mr14404681pff.124.1510676356396;
        Tue, 14 Nov 2017 08:19:16 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g13sm38365947pfm.130.2017.11.14.08.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 08:19:15 -0800 (PST)
Date:   Tue, 14 Nov 2017 08:19:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        linux-mips@linux-mips.org, "# 4 . 11 +" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: indydog: Add dependency on SGI_HAS_INDYDOG
Message-ID: <20171114161915.GC19879@roeck-us.net>
References: <1510656774-31464-1-git-send-email-matt.redfearn@mips.com>
 <20171114111737.GB5823@jhogan-linux.mipstec.com>
 <20171114134812.GF13046@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114134812.GF13046@linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Nov 14, 2017 at 02:48:12PM +0100, Ralf Baechle wrote:
> On Tue, Nov 14, 2017 at 11:17:38AM +0000, James Hogan wrote:
> 
> > On Tue, Nov 14, 2017 at 10:52:54AM +0000, Matt Redfearn wrote:
> > > Commit da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")

Yes, that patch was a tremenuous failure and definitely not worth the trouble
it caused.

> > > enabled building the Indy watchdog driver when COMPILE_TEST is enabled.
> > > However, the driver makes reference to symbols that are only defined for
> > > certain platforms are selected in the config. These platforms select
> > > SGI_HAS_INDYDOG. Without this, link time errors result, for example
> > > when building a MIPS allyesconfig.
> > > 
> > > drivers/watchdog/indydog.o: In function `indydog_write':
> > > indydog.c:(.text+0x18): undefined reference to `sgimc'
> > > indydog.c:(.text+0x1c): undefined reference to `sgimc'
> > > drivers/watchdog/indydog.o: In function `indydog_start':
> > > indydog.c:(.text+0x54): undefined reference to `sgimc'
> > > indydog.c:(.text+0x58): undefined reference to `sgimc'
> > > drivers/watchdog/indydog.o: In function `indydog_stop':
> > > indydog.c:(.text+0xa4): undefined reference to `sgimc'
> > > drivers/watchdog/indydog.o:indydog.c:(.text+0xa8): more undefined
> > > references to `sgimc' follow
> > > make: *** [Makefile:1005: vmlinux] Error 1
> > > 
> > > Fix this by ensuring that CONFIG_INDIDOG can only be selected when the
> > > necessary dependent platform symbols are built in.
> > > 
> > > Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> > > Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> > > Cc: <stable@vger.kernel.org> # 4.11 +
> > > ---
> > > 
> > >  drivers/watchdog/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > index ca200d1f310a..d96e2e7544fc 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -1451,7 +1451,7 @@ config RC32434_WDT
> > >  
> > >  config INDYDOG
> > >  	tristate "Indy/I2 Hardware Watchdog"
> > > -	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
> > > +	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST && SGI_HAS_INDYDOG)
> > 
> > (MIPS && COMPILE_TEST && SGI_HAS_INDYDOG) implies SGI_HAS_INDYDOG
> > 
> > So I think you can just do:
> > -	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
> > +	depends on SGI_HAS_INDYDOG
> > 
> > I.e. COMPILE_TEST isn't of any value in this case.
> 
> I agree, due to the references to sgimc this driver will only compile for
> the platforms which set SGI_HAS_INDYDOG; MIPS as the dependency is too
> generic.
> 
> Updated patch for the watchdog maintainers' ease below.
> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Reported-by: Matt Redfearn <matt.redfearn@mips.com>
> Suggested-by: James Hogan <james.hogan@mips.com>
> 
Not sure if/how that helps. Now we have two patches with different
authors and sign-off statements, both of which need maintainer
manipulation. I'll pick the first patch into my tree and fix it up.
Let's see what Wim does with it.

Guenter

>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..3ece1335ba84 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1451,7 +1451,7 @@ config RC32434_WDT
>  
>  config INDYDOG
>  	tristate "Indy/I2 Hardware Watchdog"
> -	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
> +	depends on SGI_HAS_INDYDOG
>  	help
>  	  Hardware driver for the Indy's/I2's watchdog. This is a
>  	  watchdog timer that will reboot the machine after a 60 second
