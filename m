Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 12:11:14 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:39783 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009437AbcAKLLHVL3-e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2016 12:11:07 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 1E9988DFEA;
        Mon, 11 Jan 2016 11:11:04 +0000 (UTC)
Received: from redhat.com (vpn1-6-10.ams2.redhat.com [10.36.6.10])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0BBAtUG029399;
        Mon, 11 Jan 2016 06:10:56 -0500
Date:   Mon, 11 Jan 2016 13:10:54 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
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
        Davidlohr Bueso <dbueso@suse.de>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 20/32] metag: define __smp_xxx
Message-ID: <20160111131001-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
 <20160105000929.GM17861@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160105000929.GM17861@jhogan-linux.le.imgtec.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51060
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

On Tue, Jan 05, 2016 at 12:09:30AM +0000, James Hogan wrote:
> Hi Michael,
> 
> On Thu, Dec 31, 2015 at 09:08:22PM +0200, Michael S. Tsirkin wrote:
> > This defines __smp_xxx barriers for metag,
> > for use by virtualization.
> > 
> > smp_xxx barriers are removed as they are
> > defined correctly by asm-generic/barriers.h
> > 
> > Note: as __smp_XX macros should not depend on CONFIG_SMP, they can not
> > use the existing fence() macro since that is defined differently between
> > SMP and !SMP.  For this reason, this patch introduces a wrapper
> > metag_fence() that doesn't depend on CONFIG_SMP.
> > fence() is then defined using that, depending on CONFIG_SMP.
> 
> I'm not a fan of the inconsistent commit message wrapping. I wrap to 72
> columns (although I now notice SubmittingPatches says to use 75...).
> 
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/metag/include/asm/barrier.h | 32 +++++++++++++++-----------------
> >  1 file changed, 15 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/barrier.h
> > index b5b778b..84880c9 100644
> > --- a/arch/metag/include/asm/barrier.h
> > +++ b/arch/metag/include/asm/barrier.h
> > @@ -44,13 +44,6 @@ static inline void wr_fence(void)
> >  #define rmb()		barrier()
> >  #define wmb()		mb()
> >  
> > -#ifndef CONFIG_SMP
> > -#define fence()		do { } while (0)
> > -#define smp_mb()        barrier()
> > -#define smp_rmb()       barrier()
> > -#define smp_wmb()       barrier()
> > -#else
> 
> !SMP kernel text differs, but only because of new presence of unused
> metag_fence() inline function. If I #if 0 that out, then it matches, so
> thats fine.
> 
> > -
> >  #ifdef CONFIG_METAG_SMP_WRITE_REORDERING
> >  /*
> >   * Write to the atomic memory unlock system event register (command 0). This is
> > @@ -60,26 +53,31 @@ static inline void wr_fence(void)
> >   * incoherence). It is therefore ineffective if used after and on the same
> >   * thread as a write.
> >   */
> > -static inline void fence(void)
> > +static inline void metag_fence(void)
> >  {
> >  	volatile int *flushptr = (volatile int *) LINSYSEVENT_WR_ATOMIC_UNLOCK;
> >  	barrier();
> >  	*flushptr = 0;
> >  	barrier();
> >  }
> > -#define smp_mb()        fence()
> > -#define smp_rmb()       fence()
> > -#define smp_wmb()       barrier()
> > +#define __smp_mb()        metag_fence()
> > +#define __smp_rmb()       metag_fence()
> > +#define __smp_wmb()       barrier()
> >  #else
> > -#define fence()		do { } while (0)
> > -#define smp_mb()        barrier()
> > -#define smp_rmb()       barrier()
> > -#define smp_wmb()       barrier()
> > +#define metag_fence()		do { } while (0)
> > +#define __smp_mb()        barrier()
> > +#define __smp_rmb()       barrier()
> > +#define __smp_wmb()       barrier()
> 
> Whitespace is now messed up. Admitedly its already inconsistent
> tabs/spaces, but it'd be nice if the definitions at least still all
> lined up. You're touching all the definitions which use spaces anyway,
> so feel free to convert them to tabs while you're at it.
> 
> Other than those niggles, it looks sensible to me:
> Acked-by: James Hogan <james.hogan@imgtec.com>
> 
> Cheers
> James

Thanks!

I did this in my tree (replaced spaces with tabs in the new
definitions); not reposting just because of this change.

> >  #endif
> > +
> > +#ifdef CONFIG_SMP
> > +#define fence() metag_fence()
> > +#else
> > +#define fence()		do { } while (0)
> >  #endif
> >  
> > -#define smp_mb__before_atomic()	barrier()
> > -#define smp_mb__after_atomic()	barrier()
> > +#define __smp_mb__before_atomic()	barrier()
> > +#define __smp_mb__after_atomic()	barrier()
> >  
> >  #include <asm-generic/barrier.h>
> >  
> > -- 
> > MST
> > 
