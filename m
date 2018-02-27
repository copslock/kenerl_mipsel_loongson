Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2018 22:02:11 +0100 (CET)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:45357
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeB0VCDqP2w6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2018 22:02:03 +0100
Received: by mail-ua0-x244.google.com with SMTP id z3so138826uae.12;
        Tue, 27 Feb 2018 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2NVF8sQQIunL9bX6VUTg6os9cvIWt+n/ZM68gIEsooQ=;
        b=r3GaQf81waxUricW6Qsoa00PHTEDnpXvGXLAIoyzqllH7XoWzMlta1q2fbfKsvR9Dg
         6uw80jCUS0WxQ4d8xYxsO8lle9TAfQAR0wvnZXk6bLRbaHErZfke0kPvcJ5xm2rRXQhW
         CWopLFaE0UQjlzr64CAcY/uu0eIlVuanXCT+bPqHg/qgHdorS8h2HU/AN/yYN+NuCdef
         moT8T+Noyp5DFZqmzdRgqI4YD0jr6m7eckDyHNUxIHt8/MJ5EK+QQQMitgygHw2PdKWM
         Q7fyNWFhS1p4AqAdoP91+YlK1TBNmXZkfwRvzUxW8FcOEduVHL6tS9iE9TywOqeFzLf+
         qg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2NVF8sQQIunL9bX6VUTg6os9cvIWt+n/ZM68gIEsooQ=;
        b=B++/9CA8xFToG041GLMujWeruf67xYtmB/aSPO6l3zoM1Y3zHwPKKVn6qo2e2aw3UA
         f7LDlypv/R33gBj7B0IN8U9j9TO+4DRzdxoHfYrUKwFLRUUC+Fb8s1kuJsaz/UCSyR5+
         KTIcQ3jznwixesXQgKGSdlFTRxkrfEGbCOE9JjyV5/i48IHI4eZe8DxoZ28+dkwEdTri
         OuN0wvi+Y1F+1rAfrFCTpjHzFXh4BC6Jnz+Jl6Fr082e/6ZDDcaqzWlTcfdwvuT9Y0xj
         Z6/jK8HR1JJbQtY/WPc5XS+SLYAjVVNZA6d4k9ImLLz8zYY4F4U08nXTSiF6Te3OTQFq
         FFTg==
X-Gm-Message-State: APf1xPAHYFLTvmQ7HtZgqKXyGOOIpVbWAIotQw8KDUrS45Mdgs1mevYR
        RUm4CppYGv4tpGeDB3WZohReac+foFdiARo0cSE=
X-Google-Smtp-Source: AG47ELtijRn3Xf+F9YFn4+4Eacy/PwV2I4fm2ZsxYg1UkEMlUG6sAW3zqWtkIYgeOFP8WBnhwyzK5Z1NCbrD8oF9Wzs=
X-Received: by 10.176.11.21 with SMTP id b21mr11161537uak.106.1519765317519;
 Tue, 27 Feb 2018 13:01:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.81.166 with HTTP; Tue, 27 Feb 2018 13:01:37 -0800 (PST)
In-Reply-To: <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com> <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 27 Feb 2018 22:01:37 +0100
Message-ID: <CAOiHx=n5bekhgaA_-teYZzJQCErfb2Vg1X9fTaq073B=kpWnTA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] MIPS: mscc: add ocelot dtsi
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 16 January 2018 at 11:12, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Add a device tree include file for the Microsemi Ocelot SoC.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/mips/boot/dts/Makefile         |   1 +
>  arch/mips/boot/dts/mscc/Makefile    |   4 ++
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 110 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
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
> index 000000000000..f0a155a74e02
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/Makefile
> @@ -0,0 +1,4 @@
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> new file mode 100644
> index 000000000000..b2f936e1fbb9
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
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
> +               mips-hpt-frequency = <250000000>;
> +
> +               cpu@0 {
> +                       compatible = "mscc,ocelot";

You are using the same compatible string for the whole chip as well as
the cpu core of it, this doesn't seem right.

Also is this really a custom cpu core? Your product brief suggests
this is a "normal" 24KEc MIPS CPU, at least for ocelot-10 (VSC7514).
So something like "mips,mips24KEc" might be more appropriate here.


Regards
Jonas
