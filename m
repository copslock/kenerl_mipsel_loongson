Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 11:24:43 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:33901 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009085AbcAOKYk6NT55 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jan 2016 11:24:40 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F5A49;
        Fri, 15 Jan 2016 02:23:58 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 055A03F246;
        Fri, 15 Jan 2016 02:24:28 -0800 (PST)
Date:   Fri, 15 Jan 2016 10:24:32 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
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
Message-ID: <20160115102431.GB2131@arm.com>
References: <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160114225510.GJ3818@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51151
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

On Thu, Jan 14, 2016 at 02:55:10PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 14, 2016 at 01:36:50PM -0800, Leonid Yegoshin wrote:
> > On 01/14/2016 01:29 PM, Paul E. McKenney wrote:
> > >
> > >>On 01/14/2016 12:34 PM, Paul E. McKenney wrote:
> > >>>
> > >>>The WRC+addr+addr is OK because data dependencies are not required to be
> > >>>transitive, in other words, they are not required to flow from one CPU to
> > >>>another without the help of an explicit memory barrier.
> > >>I don't see any reliable way to fit WRC+addr+addr into "DATA
> > >>DEPENDENCY BARRIERS" section recommendation to have data dependency
> > >>barrier between read of a shared pointer/index and read the shared
> > >>data based on that pointer. If you have this two reads, it doesn't
> > >>matter the rest of scenario, you should put the dependency barrier
> > >>in code anyway. If you don't do it in WRC+addr+addr scenario then
> > >>after years it can be easily changed to different scenario which
> > >>fits some of scenario in "DATA DEPENDENCY BARRIERS" section and
> > >>fails.
> > >The trick is that lockless_dereference() contains an
> > >smp_read_barrier_depends():
> > >
> > >#define lockless_dereference(p) \
> > >({ \
> > >	typeof(p) _________p1 = READ_ONCE(p); \
> > >	smp_read_barrier_depends(); /* Dependency order vs. p above. */ \
> > >	(_________p1); \
> > >})
> > >
> > >Or am I missing your point?
> > 
> > WRC+addr+addr has no any barrier. lockless_dereference() has a
> > barrier. I don't see a common points between this and that in your
> > answer, sorry.
> 
> Me, I am wondering what WRC+addr+addr has to do with anything at all.

See my earlier reply [1] (but also, your WRC Linux example looks more
like a variant on WWC and I couldn't really follow it).

> <Going back through earlier email>
> 
> OK, so it looks like Will was asking not about WRC+addr+addr, but instead
> about WRC+sync+addr.  This would drop an smp_mb() into cpu2() in my
> earlier example, which needs to provide ordering.
> 
> I am guessing that the manual's "Older instructions which must be globally
> performed when the SYNC instruction completes" provides the equivalent
> of ARM/Power A-cumulativity, which can be thought of as transitivity
> backwards in time. 

I couldn't make that leap. In particular, the manual's "Detailed
Description" sections explicitly refer to program-order:

  Every synchronizable specified memory instruction (loads or stores or
  both) that occurs in the instruction stream before the SYNC
  instruction must reach a stage in the load/store datapath after which
  no instruction re-ordering is possible before any synchronizable
  specified memory instruction which occurs after the SYNC instruction
  in the instruction stream reaches the same stage in the load/store
  datapath.

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399765.html
