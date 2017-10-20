Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 16:42:10 +0200 (CEST)
Received: from mail-io0-x231.google.com ([IPv6:2607:f8b0:4001:c06::231]:44421
        "EHLO mail-io0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992982AbdJTOmDzkm4Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 16:42:03 +0200
Received: by mail-io0-x231.google.com with SMTP id m16so13477656iod.1;
        Fri, 20 Oct 2017 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XgpXyFDdDEVSTpH1rZAEP5aB3YPxYHrwNFNiSquo3es=;
        b=H7XSfEe5GIi060gWofVzTXfmBv2pL1akTFnVfIz2R9CdIIyWRK6TZ1/ywpblHreWWC
         OOaSwMpYz0+MW7yPeWUHWhTGYCn6r9MwrlgquoAJV4TDmGuqejqMwxCPPvgHQgcEnyip
         RUvHt2l/CgrvDMsKsrzX1mbwnAeCCyWuHsd54YcunOy8BfZE0eINGL2CCcwKjYbSEV/c
         nNlsFMuOcSjRHgB6+lvBFZ5DFY5NVCBeCIdKLT6yfz8ENOOskm2YVYmYV+UUtA436/Wm
         R9SW8rdiSwi4CgyQPmcPxAKWnwBudYSSaKQpF+ch7e3OYj3+uBhOQx6zFQsU14dZWI1u
         5uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XgpXyFDdDEVSTpH1rZAEP5aB3YPxYHrwNFNiSquo3es=;
        b=Nt6vBoAO8Jmi39mGPDmOAuzpGTW8Ov9wSLUEQEjeAw5qpTIGM+UWogf2G8sAy7dG7A
         P5XIX1uPcSyuRG6YxHRwhdQ4Ci8sYbmooEtPLTaVyR84YhpB+VCo6XM4XdNAYGoIbZeG
         vGps70f42gsp3kvFqH3WXgxOdkmKYafClVS0x8BzEVQyNGOqtzf7I8JDP0X+LD9mkYi+
         iEsuNwz4Ezpr5wbcZEVrBMQUQsJoIrc+NOD+bAC8R8LxKKsmUbi/shmikMV2wE56OwFM
         4p81rQOK3sQjPiW++I6ltRXvL9QvTyKK/wv6gJ4W/mCiPqI5fdCCAPpVXe5bcwciv991
         dJqA==
X-Gm-Message-State: AMCzsaXdS8G7mTFsTUT5hWgiFtPxnu7mNqcLm3P/czkWVLcYvD9dbH09
        RhMwLrOrop+GEMC/mzcUtpVuUsC56oFW7/jT2ss=
X-Google-Smtp-Source: ABhQp+SprlyIPeRSkUFMHdGJCv+Sm6ngH5R6OUGlt+ySzrrWAlw/Ay9kb18R15mCXm5HfvS3dUpcez+b42x917CCWl4=
X-Received: by 10.107.18.74 with SMTP id a71mr7142359ioj.58.1508510517673;
 Fri, 20 Oct 2017 07:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Fri, 20 Oct 2017 07:41:56 -0700 (PDT)
In-Reply-To: <20171020073730.GA12937@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 20 Oct 2017 10:41:56 -0400
Message-ID: <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
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
X-archive-position: 60506
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

On Fri, Oct 20, 2017 at 3:37 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Oct 19, 2017 at 06:47:45PM -0400, Jim Quinlan wrote:
>> The only way to prevent this is to reserve a single page at the end of
>> the first memory region of any pair that are adjacent in physical
>> memory.  A hack, yes, but I don't see an easier way out of this.  Many
>> if not most of our boards do not have adjacent regions and would not
>> need this.
>
> dma mappings can be much larger than a single page.  For the block
> world take a look at __blk_segment_map_sg which does the merging
> of contiguous pages into a single SG segment.  You'd have to override
> BIOVEC_PHYS_MERGEABLE to prevent this from happening in your supported
> architectures for the block layer.

I am not sure I understand your comment -- the size of the request
shouldn't be a factor.  Let's look at your example of the DMA request
of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
what is available, there is no 15 page span that can happen across the
0x40000000 boundary.  For SG, there can be no merge that connects a
page from one region to another region.  Can you give an example of
the scenario you are thinking of?
