Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 16:34:53 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:35612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012765AbbKPPeuL8VDk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 16:34:50 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E5B8120529;
        Mon, 16 Nov 2015 15:34:46 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10AB920522;
        Mon, 16 Nov 2015 15:34:44 +0000 (UTC)
Date:   Mon, 16 Nov 2015 09:34:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/2] MIPS: bmips: Add bcm63168-l1 interrupt controller
Message-ID: <20151116153443.GA13799@rob-hp-laptop>
References: <5648B804.40806@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5648B804.40806@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49942
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

On Sun, Nov 15, 2015 at 04:51:16PM +0000, Simon Arlott wrote:
> Add device tree binding for the BCM63168 interrupt controller.
> 
> This controller is similar to the SMP-capable BCM7038 and
> the BCM3380 but with packed interrupt registers.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../interrupt-controller/brcm,bcm63168-l1-intc.txt | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm63168-l1-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm63168-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm63168-l1-intc.txt
> new file mode 100644
> index 0000000..636a6db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm63168-l1-intc.txt
> @@ -0,0 +1,57 @@
> +Broadcom BCM63168-style Level 1 interrupt controller
> +
> +This block is a first level interrupt controller that is typically connected
> +directly to one of the HW INT lines on each CPU.
> +
> +Key elements of the hardware design include:
> +
> +- 64 or 128 incoming level IRQ lines
> +
> +- Most onchip peripherals are wired directly to an L1 input
> +
> +- A separate instance of the register set for each CPU, allowing individual
> +  peripheral IRQs to be routed to any CPU
> +
> +- Contains one or more enable/status word pairs per CPU
> +
> +- No atomic set/clear operations
> +
> +- No polarity/level/edge settings
> +
> +- No FIFO or priority encoder logic; software is expected to read all
> +  2-4 status words to determine which IRQs are pending
> +
> +Required properties:
> +
> +- compatible: should be "brcm,bcm63168-l1-intc"
> +- reg: specifies the base physical address and size of the registers;
> +  the number of supported IRQs is inferred from the size argument
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 1.
> +- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
> +  this one is cascaded from
> +- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
> +  node; valid values depend on the type of parent interrupt controller
> +
> +If multiple reg ranges and interrupt-parent entries are present on an SMP
> +system, the driver will allow IRQ SMP affinity to be set up through the
> +/proc/irq/ interface.  In the simplest possible configuration, only one
> +reg range and one interrupt-parent is needed.
> +
> +The driver operates in native CPU endian by default, there is no support for
> +specifying an alternative endianness.
> +
> +Example:
> +
> +periph_intc: periph_intc@10000000 {
> +        compatible = "brcm,bcm63168-l1-intc";
> +        reg = <0x10000020 0x20>,
> +              <0x10000040 0x20>;
> +
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        interrupt-parent = <&cpu_intc>;
> +        interrupts = <2>, <3>;
> +};
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
