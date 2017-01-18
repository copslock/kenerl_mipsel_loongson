Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 00:50:46 +0100 (CET)
Received: from mail-qt0-x22b.google.com ([IPv6:2607:f8b0:400d:c0d::22b]:36863
        "EHLO mail-qt0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993904AbdARXuffXIve (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 00:50:35 +0100
Received: by mail-qt0-x22b.google.com with SMTP id k15so38651001qtg.3
        for <linux-mips@linux-mips.org>; Wed, 18 Jan 2017 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q/TVNCyjSc/eLWfngR+wRq64ekXVIRlwMJofznd9htc=;
        b=AjOnRn0Bx90PnAexGvAIYDBFizrRkygUcWSEctsB0ETiJ2foo2VTf62+NZcj2MMXV+
         hs9sNF8KebmIb6G6RZfilirLHF6c8/XV59xfCl55usU02fJO9kcRmHh4zBlixnDkGabb
         aizHTBIk8Qi8ma1kW+blPVyYERw/ivhHK7OZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q/TVNCyjSc/eLWfngR+wRq64ekXVIRlwMJofznd9htc=;
        b=SI01Gv+xdi5FJLWIWDaVHqi0fS10ICOuMdO+CQwCZT3bocL2OL7njT7uqHgiyC9FkG
         GnS6Fp/GL6Pamhrf1RLQeMc5VO7UTfP6w+pXPSvW0C92wMLwRAeC7ASet+VeEA7quO0D
         AHi2YNZ/5044gber2+QzwxHadjSrubHfKRslavZPiPGe4rCfr1ieVPYGme1DcVAGO3/u
         6S6jVeUNtOeWJNJppyTwj/nivj+xZczthIV1lRQzL64UjanooVn5A0tUJg2k+1n25Fr1
         U2kyBKGY/9e9B5Q4aY7D3iJO9S1Hc1ZBIgbmN/2369wVTwWHBq4VOondf+woAFTyJMab
         cqrA==
X-Gm-Message-State: AIkVDXJ92eAU+edOR5DmqXo2QShUuXgANgnMR/BJh8iowgnmzAgMjBCt7uWE/iDafXCRZ+SsKiq4t8mJC5GQR1Vf
X-Received: by 10.237.33.185 with SMTP id l54mr5795849qtc.111.1484783430016;
 Wed, 18 Jan 2017 15:50:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.177.145 with HTTP; Wed, 18 Jan 2017 15:50:29 -0800 (PST)
In-Reply-To: <20170117231421.16310-6-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-6-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Jan 2017 00:50:29 +0100
Message-ID: <CACRpkdZ-2-mOiEwiRUoMU+X4RG1jik7edPK0nsu_kYy5Pi7N1g@mail.gmail.com>
Subject: Re: [PATCH 05/13] MIPS: jz4740: DTS: Add node for the jz4740-pinctrl driver
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
X-archive-position: 56404
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

> For a description of the devicetree node, please read
> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

(...)

> +       pinctrl: ingenic-pinctrl@10010000 {
> +               compatible = "ingenic,jz4740-pinctrl";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               gpio-chips {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       gpa: gpa {
> +                               reg = <0x10010000 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <28>;
> +
> +                               ingenic,pull-ups = <0xffffffff>;
> +                       };
> +
> +                       gpb: gpb {
> +                               reg = <0x10010100 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <27>;
> +
> +                               ingenic,pull-ups = <0xffffffff>;
> +                       };
> +
> +                       gpc: gpc {
> +                               reg = <0x10010200 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <26>;
> +
> +                               ingenic,pull-ups = <0xffffffff>;
> +                       };
> +
> +                       gpd: gpd {
> +                               reg = <0x10010300 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <25>;
> +
> +                               ingenic,pull-ups = <0xdfffffff>;
> +                       };
> +               };

Just pull all these down two levels and make them one device
each instead of having them inside the pin controller node
like this.

Then make a pin controller node separately, it can reference the
pin controller by phandles if necessary, and use the standard
gpio-ranges property to cross make GPIO and pin control.

It seems you driver is similar to for example the
drivers/pinctrl/nomadik/* pin controller.

Look in arch/arm/boot/dts/ste-dbx500.dtsi for examples,
NB: I'm not fully using standard bindings in it, because they
were not invented at the time.

Yours,
Linus Walleij
