Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 19:01:00 +0200 (CEST)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:42898
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994657AbeGDRAuoxvrt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jul 2018 19:00:50 +0200
Received: by mail-pl0-x242.google.com with SMTP id y8-v6so41514plr.9;
        Wed, 04 Jul 2018 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WmCNuQnfXIq3s1NgAiKKWmRRFnYRKumbuMn4+jV6W78=;
        b=Im7yXsELQES1mJg10768WCMLCLt3SALHdb5RZXFE/C08XTsIu7vHrGlzy080HaobSw
         6QnrNJXJH0pxfltqH2j+ezT7dtxk7dMV0vw+3ENb2U7GZl/HZQDJdkdvzQG6GzmCouEn
         GtvJC/0rRegzi4vd+4WnbDCRzXmVVhWIAV292iuSbU0+I1nIAHD3gVUJGLEW3RTmbHF2
         RGLrrist+G/q9OYltJQXgVF8hWrZ6khf3HFk6eTy+Z7nmWLIaTlgTVwjo6sKt2yUuLOD
         Rsd4sEPmGVBsevtwKipz1dQGuPvWDEzs4d9NKOfsFt9ISe35yffv5Ou+FfpZXujTi4la
         /0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WmCNuQnfXIq3s1NgAiKKWmRRFnYRKumbuMn4+jV6W78=;
        b=dKvEBbfnFDqBh31I80ke8MaHox5UYL93Hp95i1Yq3a9G5sjKsEkBYNNPTzGcwYAUzr
         xrMXktcdxwWFI1oepLoo4CleEooo1lRT1hRFgBgn9ScrgWcMihQyOYcSj5zQ3EVEReUY
         WcU72o0QWCSb4eyWJBD4+KUcmIKc8ByrgfHipqqKWTDuJhMuQ4yo6sJUBK4jixRggR6x
         ez44tadO2nvT4VnFyRJmq4AgINwecc3wP8jsVn6QcGlZoc++PqmE3ylDYpa8dRPyLQDj
         dTi6ENyzzMs49xZwrCo+LKHp7xpX7xV5F94lhzIW9R7LAsPKY3g/k3KF/gAX1hgi3Hkh
         YeDw==
X-Gm-Message-State: APt69E3BJD8/g53eIykDA8DoIPgTZ04WknnoXdxnlv0L7fevK8FGzgeP
        feW1R5jrC2jAQTYPyf/vZwxIv5avE0SSgr6vCQo=
X-Google-Smtp-Source: AAOMgpeAiATEe0IiOPHxhAlzpHF+ycY8wKn3Ggl5XeHi1ess/mPTgJaqZCtQefREufpTlteM4DH9a2XvOJN2FvYQon8=
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11-v6mr2815890plv.342.1530723644342;
 Wed, 04 Jul 2018 10:00:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:00:43
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-8-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-8-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 22:30:43 +0530
Message-ID: <CANc+2y7BU5SmgP8yv46PQx2E1Bz1gb0dOQaM0wG=-iReCd8YyQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] dmaengine: dma-jz4780: Enable Fast DMA to the AIC
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
> With the fast DMA bit set, the DMA will transfer twice as much data
> per clock period to the AIC, so there is little point not to set it.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-jz4780.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 922e4031e70e..7ee2c121948f 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -52,6 +52,7 @@
>  #define JZ_DMA_DMAC_DMAE       BIT(0)
>  #define JZ_DMA_DMAC_AR         BIT(2)
>  #define JZ_DMA_DMAC_HLT                BIT(3)
> +#define JZ_DMA_DMAC_FAIC       BIT(27)
>  #define JZ_DMA_DMAC_FMSC       BIT(31)
>
>  #define JZ_DMA_DRT_AUTO                0x8
> @@ -929,8 +930,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>          * Also set the FMSC bit - it increases MSC performance, so it makes
>          * little sense not to enable it.
>          */
> -       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
> -                         JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
> +       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, JZ_DMA_DMAC_DMAE |
> +                              JZ_DMA_DMAC_FAIC | JZ_DMA_DMAC_FMSC);
>
>         if (jzdma->version == ID_JZ4780)
>                 jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
> --
> 2.18.0
>
>

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>.
