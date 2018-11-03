Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Nov 2018 19:34:06 +0100 (CET)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:45650
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992081AbeKCScMeKM5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Nov 2018 19:32:12 +0100
Received: by mail-pg1-x544.google.com with SMTP id y4so1945161pgc.12
        for <linux-mips@linux-mips.org>; Sat, 03 Nov 2018 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+lLPEfrVQ9C2llxSALOmcEKlDAWxZKsHsAd4XJOgi+8=;
        b=FV1Q0wDvKgkG4kZRj+VZtvFgfpLxegdKxvEOWdUoTsGuYYqOt63vQBXT1gkyiQdbAi
         svoRJLCKxf1oY5viw67ejDUpLUlGpXOV6p6fsqhz+scN/mBqlRF6BsiaYvQifD6XRBSl
         F1mKSr8VXjBVgcSHM1RqfBbz7rT2K+1dKDQgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+lLPEfrVQ9C2llxSALOmcEKlDAWxZKsHsAd4XJOgi+8=;
        b=TBMepFfjZld1sx3PxiuCSyvTd9KSam+CTcrnePX5De3fRKU+M+vVo1kJFwS7yPzLMF
         JHPDFrHOI/sZfcHTsikBreK1Zd1ieDoVlWtnhTsJJh6sAe3IFVNLKYrrd8fl9j1wi4GH
         B7REIUX+Jc46rw2PT5jJ52SM5e3Qn2cVZpYC/BNQ+9sQ92zyn3EbfbAQvMM4VFD6gC/h
         lUWAdyFX/kKiXwsMig6FVSm+Nvu23wroDE0stOWlWWvwrGJ0BHGfIBh5wV1k4toyaT0b
         1p1QaV/y7YDdLjkU3Uxn3if7u3ggiB9M2oq7CJZ4/PnqpP8hPBLQ0gYs1TxNh3Nexa61
         SLnQ==
X-Gm-Message-State: AGRZ1gKP3+CzYCEwUn6mHZPaBhyZ8y317yNcsgR9nCwEFpaNUUAGaiec
        IRIvdZkeiqWyOSDF28e7Ttj4RQ==
X-Google-Smtp-Source: AJdET5cVGh+4UnJ6apMI+3/UlVSbVol0AIxVykI0yDHUDrs2IM14b8w2piyx1JVd0OmDbLiGVERHfA==
X-Received: by 2002:a63:94:: with SMTP id 142mr13240807pga.74.1541269931140;
        Sat, 03 Nov 2018 11:32:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id f22-v6sm46381558pff.29.2018.11.03.11.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 11:32:09 -0700 (PDT)
Date:   Sat, 3 Nov 2018 11:32:08 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc:     Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kirill@shutemov.name,
        kvmarm@lists.cs.columbia.edu, Ley Foon Tan <lftan@altera.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vge.kvack.org, r.kernel.org@lithops.sigma-star.at,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, lokeshgidra@google.com,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
Message-ID: <20181103183208.GA56850@google.com>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
 <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67067
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

On Sat, Nov 03, 2018 at 09:24:05AM +0000, Anton Ivanov wrote:
> On 03/11/2018 09:15, Richard Weinberger wrote:
> > Joel,
> > 
> > Am Samstag, 3. November 2018, 05:00:38 CET schrieb Joel Fernandes:
> > > Hi,
> > > Here is the latest "fast mremap" series. This just a repost with Kirill's
> > > Acked-bys added. I would like this to be considered for linux -next.  I also
> > > dropped the CONFIG enablement patch for arm64 since I am yet to test it with
> > > the new TLB flushing code that is in very recent kernel releases. (None of my
> > > arm64 devices run mainline right now.) so I will post the arm64 enablement once
> > > I get to that. The performance numbers in the series are for x86.
> > > 
> > > List of patches in series:
> > > 
> > > (1) mm: select HAVE_MOVE_PMD in x86 for faster mremap
> > > 
> > > (2) mm: speed up mremap by 20x on large regions (v4)
> > > v1->v2: Added support for per-arch enablement (Kirill Shutemov)
> > > v2->v3: Updated commit message to state the optimization may also
> > > 	run for non-thp type of systems (Daniel Col).
> > > v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
> > > 	Rebased ontop of Linus's master, updated perf results based
> > >          on x86 testing. Added Kirill's Acks.
> > > 
> > > (3) mm: treewide: remove unused address argument from pte_alloc functions (v2)
> > > v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
> > >          update changelog with manual fixups for m68k and microblaze.
> > > 
> > > not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
> > >      This patch is dropped since last posting pending further performance
> > >      testing on arm64 with new TLB gather updates. See notes in patch
> > >      titled "mm: speed up mremap by 500x on large regions" for more
> > >      details.
> > > 
> > This breaks UML build:
> >    CC      mm/mremap.o
> > mm/mremap.c: In function ‘move_normal_pmd’:
> > mm/mremap.c:229:2: error: implicit declaration of function ‘set_pmd_at’; did you mean ‘set_pte_at’? [-Werror=implicit-function-declaration]
> >    set_pmd_at(mm, new_addr, new_pmd, pmd);
> >    ^~~~~~~~~~
> >    set_pte_at
> >    CC      crypto/rng.o
> >    CC      fs/direct-io.o
> > cc1: some warnings being treated as errors
> > 
> > To test yourself, just run on a x86 box:
> > $ make defconfig ARCH=um
> > $ make linux ARCH=um
> > 
> > Thanks,
> > //richard
> > 
> > 
> > 
> 
> UM somehow managed to miss one of the 3-level functions, I sent a patch at
> some point to add to the mmremap series, but it looks like it did not get
> included in the final version.
> 
> You need these two incremental on top of Joel's patch. Richard - feel free
> to relocate the actual implementation of the set_pgd_at elsewhere - I put it
> at the end of tlb.c
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 7485398d0737..1692da55e63a 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -359,4 +359,7 @@ do {                                                \
>         __flush_tlb_one((vaddr));               \
>  } while (0)
> 
> +extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +               pmd_t *pmdp, pmd_t pmd);
> +
>  #endif
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 763d35bdda01..d17b74184ba0 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -647,3 +647,9 @@ void force_flush_all(void)
>                 vma = vma->vm_next;
>         }
>  }
> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +               pmd_t *pmdp, pmd_t pmd)
> +{
> +       *pmdp = pmd;
> +}
> +
> 

Looks like more architectures don't define set_pmd_at. I am thinking the
easiest way forward is to just do the following, instead of defining
set_pmd_at for every architecture that doesn't care about it. Thoughts?

diff --git a/mm/mremap.c b/mm/mremap.c
index 7cf6b0943090..31ad64dcdae6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -281,7 +281,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
-		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
+		} else if (extent == PMD_SIZE) {
+#ifdef CONFIG_HAVE_MOVE_PMD
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
 			 * moving at the PMD level if possible.
@@ -296,6 +297,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 				drop_rmap_locks(vma);
 			if (moved)
 				continue;
+#endif
 		}
 
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
