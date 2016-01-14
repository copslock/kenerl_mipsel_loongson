Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 13:05:00 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:55832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009621AbcANMEzfskMW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jan 2016 13:04:55 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8099E49;
        Thu, 14 Jan 2016 04:04:12 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AEC43F246;
        Thu, 14 Jan 2016 04:04:43 -0800 (PST)
Date:   Thu, 14 Jan 2016 12:04:45 +0000
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
Message-ID: <20160114120445.GB15828@arm.com>
References: <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5696BA6E.4070508@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51116
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

On Wed, Jan 13, 2016 at 12:58:22PM -0800, Leonid Yegoshin wrote:
> On 01/13/2016 12:48 PM, Peter Zijlstra wrote:
> >On Wed, Jan 13, 2016 at 11:02:35AM -0800, Leonid Yegoshin wrote:
> >
> >>I ask HW team about it but I have a question - has it any relationship with
> >>replacing MIPS SYNC with lightweight SYNCs (SYNC_WMB etc)?
> >Of course. If you cannot explain the semantics of the primitives you
> >introduce, how can we judge the patch.
> >
> >
> You missed a point - it is a question about replacement of SYNC with
> lightweight primitives. It is NOT a question about multithread system
> behavior without any SYNC. The answer on a latest Will's question lies in
> different area.

The reason we (Peter and I) care about this isn't because we enjoy being
obstructive. It's because there is a whole load of core (i.e. portable)
kernel code that is written to the *kernel* memory model. For example,
the scheduler, RCU, mutex implementations, perf, drivers, you name it.

Consequently, it's important that the architecture back-ends implement
these portable primitives (e.g. smp_mb()) in a way that satisfies the
kernel memory model so that core code doesn't need to worry about the
underlying architecture for synchronisation purposes. You could turn
around and say "but if MIPS gets it wrong, then that's MIPS's problem",
but actually not having a general understanding of the ordering guarantees
provided by each architecture makes it very difficult for us to extend
the kernel memory model in such a way that it can be implemented
efficiently across the board *and* relied upon by core code.

The virtio patch at the start of the thread doesn't particularly concern
me. It's the other patches you linked to that implement acquire/release
that have me worried.

Will
