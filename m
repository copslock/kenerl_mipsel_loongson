Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 17:09:32 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58561 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007819AbaLAQJaT3MRz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Dec 2014 17:09:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id DB99028BCD1;
        Mon,  1 Dec 2014 17:07:50 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com [209.85.192.51])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 856BF2805AB;
        Mon,  1 Dec 2014 17:07:48 +0100 (CET)
Received: by mail-qg0-f51.google.com with SMTP id l89so7828621qgf.10
        for <multiple recipients>; Mon, 01 Dec 2014 08:09:24 -0800 (PST)
X-Received: by 10.140.88.177 with SMTP id t46mr85463000qgd.36.1417450164781;
 Mon, 01 Dec 2014 08:09:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.95.79 with HTTP; Mon, 1 Dec 2014 08:09:04 -0800 (PST)
In-Reply-To: <1417149142-3756-9-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com> <1417149142-3756-9-git-send-email-cernekee@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 1 Dec 2014 17:09:04 +0100
Message-ID: <CAOiHx=nb4Ub_bseHUrz+HrnJxDEKMijQ=r+ASZ-p5MtTi81Big@mail.gmail.com>
Subject: Re: [PATCH V4 08/16] irqchip: Add new driver for BCM7038-style level
 1 interrupt controllers
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, computersforpeace@gmail.com,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44530
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

On Fri, Nov 28, 2014 at 5:32 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> This is the main peripheral IRQ controller on the BCM7xxx MIPS chips;
> it has the following characteristics:
>
>  - 64 to 160+ level IRQs
>  - Atomic set/clear registers
>  - Reasonably predictable register layout (N status words, then N
>    mask status words, then N mask set words, then N mask clear words)
>  - SMP affinity supported on most systems
>  - Typically connected to MIPS IRQ 2,3,2,3 on CPUs 0,1,2,3
>
> This driver registers one IRQ domain and one IRQ chip to cover all
> instances of the block.  Up to 4 instances of the block may appear, as
> it supports 4-way IRQ affinity on BCM7435.
>
> The same block exists on the ARM BCM7xxx chips, but typically the ARM GIC
> is used instead.  So this driver is primarily intended for MIPS STB chips.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  .../interrupt-controller/brcm,bcm7038-l1-intc.txt  |  52 ++++
>  drivers/irqchip/Kconfig                            |   5 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-bcm7038-l1.c                   | 335 +++++++++++++++++++++
>  4 files changed, 393 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
>  create mode 100644 drivers/irqchip/irq-bcm7038-l1.c
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
> new file mode 100644
> index 000000000000..cc217b22dccd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
> @@ -0,0 +1,52 @@
> +Broadcom BCM7038-style Level 1 interrupt controller
> +
> +This block is a first level interrupt controller that is typically connected
> +directly to one of the HW INT lines on each CPU.  Every BCM7xxx set-top chip
> +since BCM7038 has contained this hardware.
> +
> +Key elements of the hardware design include:
> +
> +- 64, 96, 128, or 160 incoming level IRQ lines
> +
> +- Most onchip peripherals are wired directly to an L1 input
> +
> +- A separate instance of the register set for each CPU, allowing individual
> +  peripheral IRQs to be routed to any CPU
> +
> +- Atomic mask/unmask operations
> +
> +- No polarity/level/edge settings
> +
> +- No FIFO or priority encoder logic; software is expected to read all
> +  2-5 status words to determine which IRQs are pending
> +
> +Required properties:
> +
> +- compatible: should be "brcm,bcm7038-l1-intc"
> +- reg: specifies the base physical address and size of the registers;
> +  the number of supported IRQs is inferred from the size argument
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 1.
> +- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
> +  this one is cascaded from

I'm not that firm in interrupt controller terminology, but can this be
a level 1 interrupt controller if it has a parent interrupt
controller? Isn't the parent the level 1 interrupt controller? Or
would the parent then be a level 0 interrupt controller? ;-)


Regards,
Jonas
