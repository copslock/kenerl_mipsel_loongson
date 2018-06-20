Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 11:22:42 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbeFTJWgJ0hLn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 11:22:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mm8B6hvvw2/VNm8h40poQZG0dsa92W6ce82K+9oLdF0=; b=J5tf/UZpExB0n+CuRHIZDz8J5G
        QZjxc7TWh34GfhSehQQxNesnKNoTISy7S7BwVzeevnAswNQC03mivf1jc5Ozyx23heikOh2pxv2Em
        ztP45cjmrggMlFdGdrQvhWvglUjssvgVHPYenZjicpEnwhvm2WPFDf2vLZx/LHzw4VKJZD+jHHCH4
        6BhfjTCvn3KHjE8SKnlySfwtiQxHkZJNDu3N0bbRKbLv/eQSm3FpORmWqUtQ2We5MvvU/cxYw915D
        BGFJI+5906LbwYDIa9K7de/Xtqd8iCZeedwQO0+9IImnd/1fRfW58zG2NeKzHmaZuqBWm9th4VBci
        OllyLKZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVZJr-00039z-LP; Wed, 20 Jun 2018 09:22:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 197BC2029F1DD; Wed, 20 Jun 2018 11:22:26 +0200 (CEST)
Date:   Wed, 20 Jun 2018 11:22:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        AndreaParri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180620092226.GM2476@hirez.programming.kicks-ass.net>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
 <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
 <tencent_59DC823168EC2F5D42AE44F0@qq.com>
 <20180619072242.GC2494@hirez.programming.kicks-ass.net>
 <tencent_2BF857EC332473814C12A753@qq.com>
 <20180620081715.GA27776@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620081715.GA27776@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Wed, Jun 20, 2018 at 09:17:16AM +0100, Will Deacon wrote:
> On Wed, Jun 20, 2018 at 11:31:55AM +0800, 陈华才 wrote:
> > Loongson-3's Store Fill Buffer is nearly the same as your "Store Buffer",
> > and it increases the memory ordering weakness. So, smp_cond_load_acquire()
> > only need a __smp_mb() before the loop, not after every READ_ONCE(). In
> > other word, the following code is just OK:
> > 
> > #define smp_cond_load_acquire(ptr, cond_expr)                   \
> > ({                                                              \
> >         typeof(ptr) __PTR = (ptr);                              \
> >         typeof(*ptr) VAL;                                       \
> >         __smp_mb();                                     \
> >         for (;;) {                                              \
> >                 VAL = READ_ONCE(*__PTR);                        \
> >                 if (cond_expr)                                  \
> >                         break;                                  \
> >                 cpu_relax();                                    \
> >         }                                                       \
> >         __smp_mb();                                     \
> >         VAL;                                                    \
> > })
> > 
> > the __smp_mb() before loop is used to avoid "reads prioritised over
> > writes", which is caused by SFB's weak ordering and similar to ARM11MPCore
> > (mentioned by Will Deacon).
> 
> Sure, but smp_cond_load_acquire() isn't the only place you'll see this sort
> of pattern in the kernel. In other places, the only existing arch hook is
> cpu_relax(), so unless you want to audit all loops and add a special
> MIPs-specific smp_mb() to those that are affected, I think your only option
> is to stick it in cpu_relax().
> 
> I assume you don't have a control register that can disable this
> prioritisation in the SFB?

Right, I think we also want to clarify that this 'feature' is not
supported by the Linux kernel in general and LKMM in specific.

It really is a CPU bug. And the cpu_relax() change is a best effort
work-around.
