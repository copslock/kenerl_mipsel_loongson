Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 15:22:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55022 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006928AbbFBNWudSeP4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jun 2015 15:22:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t52DMi84023557;
        Tue, 2 Jun 2015 15:22:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t52DMhK4023556;
        Tue, 2 Jun 2015 15:22:43 +0200
Date:   Tue, 2 Jun 2015 15:22:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, macro@linux-mips.org,
        Steven.Hill@imgtec.com, alexander.h.duyck@redhat.com,
        davem@davemloft.net
Subject: Re: [PATCH 3/3] MIPS: bugfix - replace smp_mb with release barrier
 function in unlocks
Message-ID: <20150602132243.GI29986@linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <20150602000952.6668.82483.stgit@ubuntu-yegoshin>
 <556D96B0.3050409@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556D96B0.3050409@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 02, 2015 at 12:42:40PM +0100, James Hogan wrote:

> Replace.
> 
> > smp_mb__before_llsc() call which does "release" barrier functionality.
> > 
> > It seems like it was missed in commit f252ffd50c97dae87b45f1dbad24f71358ccfbd6
> > during introduction of "acquire" and "release" semantics.
> > 
> > Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> > ---
> >  arch/mips/include/asm/bitops.h   |    2 +-
> >  arch/mips/include/asm/spinlock.h |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> > index 0cf29bd5dc5c..ce9666cf1499 100644
> > --- a/arch/mips/include/asm/bitops.h
> > +++ b/arch/mips/include/asm/bitops.h
> > @@ -469,7 +469,7 @@ static inline int test_and_change_bit(unsigned long nr,
> >   */
> >  static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
> >  {
> > -	smp_mb();
> > +	smp_mb__before_llsc();
> >  	__clear_bit(nr, addr);
> >  }
> >  
> > diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
> > index 1fca2e0793dc..7c7f3b2bd3de 100644
> > --- a/arch/mips/include/asm/spinlock.h
> > +++ b/arch/mips/include/asm/spinlock.h
> > @@ -317,7 +317,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
> >  
> >  static inline void arch_write_unlock(arch_rwlock_t *rw)
> >  {
> > -	smp_mb();
> > +	smp_mb__before_llsc();
> 
> arch_write_unlock appears to just use sw, not sc, and __clear_bit
> appears to be implemented in plain C, so is smp_mb__before_llsc() really
> appropriate? Would smp_release() be more accurate/correct in both cases?

Yes on the both questions.

  Ralf
