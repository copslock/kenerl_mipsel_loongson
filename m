Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 18:28:09 +0100 (CET)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:44206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991112AbeKAR15aWHvQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 18:27:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cqmmiMgCoNcYZQd3PjTzf7yi7hw7o8SwAHEWFTCrXl8=; b=gWLRh4r6aXQzNSHXyEu6rBCZ0
        CXntVUXtJM7/5EOPwODwlXeSL7EmyL0qVWbo1al8RQrIRBjiboIjqi1FRwPHUki+FEub2DgMCN16q
        qQJaNWTsghoRMRDX0mBRay5LsKTKLlz6KH0pNTYOt3kVNhGjD4gcDjSzhQlnVMO7RqvtddOHMAcgX
        F5wImHGmImAKF8mI96vG+8qR0gVOdYlCWxwzkuxlkePVLDG9x+donUW01Scn0HYp5Vwwobmi3G5YW
        40rP5Rj7NmuIJaVbrW1E0pLR+BS3THdg2CScMj7zCN/sGDRUUBuZ9BCNVRVhHd43UyIqAwZg30xnZ
        NFI5GOftA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIGkx-0005xd-BU; Thu, 01 Nov 2018 17:27:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E0512029F9FF; Thu,  1 Nov 2018 18:27:39 +0100 (CET)
Date:   Thu, 1 Nov 2018 18:27:39 +0100
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
Message-ID: <20181101172739.GA3196@hirez.programming.kicks-ass.net>
References: <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <b0160f4b-b996-b0ee-405a-3d5f1866272e@gmail.com>
 <20181101171432.GH3178@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101171432.GH3178@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67038
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

On Thu, Nov 01, 2018 at 06:14:32PM +0100, Peter Zijlstra wrote:
> > This reminds me of this sooooo silly patch :/
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb03115f4590baa280ddc440a8eff08a6be0cb7

You'd probably want to write it like so; +- some ordering stuff, that
code didn't look like it really needs the memory barriers implied by
these, but I didn't look too hard.

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c0a9d26c06ce..11deb1d7e96b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -485,16 +485,10 @@ u32 ip_idents_reserve(u32 hash, int segs)
 	u32 now = (u32)jiffies;
 	u32 new, delta = 0;
 
-	if (old != now && cmpxchg(p_tstamp, old, now) == old)
+	if (old != now && try_cmpxchg(p_tstamp, &old, now))
 		delta = prandom_u32_max(now - old);
 
-	/* Do not use atomic_add_return() as it makes UBSAN unhappy */
-	do {
-		old = (u32)atomic_read(p_id);
-		new = old + delta + segs;
-	} while (atomic_cmpxchg(p_id, old, new) != old);
-
-	return new - segs;
+	return atomic_fetch_add(segs + delta, p_id) + delta;
 }
 EXPORT_SYMBOL(ip_idents_reserve);
 
