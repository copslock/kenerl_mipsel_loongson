Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 11:46:08 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:36083
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991438AbdIFJqBYAvLq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 11:46:01 +0200
Received: by mail-pg0-x242.google.com with SMTP id d8so3235343pgt.3;
        Wed, 06 Sep 2017 02:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DvoMAYOImOupHndg8OJqw4RWI0X7FVYRPRIX6huQmkk=;
        b=OJ+aEOS6K8GKWP44Nmho1ua97vjhPTLTu84O5jmQvcIa74c/pihbxozMhnSJ+/2KR9
         LIVJWNA5276oOz5M+JcKRxEF2wvrBo4PSXVDrB/ivcSPUYSwjE1W4vDz1LL3Lh2/hOv8
         bo3yqiJUCEL/A1GunrvmfULf9qxIGbmpGnb75oRYx9898cNsBFNwlZM7pu8lkAK4iWlg
         1S1XjuZnpAjtGuOHN7k/VaiOoNjVkMzbpISm6xIkxZdJpc0VZ7zM0EsIVUfqkwh5jnUt
         Ok5rbHbZZhbTGJ9Yq5BTBXcEui80aeVbnVN7HISoh6yqlsod/x4vlLfABkdPp2NL2QsR
         qbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DvoMAYOImOupHndg8OJqw4RWI0X7FVYRPRIX6huQmkk=;
        b=fDzYsjnd7iFqPMpyTds3mC/Sl37OM07uDA+Nnsly+Jp9LYPSLnJd4us9v24sprXYgp
         2xRaVdJD9HjtHJV0Slx/CRyVVe2AaFHs2IEoBQOZ6oa5yb3E4z3jIlBtJ5PN8ELQGb79
         LwaBE5hY1Xv88D8GFO3Szdhia9M+eHGmaVUa8l5dvzQF87He8fod9dJpd7rGgPVkg6qC
         23MtuihsgC8u8yETUZiFYCh6drsc1FsyewrrisiaW5mhHeVx5pSpdRxps/awhhTRBDf1
         1icRhq2l73xkknVxcPVrA3RJ4tXnATD/PaQQnu63NBvOc+newgnnI//lXZK/2d2o6NQT
         3afg==
X-Gm-Message-State: AHPjjUiLTx/XLu6qFKTo5kx1CitbUCFDaVJy42QIh5bCApIq1XQcA1LY
        lxy+LmruMaWkiAs/pUhdf7Dsy/G6IA==
X-Google-Smtp-Source: ADKCNb56M7LAaIG0ORpKjMQT2Eg3ImwBijB2xW9ulPtDwGl/l1vKSUl558Vm9Y5j0P2EHDltIE6IBh9QDvrL5OEpVSI=
X-Received: by 10.99.143.89 with SMTP id r25mr6928716pgn.224.1504691154767;
 Wed, 06 Sep 2017 02:45:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.160.9 with HTTP; Wed, 6 Sep 2017 02:45:54 -0700 (PDT)
In-Reply-To: <1504277584-37794-1-git-send-email-harvey.hunt@imgtec.com>
References: <1504277584-37794-1-git-send-email-harvey.hunt@imgtec.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Sep 2017 11:45:54 +0200
X-Google-Sender-Auth: FtlZfyucwZ6OrNWiA6Es6NvwEBM
Message-ID: <CAMuHMdULSM2SfMYxS_xBn=GaHe+u2UfhHtXvwpvBo+rM3akjYw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: mt7620: Rename uartlite to serial
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Fri, Sep 1, 2017 at 4:53 PM, Harvey Hunt <harvey.hunt@imgtec.com> wrote:
> Previously, mt7620.c defined the clocks for uarts with the names
> uartlite, uart1 and uart2. Rename them to serial{0,1,2} and update
> the devicetree node names.
>
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/mips/boot/dts/ralink/mt7620a.dtsi |  2 +-
>  arch/mips/boot/dts/ralink/mt7628a.dtsi |  6 +++---
>  arch/mips/ralink/mt7620.c              | 14 +++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/mips/boot/dts/ralink/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
> index 793c0c7..58bd002 100644
> --- a/arch/mips/boot/dts/ralink/mt7620a.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7620a.dtsi
> @@ -45,7 +45,7 @@
>                         reg = <0x300 0x100>;
>                 };
>
> -               uartlite@c00 {
> +               serial0@c00 {

Device node names should use generic names and no numerical suffix
=> "serial@c00"

>                         compatible = "ralink,mt7620a-uart", "ralink,rt2880-uart", "ns16550a";
>                         reg = <0xc00 0x100>;
>
> diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
> index 9ff7e8f..fe3fe9a 100644
> --- a/arch/mips/boot/dts/ralink/mt7628a.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
> @@ -62,7 +62,7 @@
>                         reg = <0x300 0x100>;
>                 };
>
> -               uart0: uartlite@c00 {
> +               uart0: serial0@c00 {

uart0: serial@c00

>                         compatible = "ns16550a";
>                         reg = <0xc00 0x100>;
>
> @@ -75,7 +75,7 @@
>                         reg-shift = <2>;
>                 };
>
> -               uart1: uart1@d00 {
> +               uart1: serial1@d00 {

uart1: serial@d00

>                         compatible = "ns16550a";
>                         reg = <0xd00 0x100>;
>
> @@ -88,7 +88,7 @@
>                         reg-shift = <2>;
>                 };
>
> -               uart2: uart2@e00 {
> +               uart2: serial2@e00 {

uart2: serial@e00

>                         compatible = "ns16550a";
>                         reg = <0xe00 0x100>;
>
> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index 9be8b08..f623ceb 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
> @@ -54,7 +54,7 @@ static int dram_type;
>
>  static struct rt2880_pmx_func i2c_grp[] =  { FUNC("i2c", 0, 1, 2) };
>  static struct rt2880_pmx_func spi_grp[] = { FUNC("spi", 0, 3, 4) };
> -static struct rt2880_pmx_func uartlite_grp[] = { FUNC("uartlite", 0, 15, 2) };
> +static struct rt2880_pmx_func serial_grp[] = { FUNC("serial", 0, 15, 2) };
>  static struct rt2880_pmx_func mdio_grp[] = {
>         FUNC("mdio", MT7620_GPIO_MODE_MDIO, 22, 2),
>         FUNC("refclk", MT7620_GPIO_MODE_MDIO_REFCLK, 22, 2),
> @@ -92,7 +92,7 @@ static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
>         GRP("uartf", uartf_grp, MT7620_GPIO_MODE_UART0_MASK,
>                 MT7620_GPIO_MODE_UART0_SHIFT),
>         GRP("spi", spi_grp, 1, MT7620_GPIO_MODE_SPI),
> -       GRP("uartlite", uartlite_grp, 1, MT7620_GPIO_MODE_UART1),
> +       GRP("serial", serial_grp, 1, MT7620_GPIO_MODE_UART1),
>         GRP_G("wdt", wdt_grp, MT7620_GPIO_MODE_WDT_MASK,
>                 MT7620_GPIO_MODE_WDT_GPIO, MT7620_GPIO_MODE_WDT_SHIFT),
>         GRP_G("mdio", mdio_grp, MT7620_GPIO_MODE_MDIO_MASK,
> @@ -530,8 +530,8 @@ void __init ralink_clk_init(void)
>                 periph_rate = MHZ(40);
>                 pcmi2s_rate = MHZ(480);
>
> -               ralink_clk_add("10000d00.uartlite", periph_rate);
> -               ralink_clk_add("10000e00.uartlite", periph_rate);
> +               ralink_clk_add("10000d00.serial0", periph_rate);
> +               ralink_clk_add("10000e00.serial0", periph_rate);

Ugh, you're relying on the actual node names in DT?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
