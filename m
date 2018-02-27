Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2018 16:55:09 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:43643 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990864AbeB0PzBnCURC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Feb 2018 16:55:01 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ACA1D2087E; Tue, 27 Feb 2018 16:54:53 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 76FB32087A;
        Tue, 27 Feb 2018 16:54:43 +0100 (CET)
Date:   Tue, 27 Feb 2018 16:54:44 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] MIPS: mscc: add ocelot PCB123 device tree
Message-ID: <20180227155444.GB15333@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
 <20180214170042.GE3986@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214170042.GE3986@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62724
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

On 14/02/2018 at 17:00:42 +0000, James Hogan wrote:
> On Tue, Jan 16, 2018 at 11:12:38AM +0100, Alexandre Belloni wrote:
> > Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Please Cc DT folk.
> 

I can do but again, I don't think they care.

> > diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> > new file mode 100644
> > index 000000000000..42bd404471f6
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/* Copyright (c) 2017 Microsemi Corporation */
> > +
> > +/dts-v1/;
> > +
> > +#include "ocelot.dtsi"
> > +
> > +/ {
> > +	compatible = "mscc,ocelot-pcb123", "mscc,ocelot";
> 
> Should mscc,ocelot-pcb123 be added to the mscc DT binding documentation
> in the other patch?
> 

On ARM at least, we don't document the board compatibles because this
will be a huge list without much benefit as they are mostly unused.
Still, it is nice to have in case something specific needs to be done
for a particular board (and hopefully this never happens).

also, I don't think any other MIPS boards are documented bu if you
insist, I can either add it in
Documentation/devicetree/bindings/mips/mscc.txt or create a new file to
list all the mips board compatibles.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
