Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 15:25:34 +0100 (CET)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:56132 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992783AbeKEOZbeMIGc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 15:25:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bDIKyuSp9LLH9BqGVqhJP/hbXdOmufd3UQW+85NbV+8=; b=rykwNpJ5nCzznn4Jucrx26gsq
        +JH4MPOXMJ+pyWb4JU6Gj3AHUuigkLWXl9uB/Dn7tVxRF87Ptd16aKHV8RQW0nrfm1DqdeIboPOpJ
        w2ytLOtAu3dVg33KI46V7z703S+T8XnZkGmRqV7gYgNLAL7GqHnE5WapNvgfRsWGdMSJ3gMnO0cyk
        gZVOd/rhM4BbpGP6BT2UJhVvVWmX/HGnTnK8eZWbA8bXiFbqStjSfBDyJ0iWJjwae4/JjrmnjZYSd
        F2LwaakSwVKD/wKt8d3+feCrExhqyR6midZcsGLi3jSKyovhcXMJjIGoqUavssAC/YMHmpKsUr2NC
        QLv2vSwLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJfoG-0006kE-Li; Mon, 05 Nov 2018 14:24:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3223A2029F9FF; Mon,  5 Nov 2018 15:24:53 +0100 (CET)
Date:   Mon, 5 Nov 2018 15:24:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
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
        Paul McKenney <paulmck@linux.vnet.ibm.com>, dvyukov@google.com,
        willy@infradead.org
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181105142453.GA22449@hirez.programming.kicks-ass.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <5a846924-e642-d9d1-4e0e-810bd4d01c26@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a846924-e642-d9d1-4e0e-810bd4d01c26@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67084
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

On Fri, Nov 02, 2018 at 07:19:15PM +0300, Andrey Ryabinin wrote:
> UBSAN warns about signed overflows despite -fno-strict-overflow if gcc version is < 8.
> I have learned recently that UBSAN in GCC 8 ignores signed overflows if -fno-strict-overflow of fwrapv is used.
> 
> $ cat signed_overflow.c 
> #include <stdio.h>
> 
> __attribute__((noinline))
> int foo(int a, int b)
> {
>         return a+b;

 s/+/<</

> }
> 
> int main(void)
> {
>         int a = 0x7fffffff;
>         int b = 2;
>         printf("%d\n", foo(a,b));
>         return 0;
> }

It also seem to affect 'shift':

peterz@hirez:~/tmp$ gcc -fsanitize=signed-integer-overflow,shift overflow.c ; ./a.out
overflow.c:6:11: runtime error: left shift of 2147483647 by 2 places cannot be represented in type 'int'
-4
peterz@hirez:~/tmp$ gcc -fsanitize=signed-integer-overflow,shift -fwrapv overflow.c ; ./a.out
-4
