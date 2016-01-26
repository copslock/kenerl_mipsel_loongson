Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:33:49 +0100 (CET)
Received: from mail-io0-f173.google.com ([209.85.223.173]:36430 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011640AbcAZWdsDBXql (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 23:33:48 +0100
Received: by mail-io0-f173.google.com with SMTP id g73so206673404ioe.3;
        Tue, 26 Jan 2016 14:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m7KSuAye9nwa9cL04J9X/RvSDGYQSepy1vvDUuO3JR8=;
        b=foQuEKa4HNar4wFUDDSJmJQrRn4w8Fyqc37bpLEzC5ADHhfIod3MlvCX4Tks26MpPJ
         oLviVUGcznr+C4178SSGES2ZIEz1w355Cv5Khl6e1Of+Hz924rdtXpDYjzaYX5Wy2gGy
         GcUJcjKKau9yAZd7RIDaAPkjIG9+tlIK+Mn/YGFYliibkvrwsdOescLZkRzxfc5zXztf
         PJsYRCfIQZ8YzuEOuuFTiHED4LaCSwr+cuKmQNS+Uo2cwguw5zEyL+HvYQfpu5VDnwja
         buBpV1ojvebQc6f4HOIh2uDXc29CIxyeuQiSGjv0JnEbHsKOfRoyGeOOZCd+NhiIWkje
         vlBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m7KSuAye9nwa9cL04J9X/RvSDGYQSepy1vvDUuO3JR8=;
        b=h5d08G5mXWfhl0N7uH4vc5lBDSQwhUFRjd2e3SOHgJ9ejoNouEFtLZNdMpxlMtZVGG
         IoCKgItoHputWdfsK4KWaFA4PdEtoBcvcAX0PniXPq2Fdm0s2DZ2rhBKy0ddHkxPNlVh
         XCtrv5muGROcX/Ett/0t6hMDlanNDW+OZreIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=m7KSuAye9nwa9cL04J9X/RvSDGYQSepy1vvDUuO3JR8=;
        b=LoKKTwmKbSVpczQMg2lgup6UqSQ6/IwQZdq97HycRhRQwU27JfuiBw+YMe+GIwgNQD
         cc5ANXvHJbQMJ3ymG3toC1skvrxPPr75OJcP5Yb6j5k7Y3iALBLdEt9jJvPxeRnCRWUX
         343O4xHYlQTBpplm+4yrcgVxLm2DxDiqmY1jlbgMLwBc4wlu/BH9LNSFvQWWaFXLcaSH
         psQD8BCayGjty8ujkQRDjjOxVkCFAl8FPmZqw1lRdZ1doDn/TRfsUD3ljmYdK72ACMrZ
         LUUAgKWFAWzT3vkDsUQ7ysW542hEkAOU0RukeLmHYp1S2DWhw1c/qzNM3un9obQQrrXy
         Uwgw==
X-Gm-Message-State: AG10YORbg3dP79ds89zuCDH4BHgk9Hb6w0MntYrXx+/EY+8qe+fHHGuIYRbSbuejO0seXb/D9Oq9BQZ0yqoT+w==
MIME-Version: 1.0
X-Received: by 10.107.132.221 with SMTP id o90mr28916715ioi.137.1453847621300;
 Tue, 26 Jan 2016 14:33:41 -0800 (PST)
Received: by 10.36.60.82 with HTTP; Tue, 26 Jan 2016 14:33:40 -0800 (PST)
In-Reply-To: <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
        <20160118081929.GA30420@gondor.apana.org.au>
        <20160118154629.GB3818@linux.vnet.ibm.com>
        <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
        <20160126172227.GG6357@twins.programming.kicks-ass.net>
        <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
        <20160126201037.GU4503@linux.vnet.ibm.com>
        <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
Date:   Tue, 26 Jan 2016 14:33:40 -0800
X-Google-Sender-Auth: jrH1Y-2rPmX0XPeb1iHEl5cNOaA
Message-ID: <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>,
        linux-xtensa@linux-xtensa.org,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        David Daney <ddaney.cavm@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-metag@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Joe Perches <joe@perches.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51439
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

On Tue, Jan 26, 2016 at 2:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You might as well just write it as
>
>     struct foo x = READ_ONCE(*ptr);
>     x->bar = 5;
>
> because that "smp_read_barrier_depends()" does NOTHING wrt the second write.

Just to clarify: on alpha it adds a memory barrier, but that memory
barrier is useless.

On non-alpha, it is a no-op, and obviously does nothing simply because
it generates no code.

So if anybody believes that the "smp_read_barrier_depends()" does
something, they are *wrong*.

And if anybody sends out an email with that smp_read_barrier_depends()
in an example, they are actively just confusing other people, which is
even worse than just being wrong. Which is why I jumped in.

So stop perpetuating the myth that smp_read_barrier_depends() does
something here. It does not. It's a bug, and it has become this "mind
virus" for some people that seem to believe that it does something.

I had to remove this crap once from the kernel already, see commit
105ff3cbf225 ("atomic: remove all traces of READ_ONCE_CTRL() and
atomic*_read_ctrl()").

I don't want to ever see that broken construct again. And I want to
make sure that everybody is educated about how broken it was. I'm
extremely unhappy that it came up again.

If it turns out that some architecture does actually need a barrier
between a read and a dependent write, then that will mean that

 (a) we'll have to make up a _new_ barrier, because
"smp_read_barrier_depends()" is not that barrier. We'll presumably
then have to make that new barrier part of "rcu_derefence()" and
friends.

 (b) we will have found an architecture with even worse memory
ordering semantics than alpha, and we'll have to stop castigating
alpha for being the worst memory ordering ever.

but I sincerely hope that we'll never find that kind of broken architecture.

               Linus
