Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2018 09:34:58 +0200 (CEST)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:45551
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992589AbeGGHesxEWtM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Jul 2018 09:34:48 +0200
Received: by mail-pl0-x242.google.com with SMTP id bi1-v6so3836157plb.12;
        Sat, 07 Jul 2018 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pNfVVRyr21nqrWIw7SM71QicGBqxaKES+kmnpFGgnpE=;
        b=Bg3vhCiPymtjyar1QR6cidcOU0lNwYvpNsyDDUmByiXfT8OCsbg74VOP2X2p82kLpm
         Wbo6k2S9Qua/g4NE/fRU5HnOdeEshey4SNkERDFftuXYtKjnOymx9vlud3qqy0BTxjFA
         lzwjoiPK8e9HiG/LEaNSVsC3UabQeTjVj44RnH1gaCDEiZ1IImo02z/hih28oGwq8Hd1
         sGKuv8teGYMpmp277RD2ybTdz/M4E77iuCRRgVk4nicbx9S8b63t0F7BFJiUPtd51P+V
         QnKQ2K8mQuZFmxuMX6IQ6ucqfVURKkNH3aYRym86UOOh1yMKmIGeFvBitGOjV4wrztF/
         k7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pNfVVRyr21nqrWIw7SM71QicGBqxaKES+kmnpFGgnpE=;
        b=Y/apttgDkrSu/26nSqmSofI+Fmzqx2mqN+tQL6BvTiAld9bubaSWuJIosOTMcnk0Xx
         zrw65ruT1zrj182xQhaopGaZai2lap5fMBe3J1XtKfeUUt3CXlZ6+Qfa6ykvtdSaf+4v
         VanhcN79t2ZYC7Cs9U5oxyvVd0FR9q1Xov4rgvALHANoOfe9G6j8Bt6jl0YRx3+FYXH2
         ViBAoqoRVDrFE7pDVo5ch5yFr5X0nuthyfjv74BWcqKTKETJIOSXIhzbch5nDJBF8Q76
         kd4pz0K3wUDYnYXam8AbqX5NERyBKvovS9mnKl2/bfLAJXPnQa2TE1QmBbWMxLc+U8RH
         Xm5g==
X-Gm-Message-State: APt69E1ScsSe1k2MeZZLbRn3Hgr6KfL9rvNqTYuaNUzqhBWti2G9w4Ex
        KbbZz1qfKe4FrB48AwO43jkORxg2UbFxe+Zi2tQUryTcV2A=
X-Google-Smtp-Source: AAOMgpcy18m5lXq4bJbQhg1F0Hwf9PKYxeFYGLnazOHE+LEMiLWws85rXT5bj/YfyepzNfBlWPGygyExxOmClmlsNxQ=
X-Received: by 2002:a17:902:683:: with SMTP id 3-v6mr13057684plh.291.1530948880932;
 Sat, 07 Jul 2018 00:34:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Sat, 7 Jul 2018 00:34:40
 -0700 (PDT)
In-Reply-To: <1530815198.6642.1@smtp.crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-2-paul@crapouillou.net>
 <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com> <1530815198.6642.1@smtp.crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 7 Jul 2018 13:04:40 +0530
Message-ID: <CANc+2y5wkp2mHb+Z=Rh332uY+ixhUxbM3EM3HEs-fq5efa+msQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of channels
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
X-archive-position: 64704
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

On 5 July 2018 at 23:56, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi PrasannaKumar,
>
>
>> Hi Paul,
>>
>> On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
>>>
>>>  As part of the work to support various other Ingenic JZ47xx SoC
>>> versions,
>>>  which don't feature the same number of DMA channels per core, we now
>>>  deduce the number of DMA channels available from the devicetree
>>>  compatible string.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  ---
>>>   drivers/dma/dma-jz4780.c | 53 +++++++++++++++++++++++++++++-----------
>>>   1 file changed, 39 insertions(+), 14 deletions(-)
>>>
>>>  diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>>>  index 85820a2d69d4..b40f491f0367 100644
>>>  --- a/drivers/dma/dma-jz4780.c
>>>  +++ b/drivers/dma/dma-jz4780.c
>>>  @@ -16,6 +16,7 @@
>>>   #include <linux/interrupt.h>
>>>   #include <linux/module.h>
>>>   #include <linux/of.h>
>>>  +#include <linux/of_device.h>
>>>   #include <linux/of_dma.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/slab.h>
>>>  @@ -23,8 +24,6 @@
>>>   #include "dmaengine.h"
>>>   #include "virt-dma.h"
>>>
>>>  -#define JZ_DMA_NR_CHANNELS     32
>>>  -
>>>   /* Global registers. */
>>>   #define JZ_DMA_REG_DMAC                0x1000
>>>   #define JZ_DMA_REG_DIRQP       0x1004
>>>  @@ -135,14 +134,20 @@ struct jz4780_dma_chan {
>>>          unsigned int curr_hwdesc;
>>>   };
>>>
>>>  +enum jz_version {
>>>  +       ID_JZ4780,
>>>  +};
>>>  +
>>>   struct jz4780_dma_dev {
>>>          struct dma_device dma_device;
>>>          void __iomem *base;
>>>          struct clk *clk;
>>>          unsigned int irq;
>>>  +       unsigned int nb_channels;
>>>  +       enum jz_version version;
>>>
>>>          uint32_t chan_reserved;
>>>  -       struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
>>>  +       struct jz4780_dma_chan chan[];
>>
>>
>> Looks like a variable length array in struct. I think there is some
>> effort to remove the usage of VLA. Can you revisit this? I may be
>> wrong, please feel free to correct.
>
>
> Are you sure? It's the first time I hear about it.
> Could anybody confirm?

Please see [1] for info.

Variable Length Arrays in struct is expressly forbidden in C99, C11.
Clang does not support it. To make kernel compile with Clang few
people are trying to remove/reduce VLAIS usage.

1. https://blog.linuxplumbersconf.org/2013/ocw/system/presentations/1221/original/VLAIS.pdf
