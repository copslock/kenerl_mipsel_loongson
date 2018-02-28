Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 14:14:21 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:45338 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991855AbeB1NOM5xuJf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Feb 2018 14:14:12 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 94BDD207C1; Wed, 28 Feb 2018 14:14:01 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 47CBF2036E;
        Wed, 28 Feb 2018 14:14:01 +0100 (CET)
Date:   Wed, 28 Feb 2018 14:14:02 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] MIPS: mscc: add ocelot dtsi
Message-ID: <20180228131402.GL1479@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
 <CAOiHx=n5bekhgaA_-teYZzJQCErfb2Vg1X9fTaq073B=kpWnTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=n5bekhgaA_-teYZzJQCErfb2Vg1X9fTaq073B=kpWnTA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 27/02/2018 at 22:01:37 +0100, Jonas Gorski wrote:
> On 16 January 2018 at 11:12, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Add a device tree include file for the Microsemi Ocelot SoC.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  arch/mips/boot/dts/Makefile         |   1 +
> >  arch/mips/boot/dts/mscc/Makefile    |   4 ++
> >  arch/mips/boot/dts/mscc/ocelot.dtsi | 110 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >  create mode 100644 arch/mips/boot/dts/mscc/Makefile
> >  create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
> >
> > diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> > index e2c6f131c8eb..1e79cab8e269 100644
> > --- a/arch/mips/boot/dts/Makefile
> > +++ b/arch/mips/boot/dts/Makefile
> > @@ -4,6 +4,7 @@ subdir-y        += cavium-octeon
> >  subdir-y       += img
> >  subdir-y       += ingenic
> >  subdir-y       += lantiq
> > +subdir-y       += mscc
> >  subdir-y       += mti
> >  subdir-y       += netlogic
> >  subdir-y       += ni
> > diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> > new file mode 100644
> > index 000000000000..f0a155a74e02
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> > +
> > +# Force kbuild to make empty built-in.o if necessary
> > +obj-                           += dummy.o
> > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > new file mode 100644
> > index 000000000000..b2f936e1fbb9
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > @@ -0,0 +1,110 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/* Copyright (c) 2017 Microsemi Corporation */
> > +
> > +/ {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +       compatible = "mscc,ocelot";
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               mips-hpt-frequency = <250000000>;
> > +
> > +               cpu@0 {
> > +                       compatible = "mscc,ocelot";
> 
> You are using the same compatible string for the whole chip as well as
> the cpu core of it, this doesn't seem right.
> 
> Also is this really a custom cpu core? Your product brief suggests
> this is a "normal" 24KEc MIPS CPU, at least for ocelot-10 (VSC7514).
> So something like "mips,mips24KEc" might be more appropriate here.
> 

Indeed, that is something I forgot to change before sending.

> 
> Regards
> Jonas

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
