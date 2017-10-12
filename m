Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 20:15:51 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:43986
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992274AbdJLSPiRnzT5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 20:15:38 +0200
Received: by mail-io0-x242.google.com with SMTP id 134so2200930ioo.0;
        Thu, 12 Oct 2017 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8h7W6YKnSGVdv68HN8xT/AW7TAlMhR86tynFNyiMIpM=;
        b=DM4Nbvtn7vJm8ywgg8wga9IHtFhoH7pupQtPGZKJ6BIyfUbOzRiLbh5ebbQx/9aVD/
         nSVLWOdjYKiigNGMqCXn2+nj5YROeqCxXSczyD8ENCqDbAHdRpVsaTvgTvFijqOmZRhk
         zhkZkx+4riIm618iJUW1gMwD6/V7kfKNM4e48on1jJRiehvBZRhRGEoh+kNsctzcG9f3
         9b4rHoMuphJg5lacXjBzQkDqcgcxPM0Nz+YcBMTNUJ8JrAQeNE6nxrbSMdW2ptQTI/ZS
         pamdle9kxByU4atSgQXeH/EPGn0N04NIKgcIAMtM2WPhOWJ5IZqmSnDwtcV21SqSyM/i
         9JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8h7W6YKnSGVdv68HN8xT/AW7TAlMhR86tynFNyiMIpM=;
        b=t+mFjsLo/PxHBaepER7np+Um9cF4w7KoRfgMpqzV+CxLMmoJMYt1/gioCOl2wYR8VU
         6cpqsfvYjNsdG11XdE+JosT//HmI0SSFMdesFwfS9yVZFI+u7VUKJuL+TmEm/6AocFlZ
         e39ULt337LIixysBwtG8mxGi4BQ251gvA4fz91aRjs9Z83gYOZiQZTGVsgItJs4dD8Ma
         1So0pc/CKMI/6v/wz9mTHo+FqmYRjIkN9QPMKbATEs5Po478Epd9h+VZNnSrsWlxrYBV
         c4nRTSJEz5xDRWUads/ccdw+lC5LleL9i1sVQVywWzCbCiKnrZ7KNLptZKPBl0Ik3PQB
         sEPw==
X-Gm-Message-State: AMCzsaUZtCBNOdiHmOgEvXiPDPknuMDN31j8m+1lhIlX85KIezemRbzP
        KQUL1sy7KVNoQj6jfc3JFwZ/xIx6We5ihK8rgME=
X-Google-Smtp-Source: ABhQp+SdgZmY2UOCSdeM/ae3rrh4RSVlMn4pvJ3i6Nhu00wz9Wh1Of2Z3Lj5fdeits3YirnTdqDdl3z7SHMu8MAsgQ8=
X-Received: by 10.107.83.22 with SMTP id h22mr107416iob.40.1507832131906; Thu,
 12 Oct 2017 11:15:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Thu, 12 Oct 2017 11:15:30 -0700 (PDT)
In-Reply-To: <a8fa87e4-4d70-eb60-f1c5-94071d6394aa@arm.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-5-git-send-email-jim2101024@gmail.com> <a8fa87e4-4d70-eb60-f1c5-94071d6394aa@arm.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 12 Oct 2017 14:15:30 -0400
Message-ID: <CANCKTBuerHizxzY7BL-jP7L=z4g0=+2tfeafJnEJVkZ1zV+z-w@mail.gmail.com>
Subject: Re: [PATCH 4/9] arm64: dma-mapping: export symbol arch_setup_dma_ops
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Thu, Oct 12, 2017 at 1:06 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 11/10/17 23:34, Jim Quinlan wrote:
>> The BrcmSTB driver needs to get ahold of a pointer to swiotlb_dma_ops.
>> However, that variable is defined as static.  Instead, we use
>> arch_setup_dma_ops() to get the pointer to swiotlb_dma_ops.  Since
>> we also want our driver to be a separate module, we need to
>> export this function.
>
> NAK. Retrieve the platform-assigned ops from the device via
> get_dma_ops() and stash them in your drvdata or wherever before you
> replace them. Don't go poking around arch code internals directly from a
> driver.
Will fix (and drop the commit).

>
> Robin.
>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>  arch/arm64/mm/dma-mapping.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 614af88..dae572f 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -936,3 +936,4 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>       }
>>  #endif
>>  }
>> +EXPORT_SYMBOL(arch_setup_dma_ops);
>>
>
