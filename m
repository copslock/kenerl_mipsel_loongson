Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 09:22:40 +0100 (CET)
Received: from helcar.hengli.com.au ([209.40.204.226]:41132 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009232AbcARIWdcXQCG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 09:22:33 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
        by norbury.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
        id 1aL52Y-0006Wo-Nq; Mon, 18 Jan 2016 19:19:54 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1aL52A-0007ut-Bx; Mon, 18 Jan 2016 16:19:30 +0800
Date:   Mon, 18 Jan 2016 16:19:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     paulmck@linux.vnet.ibm.com
Cc:     Leonid.Yegoshin@imgtec.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
        will.deacon@arm.com, virtualization@lists.linux-foundation.org,
        hpa@zytor.com, sparclinux@vger.kernel.org, mingo@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux@arm.linux.org.uk,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, mpe@ellerman.id.au, x86@kernel.org,
        xen-devel@lists.xenproject.org, mingo@elte.hu,
        linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com,
        arnd@arndb.de, stefano.stabellini@eu.citrix.com,
        adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com,
        tglx@linutronix.de, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160118081929.GA30420@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160114204827.GE3818@linux.vnet.ibm.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.virtualization
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
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

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
>
> You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.
> The reason for this is that smp_read_barrier_depends() must order the
> pointer load against any subsequent read or write through a dereference
> of that pointer.  For example:
> 
>        p = READ_ONCE(gp);
>        smp_rmb();
>        r1 = p->a; /* ordered by smp_rmb(). */
>        p->b = 42; /* NOT ordered by smp_rmb(), BUG!!! */
>        r2 = x; /* ordered by smp_rmb(), but doesn't need to be. */
> 
> In contrast:
> 
>        p = READ_ONCE(gp);
>        smp_read_barrier_depends();
>        r1 = p->a; /* ordered by smp_read_barrier_depends(). */
>        p->b = 42; /* ordered by smp_read_barrier_depends(). */
>        r2 = x; /* not ordered by smp_read_barrier_depends(), which is OK. */
> 
> Again, if your hardware maintains local ordering for address
> and data dependencies, you can have read_barrier_depends() and
> smp_read_barrier_depends() be no-ops like they are for most
> architectures.
> 
> Does that help?

This is crazy! smp_rmb started out being strictly stronger than
smp_read_barrier_depends, when did this stop being the case?
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
