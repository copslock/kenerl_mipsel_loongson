Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 03:58:52 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007112AbbLKC6uutNAZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 03:58:50 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id A6E7520570;
        Fri, 11 Dec 2015 02:58:48 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB2AA2056D;
        Fri, 11 Dec 2015 02:58:46 +0000 (UTC)
Date:   Thu, 10 Dec 2015 20:58:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
Message-ID: <20151211025844.GA5251@rob-hp-laptop>
References: <5668AB4F.7030100@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5668AB4F.7030100@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50540
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

On Wed, Dec 09, 2015 at 10:29:35PM +0000, Simon Arlott wrote:
> The BCM6358 contains power domains controlled with a register. Power
> domains are indexed by bits in the register. Power domain bits can be
> interleaved with other status bits and clocks in the same register.
> 
> Newer SoCs with dedicated power domain registers are active low.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  .../power/brcm,bcm6358-power-controller.txt        | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
> new file mode 100644
> index 0000000..556c323
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
> @@ -0,0 +1,53 @@
> +Broadcom BCM6358 Power domain controller
> +
> +This binding uses the power domain bindings:
> +        Documentation/devicetree/bindings/power/power_domain.txt
> +
> +The BCM6358 contains power domains controlled with a register. Power
> +domains are indexed by bits in the register. Power domain bits can be
> +interleaved with other status bits and clocks in the same register.
> +
> +Newer SoCs with dedicated power domain registers are active low.
> +
> +Required properties:
> +- compatible:           Should be "brcm,bcm<soc>-power-controller", "brcm,bcm6358-power-controller"
> +- #power-domain-cells:  Should be <1>.
> +- regmap:               The register map phandle
> +- offset:               Offset in the register map for the power domain register (in bytes)
> +- power-domain-indices: The bits in the register used for power domains.

You should drop this and make the cell values be the register offsets.

> +- power-domain-names:   Should be a list of strings of power domain names
> +                        indexed by the power domain indices.

This isn't really needed anyway.

> +
> +Optional properties:
> +- active-low:           Specify that the bits are active low.

This should be implied by the compatible property.

Rob
