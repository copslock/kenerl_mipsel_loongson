Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 13:15:01 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:55937 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009621AbcANMO70dWZW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jan 2016 13:14:59 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F006649;
        Thu, 14 Jan 2016 04:14:16 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A19AF3F246;
        Thu, 14 Jan 2016 04:14:47 -0800 (PST)
Date:   Thu, 14 Jan 2016 12:14:50 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160114121449.GC15828@arm.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5696CF08.8080700@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51117
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

On Wed, Jan 13, 2016 at 02:26:16PM -0800, Leonid Yegoshin wrote:
> On 01/13/2016 02:45 AM, Will Deacon wrote:
> >>
> >I don't think the address dependency is enough on its own. By that
> >reasoning, the following variant (WRC+addr+addr) would work too:
> >
> >
> >P0:
> >Wx = 1
> >
> >P1:
> >Rx == 1
> ><address dep>
> >Wy = 1
> >
> >P2:
> >Ry == 1
> ><address dep>
> >Rx = 0
> >
> >
> >So are you saying that this is also forbidden?
> >Imagine that P0 and P1 are two threads that share a store buffer. What
> >then?
> 
> OK, I collected answers and it is:
> 
>     In MIPS R6 this test passes OK, I mean - P2: Rx = 1 if Ry is read as 1.
> By design.
> 
>     However, it is unclear that happens in MIPS R2 1004K.

How can it be unclear? If, for example, the outcome is permitted on that
CPU, then your original reasoning for the WRC+sync+addr doesn't apply
there and SYNC is not transitive. That's what I'm trying to get to the
bottom of.

Does the MIPS kernel target a particular CPU at compile time?

>     Moreover, there are voices against guarantee that it will be in future
> and that voices point me to Documentation/memory-barriers.txt section "DATA
> DEPENDENCY BARRIERS" examples which require SYNC_RMB between loading
> address/index and using that for loading data based on that address or index
> for shared data (look on CPU2 pseudo-code):
> >To deal with this, a data dependency barrier or better must be inserted
> >between the address load and the data load:
> >
> >        CPU 1                 CPU 2
> >        ===============       ===============
> >        { A == 1, B == 2, C = 3, P == &A, Q == &C }
> >        B = 4;
> >        <write barrier>
> >        WRITE_ONCE(P, &B);
> >                              Q = READ_ONCE(P);
> >                              <data dependency barrier> <-----------
> >SYNC_RMB is here
> >                              D = *Q;
> ...
> >Another example of where data dependency barriers might be required is
> >where a
> >number is read from memory and then used to calculate the index for an
> >array
> >access:
> >
> >        CPU 1                 CPU 2
> >        ===============       ===============
> >        { M[0] == 1, M[1] == 2, M[3] = 3, P == 0, Q == 3 }
> >        M[1] = 4;
> >        <write barrier>
> >        WRITE_ONCE(P, 1);
> >                              Q = READ_ONCE(P);
> >                              <data dependency barrier> <------------
> >SYNC_RMB is here
> >                              D = M[Q];
> 
> That voices say that there is a legitimate reason to relax HW here for
> performance if SYNC_RMB is needed anyway to work with this sequence of
> shared data.

Are you saying that MIPS needs to implement [smp_]read_barrier_depends?

> And all that is out-of-topic here in my mind. I just want to be sure that
> this patchset still provides a use of a specific lightweight SYNCs on MIPS
> vs bold and heavy generalized "SYNC 0" in any case.

We may be highjacking the thread slightly, but there are much bigger
issues at play here if you want to start using lightweight barriers to
implement relaxed kernel primitives such as smp_load_acquire and
smp_store_release.

Will
