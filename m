Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 00:45:35 +0100 (CET)
Received: from mail-qt0-x22f.google.com ([IPv6:2607:f8b0:400d:c0d::22f]:36468
        "EHLO mail-qt0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993887AbdARXpZqJiQe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 00:45:25 +0100
Received: by mail-qt0-x22f.google.com with SMTP id k15so38456848qtg.3
        for <linux-mips@linux-mips.org>; Wed, 18 Jan 2017 15:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YbXkbb3a0Vw7KEdeRoG/aAebW83Ums2CTCrZebU7vzM=;
        b=OaxqF+Rfkb+nEnJjQ3bbPyAPffYfch0xxGAQNROwS+/VNvVwwNYj1Dyc1HO7uPdkuz
         2cmNkLs51nOJZm+ZDxktjxbXKnyeyG1UpUK3v8mGNfl43jIJbq3LDmc4v2no+B8VxKaF
         /Q/jz1zEBEEEci47SkNLL2hFztuqnQ1yjT4EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YbXkbb3a0Vw7KEdeRoG/aAebW83Ums2CTCrZebU7vzM=;
        b=RZvCZXQ3XZrnX0Ae1Wr71VRaIj0HzLbmwDqKH7RsqjD42NAR5y94Vy99W0+Vjvkqji
         zTDOo7kathcUU0xoJ54fT1fy41wVa00n6CDVxZxnIPb0ERKX0NUZdkoSjPKKJFniZslu
         QX++aEXBAgxIQM/9MTaM129mwvNk+7rwrK3jy47qEyNLVm6DrAUQ/NuWKyfPBgcjxTze
         Tm9fyRXdSvZk01gY1dVRf3aJUZwr0o4kJJNItebJPx8CBElo3ZDkmHoCYFxtNSXjcQMr
         YL9L3JOUuo5J7mR6vFk34Rn6FbyZHv8jys0tMMf5Yn1odjaY/oVoBXAlrU423KLCEZ0m
         wGCQ==
X-Gm-Message-State: AIkVDXIJJ6g6woWKzkJvI/XdeWiNUsqM9ntqyFDdtI1vqzvQ63fUsVQ+6RJaGbPs2Fa3h2DF338H/iZMew0RZtmi
X-Received: by 10.237.52.37 with SMTP id w34mr5742532qtd.173.1484783119973;
 Wed, 18 Jan 2017 15:45:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.177.145 with HTTP; Wed, 18 Jan 2017 15:45:19 -0800 (PST)
In-Reply-To: <20170117231421.16310-2-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-2-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Jan 2017 00:45:19 +0100
Message-ID: <CACRpkdZAGHHpCyR4d8dJv=hTRTS6-zkX-2-GarLXnNf_2QO2UQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] Documentation: dt/bindings: Document pinctrl-ingenic
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> From: Paul Burton <paul.burton@imgtec.com>
>
> This commit adds documentation for the devicetree bidings of the
> pinctrl-ingenic driver, which handles pin configuration, pin muxing
> and GPIOs of the Ingenic SoCs currently supported by the Linux kernel.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

(...)

> +##### 'gpio-chips' sub-node #####
> +
> +The gpio-chips node will contain sub-nodes that correspond to GPIO controllers
> +(one sub-node per GPIO controller).
> +
> +Required properties:
> +- #address-cells: Should contain the integer 1.
> +- #size-cells: Should contain the integer 1.
> +- ranges: Should be empty.

I do not see why the GPIO needs a special subnode. Can the pin controller
and the GPIO not simply spawn from a single node?

> +##### GPIO controller node #####
> +
> +Each subnode of the 'gpio-chips' node is a GPIO controller node.
> +
> +Required properties:
> +- gpio-controller: Identifies this node as a GPIO controller.
> +- #gpio-cells: Should contain the integer 2.
> +- reg: Should contain the physical address and length of the GPIO controller's
> +  configuration registers.
> +
> +Optional properties:
> +- interrupt-controller: The GPIO controllers can optionally configure the
> +  GPIOs as interrupt sources. In this case, the 'interrupt-controller'
> +  standalone property should be supplied.
> +- #interrupt-cells: Required if 'interrupt-controller' is also specified.
> +  In that case, it should contain the integer 2.
> +- interrupts: Required if 'interrupt-controller' is also specified.
> +  In that case, it should contain the IRQ number of this GPIO controller.
> +- ingenic,pull-ups: A bit mask identifying the pins associated with this GPIO
> +  port which feature a pull-up resistor. The default mask is 0x0.
> +- ingenic,pull-downs: A bit mask identifying the pins associated with this GPIO
> +  port which feature a pull-down resistor. The default mask is 0x0.

So these bits tell us which lines have a pull up and pull down resistor?

Isn't that readily know from the compatible string? Then just hardcode
that into the driver for each variant, there is no need to define that in
the device tree.

> +##### Pin function node #####
> +
> +Each subnode of the 'functions' node is a pin function node.
> +
> +These subnodes represent a functionality of the SoC which may be exposed
> +through one or more groups of pins, represented as subnodes of the pin
> +function node. For example a function may be uart0, which may be exposed
> +through the group of pins PF0 to PF3.
> +
> +Required pin function node properties:
> +- None.
> +
> +
> +##### Pin group node #####
> +
> +Each subnode of a pin function node is a pin group node.
> +
> +Required pin group node properties:
> +- ingenic,pins: A set of values representing the pins within this pin group and
> +  their configuration.

Look into using the standard pins property from the pinctrl bindings
if yoy want to do this.

> Four values should be provided for each pin:
> +  - The phandle of the GPIO controller node for the GPIO port within which the
> +    pin is found.
> +  - The index of the pin within its GPIO port (an integer in the range 0 to 31
> +    inclusive).

This is already supported by gpio ranges, please do not reimplement
stuff we already have.

> +  - The index of the shared function port to be programmed in the GPIO port
> +    registers for this pin.

I don't see why this can not be stored in the driver.
But some people prefer to shovel everything into the device
tree, I don't know. Can you elaborate why this should be in the
device tree?

> +  - The phandle of a pin configuration node specifying the electrical
> +    configuration that should be applied to the pin.

Why? This is something the standard pin control states handles.
I'm confused.

> +For example the function 'msc0' may be exposed through 2 different pin groups,
> +one in GPIO port A and one in GPIO port E:
> +
> +  bias-configs {
> +    nobias: nobias {
> +      bias-disable;
> +    };
> +  };
> +
> +  functions {
> +    pinfunc_msc0: msc0 {
> +      pins_msc0_pa: msc0-pa {
> +        ingenic,pins = <&gpa  4 1 &nobias   /* d4 */
> +                        &gpa  5 1 &nobias   /* d5 */
> +                        &gpa  6 1 &nobias   /* d6 */
> +                        &gpa  7 1 &nobias   /* d7 */
> +                        &gpa 18 1 &nobias   /* clk */
> +                        &gpa 19 1 &nobias   /* cmd */
> +                        &gpa 20 1 &nobias   /* d0 */
> +                        &gpa 21 1 &nobias   /* d1 */
> +                        &gpa 22 1 &nobias   /* d2 */
> +                        &gpa 23 1 &nobias   /* d3 */
> +                        &gpa 24 1 &nobias>; /* rst */
> +      };

Please look at other bindings and drivers and read pinctrl.txt
closely. This makes no sense to me compared to other
examples.

This is something that seems to cross-mix gpio ranges
and pin config, that doesn't work for me, we can't have an
idiomatic binding like this. I understand that it may fit your
single usecase perfectly but it will be a maintenance nightmare
for me.

Yours,
Linus Walleij
