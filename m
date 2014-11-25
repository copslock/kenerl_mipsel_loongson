Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 01:01:03 +0100 (CET)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:59345 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012832AbaKYABB55rLD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 01:01:01 +0100
Received: by mail-qc0-f169.google.com with SMTP id w7so7654907qcr.0
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 16:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SDHHKBaB9s7hiapCAP0REKsv+tXq4rhNZ+OFBSkuJqA=;
        b=xcHha1VaztaobrdC60FfsPJXqSiJuNhBn9M5SnjrGbArej6rvjDR/PopkpVYjl9lKd
         HMw+VLVgUnxAl0G+3yIg9KBSZgdHvtmnifgUIYRNJcOhvIUFd6g7vwyO2T1qk/4O9lDM
         NwNTSEPnNFG+PKOZmfMhAusg7dgkaDVa2arE5ScbCKYp6jDkxA231hu4sSU4pui8jUsY
         zpzK5BymKOqggq7n5sIEBqbAzxe3k8+SuMCF2FoDY1jVORYDK8rffTHQqL8E9UrkY/x4
         ZECrdzPrUfdGG4mICqmgLPFCw9kt2CtdcvbIwSaTXaP4aiOZEd2RzQvYEp49QoATe0+d
         qXgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SDHHKBaB9s7hiapCAP0REKsv+tXq4rhNZ+OFBSkuJqA=;
        b=NyQc47I7VKlZi4aoKlFiPrJrfb1EPY9MttY4Cq8/VRuAYIJMABCH41P7eoGnDUxKZL
         TIrzGn5z4cDSm/wrMAZry1BrfP95Xu43q/ZeDwBYPAb4qBA0aueql3wO9tURPxg9y5N6
         QFVcSGvvXJRmmChNwPd12PKnVnqNNN9GN8TOg=
MIME-Version: 1.0
X-Received: by 10.140.51.99 with SMTP id t90mr32482997qga.72.1416873655450;
 Mon, 24 Nov 2014 16:00:55 -0800 (PST)
Received: by 10.140.39.170 with HTTP; Mon, 24 Nov 2014 16:00:55 -0800 (PST)
In-Reply-To: <CAADnVQ+8d0GC5OwQTdJKkmG8=vshUVqK1pPou1GCGa_iuU2v-g@mail.gmail.com>
References: <CAADnVQ+8d0GC5OwQTdJKkmG8=vshUVqK1pPou1GCGa_iuU2v-g@mail.gmail.com>
Date:   Mon, 24 Nov 2014 16:00:55 -0800
X-Google-Sender-Auth: cuY7Gag83mM6hOzeo1qXLwUmmC0
Message-ID: <CA+55aFyktcMZnQHqoaCePgJVXmbi=9pTS_jz7j+j=QDuSoSFoA@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44421
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

On Mon, Nov 24, 2014 at 2:58 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I've changed gcc pr58145-1.c reproducer to use
> __read_once_size() approach above

I don't think you did.

> modified reproducer:
> struct S { unsigned int data; };
> void bar(int val)
> {
>   struct S _s = { .data = val };
>   *(volatile struct S *) 0x880000UL = ACCESS_ONCE(&_s);
> }

My approach never had "volatile struct S *". The only volatile
pointers were the actual byte/word/etc pointers, and those generated
temporary values that were then assigned to the final type through a
cast.

Also, note that the kernel is compiled without strict aliasing, so the
casting to 'void *' and various smaller types is "safe" - even if the
C standard doesn't like it.

With strict aliasing, you'd need to make the read_once() macro not
just pass in the size, there would have to be some kind of union of
the type, and that would effectively mean that you can't use an inline
function, you'd have to do it in a big macro (because the type would
be per-site).

So with strict aliasing, you'd have to make it something like

        #define ACCESS_ONCE(p) \
      ({ union { typeof(*p) __val; char __array[sizeof(*p)]} __u;
__read_once_size(p, __u.__array, sizeof(__u)); __u.__val; })

Pretty? No. But then, the standard C aliasing rules are so broken that
"pretty" doesn't really come into play..

                  Linus
