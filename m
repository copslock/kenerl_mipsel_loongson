Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 04:09:12 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:34199
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeJPCJCzfS8H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 04:09:02 +0200
Received: by mail-pg1-x543.google.com with SMTP id g12-v6so10051427pgs.1
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2018 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cz67bHFDMvGJFAPVrnGd7nRR9VaEfFbq9lmMgtQ7ALI=;
        b=Ok8PoT2K5GRd0KamvoP9eqKuZhLNGS9A/TQQUFKNVaiKMTPdWZBOlKBJnP/SBNp0fB
         eaNg0TIhicPK/28Gv9xiSnJPwjChRHhy71Hj8UEp7IXgBHdi4gGzcrB8K+qvQHybEgT/
         4RZeGqEX+CUKeDt+Zqt+rRqDUsxY24+s4U2g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cz67bHFDMvGJFAPVrnGd7nRR9VaEfFbq9lmMgtQ7ALI=;
        b=IZPBBpgbX06DQZ5bDWsGrVm45qdxKqHYckF+1AV57d1BmHb+tV6R1ijXKUrGmgt2hz
         5bS+DVRPCBCUtwVswRGh6nwaV/EYyGxPTobWhu+Mpe3p2euotHc/f2hTA6JTECQlIvJz
         1kA8bSJnz20U3B8JB/14RxELoECSP6L5bXBgi8YUp0ptSXAHipJxP59KgTxHyYilReh8
         FNP/qg51FWPBlfNX2Ws4k2q7SnIfogMkoNZEAqSfcEaCNvtlx55ZpRKd6tnIbhdKS6MW
         AVRQbHVe0L8H+m4VFPNMg+apJFlNtazkW734pBAaTMMat8ywtUkYWjkBDsWU3qDXsbzt
         +j7w==
X-Gm-Message-State: ABuFfoiTHbXvlX7tjBxBW/Yc+PIIEB7ODxjdtdO7OFOOK0OYT5fuKeVY
        J9WXhrHrxAWjYbY2Dt4xTORd2A==
X-Google-Smtp-Source: ACcGV61tXshD0kdUz1rx/VWy95C7tPdFHs9NIxbQ7U95KgElxYyhNYgyjAz7jKjVcYQ4X5DlhOsyjw==
X-Received: by 2002:a62:6643:: with SMTP id a64-v6mr19935671pfc.202.1539655735629;
        Mon, 15 Oct 2018 19:08:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id m15-v6sm19964319pgt.28.2018.10.15.19.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 19:08:54 -0700 (PDT)
Date:   Mon, 15 Oct 2018 19:08:53 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        minchan@kernel.org, pantin@google.com, hughd@google.com,
        lokeshgidra@google.com, dancol@google.com, mhocko@kernel.org,
        kirill@shutemov.name, akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
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
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181016020853.GA56701@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <6580a62b-69c6-f2e3-767c-bd36b977bea2@de.ibm.com>
 <20181015101814.306d257c@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015101814.306d257c@mschwideX1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joel@joelfernandes.org
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

On Mon, Oct 15, 2018 at 10:18:14AM +0200, Martin Schwidefsky wrote:
> On Mon, 15 Oct 2018 09:10:53 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 10/12/2018 03:37 AM, Joel Fernandes (Google) wrote:
> > > Android needs to mremap large regions of memory during memory management
> > > related operations. The mremap system call can be really slow if THP is
> > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > pte at a time, and can be really slow across a large map. Turning on THP
> > > may not be a viable option, and is not for us. This patch speeds up the
> > > performance for non-THP system by copying at the PMD level when possible.
> > > 
> > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > 
> > > Before:
> > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > 
> > > After:
> > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > 
> > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > tlb every time we do this optimization since I couldn't find a way to
> > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > > 
> > > Cc: minchan@kernel.org
> > > Cc: pantin@google.com
> > > Cc: hughd@google.com
> > > Cc: lokeshgidra@google.com
> > > Cc: dancol@google.com
> > > Cc: mhocko@kernel.org
> > > Cc: kirill@shutemov.name
> > > Cc: akpm@linux-foundation.org
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > > 
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index 9e68a02a52b1..d82c485822ef 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> > >  		drop_rmap_locks(vma);
> > >  }
> > >  
> > > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > > +		  unsigned long new_addr, unsigned long old_end,
> > > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > > +{
> > > +	spinlock_t *old_ptl, *new_ptl;
> > > +	struct mm_struct *mm = vma->vm_mm;
> > > +
> > > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > +	    || old_end - old_addr < PMD_SIZE)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * The destination pmd shouldn't be established, free_pgtables()
> > > +	 * should have release it.
> > > +	 */
> > > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * We don't have to worry about the ordering of src and dst
> > > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > > +	 */
> > > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > > +	if (old_ptl) {
> > > +		pmd_t pmd;
> > > +
> > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > > +		if (new_ptl != old_ptl)
> > > +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > > +
> > > +		/* Clear the pmd */
> > > +		pmd = *old_pmd;
> > > +		pmd_clear(old_pmd);  
> > 
> > Adding Martin Schwidefsky.
> > Is this mapping maybe still in use on other CPUs? If yes, I think for
> > s390 we need to flush here as well (in other word we might need to introduce
> > pmd_clear_flush). On s390 you have to use instructions like CRDTE,IPTE or IDTE
> > to modify page table entries that are still in use. Otherwise you can get a 
> > delayed access exception which is - in contrast to page faults - not recoverable.
> 
> Just clearing an active pmd would be broken for s390. We need the equivalent
> of the ptep_get_and_clear() function for pmds. For s390 this function would
> look like this:
> 
> static inline pte_t pmdp_get_and_clear(struct mm_struct *mm,
>                                        unsigned long addr, pmd_t *pmdp)
> {
>         return pmdp_xchg_lazy(mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_INVALID));
> }
> 
> Just like pmdp_huge_get_and_clear() in fact.

I agree architecture like s390 may need additional explicit instructions to
avoid any unrecoverable failure. So the good news is in my last patch I sent, I
have put this behind an architecture flag (HAVE_MOVE_PMD), so we don't have
to enable it with architectures that cannot handle it:
https://www.spinics.net/lists/linux-mm/msg163621.html

Also we are triggering this optimization only if the page is not a transparent
huge page by calling pmd_trans_huge(). For regular pages, it should be safe to
not do the atomic get_and_clear AIUI because Linux doesn't use any bits from
the PMD like the dirty bit if THP is not in use (and the processors that I
saw (not s390) should not storing anything in the bits anyway when the page
is not a huge page. I have gone through various scenarios and read both arm
32-bit and 64-bit and x86 64-bit manuals, and I believe it to be safe.

For s390, lets not set the HAVE_MOVE_PMD flag. Does that work for you?

> > > +
> > > +		VM_BUG_ON(!pmd_none(*new_pmd));
> > > +
> > > +		/* Set the new pmd */
> > > +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> > > +		if (new_ptl != old_ptl)
> > > +			spin_unlock(new_ptl);
> > > +		spin_unlock(old_ptl);
> > > +
> > > +		*need_flush = true;
> > > +		return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> 
> So the idea is to move the pmd entry to the new location, dragging
> the whole pte table to a new location with a different address.
> I wonder if that is safe in regard to get_user_pages_fast().

Could you elaborate why you feel it may not be?

Are you concerned that the PMD moving interferes with the page walk? Incase
the tree changes during page-walking, the number of pages pinned by
get_user_pages_fast may be less than the number requested. In this case,
get_user_pages_fast would fall back to the slow path which should be
synchronized with the mremap by courtesy of the mm->mmap_sem. But please let
me know the scenario you have in mind and if I missed something.

thanks,

 - Joel
