Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 09:13:33 +0100 (CET)
Received: from e06smtp08.uk.ibm.com ([195.75.94.104]:40803 "EHLO
        e06smtp08.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008357AbcAEINa4jX00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 09:13:30 +0100
Received: from localhost
        by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <schwidefsky@de.ibm.com>;
        Tue, 5 Jan 2016 08:13:25 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp08.uk.ibm.com (192.168.101.138) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 5 Jan 2016 08:13:24 -0000
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: schwidefsky@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B27CB219004D
        for <linux-mips@linux-mips.org>; Tue,  5 Jan 2016 08:13:13 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com [9.149.37.252])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u058DNdT8716644
        for <linux-mips@linux-mips.org>; Tue, 5 Jan 2016 08:13:23 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u058DLF9013820
        for <linux-mips@linux-mips.org>; Tue, 5 Jan 2016 01:13:23 -0700
Received: from mschwide (dyn-9-152-212-43.boeblingen.de.ibm.com [9.152.212.43])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u058DLwT013799;
        Tue, 5 Jan 2016 01:13:21 -0700
Date:   Tue, 5 Jan 2016 09:13:19 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
        xen-devel@lists.xenproject.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 22/32] s390: define __smp_xxx
Message-ID: <20160105091319.59ddefc7@mschwide>
In-Reply-To: <20160104221323-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
        <1451572003-2440-23-git-send-email-mst@redhat.com>
        <20160104134525.GA6344@twins.programming.kicks-ass.net>
        <20160104221323-mutt-send-email-mst@redhat.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16010508-0033-0000-0000-0000054A6C10
Return-Path: <schwidefsky@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwidefsky@de.ibm.com
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

On Mon, 4 Jan 2016 22:18:58 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jan 04, 2016 at 02:45:25PM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 31, 2015 at 09:08:38PM +0200, Michael S. Tsirkin wrote:
> > > This defines __smp_xxx barriers for s390,
> > > for use by virtualization.
> > > 
> > > Some smp_xxx barriers are removed as they are
> > > defined correctly by asm-generic/barriers.h
> > > 
> > > Note: smp_mb, smp_rmb and smp_wmb are defined as full barriers
> > > unconditionally on this architecture.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/s390/include/asm/barrier.h | 15 +++++++++------
> > >  1 file changed, 9 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> > > index c358c31..fbd25b2 100644
> > > --- a/arch/s390/include/asm/barrier.h
> > > +++ b/arch/s390/include/asm/barrier.h
> > > @@ -26,18 +26,21 @@
> > >  #define wmb()				barrier()
> > >  #define dma_rmb()			mb()
> > >  #define dma_wmb()			mb()
> > > -#define smp_mb()			mb()
> > > -#define smp_rmb()			rmb()
> > > -#define smp_wmb()			wmb()
> > > -
> > > -#define smp_store_release(p, v)						\
> > > +#define __smp_mb()			mb()
> > > +#define __smp_rmb()			rmb()
> > > +#define __smp_wmb()			wmb()
> > > +#define smp_mb()			__smp_mb()
> > > +#define smp_rmb()			__smp_rmb()
> > > +#define smp_wmb()			__smp_wmb()
> > 
> > Why define the smp_*mb() primitives here? Would not the inclusion of
> > asm-generic/barrier.h do this?
> 
> No because the generic one is a nop on !SMP, this one isn't.
> 
> Pls note this patch is just reordering code without making
> functional changes.
> And at the moment, on s390 smp_xxx barriers are always non empty.

The s390 kernel is SMP to 99.99%, we just didn't bother with a
non-smp variant for the memory-barriers. If the generic header
is used we'd get the non-smp version for free. It will save a
small amount of text space for CONFIG_SMP=n. 
 
> Some of this could be sub-optimal, but
> since on s390 Linux always runs on a hypervisor,
> I am not sure it's safe to use the generic version -
> in other words, it just might be that for s390 smp_ and virt_
> barriers must be equivalent.

The definition of the memory barriers is independent from the fact
if the system is running on an hypervisor or not. Is there really
an architecture where you need special virt_xxx barriers?!? 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
