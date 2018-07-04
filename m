Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 18:52:45 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:41313
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994657AbeGDQwfCGm6t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jul 2018 18:52:35 +0200
Received: by mail-pf0-x244.google.com with SMTP id a11-v6so3084377pff.8;
        Wed, 04 Jul 2018 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fGWUjIyQjivT5mY8dhmiKszGTEUsn3DD9lSHrF6HmJE=;
        b=kA5ZTVtyRe0NIu4QfY3UFI7oxr9JkFjMxPLho5hKn8KbVX03amMSJqYYBlnl4ZMxwc
         NoiPbg3j6QHGoYaGwxMQ4AXMdhwZwHJFplXTBFI67tWA9/1PRQMap3w3+hFQGHmd+/nZ
         PprXYdxWuL8iDLeZ2AojI+yQMqTl0PReLbG8cMrqHCEM/F9rFNmDXjpbYU6f7KkKuo4a
         IwdM+Ejb44Kivqp3EfWtb9gXa9RqC3JxQy0yGh7u5lJP4nVsz4dlmSgNK6BITgpjHDvC
         HLNgCMhsRXBdrngqzVfl2yvc9EhkOYfWfqDxG4Q5TBUwC0jW/abe4ouAb3u1LbobyhLh
         DJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fGWUjIyQjivT5mY8dhmiKszGTEUsn3DD9lSHrF6HmJE=;
        b=dvkSDqGFS/g0h16tccqTX9vJZh0Kee26e+fuSJgWC0aJgl/HT2vPvP5zjTVNCgkRpV
         bUT2ZuxjRlq8snXCUUtZDGaljQgDXW6THz3SsQZDzpVx4MWpk60OOCdyMA+GzeiMo014
         74fiPssYQIn2pWLfa67k9suWFxP7HfQKv7CIun4DJ8cyhna/51aJBmPS4/dOmU7ImctQ
         2rJIEya9MJ8YUpcyPQCSd1ozkxV8+nkdJJGQu+cVluJ84sRp3GrrWfZkcToQ7qprHicA
         yxmXnjjYnfQ8J+XkvI/Gsum2cARaaGocLfTWhyiuVAtA+0j7ok8xV23xf42AjqGLbhdw
         AEew==
X-Gm-Message-State: APt69E2qLcLXnt+v2Rs5scJtrwkV2yUz22YpDcxVL5uCRHlqoYQDWFDr
        XssrXc6ocJ34tRQQ5VUj1ec1jsJCgor88EVWVMI=
X-Google-Smtp-Source: AAOMgpeaV4hJ1nP9OJ1yZJQflDSfZnXwRBYmWFmwbxjj+RKrn8u2C+K1KuywszG17+yJoVA+Sdbgv6nLE0SsL85Xcns=
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr2575063pgt.337.1530723148220;
 Wed, 04 Jul 2018 09:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:52:27
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-6-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-6-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 22:22:27 +0530
Message-ID: <CANc+2y4L3WPUn39fmy+D=vYT7jwYcc+0Ox3sZ8V6cyM511UmhQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740 SoC
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
X-archive-position: 64618
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
> The JZ4740 SoC has a single DMA core starring six DMA channels.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/dma/jz4780-dma.txt | 1 +
>  drivers/dma/Kconfig                                  | 2 +-
>  drivers/dma/dma-jz4780.c                             | 4 ++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> index 0fd0759053be..d7ca3f925fdf 100644
> --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - compatible: Should be one of:
>    * ingenic,jz4780-dma
>    * ingenic,jz4770-dma
> +  * ingenic,jz4740-dma
>  - reg: Should contain the DMA channel registers location and length, followed
>    by the DMA controller registers location and length.
>  - interrupts: Should contain the interrupt specifier of the DMA controller.
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 48d25dccedb7..a935d15ec581 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -143,7 +143,7 @@ config DMA_JZ4740
>
>  config DMA_JZ4780
>         tristate "JZ4780 DMA support"
> -       depends on MACH_JZ4780 || MACH_JZ4770 || COMPILE_TEST
> +       depends on MACH_INGENIC || COMPILE_TEST
>         select DMA_ENGINE
>         select DMA_VIRTUAL_CHANNELS
>         help
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 7b8b2dcd119e..ccadbe61dde7 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -133,6 +133,7 @@ struct jz4780_dma_chan {
>  };
>
>  enum jz_version {
> +       ID_JZ4740,
>         ID_JZ4770,
>         ID_JZ4780,
>  };
> @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
>  }
>
>  static const unsigned int jz4780_dma_ord_max[] = {
> +       [ID_JZ4740] = 5,
>         [ID_JZ4770] = 6,
>         [ID_JZ4780] = 7,
>  };
> @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>  }
>
>  static const unsigned int jz4780_dma_nb_channels[] = {
> +       [ID_JZ4740] = 6,
>         [ID_JZ4770] = 6,
>         [ID_JZ4780] = 32,
>  };
>
>  static const struct of_device_id jz4780_dma_dt_match[] = {
> +       { .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
>         { .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
>         { .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
>         {},
> --
> 2.18.0
>
>

Patch looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>/
