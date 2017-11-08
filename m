Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 17:46:44 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992312AbdKHQqevuPnc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 17:46:34 +0100
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com [209.85.220.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F069721938;
        Wed,  8 Nov 2017 16:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F069721938
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qk0-f172.google.com with SMTP id c16so4121503qke.2;
        Wed, 08 Nov 2017 08:46:31 -0800 (PST)
X-Gm-Message-State: AJaThX71++ocpbKesd8SUIHm/2lsXldVwzHpMEAcyWg70eWB7E74NxzQ
        4BKj/bA53IbwR9H2858jXaQZUWh5agLQfSezEQ==
X-Google-Smtp-Source: AGs4zMbymStvXNAyqM0Gg1dNzuof3hYxTUyS1CyEq0m1uo5KJRyvmQLpgA0d3aKqZIeoz+UH1JNZ3t8sMRfCASScwqQ=
X-Received: by 10.55.128.66 with SMTP id b63mr1745227qkd.67.1510159591121;
 Wed, 08 Nov 2017 08:46:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.130.134 with HTTP; Wed, 8 Nov 2017 08:46:10 -0800 (PST)
In-Reply-To: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Nov 2017 10:46:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLbDWcwcgotnQAO2FeFp55SZRd0z9r2Dr0ZsK0LKZMLw@mail.gmail.com>
Message-ID: <CAL_JsqKLbDWcwcgotnQAO2FeFp55SZRd0z9r2Dr0ZsK0LKZMLw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Nov 1, 2017 at 9:51 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> We need to add "clean-files" in Makfiles to clean up DT blobs, but we
> often miss to do so.
>
> Since there are no source files that end with .dtb or .dtb.S, so we
> can clean-up those files from the top-level Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Remove clean-files

Applied this and the 2 prerequisite patches.

>
>  Documentation/kbuild/makefiles.txt               | 1 -
>  Makefile                                         | 2 +-
>  arch/arc/boot/dts/Makefile                       | 1 -
>  arch/arm/boot/dts/Makefile                       | 1 -
>  arch/arm64/boot/dts/actions/Makefile             | 1 -
>  arch/arm64/boot/dts/al/Makefile                  | 1 -
>  arch/arm64/boot/dts/allwinner/Makefile           | 1 -
>  arch/arm64/boot/dts/altera/Makefile              | 1 -
>  arch/arm64/boot/dts/amd/Makefile                 | 1 -
>  arch/arm64/boot/dts/amlogic/Makefile             | 1 -
>  arch/arm64/boot/dts/apm/Makefile                 | 1 -
>  arch/arm64/boot/dts/arm/Makefile                 | 1 -
>  arch/arm64/boot/dts/broadcom/Makefile            | 1 -
>  arch/arm64/boot/dts/broadcom/northstar2/Makefile | 1 -
>  arch/arm64/boot/dts/broadcom/stingray/Makefile   | 1 -
>  arch/arm64/boot/dts/cavium/Makefile              | 1 -
>  arch/arm64/boot/dts/exynos/Makefile              | 1 -
>  arch/arm64/boot/dts/freescale/Makefile           | 1 -
>  arch/arm64/boot/dts/hisilicon/Makefile           | 1 -
>  arch/arm64/boot/dts/lg/Makefile                  | 1 -
>  arch/arm64/boot/dts/marvell/Makefile             | 1 -
>  arch/arm64/boot/dts/mediatek/Makefile            | 1 -
>  arch/arm64/boot/dts/nvidia/Makefile              | 1 -
>  arch/arm64/boot/dts/qcom/Makefile                | 1 -
>  arch/arm64/boot/dts/realtek/Makefile             | 1 -
>  arch/arm64/boot/dts/renesas/Makefile             | 1 -
>  arch/arm64/boot/dts/rockchip/Makefile            | 1 -
>  arch/arm64/boot/dts/socionext/Makefile           | 1 -
>  arch/arm64/boot/dts/sprd/Makefile                | 1 -
>  arch/arm64/boot/dts/xilinx/Makefile              | 1 -
>  arch/arm64/boot/dts/zte/Makefile                 | 1 -
>  arch/c6x/boot/dts/Makefile                       | 2 --
>  arch/cris/boot/dts/Makefile                      | 2 --
>  arch/h8300/boot/dts/Makefile                     | 1 -
>  arch/metag/boot/dts/Makefile                     | 1 -
>  arch/microblaze/boot/Makefile                    | 2 +-
>  arch/mips/boot/dts/Makefile                      | 1 -
>  arch/mips/boot/dts/brcm/Makefile                 | 1 -
>  arch/mips/boot/dts/cavium-octeon/Makefile        | 1 -
>  arch/mips/boot/dts/img/Makefile                  | 1 -
>  arch/mips/boot/dts/ingenic/Makefile              | 1 -
>  arch/mips/boot/dts/lantiq/Makefile               | 1 -
>  arch/mips/boot/dts/mti/Makefile                  | 1 -
>  arch/mips/boot/dts/netlogic/Makefile             | 1 -
>  arch/mips/boot/dts/ni/Makefile                   | 1 -
>  arch/mips/boot/dts/pic32/Makefile                | 1 -
>  arch/mips/boot/dts/qca/Makefile                  | 1 -
>  arch/mips/boot/dts/ralink/Makefile               | 1 -
>  arch/mips/boot/dts/xilfpga/Makefile              | 1 -
>  arch/nios2/boot/Makefile                         | 2 --
>  arch/openrisc/boot/dts/Makefile                  | 2 --
>  arch/powerpc/boot/Makefile                       | 2 +-
>  arch/sh/boot/dts/Makefile                        | 2 --
>  arch/xtensa/boot/dts/Makefile                    | 2 --
>  54 files changed, 3 insertions(+), 60 deletions(-)
