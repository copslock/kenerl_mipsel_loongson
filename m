Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 21:56:55 +0200 (CEST)
Received: from mail-qt0-x233.google.com ([IPv6:2607:f8b0:400d:c0d::233]:36723
        "EHLO mail-qt0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993893AbdDXT4su0dm0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2017 21:56:48 +0200
Received: by mail-qt0-x233.google.com with SMTP id g60so123738910qtd.3
        for <linux-mips@linux-mips.org>; Mon, 24 Apr 2017 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Qjd4R/C4AKlFTvUAhKoDzEmT6m/D3MZfcIf7ILplGI=;
        b=khcdJv0EhU57k8d5FACFj1jEt5pzI8TcrfIpohCB+A2OIKejDOuXn2pBYU2BMg0DZm
         8vtCLj7kfFvs2YWQckN28N/Ko+Hv2+mMtGtoaMFPOr3DAkYkkukdoqJyB8WioKUR/QxR
         kk8DLGOJ1LodtJ5thtVamZtjFx1uNGmeSCUSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Qjd4R/C4AKlFTvUAhKoDzEmT6m/D3MZfcIf7ILplGI=;
        b=TTJYag7RFmHL8qcfJoXJkSru/RoiRBWbZMibiBh+KbIT7Yg3MiFy+qxncJ5OawygDz
         Zup5vwXslgZXV1upWAhUa6uYci0WoxbKITonhYPpycvJlPXY+9LUMkX9ZdaTyMpxXH0G
         qkBDj3oS4zNe4mKFvIu+rMxn1cbGZQfb5s1B9EyKTB0I11hmHqnouPrWUru1uQAsZSSy
         yzSSBwFoDkyqq7cGo6Lee4yH0pQXP+LdepNvs7CZ5OVeQDgO4CSNbDDwUgEgZvF7/EBq
         EYhNw3pP/165vIgq2im+d2PRAD6f85wvmB0X+TJJJ/NM/zc4oivaXHHS4UUgzUH3AmUL
         tiMA==
X-Gm-Message-State: AN3rC/6EDPVTCvesOrwMv0OHbzH3MhHoORqB6TOcHqO/4thqZDwg+w7L
        2+KB4VLswEJjhR91CTKfR/ah/Klt4Mj0
X-Received: by 10.200.54.121 with SMTP id n54mr25920193qtb.275.1493063802967;
 Mon, 24 Apr 2017 12:56:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.37.246 with HTTP; Mon, 24 Apr 2017 12:56:42 -0700 (PDT)
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Apr 2017 21:56:42 +0200
Message-ID: <CAPDyKFoAeyqnomWSphRt95WPDuhHRnAuowYHRnMkAB6izZv4nw@mail.gmail.com>
Subject: Re: [PATCH 0/4] MMC support for Octeon platforms.
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57777
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

On 24 April 2017 at 20:41, Steven J. Hill <steven.hill@cavium.com> wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
>
> Enable MMC support on Octeon SoCs. Tested on EdgeRouter Pro,
> SFF7000, and SFF7800 platforms. This should be applied on top
> of the "Cavium MMC driver" patch series from Jan Glauber.
>
> Steven J. Hill (3):
>   mmc: cavium: Fix detection of block or byte addressing.
>   mmc: cavium: Add MMC support for Octeon SOCs.
>   MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC
>
> Ulf Hansson (1):
>   mmc: core: Export API to allow hosts to get the card address
>
>  arch/mips/configs/cavium_octeon_defconfig |   5 +
>  drivers/mmc/core/core.c                   |   6 +
>  drivers/mmc/host/Kconfig                  |  10 +
>  drivers/mmc/host/Makefile                 |   2 +
>  drivers/mmc/host/cavium-octeon.c          | 351 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/cavium.c                 |   2 +-
>  include/linux/mmc/card.h                  |   2 +
>  7 files changed, 377 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/cavium-octeon.c
>
> --
> 2.1.4
>

Thanks, applied patch 1->3. Patch 4 is for the MIPS SoC maintainer,
unless I get an ack for it.

Kind regards
Uffe
