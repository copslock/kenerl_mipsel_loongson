Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2018 04:09:22 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:33073
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeJYCJRaz0FJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2018 04:09:17 +0200
Received: by mail-pf1-x444.google.com with SMTP id 22-v6so3393375pfz.0
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G78I9uM4gXdiLalpqQZcUQ0k8S9gAvq6zBmyUxhGe0M=;
        b=LAnJhDOqLDe5rJ8W4SiC2EjUQZvQu/r5ZibVfgxKfT2epX8iHZwYQmEjB6a8btC1dW
         r6dDSvdCvkPgsk5m3K0hxUEc1ohpdLPr/504o7kJ7XSyqWkNXqLU77+seSO2HzOgNvQs
         hVyNi6MDrJlz77EflnU3vSDe0xbeuTe8cghrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G78I9uM4gXdiLalpqQZcUQ0k8S9gAvq6zBmyUxhGe0M=;
        b=h8ADg9YexNOr9DgYnAtTclSkQEZ696o+3jzie9W8pghiSAITWwEgbJ+JuGjJPOf6yw
         nIOonN/fSfGY1pf8NZYd6SwOch/8k+ww+BZCSpS5YJATe+jkxwUjaAY49/Rh6334Jd1b
         JczCxgoo5Urp2rn5lkPv2xl1utLmuTaDMNtxW2fBsAAxNH3BqfppkxtGOWoP+43bxqjb
         C6GUKcRa70mI0EIg2cYf4pZ6n/E/E/mQ9KFaNcg/X/CSPtsO0nFEdvz+tbGavOQlHxU6
         wIf8/w5lBPCZ6kzJfgdiWZ+ckeU8ngYuwjs6aBs1m1FQ5ViRxHvdKR33AQZ5xsZeUqmc
         PIwg==
X-Gm-Message-State: AGRZ1gIL2jcaK0zHQfLk5SThI+RrMt/j/mxD2DDWrM3yDeajwWKM8U2e
        2ThPpgn12cl7rIjo+QvPZrxlYQ==
X-Google-Smtp-Source: AJdET5dUEfywPWvzS+489PJ55mfHZNUk9qKPmDa0EsEQ3lYTg7j+ER6qGO2BektCxwt9F6U/VdSRSA==
X-Received: by 2002:aa7:814f:: with SMTP id d15-v6mr5054081pfn.78.1540433350578;
        Wed, 24 Oct 2018 19:09:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 68-v6sm6748192pfg.136.2018.10.24.19.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 19:09:08 -0700 (PDT)
Date:   Wed, 24 Oct 2018 19:09:07 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, minchan@kernel.org, pantin@google.com,
        hughd@google.com, lokeshgidra@google.com, dancol@google.com,
        mhocko@kernel.org, akpm@linux-foundation.org,
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
Message-ID: <20181025020907.GA13560@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66931
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

On Wed, Oct 24, 2018 at 03:57:24PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> > On Wed, Oct 24, 2018 at 01:12:56PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > index 9e68a02a52b1..2fd163cff406 100644
> > > > --- a/mm/mremap.c
> > > > +++ b/mm/mremap.c
> > > > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> > > >  		drop_rmap_locks(vma);
> > > >  }
> > > >  
> > > > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > > > +		  unsigned long new_addr, unsigned long old_end,
> > > > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > > > +{
> > > > +	spinlock_t *old_ptl, *new_ptl;
> > > > +	struct mm_struct *mm = vma->vm_mm;
> > > > +
> > > > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > > +	    || old_end - old_addr < PMD_SIZE)
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * The destination pmd shouldn't be established, free_pgtables()
> > > > +	 * should have release it.
> > > > +	 */
> > > > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * We don't have to worry about the ordering of src and dst
> > > > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > > > +	 */
> > > > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > > > +	if (old_ptl) {
> > > 
> > > How can it ever be false?

Kirill,
It cannot, you are right. I'll remove the test.

By the way, there are new changes upstream by Linus which flush the TLB
before releasing the ptlock instead of after. I'm guessing that patch came
about because of reviews of this patch and someone spotted an issue in the
existing code :)

Anyway the patch in concern is:
eb66ae030829 ("mremap: properly flush TLB before releasing the page")

I need to rebase on top of that with appropriate modifications, but I worry
that this patch will slow down performance since we have to flush at every
PMD/PTE move before releasing the ptlock. Where as with my patch, the
intention is to flush only at once in the end of move_page_tables. When I
tried to flush TLB on every PMD move, it was quite slow on my arm64 device [2].

Further observation [1] is, it seems like the move_huge_pmds and move_ptes code
is a bit sub optimal in the sense, we are acquiring and releasing the same
ptlock for a bunch of PMDs if the said PMDs are on the same page-table page
right? Instead we can do better by acquiring and release the ptlock less
often.

I think this observation [1] and the frequent TLB flush issue [2] can be solved
by acquiring the ptlock once for a bunch of PMDs, move them all, then flush
the tlb and then release the ptlock, and then proceed to doing the same thing
for the PMDs in the next page-table page. What do you think?

- Joel
