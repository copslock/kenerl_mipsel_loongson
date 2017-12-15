Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 23:07:55 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:39755 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994660AbdLOWHq5aHKc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 23:07:46 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id D323B20999; Fri, 15 Dec 2017 23:07:40 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id ADDB320810;
        Fri, 15 Dec 2017 23:07:40 +0100 (CET)
Date:   Fri, 15 Dec 2017 23:07:41 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 07/13] dt-bindings: power: reset: Document
 ocelot-reset binding
Message-ID: <20171215220741.GE7022@piout.net>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-8-alexandre.belloni@free-electrons.com>
 <20171215202332.bn47da3fpkynusno@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215202332.bn47da3fpkynusno@rob-hp-laptop>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61492
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

On 15/12/2017 at 14:23:32 -0600, Rob Herring wrote:
> On Fri, Dec 08, 2017 at 04:46:12PM +0100, Alexandre Belloni wrote:
> > Add binding documentation for the Microsemi Ocelot reset block.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  .../devicetree/bindings/power/reset/ocelot-reset.txt    | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> > new file mode 100644
> > index 000000000000..1bcf276b04cb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> > @@ -0,0 +1,17 @@
> > +Microsemi Ocelot reset controller
> > +
> > +The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
> > +SoC MIPS core.
> > +
> > +Required Properties:
> > + - compatible: "mscc,ocelot-chip-reset"
> > +
> > +Example:
> > +	syscon@71070000 {
> > +		compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
> > +		reg = <0x71070000 0x1c>;
> > +
> > +		reset {
> > +			compatible = "mscc,ocelot-chip-reset";
> 
> Why do you need a subnode here other than as a way to instantiate a 
> driver? Can you describe the SOFT_RST register in reg property here 
> (without having overlapping regions)?

You mean like:

reset@7107001c {
	compatible = "mscc,ocelot-chip-reset";
	reg = <0x7107001c 0x4>;
};

I guess that could work.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
