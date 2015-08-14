Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 05:30:57 +0200 (CEST)
Received: from mail-io0-f175.google.com ([209.85.223.175]:32868 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006209AbbHNDa4Kybdi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 05:30:56 +0200
Received: by iods203 with SMTP id s203so72904504iod.0
        for <linux-mips@linux-mips.org>; Thu, 13 Aug 2015 20:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bjXLH5/e3N/AsOZUEYEZobHeJmOkpGKb2isa0VQp1k8=;
        b=KeY49bDDQPWnDw82TrEBfw/p5mccAACHCoAJp7JGLdm5aHqsmEHLJdHQhjDXPe28tD
         LgAj/6MQVwc38L8KAlqJvxxedBrC0QWjT/Aqlaun8xPnZWfCfbcp0/aob+naoru+YyaW
         yZmsebi/RvW+miRpWxDEHekr9+3er50T7r0JMOfy4MmX13ipo4vY59Ar9tJ9ZN6RXKoe
         CN2UfoBPA/K5EBwvmHAiVBkHB5kLCr/a44CCQRLK7rWLvj+7jS74iD61PCaTZOJiGnrZ
         virePPAUPke2RTlr6JIGt13fDKY4DTeaVHubIyNLWySUgi2OSMsFlfIxvbq6wUmrpS6v
         gXaQ==
MIME-Version: 1.0
X-Received: by 10.107.25.4 with SMTP id 4mr35917600ioz.168.1439523050260; Thu,
 13 Aug 2015 20:30:50 -0700 (PDT)
Received: by 10.107.20.1 with HTTP; Thu, 13 Aug 2015 20:30:49 -0700 (PDT)
In-Reply-To: <20150813143150.GA17183@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
        <1439363150-8661-30-git-send-email-hch@lst.de>
        <CA+55aFxsH9Lde7wqZi555vqfH2uxeQqC9cjeca9L6Wr=XpyzXA@mail.gmail.com>
        <20150813143150.GA17183@lst.de>
Date:   Thu, 13 Aug 2015 20:30:49 -0700
X-Google-Sender-Auth: epu66dX39aESb2z3-1Y3WUDi2xs
Message-ID: <CAA9_cmcNA__N_yVTKsEqLAKBuoL-hx73t6opdsmb7w-0qKXaWg@mail.gmail.com>
Subject: Re: [PATCH 29/31] parisc: handle page-less SG entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
        David Howells <dhowells@redhat.com>,
        sparclinux@vger.kernel.org,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>,
        linux-xtensa@linux-xtensa.org, grundler@parisc-linux.org,
        Miao Steven <realmz6@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-metag@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <dan.j.williams@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48878
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

On Thu, Aug 13, 2015 at 7:31 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Aug 12, 2015 at 09:01:02AM -0700, Linus Torvalds wrote:
>> I'm assuming that anybody who wants to use the page-less
>> scatter-gather lists always does so on memory that isn't actually
>> virtually mapped at all, or only does so on sane architectures that
>> are cache coherent at a physical level, but I'd like that assumption
>> *documented* somewhere.
>
> It's temporarily mapped by kmap-like helpers.  That code isn't in
> this series. The most recent version of it is here:
>
> https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git/commit/?h=pfn&id=de8237c99fdb4352be2193f3a7610e902b9bb2f0
>
> note that it's not doing the cache flushing it would have to do yet, but
> it's also only enabled for x86 at the moment.

For virtually tagged caches I assume we would temporarily map with
kmap_atomic_pfn_t(), similar to how drm_clflush_pages() implements
powerpc support.  However with DAX we could end up with multiple
virtual aliases for a page-less pfn.
