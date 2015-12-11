Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 04:49:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:58247 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006195AbbLKDtFAEExD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 04:49:05 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id C87302055D;
        Fri, 11 Dec 2015 03:49:02 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC74020547;
        Fri, 11 Dec 2015 03:49:00 +0000 (UTC)
Date:   Thu, 10 Dec 2015 21:48:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH linux-next (v2) 1/2] clk: Add brcm,bcm6345-gate-clk
 device tree binding
Message-ID: <20151211034859.GA7982@rob-hp-laptop>
References: <5669F361.60405@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5669F361.60405@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50542
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

On Thu, Dec 10, 2015 at 09:49:21PM +0000, Simon Arlott wrote:
> Add device tree binding for the BCM6345's gated clocks.
> 
> The BCM6345 contains clocks gated with a register. Clocks are indexed
> by bits in the register and are active high. Most MIPS-based BCM63xx
> SoCs have a clock gating set of registers, but some have clock gate bits
> interleaved with other status bits and configurable clocks in the same
> register.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> v2: Added clock-indices, clock-output-names (from clock-bindings.txt),
>     these are required properties.
> 
> v1: Renamed from BCM63xx to BCM6345.
> 
>  .../bindings/clock/brcm,bcm6345-gate-clk.txt       | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt b/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt
> new file mode 100644
> index 0000000..a6e264c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt
> @@ -0,0 +1,62 @@
> +Broadcom BCM6345 clocks
> +
> +This binding uses the common clock binding:
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +The BCM6345 contains clocks gated with a register. Clocks are indexed
> +by bits in the register and are active high. Most MIPS-based BCM63xx
> +SoCs have a clock gating set of registers, but some have clock gate bits
> +interleaved with other status bits and configurable clocks in the same
> +register.
> +
> +Required properties:
> +- compatible:         Should be "brcm,bcm<soc>-gate-clk", "brcm,bcm6345-gate-clk"
> +- #clock-cells:       Should be <1>.
> +- regmap:             The register map phandle
> +- offset:             Offset in the register map for the clock register (in bytes)
> +- clocks:             The external oscillator clock phandle
> +- clock-indices:      The bits in the register used for gated clocks.
> +- clock-output-names: Should be a list of strings of clock output signal
> +                      names indexed by the clock indices.
> +
> +Example:
> +
> +periph_clk: periph_clk {
> +	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm6345-gate-clk";
> +	regmap = <&periph_cntl>;
> +	offset = <0x4>;
> +
> +	#clock-cells = <1>;
> +	clock-indices =
> +		<1>,          <2>,        <3>,       <4>,     <5>,
> +		<6>,          <7>,        <8>,       <9>,     <10>,
> +		<11>,         <12>,       <13>,      <14>,    <15>,
> +		<16>,         <17>,       <18>,      <19>,    <20>,
> +		<27>,         <31>;
> +	clock-output-names =
> +		"vdsl_qproc", "vdsl_afe", "vdsl",    "mips",  "wlan_ocp",
> +		"dect",       "fap0",     "fap1",    "sar",   "robosw",
> +		"pcm",        "usbd",     "usbh",    "ipsec", "spi",
> +		"hsspi",      "pcie",     "phymips", "gmac",  "nand",
> +		"tbus",       "robosw250";
> +};
> +
> +timer_clk: timer_clk {
> +	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm6345-gate-clk";
> +	regmap = <&timer_cntl>;
> +	offset = <0x4>;
> +
> +	#clock-cells = <1>;
> +	clock-indices = <17>, <18>;
> +	clock-output-names = "uto_extin", "usb_ref";
> +};
> +
> +ehci0: usb@10002500 {
> +	compatible = "brcm,bcm63168-ehci", "brcm,bcm6345-ehci", "generic-ehci";
> +	reg = <0x10002500 0x100>;
> +	big-endian;
> +	interrupt-parent = <&periph_intc>;
> +	interrupts = <10>;
> +	clocks = <&periph_clk 13>, <&timer_clk 18>;
> +	phys = <&usbh>;
> +};
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
