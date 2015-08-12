Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 14:42:58 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37558 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012348AbbHLMm45p3kZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 14:42:56 +0200
Received: by wibhh20 with SMTP id hh20so26945858wib.0
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 05:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3t1xKSTRoEwhUlfn5TnXO5ayka59UgmQwzSIO9gz3vs=;
        b=j8Lzz5sgbo9pGkZubDb7eaFLoo4KeV+rd38r/almyD4TRsBm//dK0DP8M+nBZzqc0H
         p9uxe4TBP+5EUs3XrrkgthmGv2d3Sgl9m7hUV7di9jp3LIPMPL/w7rq7g+X7iPD7Try/
         jufUScAAUAg43J7izHPcGntYiOdeoRRwhfp7zcI1T7gCedfzOv8cjvV79BQPwRJW7MlM
         WlyL/pFCw/aVOhK6VxzW36resvHxLKmO00seU6+vCtLdpFee5vJFUxv610hQbw9z2Iey
         ebq4PYJ82ICUTbTjka3cOaxTJQMxiE2bmd0aJ1yVVXaqQVbQotEPwGvb9TOuz51MM5Nu
         Mj1A==
X-Gm-Message-State: ALoCoQkXmpmOsdJOZ91ZZESWtqON/mL5dBUy8zpaTLWL3Vb+sdBVIQ0wmwlIjDBbla7dRDefD4rU
X-Received: by 10.194.238.193 with SMTP id vm1mr66723109wjc.57.1439383371204;
        Wed, 12 Aug 2015 05:42:51 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.googlemail.com with ESMTPSA id hn2sm7777363wjc.45.2015.08.12.05.42.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Aug 2015 05:42:50 -0700 (PDT)
Message-ID: <55CB3F47.3000902@plexistor.com>
Date:   Wed, 12 Aug 2015 15:42:47 +0300
From:   Boaz Harrosh <boaz@plexistor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        axboe@kernel.dk
CC:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-nvdimm@ml01.01.org, dhowells@redhat.com,
        sparclinux@vger.kernel.org, egtvedt@samfundet.no,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, dwmw2@infradead.org, hskinnemoen@gmail.com,
        linux-xtensa@linux-xtensa.org, grundler@parisc-linux.org,
        realmz6@gmail.com, alex.williamson@redhat.com,
        linux-metag@vger.kernel.org, monstr@monstr.eu,
        linux-parisc@vger.kernel.org, vgupta@synopsys.com,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: RFC: prepare for struct scatterlist entries without page backing
References: <1439363150-8661-1-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <boaz@plexistor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boaz@plexistor.com
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

On 08/12/2015 10:05 AM, Christoph Hellwig wrote:
> Dan Williams started to look into addressing I/O to and from
> Persistent Memory in his series from June:
> 
> 	http://thread.gmane.org/gmane.linux.kernel.cross-arch/27944
> 
> I've started looking into DMA mapping of these SGLs specifically instead
> of the map_pfn method in there.  In addition to supporting NVDIMM backed
> I/O I also suspect this would be highly useful for media drivers that
> go through nasty hoops to be able to DMA from/to their ioremapped regions,
> with vb2_dc_get_userptr in drivers/media/v4l2-core/videobuf2-dma-contig.c
> being a prime example for the unsafe hacks currently used.
> 

The support I have suggested and submitted for zone-less sections.
(In my add_persistent_memory() patchset)

Would work perfectly well and transparent for all such multimedia cases.
(All hacks removed). In fact I have loaded pmem (with-pages) on a VRAM
a few times and it is great easy fun. (I wanted to experiment with cached
memory over a pcie)

> It turns out most DMA mapping implementation can handle SGLs without
> page structures with some fairly simple mechanical work.  Most of it
> is just about consistently using sg_phys.  For implementations that
> need to flush caches we need a new helper that skips these cache
> flushes if a entry doesn't have a kernel virtual address.
> 
> However the ccio (parisc) and sba_iommu (parisc & ia64) IOMMUs seem
> to be operate mostly on virtual addresses.  It's a fairly odd concept
> that I don't fully grasp, so I'll need some help with those if we want
> to bring this forward.
> 
> Additional this series skips ARM entirely for now.  The reason is
> that most arm implementations of the .map_sg operation just iterate
> over all entries and call ->map_page for it, which means we'd need
> to convert those to a ->map_pfn similar to Dan's previous approach.
> 

All this endless work for nothing more than uglyfing the Kernel, and
It will never end. When a real and fully working solution is right
here for more then a year.

If you are really up for a deep audit and a mammoth testing effort,
why not do a more worthy, and order of magnitude smaller work and support
2M and 1G variable sized "pages". All the virtual-vs-phisical-vs-caching
just works.

Most of the core work is there. Block layer and lots of other subsytems
already support sending a single page-pointer with bvec_offset bvec_len
bigger then 4K. Other system will be small fixes sprinkled around but
not at all this endless stream of subsystem after another of patches.
And for why.

The novelty of pages is the section object, the section is reached
from page* from virtual as well as physical planes. And is a center
that translate from all plains to all plains. You keep this concept
only make 2M-page sections and 1G-page sections.

It is a bit of work but is worth while, and accelerating tremendously
lots of workloads. Not like this abomination which only branches
things more and more, and making things fatter and slower.

It all feels like a typhoon, the inertia of tones and tons of
men hours work, in a huge wave. How will you ever stop such a
rushing mass. I'm trying to dock under but, surly it makes me sad.

Thanks
Boaz
