Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2011 23:21:23 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34365 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903649Ab1LDWVS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2011 23:21:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PwBbvNY1gkLyVx7MIqMuQ4iIO41bBCwOKq1im/PcvdE=;
        b=ZwkunshBzF6Rw0q/zwfgK9DUsmsyGJY+fJtqvrQEcCeqrkBDFHoFyk+bhbGge/PdpctxMbcT21vOzjbk0w0oZamy3ysky6TWJ/YH/O95qFPhQBsNlImHtDKqmfQrdsrisNb7lEqbyv7PdX0Krh289CJ8HWcCYIN6V2bxU/dZZuA=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:41618)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1RXKOb-0002IJ-0F; Sun, 04 Dec 2011 22:18:53 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1RXKOY-0008Go-To; Sun, 04 Dec 2011 22:18:50 +0000
Date:   Sun, 4 Dec 2011 22:18:50 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        Randy Dunlap <rdunlap@xenotime.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergma nn <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org
Subject: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Message-ID: <20111204221850.GC14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org> <20111204213316.GB14542@n2100.arm.linux.org.uk> <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 32024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2746

On Sun, Dec 04, 2011 at 10:49:10PM +0100, Sven Eckelmann wrote:
> On Sunday 04 December 2011 21:33:16 Russell King - ARM Linux wrote:
> [...]
> > > +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> > 
> > I think this is rather silly - all these definitions are very similar to
> > each other.  Is there really no way to put this into include/linux/atomic.h,
> > maybe as something like:
> > 
> > #ifndef atomic64_dec_not_zero
> > #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> > #endif
> > 
> > and avoid having to add essentially the same definition to 12 individual
> > files?
> > 
> > Architectures which want to override it can do by the following:
> > 
> > #define atomic64_dec_not_zero		atomic64_dec_not_zero
> > 
> > which won't have any effect on C nor asm code.
> 
>  * https://lkml.org/lkml/2011/5/8/15
>  * https://lkml.org/lkml/2011/5/8/16
>  * https://lkml.org/lkml/2011/5/8/321

I don't see any reason in that set of messages _not_ to do what I suggest.
Even on SMP architectures, your:

#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)

makes total sense - and with the adjustments I've suggested it means
that architectures (like x86) can still override it if have a more
optimal way to perform this operation.

Not only that, but we already do this kind of thing in
include/linux/atomic.h for the non-64 bit ops, for example:

#ifndef atomic_inc_unless_negative
static inline int atomic_inc_unless_negative(atomic_t *p)
{
        int v, v1;
        for (v = 0; v >= 0; v = v1) {
                v1 = atomic_cmpxchg(p, v, v + 1);
                if (likely(v1 == v))
                        return 1;
        }
        return 0;
}
#endif

And really, I believe it would be a good cleanup if all the standard
definitions for atomic64 ops (like atomic64_add_negative) were also
defined in include/linux/atomic.h rather than individually in every
atomic*.h header throughout the kernel source, except where an arch
wants to explicitly override it.  Yet again, virtually all architectures
define these in exactly the same way.

We have more than enough code in arch/ for any architecture to worry
about, we don't need schemes to add more when there's simple and
practical solutions to avoiding doing so if the right design were
chosen (preferably from the outset.)

So, I'm not going to offer my ack for a change which I don't believe
is the correct approach.
