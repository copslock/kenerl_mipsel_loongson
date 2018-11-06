Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 00:18:22 +0100 (CET)
Received: from mail-wr1-x42c.google.com ([IPv6:2a00:1450:4864:20::42c]:43116
        "EHLO mail-wr1-x42c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991112AbeKFXQMsyy4F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 00:16:12 +0100
Received: by mail-wr1-x42c.google.com with SMTP id y3-v6so15116799wrh.10
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2018 15:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DpbdRIbQaA1wYedZxLueEoKVXd0GtXSVdWHp5s+Vj5E=;
        b=EV6dDpilBdBrt8A3965PIlZ+GI6J0bE9Nv5NZjJ1O3eS/TGeVi/cYUaAKSt+PuRbgM
         koMU/yG5gtqviznReNYvJjmg6cg37FHB1RHK+e9ya8d88+ZuEKysc9FRqwhVXiLHKYbS
         mol3Q03VMKhtQ3G1LyfkX4hq51EQvE/8zFcSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DpbdRIbQaA1wYedZxLueEoKVXd0GtXSVdWHp5s+Vj5E=;
        b=BaV+JgUjkOlux31Xi32lf02KApjuSkBGADXT4gqs2uaMIyJh/aqCebtMphGX4yL9RQ
         KPq8okljPlgZ69aXxhPB0hmud/nQAtNyG+JX7MqYjeYAPuxvx8uGFXLLn9GkexPKGG0x
         pH9FZj1kKKRNirplV/8fmsjPgO6jRC773Txd28L/Xl+iK7883Ke5vCuLwsMMobFOwMxq
         uMCBjX3ljps/gL7MzPKA2nHHO1hoTvNo3KL5bHJih+cAMLrSDfL6C76YenY4ESS7Pzlt
         6Sax7x8RfypuNFJEqut0kmWF3uRjiPMLWpt/8jTlt0TWbBJKCNHDTrIJVFKcS1h00Dq6
         n4zQ==
X-Gm-Message-State: AGRZ1gIa1kh0hfp4AMps3zH6qOFNz+dAm29goji0RbVK+tH+8IgBc71r
        2uRTrCQnBCWOxU/AOdC05O5xtbYPtQ5yFFSiPZ/tYw==
X-Google-Smtp-Source: AJdET5ctU7zVijdvQObNSvAkB+IVwGhySRRekx3PGLGdflOUkZauUIt6bCg/Bf6gmDu1g4NixHJEDvmfOzIULa02OK8=
X-Received: by 2002:adf:cc81:: with SMTP id p1-v6mr7154438wrj.139.1541546172236;
 Tue, 06 Nov 2018 15:16:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 15:16:11 -0800 (PST)
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 6 Nov 2018 15:16:11 -0800
Message-ID: <CALAqxLWif1wjRHx5X136sBqdg0KJ8itqXPk9G6NJ70Z_QFavzQ@mail.gmail.com>
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        aaro.koskinen@iki.fi, jean-philippe.brucker@arm.com,
        iommu@lists.linux-foundation.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <john.stultz@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john.stultz@linaro.org
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

On Tue, Nov 6, 2018 at 3:54 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
>
> Make sure we only touch it if the DT actually said so.
>
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Sorry about that... I guess I only have test setups that either have
> dma-ranges or where a 32-bit bus mask goes unnoticed :(
>
> The Octeon and SMMU issues sound like they're purely down to this, and
> it's probably related to at least one of John's Hikey woes.

Yep! This does seem to resolve the mali bifrost dma address warn-ons I
was seeing, and makes the board seem to function more consistently, so
that's great!

Tested-by: John Stultz <john.stultz@linaro.org>

Though I still find I have to revert "swiotlb: use swiotlb_map_page in
swiotlb_map_sg_attrs" still to boot to UI successfully with AOSP.
Still not sure whats going on there (its sort of soft hangs where some
userland runs ok, but other bits seem to jam up, even console commands
sometimes hang - almost seems like io stalls).

Anyway, thanks so much again for this one!
-john
