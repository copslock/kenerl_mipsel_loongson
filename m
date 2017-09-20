Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 22:53:19 +0200 (CEST)
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35377 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994781AbdITUxMKJB8t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 22:53:12 +0200
Received: by mail-pg0-f65.google.com with SMTP id j16so2249459pga.2
        for <linux-mips@linux-mips.org>; Wed, 20 Sep 2017 13:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lyIskk6H4f0CWizhoe1/vE50IcZAqdd2ajuPiWbZNM=;
        b=iSBIJXr3FxQHFYgTxVD6MlGZFhZaLtzpRux8UODl2FROvCBz2vXFbomwvRJp4qKNvE
         nAjemdTmIo2ol/wqzFgQRXG5utoetWXCmvGnNOHwAxVjMOsZgJt6Az2La1MjqSvWqvqA
         Jbb/Hb0g5stY5FP3zSpptz3jkmvGPceupQp8fM/yxVeXGeYU4MWnZRWj0o/a4zi6JKt1
         GMjconLC/RCKYHMnN52HOGsD0n3AASUbd22D9T9clH99HPLrjQHbxy40I6F1RgeWvz+V
         JoGAbIZZcEgqd0aW57NSt+4GNBgrN6by3c+N4ZZwhcLplNfBtgjUYuN6025ZZ9+vbF8A
         vWBA==
X-Gm-Message-State: AHPjjUjV97PUQ9Mym6dDdENRWAKTv8JnNNgtON8LcT/tmaOb52OYOk3Y
        IBK3YItUbcmOcrq32wM2Tw==
X-Google-Smtp-Source: AOwi7QA/xK/AQ6JTU/WBmuu/cxX+OYdXdOdR+QUeH+FTTOZ1h4nbJuqCjRkcfKDiNMJ1+rg2OU33VQ==
X-Received: by 10.99.99.197 with SMTP id x188mr3413376pgb.90.1505940785875;
        Wed, 20 Sep 2017 13:53:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:fd28:e83d:5428:912b:b325])
        by smtp.gmail.com with ESMTPSA id j1sm8761371pfc.169.2017.09.20.13.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Sep 2017 13:53:05 -0700 (PDT)
Date:   Wed, 20 Sep 2017 15:53:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        geert.renesas@glider.be, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 6/7] dt-bindings: i2c: i2c-gpio: Add support for named
 gpios
Message-ID: <20170920205304.shkguzlqco3m6weu@rob-hp-laptop>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-7-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170917093906.16325-7-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60096
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

On Sun, Sep 17, 2017 at 11:39:05AM +0200, Linus Walleij wrote:
> From: Geert Uytterhoeven <geert+renesas () glider ! be>
> 
> The current i2c-gpio DT bindings use a single unnamed "gpios" property
> to refer to the SDA and SCL signal lines by index.  This is error-prone
> for the casual DT writer and reviewer, as one has to look up the order
> in the DT bindings.
> 
> Fix this by amending the DT bindings to use two separate named gpios
> properties, and deprecate the old unnamed variant.
> 
> Take this opportunity to clearly deprecate the "i2c-gpio,sda-open-drain"
> and "i2c-gpio,scl-open-drain" flags as well. The commit describes
> in detail what these flags actually mean, and why they should not be
> used in new device trees.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [Augmented to what I and Rob would like]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Create a special section for the deprecated bindings
> - Also deprecate the open drain bool properties
> - Update the example to use the new style of bindings
> ---
>  Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 32 ++++++++++++++++------
>  1 file changed, 23 insertions(+), 9 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
