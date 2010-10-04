Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2010 06:24:56 +0200 (CEST)
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:56169 "EHLO
        eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490974Ab0JDEYw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Oct 2010 06:24:52 +0200
Received: from source ([167.4.1.35]) (using TLSv1) by eu1sys200aob106.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKlW4hhvlSQNfI5YutTb8mHxaHNQ2SNA@postini.com; Mon, 04 Oct 2010 04:24:51 UTC
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
        by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 8E52766;
        Mon,  4 Oct 2010 04:19:32 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 014F2323;
        Mon,  4 Oct 2010 04:22:48 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id F2D96A8072;
        Mon,  4 Oct 2010 06:22:45 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.6.6.68]) by
 exdcvycastm003.EQ1STM.local ([10.230.100.1]) with mapi; Mon, 4 Oct 2010
 06:22:48 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
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
Date:   Mon, 4 Oct 2010 06:22:46 +0200
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Thread-Topic: [PATCH 1/7] pwm: Add pwm core driver
Thread-Index: Acthko93yUf2x7o4Qr2yfrSftwA5hQB6CGOg
Message-ID: <F45880696056844FA6A73F415B568C695356E67D03@EXDCVYMBSTM006.EQ1STM.local>
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
 <20101001180051.GC21157@opensource.wolfsonmicro.com>
In-Reply-To: <20101001180051.GC21157@opensource.wolfsonmicro.com>
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
X-archive-position: 27931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

> On Fri, Oct 01, 2010 at 10:46:15AM +0200, Arun MURTHY wrote:
> > > On Fri, Oct 1, 2010 at 4:25 PM, Arun MURTHY
> 
> > > > I mean not the functions but the functionality.
> > > > PWM is a simple device and most of its clients are controlling
> > > intensity
> > > > of backlight, leds, vibrator etc.
> > > > I don't think these complex functionality are required.
> > > oh dear !
> > Here I mean why should all those function be exposed to the entire
> kernel,
> > as most of the pwm devices do not use them.
> 
> While many PWM uses are very simple that doesn't mean that we'll never
> need to support more advanced uses.  Normally we try to design APIs so
> that they both scale down to the simplest use cases and also up to more
> complex ones.
My intention is just to enable two pwm drivers and build successfully.
This patch can be considered for this reason and taken up until Bill's
patches are merged.

Thanks and Regards,
Arun R Murthy
-------------
