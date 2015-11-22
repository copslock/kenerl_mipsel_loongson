Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 23:14:00 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:55315 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKVWN6D25CM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 23:13:58 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 3D934206B6;
        Sun, 22 Nov 2015 22:13:56 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD18206B2;
        Sun, 22 Nov 2015 22:13:54 +0000 (UTC)
Date:   Sun, 22 Nov 2015 16:13:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 3/4] watchdog: Add brcm,bcm6345-wdt device tree binding
Message-ID: <20151122221352.GA13686@rob-hp-laptop>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C047.6040303@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5650C047.6040303@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50058
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

On Sat, Nov 21, 2015 at 07:04:39PM +0000, Simon Arlott wrote:
> Add device tree binding for the BCM6345 watchdog.
> 
> This uses the BCM6345 timer for its warning interrupt.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/watchdog/brcm,bcm6345-wdt.txt         | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt
> new file mode 100644
> index 0000000..9d852d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt
> @@ -0,0 +1,35 @@
> +BCM6345 Watchdog timer
> +
> +Required properties:
> +
> +- compatible: should be "brcm,bcm63<soc>-wdt", "brcm,bcm6345-wdt"
> +- reg: Specifies base physical address and size of the registers.
> +- clocks: Specify the clock used for timing
> +
> +Optional properties:
> +
> +- interrupt-parent: phandle to the interrupt controller
> +- interrupts: Specify the interrupt used for the watchdog timout warning
> +- timeout-sec: Contains the default watchdog timeout in seconds
> +
> +Example:
> +
> +watchdog {
> +	compatible = "brcm,bcm63168-wdt", "brcm,bcm6345-wdt";
> +	reg = <0x1000009c 0x0c>;
> +	clocks = <&periph_clk>;
> +
> +	interrupt-parent = <&timer>;
> +	interrupts = <3>;
> +	timeout-sec = <30>;
> +};
> +
> +watchdog {
> +	compatible = "brcm,bcm6318-wdt", "brcm,bcm6345-wdt";
> +	reg = <0x10000068 0x0c>;
> +	clocks = <&periph_clk>;
> +
> +	interrupt-parent = <&timer>;
> +	interrupts = <3>;
> +	timeout-sec = <30>;
> +};
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
