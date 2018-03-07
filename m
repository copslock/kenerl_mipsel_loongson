Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 17:09:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994737AbeCGQJJaEavy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 17:09:09 +0100
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com [209.85.220.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ED742177B;
        Wed,  7 Mar 2018 16:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED742177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-qk0-f177.google.com with SMTP id y137so3253168qka.4;
        Wed, 07 Mar 2018 08:09:02 -0800 (PST)
X-Gm-Message-State: AElRT7FbtKoOPCigdByd/+VtSOBuSG1Seugn2+5HNoBeoAtRUK+3F3DT
        HRUVqpUAJ0rixmDEvbyZKOkM1jb6Up5Kl2IVXQ==
X-Google-Smtp-Source: AG47ELvFGL1XfTmn38YKKZTaTda+OBha7Liq1O54uXyHH+OSZUDQgb7vqaFSK6a9+tr+v1vr2mpYfU0+wW/NLTrnsZA=
X-Received: by 10.55.31.163 with SMTP id n35mr34496065qkh.147.1520438941811;
 Wed, 07 Mar 2018 08:09:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.131 with HTTP; Wed, 7 Mar 2018 08:08:28 -0800 (PST)
In-Reply-To: <20180306121607.1567-3-alexandre.belloni@bootlin.com>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com> <20180306121607.1567-3-alexandre.belloni@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 7 Mar 2018 10:08:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzEUO1DiaVtw8vBtiO9Xw7_5EprrC8z3C9JA6bFq1KmQ@mail.gmail.com>
Message-ID: <CAL_JsqKzEUO1DiaVtw8vBtiO9Xw7_5EprrC8z3C9JA6bFq1KmQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] MIPS: mscc: add ocelot dtsi
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Tue, Mar 6, 2018 at 6:16 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Add a device tree include file for the Microsemi Ocelot SoC.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/mips/boot/dts/Makefile         |   1 +
>  arch/mips/boot/dts/mscc/Makefile    |   1 +
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 117 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 arch/mips/boot/dts/mscc/Makefile
>  create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
>
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index e2c6f131c8eb..1e79cab8e269 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -4,6 +4,7 @@ subdir-y        += cavium-octeon
>  subdir-y       += img
>  subdir-y       += ingenic
>  subdir-y       += lantiq
> +subdir-y       += mscc
>  subdir-y       += mti
>  subdir-y       += netlogic
>  subdir-y       += ni
> diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> new file mode 100644
> index 000000000000..dd08e63a10ba
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/Makefile
> @@ -0,0 +1 @@
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> new file mode 100644
> index 000000000000..8c3210577410
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -0,0 +1,117 @@
> +//SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2017 Microsemi Corporation */
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       compatible = "mscc,ocelot";
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       compatible = "mips,mips24KEc";
> +                       device_type = "cpu";
> +                       clocks = <&cpu_clk>;
> +                       reg = <0>;
> +               };
> +       };
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       cpuintc: interrupt-controller@0 {

Please compile with W=1 and fix any issues like this one which is a
unit-address without a reg property. Drop the unit-address.

> +               #address-cells = <0>;
> +               #interrupt-cells = <1>;
> +               interrupt-controller;
> +               compatible = "mti,cpu-interrupt-controller";
