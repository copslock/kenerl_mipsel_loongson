Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 14:54:34 +0100 (CET)
Received: from bombadil.infradead.org ([198.137.202.9]:54592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008336AbcADNydKEznn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 14:54:33 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aG5aY-0004oe-Gq; Mon, 04 Jan 2016 13:54:22 +0000
Received: by twins (Postfix, from userid 1000)
        id 36C0D1257A0D8; Mon,  4 Jan 2016 14:54:20 +0100 (CET)
Date:   Mon, 4 Jan 2016 14:54:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
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
Message-ID: <20160104135420.GS6373@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-18-git-send-email-mst@redhat.com>
 <20160102112438.GU8644@n2100.arm.linux.org.uk>
 <20160103110158-mutt-send-email-mst@redhat.com>
 <20160104133658.GY6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160104133658.GY6344@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50849
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

On Mon, Jan 04, 2016 at 02:36:58PM +0100, Peter Zijlstra wrote:
> On Sun, Jan 03, 2016 at 11:12:44AM +0200, Michael S. Tsirkin wrote:
> > On Sat, Jan 02, 2016 at 11:24:38AM +0000, Russell King - ARM Linux wrote:
> 
> > > My only concern is that it gives people an additional handle onto a
> > > "new" set of barriers - just because they're prefixed with __*
> > > unfortunately doesn't stop anyone from using it (been there with
> > > other arch stuff before.)
> > > 
> > > I wonder whether we should consider making the smp memory barriers
> > > inline functions, so these __smp_xxx() variants can be undef'd
> > > afterwards, thereby preventing drivers getting their hands on these
> > > new macros?
> > 
> > That'd be tricky to do cleanly since asm-generic depends on
> > ifndef to add generic variants where needed.
> > 
> > But it would be possible to add a checkpatch test for this.
> 
> Wasn't the whole purpose of these things for 'drivers' (namely
> virtio/xen hypervisor interaction) to use these?

Ah, I see, you add virt_*mb() stuff later on for that use case.

So, assuming everybody does include asm-generic/barrier.h, you could
simply #undef the __smp version at the end of that, once we've generated
all the regular primitives from it, no?
