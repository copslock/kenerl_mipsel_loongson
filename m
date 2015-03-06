Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 12:37:16 +0100 (CET)
Received: from mail-oi0-f54.google.com ([209.85.218.54]:37242 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012677AbbCFLhOVSX0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 12:37:14 +0100
Received: by oigi138 with SMTP id i138so17127638oig.4
        for <linux-mips@linux-mips.org>; Fri, 06 Mar 2015 03:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cImJa/xVz8eLzAiFmvWdMApl/eftg/L5MiE0ym8ex/E=;
        b=dt6Db8VAS2rmvMNgtiq1FM8S3fwkHiRlCjVeZy2NyPp4AU56xeIszNcLr+i5VG+KJT
         S3TfAoGOiq4mcxNYw7Wms1gQQN1a90RvPik1tiF5qThXJ/TzhRjfv31UqxLn1eGdMRIO
         Zdhz6Y/geatGPbraLj5/jCYen3h6j1J7Uy9IGvVuxAQGBJCANI4LgiTedBSDgx+Lomf1
         WGzUPgd85Dagm9ezptypFEXRzTcrXH48C3lUtBf0SfybhGI/1T2aEh4EoGrrTl0WagAJ
         Jp+LWrqEf0CzBrDlaDi7MFDMUYe8/weUNL6aZXwaX0ioHe9SwIOgSQ8OUh5b27USwbvz
         Ym6g==
X-Gm-Message-State: ALoCoQkwrTh/N8nePychh1wXLk60bewtmm60aXPrcUzGJt4g5l8jLEGN9LZyFRarBuvdIUn7xy2v
MIME-Version: 1.0
X-Received: by 10.182.97.134 with SMTP id ea6mr10650814obb.21.1425641829131;
 Fri, 06 Mar 2015 03:37:09 -0800 (PST)
Received: by 10.182.132.45 with HTTP; Fri, 6 Mar 2015 03:37:09 -0800 (PST)
In-Reply-To: <1424744104-14151-2-git-send-email-abrestic@chromium.org>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <1424744104-14151-2-git-send-email-abrestic@chromium.org>
Date:   Fri, 6 Mar 2015 12:37:09 +0100
Message-ID: <CACRpkdbCavYLk-Uo8hjTrGcGLJe6NEB9dVPVNm_fyd3eGccnEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: Add Pistachio SoC pin control binding document
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46229
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

On Tue, Feb 24, 2015 at 3:15 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:

> Add a device-tree binding document for the pin controller present
> on the IMG Pistachio SoC.
>
> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
(...)
> +Note that the GPIO bank sub-nodes *must* be listed in order.

Usually we use aliases to mark the order of things. e.g.:

        aliases {
                gpio0 = &gpio0;
                gpio1 = &gpio1;
                gpio2 = &gpio2;
                ethernet0 = &eth0;
                ethernet1 = &eth1;
        };

(arch/arm/boot/dts/armada-375.dtsi)

> +Required properties for pin configuration sub-nodes:
> +----------------------------------------------------
> + - pins: List of pins to which the configuration applies. See below for a
> +   list of possible pins.
> +
> +Optional properties for pin configuration sub-nodes:
> +----------------------------------------------------
> + - function: Mux function for the specified pins. This is not applicable for
> +   non-MFIO pins. See below for a list of valid functions for each pin.
> + - bias-high-impedance: Enable high-impedance mode.
> + - bias-pull-up: Enable weak pull-up.
> + - bias-pull-down: Enable weak pull-down.
> + - bias-bus-hold: Enable bus-keeper mode.
> + - drive-strength: Drive strength in mA. Supported values: 2, 4, 8, 12.
> + - input-schmitt-enable: Enable Schmitt trigger.
> + - input-schmitt-disable: Disable Schmitt trigger.
> + - slew-rate: Slew rate control. 0 for slow, 1 for fast.

We actually haven't specified that function+pins is a valid pattern,
a lot of drivers just started doing that :(

function+groups is documented for muxing.

group + config opts is documented for config.

Please consider patching the generic bindings to reflect this
mux use of pins... We need to discuss it.

Yours,
Linus Walleij
