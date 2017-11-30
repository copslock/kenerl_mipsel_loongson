Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 08:57:45 +0100 (CET)
Received: from mail-ua0-x242.google.com ([IPv6:2607:f8b0:400c:c08::242]:40956
        "EHLO mail-ua0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990590AbdK3H5hyts4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Nov 2017 08:57:37 +0100
Received: by mail-ua0-x242.google.com with SMTP id i92so5164814uad.7
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 23:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hYrJSrKCJdWGaJP/X7sq7jttPNFA1G2lz04KkNGd4kY=;
        b=bH2KFPmTDzBCKHkbUS8EWhSmpNmZ3cLZZOpFrHr6SZXhyOLbmHvKELcUeLg0RnhcWq
         4gujxtVt4YkBjV3vSLbIKqjnrnapr4MzgCkRGrSLp4mXqWHMF3c9tkpEpm0da6X0u0fP
         6JBFbwqa7fiCiytFK68lmCFOHyKcY16uXB8VGaIGjKe6A88xCd0btLP/B2SrOhjf/tey
         MGucDVC2/PoEbMS0WHhFV/xplKIQCtix+m+wRzt19yeiQIj90ThT+V5JCg4hkqlmUUM9
         inn7WCOBHMOw1C8UDZijJd6tFAB40aZRjupH3XCEu25JWaSswiCgPdkGRs7vXfTwpi91
         JO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hYrJSrKCJdWGaJP/X7sq7jttPNFA1G2lz04KkNGd4kY=;
        b=HpJPIgW1VVgIThE/mvbisO69e5/r46VI3I9md9NKqGlw0gtMnF/jjhEhO7BS0+gbck
         y40QiLmphskSj+D+mxMBqqxuWtFt0vfUUd6JVzSiCRWCG/XKgMMlE1e0vZfzKh9X7xr5
         Bif99V714xCnHJfG2tpp6wzZ2Jh4PASFQ5XBCkuidWFWFkDObn2AofDi3uF1u+XIA9Rc
         vgoUN6Wc0FOxmw2m73iDQaR7BdeoeSrf9AdJRr7oXHNx7FUm0HWMhRhwv/VFZ3jLa1rC
         iaEuTpS2Y0kAY2Mz146b82ZhhZLQDus7te9KokMHXtKwFaA84UYXQkjB3UA86m9tGw/6
         hoow==
X-Gm-Message-State: AKGB3mIQ/iyzNGg4aSPcW4SH6+HaOOgGoKz7e/9k734Uzhqy5mwAPCuz
        Vs5QAMpNgGvT88yfjUZil884+rQU3kDFX4t4VWA=
X-Google-Smtp-Source: AGs4zMbgJq4HAEAoFuLR9RPPrzuC7KCG2rh06pcx/K5Y3ykGuoNUhovLdacJpyQosk8cdEczAMjbWKilVmflkPEqS+E=
X-Received: by 10.159.62.204 with SMTP id n12mr1233298uaj.85.1512028651766;
 Wed, 29 Nov 2017 23:57:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.114 with HTTP; Wed, 29 Nov 2017 23:57:11 -0800 (PST)
In-Reply-To: <c7200904-f016-8789-ee5e-fe5a281be215@caviumnetworks.com>
References: <20171129205515.9009-1-malat@debian.org> <c7200904-f016-8789-ee5e-fe5a281be215@caviumnetworks.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 30 Nov 2017 08:57:11 +0100
X-Google-Sender-Auth: bfScJ7r5sjF0WRJAFDKOAcOTvL0
Message-ID: <CA+7wUszQAjcOkaWyEhJ9GnqL0+PQOvsMx3rOaHMOnq_0HnUDeQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove leading 0x from bindings notation
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Hi David,

On Thu, Nov 30, 2017 at 12:21 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 11/29/2017 12:55 PM, Mathieu Malaterre wrote:
>>
>> Improve the binding example by removing all the leading 0x to fix the
>> following dtc warnings:
>>
>> Warning (unit_address_format): Node /XXX unit name should not have leading
>> "0x"
>
>
> How does it fix the warnings?  You are not changing the .dts files that are
> compiled.

I originally only wanted to fix [...]watchdog/ingenic,jz4740-wdt.txt,
but when I lookup git log, I eventually found out about the commit I
refer to in my commit message:

https://github.com/torvalds/linux/commit/48c926cd3414

and I simply followed suggestion from Rob:

https://lkml.org/lkml/2017/11/1/965

> This may also cause the binding documentation to differ from the reality of
> what the actual device trees contain.


Chicken or the egg dilemma, but you understand that linux master tree
still has the original warning:

$ perl -p -i -e 's/\@0+([0-9a-f])/\@$1/g' `find ./ -type f \( -iname
\*.dtsi -o -iname \*.dts \)`
$ git diff | diffstat
[...]
 40 files changed, 160 insertions(+), 160 deletions(-)

And those are real W=1 actual warnings. Do you want me to re-submit it
as patch series instead which fix both the documentation side and the
dts* files ?


>
>>
>> Converted using the following command:
>>
>> find Documentation/devicetree/bindings -name "*.txt" -exec sed -i -e
>> 's/([^ ])\@0x([0-9a-f])/$1\@$2/g' {} +
>>
>> This is a follow up to commit 48c926cd3414
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> I've also checked using the original perl command that I did not
>> introduce:
>>
>> Warning (unit_address_format): Node /XXX unit name should not have leading
>> 0s
>>
>>   Documentation/devicetree/bindings/arm/ccn.txt                |  2 +-
>>   Documentation/devicetree/bindings/arm/omap/crossbar.txt      |  2 +-
>>   .../devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt      |  2 +-
>>   Documentation/devicetree/bindings/clock/axi-clkgen.txt       |  2 +-
>>   .../devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt     |  2 +-
>>   Documentation/devicetree/bindings/clock/exynos4-clock.txt    |  2 +-
>>   Documentation/devicetree/bindings/clock/exynos5250-clock.txt |  2 +-
>>   Documentation/devicetree/bindings/clock/exynos5410-clock.txt |  2 +-
>>   Documentation/devicetree/bindings/clock/exynos5420-clock.txt |  2 +-
>>   Documentation/devicetree/bindings/clock/exynos5440-clock.txt |  2 +-
>>   .../devicetree/bindings/clock/ti-keystone-pllctrl.txt        |  2 +-
>>   Documentation/devicetree/bindings/clock/zx296702-clk.txt     |  4 ++--
>>   Documentation/devicetree/bindings/crypto/fsl-sec4.txt        |  4 ++--
>>   .../devicetree/bindings/devfreq/event/rockchip-dfi.txt       |  2 +-
>>   Documentation/devicetree/bindings/display/atmel,lcdc.txt     |  4 ++--
>>   Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 ++--
>>   Documentation/devicetree/bindings/dma/zxdma.txt              |  2 +-
>>   Documentation/devicetree/bindings/gpio/gpio-altera.txt       |  2 +-
>>   Documentation/devicetree/bindings/i2c/i2c-jz4780.txt         |  2 +-
>>   Documentation/devicetree/bindings/iio/pressure/hp03.txt      |  2 +-
>>   .../devicetree/bindings/input/touchscreen/bu21013.txt        |  2 +-
>>   .../devicetree/bindings/interrupt-controller/arm,gic.txt     |  4 ++--
>>   .../bindings/interrupt-controller/img,meta-intc.txt          |  2 +-
>>   .../bindings/interrupt-controller/img,pdc-intc.txt           |  2 +-
>>   .../bindings/interrupt-controller/st,spear3xx-shirq.txt      |  2 +-
>>   Documentation/devicetree/bindings/mailbox/altera-mailbox.txt |  6 +++---
>>   .../devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt      |  2 +-
>>   Documentation/devicetree/bindings/media/exynos5-gsc.txt      |  2 +-
>>   Documentation/devicetree/bindings/media/mediatek-vcodec.txt  |  2 +-
>>   Documentation/devicetree/bindings/media/rcar_vin.txt         |  2 +-
>>   Documentation/devicetree/bindings/media/samsung-fimc.txt     |  2 +-
>>   Documentation/devicetree/bindings/media/sh_mobile_ceu.txt    |  2 +-
>>   Documentation/devicetree/bindings/media/video-interfaces.txt | 10
>> +++++-----
>>   .../devicetree/bindings/memory-controllers/ti/emif.txt       |  2 +-
>>   .../devicetree/bindings/mfd/ti-keystone-devctrl.txt          |  2 +-
>>   Documentation/devicetree/bindings/misc/brcm,kona-smc.txt     |  2 +-
>>   Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt    |  2 +-
>>   Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  2 +-
>>   Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  4 ++--
>>   Documentation/devicetree/bindings/mtd/gpmc-nor.txt           |  6 +++---
>>   Documentation/devicetree/bindings/mtd/mtk-nand.txt           |  2 +-
>>   Documentation/devicetree/bindings/net/altera_tse.txt         |  4 ++--
>>   Documentation/devicetree/bindings/net/mdio.txt               |  2 +-
>>   Documentation/devicetree/bindings/net/socfpga-dwmac.txt      |  2 +-
>>   Documentation/devicetree/bindings/nios2/nios2.txt            |  2 +-
>>   Documentation/devicetree/bindings/pci/altera-pcie.txt        |  2 +-
>>   Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 +-
>>   Documentation/devicetree/bindings/pci/hisilicon-pcie.txt     |  2 +-
>>   Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt      |  2 +-
>>   .../devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt       |  2 +-
>>   Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt |  4 ++--
>>   Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt   |  2 +-
>>   .../devicetree/bindings/pinctrl/rockchip,pinctrl.txt         |  4 ++--
>>   Documentation/devicetree/bindings/regulator/regulator.txt    |  2 +-
>>   Documentation/devicetree/bindings/serial/efm32-uart.txt      |  2 +-
>>   .../devicetree/bindings/serio/allwinner,sun4i-ps2.txt        |  2 +-
>>   .../devicetree/bindings/soc/ti/keystone-navigator-qmss.txt   |  2 +-
>>   Documentation/devicetree/bindings/sound/adi,axi-i2s.txt      |  2 +-
>>   Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt |  2 +-
>>   Documentation/devicetree/bindings/sound/ak4613.txt           |  2 +-
>>   Documentation/devicetree/bindings/sound/ak4642.txt           |  2 +-
>>   Documentation/devicetree/bindings/sound/max98371.txt         |  2 +-
>>   Documentation/devicetree/bindings/sound/max9867.txt          |  2 +-
>>   Documentation/devicetree/bindings/sound/renesas,fsi.txt      |  2 +-
>>   Documentation/devicetree/bindings/sound/rockchip-spdif.txt   |  2 +-
>>   Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt |  8
>> ++++----
>>   Documentation/devicetree/bindings/spi/efm32-spi.txt          |  2 +-
>>   Documentation/devicetree/bindings/thermal/thermal.txt        | 12
>> ++++++------
>>   Documentation/devicetree/bindings/ufs/ufs-qcom.txt           |  4 ++--
>>   Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  2 +-
>>   Documentation/devicetree/bindings/usb/ehci-st.txt            |  2 +-
>>   Documentation/devicetree/bindings/usb/ohci-st.txt            |  2 +-
>>   .../devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt      |  2 +-
>>   73 files changed, 99 insertions(+), 99 deletions(-)
>>
>
