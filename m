Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 16:37:49 +0200 (CEST)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:42933
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJLOhmLF3Sd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 16:37:42 +0200
Received: by mail-pl1-x643.google.com with SMTP id c8-v6so6024293plo.9
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WmsBeRqG+js0d1ZYoeNRzLWfmHXKH+0ny1JSwktvXaA=;
        b=UYddXijWdtK9+FBoycXqxjeDGtjj/99t/2YOiRgSdNY9ts+ybCKBQgWkbhOw3a0URs
         yzPTxHWgLmkfdlyI4yoSEx/ax89p4/aZUNpeF9gGkdPOSDUGdbqm7XKqzqiCbasA3WV0
         qdCaVeaXsSO4uwUI1EksMXDjBgN9542M4G4Rhq8Z1ZwXPb+Fa8hBdziFFq4A8LdSY8Xe
         K/9zRLDH1k3tfdvlXuq5bjM2NgMx7gSsu/MWXhYEMazsght6EqNCnY3QJqhMfBe3PIdF
         is7eogsMKQfiycKtWskb2wWAR9kqJ106PX+GvamKzqxF4YukqxOJQPgO0bDFYWkI/zub
         wkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WmsBeRqG+js0d1ZYoeNRzLWfmHXKH+0ny1JSwktvXaA=;
        b=io3BQyEZpKKtMUtMT9NTdntoKtAFdj0wJkw0IdPcFToPMxSLrZ2SEcMwMH+wDkvesf
         G0oPJiqJZZCG7vdylsEZNySZDj2y8xu/r9/f8WIFbHT2urTVrVqD57PcveSXXAWtbzQU
         3ZW4e9ac1VOdLq/MHA8dU0V+f7GwMmE8GG4kC/bD6ZGMOxwRRsDzdpzYiUpW3T7OhIZy
         yI6CjbkZneTCPQZUCpMtlcyFqCoxwHZ7UcEp98nb+Vg6MHRN+9gghdoeoXloCWkkgjaB
         CQlfYPUKRPZmrS1RzEyZ+1F/TOxu0Ck8Cb+inNBo53Q9mKeLx91sudgbU/Oj5ecgvTdE
         ZQ6g==
X-Gm-Message-State: ABuFfoiBKq5ZZ8fmaW0QMTh7LnLpNKrIhBmPG3PhpmR4Mwn3OoNXJsu2
        MuwOh9YdujP+x/Wx4Gc4bZB83A==
X-Google-Smtp-Source: ACcGV624HBQdcYuhf1fNqc+fSSuf014ZgxhuMF9sCWpN1xC28Kjk2roR0JUzmssKeyQqkz1U05KpYw==
X-Received: by 2002:a17:902:2e81:: with SMTP id r1-v6mr79552plb.212.1539355054305;
        Fri, 12 Oct 2018 07:37:34 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id h7-v6sm3188482pfd.35.2018.10.12.07.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:37:33 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B6CDF300030; Fri, 12 Oct 2018 17:37:28 +0300 (+03)
Date:   Fri, 12 Oct 2018 17:37:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, mhocko@kernel.org,
        linux-mm@kvack.org, lokeshgidra@google.com,
        linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
        Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
        dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-snps-arc@lists.infradead.org, kernel-team@android.com,
        Sam Creasey <sammy@sammy.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        nios2-dev@lists.rocketboards.org,
        Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-parisc@vger.kernel.org, pantin@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181012143728.t42uvr6etg7gp7fh@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <9ed82f9e-88c4-8e4f-8c45-3ef153469603@kot-begemot.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed82f9e-88c4-8e4f-8c45-3ef153469603@kot-begemot.co.uk>
User-Agent: NeoMutt/20180716
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill@shutemov.name
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

On Fri, Oct 12, 2018 at 03:09:49PM +0100, Anton Ivanov wrote:
> On 10/12/18 2:37 AM, Joel Fernandes (Google) wrote:
> > Android needs to mremap large regions of memory during memory management
> > related operations. The mremap system call can be really slow if THP is
> > not enabled. The bottleneck is move_page_tables, which is copying each
> > pte at a time, and can be really slow across a large map. Turning on THP
> > may not be a viable option, and is not for us. This patch speeds up the
> > performance for non-THP system by copying at the PMD level when possible.
> > 
> > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > 
> > Before:
> > Total mremap time for 1GB data: 242321014 nanoseconds.
> > Total mremap time for 1GB data: 196842467 nanoseconds.
> > Total mremap time for 1GB data: 167051162 nanoseconds.
> > 
> > After:
> > Total mremap time for 1GB data: 385781 nanoseconds.
> > Total mremap time for 1GB data: 388959 nanoseconds.
> > Total mremap time for 1GB data: 402813 nanoseconds.
> > 
> > Incase THP is enabled, the optimization is skipped. I also flush the
> > tlb every time we do this optimization since I couldn't find a way to
> > determine if the low-level PTEs are dirty. It is seen that the cost of
> > doing so is not much compared the improvement, on both x86-64 and arm64.
> > 
> > Cc: minchan@kernel.org
> > Cc: pantin@google.com
> > Cc: hughd@google.com
> > Cc: lokeshgidra@google.com
> > Cc: dancol@google.com
> > Cc: mhocko@kernel.org
> > Cc: kirill@shutemov.name
> > Cc: akpm@linux-foundation.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 62 insertions(+)
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 9e68a02a52b1..d82c485822ef 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >   		drop_rmap_locks(vma);
> >   }
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
> > +		pmd_t pmd;
> > +
> > +		new_ptl = pmd_lockptr(mm, new_pmd);
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
> 
> UML does not have set_pmd_at at all

Every architecture does. :)

But it may come not from the arch code.

> If I read the code right, MIPS completely ignores the address argument so
> set_pmd_at there may not have the effect which this patch is trying to
> achieve.

Ignoring address is fine. Most architectures do that..
The ideas is to move page table to the new pmd slot. It's nothing to do
with the address passed to set_pmd_at().

-- 
 Kirill A. Shutemov
