Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:01:08 +0100 (CET)
Received: from e34.co.us.ibm.com ([32.97.110.152]:59392 "EHLO
        e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011663AbcAZWADN1Bmi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 23:00:03 +0100
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jan 2016 14:59:56 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 26 Jan 2016 14:59:54 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0504E1FF0046;
        Tue, 26 Jan 2016 14:48:04 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0QLxrM729819072;
        Tue, 26 Jan 2016 14:59:53 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0QLxZH9008663;
        Tue, 26 Jan 2016 14:59:52 -0700
Received: from paulmck-ThinkPad-W541 (paulmck-thinkpad-w541.au.ibm.com [9.192.250.130])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0QLxWUH008430;
        Tue, 26 Jan 2016 14:59:32 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E883116C1AFA; Tue, 26 Jan 2016 11:44:10 -0800 (PST)
Date:   Tue, 26 Jan 2016 11:44:10 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
Message-ID: <20160126194410.GQ4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160113104516.GE25458@arm.com>
 <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
 <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126102402.GE6357@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16012621-0017-0000-0000-00001187A013
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51436
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

On Tue, Jan 26, 2016 at 11:24:02AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 14, 2016 at 02:20:46PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 14, 2016 at 01:24:34PM -0800, Leonid Yegoshin wrote:
> > > On 01/14/2016 12:48 PM, Paul E. McKenney wrote:
> > > >
> > > >So SYNC_RMB is intended to implement smp_rmb(), correct?
> > > Yes.
> > > >
> > > >You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> > > >smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.
> > > 
> > > If smp_read_barrier_depends() is used to separate not only two reads
> > > but read pointer and WRITE basing on that pointer (example below) -
> > > yes. I just doesn't see any example of this in famous
> > > Documentation/memory-barriers.txt and had no chance to know what you
> > > use it in this way too.
> > 
> > Well, Documentation/memory-barriers.txt was intended as a guide for Linux
> > kernel hackers, and not for hardware architects.
> 
> Yeah, this goes under the header: memory-barriers.txt is _NOT_ a
> specification (I seem to keep repeating this).
> 
> > ------------------------------------------------------------------------
> > 
> > commit 955720966e216b00613fcf60188d507c103f0e80
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Thu Jan 14 14:17:04 2016 -0800
> > 
> >     documentation: Subsequent writes ordered by rcu_dereference()
> >     
> >     The current memory-barriers.txt does not address the possibility of
> >     a write to a dereferenced pointer.  This should be rare, 
> 
> How are these rare? Isn't:
> 
> 	rcu_read_lock()
> 	obj = rcu_dereference(ptr);
> 	if (!atomic_inc_not_zero(&obj->ref))
> 		obj = NULL;
> 	rcu_read_unlock();
> 
> a _very_ common thing to do?

It is, but it provides its own barriers, so does not need to rely on
dependency ordering.

							Thanx, Paul
