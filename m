Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 18:17:52 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37530 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011859AbbHNQRu4QoDr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 18:17:50 +0200
Received: by wibhh20 with SMTP id hh20so26181935wib.0
        for <linux-mips@linux-mips.org>; Fri, 14 Aug 2015 09:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=o6NDt3QsPNeeIa6eBBGWwEhoGPRTlpza83UIE1Lk27s=;
        b=deFn19nYEjxKlOD0Rpu5vHKUCcr1XQ2v3aQCka+0eL/uftkORK6FneQB8w1sIXqF1E
         HBxk45vsUgieqZTudseUAiES55kr22j3B+HwXSsfMwlAAU779V732FFR1TNsEfD24GfX
         PkCHwDsCIBUWFOSAY1mI4BWE7v3C6ThAagrltsuO4og/JTeucjizJjipcbgaL1AjR0v5
         YPmeMU69GZBhuFaZQww5vvCoR/4D+7SkiMjlZLGVFnagATbm8c8MUnMSoFFjcjt+Lj8C
         Dr8L3/ML70Klx4kqPhoz/vzBYxp1H9+ia3ZSawQpO/UlmxDSnAzhlG72/NDLAO/ftE6s
         2qNw==
X-Gm-Message-State: ALoCoQnDXLDdxWvHYcZhea94pJ2OK4cN5ciRhp6Y/2UntmYZ/FP2ViTnHCIbQTi1n2uOf5ShEX3j
MIME-Version: 1.0
X-Received: by 10.180.86.137 with SMTP id p9mr8506119wiz.38.1439569065569;
 Fri, 14 Aug 2015 09:17:45 -0700 (PDT)
Received: by 10.27.127.196 with HTTP; Fri, 14 Aug 2015 09:17:45 -0700 (PDT)
In-Reply-To: <20150813.211155.1774898831276303437.davem@davemloft.net>
References: <20150813143150.GA17183@lst.de>
        <CAA9_cmcNA__N_yVTKsEqLAKBuoL-hx73t6opdsmb7w-0qKXaWg@mail.gmail.com>
        <1439524760.8421.23.camel@HansenPartnership.com>
        <20150813.211155.1774898831276303437.davem@davemloft.net>
Date:   Fri, 14 Aug 2015 09:17:45 -0700
Message-ID: <CAPcyv4idztwrtr5wBQkiTSNT8L3HWf8zk9webheQAmunLD7cBw@mail.gmail.com>
Subject: Re: [PATCH 29/31] parisc: handle page-less SG entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     David Miller <davem@davemloft.net>
Cc:     Jej B <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, dhowells@redhat.com,
        sparclinux@vger.kernel.org, egtvedt@samfundet.no,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        X86 ML <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        hskinnemoen@gmail.com, linux-xtensa@linux-xtensa.org,
        grundler@parisc-linux.org, realmz6@gmail.com,
        alex.williamson@redhat.com, linux-metag@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Michal Simek <monstr@monstr.eu>,
        linux-parisc@vger.kernel.org, vgupta@synopsys.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-media@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <dan.j.williams@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
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

On Thu, Aug 13, 2015 at 9:11 PM, David Miller <davem@davemloft.net> wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>> At least on some PA architectures, you have to be very careful.
>> Improperly managed, multiple aliases will cause the system to crash
>> (actually a machine check in the cache chequerboard). For the most
>> temperamental systems, we need the cache line flushed and the alias
>> mapping ejected from the TLB cache before we access the same page at an
>> inequivalent alias.
>
> Also, I want to mention that on sparc64 we manage the cache aliasing
> state in the page struct.
>
> Until a page is mapped into userspace, we just record the most recent
> cpu to store into that page with kernel side mappings.  Once the page
> ends up being mapped or the cpu doing kernel side stores changes, we
> actually perform the cache flush.
>
> Generally speaking, I think that all actual physical memory the kernel
> operates on should have a struct page backing it.  So this whole
> discussion of operating on physical memory in scatter lists without
> backing page structs feels really foreign to me.

So the only way for page-less pfns to enter the system is through the
->direct_access() method provided by a pmem device's struct
block_device_operations.  Architectures that require struct page for
cache management to must disable ->direct_access() in this case.

If an arch still wants to support pmem+DAX then it needs something
like this patchset (feedback welcome) to map pmem pfns:

https://lkml.org/lkml/2015/8/12/970

Effectively this would disable ->direct_access() on /dev/pmem0, but
permit ->direct_access() on /dev/pmem0m.
