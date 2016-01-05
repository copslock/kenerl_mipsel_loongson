Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 15:39:08 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:57391 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009780AbcAEOjHSPMku (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2016 15:39:07 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id D8B3342E5C8;
        Tue,  5 Jan 2016 14:39:03 +0000 (UTC)
Received: from redhat.com (vpn1-5-187.ams2.redhat.com [10.36.5.187])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u05Ecthg031167;
        Tue, 5 Jan 2016 09:38:56 -0500
Date:   Tue, 5 Jan 2016 16:38:54 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 17/32] arm: define __smp_xxx
Message-ID: <20160105163429-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-18-git-send-email-mst@redhat.com>
 <20160102112438.GU8644@n2100.arm.linux.org.uk>
 <20160103110158-mutt-send-email-mst@redhat.com>
 <20160104133658.GY6344@twins.programming.kicks-ass.net>
 <20160104135420.GS6373@twins.programming.kicks-ass.net>
 <20160104135934.GE19062@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160104135934.GE19062@n2100.arm.linux.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

On Mon, Jan 04, 2016 at 01:59:34PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2016 at 02:54:20PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 04, 2016 at 02:36:58PM +0100, Peter Zijlstra wrote:
> > > On Sun, Jan 03, 2016 at 11:12:44AM +0200, Michael S. Tsirkin wrote:
> > > > On Sat, Jan 02, 2016 at 11:24:38AM +0000, Russell King - ARM Linux wrote:
> > > 
> > > > > My only concern is that it gives people an additional handle onto a
> > > > > "new" set of barriers - just because they're prefixed with __*
> > > > > unfortunately doesn't stop anyone from using it (been there with
> > > > > other arch stuff before.)
> > > > > 
> > > > > I wonder whether we should consider making the smp memory barriers
> > > > > inline functions, so these __smp_xxx() variants can be undef'd
> > > > > afterwards, thereby preventing drivers getting their hands on these
> > > > > new macros?
> > > > 
> > > > That'd be tricky to do cleanly since asm-generic depends on
> > > > ifndef to add generic variants where needed.
> > > > 
> > > > But it would be possible to add a checkpatch test for this.
> > > 
> > > Wasn't the whole purpose of these things for 'drivers' (namely
> > > virtio/xen hypervisor interaction) to use these?
> > 
> > Ah, I see, you add virt_*mb() stuff later on for that use case.
> > 
> > So, assuming everybody does include asm-generic/barrier.h, you could
> > simply #undef the __smp version at the end of that, once we've generated
> > all the regular primitives from it, no?
> 
> Not so simple - that's why I mentioned using inline functions.
> 
> The new smp_* _macros_ are:
> 
> +#define smp_mb()       __smp_mb()
> 
> which means if we simply #undef __smp_mb(), smp_mb() then points at
> something which is no longer available, and we'll end up with errors
> saying that __smp_mb() doesn't exist.
> 
> My suggestion was to change:
> 
> #ifndef smp_mb
> #define smp_mb()	__smp_mb()
> #endif
> 
> to:
> 
> #ifndef smp_mb
> static inline void smp_mb(void)
> {
> 	__smp_mb();
> }
> #endif
> 
> which then means __smp_mb() and friends can be #undef'd afterwards.

Absolutely, I got it.
The issue is that e.g. tile has:
#define __smp_mb__after_atomic()        do { } while (0)

and this is cheaper than barrier().

For this reason I left
#define smp_mb__after_atomic()  __smp_mb__after_atomic()
in place there.

Now, of course I can do (in asm-generic):

#ifndef smp_mb__after_atomic
static inline void smp_mb__after_atomic(void)
{
...
}
#endif

but this seems ugly: architectures do defines, generic
version does inline.


And that is not all: APIs like smp_store_mb can take
a variety of types as arguments so they pretty much
must be implemented as macros.

Teaching checkpatch.pl to complain about it seems like the cleanest
approach.

> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
