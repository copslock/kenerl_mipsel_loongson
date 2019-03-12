Return-Path: <SRS0=h4L/=RP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA3C4360F
	for <linux-mips@archiver.kernel.org>; Tue, 12 Mar 2019 12:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CED7214AE
	for <linux-mips@archiver.kernel.org>; Tue, 12 Mar 2019 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552393695;
	bh=RfMRDnH1eEt84Aj4yukahn+u48BjxguJ/6f9pQE5oIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ll5yY7Mahn7QpdTTSiPm26GwzCrfNgJvC2MLNL9lWn2phRYZcP/ECIlbJ6zkxXiH5
	 GFaB215D71JQNdz6OtgGb/K8/Z8CoHBdwFrhp5zvJI5jvtjw5GbXtzrlgntMiJc5GG
	 SnDNNHcMnBSHzCORE6C8+TmSONIteMH7f/Xrq3hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCLM2O (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfCLM2N (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 12 Mar 2019 08:28:13 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52DF5214AF
        for <linux-mips@vger.kernel.org>; Tue, 12 Mar 2019 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552393692;
        bh=RfMRDnH1eEt84Aj4yukahn+u48BjxguJ/6f9pQE5oIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0f5lc6xqHH9qSgTCD3dq2oeTyxqvKCZxhoOE4/THZ5Vtu1KKLQlWd+ST/zAQVdBCV
         QQpq54vbSzlY3P0sF0gO8pd30yU0cBK579zyBcuRG3vNINuFw7hgKKMZ2RfFy4C/rQ
         HKkojTXUWQZPs0TyTusdrxBRhD3NeHodYFOSjvOo=
Received: by mail-ot1-f41.google.com with SMTP id c18so2223367otl.13
        for <linux-mips@vger.kernel.org>; Tue, 12 Mar 2019 05:28:12 -0700 (PDT)
X-Gm-Message-State: APjAAAVJ7WgHqDhTFNi4FYnm3dvT8RzrWiv8RfaP5mDktK5TxAlliy0F
        xUA/d7ZfqGd0NLx+S+BDMEpqaSAdBjBG1JCpW13YFA==
X-Google-Smtp-Source: APXvYqz0vB0J2+h3DL6He37eQCNIvCvUy9T/ByTelc9RVPeWJshavRtenpxLsfspEWltM8H6JuWe2cTn4mOc5Ue2w4Y=
X-Received: by 2002:a9d:7390:: with SMTP id j16mr23496214otk.231.1552393691537;
 Tue, 12 Mar 2019 05:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190312091520.8863-1-jiaxun.yang@flygoat.com> <20190312091520.8863-5-jiaxun.yang@flygoat.com>
In-Reply-To: <20190312091520.8863-5-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Mar 2019 07:28:00 -0500
X-Gmail-Original-Message-ID: <CABGGiszYh0uE_ybrfhK2byz4XZVAm9wvL5tQg0R85nnLt4c1iw@mail.gmail.com>
Message-ID: <CABGGiszYh0uE_ybrfhK2byz4XZVAm9wvL5tQg0R85nnLt4c1iw@mail.gmail.com>
Subject: Re: [PATCH 4/4] MIPS: Loongson32: dts: add ls1b & ls1c
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, paul.burton@mips.com,
        keguang.zhang@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Mar 12, 2019 at 4:16 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote=
:
>
> Add devicetree skeleton for ls1b and ls1c
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/boot/dts/loongson/Makefile  |   6 ++
>  arch/mips/boot/dts/loongson/ls1b.dts  |  21 +++++
>  arch/mips/boot/dts/loongson/ls1c.dts  |  25 ++++++
>  arch/mips/boot/dts/loongson/ls1x.dtsi | 117 ++++++++++++++++++++++++++
>  4 files changed, 169 insertions(+)
>  create mode 100644 arch/mips/boot/dts/loongson/Makefile
>  create mode 100644 arch/mips/boot/dts/loongson/ls1b.dts
>  create mode 100644 arch/mips/boot/dts/loongson/ls1c.dts
>  create mode 100644 arch/mips/boot/dts/loongson/ls1x.dtsi
>
> diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/lo=
ongson/Makefile
> new file mode 100644
> index 000000000000..447801568f33
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_LOONGSON1_LS1B)   +=3D ls1b.dtb
> +
> +dtb-$(CONFIG_LOONGSON1_LS1B)   +=3D ls1c.dtb
> +
> +obj-$(CONFIG_BUILTIN_DTB)      +=3D $(addsuffix .o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/loongson/ls1b.dts b/arch/mips/boot/dts/lo=
ongson/ls1b.dts
> new file mode 100644
> index 000000000000..6d40dc502acf
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/ls1b.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +/dts-v1/;
> +#include <ls1x.dtsi>
> +
> +/ {
> +       model =3D "Loongson LS1B";
> +       compatible =3D "loongson,ls1b";

Documented?

> +
> +};
> +
> +&ehci0 {
> +       status =3D "okay";
> +};
> +
> +&ohci0 {
> +       status =3D "okay";
> +};
> \ No newline at end of file

Fix this.

> diff --git a/arch/mips/boot/dts/loongson/ls1c.dts b/arch/mips/boot/dts/lo=
ongson/ls1c.dts
> new file mode 100644
> index 000000000000..778d205a586e
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/ls1c.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +/dts-v1/;
> +#include <ls1x.dtsi>
> +
> +/ {
> +       model =3D "Loongson LS1C300A";
> +       compatible =3D "loongson,ls1c300a";
> +
> +};
> +
> +&platintc4 {
> +       status =3D "okay";
> +};
> +
> +&ehci0 {
> +       status =3D "okay";
> +};
> +
> +&ohci0 {
> +       status =3D "okay";
> +};
> \ No newline at end of file
> diff --git a/arch/mips/boot/dts/loongson/ls1x.dtsi b/arch/mips/boot/dts/l=
oongson/ls1x.dtsi
> new file mode 100644
> index 000000000000..f808e4328fd8
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/ls1x.dtsi
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +
> +/ {
> +    #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               cpu@0 {
> +                       device_type =3D "cpu";
> +                       reg =3D <0>;

Needs a (documented) compatible string.

> +               };
> +       };
> +
> +       cpu_intc: interrupt-controller {
> +               #address-cells =3D <0>;
> +               compatible =3D "mti,cpu-interrupt-controller";
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <1>;
> +       };
> +
> +       soc {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +
> +               compatible =3D "simple-bus";
> +               ranges;
> +
> +
> +               platintc0: interrupt-controller@1fd01040 {
> +                       compatible =3D "loongson,ls1x-intc";
> +                       reg =3D <0x1fd01040 0x18>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <2>;
> +
> +                       interrupt-parent =3D <&cpu_intc>;
> +                       interrupts =3D <2>;
> +               };
> +
> +               platintc1: interrupt-controller@1fd01058 {
> +                       compatible =3D "loongson,ls1x-intc";
> +                       reg =3D <0x1fd01058 0x18>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <2>;
> +
> +                       interrupt-parent =3D <&cpu_intc>;
> +                       interrupts =3D <3>;
> +               };
> +
> +               platintc2: interrupt-controller@1fd01070 {
> +                       compatible =3D "loongson,ls1x-intc";
> +                       reg =3D <0x1fd01070 0x18>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <2>;
> +
> +                       interrupt-parent =3D <&cpu_intc>;
> +                       interrupts =3D <4>;
> +               };
> +
> +               platintc3: interrupt-controller@1fd01088 {
> +                       compatible =3D "loongson,ls1x-intc";
> +                       reg =3D <0x1fd01088 0x18>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <2>;
> +
> +                       interrupt-parent =3D <&cpu_intc>;
> +                       interrupts =3D <5>;
> +               };
> +
> +               platintc4: interrupt-controller@1fd010a0 {
> +                       compatible =3D "loongson,ls1x-intc";
> +                       reg =3D <0x1fd010a0 0x18>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <2>;
> +
> +                       interrupt-parent =3D <&cpu_intc>;
> +                       interrupts =3D <6>;
> +
> +           status =3D "disabled";

Some indentation problem.

> +               };
> +
> +               ehci0: usb@1fe20000 {
> +                       compatible =3D "generic-ehci";

It would be better to add a chip specific compatible here. Most all
USB controllers have some quirks.

> +                       reg =3D <0x1fe20000 0x100>;
> +                       interrupt-parent =3D <&platintc1>;
> +                       interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +           status =3D "disabled";
> +                       };
> +
> +               ohci0: usb@1fe28000 {
> +                       compatible =3D "generic-ohci";
> +                       reg =3D <0x1fe28000 0x100>;
> +                       interrupt-parent =3D <&platintc1>;
> +                       interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
> +
> +           status =3D "disabled";
> +                       };

Don't you need a serial port or something for a console?

> +
> +       };
> +};
> +\ =E6=96=87=E4=BB=B6=E5=B0=BE=E6=B2=A1=E6=9C=89=E6=8D=A2=E8=A1=8C=E7=AC=
=A6
> --
> 2.20.1
>
