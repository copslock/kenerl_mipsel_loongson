Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 22:59:17 +0100 (CET)
Received: from e33.co.us.ibm.com ([32.97.110.151]:46105 "EHLO
        e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009972AbcAOV7PpU8W3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 22:59:15 +0100
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 15 Jan 2016 14:59:09 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 15 Jan 2016 14:59:06 -0700
X-IBM-Helo: d03dlp02.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C04AC3E40030;
        Fri, 15 Jan 2016 14:59:05 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0FLx5mY21495846;
        Fri, 15 Jan 2016 14:59:05 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0FLwpV6026645;
        Fri, 15 Jan 2016 14:59:04 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0FLwp6Z026607;
        Fri, 15 Jan 2016 14:58:51 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EE43016C0BB6; Fri, 15 Jan 2016 13:58:53 -0800 (PST)
Date:   Fri, 15 Jan 2016 13:58:53 -0800
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
Message-ID: <20160115215853.GC3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115091348.GA27936@worktop>
 <20160115174612.GV3818@linux.vnet.ibm.com>
 <20160115212714.GM3421@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115212714.GM3421@worktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011521-0009-0000-0000-00001175D47E
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51164
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

On Fri, Jan 15, 2016 at 10:27:14PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 15, 2016 at 09:46:12AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 15, 2016 at 10:13:48AM +0100, Peter Zijlstra wrote:
> 
> > > And the stuff we're confused about is how best to express the difference
> > > and guarantees of these two forms of transitivity and how exactly they
> > > interact.
> > 
> > Hoping my memory-barrier.txt patch helps here...
> 
> Yes, that seems a good start. But yesterday you raised the 'fun' point
> of two globally ordered sequences connected by a single local link.

The conclusion that I am slowly coming to is that litmus tests should
not be thought of as linear chains, but rather as cycles.  If you think
of it as a cycle, then it doesn't matter where the local link is, just
how many of them and how they are connected.

But I will admit that there are some rather strange litmus tests that
challenge this cycle-centric view, for example, the one shown below.
It turns out that herd and ppcmem disagree on the outcome.  (The Power
architects side with ppcmem.)

> And I think I'm still confused on LWSYNC (in the smp_wmb case) when one
> of the stores looses a conflict, and if that scenario matters. If it
> does, we should inspect the same case for other barriers.

Indeed.  I am still working on how these should be described.  My
current thought is to be quite conservative on what ordering is
actually respected, however, the current task is formalizing how
RCU plays with the rest of the memory model.

							Thanx, Paul

------------------------------------------------------------------------

PPC Overlapping Group-B sets version 4
""
(* When the Group-B sets from two different barriers involve instructions in
   the same thread, within that thread one set must contain the other.

	P0	P1	P2
	Rx=1	Wy=1	Wz=2
	dep.	lwsync	lwsync
	Ry=0	Wz=1	Wx=1
	Rz=1

	assert(!(z=2))

   Forbidden by ppcmem, allowed by herd.
*)
{
0:r1=x; 0:r2=y; 0:r3=z;
1:r1=x; 1:r2=y; 1:r3=z; 1:r4=1;
2:r1=x; 2:r2=y; 2:r3=z; 2:r4=1; 2:r5=2;
}
 P0		| P1		| P2		;
 lwz r6,0(r1)	| stw r4,0(r2)	| stw r5,0(r3)	;
 xor r7,r6,r6	| lwsync	| lwsync	;
 lwzx r7,r7,r2	| stw r4,0(r3)	| stw r4,0(r1)	;
 lwz r8,0(r3)	|		|		;

exists
(z=2 /\ 0:r6=1 /\ 0:r7=0 /\ 0:r8=1)
