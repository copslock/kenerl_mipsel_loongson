Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2017 20:08:26 +0200 (CEST)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:45845
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbdJXSITU-YwV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2017 20:08:19 +0200
Received: by mail-it0-x242.google.com with SMTP id n195so11103401itg.0;
        Tue, 24 Oct 2017 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VkpLKiszqDkXEN3YgdBA9HaJ6XI5MVQ117uXayd+5C0=;
        b=Cgncf10LMIOjT47u97/Hj8dauahQQCK7q2862CPnyla+wCamld7Jpg83Dd8H36nA+t
         N/mvVa0D+gIo1o9Allnxyad3MilL8+S7/NmCvRnLGz2vAsdEiMo8xkFg+rTGLRxp6MzB
         1YWaLOWaStAbbN4llOE2HAdvSpnYVzmn2qh7S0YaSxpYtSbcqhVj5boeii5o3K/JJebV
         jcf3VCNXXkagkEuefnpzK13Pxb7RVvN3g94i6sBIchjV1iejBHtwjnC6MnujLxub7/5U
         LUgG/xBKi31zdEysXDooP56184o86Rbgwp4pHd5yEq7u6h8lhOhFRfJF4vie4pF0nYYy
         e+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VkpLKiszqDkXEN3YgdBA9HaJ6XI5MVQ117uXayd+5C0=;
        b=bI0yKKAnUtL6T6qrNia4hLWYXMZ5EjqxLEjFjyqvPYnsc0S4sws2oPxJRNFrpsjZFz
         joSgdvtxDfkBCX1sdEiNLZXQ5fxOx3LrXk2CpqPk0SistJVB4fgxkQm64oMnO31CaEf0
         LiiicXiR92ntazMMdZarZhylQ5CF7f+VgeoGLsGg2v5RqK7fFEIiXJjHU/UN1taK169A
         l1QGY9gb6g2mDsj4beGAaWxJuxSQDKPWh8+5FRIReSFZsYHs9vAcvG+foQaCfAR8FYFb
         Yw+XGPIV3l1u8tbDZy4mJPTQm6RqgGJJpHmgdUttmK+Pt+0w9C+sIwvkNero+MsSg+4u
         g3oQ==
X-Gm-Message-State: AMCzsaXyt/3FNSY6u7CCV/20p6A2s7a/BrZuGWBVB2U7ptaDxQeJ8Crm
        xnF7TKhvpGpM8i/64fvANEAQ1j11gYEO7Dhk3KA=
X-Google-Smtp-Source: ABhQp+TwTDsq8/q9NDZy+K5py0TwsrdO4SDLgysnU7oPp2CsmAi7RKVQnae4lOZOTNbyxmxQPyI2zY4HeeqY8A4u8hw=
X-Received: by 10.36.17.130 with SMTP id 124mr14490344itf.81.1508868492750;
 Tue, 24 Oct 2017 11:08:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Tue, 24 Oct 2017 11:08:12 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com> <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de> <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de> <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 24 Oct 2017 14:08:12 -0400
Message-ID: <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60532
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

On Mon, Oct 23, 2017 at 5:06 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Jim Quinlan
>> Sent: 20 October 2017 16:28
>> On Fri, Oct 20, 2017 at 10:57 AM, Christoph Hellwig <hch@lst.de> wrote:
>> > On Fri, Oct 20, 2017 at 10:41:56AM -0400, Jim Quinlan wrote:
>> >> I am not sure I understand your comment -- the size of the request
>> >> shouldn't be a factor.  Let's look at your example of the DMA request
>> >> of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
>> >> pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
>> >> what is available, there is no 15 page span that can happen across the
>> >> 0x40000000 boundary.  For SG, there can be no merge that connects a
>> >> page from one region to another region.  Can you give an example of
>> >> the scenario you are thinking of?
>> >
>> > What prevents a merge from say the regions of
>> > 0....3fffffff and 40000000....7fffffff?
>>
>> Huh? [0x3ffff000...x3ffffff] is not available to be used. Drawing from
>> the original example, we now have to tell Linux that these are now our
>> effective memory regions:
>>
>>       memc0-a@[        0....3fffefff] <=> pci@[        0....3fffefff]
>>       memc0-b@[100000000...13fffefff] <=> pci@[ 40000000....7fffefff]
>>       memc1-a@[ 40000000....7fffefff] <=> pci@[ 80000000....bfffefff]
>>       memc1-b@[300000000...33fffefff] <=> pci@[ c0000000....ffffefff]
>>       memc2-a@[ 80000000....bfffefff] <=> pci@[100000000...13fffefff]
>>       memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>>
>> This leaves a one-page gap between phsyical memory regions which would
>> normally be contiguous. One cannot have a dma alloc that spans any two
>> regions.  This is a drastic step, but I don't see an alternative.
>> Perhaps  I may be missing what you are saying...
>
> Isn't this all unnecessary?
> Both kmalloc() and dma_alloc() are constrained to allocate memory
> that doesn't cross an address boundary that is larger than the size.
> So if you allocate 16k it won't cross a 16k physical address boundary.
>
>         David
>
Hi David,  Christoph was also concerned about this:

"For the block world take a look at __blk_segment_map_sg which does the merging
of contiguous pages into a single SG segment.  You'd have to override
BIOVEC_PHYS_MERGEABLE to prevent this from happening in your supported
architectures for the block layer."

Do you consider this a non-issue as well or can this happen and span
memory regions?
