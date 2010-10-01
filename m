Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 09:42:52 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:61551 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491759Ab0JAHmt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 09:42:49 +0200
Received: by bwz19 with SMTP id 19so2693116bwz.36
        for <linux-mips@linux-mips.org>; Fri, 01 Oct 2010 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sdsc5D0NA4nh56+S6OrMqmsKJJaZkPYgW0smbTAwwXI=;
        b=d5WEX8JTqOwCa7gNJWjDq3LhnePNloMtWrcG3zN8n/pSAuRlkIgiDxk11fmSvuFU6K
         Fye8dEE1ODnFVhBgMs61QaWMZsNA3Bbu9OrCIznD2K9BEaOSAR5EkM602KQLkA0UT8vo
         VWFonkTyaawzpPqvmXXyScEGuh+bK96aMUQFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OybrD6e5E/ugbaAuKUNW1Snfs8vXPVKLHZRoMIIErSUgAjb/7ndH7aiXcvZyTCciCY
         ydh2894qhd5HNrOXd9SHlArd4/Vg51NHZzw8KR02RlMhwNOQWvO8+GNX31y3Ljur3ERB
         0T2ihf5cYhRsACKGIo/WmCXakmgJdwl3w6Rsw=
MIME-Version: 1.0
Received: by 10.204.133.91 with SMTP id e27mr3539117bkt.197.1285918968917;
 Fri, 01 Oct 2010 00:42:48 -0700 (PDT)
Received: by 10.204.48.76 with HTTP; Fri, 1 Oct 2010 00:42:48 -0700 (PDT)
In-Reply-To: <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
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
        <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
Date:   Fri, 1 Oct 2010 16:42:48 +0900
Message-ID: <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
From:   Jassi Brar <jassisinghbrar@gmail.com>
To:     Arun MURTHY <arun.murthy@stericsson.com>
Cc:     Trilok Soni <soni.trilok@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Bill Gatliff <bgat@billgatliff.com>,
        "broonie@opensource.wolfsonmicro.com" 
        <broonie@opensource.wolfsonmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus WALLEIJ <linus.walleij@stericsson.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        Mattias WALLIN <mattias.wallin@stericsson.com>,
        STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Samuel Ortiz <sameo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jassisinghbrar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jassisinghbrar@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 1, 2010 at 4:25 PM, Arun MURTHY <arun.murthy@stericsson.com> wrote:
> You can have a look at the pwm_config_nosleep(),pwm_set_polarity(),
> pwm_synchronize(),pwm_unsynchronize(), pwm_set_handler() etc.
> These are not being used by the exsting pwm drivers except Atmel pwm.
How would your 'simple' driver handle Atmel then ?
What if future's SoCs start providing those 'advance' features like Atmel's ?

> I mean not the functions but the functionality.
> PWM is a simple device and most of its clients are controlling intensity
> of backlight, leds, vibrator etc.
> I don't think these complex functionality are required.
oh dear !
