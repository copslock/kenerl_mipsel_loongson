Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 16:58:51 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:34707
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbeDKO6odlzFW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2018 16:58:44 +0200
Received: by mail-io0-x244.google.com with SMTP id d6so2709731iog.1
        for <linux-mips@linux-mips.org>; Wed, 11 Apr 2018 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QzXJSbzNA3VmaUepN+F+/8yVpkwQRZbjAWk98Sh3KjQ=;
        b=F0dmpdFhBryxpipUaYzw5P08ucO060hnwLBz7gFIAkZFqsnV2roUNZ9jE0lBu7IMhq
         S/Vp56I24ooc/GX0YFInNcjkic9MA8MRf125wSdBKKlgjnrvmnfvUjf8oCGogT64F8dD
         UYgL6mJx1D+et7ACO+rzQeQfIEW9h1noFu6sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QzXJSbzNA3VmaUepN+F+/8yVpkwQRZbjAWk98Sh3KjQ=;
        b=k0CBvd3ikS8XWnm/l50QL5bf3GTWeGR578315acPNo04Z4hDymA6Es7YCmgXAzsTBR
         YVBR6vtyYiah+iGFMxPUASc8cfvJhz+Pgm0eUpNc6ZrF/zaVm8+n3vuQzbOjee9GMUXd
         Y4XFsipNs1O4TNlwvsqy+a8w3D7KJCDfpWEU7zWjK5yDkb66uvP7byFoqxN+ZbGgPJAT
         9QipitBTcuMinBfyjjOvWXbWlnBouwuCCkordqTBpVhvV518UtHmsrfdZCw4+pUmv8el
         EGdguqngEC9jgZoUgbpVm1yJwiFL0LCrl7LCMrBUqsgh7Nv/OgNSzDpk3e08Rq3qyMGW
         KDXw==
X-Gm-Message-State: ALQs6tBHl2hJ2bAfdNoHBySoLeCP2xl0H1PPmJgWA2t7bHy6dYLd7Ulm
        6l7AWtnDFLQTfzk59bMfTTKlcXLHiJu23X/8KmW3bg==
X-Google-Smtp-Source: AIpwx49Rk0WAeOnJ5hlqhLNQj8NMf+ZKf3S+HN10oqTdpiq9bG6cB6f0cy+MNffVR5iRW8zrSV59Fp5raNu5NeezqZ0=
X-Received: by 10.107.132.197 with SMTP id o66mr4970830ioi.119.1523458718150;
 Wed, 11 Apr 2018 07:58:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.101.23 with HTTP; Wed, 11 Apr 2018 07:58:37 -0700 (PDT)
In-Reply-To: <20180328210057.31148-16-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com> <20180328210057.31148-16-ezequiel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Apr 2018 16:58:37 +0200
Message-ID: <CAPDyKFrakbziKb-BJ1VR-GJUogBdJ0b8OkvjEVEWNrm+EgkyMA@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] MIPS: configs: ci20: Enable ext4
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 28 March 2018 at 23:00, Ezequiel Garcia <ezequiel@collabora.com> wrote:
> Now that we have MMC support, enable ext2/3/4 support
> in the CI20 defconfig.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks, queued for 4.18!

Kind regards
Uffe

> ---
>  arch/mips/configs/ci20_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
> index f88b05fd3077..be23fd25eeaa 100644
> --- a/arch/mips/configs/ci20_defconfig
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -111,6 +111,7 @@ CONFIG_DMADEVICES=y
>  CONFIG_DMA_JZ4780=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_MEMORY=y
> +CONFIG_EXT4_FS=y
>  # CONFIG_DNOTIFY is not set
>  CONFIG_PROC_KCORE=y
>  # CONFIG_PROC_PAGE_MONITOR is not set
> --
> 2.16.2
>
