Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 18:34:49 +0100 (CET)
Received: from e35.co.us.ibm.com ([32.97.110.153]:52000 "EHLO
        e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009959AbcANRerHRbDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 18:34:47 +0100
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Jan 2016 10:34:39 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 14 Jan 2016 10:34:38 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B83391FF0046;
        Thu, 14 Jan 2016 10:22:47 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0EHYbEZ20971554;
        Thu, 14 Jan 2016 10:34:37 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0EHYUhl025256;
        Thu, 14 Jan 2016 10:34:37 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0EHYQNU024900;
        Thu, 14 Jan 2016 10:34:27 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5A3F016C1B1C; Thu, 14 Jan 2016 08:16:04 -0800 (PST)
Date:   Thu, 14 Jan 2016 08:16:04 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160114161604.GT3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
 <20160114120445.GB15828@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160114120445.GB15828@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011417-0013-0000-0000-00001BE3AA03
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Thu, Jan 14, 2016 at 12:04:45PM +0000, Will Deacon wrote:
> On Wed, Jan 13, 2016 at 12:58:22PM -0800, Leonid Yegoshin wrote:
> > On 01/13/2016 12:48 PM, Peter Zijlstra wrote:
> > >On Wed, Jan 13, 2016 at 11:02:35AM -0800, Leonid Yegoshin wrote:
> > >
> > >>I ask HW team about it but I have a question - has it any relationship with
> > >>replacing MIPS SYNC with lightweight SYNCs (SYNC_WMB etc)?
> > >Of course. If you cannot explain the semantics of the primitives you
> > >introduce, how can we judge the patch.
> > >
> > >
> > You missed a point - it is a question about replacement of SYNC with
> > lightweight primitives. It is NOT a question about multithread system
> > behavior without any SYNC. The answer on a latest Will's question lies in
> > different area.
> 
> The reason we (Peter and I) care about this isn't because we enjoy being
> obstructive. It's because there is a whole load of core (i.e. portable)
> kernel code that is written to the *kernel* memory model. For example,
> the scheduler, RCU, mutex implementations, perf, drivers, you name it.
> 
> Consequently, it's important that the architecture back-ends implement
> these portable primitives (e.g. smp_mb()) in a way that satisfies the
> kernel memory model so that core code doesn't need to worry about the
> underlying architecture for synchronisation purposes. You could turn
> around and say "but if MIPS gets it wrong, then that's MIPS's problem",
> but actually not having a general understanding of the ordering guarantees
> provided by each architecture makes it very difficult for us to extend
> the kernel memory model in such a way that it can be implemented
> efficiently across the board *and* relied upon by core code.

What Will said!

Yes, you can cut corners within MIPS architecture-specific code,
but primitives that are used in the core kernel really do need to
work as expected.

							Thanx, Paul

> The virtio patch at the start of the thread doesn't particularly concern
> me. It's the other patches you linked to that implement acquire/release
> that have me worried.
> 
> Will
> 
