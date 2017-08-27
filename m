Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2017 08:40:11 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:36549
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991181AbdH0GkFC0w6p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2017 08:40:05 +0200
Received: by mail-io0-x242.google.com with SMTP id v96so1693707ioi.3;
        Sat, 26 Aug 2017 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u8emSYj+ImUHOHKOL0hsGsz+oqF418WBDSNpzwk5X0Y=;
        b=nEETWCwvnnsNnHrWsWaB12c+sZUASI6Mk8LC6ItPSFFA7/umY1TBRa4XvFoTvrMfor
         ebOvz6OAzIIh5eHOfx64gkZojJAtXYyKuzUbKJRFVvO8EeEiMXjX8q23U/N31fcillZ+
         Oz+bsO9zyG7xaRKN4DmxUvJR/C9ZtWO+kBPvGhw8p/DznX6iTxPe/NsgcxYNEOf4j0oR
         5xLCM/ptQgxS0Pn1+g54KCkaLDZHCYYrhe7lfhICXrcVl0zkpwAXdhXlgWuC3opxM+Eo
         MLEvzMKpLfQbIlyg1KthdO1sWKO1XEgUPxKFfpVFzOUuAdKzbwv3G4zIeOBbGLKpu5wD
         FToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u8emSYj+ImUHOHKOL0hsGsz+oqF418WBDSNpzwk5X0Y=;
        b=fzqSK+kqxXcz5YyWhqvlxtWEqzNJiQxLTTbTCbUK7PZ8IqpxV6+0m736njyfUOFkWQ
         7BlCD2nnqk0rWkHDtFQhJNwVb/6SEkCj8xOyhj7Ftcyq6Q1f/MqaQuWaFm278b43imCM
         6bSHLd2EMerDpOPwCUaAKwd5eFTraG+rpptq6VXec4XANjpZiCGVIK6QBu2M7FDcviqf
         rrUxuJjo5VcWaGtjKDaIDWph//LOQjbsUfwOldqFCfIGqFWuDr7hd16Yv/bso6YCnPMc
         aIi1ak5cV45MsVOxKBGpfYPqoGjRnVDLPaXePdxdbmR2oiRf/L7mCyZc+6Gnb39V6PlI
         walg==
X-Gm-Message-State: AHYfb5jpW1UEubEdpFPcyyPmR9G5FAxX4e1Absp5JEM3uktpKA5tqpm/
        i4hhgjAH/xg2e6qE/8ZJoEwIqsFQbQ==
X-Received: by 10.107.174.35 with SMTP id x35mr3460922ioe.114.1503815999218;
 Sat, 26 Aug 2017 23:39:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.14.197 with HTTP; Sat, 26 Aug 2017 23:39:58 -0700 (PDT)
In-Reply-To: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sun, 27 Aug 2017 12:09:58 +0530
Message-ID: <CANc+2y4EmmeYX7DVdjR7evt1siK4YS9MenTwjJRvubOr-yfuVw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] crypto: Add driver for JZ4780 PRNG
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, Mathieu Malaterre <malat@debian.org>,
        noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

On 23 August 2017 at 08:27, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
> This patch series adds support of pseudo random number generator found
> in Ingenic's JZ4780 and X1000 SoC.
>
> Based on Paul's review comments, add 'syscon' compatible in CGU node in
> jz4780.dtsi. jz4780-rng driver uses regmap exposed via syscon interface
> to access the RNG registers. CGU driver is not modified in this patch
> set as registers used by CGU driver and this driver are different.
>
> PrasannaKumar Muralidharan (4):
>   crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
>   crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
>   crypto: jz4780-rng: Add RNG node to jz4780.dtsi
>   crypto: jz4780-rng: Enable PRNG support in CI20 defconfig
>
>  .../bindings/crypto/ingenic,jz4780-rng.txt         |  20 +++
>  MAINTAINERS                                        |   5 +
>  arch/mips/boot/dts/ingenic/jz4780.dtsi             |   6 +-
>  arch/mips/configs/ci20_defconfig                   |   5 +
>  drivers/crypto/Kconfig                             |  19 +++
>  drivers/crypto/Makefile                            |   1 +
>  drivers/crypto/jz4780-rng.c                        | 168 +++++++++++++++++++++
>  7 files changed, 223 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
>  create mode 100644 drivers/crypto/jz4780-rng.c
>
> --
> 2.10.0
>

The rng node which is the child node of CGU is ignored so the driver's
probe is not called at all. Realised that the tests were using crng
instead of this. Don't know how to get this working. Will submit a new
version once the issue is fixed.

Please do not take this patch series.

Thanks,
PrasannaKumar
