Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 18:53:29 +0100 (CET)
Received: from e33.co.us.ibm.com ([32.97.110.151]:33237 "EHLO
        e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009986AbcAORx02GJxJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 18:53:26 +0100
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 15 Jan 2016 10:53:19 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 15 Jan 2016 10:53:16 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 760521FF004B;
        Fri, 15 Jan 2016 10:41:26 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0FHrGos28049610;
        Fri, 15 Jan 2016 10:53:16 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0FHr607008460;
        Fri, 15 Jan 2016 10:53:15 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0FHr5sU008380;
        Fri, 15 Jan 2016 10:53:06 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 285A316C0BB3; Fri, 15 Jan 2016 09:46:12 -0800 (PST)
Date:   Fri, 15 Jan 2016 09:46:12 -0800
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
Message-ID: <20160115174612.GV3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115091348.GA27936@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115091348.GA27936@worktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011517-0009-0000-0000-000011741499
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51154
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

On Fri, Jan 15, 2016 at 10:13:48AM +0100, Peter Zijlstra wrote:
> On Fri, Jan 15, 2016 at 09:55:54AM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 14, 2016 at 01:29:13PM -0800, Paul E. McKenney wrote:
> > > So smp_mb() provides transitivity, as do pairs of smp_store_release()
> > > and smp_read_acquire(), 
> > 
> > But they provide different grades of transitivity, which is where all
> > the confusion lays.
> > 
> > smp_mb() is strongly/globally transitive, all CPUs will agree on the order.
> > 
> > Whereas the RCpc release+acquire is weakly so, only the two cpus
> > involved in the handover will agree on the order.
> 
> And the stuff we're confused about is how best to express the difference
> and guarantees of these two forms of transitivity and how exactly they
> interact.

Hoping my memory-barrier.txt patch helps here...

> And smp_load_acquire()/smp_store_release() are RCpc because TSO archs
> and PPC. the atomic*_{acquire,release}() are RCpc because PPC and
> LOCK,UNLOCK are similarly RCpc because of PPC.
> 
> Now we'd like PPC to stick a SYNC in either LOCK or UNLOCK so at least
> the locks are RCsc again, but they resist for performance reasons but
> waver because they don't want to be the ones finding all the nasty bugs
> because they're the only one.

I believe that the relevant proverb said something about starving to
death between two bales of hay...  ;-)

> Now the thing I worry about, and still have not had an answer to is if
> weakly ordered MIPS will end up being RCsc or RCpc for their locks if
> they get implemented with SYNC_ACQUIRE and SYNC_RELEASE instead of the
> current SYNC.

It would be good to have better clarity on this, no two ways about it.

							Thanx, Paul
