Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2018 09:28:10 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:33878
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992571AbeGGH2DUWFgM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Jul 2018 09:28:03 +0200
Received: by mail-pf0-x243.google.com with SMTP id e10-v6so10135311pfn.1;
        Sat, 07 Jul 2018 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yUa2bUGn8FCR61aQFejfeap9aUU1xxuiYxbyut0ysv4=;
        b=buo2Ixu11W3g46CV6Kluz4hQGIeCwxowCW1IgmylIX8mLo+491zSJecQdzc5L8nztO
         1pS1tqjsJh8GkkwnEX2yEtw+Zq7cKYFHw10Lbu6EG2s0Ao7PD2q+R0RW1D97hR+6bSM/
         /k73YXkn7qUX90tHs5lAgER8qzcezQg5/dFqlaED2qF1tTTR3itQW2/239TzmfCbJyx8
         fVbtN0FO070cdW6Jf2H9nMF3lNj53MERdem1i4LALCS4TMC1laYXYeiaT4avy5S56bFC
         9ARx8jT4Z12+w1n3THsDaWSF1p2G3vXL9QIIwQshA+ZHsjbOqLhO5FVcFGAwrHC77wvx
         olnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yUa2bUGn8FCR61aQFejfeap9aUU1xxuiYxbyut0ysv4=;
        b=FmyB938RLun3rhnoiA4l2zHB3DN/tRe8W2Hr7xhKGCeQDXcmvQPciKiwUbLIV5GHHN
         hWycoLaFrukkRVKo1oZ+8vLSZESJ4Bh20blaZme+Ij+YFZbBVEwSfaQgHbxDBMsWr+DC
         LTfvoLWD/B5PQgcqWkP8IbcTQZFWL94tNt5lDCM9KpQY1cvIiB/d7P2jp0Sz3Cq9c6oM
         z0sYI7sZ4L3EO+cujYn56NlDZGwWfSRE78B1TyRdLvasBzxy5fwbQscM9nFAV0UDv79W
         N9hYaVPz5SK9IBK12XR9B2WPc25vyBFp/kEj/j+uJ+CWbixXbbt4WCaPLEfcveUOMlxD
         N8Rw==
X-Gm-Message-State: APt69E0gXwWPmR+RoOByWmlS2+PvjRkFYk1qJjrd17V3JzzLCvJH6RwP
        VqI0BUmornj4pkJQD934U8picFJBRFK+plHJmSQ=
X-Google-Smtp-Source: AAOMgpc5gS3Vhn++f7BHplnykMVrWto7Hc9QSUZkk95P0K8Uuh0jCvwZElGRf+bknZuB7D6GlfnZC2/E7sA6JvTR2g4=
X-Received: by 2002:a65:6699:: with SMTP id b25-v6mr7297578pgw.426.1530948476764;
 Sat, 07 Jul 2018 00:27:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Sat, 7 Jul 2018 00:27:56
 -0700 (PDT)
In-Reply-To: <1530827112.6642.2@smtp.crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-3-paul@crapouillou.net>
 <CANc+2y4dVDQoPP4zJkous=p-HYL+nu1Cxcrv0nqEMABN_4uyZw@mail.gmail.com> <1530827112.6642.2@smtp.crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 7 Jul 2018 12:57:56 +0530
Message-ID: <CANc+2y70=hp7_p3ojyWMddm42VKFHDqUbKGMz97+xakADp9PNQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
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
X-archive-position: 64703
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

On 6 July 2018 at 03:15, Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>> Paul,
>>
>> On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
>>>
>>>  The register area of the JZ4780 DMA core can be split into different
>>>  sections for different purposes:
>>>
>>>  * one set of registers is used to perform actions at the DMA core level,
>>>  that will generally affect all channels;
>>>
>>>  * one set of registers per DMA channel, to perform actions at the DMA
>>>  channel level, that will only affect the channel in question.
>>>
>>>  The problem rises when trying to support new versions of the JZ47xx
>>>  Ingenic SoC. For instance, the JZ4770 has two DMA cores, each one
>>>  with six DMA channels, and the register sets are interleaved:
>>>  <DMA0 chan regs> <DMA1 chan regs> <DMA0 ctrl regs> <DMA1 ctrl regs>
>>>
>>>  By using one memory resource for the channel-specific registers and
>>>  one memory resource for the core-specific registers, we can support
>>>  the JZ4770, by initializing the driver once per DMA core with different
>>>  addresses.
>>
>>
>> As per my understanding device tree should be modified only when
>> hardware changes. This looks the other way around. It must be possible
>> to achieve what you are trying to do in this patch without changing
>> the device tree.
>
>
> I would agree that devicetree has an ABI that we shouldn't break if
> possible.
>
> However DTS support for all the Ingenic SoCs/boards is far from being
> complete, and more importantly, all Ingenic-based boards compile the DTS
> file within the kernel; so breaking the ABI is not (yet) a problem, and
> we should push the big changes right now while it's still possible.

Completely agree with you in this. Let's wait and see what DT maintainer's view.
