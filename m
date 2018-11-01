Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 17:36:07 +0100 (CET)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:42206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991096AbeKAQee1hCAS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 17:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=72R9GSVv7q61E8s94sqJXn1GeQMfmrRmyrChueXaE7o=; b=EjDVk916koSID/y6g6cHYn2U0
        H0Dp44Xq9Z4gsV937jqvr0H8/OvdnyAJrPM4MSc0DghXIXDQYKRd7XszAq73m8jiPtcLDA3RaNcF6
        s8jDzxwGB42zer9eDKYQt23SthtpPQlMYaFTagbfYWlXx3pkhZD6gWoS4l77j4T3ez0XXgBh4mvw5
        pU3DqmA8ykYhW06wZLT+Vx+KEzEdOLoM+E/BtFiW1AejvhVkSTK7xo8ryt7EnpoyDHSb/MArxg/rG
        rkuf7fCmBhGO3jJy0j1x25iy9pwUK0V1tTxDAIvfGEuqOcV+Rv+HVv4Fct2rw8aPBmQOKRKlQ7IsW
        UFvIJi2NA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIFtH-0002L3-Pg; Thu, 01 Nov 2018 16:32:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CAE020297B7F; Thu,  1 Nov 2018 17:32:12 +0100 (CET)
Date:   Thu, 1 Nov 2018 17:32:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        aryabinin@virtuozzo.com, dvyukov@google.com
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101163212.GF3159@hirez.programming.kicks-ass.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67033
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

On Thu, Nov 01, 2018 at 03:22:15PM +0000, Trond Myklebust wrote:
> On Thu, 2018-11-01 at 15:59 +0100, Peter Zijlstra wrote:
> > On Thu, Nov 01, 2018 at 01:18:46PM +0000, Mark Rutland wrote:

> > > > My one question (and the reason why I went with cmpxchg() in the
> > > > first place) would be about the overflow behaviour for
> > > > atomic_fetch_inc() and friends. I believe those functions should
> > > > be OK on x86, so that when we overflow the counter, it behaves
> > > > like an unsigned value and wraps back around.  Is that the case
> > > > for all architectures?
> > > > 
> > > > i.e. are atomic_t/atomic64_t always guaranteed to behave like
> > > > u32/u64 on increment?
> > > > 
> > > > I could not find any documentation that explicitly stated that
> > > > they should.
> > > 
> > > Peter, Will, I understand that the atomic_t/atomic64_t ops are
> > > required to wrap per 2's-complement. IIUC the refcount code relies
> > > on this.
> > > 
> > > Can you confirm?
> > 
> > There is quite a bit of core code that hard assumes 2s-complement.
> > Not only for atomics but for any signed integer type. Also see the
> > kernel using -fno-strict-overflow which implies -fwrapv, which
> > defines signed overflow to behave like 2s-complement (and rids us of
> > that particular UB).
> 
> Fair enough, but there have also been bugfixes to explicitly fix unsafe
> C standards assumptions for signed integers. See, for instance commit
> 5a581b367b5d "jiffies: Avoid undefined behavior from signed overflow"
> from Paul McKenney.

Yes, I feel Paul has been to too many C/C++ committee meetings and got
properly paranoid. Which isn't always a bad thing :-)

But for us using -fno-strict-overflow which actually defines signed
overflow, I myself am really not worried. I'm also not sure if KASAN has
been taught about this, or if it will still (incorrectly) warn about UB
for signed types.

> Anyhow, if the atomic maintainers are willing to stand up and state for
> the record that the atomic counters are guaranteed to wrap modulo 2^n
> just like unsigned integers, then I'm happy to take Paul's patch.

I myself am certainly relying on it.
