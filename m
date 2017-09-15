Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:51:43 +0200 (CEST)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:38661
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991438AbdIORvfciBKM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 19:51:35 +0200
Received: by mail-lf0-x243.google.com with SMTP id m199so1539681lfe.5
        for <linux-mips@linux-mips.org>; Fri, 15 Sep 2017 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LkOxz7ko19YWFUk/93bL+f82YraDqaR0GElwoHIKlRE=;
        b=cJfBWlIvwrh39cumIHL4cuqX/n2iSZOwN/F/20bsWQqGXZCMDFsfrKJ0SAEEss8Ezb
         x6WX9FpZ2EBMD0NPGJs/TxjnU6BlD1kAs5wdX+H5Wx40wiQyVezgKdy83VbmAqWtaEfd
         nxIBjkPp2gFXIdSb5R0HS+qjf5wEDGbKWJ6Ox2jLwMwgpswbetwkWxcbU/SmpMk2cJi9
         ZoqdMUUNCBkoGlgNQb5gLA+l1SwE06Uf8OPXyAK9EWKEc/twv4BoGPaz0/Y7ogFkFCQp
         FLfslRtgQyUiFtAbJPLj07PI8LHSXi2CXYzlwxwN8mFgXeleHlfpR1fdJIEhxBSKw3RP
         c6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LkOxz7ko19YWFUk/93bL+f82YraDqaR0GElwoHIKlRE=;
        b=C7by6XarTecn3ibZjxIeDE+QRXsb42X9YhA9Mha7B1JiOnkgQFykOjvIrH/7oFicOr
         UH+dJlsrA9rx99RdyNnibmhQ5ANL1LSc7y9QmvY4BkPFGrBl5YjDW/amyPYD82wwYsnA
         twZ93x7xRrLaU2FLElOsLk5zlLtHy13SpgPARC2TCzoWMKS4Lz6hS5Mz9sdXaUU73YTI
         ttxWRMA1J7LYGUmJ0qNXbMPt0NIVW1OM4+Sn6R+5O+2JA6LqjRf1ciAqJFNvx5NZCH5R
         ukCHU0qJe/JaqAE5wmcpcS50MJGdTFQM8vpZRlX3h13uez661qM3UgIxEnroEx13GbqM
         CDgA==
X-Gm-Message-State: AHPjjUggGwYs8uMlyDVf3n7n3mhfyETxGIQviZBchIh3qtvKKqqQ+MBo
        olYM+d9KZCvxGTlhLZ23lM4IyOxmQlxHPX/CC/tFiQ==
X-Google-Smtp-Source: AOwi7QAAC1LorFuNiHWHoRdi/LjCVSaMZRsyzBrPsgXGGNaBVqpNX/Lrt5xwbOEU/2eB2WVrA83o2u7IyCh02DtVp0A=
X-Received: by 10.46.67.156 with SMTP id z28mr9147816lje.124.1505497889799;
 Fri, 15 Sep 2017 10:51:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.199.193 with HTTP; Fri, 15 Sep 2017 10:51:28 -0700 (PDT)
X-Originating-IP: [209.133.79.8]
In-Reply-To: <20170910214424.14945-2-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org> <20170910214424.14945-2-linus.walleij@linaro.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 15 Sep 2017 10:51:28 -0700
Message-ID: <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <olof@lixom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olof@lixom.net
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

On Sun, Sep 10, 2017 at 2:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
[...]
> Cc: arm@kernel.org
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: requesting ACK for Wolfram to take this patch.
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.

Acked-by: Olof Johansson <olof@lixom.net>

Wolfram: Same thing here, maybe this and the other patch can go on one
branch for merge in case of conflicts.


-Olof
