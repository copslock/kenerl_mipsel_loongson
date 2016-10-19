Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 02:46:15 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:53237 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993008AbcJSAqIDvGqo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 02:46:08 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3FFE61AD2; Wed, 19 Oct 2016 00:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1476837966;
        bh=O6PIbPE+soDwk7QeN9CULsLjTJhKj18e9dSAiNoJIig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpPrs7qN6CLYZdfIygylcnteWu4OORWXPlEJR9vgcwi6GQLo3EBiUjfHK2FRSA7j0
         uq8gIqjgnH03zQlfgsBFKXIS28KhpcGL/ljSlla8pT2Fv7GSvYO+C+X3E6qf47NPZq
         VYVQkn2m2BphEdc1ocs8roWsBz5FN7uXNwM8+0xE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C61D861AD1;
        Wed, 19 Oct 2016 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1476837964;
        bh=O6PIbPE+soDwk7QeN9CULsLjTJhKj18e9dSAiNoJIig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkHlwG0Ujm0SzGQirrwUZsa7RQhNIzJItNdR0HTSP4BShjC8R4pWtn70TQkjtwEkj
         VqOVngYFcDqGX07mbNM0G4V6z3zB90fwEKxisHZPSuYtUvjm3Ub9u+qF2u9V8X2Htk
         6nI39YqbIRSQEvKfTf5K3503OScT1tdS/7vctoq0=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org C61D861AD1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=sboyd@codeaurora.org
Date:   Tue, 18 Oct 2016 17:46:04 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 16/18] dt-bindings: Document img,boston-clock binding
Message-ID: <20161019004604.GS8871@codeaurora.org>
References: <20161005171824.18014-1-paul.burton@imgtec.com>
 <2468748.fALFhzhDcI@np-p-burton>
 <CAL_Jsq+PkQmkkLMjiurmHegewpc6n_ntUMsik8oMZdM2nXHQ6g@mail.gmail.com>
 <2330857.F1IQS18Qic@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2330857.F1IQS18Qic@np-p-burton>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 10/11, Paul Burton wrote:
> On Tuesday, 11 October 2016 15:06:46 BST Rob Herring wrote:
> > On Tue, Oct 11, 2016 at 11:00 AM, Paul Burton <paul.burton@imgtec.com> 
> wrote:
> > > On Monday, 10 October 2016 08:01:21 BST Rob Herring wrote:
> > >> On Wed, Oct 05, 2016 at 06:18:22PM +0100, Paul Burton wrote:
> > >> > Add device tree binding documentation for the clocks provided by the
> > >> > MIPS Boston development board from Imagination Technologies, and a
> > >> > header file describing the available clocks for use by device trees &
> > >> > driver.
> > >> > 
> > >> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > >> > Cc: Michael Turquette <mturquette@baylibre.com>
> > >> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > >> > Cc: linux-clk@vger.kernel.org
> > >> > Cc: Rob Herring <robh+dt@kernel.org>
> > >> > Cc: Mark Rutland <mark.rutland@arm.com>
> > >> > Cc: devicetree@vger.kernel.org
> > >> > 
> > >> > ---
> > >> > 
> > >> > Changes in v3: None
> > >> > Changes in v2:
> > >> > - Add BOSTON_CLK_INPUT to expose the input clock.
> > >> > 
> > >> >  .../devicetree/bindings/clock/img,boston-clock.txt | 27
> > >> >  ++++++++++++++++++++++ include/dt-bindings/clock/boston-clock.h
> > >> >  
> > >> >   | 14 +++++++++++ 2 files changed, 41 insertions(+)
> > >> >  
> > >> >  create mode 100644
> > >> >  Documentation/devicetree/bindings/clock/img,boston-clock.txt create
> > >> >  mode
> > >> >  100644 include/dt-bindings/clock/boston-clock.h
> > >> > 
> > >> > diff --git
> > >> > a/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> > >> > b/Documentation/devicetree/bindings/clock/img,boston-clock.txt new file
> > >> > mode 100644
> > >> > index 0000000..c01ea60
> > >> > --- /dev/null
> > >> > +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> > >> > @@ -0,0 +1,27 @@
> > >> > +Binding for Imagination Technologies MIPS Boston clock sources.
> > >> > +
> > >> > +This binding uses the common clock binding[1].
> > >> > +
> > >> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > >> > +
> > >> > +Required properties:
> > >> > +- compatible : Should be "img,boston-clock".
> > >> > +- #clock-cells : Should be set to 1.
> > >> > +  Values available for clock consumers can be found in the header
> > >> > file:
> > >> > +    <dt-bindings/clock/boston-clock.h>
> > >> > +- regmap : Phandle to the Boston platform register system controller.
> > >> > +  This should contain a phandle to the system controller node covering
> > >> > the
> > >> > +  platform registers provided by the Boston board.
> > >> 
> > >> Can you just make the clock node a child of the system controller and
> > >> drop this?
> > >> 
> > >> Rob
> > > 
> > > Hi Rob,
> > > 
> > > (Apologies to anyone who received my last; my mail client seems to be
> > > misconfigured & previously sent HTML mail.)
> > > 
> > > As I mentioned before technically that could be done, but it would really
> > > not be at all reflective of the hardware & so seems somewhat contrary to
> > > the purpose of a device tree.
> > 
> > Given that you need a reference back to the system controller, it does
> > match the h/w. The system controller h/w contains various functions,
> > therefore the system controller node should contain nodes for those
> > functions (or the sys ctrlr itself could be the clock provider node
> > with no child nodes). Otherwise, what is the parent of the clock node?
> > Root? Root should generally be the top level devices of the SoC,
> > though it gets used for things which have no good parent.
> > 
> > Rob
> 
> Hi Rob,
> 
> The "system controller" here is a bunch of registers which contain information 
> about the system - nothing more & nothing less. There are a few random bits of 
> functionality such as system level reset exposed through them, but things like 
> clocks are not part of some coherent block of hardware known as the system 
> controller. The register exposing information about the clocks has no actual 
> connection to the clocks at all - it's just a dumb register whose value is 
> filled in by whomever generates the FPGA bitfile. 

This sounds pretty much how every clk controller or syscon/mfd is
made. A dumb register set that controls a bunch of hard macros
placed by hardware designers. It just so happens that there are
other things in this register set that aren't clk controls.

> I don't see how that can be 
> reasonably seen as the clocks being a child of this ecclectic bunch of 
> registers.

Can you further describe what being a child device means to you?
There must be some reason why a child device is wrong from your
perspective that isn't coming across here.

> 
> Perhaps the use of syscon has been misleading here? I'm using the syscon code 
> purely as a nice way to obtain a regmap to that bunch of registers. Please 
> believe me when I say I know this hardware well enough to know that there 
> isn't a coherent block of system controller hardware that provides the clocks 
> here.
> 

The problem I have, from a DT perspective, is that the clks are
not on the board. Clks that live on the board go to the root of
the DT tree under / or some container clks node. In this case the
clks are in the SoC, so they should go into the SoC node, not the
root. But the SoC node should have a reg property for each child
node, and this node wouldn't have a reg property because it uses
a regmap, so from a DT perspective that's also the wrong place to
put this node.

Therefore, the best solution is to make the clk controller node a
child of the syscon, and then the reg property doesn't exist in
the clk controller node. This also nicely removes any linuxism of
needing to have a regmap property (regmap is not really a
hardware concept and is fairly linux specific) because we can
grab the regmap handle from the parent device/node.

Technically having the child node for the clk controller part is
abusing DT. We should really only have one node for the syscon,
which probes a driver that then creates platform devices in
software to match up with other drivers for the specific
functions that are accessible through the dumb register set. But
since we have MFD/syscons quite often, and things get sort of
messy when all these different things are going on within one
node and thus one big driver, we allow MFDs to be described in DT
with sub-nodes that are for the sub-functions so that we can have
drivers match up appropriately. Otherwise we're left with a big
driver for the MFD that becomes sort of like a board file to
register sub devices, or a mash up of all these different
functions that use one struct device.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
