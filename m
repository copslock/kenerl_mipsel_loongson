Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 07:24:16 +0100 (CET)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:49019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990754AbeACGYKHeIcC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jan 2018 07:24:10 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3zBLVW0w5Jz9t2f;
        Wed,  3 Jan 2018 17:24:03 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list\:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        patches@groups.riscv.org,
        "open list\:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Cris <linux-cris-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
In-Reply-To: <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de> <878tdgtwzp.fsf@concordia.ellerman.id.au> <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
Date:   Wed, 03 Jan 2018 17:24:02 +1100
Message-ID: <87h8s3cvel.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> We want to use the dma_direct_ namespace for a generic implementation,
>>> so rename powerpc to the second best choice: dma_nommu_.
>>
>> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
>> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
>> than mapping dynamically.
>>
>> Though I don't have a good idea for a better name, maybe "1to1",
>> "linear", "premapped" ?
>
> "identity"?

I think that would be wrong, but thanks for trying to help :)

The address on the device side is sometimes (often?) offset from the CPU
address. So eg. the device can DMA to RAM address 0x0 using address
0x800000000000000.

Identity would imply 0 == 0 etc.

I think "bijective" is the correct term, but that's probably a bit
esoteric.

cheers
