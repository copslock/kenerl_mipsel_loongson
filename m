Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 21:24:16 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:35630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010102AbcAFUYICrJ2X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jan 2016 21:24:08 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id D406DC057EC8;
        Wed,  6 Jan 2016 20:24:03 +0000 (UTC)
Received: from redhat.com (vpn1-4-81.ams2.redhat.com [10.36.4.81])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u06KNpfk014354;
        Wed, 6 Jan 2016 15:23:52 -0500
Date:   Wed, 6 Jan 2016 22:23:51 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <20160106222337-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-16-git-send-email-mst@redhat.com>
 <20160105013648.GA1256@fixme-laptop.cn.ibm.com>
 <20160105085117.GA11858@redhat.com>
 <20160105095341.GA5321@fixme-laptop.cn.ibm.com>
 <20160105180938-mutt-send-email-mst@redhat.com>
 <20160106015152.GA14605@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160106015152.GA14605@fixme-laptop.cn.ibm.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50947
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

On Wed, Jan 06, 2016 at 09:51:52AM +0800, Boqun Feng wrote:
> On Tue, Jan 05, 2016 at 06:16:48PM +0200, Michael S. Tsirkin wrote:
> [snip]
> > > > > Another thing is that smp_lwsync() may have a third user(other than
> > > > > smp_load_acquire() and smp_store_release()):
> > > > > 
> > > > > http://article.gmane.org/gmane.linux.ports.ppc.embedded/89877
> > > > > 
> > > > > I'm OK to change my patch accordingly, but do we really want
> > > > > smp_lwsync() get involved in this cleanup? If I understand you
> > > > > correctly, this cleanup focuses on external API like smp_{r,w,}mb(),
> > > > > while smp_lwsync() is internal to PPC.
> > > > > 
> > > > > Regards,
> > > > > Boqun
> > > > 
> > > > I think you missed the leading ___ :)
> > > > 
> > > 
> > > What I mean here was smp_lwsync() was originally internal to PPC, but
> > > never mind ;-)
> > > 
> > > > smp_store_release is external and it needs __smp_lwsync as
> > > > defined here.
> > > > 
> > > > I can duplicate some code and have smp_lwsync *not* call __smp_lwsync
> > > 
> > > You mean bringing smp_lwsync() back? because I haven't seen you defining
> > > in asm-generic/barriers.h in previous patches and you just delete it in
> > > this patch.
> > > 
> > > > but why do this? Still, if you prefer it this way,
> > > > please let me know.
> > > > 
> > > 
> > > I think deleting smp_lwsync() is fine, though I need to change atomic
> > > variants patches on PPC because of it ;-/
> > > 
> > > Regards,
> > > Boqun
> > 
> > Sorry, I don't understand - why do you have to do anything?
> > I changed all users of smp_lwsync so they
> > use __smp_lwsync on SMP and barrier() on !SMP.
> > 
> > This is exactly the current behaviour, I also tested that
> > generated code does not change at all.
> > 
> > Is there a patch in your tree that conflicts with this?
> > 
> 
> Because in a patchset which implements atomic relaxed/acquire/release
> variants on PPC I use smp_lwsync(), this makes it have another user,
> please see this mail:
> 
> http://article.gmane.org/gmane.linux.ports.ppc.embedded/89877
> 
> in definition of PPC's __atomic_op_release().
> 
> 
> But I think removing smp_lwsync() is a good idea and actually I think we
> can go further to remove __smp_lwsync() and let __smp_load_acquire and
> __smp_store_release call __lwsync() directly, but that is another thing.
> 
> Anyway, I will modify my patch.
> 
> Regards,
> Boqun


Thanks!
Could you send an ack then please?

> > 
> > > > > >  	WRITE_ONCE(*p, v);						\
> > > > > >  } while (0)
> > > > > >  
> > > > > > -#define smp_load_acquire(p)						\
> > > > > > +#define __smp_load_acquire(p)						\
> > > > > >  ({									\
> > > > > >  	typeof(*p) ___p1 = READ_ONCE(*p);				\
> > > > > >  	compiletime_assert_atomic_type(*p);				\
> > > > > > -	smp_lwsync();							\
> > > > > > +	__smp_lwsync();							\
> > > > > >  	___p1;								\
> > > > > >  })
> > > > > >  
> > > > > > -- 
> > > > > > MST
> > > > > > 
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > > Please read the FAQ at  http://www.tux.org/lkml/
