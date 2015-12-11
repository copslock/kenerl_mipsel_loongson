Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 04:47:35 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:58171 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006195AbbLKDr2MSFmD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 04:47:28 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E0A452056D;
        Fri, 11 Dec 2015 03:47:25 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403F420562;
        Fri, 11 Dec 2015 03:47:24 +0000 (UTC)
Date:   Thu, 10 Dec 2015 21:47:22 -0600
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
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH linux-next (v3) 1/2] reset: Add brcm,bcm6345-reset device
 tree binding
Message-ID: <20151211034722.GA6667@rob-hp-laptop>
References: <5669EE86.8030406@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5669EE86.8030406@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50541
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

On Thu, Dec 10, 2015 at 09:28:38PM +0000, Simon Arlott wrote:
> Add device tree binding for the BCM6345 soft reset controller.
> 
> The BCM6345 contains a soft-reset controller activated by setting
> a bit (that must previously have been cleared).
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> v3: Resend. Example has changed because usbh now has two compatible
>     strings and uses a power domain instead of a regulator.

Not really all that important to this binding definition, so you can 
keep my ack.

> 
> v2: Renamed to bcm6345, removed "mask" property.
>     Acked-by: Rob Herring <robh@kernel.org>
> 
>  .../bindings/reset/brcm,bcm6345-reset.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
> new file mode 100644
> index 0000000..0313040
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
> +
> +usbh: usbphy@10002700 {
> +	compatible = "brcm,bcm63168-usbh", "brcm,bcm6328-usbh";
> +	reg = <0x10002700 0x38>;
> +	clocks = <&periph_clk 13>, <&timer_clk 18>;
> +	resets = <&periph_soft_rst 6>;
> +	power-domains = <&misc_iddq_ctrl 4>;
> +	#phy-cells = <0>;
> +};
> +
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
