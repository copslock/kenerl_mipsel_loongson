Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 09:58:14 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:58746 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006660AbaHYH6Mrq7Sx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 09:58:12 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue103) with ESMTP (Nemesis)
        id 0M5qIb-1WOVT60WQD-00xu96; Mon, 25 Aug 2014 09:57:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        zajec5@gmail.com
Subject: Re: [RFC 4/7] bcma: register bcma as device tree driver
Date:   Mon, 25 Aug 2014 09:57:36 +0200
Message-ID: <2462012.kILSFadzpm@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.11.0-26-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1408915485-8078-6-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de> <1408915485-8078-6-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:jdXHM7CcdBeD4iKL6vbJx4MlZ/cA2qflP5g6RFCrMLR
 ukcCg1wKf1Wrnm8rsH1VzhcfEtreRjMxcP8X80FYhKn27+o7dY
 2injjQVnFwJg2jnpZOmqs3NsSSWI7bC+ZDRLCzE/xbTNgHHZUP
 WRmBfCuyGVYKaz96RN5drgh53tsmy2fYY18Oj2quN3EYSpx4Cc
 zBe4nTZw2WIBjbFnTp1M47LKWQ5KEnc6vldjyFwTobVoIjOCv5
 1BNlsKhrAuD445+kNS8SkGqEOxuz2Qo0STlz6YoH9SkFfUvSC0
 l8jqKLefMN/YdFLEvTiBIBWtJjGtNRWA3NkvMu5NXOBdggejd9
 pj/0k9h8WanubAE5NX5w=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sunday 24 August 2014 23:24:42 Hauke Mehrtens wrote:
> This driver is used by the bcm53xx ARM SoC code. Now it is possible to
> give the address of the chipcommon core in device tree and bcma will
> search for all the other cores.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Looks good to me overall. Two small comments:

>  Documentation/devicetree/bindings/bus/bcma.txt | 46 +++++++++++++++++
>  drivers/bcma/host_soc.c                        | 70 ++++++++++++++++++++++++++
>  include/linux/bcma/bcma.h                      |  2 +
>  3 files changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/bcma.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/bcma.txt b/Documentation/devicetree/bindings/bus/bcma.txt
> new file mode 100644
> index 0000000..52fb929
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/bcma.txt
> @@ -0,0 +1,46 @@
> +Broadcom AIX bcma bus driver
> +
> +
> +Required properties:
> +
> +- compatible : brcm,bus-aix
> +
> +- reg : iomem address range of chipcommon core
> +
> +Optional properties:
> +
> +- sprom: reference to a sprom driver. This is needed for sprom less devices.
> +        Use bcm47xx_sprom for example.
> +
> +
> +The cores on the AIX bus are auto detected by bcma. Detection of the
> +IRQ number is not supported on BCM47xx/BCM53xx ARM SoCs, so it is
> +possible to provide the IRQ number over device tree. The IRQ number and
> +the device tree child entry will be added to the core with the matching
> +reg address.

What is the problem with the interrupt numbers? Is that information
missing completely from the data available to the brcm bus, or is it
in an inconvenient format?

> +Example:
> +
> +       aix@18000000 {
> +               compatible = "brcm,bus-aix";
> +               reg = <0x18000000 0x1000>;
> +               ranges = <0x00000000 0x18000000 0x00100000>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               sprom = <&sprom0>;
> +
> +               gmac@0 {
> +                       reg = <0x18024000 0x1000>;
> +                       interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +               };

The @0 part seems wrong here: the address should generally match
the first entry in the reg property, which would be gmac@18024000.

Also, you probably mean ethernet@ not gmac@.

> +               gmac@1 {
> +                       reg = <0x18025000 0x1000>;
> +                       interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               pcie@0 {
> +                       reg = <0x18012000 0x1000>;
> +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +       };

We may require additional properties for the pcie node, depending on whether
we want to use the DT probing interfaces for it, or whether it should just
hardcode the settings used on brcm based on the ID.

	Arnd
