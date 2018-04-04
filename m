Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2018 14:46:16 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:39730
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeDDMqJayag5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2018 14:46:09 +0200
Received: by mail-io0-x244.google.com with SMTP id v13so26182891iob.6
        for <linux-mips@linux-mips.org>; Wed, 04 Apr 2018 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EkO0QQMSwZAtfQ1JC6rJ40q1TiPYlFvHD3Owlwm5Hcg=;
        b=ccSkpN1Hqz0oPYqcXu/6PrIRikPCke9FpUGcjAOOqVStUEf9KOzzPZhLbe8JbKttQ0
         dxWjKY47HHefvZzTgHKmlE1NC8TnTPDo3OL1GKJfmm4mlbqaYV6DvRtx9JHtefmZGzXd
         B2a+Ayfy29mvN1mqRVvJc3rwdTPIeRt2qcmDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EkO0QQMSwZAtfQ1JC6rJ40q1TiPYlFvHD3Owlwm5Hcg=;
        b=B6gaCEgo97xpn/qVXSbeJKnEpmzwqlQoFR2XnspX+1uwMuMonslg0WkrfkJ8WF39cU
         Lmc7V+zdumm4sI2k+h8uO+SXJIqevPl0e9iWnYAdkTyu7GehuiZXO4ZUQwORwUaOu/u3
         bsZLTYthR0Mn6aBa7hzNd9tr9bpeuhNu9A/jb3W24N88dXSdLpYbaJp+WACGCL57cW3A
         Q3I6BB/iLwBMU/CN+kLmu13CJQdV4LOm7vusKw7RY4AJd/ocSJjDK8WYtZUAYkK+Zyfs
         A+3Ttlc1mx88k2blUOY4a6M3TwyxeOC3guKYiqc69opEHuLRrHXRH8Wd9T5VCD+YOp/m
         ZjYQ==
X-Gm-Message-State: ALQs6tAbcrbjTTsP9HU3vFfCwGXUP3ey3jkYdnpM9B4Ec3PmpO3sardY
        awiQh5VtG/SiHSLijip/ZR06yWiRl2UcijhGEnGNFQ==
X-Google-Smtp-Source: AIpwx49Uhgxt+InMrLQ1XvyK4vpp5Qh4dKmETT5HW1cpcZU4N8lyr4IgrR/OGxAJ91GI9xkCVnKOVx6e2eaQ56XNh+c=
X-Received: by 10.107.20.88 with SMTP id 85mr15742843iou.218.1522845963090;
 Wed, 04 Apr 2018 05:46:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.101.23 with HTTP; Wed, 4 Apr 2018 05:46:02 -0700 (PDT)
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Apr 2018 14:46:02 +0200
Message-ID: <CAPDyKFpf2vjwKRbPTOZZDGjp6ruzpGO8WG28W_x9tEWNppOMtg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Enable SD/MMC on JZ4780 SoCs
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
X-archive-position: 63412
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
> This patchset adds support for SD/MMC on JZ4780 based
> platforms, such as the MIPS Creator CI20 board.
>
> Most of the work has been done by Alex, Paul and Zubair,
> while I've only prepared the upstream submission, cleaned
> some patches, and written some commit logs where needed.
>
> All praises should go to them, all rants to me.
>
> The series is based on v4.16-rc6.

I have queued up this series for 4.18, with the following exceptions.
*) Patch 1, which I applied as fix for 3.17.
**) Patch 15, deferred until James acks it.

Thanks and kind regards
Uffe

>
> Changes from v3:
>   * Replaced callbacks with if/else magic to handle
>     the different register widths on versions of the SoC.
>
> Changes from v2:
>   * Fix commit log in "mmc: dt-bindings: add MMC support to JZ4740 SoC"
>
> Changes from v1:
>   * Reordered patches, fixes first, for easier backporting.
>   * Added Link and Fixes tags to patch "Fix race condition",
>     for easier backporting.
>   * Enabled the DMA in the dtsi for jz4780, dropped it from the ci20 dts.
>   * Reworded config and help user visible text.
>   * Reworded commit logs, using imperative.
>   * Re-authored my patches, as Collabora is partially
>     sponsoring them.
>
>
> Alex Smith (3):
>   mmc: jz4740: Fix race condition in IRQ mask update
>   mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
>   mmc: jz4740: Add support for the JZ4780
>
> Ezequiel Garcia (10):
>   mmc: jz4780: Order headers alphabetically
>   mmc: jz4740: Use dev_get_platdata
>   mmc: jz4740: Introduce devicetree probe
>   mmc: dt-bindings: add MMC support to JZ4740 SoC
>   mmc: jz4740: Use dma_request_chan()
>   MIPS: dts: jz4780: Add DMA controller node to the devicetree
>   MIPS: dts: jz4780: Add MMC controller node to the devicetree
>   MIPS: dts: ci20: Enable MMC in the devicetree
>   MIPS: configs: ci20: Enable DMA and MMC support
>   MIPS: configs: ci20: Enable ext4
>
> Paul Cercueil (1):
>   mmc: jz4740: Fix error exit path in driver's probe
>
> Zubair Lutfullah Kakakhel (1):
>   mmc: jz4740: Reset the device requesting the interrupt
>
>  Documentation/devicetree/bindings/mmc/jz4740.txt |  38 +++++
>  arch/mips/boot/dts/ingenic/ci20.dts              |  34 ++++
>  arch/mips/boot/dts/ingenic/jz4780.dtsi           |  52 ++++++
>  arch/mips/configs/ci20_defconfig                 |   4 +
>  drivers/mmc/host/Kconfig                         |   9 +-
>  drivers/mmc/host/jz4740_mmc.c                    | 205 +++++++++++++++--------
>  include/dt-bindings/dma/jz4780-dma.h             |  49 ++++++
>  7 files changed, 321 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt
>  create mode 100644 include/dt-bindings/dma/jz4780-dma.h
>
> --
> 2.16.2
>
