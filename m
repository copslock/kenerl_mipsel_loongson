Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Sep 2017 19:36:42 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:34458
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994867AbdIDRgc3B7iF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Sep 2017 19:36:32 +0200
Received: by mail-io0-x244.google.com with SMTP id f99so594761ioi.1;
        Mon, 04 Sep 2017 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8XVwHu0F1Qys7zDKeOT28OK8YZd6+hlG07g1XymBYjs=;
        b=slD4nj2Ok6PmLosisAhLgxlXB4g5TlpK7s7GpUX03QC6tFOMHLWcB0BtoRmfSxhjT+
         U89afHlXo5DDsgck4/PyDbpJVBVhKI1mKQdCM5u6CxghSegM9+uw7u23qLiOPBCeWKSv
         wTMaQVB3c/cHkqnTNjOop1ZuqDTQRrEbrpFvbGgen3wsM6jD2SLLIQgj9+xBTmFEhnbl
         za4HL4RkDOGP0DgbOsQ2DfuymDb2Z16LuEqQo7+YgC/9ci95SelFd57su1GSC2gc3zX2
         oOlHFRipdvrkoepbXgXfIMNNGcmdTJAd0mfWAAb+OxE/MxIzuz0NYYilXalB8s7K6hvF
         bO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8XVwHu0F1Qys7zDKeOT28OK8YZd6+hlG07g1XymBYjs=;
        b=FZrOJ0eY8zta96oLcJ1Bdncovjbb1NhtNLKpX6BWYyZ5mydApzS/w3Uy31g21lPhab
         4S7s0x6zKFu2K/y+IUiVwIVRMHPy0ybt4O8BKovTXJ7BjY8ZHARGKNq4zNrIT7o1tGEc
         tfcue6eRGH6L7OEiGdwccChDrgEmC1l9w6mJCt7LsTTeAXOYueXpcz5/MmGPGRowNBkq
         vKyraSkB5nKd+L8ewV3MehuKwvcd8fmSyMJdglASyDTrNWW2aPMYoM9XjDmSHOR0nl3/
         5vK/JQ1+BRMJyJ54zh/iIZkAd+H0BM+0fDUDtKLD3bk8/YWdNgvkaHI4Wxr7eHJV8d0Z
         +gNQ==
X-Gm-Message-State: AHPjjUgeTqs7taxcLO7/XBDF7ETDd0EPI0NdRtcAe+t1kQXnRyGZfQTt
        e4gv9NssLYoPK1WsoBcXIFx14mp6KQ==
X-Google-Smtp-Source: ADKCNb6beUSWMJP+HvP76C1wKFa4HyLfCd1IzQVZI4t1R1bSfS+ml6j4vP1wgrP6qkJi1yosqho+x+sOJrpnGQu41AU=
X-Received: by 10.36.5.206 with SMTP id 197mr1782505itl.79.1504546586514; Mon,
 04 Sep 2017 10:36:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.153.53 with HTTP; Mon, 4 Sep 2017 10:36:06 -0700 (PDT)
In-Reply-To: <20170819221823.13850-7-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de> <20170819221823.13850-7-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Sep 2017 19:36:06 +0200
Message-ID: <CAFBinCACuJ8gs+k4hu+JqpbfS2oJyu2di_2rqqyAFxh8kDOivw@mail.gmail.com>
Subject: Re: [PATCH v10 06/16] MIPS: lantiq: Enable MFD_SYSCON to be able to
 use it for the RCU MFD
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59925
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

On Sun, Aug 20, 2017 at 12:18 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/mips/lantiq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
> index 177769dbb0e8..f5db4a426568 100644
> --- a/arch/mips/lantiq/Kconfig
> +++ b/arch/mips/lantiq/Kconfig
> @@ -17,6 +17,7 @@ config SOC_XWAY
>         bool "XWAY"
>         select SOC_TYPE_XWAY
>         select HW_HAS_PCI
> +       select MFD_SYSCON
>
>  config SOC_FALCON
>         bool "FALCON"
> --
> 2.11.0
>
