Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 15:30:49 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:34093 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013220AbbLDOaqxluOp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 15:30:46 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 927182045E;
        Fri,  4 Dec 2015 14:30:43 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6AF20445;
        Fri,  4 Dec 2015 14:30:39 +0000 (UTC)
Date:   Fri, 4 Dec 2015 08:30:37 -0600
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
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/2] clk: Add brcm,bcm63xx-gate-clk device tree binding
Message-ID: <20151204143037.GA3667@rob-hp-laptop>
References: <565CB727.7030209@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565CB727.7030209@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50335
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

On Mon, Nov 30, 2015 at 08:52:55PM +0000, Simon Arlott wrote:
> Add device tree binding for the BCM63xx's gated clocks.
> 
> The BCM63xx contains clocks gated with a register. Clocks are indexed
> by bits in the register and are active high. Clock gate bits are
> interleaved with other status bits and configurable clocks in the same
> register.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  .../bindings/clock/brcm,bcm63xx-gate-clk.txt       | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
> new file mode 100644
> index 0000000..3f4ead1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
> @@ -0,0 +1,58 @@
> +Broadcom BCM63xx clocks
> +
> +This binding uses the common clock binding:
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +The BCM63xx contains clocks gated with a register. Clocks are indexed
> +by bits in the register and are active high. Clock gate bits are
> +interleaved with other status bits and configurable clocks in the same
> +register.
> +
> +Required properties:
> +- compatible:	Should be "brcm,bcm<soc>-gate-clk", "brcm,bcm63xx-gate-clk"
> +- #clock-cells:	Should be <1>.
> +- regmap:	The register map phandle
> +- offset:	Offset in the register map for the reboot register (in bytes)
> +- clocks:	The external oscillator clock phandle
> +
> +Example:
> +
> +periph_clk: periph_clk {
> +	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm63xx-gate-clk";
> +	regmap = <&periph_cntl>;

What else is in periph_cntrl? Could this all just be part of that node?

Rob
