Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 18:05:24 +0200 (CEST)
Received: from mail-io0-f180.google.com ([209.85.223.180]:34052 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012263AbbHLQFW3Swzh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 18:05:22 +0200
Received: by iodb91 with SMTP id b91so24520165iod.1
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MJzZL+CgMUY3GKm3z8wa7otA0jR+vzieLcQ/5SMgzCw=;
        b=kkRRSsFoxIgSo1Bdk5Nf7Qd9PT5CZnku1e2US7Qyl67N8W8T6l8sw2TGRk3JQq+orD
         unGyut8KkW8nSP/+sHKJZ9pr8yEi5u1NWYdyChPLptQq1wr3t0S86QVr9le8ffBISLCj
         pVsu4LHPq/9xSWTbOuf3stzG85HzlrGlfJMc07Uz61mFENyv85ps9FWjUawvjR1RuymI
         Kkpdb2pxKS7bs1PqDf+KKlSdl38uKGfF7XkZTyk2Gb/peUH31XlUifWHo1dZI7nGwFwB
         1M/BxvpCJvILSJCkPizNDUyMkQF3jCwhQDzxUpo2zH4m/hEWM6CifvSsYJXMKziMe58s
         pQUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MJzZL+CgMUY3GKm3z8wa7otA0jR+vzieLcQ/5SMgzCw=;
        b=CIH6VHeEYKQEZR6ycpamm1sYQdzNAvDu4IfBfFaAHPyoUdawGq8YuoAYg8JKjFvKi/
         ISCpUT3kA22ttz7Ts6qZ2qoIVNxIe0i/+vGjSY+2RlSisZMfHUa693/kWh2uMM87TLht
         JvVLGTH3430jAnnGE9wUoFngZHFAD96MXL0Ww=
MIME-Version: 1.0
X-Received: by 10.107.8.216 with SMTP id h85mr25771845ioi.89.1439395516038;
 Wed, 12 Aug 2015 09:05:16 -0700 (PDT)
Received: by 10.36.219.130 with HTTP; Wed, 12 Aug 2015 09:05:15 -0700 (PDT)
In-Reply-To: <1439363150-8661-32-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
        <1439363150-8661-32-git-send-email-hch@lst.de>
Date:   Wed, 12 Aug 2015 09:05:15 -0700
X-Google-Sender-Auth: 1lgZvIhI2y3w_A-MYzUfqFXbHCI
Message-ID: <CA+55aFxfZM81HNfo2ysfhGwrhx6GX-+F--+jLFmMVv+Z0id2rw@mail.gmail.com>
Subject: Re: [PATCH 31/31] dma-mapping-common: skip kmemleak checks for
 page-less SG entries
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
X-archive-position: 48822
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
> +       for_each_sg(sg, s, nents, i) {
> +               if (sg_has_page(s))
> +                       kmemcheck_mark_initialized(sg_virt(s), s->length);
> +       }

[ Again, I'm responding to one random patch - this pattern was in
other patches too.  ]

A question: do we actually expect to mix page-less and pageful SG
entries in the same SG list?

How does that happen?

(I'm not saying it can't, I'm just wondering where people expect this
to happen).

IOW, maybe it would be valid to have a rule saying "a SG list is
either all pageful or pageless, never mixed", and then have the "if"
statement outside the loop rather than inside.

                      Linus
