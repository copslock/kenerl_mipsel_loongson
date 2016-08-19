Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 02:59:59 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35560 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992310AbcHSA7vv7Xl5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 02:59:51 +0200
Received: by mail-oi0-f65.google.com with SMTP id e80so5081330oig.2;
        Thu, 18 Aug 2016 17:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yP3mMu662hFFo4Cu1Rfj/+LL+w0BtxEHQVDmEWu3MJ8=;
        b=guMgpk4pCGvTxbb47VHrwgGXZ7Q2qqHk2vR+v/Zqrf3JyULrIjzbwM72SbrPeCUxlJ
         dbcHFsXwOXlu5B8pXgYNrh3qdEgs4kpye7vUdWI/OWJAEpiIikazKqMUvC7Ul96bFZWP
         jnbPIJnpTMLZrEiJQEc3/tf+FT9w+o51+juyo4sWExx3I4CfcJFmRwOB6EoL/SnWCrmi
         kAKD+ymMNoIhf2kKrswjGqc6SkIGFh9/zho1UdaYsz/iHIJZZZaY8qfpXmuACnB/Kfef
         AYAwPCcNfP8pXZqfSmKW8BILxhNeIqqcevW5BH5GdG/uVkaAIazXDc7nlFl2CnV6PvWv
         RxBA==
X-Gm-Message-State: AEkooutnmDNoxxvj/HV1KUE5rj9B9QefpA8gSQcIlpNn3ZdGq4DDfwkTrCsWK2J8JC9I2g==
X-Received: by 10.157.63.221 with SMTP id i29mr3253847ote.156.1471568385828;
        Thu, 18 Aug 2016 17:59:45 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id s132sm2499092oif.3.2016.08.18.17.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 17:59:45 -0700 (PDT)
Date:   Thu, 18 Aug 2016 19:59:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au, mark.rutland@arm.com,
        ralf@linux-mips.org, davem@davemloft.net, geert@linux-m68k.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mchehab@kernel.org, linux@roeck-us.net,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        alex.smith@imgtec.com, daniel.thompson@linaro.org,
        lee.jones@linaro.org, f.fainelli@gmail.com, kieran@bingham.xyz,
        krzk@kernel.org, joshua.henderson@microchip.com,
        yendapally.reddy@broadcom.com, narmstrong@baylibre.com,
        wangkefeng.wang@huawei.com, chunkeey@googlemail.com,
        noltari@gmail.com, linus.walleij@linaro.org, pankaj.dev@st.com,
        mathieu.poirier@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
Message-ID: <20160819005944.GA1711@rob-hp-laptop>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54668
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

On Wed, Aug 17, 2016 at 09:05:51PM +0530, PrasannaKumar Muralidharan wrote:
> This patch adds support for hardware random number generator present in
> JZ4780 SoC.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  .../devicetree/bindings/rng/ingenic,jz4780-rng.txt |  12 +++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   5 +
>  arch/mips/boot/dts/ingenic/jz4780.dtsi             |   7 +-
>  drivers/char/hw_random/Kconfig                     |  14 +++
>  drivers/char/hw_random/Makefile                    |   1 +
>  drivers/char/hw_random/jz4780-rng.c                | 105 +++++++++++++++++++++
>  6 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
>  create mode 100644 drivers/char/hw_random/jz4780-rng.c
