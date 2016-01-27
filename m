Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 09:39:27 +0100 (CET)
Received: from bombadil.infradead.org ([198.137.202.9]:45667 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010139AbcA0IjZrIrsT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 09:39:25 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aOLd6-0001zv-B9; Wed, 27 Jan 2016 08:39:08 +0000
Received: by twins (Postfix, from userid 1000)
        id 02F351257A0D8; Wed, 27 Jan 2016 09:39:06 +0100 (CET)
Date:   Wed, 27 Jan 2016 09:39:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
Message-ID: <20160127083905.GK6357@twins.programming.kicks-ass.net>
References: <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115091348.GA27936@worktop>
 <20160115174612.GV3818@linux.vnet.ibm.com>
 <20160115212714.GM3421@worktop>
 <20160115215853.GC3818@linux.vnet.ibm.com>
 <20160125164242.GF22927@arm.com>
 <20160126060322.GJ4503@linux.vnet.ibm.com>
 <20160126101927.GD6357@twins.programming.kicks-ass.net>
 <20160126201339.GW4503@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126201339.GW4503@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51459
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

On Tue, Jan 26, 2016 at 12:13:39PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 26, 2016 at 11:19:27AM +0100, Peter Zijlstra wrote:

> > So isn't smp_mb__after_unlock_lock() exactly such a scenario? And would
> > not someone trying to implement RCsc locks using locally transitive
> > RELEASE/ACQUIRE operations need exactly this stuff?
> > 
> > That is, I am afraid we need to cover the mix of local and global
> > transitive operations at least in overview.
> 
> True, but we haven't gotten to locking yet.

The mythical smp_mb__after_release_acquire() then ;-)

(and yes, I know you're going to say we don't have that)

> That said, I would argue
> that smp_mb__after_unlock_lock() upgrades locks to transitive, and
> thus would not be an exception to the "no combining transitive and
> non-transitive steps in cycles" rule.

But But But ;-) It does that exactly by combining. I suspect this is
(partly) the source of your SC chains with one PC link example.
