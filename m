Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2014 04:15:52 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:54519 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817040AbaA1DPstpKT2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jan 2014 04:15:48 +0100
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s0S3D4jt028228;
        Mon, 27 Jan 2014 21:13:06 -0600
Message-ID: <1390878783.3872.63.camel@pasglop>
Subject: Re: [PATCH RFC 00/73] tree-wide: clean up some no longer required
 #include <linux/init.h>
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, rusty@rustcorp.com.au,
        linux-ia64@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 28 Jan 2014 14:13:03 +1100
In-Reply-To: <20140123003838.GA10182@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
         <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>
         <20140123003838.GA10182@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Wed, 2014-01-22 at 19:38 -0500, Paul Gortmaker wrote:

> Thanks, it was a great help as it uncovered a few issues in fringe arch
> that I didn't have toolchains for, and I've fixed all of those up.
> 
> I've noticed that powerpc has been un-buildable for a while now; I have
> used this hack patch locally so I could run the ppc defconfigs to check
> that I didn't break anything.  Maybe useful for linux-next in the
> interim?  It is a hack patch -- Not-Signed-off-by: Paul Gortmaker.  :)

Can you and/or Aneesh submit that as a proper patch (with S-O-B
etc...) ?

Thanks !

Cheers,
Ben.

> Paul.
> --
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index d27960c89a71..d0f070a2b395 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  			    pmd_t *pmdp);
>  
>  #define pmd_move_must_withdraw pmd_move_must_withdraw
> -typedef struct spinlock spinlock_t;
> -static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
> -					 spinlock_t *old_pmd_ptl)
> +struct spinlock;
> +static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> +					 struct spinlock *old_pmd_ptl)
>  {
>  	/*
>  	 * Archs like ppc64 use pgtable to store per pmd
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
