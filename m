Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2018 22:57:15 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54390 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994572AbeH0U5It3QJd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Aug 2018 22:57:08 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F127B207B0; Mon, 27 Aug 2018 22:57:03 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C786320734;
        Mon, 27 Aug 2018 22:57:03 +0200 (CEST)
Date:   Mon, 27 Aug 2018 22:57:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio
 from the list of register address spaces
Message-ID: <20180827205703.GE24549@piout.net>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180813223103.GA16669@rob-hp-laptop>
 <20180814064953.vboz2gryq4jff34n@qschulz>
 <20180814124135.GK943@piout.net>
 <20180816142514.pf4eiqeditoy4uei@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816142514.pf4eiqeditoy4uei@qschulz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 16/08/2018 16:25:14+0200, Quentin Schulz wrote:
> Hi Alexandre,
> 
> On Tue, Aug 14, 2018 at 02:41:35PM +0200, Alexandre Belloni wrote:
> > On 14/08/2018 08:49:53+0200, Quentin Schulz wrote:
> > > Understood but it's an intermediate patch. Later (patch 8), the SerDes
> > > muxing "controller" is added as a child to this node. There most likely
> > > will be some others in the future (temperature sensor for example).
> > > 
> > > Furthermore, there's already a simple-mfd without children in this file:
> > > https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mips/mscc.txt#L19
> > > 
> > > How should we handle this case?
> > > 
> > 
> > There were child nodes in previous version of the binding. You can
> > remove simple-mfd now. The useful registers that are not used by any
> > drivers are gpr and chipid.
> > 
> 
> And what about the use case I'm facing? I've got child nodes defined in
> it but with a later patch (but they actually haven't made it to the
> DT binding documentation, so that's for the next version of the patch
> series).
> 

I guess you should keep simple-mfd for hsio because it will have child
nodes.



-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
