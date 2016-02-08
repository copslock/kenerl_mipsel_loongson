Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 10:58:37 +0100 (CET)
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33848 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009935AbcBHJ6f7D39C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 10:58:35 +0100
Received: by mail-yw0-f175.google.com with SMTP id h129so98264274ywb.1
        for <linux-mips@linux-mips.org>; Mon, 08 Feb 2016 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mJc07Ai/Uv1tdB/WI/0c/T7uXMnRWdheP368rUQu47o=;
        b=WbjasglBMsYjw2yzqSiiKe2Np8XzkAW+l4ptO6M/GLRdE+NLq2eTDoBwVJiGgMP+od
         z5LIGZxtK3PyaVycvHFFR4mS6bXo+PfHBfkaFKQ6fqe0ht/GcPPoWLbnQuEF5TNP4oe7
         OM/4fmnWOIUxF8PrKczbNq8wgFX5X3uaO0gAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mJc07Ai/Uv1tdB/WI/0c/T7uXMnRWdheP368rUQu47o=;
        b=W28rAWQuYadfv2At8bZX0kuZriVZ7qz0rS88o4fBqSUJvbybZT0jyWpX7O4fh8eClP
         aFVSusSAzG2irNayIReG/lT+jxj+tFpAL390fWlimxKEb2mN2dBPrw8+patgqiuCnZ4l
         jkI7r4CdkIHokquDAPObTo9cTRwNqHAcrTvsQvGqrcP6PGe1gEWGmxJmF3ySGj91ch3W
         3MG4Ig1/ChhAsy/cn5AMioXq+6sK5rxis4/4pdjfiaqxmyfg5NwNNeGLSdScV52HZRWf
         HOVwO83PYvokIFm6ZlRE/bt7B9lRRKQKObsN/DaRdIf4fKclCrNq77BY9Jz5fW2vgzT5
         3WYg==
X-Gm-Message-State: AG10YORZ0DxTeTcFXPnBPKYYNpYa6zwJRie3h5PFduJZKbjYqWhu47rn4viGxv95Cyi9Q2HT8MPtmBwU5L0JdvE0
MIME-Version: 1.0
X-Received: by 10.129.44.212 with SMTP id s203mr14640156yws.280.1454925510205;
 Mon, 08 Feb 2016 01:58:30 -0800 (PST)
Received: by 10.129.114.84 with HTTP; Mon, 8 Feb 2016 01:58:30 -0800 (PST)
In-Reply-To: <1452734299-460-12-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
        <1452734299-460-12-git-send-email-joshua.henderson@microchip.com>
Date:   Mon, 8 Feb 2016 10:58:30 +0100
Message-ID: <CAPDyKFonEs4uA2YwgpxfWN=X7FtCAWKGn-9WQ8D3Z9soSQPsUA@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] dt/bindings: Add bindings for PIC32 SDHCI host controller
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 14 January 2016 at 02:15, Joshua Henderson
<joshua.henderson@microchip.com> wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>
> Document the devicetree bindings for the SDHCI peripheral found on
> Microchip PIC32 class devices.
>
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Rob Herring <robh@kernel.org>

I have picked this up and applied it to my next branch in my mmc tree.

Thanks and kind regards!
Uffe

> ---
> Changes since v4: None
> Changes since v3: None
> Changes since v2: None
> Changes since v1:
>         - Drop usage of piomode and no-1-8-v DT properties
> ---
>  .../bindings/mmc/microchip,sdhci-pic32.txt         |   29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
> new file mode 100644
> index 0000000..71ad57e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
> @@ -0,0 +1,29 @@
> +* Microchip PIC32 SDHCI Controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci-pic32 driver.
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32mzda-sdhci"
> +- interrupts: Should contain interrupt
> +- clock-names: Should be "base_clk", "sys_clk".
> +               See: Documentation/devicetree/bindings/resource-names.txt
> +- clocks: Phandle to the clock.
> +          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- pinctrl-names: A pinctrl state names "default" must be defined.
> +- pinctrl-0: Phandle referencing pin configuration of the SDHCI controller.
> +             See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
> +
> +Example:
> +
> +       sdhci@1f8ec000 {
> +               compatible = "microchip,pic32mzda-sdhci";
> +               reg = <0x1f8ec000 0x100>;
> +               interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&REFCLKO4>, <&PBCLK5>;
> +               clock-names = "base_clk", "sys_clk";
> +               bus-width = <4>;
> +               cap-sd-highspeed;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_sdhc1>;
> +       };
> --
> 1.7.9.5
>
