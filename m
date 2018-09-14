Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 19:02:38 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:40792 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINRCbkDjmm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 19:02:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ak5OAcbYxLE4bMySEw3+mZli71x/Nhk0YQkd91OJsPw=;
        b=Q8qgoasxgh8vNqzLSLdzmNPOhy3fN1+WIVMUw8Hj3B+7Z/KHXB6se3YlFJt/6Sfnxy3k0wPu4ZmXJYE7OqNS8p7Ir++9/XOSO4kisFxETod512QdHPUSwU5c3wp+FzTfGUcYYeQUMr0UCytNAiShHwg2BpymHZaL2ki0r7qB9tg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0rU5-00062l-MM; Fri, 14 Sep 2018 19:02:21 +0200
Date:   Fri, 14 Sep 2018 19:02:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 5/7] MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
Message-ID: <20180914170221.GB3811@lunn.ch>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914145446.GQ14988@piout.net>
 <20180914162638.fgzzjin2bzgx74de@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914162638.fgzzjin2bzgx74de@qschulz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

On Fri, Sep 14, 2018 at 06:26:38PM +0200, Quentin Schulz wrote:
> Hi Alexandre,
> 
> On Fri, Sep 14, 2018 at 04:54:46PM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 14/09/2018 11:44:26+0200, Quentin Schulz wrote:
> > > In order to use GPIO4 as a GPIO, we need to mux it in this mode so let's
> > > declare a new pinctrl DT node for it.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > ---
> > >  arch/mips/boot/dts/mscc/ocelot.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > index 8ce317c..b5c4c74 100644
> > > --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > @@ -182,6 +182,11 @@
> > >  			interrupts = <13>;
> > >  			#interrupt-cells = <2>;
> > >  
> > > +			gpio4: gpio4 {
> > > +				pins = "GPIO_4";
> > > +				function = "gpio";
> > > +			};
> > > +
> > 
> > For a GPIO, I would do that in the board dts because it is not used
> > directly in the dtsi.
> > 
> 
> And the day we've two boards using this pinctrl we move it to a dtsi. Is
> that the plan?

Hi Quentin

gpio4 appears to be pretty arbitrary. Could a different design use a
different gpio? It me, this seems like a board property.

    Andrew
