Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 17:41:32 +0100 (CET)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:63086 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011323AbaJ0Ql3ONkU9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 17:41:29 +0100
Received: by mail-ig0-f171.google.com with SMTP id l13so6667963iga.4
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 09:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/kyP5N7dRdsUOxgSnwDGVPlZyyjY0a6OjKbI13reJcw=;
        b=Kn/+ugXGak7j775qsH4yZPCAFPROAl5TmZkPrXCNNHWI5+++gVsNPHwU4dAy9VGRjh
         ryUODLdfGGjCq/8sDxBBRptG+a7C+lGuxFjLaUgzkEIwogd/5/JuSBdaoW/M2H4zPU3z
         xut786OIR0cWmK0XaAfhyNbMXyOFbzGNQYm6vIlNAiMf88qv3bSeiahBVgzT/J+k7CZd
         qBX16rn9EssEBfF6sjhUK6vn02naEZty/90ReOr/Tmipnop7ulqLg/JSOh+I7woYRMns
         FMj8i6iOSAXSB/ggtcZQ/I39JCCrSIAmja+fTpT033F+FywYKiKxF3nswOYo8MaLHKss
         zu4Q==
X-Gm-Message-State: ALoCoQnih+sGEHszhsq1J/YkIWRI8cX5sk6YNx78ad1ofKuuEi7+2kzOK41mFyaobRyaCzJOamYQ
MIME-Version: 1.0
X-Received: by 10.42.114.201 with SMTP id h9mr2848096icq.94.1414428083407;
 Mon, 27 Oct 2014 09:41:23 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Mon, 27 Oct 2014 09:41:23 -0700 (PDT)
In-Reply-To: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
Date:   Mon, 27 Oct 2014 17:41:23 +0100
Message-ID: <CACRpkdYR=ha+Q9-cRdtXVtuLvQnAEA8h9fgeQ8SpcNrXX-QO+A@mail.gmail.com>
Subject: Re: [PATCH 1/5] DT: Add documentation for gpio-rt2880
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43600
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

On Fri, Oct 10, 2014 at 10:28 PM, John Crispin <blogic@openwrt.org> wrote:

> Describe gpio-rt2880 binding.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> ---
>  .../devicetree/bindings/gpio/gpio-rt2880.txt       |   40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rt2880.txt
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt b/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt
> new file mode 100644
> index 0000000..b4acf02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt
> @@ -0,0 +1,40 @@
> +Ralink SoC GPIO controller bindings
> +
> +Required properties:
> +- compatible:
> +  - "ralink,rt2880-gpio" for Ralink controllers
> +- #gpio-cells : Should be two.
> +  - first cell is the pin number
> +  - second cell is used to specify optional parameters (unused)
> +- gpio-controller : Marks the device node as a GPIO controller
> +- reg : Physical base address and length of the controller's registers
> +- interrupt-parent: phandle to the INTC device node
> +- interrupts : Specify the INTC interrupt number
> +- ralink,num-gpios : Specify the number of GPIOs
> +- ralink,register-map : The register layout depends on the GPIO bank and actual
> +               SoC type. Register offsets need to be in this order.
> +               [ INT, EDGE, RENA, FENA, DATA, DIR, POL, SET, RESET, TOGGLE ]
> +
> +Optional properties:
> +- ralink,gpio-base : Specify the GPIO chips base number

NAK. This is a Linux-internal number. It is not OS-neutral.

Yours,
Linus Walleij
