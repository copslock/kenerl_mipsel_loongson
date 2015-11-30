Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:24:51 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:53506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008064AbbK3WYqkSutc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 23:24:46 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id BA2F82044B;
        Mon, 30 Nov 2015 22:24:44 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E075D20443;
        Mon, 30 Nov 2015 22:24:42 +0000 (UTC)
Date:   Mon, 30 Nov 2015 16:24:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>
Subject: Re: [PATCH 1/2] reset: Add brcm,bcm63xx-reset device tree binding
Message-ID: <20151130222440.GA3420@rob-hp-laptop>
References: <565CB83B.7010000@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565CB83B.7010000@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50240
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

On Mon, Nov 30, 2015 at 08:57:31PM +0000, Simon Arlott wrote:
> Add device tree binding for the BCM63xx soft reset controller.
> 
> The BCM63xx contains a soft-reset controller activated by setting
> a bit (that must previously have cleared).
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  .../bindings/reset/brcm,bcm63xx-reset.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt b/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
> new file mode 100644
> index 0000000..48e9daf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
> @@ -0,0 +1,37 @@
> +BCM63xx reset controller
> +
> +The BCM63xx contains a basic soft reset controller in the perf register
> +set which resets components using a bit in a register.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible:	Should be "brcm,bcm<soc>-reset", "brcm,bcm63xx-reset"
> +- regmap:	The register map phandle
> +- offset:	Offset in the register map for the reset register (in bytes)
> +- #reset-cells:	Must be set to 1
> +
> +Optional properties:
> +- mask:		Mask of valid reset bits in the reset register (32 bit access)
> +		(Defaults to all bits)

The bits correspond to the cell values in resets properties? If so then, 
is this really needed? If you are only validating cell values against 
this mask, then drop it (assume the DT does not have crap).

Rob

> +
> +Example:
> +
> +periph_soft_rst: reset-controller {
> +	compatible = "brcm,bcm63168-reset", "brcm,bcm63xx-reset";
> +	regmap = <&periph_cntl>;
> +	offset = <0x10>;
> +
> +	#reset-cells = <1>;
> +};
> +
> +usbh: usbphy@10002700 {
> +	compatible = "brcm,bcm63168-usbh";
> +	reg = <0x10002700 0x38>;
> +	clocks = <&periph_clk 13>, <&timer_clk 18>;
> +	resets = <&periph_soft_rst 6>;
> +	power-supply = <&power_usbh>;
> +	#phy-cells = <0>;
> +};
> +
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
