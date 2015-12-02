Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 19:13:46 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34104 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007502AbbLBSNlYudFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 19:13:41 +0100
Received: by igvg19 with SMTP id g19so123833897igv.1
        for <linux-mips@linux-mips.org>; Wed, 02 Dec 2015 10:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fmez9AUheUJkLbEk5ZJ58B8S35OiX/6tfkehLy/mvQU=;
        b=SAP2PUyhnECby6t0e38ORyOy4TgYXPzHGxUFrwLz285Dqvl09Lprml89Yh3fRQpDML
         OxNrxSVQwAHwyreMTGe1heliUM4fhsDcK9CpU3z4JA8LxT0hWs+fRD/fQZqSECqo+zVt
         6rjZKIcCar/z87wb9x6VwDoIuTti7S7xXAvJMdOiro6Rc7TBINAjt7btWpps4JAfB6gh
         P2MoLpYqla8NbNXBarfP/drzYY4nxBonhO5c/QwxwMA/J1uShZ63WeFmD1f7WClZWTob
         0knmZfQExKBE4t8KwnZQz1ZKRly5ILyW3+k59p1ZxRDVt70Q7GGFp5Nug9u1KJWhBR97
         kZXA==
X-Received: by 10.50.143.12 with SMTP id sa12mr2506639igb.82.1449080015472;
 Wed, 02 Dec 2015 10:13:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.17 with HTTP; Wed, 2 Dec 2015 10:12:56 -0800 (PST)
In-Reply-To: <565CB727.7030209@simon.arlott.org.uk>
References: <565CB727.7030209@simon.arlott.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed, 2 Dec 2015 10:12:56 -0800
Message-ID: <CAGVrzcYsjN+5Mvhasx7gqcqdzjJuzTekWwAWfMqjNrF9c7m9Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: Add brcm,bcm63xx-gate-clk device tree binding
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2015-11-30 12:52 GMT-08:00 Simon Arlott <simon@fire.lp0.eu>:
> Add device tree binding for the BCM63xx's gated clocks.
>
> The BCM63xx contains clocks gated with a register. Clocks are indexed
> by bits in the register and are active high. Clock gate bits are
> interleaved with other status bits and configurable clocks in the same
> register.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  .../bindings/clock/brcm,bcm63xx-gate-clk.txt       | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
> new file mode 100644
> index 0000000..3f4ead1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
> @@ -0,0 +1,58 @@
> +Broadcom BCM63xx clocks
> +
> +This binding uses the common clock binding:
> +       Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +The BCM63xx contains clocks gated with a register. Clocks are indexed
> +by bits in the register and are active high. Clock gate bits are
> +interleaved with other status bits and configurable clocks in the same
> +register.

Most MIPS-based BCM63xx SoCs have clock gating set of registers, these
SoCs are pretty much all of them except 63381 (maybe newer ones too),
this one uses the PMB interface, like 63138 to control resets and
clocks fed to peripherals.

> +
> +Required properties:
> +- compatible:  Should be "brcm,bcm<soc>-gate-clk", "brcm,bcm63xx-gate-clk"

I think we would want to start with the lowest common denominator
here, which is either 6345 or 6348.
--
Florian
