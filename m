Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 00:37:52 +0100 (CET)
Received: from e33.co.us.ibm.com ([32.97.110.151]:34362 "EHLO
        e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010860AbcAZXhufqr23 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 00:37:50 +0100
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jan 2016 16:37:43 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 26 Jan 2016 16:37:32 -0700
X-IBM-Helo: d03dlp02.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 338153E4003F;
        Tue, 26 Jan 2016 16:37:32 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0QNbWGX19988582;
        Tue, 26 Jan 2016 16:37:32 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0QNbOlT028828;
        Tue, 26 Jan 2016 16:37:31 -0700
Received: from paulmck-ThinkPad-W541 (paulmck-thinkpad-w541.au.ibm.com [9.192.250.130])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0QNbLXh028655;
        Tue, 26 Jan 2016 16:37:22 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8615116C11B1; Tue, 26 Jan 2016 15:37:33 -0800 (PST)
Date:   Tue, 26 Jan 2016 15:37:33 -0800
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
Message-ID: <20160126233733.GZ4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <20160115102431.GB2131@arm.com>
 <20160115175401.GW3818@linux.vnet.ibm.com>
 <20160115192845.GA12510@linux.vnet.ibm.com>
 <20160125144133.GB22927@arm.com>
 <20160126010646.GH4503@linux.vnet.ibm.com>
 <20160126121010.GD21553@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126121010.GD21553@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16012623-0009-0000-0000-000011C74221
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51444
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

On Tue, Jan 26, 2016 at 12:10:10PM +0000, Will Deacon wrote:
> On Mon, Jan 25, 2016 at 05:06:46PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 25, 2016 at 02:41:34PM +0000, Will Deacon wrote:
> > > On Fri, Jan 15, 2016 at 11:28:45AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Jan 15, 2016 at 09:54:01AM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Jan 15, 2016 at 10:24:32AM +0000, Will Deacon wrote:
> > > > > > See my earlier reply [1] (but also, your WRC Linux example looks more
> > > > > > like a variant on WWC and I couldn't really follow it).
> > > > > 
> > > > > I will revisit my WRC Linux example.  And yes, creating litmus tests
> > > > > that use non-fake dependencies is still a bit of an undertaking.  :-/
> > > > > I am sure that it will seem more natural with time and experience...
> > > > 
> > > > Hmmm...  You are quite right, I did do WWC.  I need to change cpu2()'s
> > > > last access from a store to a load to get WRC.  Plus the levels of
> > > > indirection definitely didn't match up, did they?
> > > 
> > > Nope, it was pretty baffling!
> > 
> > "It is a service that I provide."  ;-)
> > 
> > > > 	struct foo {
> > > > 		struct foo *next;
> > > > 	};
> > > > 	struct foo a;
> > > > 	struct foo b;
> > > > 	struct foo c = { &a };
> > > > 	struct foo d = { &b };
> > > > 	struct foo x = { &c };
> > > > 	struct foo y = { &d };
> > > > 	struct foo *r1, *r2, *r3;
> > > > 
> > > > 	void cpu0(void)
> > > > 	{
> > > > 		WRITE_ONCE(x.next, &y);
> > > > 	}
> > > > 
> > > > 	void cpu1(void)
> > > > 	{
> > > > 		r1 = lockless_dereference(x.next);
> > > > 		WRITE_ONCE(r1->next, &x);
> > > > 	}
> > > > 
> > > > 	void cpu2(void)
> > > > 	{
> > > > 		r2 = lockless_dereference(y.next);
> > > > 		r3 = READ_ONCE(r2->next);
> > > > 	}
> > > > 
> > > > In this case, it is legal to end the run with:
> > > > 
> > > > 	r1 == &y && r2 == &x && r3 == &c
> > > > 
> > > > Please see below for a ppcmem litmus test.
> > > > 
> > > > So, did I get it right this time?  ;-)
> > > 
> > > The code above looks correct to me (in that it matches WRC+addrs),
> > > but your litmus test:
> > > 
> > > > PPC WRCnf+addrs
> > > > ""
> > > > {
> > > > 0:r2=x; 0:r3=y;
> > > > 1:r2=x; 1:r3=y;
> > > > 2:r2=x; 2:r3=y;
> > > > c=a; d=b; x=c; y=d;
> > > > }
> > > >  P0           | P1            | P2            ;
> > > >  stw r3,0(r2) | lwz r8,0(r2)  | lwz r8,0(r3)  ;
> > > >               | stw r2,0(r3)  | lwz r9,0(r8)  ;
> > > > exists
> > > > (1:r8=y /\ 2:r8=x /\ 2:r9=c)
> > > 
> > > Seems to be missing the address dependency on P1.
> > 
> > You are quite correct!  How about the following?
> 
> I think that's it!
> 
> > As before, both herd and ppcmem say that the cycle is allowed, as
> > expected, given non-transitive ordering.  To prohibit the cycle, P1
> > needs a suitable memory-barrier instruction.
> > 
> > ------------------------------------------------------------------------
> > 
> > PPC WRCnf+addrs
> > ""
> > {
> > 0:r2=x; 0:r3=y;
> > 1:r2=x; 1:r3=y;
> > 2:r2=x; 2:r3=y;
> > c=a; d=b; x=c; y=d;
> > }
> >  P0           | P1            | P2            ;
> >  stw r3,0(r2) | lwz r8,0(r2)  | lwz r8,0(r3)  ;
> >               | stw r2,0(r8)  | lwz r9,0(r8)  ;
> > exists
> > (1:r8=y /\ 2:r8=x /\ 2:r9=c)
> 
> Agreed.

OK, thank you!  Would you agree that it would be good to replace the
current xor-based fake-dependency litmus tests with tests having real
dependencies?

							Thanx, Paul
