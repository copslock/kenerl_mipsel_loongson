Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 16:00:06 +0100 (CET)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:41206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991068AbeKAPACxKsRS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 16:00:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Rt73Dkjs07M2EcZc58W7I7bXnGaShUh703bpJozHxs=; b=QxfYez8di/tjSKl0d4uXLdjw8
        Qh9+4+H80o9W5ZaFFgn2RytbCxiV+XYrXcvapx57mvZ/kjzhFJL4TuwB0jfiv5LXADFrx3xlWH/3F
        Bm4mv7XcnrUfzuyfhKr6P2XDMxrwSxZnNrIa7e0CfmWz81voW81Dp7XMuj8m0yYza3cd+99CbxPRO
        Vz4pf9+v1WoNlCM8G7mY3IDP4ecPaf3AOavv1l4AcDlvagHUCRGR5oa0Wr5J1I0hFLZnS7rjyifsz
        NT5fkdg5sA+rlsNuofZqBu9htiulkOWkzurb4sVM206Ddsnxp8eFlbHinDCwsI7NxJ4YkyQiUz2Db
        bKC4siUSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIERU-0003x5-92; Thu, 01 Nov 2018 14:59:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C67620297BC6; Thu,  1 Nov 2018 15:59:26 +0100 (CET)
Date:   Thu, 1 Nov 2018 15:59:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101145926.GE3178@hirez.programming.kicks-ass.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67030
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

On Thu, Nov 01, 2018 at 01:18:46PM +0000, Mark Rutland wrote:
> > My one question (and the reason why I went with cmpxchg() in the first
> > place) would be about the overflow behaviour for atomic_fetch_inc() and
> > friends. I believe those functions should be OK on x86, so that when we
> > overflow the counter, it behaves like an unsigned value and wraps back
> > around.  Is that the case for all architectures?
> > 
> > i.e. are atomic_t/atomic64_t always guaranteed to behave like u32/u64
> > on increment?
> > 
> > I could not find any documentation that explicitly stated that they
> > should.
> 
> Peter, Will, I understand that the atomic_t/atomic64_t ops are required
> to wrap per 2's-complement. IIUC the refcount code relies on this.
> 
> Can you confirm?

There is quite a bit of core code that hard assumes 2s-complement. Not
only for atomics but for any signed integer type. Also see the kernel
using -fno-strict-overflow which implies -fwrapv, which defines signed
overflow to behave like 2s-complement (and rids us of that particular
UB).
