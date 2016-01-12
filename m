Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 10:52:14 +0100 (CET)
Received: from bombadil.infradead.org ([198.137.202.9]:51343 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009116AbcALJwMK0YvM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jan 2016 10:52:12 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aIvc5-0007Uj-GI; Tue, 12 Jan 2016 09:51:41 +0000
Received: by twins (Postfix, from userid 1000)
        id D7B5D1257A0D8; Tue, 12 Jan 2016 10:51:38 +0100 (CET)
Date:   Tue, 12 Jan 2016 10:51:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160112095138.GQ6344@twins.programming.kicks-ass.net>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112103913-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160112103913-mutt-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51070
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

On Tue, Jan 12, 2016 at 10:43:36AM +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 11, 2016 at 05:14:14PM -0800, Leonid Yegoshin wrote:
> > On 01/10/2016 06:18 AM, Michael S. Tsirkin wrote:
> > >On mips dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
> > >smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
> > >the asm-generic variants exactly. Drop the local definitions and pull in
> > >asm-generic/barrier.h instead.
> > >
> > This statement doesn't fit MIPS barriers variations. Moreover, there is a
> > reason to extend that even more specific, at least for smp_store_release and
> > smp_load_acquire, look into
> > 
> >     http://patchwork.linux-mips.org/patch/10506/
> > 
> > - Leonid.
> 
> Fine, but it matches what current code is doing.  Since that
> MIPS_LIGHTWEIGHT_SYNC patch didn't go into linux-next yet, do
> you see a problem reworking it on top of this patchset?

That patch is a complete doorstop atm. It needs a lot more work before
it can go anywhere. Don't worry about it.
