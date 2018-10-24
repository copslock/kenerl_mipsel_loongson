Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 13:57:50 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:41517
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990947AbeJXL5oKoRY- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 13:57:44 +0200
Received: by mail-pf1-x443.google.com with SMTP id a19-v6so2292400pfo.8
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4S1JZtjtEoZRmv1cmbD7oqQ5fBxxZJ0gckdgeOcI14=;
        b=rxvOMkoPR1fl+wChK1gmiyTy80jYizuSzzLNsN1UW/nn68lcvDelAzg7q5xRULAFwF
         88m9+eaacj9fu1oQRgbn9o9rL5OobsROYLsUPy8Jgnz+ao671RDA5Lk1ggZYlGqX9SbG
         9RUUixIOumM9W9fFeC11ng0GECm2HV0kpOJEacCyBhFOab2Q3i4VFHF0QbnxQWZzkmCY
         Lire1m9l7AF9VgUbUKgofuhPxpehLdKNOXRb6mUKntibxqs2pslottwNtAIjzUINJV13
         bV4f1WLD9yCA7Iyr+h+lgaNFbMHR6/U4tmHoxnhQ/7prUqBNDcYtn35v7xWxzF+rGnLI
         1zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4S1JZtjtEoZRmv1cmbD7oqQ5fBxxZJ0gckdgeOcI14=;
        b=QBbqTVNoRLbxdLnlgM6OhcSYhYtnpTsa804zCBagSPMKZeyco2L2Dqx6liVXpuZOnf
         wZl6cmbygqFwlUWREV4D510Sm6NlfJeVmSsalOwsJ6SbGiHiLO8f3g+YmAKA1FFblUmX
         Uhzd1umXUpbJNJYdwXkWqKLdP6Wud/RDMmb1ZoGrwqqpwHG/qdZGGYcE1DTMCcH6+jQe
         vqpZ7HfXJT2C5mQRjQtIxr2BPlLnGgBWZ+cvR35vHCHIhmY8OjGLdfSt2FSVGtibQRnV
         846TY4Jf0sbY9kGrh7DTp3Vuf2NAAjfdFbTaLMIV0CE1EV9RE3VgNIw0n76oq3oZ2zJI
         NJ9Q==
X-Gm-Message-State: AGRZ1gK5QR69azDtlssOIjUJhEvW9qqAecn6rU4/PlTqCdd9ZJKMdaUs
        M2pr7NCLRsK5MyrCmfJhssM=
X-Google-Smtp-Source: AJdET5fJWm/yEunoAdHkJCNfHZyAKT69zWrP0KZ/06Nf8Zmi/6rvBn7LEzBt+uDaB55Nx51vc0n+3g==
X-Received: by 2002:a62:6383:: with SMTP id x125-v6mr2334785pfb.13.1540382257876;
        Wed, 24 Oct 2018 04:57:37 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id t5-v6sm3677450pfm.26.2018.10.24.04.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 04:57:36 -0700 (PDT)
Date:   Wed, 24 Oct 2018 22:57:33 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        minchan@kernel.org, pantin@google.com, hughd@google.com,
        lokeshgidra@google.com, dancol@google.com, mhocko@kernel.org,
        akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181024115733.GN8537@350D>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <bsingharora@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bsingharora@gmail.com
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

On Wed, Oct 24, 2018 at 01:12:56PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 9e68a02a52b1..2fd163cff406 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >  		drop_rmap_locks(vma);
> >  }
> >  
> > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > +		  unsigned long new_addr, unsigned long old_end,
> > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > +{
> > +	spinlock_t *old_ptl, *new_ptl;
> > +	struct mm_struct *mm = vma->vm_mm;
> > +
> > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > +	    || old_end - old_addr < PMD_SIZE)
> > +		return false;
> > +
> > +	/*
> > +	 * The destination pmd shouldn't be established, free_pgtables()
> > +	 * should have release it.
> > +	 */
> > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > +		return false;
> > +
> > +	/*
> > +	 * We don't have to worry about the ordering of src and dst
> > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > +	 */
> > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > +	if (old_ptl) {
> 
> How can it ever be false?
> 
> > +		pmd_t pmd;
> > +
> > +		new_ptl = pmd_lockptr(mm, new_pmd);


Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
the code applies, why not just reuse as much as possible? The same comments
w.r.t mmap_sem helping protect against lock order issues applies as well.

> > +		if (new_ptl != old_ptl)
> > +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > +
> > +		/* Clear the pmd */
> > +		pmd = *old_pmd;
> > +		pmd_clear(old_pmd);
> > +
> > +		VM_BUG_ON(!pmd_none(*new_pmd));
> > +
> > +		/* Set the new pmd */
> > +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> > +		if (new_ptl != old_ptl)
> > +			spin_unlock(new_ptl);
> > +		spin_unlock(old_ptl);
> > +
> > +		*need_flush = true;
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> -- 
>  Kirill A. Shutemov
> 
