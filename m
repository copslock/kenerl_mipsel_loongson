Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 18:14:48 +0100 (CET)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:59076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991066AbeKAROomttzS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 18:14:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ma3LP1JT+d0hJ1ipGHv8/xbHP5Yk8y77+qZqZv7uYZ0=; b=gdTDPDZTLiwW6lM1tuILcZdvw
        qqVhAeWF4ynHujkSXNAEm/u7v6nK4ymMaziRzE5VoQilbCorYXURmXQXThpxN+5pzZJGmKAFeOYbV
        2hkhje3QKPRjEozGs8wVDDesg5fzq3YFIxroaz3rpvmqOXq0izC3fW66p5U7s49Q3EfsoOy7q1cNe
        +fgoba1e0ElZACsL6oNJGyjYtkR70ojujtiT0RpOV3UhGXtMiO2FmeZwr+KLhJV7jBoBGqp+BxSkZ
        po3276nyM4q9EkqWYj72vF5FmU+E0W2bcNbN9C7BkL1+xjui2LPjpAqrw9onDSVX/SS/hmQX/qFw5
        5jL0XRh2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIGYE-0007Uw-ME; Thu, 01 Nov 2018 17:14:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 339352029F9FF; Thu,  1 Nov 2018 18:14:32 +0100 (CET)
Date:   Thu, 1 Nov 2018 18:14:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
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
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        aryabinin@virtuozzo.com, dvyukov@google.com
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101171432.GH3178@hirez.programming.kicks-ass.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <b0160f4b-b996-b0ee-405a-3d5f1866272e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0160f4b-b996-b0ee-405a-3d5f1866272e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67036
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

On Thu, Nov 01, 2018 at 09:59:38AM -0700, Eric Dumazet wrote:
> On 11/01/2018 09:32 AM, Peter Zijlstra wrote:
> 
> >> Anyhow, if the atomic maintainers are willing to stand up and state for
> >> the record that the atomic counters are guaranteed to wrap modulo 2^n
> >> just like unsigned integers, then I'm happy to take Paul's patch.
> > 
> > I myself am certainly relying on it.
> 
> Could we get uatomic_t support maybe ?

Whatever for; it'd be the exact identical same functions as for
atomic_t, except for a giant amount of code duplication to deal with the
new type.

That is; today we merged a bunch of scripts that generates most of
atomic*_t, so we could probably script uatomic*_t wrappers with minimal
effort, but it would add several thousand lines of code to each compile
for absolutely no reason what so ever.

> This reminds me of this sooooo silly patch :/
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb03115f4590baa280ddc440a8eff08a6be0cb7

Yes, that's stupid. UBSAN is just wrong there.
