Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 00:48:20 +0200 (CEST)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:48136
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992874AbdJSWsN17ZGy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 00:48:13 +0200
Received: by mail-io0-x236.google.com with SMTP id j17so11482034iod.5;
        Thu, 19 Oct 2017 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DzcyuZPmfMH5AUzonGVRrDPtlGvkMBCXtZPoywxT5ME=;
        b=ospudasJr4v/wImmW63BNJiXEIv2p6tcsiq40TgCpo3kDk/U9HG6/3mONQSMVBzd4i
         7lHPnRTJNfI+w+qs7FRQQ1N6QGKx2ihqGo/6Xvh/acuFBc4Ofnn/ZgrstJdWPLJfCcMn
         fmqDQZk9CYePFbQnEkWa9XcytQ+r0eKnR/serTAAxCyUjg/4xcQ3zUY0MuRU4+OUR8wv
         TDR9wEfnX1nv+KS/iT/2mtG5TlWtOmCoOOrZ0hRpHFgnKYzPPgLWoXTrd3rP5jAd0ftk
         WnVziT2nJk5VYKo+j1yJBOkUS545a6WJ2RnGTOYwOFytnRjt51sKNncFf/52qWqb4gLz
         CShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DzcyuZPmfMH5AUzonGVRrDPtlGvkMBCXtZPoywxT5ME=;
        b=TZ1XvpnwHaHVhX60UbGj5jtST33QXASKj9bHwruQxHyNL3udIORiGZT8QTY9RgKJFl
         SgRVBet1zNaOwNDkNlgiP+7EU3GLtcLcbymubqS8CAWd1I20QYfT70m5Hvo6rV/Wn8Qb
         j/UzJrdlGq/0YPUbC/jXF+6o+ziTCG1SdflABjhbsD0QKbqzzmxssaQbVoLEy5SmCVgN
         z8cX4ClE7Buf2koY4ViuJwixmwYS3ib86sGU530BXaUG5yCwAbLARfD5O+oqqdHelK1/
         QZU3NKvq8q9f/cx19azlahEhiYmam+PqrUPXK23gCGm3GS8r0Sl9xvNzdCjEtYhmz3g6
         b/OA==
X-Gm-Message-State: AMCzsaU3P/cjJZfH4u2pH+7fILNEOpJChOaDrI2wR3tLuyK03q9pwFAW
        EvBKoiObnHk2q34TJg8iyi1nZwgtrAVqiUTSQW0=
X-Google-Smtp-Source: ABhQp+SA1cxKR4elyEYiuBVaw2yVUaAOOMEppVC9UYuhPz5ekW+nq7d+4XI25ayJGqznRQ9/iBVm2q9oyvTaMwJZm3g=
X-Received: by 10.107.140.9 with SMTP id o9mr4016280iod.93.1508453287077; Thu,
 19 Oct 2017 15:48:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Thu, 19 Oct 2017 15:47:45 -0700 (PDT)
In-Reply-To: <20171019091644.GA14983@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 19 Oct 2017 18:47:45 -0400
Message-ID: <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        Florian Fainelli <f.fainelli@gmail.com>,
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
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60488
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

On Thu, Oct 19, 2017 at 5:16 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Oct 18, 2017 at 10:41:17AM -0400, Jim Quinlan wrote:
>> That's what brcm_to_{pci,cpu} are for -- they keep a list of the
>> dma-ranges given in the PCIe DT node, and translate from system memory
>> addresses to pci-space addresses, and vice versa.  As long as people
>> are using the DMA API it should work.  It works for all of the ARM,
>> ARM64, and MIPS Broadcom systems I've tested, using eight different EP
>> devices.  Note that I am not thrilled to be advocating this mechanism
>> but it seemed the best alternative.
>
> Say we are using your original example ranges:
>
>  memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>  memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>  memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>  memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>  memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>  memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>
> and now you get a dma mapping request for physical addresses
> 3fffff00 to 4000000f, which would span two of your ranges.  How
> is this going to work?

The only way to prevent this is to reserve a single page at the end of
the first memory region of any pair that are adjacent in physical
memory.  A hack, yes, but I don't see an easier way out of this.  Many
if not most of our boards do not have adjacent regions and would not
need this.

Overriding phys_to_dma/dma_to_phys comes with the same overlap problem
(MIPS solution and possible ARM/ARM64 solution).

>
>> I would prefer that the same code work for all three architectures.
>> What I would like from ARM/ARM64 is the ability to override
>> phys_to_dma() and dma_to_phys(); I thought the chances of that being
>> accepted would be slim.  But you are right, I should ask the
>> maintainers.
>
> It is still better than trying to stack dma ops, which is a receipe
> for problems down the road.

Let me send out V2 of my patchset and also send it to the ARM/ARM64
maintainers as you suggested; perhaps there is an alternative.
