Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2018 13:01:39 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:52480 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992571AbeGGLBdANBzE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Jul 2018 13:01:33 +0200
Date:   Sat, 07 Jul 2018 13:01:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of
 channels
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
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
Message-Id: <1530961282.2380.0@smtp.crapouillou.net>
In-Reply-To: <CANc+2y5wkp2mHb+Z=Rh332uY+ixhUxbM3EM3HEs-fq5efa+msQ@mail.gmail.com>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-2-paul@crapouillou.net>
        <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com>
        <1530815198.6642.1@smtp.crapouillou.net>
        <CANc+2y5wkp2mHb+Z=Rh332uY+ixhUxbM3EM3HEs-fq5efa+msQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530961291; bh=N3RHUSyzIjZ/NHghqvU6TdGi4lvE/DneJbb8eajc2mY=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=YZKwFKSJb/oneZxgnNtLYModd/JmPjjTcoNn3+EkY+VE5kt3/8ifzfaUQVn3xLn1TlKZxv09Cj/jpq+LDWfEMdCdMKJ+0VDHnSHfO6G8Mh6+mBK3uMRMoMcMI+WEU3Ahkc+Rf9z+u1rG8F2o12whc9KQeesJdUCMPxJiSAb0u+Y=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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



Le sam. 7 juil. 2018 à 9:34, PrasannaKumar Muralidharan 
<prasannatsmkumar@gmail.com> a écrit :
> On 5 July 2018 at 23:56, Paul Cercueil <paul@crapouillou.net> wrote:
>>  Hi PrasannaKumar,
>> 
>> 
>>>  Hi Paul,
>>> 
>>>  On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> 
>>> wrote:
>>>> 
>>>>   As part of the work to support various other Ingenic JZ47xx SoC
>>>>  versions,
>>>>   which don't feature the same number of DMA channels per core, we 
>>>> now
>>>>   deduce the number of DMA channels available from the devicetree
>>>>   compatible string.
>>>> 
>>>>   Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>   ---
>>>>    drivers/dma/dma-jz4780.c | 53 
>>>> +++++++++++++++++++++++++++++-----------
>>>>    1 file changed, 39 insertions(+), 14 deletions(-)
>>>> 
>>>>   diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>>>>   index 85820a2d69d4..b40f491f0367 100644
>>>>   --- a/drivers/dma/dma-jz4780.c
>>>>   +++ b/drivers/dma/dma-jz4780.c
>>>>   @@ -16,6 +16,7 @@
>>>>    #include <linux/interrupt.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/of.h>
>>>>   +#include <linux/of_device.h>
>>>>    #include <linux/of_dma.h>
>>>>    #include <linux/platform_device.h>
>>>>    #include <linux/slab.h>
>>>>   @@ -23,8 +24,6 @@
>>>>    #include "dmaengine.h"
>>>>    #include "virt-dma.h"
>>>> 
>>>>   -#define JZ_DMA_NR_CHANNELS     32
>>>>   -
>>>>    /* Global registers. */
>>>>    #define JZ_DMA_REG_DMAC                0x1000
>>>>    #define JZ_DMA_REG_DIRQP       0x1004
>>>>   @@ -135,14 +134,20 @@ struct jz4780_dma_chan {
>>>>           unsigned int curr_hwdesc;
>>>>    };
>>>> 
>>>>   +enum jz_version {
>>>>   +       ID_JZ4780,
>>>>   +};
>>>>   +
>>>>    struct jz4780_dma_dev {
>>>>           struct dma_device dma_device;
>>>>           void __iomem *base;
>>>>           struct clk *clk;
>>>>           unsigned int irq;
>>>>   +       unsigned int nb_channels;
>>>>   +       enum jz_version version;
>>>> 
>>>>           uint32_t chan_reserved;
>>>>   -       struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
>>>>   +       struct jz4780_dma_chan chan[];
>>> 
>>> 
>>>  Looks like a variable length array in struct. I think there is some
>>>  effort to remove the usage of VLA. Can you revisit this? I may be
>>>  wrong, please feel free to correct.
>> 
>> 
>>  Are you sure? It's the first time I hear about it.
>>  Could anybody confirm?
> 
> Please see [1] for info.
> 
> Variable Length Arrays in struct is expressly forbidden in C99, C11.
> Clang does not support it. To make kernel compile with Clang few
> people are trying to remove/reduce VLAIS usage.
> 
> 1. 
> https://blog.linuxplumbersconf.org/2013/ocw/system/presentations/1221/original/VLAIS.pdf

I read it, and my structure is not a VLAIS; my "chan" array is a 
flexible
array, its sizeof() is 0, so the sizeof() of the structure is constant.

See page 6 of the PDF, about alternatives to VLAIS:
"If possible use a flexible array member and move the array to the end 
of
the struct"
Which is what I am doing here.

-Paul
