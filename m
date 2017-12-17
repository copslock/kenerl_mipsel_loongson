Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Dec 2017 17:59:43 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:42233
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdLQQ7hM80Fl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Dec 2017 17:59:37 +0100
Received: by mail-io0-x244.google.com with SMTP id x67so1297790ioi.9;
        Sun, 17 Dec 2017 08:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pazk3p0n8bEWa3m8ODZ6jQHVbQSh5ZiEJtYXlUVo+CA=;
        b=UR5xAYFFEXvIO4fMEucuVH3uuVsAWPEQBDZ39oG7dyhqS7hanC4OJLGJw2hSVFQM4D
         Q5CfbBb9QxhB69lmb3WIIhKkATnucvlfc6lq0GsKrzK4QNwAh8tIJPPNU4UgJpYaaH/i
         XoQUp9PjNzaidcibChkMJT/XCga+oqWBN7oicfzhDIuhqV6qUtkgyHk8gTD7aAWaw6IU
         wxJ2NRDXGQs0nlU3u0JGl2BfpdCzc431EbxkhqM39fBLfsf5Lw1TCPbTosAlNmJv+2QT
         8O3NzkWORjTTCNWMBPmCCAL0Q2WYP7tndJfyqmOhHnBhQNWSiOhhg0m+eKqDleI+JTHW
         eN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pazk3p0n8bEWa3m8ODZ6jQHVbQSh5ZiEJtYXlUVo+CA=;
        b=gMzyy1kvvzV3XnH41JojDvEaGcrbfzw05yHpEzD6IPkbjPfCOK+5rmFgo1uDIMBPqe
         hg9uiq6DKrwE3FhnZ3RXEOQsAu4BDjzoobfQH0g6K83zIOvyfzVxpKG0TQWU2fowl1L5
         y4nsdy/8GIT6ZtJMvOYT7QskxYSc9eMaMwGyNYUCGGC9a0z2JnIRgMQI0OaZTpJsTOu0
         mgZhXpCG+NUBwZJXW+BdIIxwVcdxmOreZTlg02n0mdOEoFH6K4s+8JyOV1Qtdk3CoiLR
         xVJJ3052DckXknZmZGbtlWwfKgyZ4n3ywdw+mCRjQoYrAQ7DWhI4vv8VgyeJsJ9klUMM
         sA9Q==
X-Gm-Message-State: AKGB3mKbv3PBD9KdblvxqPcxlkPCmen4ibqbTtmitx35G+aRNmTchbyy
        yakhqErytBytkaRlXa4YdvEqb+81VEPn226I3+E=
X-Google-Smtp-Source: ACJfBos6fKlO24fxPw/jHmr3BTTkhYiLd0i2zsao8YtSiXolW2s3QPLS3czoxsIci96N9V04Pl2dwyAjMouH7dMGsgE=
X-Received: by 10.107.97.16 with SMTP id v16mr18831202iob.263.1513529970690;
 Sun, 17 Dec 2017 08:59:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Sun, 17 Dec 2017 08:59:30 -0800 (PST)
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sun, 17 Dec 2017 22:29:30 +0530
Message-ID: <CANc+2y5t8RRvuSsVvAJRNtfFx_T0wCGsSVd7Vb03boiX8AnbUw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] MIPS: add support for the Microsemi MIPS SoCs
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Alexandre,

With very small amount of code in arch/mips this series looks really nice.

On 8 December 2017 at 21:16, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> This patch series adds initial support for the Microsemi MIPS SoCs. It
> is currently focusing on the Microsemi Ocelot (VSC7513, VSC7514).
>
> It adds support for the IRQ controller, pinmux and gpio controller and
> reset control.
>
> This produces a kernel that can boot to the console.
>
> This is a single series for reference but it can also be taken
> separately by each maintainer as each drivers are independant.
>
> Changes in v2:
>  - removed the wildcard in MAINAINERS
>  - corrected the Cc list
>  - added proper documentation for both syscons
>  - removed the mscc,cpucontrol property
>  - updated the ranges property in the ocelot dtsi
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
>
>
> Alexandre Belloni (13):
>   dt-bindings: Add vendor prefix for Microsemi Corporation
>   dt-bindings: interrupt-controller: Add binding for the Microsemi
>     Ocelot interrupt controller
>   irqchip: Add a driver for the Microsemi Ocelot controller
>   dt-bindings: pinctrl: Add bindings for Microsemi Ocelot
>   pinctrl: Add Microsemi Ocelot SoC driver
>   dt-bindings: mips: Add bindings for Microsemi SoCs
>   dt-bindings: power: reset: Document ocelot-reset binding
>   power: reset: Add a driver for the Microsemi Ocelot reset
>   MIPS: mscc: Add initial support for Microsemi MIPS SoCs
>   MIPS: mscc: add ocelot dtsi
>   MIPS: mscc: add ocelot PCB123 device tree
>   MIPS: defconfigs: add a defconfig for Microsemi SoCs
>   MAINTAINERS: Add entry for Microsemi MIPS SoCs
>
>  .../interrupt-controller/mscc,ocelot-icpu-intr.txt |  22 +
>  Documentation/devicetree/bindings/mips/mscc.txt    |  46 ++
>  .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       |  39 ++
>  .../bindings/power/reset/ocelot-reset.txt          |  17 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  MAINTAINERS                                        |   7 +
>  arch/mips/Kbuild.platforms                         |   1 +
>  arch/mips/Kconfig                                  |  24 +
>  arch/mips/boot/dts/Makefile                        |   1 +
>  arch/mips/boot/dts/mscc/Makefile                   |   6 +
>  arch/mips/boot/dts/mscc/ocelot.dtsi                | 115 +++++
>  arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |  27 ++
>  arch/mips/configs/mscc_defconfig                   |  84 ++++
>  arch/mips/mscc/Makefile                            |  11 +
>  arch/mips/mscc/Platform                            |  12 +
>  arch/mips/mscc/setup.c                             | 106 +++++
>  drivers/irqchip/Kconfig                            |   5 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-mscc-ocelot.c                  | 109 +++++
>  drivers/pinctrl/Kconfig                            |  10 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-ocelot.c                   | 505 +++++++++++++++++++++
>  drivers/power/reset/Kconfig                        |   7 +
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/ocelot-reset.c                 |  86 ++++
>  25 files changed, 1244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
>  create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>  create mode 100644 arch/mips/boot/dts/mscc/Makefile
>  create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
>  create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
>  create mode 100644 arch/mips/configs/mscc_defconfig
>  create mode 100644 arch/mips/mscc/Makefile
>  create mode 100644 arch/mips/mscc/Platform
>  create mode 100644 arch/mips/mscc/setup.c
>  create mode 100644 drivers/irqchip/irq-mscc-ocelot.c
>  create mode 100644 drivers/pinctrl/pinctrl-ocelot.c
>  create mode 100644 drivers/power/reset/ocelot-reset.c
>
> --
> 2.15.1
>
>

Except for irqchip driver and pinctrl driver other parts of the series is
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar
