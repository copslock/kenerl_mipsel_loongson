Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 18:34:47 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:33091
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLQenZFrjf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 18:34:43 +0200
Received: by mail-pg1-x544.google.com with SMTP id y18-v6so6102994pge.0
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeJJXCqJMCDTI+MXwHMrbk77W318YMmfXGKRapf9/Sk=;
        b=YyM56XCqSfyaUBYDgdLpuQEKq1ABQCtIjAm3mexn7sHI103AKL5IRtu1yDgRXWcUmR
         +5dV4+N0dIsXdoQdM+bIK2ixBQF6EMK+bJUmgO404S133rpaNqZgC3hsYM6bPD/0A+T8
         ZZ1OQ9M/ZdWJax92mEDJBrHQFwC2/LW1LA+LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeJJXCqJMCDTI+MXwHMrbk77W318YMmfXGKRapf9/Sk=;
        b=Ga8547ywNKyuoBcV2Gykw5rJHnGwYTcUEgqJRgoxEcyQZf3/aNwTQOJt9V9lYOvsNO
         PHiaY7Sn6mEX70Et3cqeA2qsYj4NrCgBkKShf7Ucvq48OrSQCIAtsqY1D50yNxIF3Hdb
         SHS8K2Lx/xyOwuHgU168AGSmU4Is5tLc0ZRSEK9ftUGpdVeOX1PX2drFQp8LNF18KVo6
         /7+KRY8HZ5bcABdLypOBbvMdjKLoGKcSwizj+wZKy1ISMrK/8ZeulZdEPedp7haH5T/G
         MTD1n+TdWMOn/sp4Mf4srtzfejtnvQxqFwIVBcEdBFMOlcslJDXMdTnJZdsGScpvrnwf
         IqUg==
X-Gm-Message-State: ABuFfoish3Vfw46tal4MdSREuDrj5T3gf/YCc5AyEXTdDtuEqNmGG+c6
        uEBi/tEvHBt1l8fa4u77G1DsAg==
X-Google-Smtp-Source: ACcGV60O5IRpWWZ7ZD+hGXAxlNIP90i6xDrWPRRFvZcxuenG86m+xkw+7WT83DyNZ2L6qLNSI0RNkQ==
X-Received: by 2002:aa7:80cd:: with SMTP id a13-v6mr6747047pfn.86.1539362076258;
        Fri, 12 Oct 2018 09:34:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id l71-v6sm2751559pgd.31.2018.10.12.09.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:34:34 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:34:33 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        lokeshgidra@google.com, linux-riscv@lists.infradead.org,
        elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
        linux-s390@vger.kernel.org, dancol@google.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
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
        nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
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
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Message-ID: <20181012163433.GA223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66777
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

On Fri, Oct 12, 2018 at 02:56:19PM +0100, Anton Ivanov wrote:
> 
> On 10/12/18 2:37 AM, Joel Fernandes (Google) wrote:
> > This series speeds up mremap(2) syscall by copying page tables at the
> > PMD level even for non-THP systems. There is concern that the extra
> > 'address' argument that mremap passes to pte_alloc may do something
> > subtle architecture related in the future, that makes the scheme not
> > work.  Also we find that there is no point in passing the 'address' to
> > pte_alloc since its unused.
> > 
> > This patch therefore removes this argument tree-wide resulting in a nice
> > negative diff as well. Also ensuring along the way that the architecture
> > does not do anything funky with 'address' argument that goes unnoticed.
> > 
> > Build and boot tested on x86-64. Build tested on arm64.
> > 
> > The changes were obtained by applying the following Coccinelle script.
> > The pte_fragment_alloc was manually fixed up since it was only 2
> > occurences and could not be easily generalized (and thanks Julia for
> > answering all my silly and not-silly Coccinelle questions!).
> > 
> > // Options: --include-headers --no-includes
> > // Note: I split the 'identifier fn' line, so if you are manually
> > // running it, please unsplit it so it runs for you.
> > 
> > virtual patch
> > 
> > @pte_alloc_func_def depends on patch exists@
> > identifier E2;
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> > type T2;
> > @@
> > 
> >   fn(...
> > - , T2 E2
> >   )
> >   { ... }
> > 
> > @pte_alloc_func_proto depends on patch exists@
> > identifier E1, E2, E4;
> > type T1, T2, T3, T4;
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> > @@
> > 
> > (
> > - T3 fn(T1 E1, T2 E2);
> > + T3 fn(T1 E1);
> > |
> > - T3 fn(T1 E1, T2 E2, T4 E4);
> > + T3 fn(T1 E1, T2 E2);
> > )
> > 
> > @pte_alloc_func_call depends on patch exists@
> > expression E2;
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> > @@
> > 
> >   fn(...
> > -,  E2
> >   )
> > 
> > @pte_alloc_macro depends on patch exists@
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> > identifier a, b, c;
> > expression e;
> > position p;
> > @@
> > 
> > (
> > - #define fn(a, b, c)@p e
> > + #define fn(a, b) e
> > |
> > - #define fn(a, b)@p e
> > + #define fn(a) e
> > )
> > 
> > Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> > Cc: elfring@users.sourceforge.net
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   arch/alpha/include/asm/pgalloc.h             |  6 +++---
> >   arch/arc/include/asm/pgalloc.h               |  5 ++---
> >   arch/arm/include/asm/pgalloc.h               |  4 ++--
> >   arch/arm64/include/asm/pgalloc.h             |  4 ++--
> >   arch/hexagon/include/asm/pgalloc.h           |  6 ++----
> >   arch/ia64/include/asm/pgalloc.h              |  5 ++---
> >   arch/m68k/include/asm/mcf_pgalloc.h          |  8 ++------
> >   arch/m68k/include/asm/motorola_pgalloc.h     |  4 ++--
> >   arch/m68k/include/asm/sun3_pgalloc.h         |  6 ++----
> >   arch/microblaze/include/asm/pgalloc.h        | 19 ++-----------------
> >   arch/microblaze/mm/pgtable.c                 |  3 +--
> >   arch/mips/include/asm/pgalloc.h              |  6 ++----
> >   arch/nds32/include/asm/pgalloc.h             |  5 ++---
> >   arch/nios2/include/asm/pgalloc.h             |  6 ++----
> >   arch/openrisc/include/asm/pgalloc.h          |  5 ++---
> >   arch/openrisc/mm/ioremap.c                   |  3 +--
> >   arch/parisc/include/asm/pgalloc.h            |  4 ++--
> >   arch/powerpc/include/asm/book3s/32/pgalloc.h |  4 ++--
> >   arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 +++++-------
> >   arch/powerpc/include/asm/nohash/32/pgalloc.h |  4 ++--
> >   arch/powerpc/include/asm/nohash/64/pgalloc.h |  6 ++----
> >   arch/powerpc/mm/pgtable-book3s64.c           |  2 +-
> >   arch/powerpc/mm/pgtable_32.c                 |  4 ++--
> >   arch/riscv/include/asm/pgalloc.h             |  6 ++----
> >   arch/s390/include/asm/pgalloc.h              |  4 ++--
> >   arch/sh/include/asm/pgalloc.h                |  6 ++----
> >   arch/sparc/include/asm/pgalloc_32.h          |  5 ++---
> >   arch/sparc/include/asm/pgalloc_64.h          |  6 ++----
> >   arch/sparc/mm/init_64.c                      |  6 ++----
> >   arch/sparc/mm/srmmu.c                        |  4 ++--
> >   arch/um/kernel/mem.c                         |  4 ++--
> 
> There is a declaration of pte_alloc_one in arch/um/include/asm/pgalloc.h
> 
> This patch missed it.

Ah, true. Thanks. Couldn't test every arch obviously. The reason this was
missed is the script could not find matches with prototypes without named
parameters:

extern pgtable_t pte_alloc_one(struct mm_struct *, unsigned long);

I wrote something like this as below but it failed to compile, Julia any
suggestions on how to express this?

@pte_alloc_func_proto depends on patch exists@
type T1, T2, T3, T4;
identifier fn =~
"^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
@@

(
- T3 fn(T1, T2);
+ T3 fn(T1);
|
- T3 fn(T1, T2, T4);
+ T3 fn(T1, T2);
)

thanks,

 - Joel
