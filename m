Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 23:08:35 +0100 (CET)
Received: from e31.co.us.ibm.com ([32.97.110.149]:59696 "EHLO
        e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009997AbcAOWIcL0YV3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 23:08:32 +0100
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 15 Jan 2016 15:08:25 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 15 Jan 2016 15:08:22 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 470C91FF0042;
        Fri, 15 Jan 2016 14:56:32 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0FM8LiI25952410;
        Fri, 15 Jan 2016 15:08:21 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0FM8AON020880;
        Fri, 15 Jan 2016 15:08:21 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0FM88EN020828;
        Fri, 15 Jan 2016 15:08:09 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B708316C0C3B; Fri, 15 Jan 2016 14:01:47 -0800 (PST)
Date:   Fri, 15 Jan 2016 14:01:47 -0800
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
Message-ID: <20160115220147.GD3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115173912.GU3818@linux.vnet.ibm.com>
 <20160115212912.GN3421@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115212912.GN3421@worktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011522-8236-0000-0000-0000153AE460
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51165
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

On Fri, Jan 15, 2016 at 10:29:12PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 15, 2016 at 09:39:12AM -0800, Paul E. McKenney wrote:
> > Should we start putting litmus tests for the various examples
> > somewhere, perhaps in a litmus-tests directory within each participating
> > architecture?  I have a pile of powerpc-related litmus tests on my laptop,
> > but they probably aren't doing all that much good there.
> 
> Yeah, or a version of them in C that we can 'compile'?

That would be good as well.  I am guessing that architecture-specific
litmus tests will also be needed, but you are right that
architecture-independent versions are higher priority.

> > commit 2cb4e83a1b5c89c8e39b8a64bd89269d05913e41
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Fri Jan 15 09:30:42 2016 -0800
> > 
> >     documentation: Distinguish between local and global transitivity
> >     
> >     The introduction of smp_load_acquire() and smp_store_release() had
> >     the side effect of introducing a weaker notion of transitivity:
> >     The transitivity of full smp_mb() barriers is global, but that
> >     of smp_store_release()/smp_load_acquire() chains is local.  This
> >     commit therefore introduces the notion of local transitivity and
> >     gives an example.
> >     
> >     Reported-by: Peter Zijlstra <peterz@infradead.org>
> >     Reported-by: Will Deacon <will.deacon@arm.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> I think it fails to mention smp_mb__after_release_acquire(), although I
> suspect we didn't actually introduce the primitive yet, which raises the
> point, do we want to?

Well, it is not in v4.4.  I believe that we need good use cases before
we add it.

							Thanx, Paul
