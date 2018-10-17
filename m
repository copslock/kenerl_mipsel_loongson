Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2018 15:38:30 +0200 (CEST)
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35549 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeJQNiZazbtQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2018 15:38:25 +0200
Received: by mail-ot1-f68.google.com with SMTP id 14so22187658oth.2
        for <linux-mips@linux-mips.org>; Wed, 17 Oct 2018 06:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5EUDX803PiowWWGJP/xW4a3xMrgwy9l/YNKviS+1pc=;
        b=fmj8uAXbOwei0wol0cHH7vh4CovqyBYAhputXkoXetB7evR/GGXbra5FdOqAtbrIOO
         RZpFsTNWkt1CqlPm/ExJu36XH5Z/R48GFSjREuHxZeqf3YFEC+unOmFFGa0Y+1IRnKf+
         NKjgKOPJ6B9CJIZR35dtfD/wWgQNOpwmko5biMMXZl6PeEdd0T+M8Il+I6+tKV5rthCO
         BKkbOOvW6uPF1lUmLafNEpX8ZSFW56EC/2ZHryF8KaxHLn9NMK0464b936EylLOP2Ym2
         bBqxyfO++VX0P7u+SxlNmr7V9XYlR8baaGjMK7otHRtSoTr+qvtNkhRCpi8MCLZuLdXf
         wqlw==
X-Gm-Message-State: ABuFfoiZvFb/rLZjkH5BFsdJDs9AMS304CqAcg5sIkAZv/MnxBm1xmxm
        tWcNNK7c+FTcsWDCzG04w7jV8muUjTBYUKbhwVw=
X-Google-Smtp-Source: ACcGV60v7nSAKQSm8G+Heu6Ct0EUZbvudTFD5A3Z3EcQkC4tS1GOlmez/Obvr/CeaZKqPGKdaYWwd7Rn1r1v1nd8Cfw=
X-Received: by 2002:a9d:488e:: with SMTP id d14mr17599624otf.354.1539783499285;
 Wed, 17 Oct 2018 06:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
In-Reply-To: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Oct 2018 15:38:07 +0200
Message-ID: <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
To:     aaro.koskinen@iki.fi
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66883
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

Hi,

On Sun, Oct 14, 2018 at 7:04 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> There is something wrong with jz4740-mmc in current mainline kernel
> (tested v4.18 and 4.19-rc, the MMC support for CI20 does not exist
> prior those), as the DMA support does not work properly if I disable
> kernel pre-emption. The console gets flooded with:
>
> [   16.461094] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 567 host->next_data.cookie 568
> [   16.473120] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 568 host->next_data.cookie 569
> [   16.485144] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 569 host->next_data.cookie 570
> [   16.497170] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 570 host->next_data.cookie 571
> [   16.509194] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 571 host->next_data.cookie 572
> [   16.532421] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 572 host->next_data.cookie 573
> [   16.544594] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 573 host->next_data.cookie 574
> [   16.556621] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 574 host->next_data.cookie 575
> [   16.568638] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 575 host->next_data.cookie 576
> [   16.601092] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 582 host->next_data.cookie 583
>
> etc. ad inf.
>
> This should be easily reproducible on CI20 board with ci20_defconfig
> and setting CONFIG_PREEMPT_NONE=y.

Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
could you confirm that the original mmc driver (kernel from imgtech
people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
?

Thanks

> A.
