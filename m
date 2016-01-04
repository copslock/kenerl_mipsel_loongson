Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 21:43:01 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:60498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009752AbcADUm7g194Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 21:42:59 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (Postfix) with ESMTPS id 48AF2461C8;
        Mon,  4 Jan 2016 20:42:53 +0000 (UTC)
Received: from redhat.com (vpn1-5-48.ams2.redhat.com [10.36.5.48])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u04KgjRf004990;
        Mon, 4 Jan 2016 15:42:46 -0500
Date:   Mon, 4 Jan 2016 22:42:44 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
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
        Andrey Konovalov <andreyknvl@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 06/32] s390: reuse asm-generic/barrier.h
Message-ID: <20160104224135-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-7-git-send-email-mst@redhat.com>
 <20160104132042.GW6344@twins.programming.kicks-ass.net>
 <20160104160339.25101b5d@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160104160339.25101b5d@mschwide>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50884
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

On Mon, Jan 04, 2016 at 04:03:39PM +0100, Martin Schwidefsky wrote:
> On Mon, 4 Jan 2016 14:20:42 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Dec 31, 2015 at 09:06:30PM +0200, Michael S. Tsirkin wrote:
> > > On s390 read_barrier_depends, smp_read_barrier_depends
> > > smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
> > > asm-generic variants exactly. Drop the local definitions and pull in
> > > asm-generic/barrier.h instead.
> > > 
> > > This is in preparation to refactoring this code area.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/s390/include/asm/barrier.h | 10 ++--------
> > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> > > index 7ffd0b1..c358c31 100644
> > > --- a/arch/s390/include/asm/barrier.h
> > > +++ b/arch/s390/include/asm/barrier.h
> > > @@ -30,14 +30,6 @@
> > >  #define smp_rmb()			rmb()
> > >  #define smp_wmb()			wmb()
> > >  
> > > -#define read_barrier_depends()		do { } while (0)
> > > -#define smp_read_barrier_depends()	do { } while (0)
> > > -
> > > -#define smp_mb__before_atomic()		smp_mb()
> > > -#define smp_mb__after_atomic()		smp_mb()
> > 
> > As per:
> > 
> >   lkml.kernel.org/r/20150921112252.3c2937e1@mschwide
> > 
> > s390 should change this to barrier() instead of smp_mb() and hence
> > should not use the generic versions.
>  
> Yes, we wanted to simplify this. Thanks for the reminder, I'll queue
> a patch.

Could you base on my patchset maybe, to avoid conflicts,
and I'll merge it?
Or if it's just replacing these 2 with barrier() I can do this
myself easily.

> -- 
> blue skies,
>    Martin.
> 
> "Reality continues to ruin my life." - Calvin.
