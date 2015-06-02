Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 18:15:39 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007056AbbFBQPhFRkJ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 18:15:37 +0200
Date:   Tue, 2 Jun 2015 17:15:37 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, markos.chandras@imgtec.com,
        Steven.Hill@imgtec.com, alexander.h.duyck@redhat.com,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
In-Reply-To: <556D8A03.9080201@imgtec.com>
Message-ID: <alpine.LFD.2.11.1506021709420.6751@eddie.linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000934.6668.43645.stgit@ubuntu-yegoshin> <556D8A03.9080201@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 2 Jun 2015, James Hogan wrote:

> > diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> > index 2b8bbbcb9be0..d2a63abfc7c6 100644
> > --- a/arch/mips/include/asm/barrier.h
> > +++ b/arch/mips/include/asm/barrier.h
> > @@ -96,9 +96,15 @@
> >  #  define smp_rmb()	barrier()
> >  #  define smp_wmb()	__syncw()
> >  # else
> > +#  ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
> > +#  define smp_mb()      __asm__ __volatile__("sync 0x10" : : :"memory")
> > +#  define smp_rmb()     __asm__ __volatile__("sync 0x13" : : :"memory")
> > +#  define smp_wmb()     __asm__ __volatile__("sync 0x4" : : :"memory")
> 
> binutils appears to support the sync_mb, sync_rmb, sync_wmb aliases
> since version 2.21. Can we safely use them?

 I suggest that we don't -- we still officially support binutils 2.12 and 
have other places where we even use `.word' to insert instructions current 
versions of binutils properly handle.  It may be worth noting in a comment 
though that these encodings correspond to these operations that you named.

  Maciej
