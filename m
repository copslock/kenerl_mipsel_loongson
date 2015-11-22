Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 22:56:30 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:54623 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKVV42IG2AM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 22:56:28 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id EFCB420606;
        Sun, 22 Nov 2015 21:56:25 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8825C205FC;
        Sun, 22 Nov 2015 21:56:24 +0000 (UTC)
Date:   Sun, 22 Nov 2015 15:56:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 09/14] DEVICETREE: Add bindings for PIC32 usart driver
Message-ID: <20151122215622.GA32221@rob-hp-laptop>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-10-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448065205-15762-10-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50055
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

On Fri, Nov 20, 2015 at 05:17:21PM -0700, Joshua Henderson wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
> 
> Document the devicetree bindings for the USART peripheral found on
> Microchip PIC32 class devices.
> 
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>  .../bindings/serial/microchip,pic32-usart.txt      |   29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt b/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
> new file mode 100644
> index 0000000..c87321c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
> @@ -0,0 +1,29 @@
> +* Microchip Universal Synchronous Asynchronous Receiver/Transmitter (USART)
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32-usart"

Again, should be more specific.

> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- pinctrl: Should contain pinctrl for TX/RX/RTS/CTS
> +
> +Optional properties:
> +- microchip,uart-has-rtscts : Indicate the uart has hardware flow control
> +- rts-gpios: RTS pin for USP-based UART if microchip,uart-has-rtscts
> +- cts-gpios: CTS pin for USP-based UART if microchip,uart-has-rtscts

This appears to just be copied for Sirf UART.

Doesn't *-gpios being present imply having h/w 
flow-control (i.e. microchip,uart-has-rtscts)?

Rob

> +
> +Example:
> +	usart0: serial@1f822000 {
> +		compatible = "microchip,pic32-usart";
> +		reg = <0x1f822000 0x50>;
> +		interrupts = <UART1_FAULT DEFAULT_INT_PRI IRQ_TYPE_NONE>,
> +			     <UART1_RECEIVE_DONE DEFAULT_INT_PRI IRQ_TYPE_NONE>,
> +			     <UART1_TRANSFER_DONE DEFAULT_INT_PRI IRQ_TYPE_NONE>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <
> +			&pinctrl_uart1
> +			&pinctrl_uart1_cts
> +			&pinctrl_uart1_rts>;
> +		microchip,uart-has-rtscts;
> +		cts-gpios = <&pioB 15 0>;
> +		rts-gpios = <&pioD 1 0>;
> +	};
> -- 
> 1.7.9.5
> 
