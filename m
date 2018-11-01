Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 22:45:51 +0100 (CET)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:46242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992545AbeKAVprLQU0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 22:45:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MEJyokPYI7oa2A6Ix9ONUmGbnct/Kvmgb/sJnQOStxc=; b=ls+xdu4ozQ7c4yvsm9ovqZ/4f
        fiFuSHac7Q2elKhmdle5qz3kdC0phtzafFsg4Fo2K2xfxrjjRsDtWE8XnThq8D8sZp3qGvjfpHNYJ
        KPaE2XjSwPvKGaCuIvf0YpWpc37Hen7TUH95ZQP0r4vzo5jp+Nq2MzUx1YnyYOG061j3OHyzTmnlr
        s4Jw3VZyfp0csnbleNLXSg2xp268RVktS0DawCGK+9p+MdaTrMQynXvZgyztm7d70YjSIr84TKOug
        92DT3I1mDBUZhew+WI6z8TpS90qReNeQaT3Sba2tf1zJwoV+RlbOUgr7lAc/5xwwbeYpK4YRYEmbD
        9zqkC8MRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIKmR-00079A-Uh; Thu, 01 Nov 2018 21:45:32 +0000
Received: by worktop (Postfix, from userid 1000)
        id 4A4CE6E07D9; Thu,  1 Nov 2018 22:45:29 +0100 (CET)
Date:   Thu, 1 Nov 2018 22:45:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101214529.GB3339@worktop.programming.kicks-ass.net>
References: <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <20181101170146.GQ4170@linux.ibm.com>
 <20181101171846.GI3178@hirez.programming.kicks-ass.net>
 <CACT4Y+aC45BtS88DXarn3A+LV2RRRsPQoSs_3_DnKjU4O3AMHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aC45BtS88DXarn3A+LV2RRRsPQoSs_3_DnKjU4O3AMHQ@mail.gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67045
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

On Thu, Nov 01, 2018 at 06:46:50PM +0100, Dmitry Vyukov wrote:
> If there is a warning that we don't want to see at all, then we can
> disable it. It supposed to be a useful tool, rather than a thing in
> itself that lives own life. We already I think removed 1 particularly
> noisy warning and made another optional via a config.

> But the thing with overflows is that, even if it's defined, it's not
> necessary the intended behavior. For example, take allocation size
> calculation done via unsigned size_t. If it overflows it does not help
> if C defines result or not, it still gives a user controlled write
> primitive. We've seen similar cases with timeout/deadline calculation
> in kernel, we really don't want it to just wrap modulo-2, right. Some
> user-space projects even test with unsigned overflow warnings or
> implicit truncation warnings, which are formally legal, but frequently
> bugs.

Sure; but then don't call it UB.

If we want to have an additional integer over/underflow checker (ideally
with a gcc plugin that has explicit annotations like __wrap to make it
go away) that is fine; and it can be done on unsigned and signed.
