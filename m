Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 16:46:57 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:34392 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27031940AbcFNOqy3Ev70 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 16:46:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 042BDB91A57;
        Tue, 14 Jun 2016 16:46:54 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com [209.85.213.41])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6E33FB91A3C;
        Tue, 14 Jun 2016 16:46:44 +0200 (CEST)
Received: by mail-vk0-f41.google.com with SMTP id j2so47987978vkg.2;
        Tue, 14 Jun 2016 07:46:44 -0700 (PDT)
X-Gm-Message-State: ALyK8tIKeo0hcBO56J4wqLtiYQyVBy+a+XjwYjjiMMtrrxoxCQz15cF/u6R8NzRKhaNvItNP91be54wvfJ5BhQ==
X-Received: by 10.31.179.209 with SMTP id c200mr8383065vkf.18.1465915603283;
 Tue, 14 Jun 2016 07:46:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.2.141 with HTTP; Tue, 14 Jun 2016 07:46:23 -0700 (PDT)
In-Reply-To: <1465803534-25840-6-git-send-email-noltari@gmail.com>
References: <1465803534-25840-1-git-send-email-noltari@gmail.com> <1465803534-25840-6-git-send-email-noltari@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 14 Jun 2016 16:46:23 +0200
X-Gmail-Original-Message-ID: <CAOiHx==5ZOfL5JGyv9t6jUEXGfL4xnNjKmUocEv5gBeve8=KLA@mail.gmail.com>
Message-ID: <CAOiHx==5ZOfL5JGyv9t6jUEXGfL4xnNjKmUocEv5gBeve8=KLA@mail.gmail.com>
Subject: Re: [PATCH 6/6] MIPS: BMIPS: Add device tree example for BCM6362
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh@kernel.org>, Simon Arlott <simon@fire.lp0.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54048
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

Hi,

On 13 June 2016 at 09:38, Álvaro Fernández Rojas <noltari@gmail.com> wrote:
> This adds a device tree example for SFR NeufBox 6.
>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  arch/mips/bmips/Kconfig                    |   4 +
>  arch/mips/boot/dts/brcm/Makefile           |   2 +
>  arch/mips/boot/dts/brcm/bcm6362.dtsi       | 134 +++++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm96362nb6ser.dts |  22 +++++
>  4 files changed, 162 insertions(+)
>  create mode 100644 arch/mips/boot/dts/brcm/bcm6362.dtsi
>  create mode 100644 arch/mips/boot/dts/brcm/bcm96362nb6ser.dts
>
> diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
> index 5b0ad8c..43da496 100644
> --- a/arch/mips/bmips/Kconfig
> +++ b/arch/mips/bmips/Kconfig
> @@ -33,6 +33,10 @@ config DT_BCM96358NB4SER
>         bool "BCM96358NB4SER"
>         select BUILTIN_DTB
>
> +config DT_BCM96362NB6SER
> +       bool "BCM96362NB6SER"

DT_SFR_NEUFBOX6_SERCOMM
       bool "SFR Neufbox 6 (Sercomm)"

maybe?

> +       select BUILTIN_DTB
> +
>  config DT_BCM96368MVWG
>         bool "BCM96368MVWG"
>         select BUILTIN_DTB
> diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
> index c553b95..161e54b 100644
> --- a/arch/mips/boot/dts/brcm/Makefile
> +++ b/arch/mips/boot/dts/brcm/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_DT_BCM93384WVG)            += bcm93384wvg.dtb
>  dtb-$(CONFIG_DT_BCM93384WVG_VIPER)     += bcm93384wvg_viper.dtb
>  dtb-$(CONFIG_DT_BCM963268VR3032U)      += bcm963268vr3032u.dtb
>  dtb-$(CONFIG_DT_BCM96358NB4SER)                += bcm96358nb4ser.dtb
> +dtb-$(CONFIG_DT_BCM96362NB6SER)                += bcm96362nb6ser.dtb

Similar here.

>  dtb-$(CONFIG_DT_BCM96368MVWG)          += bcm96368mvwg.dtb
>  dtb-$(CONFIG_DT_BCM9EJTAGPRB)          += bcm9ejtagprb.dtb
>  dtb-$(CONFIG_DT_BCM97125CBMB)          += bcm97125cbmb.dtb
> @@ -20,6 +21,7 @@ dtb-$(CONFIG_DT_NONE)                 += \
>                                                 bcm93384wvg_viper.dtb   \
>                                                 bcm963268vr3032u.dtb    \
>                                                 bcm96358nb4ser.dtb      \
> +                                               bcm96362nb6ser.dtb      \
>                                                 bcm96368mvwg.dtb        \
>                                                 bcm9ejtagprb.dtb        \
>                                                 bcm97125cbmb.dtb        \

(snip)

> diff --git a/arch/mips/boot/dts/brcm/bcm96362nb6ser.dts b/arch/mips/boot/dts/brcm/bcm96362nb6ser.dts
> new file mode 100644
> index 0000000..a470230
> --- /dev/null
> +++ b/arch/mips/boot/dts/brcm/bcm96362nb6ser.dts

Similar here.

> @@ -0,0 +1,22 @@
> +/dts-v1/;
> +
> +/include/ "bcm6362.dtsi"
> +
> +/ {
> +       compatible = "sfr,nb6-ser", "brcm,bcm6362";

I don't see the sfr vendor prefix documented (at least not in
4.7-rc2). If it is already in -next, then disregard that comment.


> +       model = "SFT NeufBox 6 (Sercomm)";

SFT? Not SFR? ;p



Regards
Jonas
