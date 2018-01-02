Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 11:29:23 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:44133
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeABK3RDvJf7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 11:29:17 +0100
Received: by mail-qk0-x244.google.com with SMTP id v188so33467024qkh.11
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qfjKXtZt+M5JKOq/3qU+LNmrxcg5PJqG2jPHSJt088Q=;
        b=NbZ244SftgiA5W/RcyfKrQSoy2Q7tmtsTwyOyNBGYZTq3MwDsBZ2UiHpEQHGajWfsl
         nnLru9ngeUEqYYJoLrvzdmymhC4+9nfATMh5SroCKTHQOjKyUi+tXT8KWIVMdyzu6xez
         29JogSJd1vaJ42PHcuxi/iM4Z0o6C/5dpvjsFrMZRNzTo0AZj0sX7qy1+MzAtoESZ+Wx
         YDYYpDM0qqeNcEH0BtaTSYFeC8qVC0eh/TuIoy+eLBw5rRrm7KaECEULTNnZALM5Gd2p
         KShnjL6l+g4rB4BIPBdwnAlFyV9s/rpO8Usffm5+iwlOJW+SiuZLxSmPB87WO1yDGl56
         0Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qfjKXtZt+M5JKOq/3qU+LNmrxcg5PJqG2jPHSJt088Q=;
        b=V1I4NmaFS9oMBhQu2w6vV3LZZHGnbcELo4r+p3488YZZkV3HiBSJi/HZNz0RD8Bc7r
         hKmT4OeaKQ/gnBaopTqPPBW/Mx+38lF6O9CY+FScBzopK27BZ97DH73j+d3xHejNNfr9
         9nDLMIGu5J/289IG0H/futUNz4HJJ6cHxqiKpjqnW4H9y6SES6aZkFT2ia780lgkKV73
         2H1tKbUHqMomB8yQU9TpO7788MT1pTJm0121BYuhnyi9InFuDIOOiBUnTf8IrFYqCw6O
         YGE3608+u3zckTXiF+F9je9OOQ0lftmSFvk/TF+X7qrvpnjZSa+6vReqznq5Ttzny+IQ
         6SsQ==
X-Gm-Message-State: AKGB3mIsFBSwnWQtmpZ2sWsA0RsfWZ4Ej1zUTpaZBqKDyZn2HKQ/ktXQ
        4R6atAVbk48v01hy6isIASNpUYrQfwC1d/lsq7g=
X-Google-Smtp-Source: ACJfBosNH1RDBVToRHUH8e3Jz325i8NnKH7E7ZaJYGNEvf5hnfEy3bdaJSSG1FmoX13TBB8Z9UZ2JFfdImq3g15LkT0=
X-Received: by 10.55.99.140 with SMTP id x134mr47007336qkb.35.1514888951247;
 Tue, 02 Jan 2018 02:29:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Tue, 2 Jan 2018 02:29:10 -0800 (PST)
In-Reply-To: <20171229081911.2802-30-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-30-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jan 2018 11:29:10 +0100
X-Google-Sender-Auth: drZoEJHFwEyPr2WG9pptpvwNdUw
Message-ID: <CAMuHMdU0_p4RHSKL891YCgej_L2KM5cxmhXDLXVUBXgWoUosVA@mail.gmail.com>
Subject: Re: [PATCH 29/67] dma-direct: use node local allocations for coherent memory
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Missing patch description explaining why this change is desirable.

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -39,7 +39,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>         if (gfpflags_allow_blocking(gfp))
>                 page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
>         if (!page)
> -               page = alloc_pages(gfp, page_order);
> +               page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
>         if (!page)
>                 return NULL;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
