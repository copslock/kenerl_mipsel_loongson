Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 18:01:10 +0200 (CEST)
Received: from mail-io0-f180.google.com ([209.85.223.180]:36719 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012348AbbHLQBIl7enh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 18:01:08 +0200
Received: by iodv127 with SMTP id v127so8689168iod.3
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uE+jlzjQ6ahipSG8Nj+bY6dbWKdWRTbXaVBH8/czOsk=;
        b=EWGoKlkvIHr3rbeEbqmfEVEfwBfTuwmKbXcie9HqS6GBRUIhTJj8H3YeacvEyke3xW
         EXqkqwUax179k+jv0ouv6A6kxbr3m15JimhcbvKlBMHO+8fxdEitdX8s/pouZ9fw55pK
         R0/6uxTeBM0akE9PI7dA8deKMKm3H5VEJJjjUcnzhV1s4/PXIBKyBBrwn+zbr1RtXDIs
         AVWJkPgxBzICco6QNR2YueQqUJnU771+DJEaT3xVrmv3npsfTFLiKF6OxWnnWDVNCvPP
         U97fUWnCyI0USs75jOv1/35gVcLfAs+NNSma76KYz00dHEtEBDMwQF4YDb8qm+9b/wtk
         6Utw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uE+jlzjQ6ahipSG8Nj+bY6dbWKdWRTbXaVBH8/czOsk=;
        b=Fk/NseaDldn9TyxCB7uoVACB5708PV8X3ygwx8tsPokEDvqev0eVnWQAiNGfBNhVwc
         MB2HrPJIObht4uqCHoVrxUft3IiicZkFTemzOZopeXeTXAoMC1lsFrovvK0UbxZT5JxT
         lSmu8lqZvviynCMBLmLmR5aT9e9PFcN8gQ5bA=
MIME-Version: 1.0
X-Received: by 10.107.8.216 with SMTP id h85mr25749970ioi.89.1439395262441;
 Wed, 12 Aug 2015 09:01:02 -0700 (PDT)
Received: by 10.36.219.130 with HTTP; Wed, 12 Aug 2015 09:01:02 -0700 (PDT)
In-Reply-To: <1439363150-8661-30-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
        <1439363150-8661-30-git-send-email-hch@lst.de>
Date:   Wed, 12 Aug 2015 09:01:02 -0700
X-Google-Sender-Auth: eZaVXoqdsc3fijjVhhGuuPDmGqg
Message-ID: <CA+55aFxsH9Lde7wqZi555vqfH2uxeQqC9cjeca9L6Wr=XpyzXA@mail.gmail.com>
Subject: Re: [PATCH 29/31] parisc: handle page-less SG entries
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Miao Steven <realmz6@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        grundler@parisc-linux.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-metag@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Wed, Aug 12, 2015 at 12:05 AM, Christoph Hellwig <hch@lst.de> wrote:
> Make all cache invalidation conditional on sg_has_page() and use
> sg_phys to get the physical address directly.

So this worries me a bit (I'm just reacting to one random patch in the series).

The reason?

I think this wants a big honking comment somewhere saying "non-sg_page
accesses are not necessarily cache coherent").

Now, I don't think that's _wrong_, but it's an important distinction:
if you look up pages in the page tables directly, there's a very
subtle difference between then saving just the pfn and saving the
"struct page" of the result.

On sane architectures, this whole cache flushing thing doesn't matter.
Which just means that it's going to be even more subtle on the odd
broken ones..

I'm assuming that anybody who wants to use the page-less
scatter-gather lists always does so on memory that isn't actually
virtually mapped at all, or only does so on sane architectures that
are cache coherent at a physical level, but I'd like that assumption
*documented* somewhere.

(And maybe it is, and I just didn't get to that patch yet)

                   Linus
