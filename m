Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 21:13:06 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:58962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014665AbcADUNBvrgVy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 21:13:01 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 1D422AB118;
        Mon,  4 Jan 2016 20:12:58 +0000 (UTC)
Received: from redhat.com (vpn1-5-48.ams2.redhat.com [10.36.5.48])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u04KCmr2003127;
        Mon, 4 Jan 2016 15:12:49 -0500
Date:   Mon, 4 Jan 2016 22:12:47 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20160104220938-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-18-git-send-email-mst@redhat.com>
 <20160102112438.GU8644@n2100.arm.linux.org.uk>
 <20160103110158-mutt-send-email-mst@redhat.com>
 <20160104133658.GY6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160104133658.GY6344@twins.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50877
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

My take out from discussion with you was that virtualization is probably
the only valid use-case.  So at David Miller's suggestion there's a
patch later in the series that adds virt_xxxx wrappers and these are
then used by virtio xen and later maybe others.

> And I suppose most of virtio would actually be modules, so you cannot do
> what I did with preempt_enable_no_resched() either.
> 
> But yes, it would be good to limit the use of these things.

Right so the trick is checkpatch warns about use of
__smp_xxx and hopefully people are not crazy enough
to use virt_xxx variants for non-virtual drivers.

-- 
MST
