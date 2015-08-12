Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 01:38:11 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33302 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013104AbbHLXiCgJ0-W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 01:38:02 +0200
Received: by igbpg9 with SMTP id pg9so122768952igb.0
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oKz68+y1udZVYIaxcCdMYLiWwEtrdlVfAzLUNxnLxoU=;
        b=x+F7KHYApsXkKwNlILHIj0u0Bw137dSzSgUI036w43P7BpPGrL4Vs9VwBY820YV4Vs
         P8qRBo3JDayepGGw39nVx+SKPmhWKX1bHMZL5qTkDh0AHuz239pd4Lrpmsa0U/YlX9cy
         d1SbSjoZGkZNEYGFD6BLIYoSTB8Nb+kPbcXCRVBIz3ZHXBjqIFsf9dKG5HLfHCBI9TRu
         Bm6GDb7aG+FQXnv3eh7G+pMkc8fsiNatAnXUQ/4pgnYdwQPGCoKxu4RxMZwyElFKacda
         WJGMqaBNd7vF34gG4SM8RYztYIFX/MDY2SQDDxCeV1f7DyVL9fhPtWRxe28c5dQBsbzw
         FkRQ==
X-Received: by 10.50.43.197 with SMTP id y5mr25156466igl.27.1439422676389;
 Wed, 12 Aug 2015 16:37:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.18.132 with HTTP; Wed, 12 Aug 2015 16:37:37 -0700 (PDT)
In-Reply-To: <55CB3F47.3000902@plexistor.com>
References: <1439363150-8661-1-git-send-email-hch@lst.de> <55CB3F47.3000902@plexistor.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 13 Aug 2015 09:37:37 +1000
Message-ID: <CAGRGNgUKkaPnyvn30DXyNpdiXQzS6J=1+mQ3ick8C8=bhx_RHA@mail.gmail.com>
Subject: Re: RFC: prepare for struct scatterlist entries without page backing
To:     Boaz Harrosh <boaz@plexistor.com>, Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, axboe@kernel.dk,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-nvdimm@ml01.01.org, David Howells <dhowells@redhat.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>,
        linux-xtensa@linux-xtensa.org, grundler@parisc-linux.org,
        realmz6@gmail.com, alex.williamson@redhat.com,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-parisc@vger.kernel.org, vgupta@synopsys.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi,

On Wed, Aug 12, 2015 at 10:42 PM, Boaz Harrosh <boaz@plexistor.com> wrote:
> On 08/12/2015 10:05 AM, Christoph Hellwig wrote:
>> It turns out most DMA mapping implementation can handle SGLs without
>> page structures with some fairly simple mechanical work.  Most of it
>> is just about consistently using sg_phys.  For implementations that
>> need to flush caches we need a new helper that skips these cache
>> flushes if a entry doesn't have a kernel virtual address.
>>
>> However the ccio (parisc) and sba_iommu (parisc & ia64) IOMMUs seem
>> to be operate mostly on virtual addresses.  It's a fairly odd concept
>> that I don't fully grasp, so I'll need some help with those if we want
>> to bring this forward.
>>
>> Additional this series skips ARM entirely for now.  The reason is
>> that most arm implementations of the .map_sg operation just iterate
>> over all entries and call ->map_page for it, which means we'd need
>> to convert those to a ->map_pfn similar to Dan's previous approach.
>>
>
[snip]
>
> It is a bit of work but is worth while, and accelerating tremendously
> lots of workloads. Not like this abomination which only branches
> things more and more, and making things fatter and slower.

As a random guy reading a big bunch of patches on code I know almost
nothing about, parts of this comment really resonated with me:
overall, we seem to be adding a lot of if statements to code that
appears to be in a hot path.

I.e. ~90% of this patch set seems to be just mechanically dropping
BUG_ON()s and converting open coded stuff to use accessor functions
(which should be macros or get inlined, right?) - and the remaining
bit is not flushing if we don't have a physical page somewhere.

Would it make sense to split this patch set into a few bits: one to
drop all the useless BUG_ON()s, one to convert all the open coded
stuff to accessor functions, then another to do the actual page-less
sg stuff?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
