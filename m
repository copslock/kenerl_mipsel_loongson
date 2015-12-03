Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 09:39:13 +0100 (CET)
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36639 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007359AbbLCIjKdwszV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 09:39:10 +0100
Received: from paszta.hi.pengutronix.de ([2001:67c:670:100:96de:80ff:fec2:9969] helo=paszta)
        by metis.ext.pengutronix.de with esmtp (Exim 4.80)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1a4PPt-0003Dq-9y; Thu, 03 Dec 2015 09:39:05 +0100
Message-ID: <1449131943.3339.8.camel@pengutronix.de>
Subject: Re: [PATCH (v2) 1/2] reset: Add brcm,bcm6345-reset device tree
 binding
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date:   Thu, 03 Dec 2015 09:39:03 +0100
In-Reply-To: <565F5C96.5090700@simon.arlott.org.uk>
References: <565F5C96.5090700@simon.arlott.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:96de:80ff:fec2:9969
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <p.zabel@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.zabel@pengutronix.de
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

Hi Simon,

Am Mittwoch, den 02.12.2015, 21:03 +0000 schrieb Simon Arlott:
> Add device tree binding for the BCM6345 soft reset controller.
> 
> The BCM6345 contains a soft-reset controller activated by setting
> a bit (that must previously have cleared).
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> Renamed to bcm6345, removed "mask" property.
> 
>  .../bindings/reset/brcm,bcm6345-reset.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
> new file mode 100644
> index 0000000..bb9ca6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
> @@ -0,0 +1,33 @@
> +Broadcom BCM6345 reset controller
> +
> +The BCM6345 contains a basic soft reset controller in the perf register
> +set which resets components using a bit in a register.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible:	Should be "brcm,bcm<soc>-reset", "brcm,bcm6345-reset"

> +- regmap:	The register map phandle
> +- offset:	Offset in the register map for the reset register (in bytes)

Is this something the device tree maintainers are happy with?
I see there are already some regmap properties in the device tree, but
in this case it looks to me like the reset controller node should be a
child of the periph_cntl node as that register space is the only means
of controlling it.

> +- #reset-cells:	Must be set to 1
> +
> +Example:
> +
> +periph_soft_rst: reset-controller {
> +	compatible = "brcm,bcm63168-reset", "brcm,bcm6345-reset";
> +	regmap = <&periph_cntl>;
> +	offset = <0x10>;
> +
> +	#reset-cells = <1>;
> +};

I would have written it something like this:

periph_cntl: ... {
	compatible = "syscon", "simple-mfd";
	#address-cells = <1>;
	#size-cells = <1>;

	periph_soft_rst: reset-controller {
		compatible = "brcm,bcm6345-reset";
		reg = <0x10 0x4>;
		#reset-cells = <1>;
	};
};

for a device that is only controlled through a syscon.
The driver itself looks good to me.

best regards
Philipp
