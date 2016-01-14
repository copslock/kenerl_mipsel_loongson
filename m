Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 23:24:57 +0100 (CET)
Received: from e35.co.us.ibm.com ([32.97.110.153]:57868 "EHLO
        e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010191AbcANWYyuR08W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 23:24:54 +0100
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Jan 2016 15:24:48 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 14 Jan 2016 15:24:46 -0700
X-IBM-Helo: d03dlp03.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 53BD519D804A;
        Thu, 14 Jan 2016 15:12:47 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0EMOjOZ27459666;
        Thu, 14 Jan 2016 15:24:45 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0EMOX0k012927;
        Thu, 14 Jan 2016 15:24:45 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0EMOW14012880;
        Thu, 14 Jan 2016 15:24:32 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D28F016C1B1C; Thu, 14 Jan 2016 14:24:33 -0800 (PST)
Date:   Thu, 14 Jan 2016 14:24:33 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20160114222433.GI3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
 <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com>
 <5697FA0A.6040601@imgtec.com>
 <20160114201513.GI6357@twins.programming.kicks-ass.net>
 <56980933.2020801@imgtec.com>
 <20160114213440.GG3818@linux.vnet.ibm.com>
 <56981708.4000007@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56981708.4000007@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011422-0013-0000-0000-00001BE5CF65
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51140
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

On Thu, Jan 14, 2016 at 01:45:44PM -0800, Leonid Yegoshin wrote:
> On 01/14/2016 01:34 PM, Paul E. McKenney wrote:
> >On Thu, Jan 14, 2016 at 12:46:43PM -0800, Leonid Yegoshin wrote:
> >>On 01/14/2016 12:15 PM, Peter Zijlstra wrote:
> >>>On Thu, Jan 14, 2016 at 11:42:02AM -0800, Leonid Yegoshin wrote:
> >>>>An the only point - please use an appropriate SYNC_* barriers instead of
> >>>>heavy bold hammer. That stuff was design explicitly to support the
> >>>>requirements of Documentation/memory-barriers.txt
> >>>That's madness. That document changes from version to version as to what
> >>>we _think_ the actual hardware does. It is _NOT_ a specification.
> >>>
> >>>You cannot design hardware from that. Its incomplete and fails to
> >>>specify a bunch of things. It not a mathematically sound definition of a
> >>>memory model.
> >>>
> >>>Please stop referring to that document for what a particular barrier
> >>>_should_ do.  Explain what MIPS does, so we can attempt to integrate
> >>>this knowledge with our knowledge of PPC/ARM/Alpha/x86/etc. and improve
> >>>upon our understanding of hardware and improve the Linux memory model.
> >>I am afraid I can't help you here. It is very complicated stuff and
> >>a model is actually doesn't fit your assumptions about CPUs well
> >>without some simplifications which are based on what you want to
> >>have.
> >>
> >>I say that SYNC_ACQUIRE/etc follows what you expect for smp_acquire
> >>etc (basing on that document). And at least two CPU models were
> >>tested with my patches (see it in LMO) for that last year and that
> >>instructions are implemented now in engineering kernel.
> >>
> >>If you have something else in mind, you can ask me. But I prefer to
> >>do not deviate too much from Documentation/memory-barriers.txt, for
> >>exam - if it asks to have memory barrier somewhere, then I assume
> >>the code should have it, and please - don't ask me a test which
> >>violates the current version of document recommendations.
> >>
> >>For a moment I don't see a significant changes in this document for
> >>MIPS Arch at least 1.5 year, and the only significant point is that
> >>MIPS CPU Arch doesn't have yet smp_read_barrier_depends() and
> >>smp_rmb() should be used instead.
> 
> >Is SYNC_ACQUIRE a memory-barrier instruction that orders prior loads
> >against later loads and stores?
> 
> Yes, it is in MD00087 (table 6.6 of document Ver 6.04) -
> https://imgtec.com/?do-download=4302

OK, it does look like it should work.  Of course, if you can rely
on straight address/data dependencies, that would be even better.

> >   If so, and if MIPS does not do
> >ordering based on address and data dependencies, I suggest making
> >read_barrier_depends() be a SYNC_ACQUIRE rather than SYNC_RMB.
> 
> I understood that, after I see the example of using it.
> Please consider to add that into Documentation/memory-barriers.txt
> (it is not easy to find that this barrier is used for shared WRITE
> basing on shared pointer), it would be helpful.

Actually, the Linux kernel doesn't have an acquire barrier, just an
smp_load_acquire().  Or did someone sneak one in while I wasn't looking?  ;-)

							Thanx, Paul
