Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 09:29:15 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:51060 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903606Ab1LEI3I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Dec 2011 09:29:08 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pB58Qunn015240;
        Mon, 5 Dec 2011 02:26:56 -0600
Message-ID: <1323073615.660.11.camel@pasglop>
Subject: Re: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Randy Dunlap <rdunlap@xenotime.net>,
        Paul Mackerras <paulus@samba.org>,
        Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>,
        Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergma nn <arnd@arndb.de>,
        Jeff Dike <jdike@addtoit.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        linux-m32r@ml.linux-m32r.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.in.fradead.org,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Mon, 05 Dec 2011 19:26:55 +1100
In-Reply-To: <3836467.I5Tqg6MFf9@sven-laptop.home.narfation.org>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
         <20111204221850.GC14542@n2100.arm.linux.org.uk>
         <1323038515.11728.26.camel@pasglop>
         <3836467.I5Tqg6MFf9@sven-laptop.home.narfation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.1- 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 32029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2966

On Mon, 2011-12-05 at 08:57 +0100, Sven Eckelmann wrote:
> On Monday 05 December 2011 09:41:55 Benjamin Herrenschmidt wrote:
> > On Sun, 2011-12-04 at 22:18 +0000, Russell King - ARM Linux wrote:
> > 
> >  .../...
> > 
> > > And really, I believe it would be a good cleanup if all the standard
> > > definitions for atomic64 ops (like atomic64_add_negative) were also
> > > defined in include/linux/atomic.h rather than individually in every
> > > atomic*.h header throughout the kernel source, except where an arch
> > > wants to explicitly override it.  Yet again, virtually all architectures
> > > define these in exactly the same way.
> > > 
> > > We have more than enough code in arch/ for any architecture to worry
> > > about, we don't need schemes to add more when there's simple and
> > > practical solutions to avoiding doing so if the right design were
> > > chosen (preferably from the outset.)
> > > 
> > > So, I'm not going to offer my ack for a change which I don't believe
> > > is the correct approach.
> > 
> > I agree with Russell, his approach is a lot easier to maintain long run,
> > we should even consider converting existing definitions.
> 
> I would rather go with "the existing definitions have to converted" and this 
> means "not by this patch".

Right. I didn't suggest -you- had to do it as a pre-req to your patch.

>  At the moment, the atomic64 stuff exist only as 
> separate generic or arch specific implementation. It is fine that Russell King 
> noticed that people like Arun Sharma did a lot of work to made it true for 
> atomic_t, but atomic64_t is a little bit different right now (at least as I 
> understand it).

Cheers,
Ben.
