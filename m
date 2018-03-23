Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:02:06 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:46444 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeCWVB6oZ4S1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 22:01:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=LXEe5WfqIEFIWaR0y5MMwkTrKbhdRgsvcVjcGjcM0AA=;
        b=0WqHITuMihSDCwHovGqzrflq/CPjIVjLypyXnTkQrrTrQJgBU3gcERxXF7QhG6JpGMgV2QH3owT3QecNmhg2KtUt+pJ+NA4H3tOY0YiHUXrYV/8YP6j6CNFspLOl+81NuC6Za9Mk0L+jEPQPzzxyZZ1t0Gt5NGWiN4C45dg9KGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ezTom-0005Xr-L7; Fri, 23 Mar 2018 22:01:44 +0100
Date:   Fri, 23 Mar 2018 22:01:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
Message-ID: <20180323210144.GT24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63192
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

On Fri, Mar 23, 2018 at 09:11:13PM +0100, Alexandre Belloni wrote:
> DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> new file mode 100644
> index 000000000000..ee092a85b5a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -0,0 +1,62 @@
> +Microsemi Ocelot network Switch
> +===============================
> +
> +The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
> +VSC7514)
> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-switch"
> +- reg: Must contain an (offset, length) pair of the register set for each
> +  entry in reg-names.
> +- reg-names: Must include the following entries:
> +  - "sys"
> +  - "rew"
> +  - "qs"
> +  - "hsio"
> +  - "qsys"
> +  - "ana"
> +  - "portX" with X from 0 to the number of last port index available on that
> +    switch
> +- interrupts: Should contain the switch interrupts for frame extraction and
> +  frame injection
> +- interrupt-names: should contain the interrupt names: "xtr", "inj"
> +
> +Example:
> +
> +	switch@1010000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "mscc,ocelot-switch";
> +		reg = <0x1010000 0x10000>,
> +		      <0x1030000 0x10000>,
> +		      <0x1080000 0x100>,
> +		      <0x10d0000 0x10000>,
> +		      <0x11e0000 0x100>,
> +		      <0x11f0000 0x100>,
> +		      <0x1200000 0x100>,
> +		      <0x1210000 0x100>,
> +		      <0x1220000 0x100>,
> +		      <0x1230000 0x100>,
> +		      <0x1240000 0x100>,
> +		      <0x1250000 0x100>,
> +		      <0x1260000 0x100>,
> +		      <0x1270000 0x100>,
> +		      <0x1280000 0x100>,
> +		      <0x1800000 0x80000>,
> +		      <0x1880000 0x10000>;
> +		reg-names = "sys", "rew", "qs", "hsio", "port0",
> +			    "port1", "port2", "port3", "port4", "port5",
> +			    "port6", "port7", "port8", "port9", "port10",
> +			    "qsys", "ana";
> +		interrupts = <21 22>;
> +		interrupt-names = "xtr", "inj";
> +
> +		port0: port@0 {
> +			reg = <0>;
> +			phy-handle = <&phy0>;
> +		};
> +		port1: port@1 {
> +			reg = <1>;
> +			phy-handle = <&phy1>;
> +		};

Hi Alexandre

Is there anything else in the switch which in the future might need
child nodes? At the moment, you can do
for_each_available_child_of_node() and walk the ports. But if you do
need to add some other sorts of children in the future it gets
messy. With DSA, we have a ports {} container.

       Andrew
