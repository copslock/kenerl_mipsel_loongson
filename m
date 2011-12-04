Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2011 23:43:39 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:59030 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903649Ab1LDWnd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Dec 2011 23:43:33 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pB4MfwWn026726;
        Sun, 4 Dec 2011 16:41:59 -0600
Message-ID: <1323038515.11728.26.camel@pasglop>
Subject: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Sven Eckelmann <sven@narfation.org>,
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
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Mon, 05 Dec 2011 09:41:55 +1100
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
         <20111204213316.GB14542@n2100.arm.linux.org.uk>
         <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
         <20111204221850.GC14542@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.1- 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 32026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2749

On Sun, 2011-12-04 at 22:18 +0000, Russell King - ARM Linux wrote:

 .../...

> And really, I believe it would be a good cleanup if all the standard
> definitions for atomic64 ops (like atomic64_add_negative) were also
> defined in include/linux/atomic.h rather than individually in every
> atomic*.h header throughout the kernel source, except where an arch
> wants to explicitly override it.  Yet again, virtually all architectures
> define these in exactly the same way.
> 
> We have more than enough code in arch/ for any architecture to worry
> about, we don't need schemes to add more when there's simple and
> practical solutions to avoiding doing so if the right design were
> chosen (preferably from the outset.)
> 
> So, I'm not going to offer my ack for a change which I don't believe
> is the correct approach.

I agree with Russell, his approach is a lot easier to maintain long run,
we should even consider converting existing definitions.

Cheers,
Ben.
