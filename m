Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 09:27:08 +0200 (CEST)
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:37727 "EHLO
        eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491989Ab0JAH1E convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Oct 2010 09:27:04 +0200
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob105.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKWNGy4h1GzMtJsUqEZVfkPrsrw+V96t@postini.com; Fri, 01 Oct 2010 07:27:03 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C4CB711C;
        Fri,  1 Oct 2010 07:25:17 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A4597C44;
        Fri,  1 Oct 2010 07:25:16 +0000 (GMT)
Received: from exdcvycastm004.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm004", Issuer "exdcvycastm004" (not verified))
        by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 8FD8A24C2E5;
        Fri,  1 Oct 2010 09:25:11 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.230.100.3]) by
 exdcvycastm004.EQ1STM.local ([10.230.100.2]) with mapi; Fri, 1 Oct 2010
 09:25:15 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Trilok Soni <soni.trilok@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "broonie@opensource.wolfsonmicro.com" 
        <broonie@opensource.wolfsonmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus WALLEIJ <linus.walleij@stericsson.com>,
        Mattias WALLIN <mattias.wallin@stericsson.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>,
        Bill Gatliff <bgat@billgatliff.com>
Date:   Fri, 1 Oct 2010 09:25:15 +0200
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Thread-Topic: [PATCH 1/7] pwm: Add pwm core driver
Thread-Index: ActhNIvvrnf+3lquQLCBnPYXF11EKgAAMVgg
Message-ID: <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
        <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
        <4CA1AD2B.8000905@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
        <4CA1BC16.3020702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
        <4CA25841.4090702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
        <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
        <F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
In-Reply-To: <AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <arun.murthy@stericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

Hi Trilok,

> Hi Arun,
> 
> On Fri, Oct 1, 2010 at 8:55 AM, Arun MURTHY
> <arun.murthy@stericsson.com> wrote:
> > Hi Trilok,
> >
> >> Hi Arun,
> >>
> >> Adding Bill Gatliff (anyway, CC list already crowded)
> >>
> >> On Wed, Sep 29, 2010 at 10:19 AM, Arun MURTHY
> >> <arun.murthy@stericsson.com> wrote:
> >> >> Arun MURTHY wrote:
> >> >> >>>> Shouldn't PWM_DEVICES select HAVE_PWM?
> >> >> >>>
> >> >> >>> No not required, the entire concept is to remove HAVE_PWM and
> >> use
> >> >> >> PWM_CORE.
> >>
> >> There is already nice and clean framework written by Bill for PWM,
> if
> >> you grep the LKML and linux-embedded mailing list archive then you
> >> will get his patches, and it seems that he had promised to send the
> >> updated version few week back, but not heard from him (may be
> because
> >> he was travelling as per FB status).
> >>
> >> Please evaluate that framework too.
> >>
> > Thanks for this information, I did search in linux-embedded mailing
> list
> > archive. Below are my views on that patch set.
> > Many of the functions that has been defined in pwm core driver
> > written by Bill Gatliff is not being used by the most of the pwm
> drivers
> > except Atmel PWM driver. I rather felt the pwm core driver was an
> attempt
> > made to generalize the Atmel pwm driver.
> > And moreover this was posted long back somewhere in the beginning of
> this
> > year i.e Feb and the thread is dead thereafter.
> >
> > This patch has been submitted focusing all the existing pwm drivers
> and
> > only these are the functions that are being used by pwm drivers.
> > This patch set also included patch to align all the existing pwm
> driver
> > with the pwm core driver.
> > So it is an attempt to generalize most of the pwm drivers and
> > conclude with a pwm core driver.
> 
> I don't agree that Bill had only atmel drivers view. The PWM framework
> was discussed in-depth and at that time reviewers also requested once
> to provide more example drivers using these drivers, someone said "we
> atleast need three drivers as rule of thumb". Let's wait until Bill
> reviews your framework, I am sure we don't need to end up the same
> problems faced by Bill while designing that framework in your code
> too.
> 
You can have a look at the pwm_config_nosleep(),pwm_set_polarity(),
pwm_synchronize(),pwm_unsynchronize(), pwm_set_handler() etc.
These are not being used by the exsting pwm drivers except Atmel pwm.
I mean not the functions but the functionality.
PWM is a simple device and most of its clients are controlling intensity
of backlight, leds, vibrator etc.
I don't think these complex functionality are required.
And moreover it also refers to GPIO pins, in that case it comes under
a different classification. The one that I have suggested is a generic
pwm core driver.
You can have a look at the existing pwm drivers in drivers/mfd/twl6030-pwm.c,
arch/arm/plat-samsung/pwm.c, arch/arm/plat-mxc/pwm.c, arch/arm/plat-pxa/pwm.c,
arch/mips/jz4740/pwm.c.
None of these include the function provided the patch " [PWM PATCH 1/5] API
to consolidate PWM devices behind a common user and kernel interface "
except pwm_enable, pwm_config, pwm_disable.
I have focused on all these and come up with this design.
And moreover Bill's patch set for pwm core driver, becomes incompatible with
pwm based backlight and led driver(drivers/leds/leds-pwm.c,
drivers/video/backlight/pwm_bl.c) and drivers/input/misc/pwm-beeper.c.

I don't mind waiting for Bill's review on my patch, but he is not active
since Feb 2010.

Thanks and Regards,
Arun R Murthy
-------------
