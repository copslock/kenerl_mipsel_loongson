Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2015 21:00:08 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013855AbbLOUAFsyaUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Dec 2015 21:00:05 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id F2360203A9;
        Tue, 15 Dec 2015 20:00:03 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35063201CD;
        Tue, 15 Dec 2015 20:00:02 +0000 (UTC)
Date:   Tue, 15 Dec 2015 14:00:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/14] DEVICETREE: Add bindings for PIC32 SDHCI host
 controller
Message-ID: <20151215200000.GA26180@rob-hp-laptop>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
 <1450133093-7053-12-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450133093-7053-12-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50632
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

On Mon, Dec 14, 2015 at 03:42:13PM -0700, Joshua Henderson wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
> 
> Document the devicetree bindings for the SDHCI peripheral found on
> Microchip PIC32 class devices.
> 
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/mmc/microchip,sdhci-pic32.txt         |   29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
> new file mode 100644
> index 0000000..71ad57e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
> @@ -0,0 +1,29 @@
> +* Microchip PIC32 SDHCI Controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci-pic32 driver.
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32mzda-sdhci"
> +- interrupts: Should contain interrupt
> +- clock-names: Should be "base_clk", "sys_clk".
> +               See: Documentation/devicetree/bindings/resource-names.txt
> +- clocks: Phandle to the clock.
> +          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- pinctrl-names: A pinctrl state names "default" must be defined.
> +- pinctrl-0: Phandle referencing pin configuration of the SDHCI controller.
> +             See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
> +
> +Example:
> +
> +	sdhci@1f8ec000 {
> +		compatible = "microchip,pic32mzda-sdhci";
> +		reg = <0x1f8ec000 0x100>;
> +		interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&REFCLKO4>, <&PBCLK5>;
> +		clock-names = "base_clk", "sys_clk";
> +		bus-width = <4>;
> +		cap-sd-highspeed;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sdhc1>;
> +	};
> -- 
> 1.7.9.5
> 
