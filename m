Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 00:45:31 +0100 (CET)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35365 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010153AbcAZXpaFJvT3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 00:45:30 +0100
Received: by mail-ig0-f180.google.com with SMTP id t15so71679778igr.0;
        Tue, 26 Jan 2016 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vxBBdpwNnuIYljVJMd5huWdXDB1gbM3g3PzFkWQk4HE=;
        b=IRTA+XM1m8Nn928bPpCQxnH6+BTb8zxUTZBZ5R/dUSl7sL1OZOWLH/Yk6nzo76Y49k
         K91wrBsgnlWuB7nLEX1Pg9YotRLJ4rxHTZAKAF7s2zQQSHw9NZMuH19ptaUoh6vaDlc7
         kyExqroSJmXOPTPkNAAHHvKxf+AlH+lLV5g8rv6Zk0wqewQcugMewbowEIn2Bxc3DbgL
         EXO76uBjXA2qYSJkaN/bygk0Rzf0JXEYhT0R25ZmD/2aYLpAOZ9lwAcsj0LEvrUuJZPk
         0xsamyyeiczkWhHU4+Y5jCvkgnwerPshIp5Zg5U0+tiM86a4AkFJnnyRbl/NxBATohI+
         bIJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vxBBdpwNnuIYljVJMd5huWdXDB1gbM3g3PzFkWQk4HE=;
        b=G9+N2roo+z62nZ62H8h824R5AfJwgB/v3AQqybEMArznsCucyVUUe+IHLsDjQafhtc
         S6TWZHovLQHsmlT267MTHXQfvl2VeuxGsSNUeH6Rit+X0WegGpa7EWfk46ZWrnb8690N
         Pxvh1I40mOWAe/ztQFSapr2SpCXr7YGQvYBSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vxBBdpwNnuIYljVJMd5huWdXDB1gbM3g3PzFkWQk4HE=;
        b=HRz/nQhcDkzVMYHWFGu0My4NM21liw1/uWDYZpRZYtMb0iTE6+CaqqrVTy8OxJcoq7
         T2pgGUs2BNs2BMQxVG4UMGaMftrD/Qn6vJWdFkJVB0KYTQBnnpMGdFXgZVtJMReSG1sC
         UJRBJ8uV8FOu2oSAVR569ZUcWr79n5o4NVV/Xv3oRcjtK4FoHttafm7ZDuPYwxlUvQX0
         HAS9viDLWR9C7pkLywLYM6BgC2pDGRwFmOX9UD77d77eBvy8u0Z6YUoSg4QD2hHSm/yH
         tHDcaF5ly8l6ghHd1FYwFj32WGvb8nNcl1NUMBqjlL9rgqkLadX3RTaDEqRFwLySTemZ
         Nu9w==
X-Gm-Message-State: AG10YOTKFtBPJbwqix7e9DFPc7ANlEYuoHp0qq/ZHFJO3ZFzq0m7xSamN87hcYVtoO70nh5/V1/W/7zLjHkGGA==
MIME-Version: 1.0
X-Received: by 10.50.43.168 with SMTP id x8mr19533080igl.93.1453851924284;
 Tue, 26 Jan 2016 15:45:24 -0800 (PST)
Received: by 10.36.60.82 with HTTP; Tue, 26 Jan 2016 15:45:23 -0800 (PST)
In-Reply-To: <20160126232921.GY4503@linux.vnet.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
        <20160118081929.GA30420@gondor.apana.org.au>
        <20160118154629.GB3818@linux.vnet.ibm.com>
        <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
        <20160126172227.GG6357@twins.programming.kicks-ass.net>
        <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
        <20160126201037.GU4503@linux.vnet.ibm.com>
        <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
        <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
        <20160126232921.GY4503@linux.vnet.ibm.com>
Date:   Tue, 26 Jan 2016 15:45:23 -0800
X-Google-Sender-Auth: r9XMt0fFOI9jyue8YZofPMkFFFw
Message-ID: <CA+55aFyD94yaA1QzXgfeO18T-czY3TVUi5n6r-9jOUObDeR-zQ@mail.gmail.com>
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
X-archive-position: 51445
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

On Tue, Jan 26, 2016 at 3:29 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> No trailing data-dependent read, so agreed, no smp_read_barrier_depends()
> needed.  That said, I believe that we should encourage rcu_dereference*()
> or lockless_dereference() instead of READ_ONCE() for documentation
> reasons, though.

I agree that that is likely the right thing to do in pretty much all situations.

In theory, there might be performance situations where we'd want to
actively avoid the smp_read_barrier_depends() inherent in those, but
considering that it's only a performance issue on alpha, and we
probably have all of two or three people using Linux on alpha, it's a
pretty theoretical performance worry.

                  Linus
