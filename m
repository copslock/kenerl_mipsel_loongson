Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2015 16:33:35 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:39081 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011488AbbKWPddhE4Vy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Nov 2015 16:33:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 61F9D28BD63;
        Mon, 23 Nov 2015 16:31:29 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com [209.85.215.42])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E5C7128058C;
        Mon, 23 Nov 2015 16:31:20 +0100 (CET)
Received: by lfdl133 with SMTP id l133so28745258lfd.2;
        Mon, 23 Nov 2015 07:33:23 -0800 (PST)
X-Received: by 10.25.39.19 with SMTP id n19mr8962181lfn.156.1448292803288;
 Mon, 23 Nov 2015 07:33:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.162.78 with HTTP; Mon, 23 Nov 2015 07:33:03 -0800 (PST)
In-Reply-To: <5650BFD6.5030700@simon.arlott.org.uk>
References: <5650BFD6.5030700@simon.arlott.org.uk>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 23 Nov 2015 16:33:03 +0100
X-Gmail-Original-Message-ID: <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
Message-ID: <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] clocksource: Add brcm,bcm6345-timer device tree binding
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
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50062
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

On Sat, Nov 21, 2015 at 8:02 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> Add device tree binding for the BCM6345 timer. This is required for the
> BCM6345 watchdog which needs to respond to one of the timer interrupts.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  .../bindings/timer/brcm,bcm6345-timer.txt          | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
> new file mode 100644
> index 0000000..2593907
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
> @@ -0,0 +1,57 @@
> +Broadcom BCM6345 Timer
> +
> +This block is a timer that is connected to one interrupt on the main interrupt
> +controller and functions as a programmable interrupt controller for timer events.
> +
> +- 3 to 4 independent timers with their own maskable level interrupt bit (but not
> +  per CPU because there is only one parent interrupt and the timers share it)
> +

This is true for the 6345 one but not the 6318/63148/63381 one, which
has one interrupt per timer (+ one extra watchdog interrupt on
6318/63148), and the parent interrupt controller supports affinity. So
you could e.g. route the timer 0 irq to cpu 0 and timer1 irq on cpu 1.

> +- 1 watchdog timer with an unmaskable level interrupt
> +
> +- Contains one enable/status word pair
> +
> +- No atomic set/clear operations
> +
> +The lack of per CPU ability of timers makes them unusable as a set of
> +clockevent devices, otherwise they could be attached to the remaining
> +interrupts.
> +
> +The BCM6318 also has a separate interrupt for every timer except the watchdog.
> +
> +Required properties:
> +
> +- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6345-timer"

Since bcm6318 uses a slightly different register layout than the
earlier SoCs, I'd argue that using bcm6345-timer as a compatible for
bcm6318 is wrong.


Jonas
