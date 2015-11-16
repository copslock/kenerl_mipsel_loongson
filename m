Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 13:35:59 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:59515 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012318AbbKPMfyZ450X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 13:35:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5983F28098D
        for <linux-mips@linux-mips.org>; Mon, 16 Nov 2015 13:33:55 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com [209.85.217.171])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 22AA428058C
        for <linux-mips@linux-mips.org>; Mon, 16 Nov 2015 13:33:33 +0100 (CET)
Received: by lbbkw15 with SMTP id kw15so87412572lbb.0
        for <linux-mips@linux-mips.org>; Mon, 16 Nov 2015 04:35:30 -0800 (PST)
X-Received: by 10.112.172.138 with SMTP id bc10mr16404358lbc.74.1447677330228;
 Mon, 16 Nov 2015 04:35:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.162.78 with HTTP; Mon, 16 Nov 2015 04:35:10 -0800 (PST)
In-Reply-To: <5648B804.40806@simon.arlott.org.uk>
References: <5648B804.40806@simon.arlott.org.uk>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 16 Nov 2015 13:35:10 +0100
X-Gmail-Original-Message-ID: <CAOiHx=kM8b5+1HWPOYFUABUH6LCL85K+pqe7fK_beQQpEYfR4Q@mail.gmail.com>
Message-ID: <CAOiHx=kM8b5+1HWPOYFUABUH6LCL85K+pqe7fK_beQQpEYfR4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: bmips: Add bcm63168-l1 interrupt controller
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,


On Sun, Nov 15, 2015 at 5:51 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> Add device tree binding for the BCM63168 interrupt controller.

Well, that's what I get for waiting for -rc1, I also planned to submit
irqchip drivers[1] for bcm63xx/bmips for the next window ;p.

>
> This controller is similar to the SMP-capable BCM7038 and
> the BCM3380 but with packed interrupt registers.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
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

Usually I would go by which SoC introduced it, and AFAICT tell BCM6358
was the first with per-CPU irq blocks, but since I don't see anything
preventing it to be used with the older, single thread SoCs, the
driver/binding would even support BCM6345's one.

> +
> +This block is a first level interrupt controller that is typically connected
> +directly to one of the HW INT lines on each CPU.
> +
> +Key elements of the hardware design include:
> +
> +- 64 or 128 incoming level IRQ lines

Which, in this case, has 32 incoming IRQ lines.

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

It's a bit strange using the newer chip name for older chips, so I
suggest using brcm,bcm6345-l1-intc or brcm,bcm6358-l1-intc (I went
with bcm6345-periph-intc, to avoid the l1/l2 discussion).

Also I'm not sure whether BCM63168 or BCM63268 is the right name for
the family, as Broadcom seems to use the latter in their LDKs.

Furthermore, it's always good to specify that it should contain a
brcm,bcm<soc>-l1-intc, in case one ever needs to tell them apart.

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

interrupt-controller@10000020

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


Regards
Jonas

[1] https://github.com/openwrt/openwrt/blob/master/target/linux/brcm63xx/patches-4.1/320-irqchip-add-support-for-bcm6345-style-periphery-irq-.patch
