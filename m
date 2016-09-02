Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 14:54:47 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35812 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992029AbcIBMykcDYMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 14:54:40 +0200
Received: by mail-oi0-f68.google.com with SMTP id 2so4278938oif.2;
        Fri, 02 Sep 2016 05:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSyM+jYXBw4+p7s2q5DQDJzx5MLTcsJM9RCmD/aHPVk=;
        b=Ondw1Wq2ycUlczF/VR3UQcbtg8bqXOf+SXROiKQ/dMIZ08sqbhEmD45JuNplMU2nPj
         kV4z8Uol/Qrw9uxnVoEPNUxygIyE7jwt4bpgQLP5EWOTHRPDbH4WNWW2phr2Hgrrf2DX
         D9H6v0SY5rPpZwNfo2bVbqzHmOHYv3GMTxzNKlUQesuFv2TwXlt42+gBu8bkhNBe57zp
         E6iDTmDqQMzm3p8EUtoFdn/Lma+7pLOrZ4Fx5vka1ZmmQzOCJVB94rVX0ibYUBZ24PgP
         GEg4CnGqmqcgpkg/uceLBXQ5hlCGDgvUz4pQ8c5zhInMH3UjHCAPVE5lWolDPMX9msaa
         cUug==
X-Gm-Message-State: AE9vXwNy18qUD6W0MndMcOSOZfhxMhxu5N4vxj6bQtGulSsyqP1nsRLEWFA1WGjoa5+7eA==
X-Received: by 10.202.93.197 with SMTP id r188mr18749452oib.88.1472820874660;
        Fri, 02 Sep 2016 05:54:34 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id c134sm2183137oih.10.2016.09.02.05.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 05:54:34 -0700 (PDT)
Date:   Fri, 2 Sep 2016 07:54:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 24/26] dt-bindings: Document img,boston-clock binding
Message-ID: <20160902125433.GA4066@rob-hp-laptop>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-25-paul.burton@imgtec.com>
 <20160826174446.GX19826@codeaurora.org>
 <f0633969-1df4-64c9-a003-8745ad331bc8@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0633969-1df4-64c9-a003-8745ad331bc8@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54992
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

On Tue, Aug 30, 2016 at 04:53:01PM +0100, Paul Burton wrote:
> On 26/08/16 18:44, Stephen Boyd wrote:
> > On 08/26, Paul Burton wrote:
> >> diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> >> new file mode 100644
> >> index 0000000..c01ea60
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> >> @@ -0,0 +1,27 @@
> >> +Binding for Imagination Technologies MIPS Boston clock sources.
> >> +
> >> +This binding uses the common clock binding[1].
> >> +
> >> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> +
> >> +Required properties:
> >> +- compatible : Should be "img,boston-clock".
> >> +- #clock-cells : Should be set to 1.
> >> +  Values available for clock consumers can be found in the header file:
> >> +    <dt-bindings/clock/boston-clock.h>
> >> +- regmap : Phandle to the Boston platform register system controller.
> >> +  This should contain a phandle to the system controller node covering the
> >> +  platform registers provided by the Boston board.
> >> +
> >> +Example:
> >> +
> >> +	clk_boston: clock {
> >> +		compatible = "img,boston-clock";
> >> +		#clock-cells = <1>;
> >> +		regmap = <&plat_regs>;
> > 
> > Isn't syscon more standard than regmap as the property name? Is
> > there a binding for the plat_regs device? Is there any reason the
> > clks can't be populated in that syscon driver?
> 
> Hi Stephen,
> 
> The plat_regs device doesn't have a custom driver, it simply makes use
> of the generic "syscon" driver which can provide a regmap.
> 
> It would be possible to register the clocks from a register for the
> plat_regs device, but I don't think it would make much sense. The
> platform registers in question are essentially just a convenient place
> where various bits of information about the system are exposed,
> including the clock frequencies but also other bits & pieces like
> connectivity of PCIe controllers or I/O coherence units, the RTL
> revision of the CPU or the wrapper RTL that runs on this FPGA-based
> board, a register that allows for resetting the board, etc. It's not a
> single piece of hardware, more a dumping ground for miscellanea. So in
> my opinion using the syscon approach works best here, and drivers for
> well defined pieces of hardware or functionality can reference that
> syscon to retrieve the regmap.

That is all quite common for any SoC. Whether it's 2 nodes or 2 drivers 
are independent questions. You can easily have 1 node and 2 drivers. The 
decision factor is really how many registers we're dealing with. We 
don't want to end up with a node per register or register field. That's 
too fine grained.

> As for whether "syscon" is a more standard property name than "regmap",
> both seem to be used based on a grep of
> Documentation/devicetree/bindings/. I believe I picked up use of
> "regmap" from the generic syscon-poweroff & syscon-reboot drivers, which
> both use "regmap" as a property name.

syscon is much more common.

Avoid the phandle altogether and make this a child node.

Rob
