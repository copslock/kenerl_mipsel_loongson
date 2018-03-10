Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 18:02:43 +0100 (CET)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:36645
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992336AbeCJRChLtW3A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Mar 2018 18:02:37 +0100
Received: by mail-oi0-x241.google.com with SMTP id u73so9285105oie.3
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2018 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Kw6MTIoQrLC/GFjxdXLbZyLB5ZjlcyH0mcrMjry7K3o=;
        b=GhGnR92pH3hj+8ucb6d10Yfb53nFKkqrnE6SzXDkECalmMm+Q+xo1XxzuaFRntIoyH
         Wn/TtHKCl68nREYJgENRx9FwUXS3P6RDsSLP9yj2XREhh8VlYrMdm1ZRYxrgHFwTp9sj
         en+pKYpCTprcu1gAlCyDYP8ZrfcoQ0vzcvMMzNVEk3yeoygQe7cUjSzKIxP1p8y6zEh7
         G7n2anKwueC2B6t3KJUHX1jGh1DGmtshBUI0MeBBWQB0kIQqAKb1zfZqhONJuShd26/x
         VNt6jzg11Jh7KuRWkhSJZpeAlSBNtMMmi/M/avi1pdaLMzMge9mMyCZW2HjU7ygtEshS
         njxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Kw6MTIoQrLC/GFjxdXLbZyLB5ZjlcyH0mcrMjry7K3o=;
        b=CK8DLxQxTLA/oJhOywE7qVVCpgPk2bAGfV7vBe2n+Dz0vSwiwbAQOPKTrDKklLZhjX
         ecGGOFrUOFZ4OX5hAA/OKp5mzDEEit+nW4rhxwcUPa8P/7AK3T2yRlTN0TXIDcnXqfPD
         43RcYuBi93bdJv4aenVCOWUGmXzre7ZJmb/5QyeQdlDu4zT8whBejeBODVECY6N+KWcY
         1jvNMmn8LSJEFF+2YefCcrEVUd4V6T9a3HUL47oUffJLMwOrphfsKAxz50t3XYFpidjV
         iTzcX8gUWvYGX5JbzjB1B4KeEnBaNHQEa0fwB2kkyDa6c7ZUxkA1oR72qP5BxEKeE87F
         Obyg==
X-Gm-Message-State: AElRT7FRjVJhW459PNv4sNwgpzJXud/bFkjWhmhmDXUpLXFuwdjtO+Gj
        bLpJT+v5evkrHS8Q4g7puIq4WWiCdxHzeWJST4Q=
X-Google-Smtp-Source: AG47ELtlZWXcvuV69+mg0iNba24UEen+juU4o/uxC+zwPQ9YCjDsnCA/HWffqPsvl5lIlq4Lqo1KaxwX+oywzNgFsF4=
X-Received: by 10.202.51.138 with SMTP id z132mr1538351oiz.67.1520701350695;
 Sat, 10 Mar 2018 09:02:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.201.20.79 with HTTP; Sat, 10 Mar 2018 09:02:10 -0800 (PST)
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Sat, 10 Mar 2018 18:02:10 +0100
X-Google-Sender-Auth: 5gSJ-m9iZfNwucvvoTY5xa8DWsU
Message-ID: <CA+7wUsxuavjaVOpoOEVJp4gSd+J_FQ37JuRE_N2BhEqOx7G1yA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Enable SD/MMC on JZ4780 SoCs
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Fri, Mar 9, 2018 at 4:12 PM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> This patchset adds support for SD/MMC on JZ4780 based
> platforms, such as the MIPS Creator CI20 board.
>
> Most of the work has been done by Alex, Paul and Zubair,
> while I've only prepared the upstream submission, cleaned
> some patches, and written some commit logs where needed.
>
> All praises should go to them, all rants to me.
>
> The series is based on v4.16-rc4.
>
> Alex Smith (3):
>   mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
>   mmc: jz4740: Add support for the JZ4780
>   mmc: jz4740: Fix race condition in IRQ mask update
>
> Ezequiel Garcia (9):
>   mmc: jz4780: Order headers alphabetically
>   mmc: jz4740: Use dev_get_platdata
>   mmc: jz4740: Introduce devicetree probe
>   mmc: dt-bindings: add MMC support to JZ4740 SoC
>   mmc: jz4740: Use dma_request_chan()
>   MIPS: dts: jz4780: Add DMA controller node to the devicetree
>   MIPS: dts: jz4780: Add MMC controller node to the devicetree
>   MIPS: dts: ci20: Enable DMA and MMC in the devicetree
>   MIPS: configs: ci20: Enable DMA and MMC support
>
> Paul Cercueil (1):
>   mmc: jz4740: Fix error exit path in driver's probe
>
> Zubair Lutfullah Kakakhel (1):
>   mmc: jz4740: Reset the device requesting the interrupt

Nice work. Entire series works just fine on my MIPS Creator CI20 (v1).

Nitpick: could you update the email addresses:

s/imgtec/mips/

thanks

>  Documentation/devicetree/bindings/mmc/jz4740.txt |  38 ++++
>  arch/mips/boot/dts/ingenic/ci20.dts              |  38 ++++
>  arch/mips/boot/dts/ingenic/jz4780.dtsi           |  54 ++++++
>  arch/mips/configs/ci20_defconfig                 |   3 +
>  drivers/mmc/host/Kconfig                         |   2 +-
>  drivers/mmc/host/jz4740_mmc.c                    | 232 ++++++++++++++++-------
>  include/dt-bindings/dma/jz4780-dma.h             |  49 +++++
>  7 files changed, 349 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt
>  create mode 100644 include/dt-bindings/dma/jz4780-dma.h
>
> --
> 2.16.2
>
>
