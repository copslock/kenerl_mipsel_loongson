Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 09:52:04 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:34631
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbdGCHv5bjG0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 09:51:57 +0200
Received: by mail-qt0-x244.google.com with SMTP id m54so19994383qtb.1;
        Mon, 03 Jul 2017 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nPHVfn4UDOrwnzzoiAHPjt0Ph6QZRMqM2EwojBngqs8=;
        b=eGeze+tdPCbQTNT8c3AKbAbJw2sKzy3kpGexeGcWaLyINXuKwWo4hv2SPUbqpb4pDW
         TG9iadNAL1t88cqKDeNnZZUcBN+/uQ9upu/ppAVDS74t/70d5BCZC0LJtd34Z66azmSd
         muDQZI6iEaIRP9+aL0fwgVpXuzRZQQTkAfIYXJe9nDRHxqfeaSTYnLSbuHIIXoWLCQQA
         p775nHg83jGM86lVXqYYnbOGFR29ipVRsZuXiV83/gurjwyGv5tsODQ7vDPQ4yQhcD6o
         8OUh3DOu+86krgA/qEKo6U1MMuLiQzCXYnGcv/wKJzW+yiTZmyQbSm/lkhIyJG4Yi/oj
         mtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nPHVfn4UDOrwnzzoiAHPjt0Ph6QZRMqM2EwojBngqs8=;
        b=oxMAKw33wM/VGJ8t7C1MIO2x6KGMru3Ptoo1UnE4r5e8/rZGVPMT8NCco5V2CP11zz
         n0lIM2HGWJgzNijnfVZ1s+DHHvvAJTkEosS2c4gqZCoXKwy+31jQnDUlNmtq+6U4BSie
         JREAMx6V5wSuHP6+r+MwvsbHFHEa71sA4Lt94sh7ztfJOjnpdQiYgRo6IskYi0KDq2YT
         /5L6nYChc4SjQo+okKdkfwpl5mmAbfDooSyCX9kRTyzmt8osmOt4DtUIf6UmMqbmBRIi
         0CZ9wAIOZmbMjR3NXFucSO3lZIDwkrUzRBiKPfbOmEX0Jc4Ng9ZOp/jdy3ks7hGdFNM6
         nNag==
X-Gm-Message-State: AKS2vOwOwC6j0I4mCw5Bw62ZK1ClPguj6ywKRsfAXNBIzHOYq5gQscuY
        /gLsW6nDn5KYUTesfvGyfLo0aa6vFg==
X-Received: by 10.200.41.238 with SMTP id 43mr39573876qtt.168.1499068311933;
 Mon, 03 Jul 2017 00:51:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.137 with HTTP; Mon, 3 Jul 2017 00:51:51 -0700 (PDT)
In-Reply-To: <20170702224051.15109-11-hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de> <20170702224051.15109-11-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Jul 2017 10:51:51 +0300
Message-ID: <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Mon, Jul 3, 2017 at 1:40 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> The reset controllers (on xRX200 and newer SoCs have two of them) are
> provided by the RCU module. This was initially implemented as a simple
> reset controller. However, the RCU module provides more functionality
> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> The old reset controller driver implementation from
> arch/mips/lantiq/xway/reset.c did not honor this fact.
>
> For some devices the request and the status bits are different.

> +Required properties:
> +- compatible           : Should be one of
> +                               "lantiq,danube-reset"
> +                               "lantiq,xrx200-reset"
> +- offset-set           : Offset of the reset set register
> +- offset-status                : Offset of the reset status register

Just one side comment (I'm fine with either choice, just for your
information). Recently I have reviewed at24 patch which adds a
property for getting MAC offset and my reseach ends up with the naming
pattern mac-offset (as many others are doing this way). So, perhaps in
your case it might make sense to do that way? Anyway, it's a matter of
a (bit of a) chaos in DT bindings, whatever you decide users will live
with.

-- 
With Best Regards,
Andy Shevchenko
