Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 21:19:11 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:60218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009731AbcADUTIzrJsy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 21:19:08 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 9A4B88F26B;
        Mon,  4 Jan 2016 20:19:06 +0000 (UTC)
Received: from redhat.com (vpn1-5-48.ams2.redhat.com [10.36.5.48])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u04KIwn0006260;
        Mon, 4 Jan 2016 15:18:59 -0500
Date:   Mon, 4 Jan 2016 22:18:58 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
        xen-devel@lists.xenproject.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 22/32] s390: define __smp_xxx
Message-ID: <20160104221323-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-23-git-send-email-mst@redhat.com>
 <20160104134525.GA6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160104134525.GA6344@twins.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50878
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

On Mon, Jan 04, 2016 at 02:45:25PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 31, 2015 at 09:08:38PM +0200, Michael S. Tsirkin wrote:
> > This defines __smp_xxx barriers for s390,
> > for use by virtualization.
> > 
> > Some smp_xxx barriers are removed as they are
> > defined correctly by asm-generic/barriers.h
> > 
> > Note: smp_mb, smp_rmb and smp_wmb are defined as full barriers
> > unconditionally on this architecture.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/include/asm/barrier.h | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> > index c358c31..fbd25b2 100644
> > --- a/arch/s390/include/asm/barrier.h
> > +++ b/arch/s390/include/asm/barrier.h
> > @@ -26,18 +26,21 @@
> >  #define wmb()				barrier()
> >  #define dma_rmb()			mb()
> >  #define dma_wmb()			mb()
> > -#define smp_mb()			mb()
> > -#define smp_rmb()			rmb()
> > -#define smp_wmb()			wmb()
> > -
> > -#define smp_store_release(p, v)						\
> > +#define __smp_mb()			mb()
> > +#define __smp_rmb()			rmb()
> > +#define __smp_wmb()			wmb()
> > +#define smp_mb()			__smp_mb()
> > +#define smp_rmb()			__smp_rmb()
> > +#define smp_wmb()			__smp_wmb()
> 
> Why define the smp_*mb() primitives here? Would not the inclusion of
> asm-generic/barrier.h do this?

No because the generic one is a nop on !SMP, this one isn't.

Pls note this patch is just reordering code without making
functional changes.
And at the moment, on s390 smp_xxx barriers are always non empty.

Some of this could be sub-optimal, but
since on s390 Linux always runs on a hypervisor,
I am not sure it's safe to use the generic version -
in other words, it just might be that for s390 smp_ and virt_
barriers must be equivalent.

If in fact this turns out to be wrong, I can pick up
a patch to change this, but I'd rather make this
a patch on top so that my patches are testable
just by compiling and comparing the binary.

-- 
MST
