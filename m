Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 19:07:15 +0200 (CEST)
Received: from mail-pf1-x442.google.com ([IPv6:2607:f8b0:4864:20::442]:36406
        "EHLO mail-pf1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeJLRHH1S4wf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 19:07:07 +0200
Received: by mail-pf1-x442.google.com with SMTP id l81-v6so6514380pfg.3
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWO+dFnIA15gJmvQ4eNCqGVZ4Qr8lNDSuRvOzoXBn+E=;
        b=WwQOLfCbO08E3NezFCRCjwi3+jigw7IuZV/3VMwyQTIrRXeYa1SnFe/q8Q8jl8npqM
         m7+28ANzAzlEob4deL70RikU2qKMFmo22Iqv7KRsQzLW0+PPtrLc3yy2PVaZXzxrb9Iu
         QWG8MqGMV8u6uclnrr8mBMRhkTg2589/g79Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWO+dFnIA15gJmvQ4eNCqGVZ4Qr8lNDSuRvOzoXBn+E=;
        b=WyG1v/ApWtxChj2WEFPegVFWNDG13i++EPhGGPSlKdcrn/HZJJEA0+ACKN1BOlfHuD
         f+vNXZi2VDYSvcegNvWlWJF/Guvj8sH6QFhTkgSIosH/6l/RU0SS/ose0Mde0gJaKfgf
         E5U70A4lHXYT5Cc/+wlA3VE+dcJtpFwLvRErHACuxpfIkVZMtkjYtVz8XrA9QelpUD7j
         wo6OcuqmyXZbwf8+Yj+B8+Ngo++EONfB9Q1500vG6RqNiVC7Ylf4bnHwqdXnD7hmW7w9
         60O7xqU0q42UwXtSvtNlIjBWZu6N78M4NVDXDs8PgdGq1AXgPofYA58kjFgfX5Y+oFOf
         icbA==
X-Gm-Message-State: ABuFfoh/GOnLDodMgGgIjDGP/Pe6XbhbA/yWuhcpGAgcFpss4voxUQJs
        Kzo+Zu7VPEVPeRwLqHXfS7M1OQ==
X-Google-Smtp-Source: ACcGV62OCxlNUxXyh36zKpq33KISxAGo4zTV/25XvmfDqzhMWe9+VxAYnqYbiMM/wNfwPBwH+ngvTg==
X-Received: by 2002:a65:4783:: with SMTP id e3-v6mr6189410pgs.12.1539364020849;
        Fri, 12 Oct 2018 10:07:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id i5-v6sm2695646pgs.10.2018.10.12.10.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 10:06:59 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:06:58 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <20181012170658.GF223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <9ed82f9e-88c4-8e4f-8c45-3ef153469603@kot-begemot.co.uk>
 <20181012143728.t42uvr6etg7gp7fh@kshutemo-mobl1>
 <4dd52e22-5b51-9b30-7178-fde603a08f88@kot-begemot.co.uk>
 <97cb3fe1-7bc1-12ff-d602-56c72a5496c5@kot-begemot.co.uk>
 <20181012165012.GD223066@joelaf.mtv.corp.google.com>
 <4f969958-913e-cb9f-48fb-e3a88e1d288c@kot-begemot.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f969958-913e-cb9f-48fb-e3a88e1d288c@kot-begemot.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66786
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

On Fri, Oct 12, 2018 at 05:58:40PM +0100, Anton Ivanov wrote:
[...]
> > > > > > If I read the code right, MIPS completely ignores the address
> > > > > > argument so
> > > > > > set_pmd_at there may not have the effect which this patch is trying to
> > > > > > achieve.
> > > > > Ignoring address is fine. Most architectures do that..
> > > > > The ideas is to move page table to the new pmd slot. It's nothing to do
> > > > > with the address passed to set_pmd_at().
> > > > If that is it's only function, then I am going to appropriate the code
> > > > out of the MIPS tree for further uml testing. It does exactly that -
> > > > just move the pmd the new slot.
> > > > 
> > > > A.
> > > 
> > > A.
> > > 
> > >  From ac265d96897a346b05646fce91784ed4922c7f8d Mon Sep 17 00:00:00 2001
> > > From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > > Date: Fri, 12 Oct 2018 17:24:10 +0100
> > > Subject: [PATCH] Incremental fixes to the mmremap patch
> > > 
> > > Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > > ---
> > >   arch/um/include/asm/pgalloc.h | 4 ++--
> > >   arch/um/include/asm/pgtable.h | 3 +++
> > >   arch/um/kernel/tlb.c          | 6 ++++++
> > >   3 files changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
> > > index bf90b2aa2002..99eb5682792a 100644
> > > --- a/arch/um/include/asm/pgalloc.h
> > > +++ b/arch/um/include/asm/pgalloc.h
> > > @@ -25,8 +25,8 @@
> > >   extern pgd_t *pgd_alloc(struct mm_struct *);
> > >   extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
> > > -extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
> > > -extern pgtable_t pte_alloc_one(struct mm_struct *, unsigned long);
> > > +extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
> > > +extern pgtable_t pte_alloc_one(struct mm_struct *);
> > If its Ok, let me handle this bit since otherwise it complicates things for
> > me.
> > 
> > >   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> > >   {
> > > diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> > > index 7485398d0737..1692da55e63a 100644
> > > --- a/arch/um/include/asm/pgtable.h
> > > +++ b/arch/um/include/asm/pgtable.h
> > > @@ -359,4 +359,7 @@ do {						\
> > >   	__flush_tlb_one((vaddr));		\
> > >   } while (0)
> > > +extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> > > +		pmd_t *pmdp, pmd_t pmd);
> > > +
> > >   #endif
> > > diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> > > index 763d35bdda01..d17b74184ba0 100644
> > > --- a/arch/um/kernel/tlb.c
> > > +++ b/arch/um/kernel/tlb.c
> > > @@ -647,3 +647,9 @@ void force_flush_all(void)
> > >   		vma = vma->vm_next;
> > >   	}
> > >   }
> > > +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> > > +		pmd_t *pmdp, pmd_t pmd)
> > > +{
> > > +	*pmdp = pmd;
> > > +}
> > > +
> > I believe this should be included in a separate patch since it is not related
> > specifically to pte_alloc argument removal. If you want, I could split it
> > into a separate patch for my series with you as author.
> 
> 
> Whichever is more convenient for you.

Ok.

> One thing to note - tlb flush is extremely expensive on uml.
> 
> I have lifted the definition of set_pmd_at from the mips tree and removed
> the tlb_flush_all from it for this exact reason.
> 
> If I read the original patch correctly, it does its own flush control so
> set_pmd_at does not need to do a force flush every time. It is done further
> up the chain.

That is correct. It is not done during the optimization, but is done later
after the pmds have moved.

thanks,

 - Joel
