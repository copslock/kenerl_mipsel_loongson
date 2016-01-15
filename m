Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 10:14:00 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:55803 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009050AbcAOJN6TwCUz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 10:13:58 +0100
Received: from [31.161.139.68] (helo=worktop)
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aK0SA-0001eF-CA; Fri, 15 Jan 2016 09:13:54 +0000
Received: by worktop (Postfix, from userid 1000)
        id A55B66E0814; Fri, 15 Jan 2016 10:13:48 +0100 (CET)
Date:   Fri, 15 Jan 2016 10:13:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
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
Message-ID: <20160115091348.GA27936@worktop>
References: <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115085554.GF3421@worktop>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Fri, Jan 15, 2016 at 09:55:54AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 14, 2016 at 01:29:13PM -0800, Paul E. McKenney wrote:
> > So smp_mb() provides transitivity, as do pairs of smp_store_release()
> > and smp_read_acquire(), 
> 
> But they provide different grades of transitivity, which is where all
> the confusion lays.
> 
> smp_mb() is strongly/globally transitive, all CPUs will agree on the order.
> 
> Whereas the RCpc release+acquire is weakly so, only the two cpus
> involved in the handover will agree on the order.

And the stuff we're confused about is how best to express the difference
and guarantees of these two forms of transitivity and how exactly they
interact.

And smp_load_acquire()/smp_store_release() are RCpc because TSO archs
and PPC. the atomic*_{acquire,release}() are RCpc because PPC and
LOCK,UNLOCK are similarly RCpc because of PPC.

Now we'd like PPC to stick a SYNC in either LOCK or UNLOCK so at least
the locks are RCsc again, but they resist for performance reasons but
waver because they don't want to be the ones finding all the nasty bugs
because they're the only one.

Now the thing I worry about, and still have not had an answer to is if
weakly ordered MIPS will end up being RCsc or RCpc for their locks if
they get implemented with SYNC_ACQUIRE and SYNC_RELEASE instead of the
current SYNC.
