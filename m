Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 00:38:02 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:56051 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeHMWhzyagcz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2018 00:37:55 +0200
Received: by mail-it0-f66.google.com with SMTP id d10-v6so15571479itj.5;
        Mon, 13 Aug 2018 15:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zC8SElNNRpdiT8OGcQEjnA76VkKLfLotoEpRRqvzun4=;
        b=VIMmvIMIjxAZLJdmyH5WMkwAyzB00sZQn3EJg53kNBOXv9Wr2B62GJufkoG4Dt0vJu
         5w292g9xdEXL5aHCJ0NZRzqSE7cqfvLGS3N5lIfIvC0WRzgaxKgM4XFenHZSU9JVlZKx
         R1Zb53uU6HzK/7tFavHVzZzEMnUNDip8hGgdYZUdJcnrCbXnBml24AOm5qtbEei7fCZu
         ijjXJdulzI5VkGaT8GYFcuOdCnlJxM2hUURsk0jE9PGHt3VS/5gPtroBKJD5v/+A9ehp
         2OZ88QdS0YRCv6R4LJd3TWPcHDxlrx+PsmnrpJ+TWB67xACgUlXEs8iiHdbANg5CZvE0
         lszg==
X-Gm-Message-State: AOUpUlH247pbUL8C5+QARbkleXc4VT8wUTutCm+vxZvnPt1nzuD4GkWM
        C0fI2MaSBXYiwe0Xcz9LCg==
X-Google-Smtp-Source: AA+uWPyftoiJDZ3zXjkUwkPdeC1Pz9jkSPluS0tOTXuyOlxKqbob9lKt2GaW0ne1azPwyMBJTa/NLg==
X-Received: by 2002:a24:14d8:: with SMTP id 207-v6mr13178521itg.41.1534199870062;
        Mon, 13 Aug 2018 15:37:50 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b11-v6sm7526188ioc.16.2018.08.13.15.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:37:49 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:37:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180813223748.GA20086@rob-hp-laptop>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <bcea7c75-e5a6-4533-aee0-65c893e8a422@gmail.com>
 <20180801081539.gxkviv6rnpwzoyxb@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801081539.gxkviv6rnpwzoyxb@qschulz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65577
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

On Wed, Aug 01, 2018 at 10:15:39AM +0200, Quentin Schulz wrote:
> Hi Florian,
> 
> On Mon, Jul 30, 2018 at 02:39:35PM -0700, Florian Fainelli wrote:
> > On 07/30/2018 05:43 AM, Quentin Schulz wrote:
> > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > ---
> > >  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt | 42 +++++++-
> > >  1 file changed, 42 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > > new file mode 100644
> > > index 0000000..25b102d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > > @@ -0,0 +1,42 @@
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
> > > +- #phy-cells : from the generic phy bindings, must be 3. The first number
> > > +               defines the kind of Serdes (1 for SERDES1G_X, 6 for
> > > +	       SERDES6G_X), the second defines the macros in the specified
> > > +	       kind of Serdes (X for SERDES1G_X or SERDES6G_X) and the
> > > +	       last one defines the input port to use for a given SerDes
> > > +	       macro,
> > 
> > It would probably be more natural to reverse some of this and have the
> > 1st cell be the input port, while the 2nd and 3rd cell are the serdes
> > kind and the serdes macro type. Same comment as Andrew, can you please
> > define the 2nd and 3rd cells possible values in a header file that you
> > can include from both the DTS and the driver making use of that?
> 
> OK for a define for the DeviceTree part.
> 
> You want one set of defines for the values in the 2nd cell and one other
> set of defines for the 3rd cell?
> 
> I'm fine with a define for the second value (which is basically the enum
> serdes_type I've defined at the beginning of the serdes driver) but I
> don't see the point of defining the index of the SerDes. What would it
> look like?
> 
> enum serdes_type {
> 	SERDES1G = 1,
> 	SERDES6G = 6,
> }
> 
> #define SERDES1G_0	0
> #define SERDES1G_1	1
> #define SERDES1G_2	2
> #define SERDES6G_0	0
> #define SERDES6G_1	1
> 
> Then, e.g.:
> 
> &port5 {
> 	phys = <&serdes 5 SERDES1G SERDES1G_0>
> };
> 
> If you want a define for the pair (serdes_type, serdes_index), I don't
> see how I could re-use it on the driver side but it makes more sense on the
> DeviceTree side:
> 
> #define SERDES1G_0	1 0
> #define SERDES1G_1	1 1
> #define SERDES1G_2	1 2
> #define SERDES6G_0	6 0
> #define SERDES6G_1	6 1

I prefer #defines which are a single number. Otherwise if you read a dts 
file when #phy-cells is 3, it will look like an error in that you have 
what looks like 2 cells.

Rob
