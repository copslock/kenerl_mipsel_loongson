Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 20:00:51 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33598 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492015Ab0JASAo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 20:00:44 +0200
Received: from finisterre.wolfsonmicro.main (216-75-233-70.static.wiline.com [216.75.233.70])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id E59FA11023B;
        Fri,  1 Oct 2010 19:00:36 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.72)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1P1jud-0005cK-N0; Fri, 01 Oct 2010 11:00:51 -0700
Date:   Fri, 1 Oct 2010 11:00:51 -0700
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Arun MURTHY <arun.murthy@stericsson.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Trilok Soni <soni.trilok@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Bill Gatliff <bgat@billgatliff.com>,
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
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
Message-ID: <20101001180051.GC21157@opensource.wolfsonmicro.com>
References: <4CA1BC16.3020702@metafoo.de>
 <F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
 <4CA25841.4090702@metafoo.de>
 <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
 <F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
 <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
 <F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
X-Cookie: You'll be sorry...
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <broonie@opensource.wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 01, 2010 at 10:46:15AM +0200, Arun MURTHY wrote:
> > On Fri, Oct 1, 2010 at 4:25 PM, Arun MURTHY

> > > I mean not the functions but the functionality.
> > > PWM is a simple device and most of its clients are controlling
> > intensity
> > > of backlight, leds, vibrator etc.
> > > I don't think these complex functionality are required.
> > oh dear !
> Here I mean why should all those function be exposed to the entire kernel,
> as most of the pwm devices do not use them.

While many PWM uses are very simple that doesn't mean that we'll never
need to support more advanced uses.  Normally we try to design APIs so
that they both scale down to the simplest use cases and also up to more
complex ones.
