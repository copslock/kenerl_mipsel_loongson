Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2015 21:00:54 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:46730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013855AbbLOUAoiP3Sw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Dec 2015 21:00:44 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 25DE4203B0;
        Tue, 15 Dec 2015 20:00:42 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E129202C8;
        Tue, 15 Dec 2015 20:00:40 +0000 (UTC)
Date:   Tue, 15 Dec 2015 14:00:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 09/14] DEVICETREE: Add bindings for PIC32 UART driver
Message-ID: <20151215200037.GA26863@rob-hp-laptop>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
 <1450133093-7053-10-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450133093-7053-10-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50633
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

On Mon, Dec 14, 2015 at 03:42:11PM -0700, Joshua Henderson wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
> 
> Document the devicetree bindings for the UART peripheral found on
> Microchip PIC32 class devices.
> 
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/serial/microchip,pic32-uart.txt       |   29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt b/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
> new file mode 100644
> index 0000000..65b38bf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
> @@ -0,0 +1,29 @@
> +* Microchip Universal Asynchronous Receiver Transmitter (UART)
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32mzda-uart"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- clocks: Phandle to the clock.
> +          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- pinctrl-names: A pinctrl state names "default" must be defined.
> +- pinctrl-0: Phandle referencing pin configuration of the UART peripheral.
> +             See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
> +
> +Optional properties:
> +- cts-gpios: CTS pin for UART
> +
> +Example:
> +	uart1: serial@1f822000 {
> +		compatible = "microchip,pic32mzda-uart";
> +		reg = <0x1f822000 0x50>;
> +		interrupts = <112 IRQ_TYPE_LEVEL_HIGH>,
> +			<113 IRQ_TYPE_LEVEL_HIGH>,
> +			<114 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&PBCLK2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_uart1
> +				&pinctrl_uart1_cts
> +				&pinctrl_uart1_rts>;
> +		cts-gpios = <&gpio1 15 0>;
> +	};
> -- 
> 1.7.9.5
> 
