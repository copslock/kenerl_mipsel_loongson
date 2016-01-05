Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 10:54:24 +0100 (CET)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35823 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009111AbcAEJyWdcUeh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 10:54:22 +0100
Received: by mail-oi0-f66.google.com with SMTP id e195so8942927oig.2
        for <linux-mips@linux-mips.org>; Tue, 05 Jan 2016 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4WcelTu80cgtRpW9LfXKPNnjGLhaBIIPBrswrqSYvPM=;
        b=SNFKNNu/7++/AIwj0lJNftVtz3v0SFr9KzFQkWvdlYyZVsQPvlNcNRRNVojR95eudb
         Y1RO+f9inM+PjXItrZyZXrcDGGtb03MsuqiNmGhkWvr/jEOv0ajLWbkyCya7K6U5fm36
         YeijP7NPTEgBluWXyo3z2AdsZtnwyZlkSqchZmYs/qdGIPCoQWFpbhrUesQgj9T3CyUr
         azG5NIvu/l4px1kZC582dTVkZBgG5z2GGFIVGSDgQlUH1F5mJPV0eqf46Rv8nFAotB97
         UJSDCShPHd9TdV4W+mC1v/YIEzEF4R1xGhhKLyEvOKNtHVfEwHZ4LounzWd2iIACajQi
         2r0w==
X-Received: by 10.202.73.67 with SMTP id w64mr61326543oia.84.1451987656601;
        Tue, 05 Jan 2016 01:54:16 -0800 (PST)
Received: from localhost ([45.32.128.109])
        by smtp.gmail.com with ESMTPSA id gi5sm36637559obb.6.2016.01.05.01.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 01:54:15 -0800 (PST)
Date:   Tue, 5 Jan 2016 17:53:41 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
        xen-devel@lists.xenproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/32] powerpc: define __smp_xxx
Message-ID: <20160105095341.GA5321@fixme-laptop.cn.ibm.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-16-git-send-email-mst@redhat.com>
 <20160105013648.GA1256@fixme-laptop.cn.ibm.com>
 <20160105085117.GA11858@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160105085117.GA11858@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <boqun.feng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boqun.feng@gmail.com
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

On Tue, Jan 05, 2016 at 10:51:17AM +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 05, 2016 at 09:36:55AM +0800, Boqun Feng wrote:
> > Hi Michael,
> > 
> > On Thu, Dec 31, 2015 at 09:07:42PM +0200, Michael S. Tsirkin wrote:
> > > This defines __smp_xxx barriers for powerpc
> > > for use by virtualization.
> > > 
> > > smp_xxx barriers are removed as they are
> > > defined correctly by asm-generic/barriers.h
> 
> I think this is the part that was missed in review.
> 

Yes, I realized my mistake after reread the series. But smp_lwsync() is
not defined in asm-generic/barriers.h, right?

> > > This reduces the amount of arch-specific boiler-plate code.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/powerpc/include/asm/barrier.h | 24 ++++++++----------------
> > >  1 file changed, 8 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> > > index 980ad0c..c0deafc 100644
> > > --- a/arch/powerpc/include/asm/barrier.h
> > > +++ b/arch/powerpc/include/asm/barrier.h
> > > @@ -44,19 +44,11 @@
> > >  #define dma_rmb()	__lwsync()
> > >  #define dma_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
> > >  
> > > -#ifdef CONFIG_SMP
> > > -#define smp_lwsync()	__lwsync()
> > > +#define __smp_lwsync()	__lwsync()
> > >  
> > 
> > so __smp_lwsync() is always mapped to lwsync, right?
> 
> Yes.
> 
> > > -#define smp_mb()	mb()
> > > -#define smp_rmb()	__lwsync()
> > > -#define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
> > > -#else
> > > -#define smp_lwsync()	barrier()
> > > -
> > > -#define smp_mb()	barrier()
> > > -#define smp_rmb()	barrier()
> > > -#define smp_wmb()	barrier()
> > > -#endif /* CONFIG_SMP */
> > > +#define __smp_mb()	mb()
> > > +#define __smp_rmb()	__lwsync()
> > > +#define __smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
> > >  
> > >  /*
> > >   * This is a barrier which prevents following instructions from being
> > > @@ -67,18 +59,18 @@
> > >  #define data_barrier(x)	\
> > >  	asm volatile("twi 0,%0,0; isync" : : "r" (x) : "memory");
> > >  
> > > -#define smp_store_release(p, v)						\
> > > +#define __smp_store_release(p, v)						\
> > >  do {									\
> > >  	compiletime_assert_atomic_type(*p);				\
> > > -	smp_lwsync();							\
> > > +	__smp_lwsync();							\
> > 
> > , therefore this will emit an lwsync no matter SMP or UP.
> 
> Absolutely. But smp_store_release (without __) will not.
> 
> Please note I did test this: for ppc code before and after
> this patch generates exactly the same binary on SMP and UP.
> 

Yes, you're right, sorry for my mistake...

> 
> > Another thing is that smp_lwsync() may have a third user(other than
> > smp_load_acquire() and smp_store_release()):
> > 
> > http://article.gmane.org/gmane.linux.ports.ppc.embedded/89877
> > 
> > I'm OK to change my patch accordingly, but do we really want
> > smp_lwsync() get involved in this cleanup? If I understand you
> > correctly, this cleanup focuses on external API like smp_{r,w,}mb(),
> > while smp_lwsync() is internal to PPC.
> > 
> > Regards,
> > Boqun
> 
> I think you missed the leading ___ :)
> 

What I mean here was smp_lwsync() was originally internal to PPC, but
never mind ;-)

> smp_store_release is external and it needs __smp_lwsync as
> defined here.
> 
> I can duplicate some code and have smp_lwsync *not* call __smp_lwsync

You mean bringing smp_lwsync() back? because I haven't seen you defining
in asm-generic/barriers.h in previous patches and you just delete it in
this patch.

> but why do this? Still, if you prefer it this way,
> please let me know.
> 

I think deleting smp_lwsync() is fine, though I need to change atomic
variants patches on PPC because of it ;-/

Regards,
Boqun

> > >  	WRITE_ONCE(*p, v);						\
> > >  } while (0)
> > >  
> > > -#define smp_load_acquire(p)						\
> > > +#define __smp_load_acquire(p)						\
> > >  ({									\
> > >  	typeof(*p) ___p1 = READ_ONCE(*p);				\
> > >  	compiletime_assert_atomic_type(*p);				\
> > > -	smp_lwsync();							\
> > > +	__smp_lwsync();							\
> > >  	___p1;								\
> > >  })
> > >  
> > > -- 
> > > MST
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
