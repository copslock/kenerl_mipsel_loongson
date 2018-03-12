Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 21:40:25 +0100 (CET)
Received: from mail-ot0-x242.google.com ([IPv6:2607:f8b0:4003:c0f::242]:42750
        "EHLO mail-ot0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeCLUkSu4-69 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 21:40:18 +0100
Received: by mail-ot0-x242.google.com with SMTP id l5so16665903otf.9;
        Mon, 12 Mar 2018 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sbbJGMrc8rQDNucZr8vh05Os3jq6cg6zlGFQ7U/cljU=;
        b=oh5pXO+TJusUU+n7076fZCPcrjy8rRrbgKnYHQI9H3iFzJHipIPFFGpCpRzBhu/2yP
         QMVrrVC64t/CZPLYHEuIWzFT4ZDy8I4206R19zdxlLIgxX3yhUnY+FKcuhS8C3HbMdWs
         OA41GWKrz7qI1fUYkujiF329v4aiuh13BEJP6t8hR0HFuz0w9fCbmxM9vgfdruJabO62
         7XVURRn1/hzdKZWyNlDT7zJnTusFZqa1hwmmXmipy4Zj28a/PEljtX0mkMh4Jut9zB+i
         xzKNkuu0kwMLwku5u7lOOb1IdPc2iPhgJv5vFQx00xq5T/hoq2gjjIo2ybMYXFEsI2bi
         xdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sbbJGMrc8rQDNucZr8vh05Os3jq6cg6zlGFQ7U/cljU=;
        b=tIDyY1HwX96qPaeA5+MH84z2+2GYCbs3RMS8hj3addQVwgRSxMttcn8Ip6C53Ej5bn
         qNZWVaiMlJVzCXY4oK2fLJNryENToHmBgD3lxz31iXU76q7OeiOD7E0VynmFnogdp8b1
         8GVXzO9EEn5XHtW4YbN2R28mSe4X2JJaJKxmOBAvURsBWiy8jpFAsqtENkVeK9zpqeAP
         /PZVjYtaDYX3D3QokqH91aVLKpZDksatqq1SpLoCzfQPLzKi3lZYIMFy2LYKHlR0eqXA
         nxfdJNo8zgdq1YZEJBlFpMewAn96bWpQTICmBQErc8D+AM4msZYN9n/prpvjeneFf9xl
         XRWw==
X-Gm-Message-State: AElRT7H9lrM7gjMvoQ6oFmlVPJ/FCRet0agypU3++3tQHwT8ffmjxFwA
        9e5YN+5NeaLkDRaxh8B+Luocxuptlunzq6urYfM=
X-Google-Smtp-Source: AG47ELt9UvoqVic8nolTz5lL372PdiV9zssyQZIEt3RtYmYzBRlMLz3AeOQdJOfELs/w66oal7PAyNi8OAgxZEIiGxE=
X-Received: by 10.157.41.99 with SMTP id d90mr5989467otb.396.1520887212701;
 Mon, 12 Mar 2018 13:40:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.64.3 with HTTP; Mon, 12 Mar 2018 13:39:52 -0700 (PDT)
In-Reply-To: <20180311174123.2578-3-hauke@hauke-m.de>
References: <20180311174123.2578-1-hauke@hauke-m.de> <20180311174123.2578-3-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Mar 2018 21:39:52 +0100
Message-ID: <CAFBinCBGeS_-dKX09y7xF3w1+9cnG6peq6PtzFs44Fdd4fF1yA@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: lantiq: ase: Enable MFD_SYSCON
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, john@phrozen.org,
        dev@kresin.me, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

On Sun, Mar 11, 2018 at 6:41 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Mathias Kresin <dev@kresin.me>
>
> Enable syscon to use it for the RCU MFD on Amazon SE as well.
>
> Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

> ---
>  arch/mips/lantiq/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
> index 692ae85a3e3d..8e3a1fc2bc39 100644
> --- a/arch/mips/lantiq/Kconfig
> +++ b/arch/mips/lantiq/Kconfig
> @@ -13,6 +13,8 @@ choice
>  config SOC_AMAZON_SE
>         bool "Amazon SE"
>         select SOC_TYPE_XWAY
> +       select MFD_SYSCON
> +       select MFD_CORE
>
>  config SOC_XWAY
>         bool "XWAY"
> --
> 2.11.0
>
