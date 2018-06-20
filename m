Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 10:16:55 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:36908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990475AbeFTIQsYxPOW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2018 10:16:48 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA7615BF;
        Wed, 20 Jun 2018 01:16:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE0BB3F246;
        Wed, 20 Jun 2018 01:16:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 883C71AE35A5; Wed, 20 Jun 2018 09:17:16 +0100 (BST)
Date:   Wed, 20 Jun 2018 09:17:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180620081715.GA27776@arm.com>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
 <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
 <tencent_59DC823168EC2F5D42AE44F0@qq.com>
 <20180619072242.GC2494@hirez.programming.kicks-ass.net>
 <tencent_2BF857EC332473814C12A753@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2BF857EC332473814C12A753@qq.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Wed, Jun 20, 2018 at 11:31:55AM +0800, 陈华才 wrote:
> Loongson-3's Store Fill Buffer is nearly the same as your "Store Buffer",
> and it increases the memory ordering weakness. So, smp_cond_load_acquire()
> only need a __smp_mb() before the loop, not after every READ_ONCE(). In
> other word, the following code is just OK:
> 
> #define smp_cond_load_acquire(ptr, cond_expr)                   \
> ({                                                              \
>         typeof(ptr) __PTR = (ptr);                              \
>         typeof(*ptr) VAL;                                       \
>         __smp_mb();                                     \
>         for (;;) {                                              \
>                 VAL = READ_ONCE(*__PTR);                        \
>                 if (cond_expr)                                  \
>                         break;                                  \
>                 cpu_relax();                                    \
>         }                                                       \
>         __smp_mb();                                     \
>         VAL;                                                    \
> })
> 
> the __smp_mb() before loop is used to avoid "reads prioritised over
> writes", which is caused by SFB's weak ordering and similar to ARM11MPCore
> (mentioned by Will Deacon).

Sure, but smp_cond_load_acquire() isn't the only place you'll see this sort
of pattern in the kernel. In other places, the only existing arch hook is
cpu_relax(), so unless you want to audit all loops and add a special
MIPs-specific smp_mb() to those that are affected, I think your only option
is to stick it in cpu_relax().

I assume you don't have a control register that can disable this
prioritisation in the SFB?

Will
