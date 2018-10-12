Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 15:20:06 +0200 (CEST)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:34371
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJLNT7Qb5TP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 15:19:59 +0200
Received: by mail-pl1-x644.google.com with SMTP id f18-v6so5953600plr.1
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qPLu7mXDYNebnqy2itkdFlgzgYtAbH0/XYuxd81Ni0g=;
        b=YGQLxTR/pEGGaKQwkJOPBPFRTunxlW3tZGxesrOXRnJ6KNUkprkgsjFH3yz3BCwgrr
         aYzpBghcn1iHyBVjtKgD40ZPbxRHkilAmJzb7/aFvPSk5SxyasOy3AigGVde1WJB2nax
         zY2/Ac5VgCKM0KrcyJ+RW5uG3SsqMPxflZ6l1QaePADC37N9Ltvz6oG9Aod/JKTtPaDs
         CNP1gfPNcIhVYS97nBIRjsXfwVI0/hOh6yz5e52vOr0n6L+OGcaaHMTa3oKpjyQI30pq
         +2lbu9/KfK8VHGL5qG/kTRpE1ENspnuC41qZ5FOTEi8qxtzqM+whP9MXiu/XeiCSptlJ
         /2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qPLu7mXDYNebnqy2itkdFlgzgYtAbH0/XYuxd81Ni0g=;
        b=II6C7QUfow5shyQm4kD68qY1j6lZq1Sff7USkvOtOBgLQexzj2Of3OXTtNcYVgZ0IJ
         PIPmOVWgLywYx8/Nm2BYrAR8BEUZ9hafaFMO6bwJuaP7qOT/fuUn1nGfToK/+xu7JnFv
         wiS6J96K9DXAFWMoc19EISBoMwQuHg/mRrobkGFMkXTv9LlnWoDGwqvQBVXJdhdrjHFB
         bAX2fE5EO8BafI/JfXdepKI+z8A1a41M+2y+jIINYbE2cmaecH9LCYdCt4oo90czPYmk
         2k8ks5NrGhuB9pxYgsGXhTO0QgOVbeOv5C0Mhi/W0ZooMk2NhAcyI5bFTxRxJLcjhOS1
         wgfg==
X-Gm-Message-State: ABuFfohI3caReTXichqf9sN/VG2RzkmELXQ9zKMI9Fp52JBUd8qzL6b4
        ODTxIdr+NPSUsTGyC/Og4b71PA==
X-Google-Smtp-Source: ACcGV63NiI8G9L9RoeLis69krPaHbnldlLDZCtg1d0C3iU/tVpX89y6Av72eJGnMr1LMuMBi4E+eAQ==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10-v6mr5901268plb.72.1539350392511;
        Fri, 12 Oct 2018 06:19:52 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id t22-v6sm2727444pfk.141.2018.10.12.06.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 06:19:51 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E9F3E300030; Fri, 12 Oct 2018 16:19:46 +0300 (+03)
Date:   Fri, 12 Oct 2018 16:19:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20181012131946.zoab2lpfmrycmuju@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012125046.GA170912@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66771
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

On Fri, Oct 12, 2018 at 05:50:46AM -0700, Joel Fernandes wrote:
> On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
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
> > 
> > I looked into the code more and noticed move_pte() helper called from
> > move_ptes(). It changes PTE entry to suite new address.
> > 
> > It is only defined in non-trivial way on Sparc. I don't know much about
> > Sparc and it's hard for me to say if the optimization will break anything
> > there.
> 
> Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
> not modifying the PTE itself AFAICS:
> 
> #ifdef DCACHE_ALIASING_POSSIBLE
> #define __HAVE_ARCH_MOVE_PTE
> #define move_pte(pte, prot, old_addr, new_addr)                         \
> ({                                                                      \
>         pte_t newpte = (pte);                                           \
>         if (tlb_type != hypervisor && pte_present(pte)) {               \
>                 unsigned long this_pfn = pte_pfn(pte);                  \
>                                                                         \
>                 if (pfn_valid(this_pfn) &&                              \
>                     (((old_addr) ^ (new_addr)) & (1 << 13)))            \
>                         flush_dcache_page_all(current->mm,              \
>                                               pfn_to_page(this_pfn));   \
>         }                                                               \
>         newpte;                                                         \
> })
> #endif
> 
> If its an issue, then how do transparent huge pages work on Sparc?  I don't
> see the huge page code (move_huge_pages) during mremap doing anything special
> for Sparc architecture when moving PMDs..

My *guess* is that it will work fine on Sparc as it apprarently it only
cares about change in bit 13 of virtual address. It will never happen for
huge pages or when PTE page tables move.

But I just realized that the problem is bigger: since we pass new_addr to
the set_pte_at() we would need to audit all implementations that they are
safe with just moving PTE page table.

I would rather go with per-architecture enabling. It's much safer.

> Also, do we not flush the caches from any path when we munmap address space?
> We do call do_munmap on the old mapping from mremap after moving to the new one.

Are you sure about that? It can be hided deeper in architecture-specific
code.

-- 
 Kirill A. Shutemov
