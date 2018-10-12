Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 14:51:02 +0200 (CEST)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:42354
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLMu4Mj8KP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 14:50:56 +0200
Received: by mail-pl1-x643.google.com with SMTP id c8-v6so5896328plo.9
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QKN0QLgWMdeaFShuOKgUCdS+KZEgqTytMiliL2mzgC0=;
        b=cuTpq2KxjzFREjuReJCgXoTtmsf4MapPO/GKTB1jBLxsEEu2m7M7ZkvRB6q79tS5tz
         O6mqiraSPEsjDSeGINirN/8v2zV5PUlYs/7NG0sKTsmNtz6ADZ+8u7AlqnAMULoHIM7r
         c98gGt3pHgL5ok5lR90IVL9Vuy1e12CI4gJLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKN0QLgWMdeaFShuOKgUCdS+KZEgqTytMiliL2mzgC0=;
        b=nKRkbaFNsi7Fje9kyRTh+6/Dhz0bepMYFcxsYPL86vNjXHQ1VhQyqW1uzsg4SOEP/b
         I5Nxjw9vnVmgMQzDtuJbD2iSEs4qzveRC4OQwSmJ0yZB+75vs/OsUAv96K8vBZ1szSJa
         2CQgOGcTB1lUgTbdBmVlWkxD1bYpGcjvcLb6KPR//oymT5umDST3JId7Fs3rAg/Ousuk
         zQx0fRrmUFenY2WhLv4epBAf7tG40/IZme2TjDBB8EXQSdaYKNOD/QIbHDjDl/speScr
         cylnOCC1NQ82DbCLAGAu0it/8FV31poEBvnRJ6LC0/o2kLJhzeGqW2w0jLWi9jhSc9Fm
         MUOw==
X-Gm-Message-State: ABuFfog7LGRD82u0h6OZWEBSPv72R1/enLzDDhuV/n/vocY+lD9YbUfQ
        qSL1K1Cb7859+Pfo6EQjkvYKvA==
X-Google-Smtp-Source: ACcGV62U4sAceqM+O5tNywkqcriJ8B2EehkajcnFr0AxLQ8/wmf9zrWd7Nv4vm7gsM8YPAJpgdeQnw==
X-Received: by 2002:a17:902:22a:: with SMTP id 39-v6mr5923316plc.267.1539348649157;
        Fri, 12 Oct 2018 05:50:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z11-v6sm4395226pfg.85.2018.10.12.05.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:50:47 -0700 (PDT)
Date:   Fri, 12 Oct 2018 05:50:46 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        minchan@kernel.org, pantin@google.com, hughd@google.com,
        lokeshgidra@google.com, dancol@google.com, mhocko@kernel.org,
        akpm@linux-foundation.org,
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
Message-ID: <20181012125046.GA170912@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66770
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

On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
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
> 
> I looked into the code more and noticed move_pte() helper called from
> move_ptes(). It changes PTE entry to suite new address.
> 
> It is only defined in non-trivial way on Sparc. I don't know much about
> Sparc and it's hard for me to say if the optimization will break anything
> there.

Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
not modifying the PTE itself AFAICS:

#ifdef DCACHE_ALIASING_POSSIBLE
#define __HAVE_ARCH_MOVE_PTE
#define move_pte(pte, prot, old_addr, new_addr)                         \
({                                                                      \
        pte_t newpte = (pte);                                           \
        if (tlb_type != hypervisor && pte_present(pte)) {               \
                unsigned long this_pfn = pte_pfn(pte);                  \
                                                                        \
                if (pfn_valid(this_pfn) &&                              \
                    (((old_addr) ^ (new_addr)) & (1 << 13)))            \
                        flush_dcache_page_all(current->mm,              \
                                              pfn_to_page(this_pfn));   \
        }                                                               \
        newpte;                                                         \
})
#endif

If its an issue, then how do transparent huge pages work on Sparc?  I don't
see the huge page code (move_huge_pages) during mremap doing anything special
for Sparc architecture when moving PMDs..

Also, do we not flush the caches from any path when we munmap address space?
We do call do_munmap on the old mapping from mremap after moving to the new one.

thanks,

 - Joel
