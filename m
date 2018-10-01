Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 19:11:26 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994571AbeJARLPUVXOe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 19:11:15 +0200
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707F221470;
        Mon,  1 Oct 2018 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538413868;
        bh=JiNqzpBDwcNPo4raTWE6okV3EIt1/ouSQDUVcYWMmNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M1bW1Tjx5rF8O+0XPU7moIFhoKHSGCioCoAZzAC1foGR3Tqr3N/5PtxDv6dNlK0cj
         5lTuxNrC/4oWa0kar5ECMArVdfTXe4wlLi/jwG5qppm+fUkrp7RhFc06bxjhUJ2typ
         HpBWHDrAVxYEYX0/+XqV7tjGJUdXMyCQU5hkKokM=
Received: by mail-qt1-f182.google.com with SMTP id n6-v6so14845677qtl.4;
        Mon, 01 Oct 2018 10:11:08 -0700 (PDT)
X-Gm-Message-State: ABuFfog+Pqw8IVFnjFjPZusgQkMMZFdlc6g4xr4mB9vaE5AVids+zjV9
        gJvc9kTTClYTJQoWlWGBtr0XfFlzS408Fz6qug==
X-Google-Smtp-Source: ACcGV60lO+BPU6O8XsXefBW0T3/yU8b7Wctk79plwgNua7poYYFXr58PXWC5/j+J5r+NG5i4hu01jTzqMxaWkYiZ9TA=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr9398912qtj.327.1538413867616;
 Mon, 01 Oct 2018 10:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
 <20180926213509.GA7454@bogus> <20181001124605.jxiechvp6ztvh77p@qschulz>
In-Reply-To: <20181001124605.jxiechvp6ztvh77p@qschulz>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Oct 2018 12:10:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLKNfFDPqev9uubrMn0cz04E5-BKA5dbcwfkzVePKy4LA@mail.gmail.com>
Message-ID: <CAL_JsqLKNfFDPqev9uubrMn0cz04E5-BKA5dbcwfkzVePKy4LA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/11] dt-bindings: phy: add DT binding for
 Microsemi Ocelot SerDes muxing
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Miller <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        allan.nielsen@microchip.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Oct 1, 2018 at 7:46 AM Quentin Schulz
<quentin.schulz@bootlin.com> wrote:
>
> Hi Rob,
>
> I'm not sure I've understood the way you wanted me to so let me know if
> I'm not on the right path.
>
> On Wed, Sep 26, 2018 at 04:35:09PM -0500, Rob Herring wrote:
> > On Fri, Sep 14, 2018 at 10:16:05AM +0200, Quentin Schulz wrote:
> > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > ---
> > >  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt | 40 +++++++-
> > >  1 file changed, 40 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > > new file mode 100644
> > > index 0000000..2a88cc3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > > @@ -0,0 +1,40 @@
> > > +Microsemi Ocelot SerDes muxing driver
> > > +-------------------------------------
> > > +
> > > +On Microsemi Ocelot, there is a handful of registers in HSIO address
> > > +space for setting up the SerDes to switch port muxing.
> > > +
> > > +A SerDes X can be "muxed" to work with switch port Y or Z for example.
> > > +One specific SerDes can also be used as a PCIe interface.
> > > +
> > > +Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
> > > +
> > > +There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> > > +half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
> > > +10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> > > +
> > > +Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> > > +QSGMII.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: should be "mscc,vsc7514-serdes"
> > > +- #phy-cells : from the generic phy bindings, must be 2.
> > > +          The first number defines the input port to use for a given
> > > +          SerDes macro. The second defines the macro to use. They are
> > > +          defined in dt-bindings/phy/phy-ocelot-serdes.h
> >
> > You need to define what this is a child of.
> >
>
> This is a child of the HSIO syscon on the Microsemi Ocelot. I don't
> expect all Microsemi SoCs that could use this driver to have the SerDes
> node in the HSIO syscon.
>
> Among the latest additions in Documentation/devicetree/bindings/phy I
> couldn't find anything close to my understanding of "define what this is
> a child of", could you elaborate on what you want exactly?

Essentially what you've said here, but specifically what is the
compatible property of the HSIO syscon (the specific one, not
"syscon").

> > > +
> > > +Example:
> > > +
> > > +   serdes: serdes {
> > > +           compatible = "mscc,vsc7514-serdes";
> > > +           #phy-cells = <2>;
> >
> > However, if there are no other resources associated with this, then you
> > don't even need this child node. The parent can be a phy provider and
> > provider of other functions too.
> >
>
> The parent is a syscon with multiple features (SerDes, PLL
> configuration, temp sensor, SyncE, ...) so I'm not sure it's possible to
> do what you're asking me to. For now, there is only a SerDes node but
> ultimately there'll be more than one I guess.

There's no reason you can't have:

syscon {
  compatible = "some-soc-syscon-block";
  #clock-cells = <1>;
  #phy-cells = <2>;
  ...
};

As it stands, you only have a child node because you want to
instantiate some driver. A single node can be multiple providers and
DT is not the only way to instantiate drivers.

This could change if your sub-nodes need child nodes as well (e.g.
pinctrl) or have their own resources such as clocks, interrupts, etc.
But with an incomplete binding, I can't really tell you what makes
sense.

Rob
