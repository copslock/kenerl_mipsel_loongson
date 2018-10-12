Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 23:34:15 +0200 (CEST)
Received: from mail-pf1-x442.google.com ([IPv6:2607:f8b0:4864:20::442]:43982
        "EHLO mail-pf1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeJLVeMulgE6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 23:34:12 +0200
Received: by mail-pf1-x442.google.com with SMTP id p24-v6so6792564pff.10
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHzipgUbb9bD6KKi7C8OH4ai2uXb2G2QZZei89osBiM=;
        b=tt4haWxvZLIGYgzjVvsH+gjFwfPR7DwtAHjZBdy13UoFAue6QtBjQ7yFpwdRLddwrz
         5M7Rt9vrVAomTaqAQJ7suNm3XfxtViA+swo1shgRv6b5mcASOaSfl1jxY9Io26x/3N43
         kJHc/sqKzp2v6SuHG2C8dEeJBeZpx9rXlnSqNr5HyQtCYHzhqAX/snQjGfm5BB5VdZSs
         MEUpJyErXmrbzyP5LvHp09wHHqO17A1BhLGE8wPOnD0xxGQXTAOimdYT+DkyVwz2AN51
         go/7rEXftCDBj/fYKEoPC9lVN9fdUs5TJXPwZPZIVEu19exs/DzqHb05FsfuzodtJKAK
         +mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHzipgUbb9bD6KKi7C8OH4ai2uXb2G2QZZei89osBiM=;
        b=pPYjDC+PBeywfSqf/UHNyLmjiamcm7/8D6mjbJ4cGnbej4LH4gvruT1pldsMWkoPIo
         gXaDl2wPMEdIo5AYGQJYJxkx1NuymoGGYPoCuwHM8UTHcMVBvJ78RYbLT0oK9f53AVf6
         o+2ZtRTOx6Eirths42EzTdcaGGgC6vidC1BUTrlkYwueU1wKqZ6gd/A8Gz+rROVCF53O
         TzgIuK6SxC/SBf91PAgfFyWsnKjLMqUuDXYuuOnAwRnv1oG4aO0bUKz3c6C9YfmOEMxi
         QAomLtbFVdjyGW/ykqZFh1TLLefdfOQ7UX+uUrmtOeiqZLvLBoQlyeomfNAUYgNLE1S7
         k52w==
X-Gm-Message-State: ABuFfoi5gSccv4S9O5XX5mj8xxFNVbPufVaMxoiJqjiF29F8zbo3esLH
        HEYNvLD/TF+c+Xn8L1RwMp+ZVA==
X-Google-Smtp-Source: ACcGV60SvcDuwwFfUZrEoWm25R56HMmg4aebudF5owuY6h5Fceo65AszhVv0RP3+l3Jd652Z5Qm4rw==
X-Received: by 2002:a63:7b09:: with SMTP id w9-v6mr7023932pgc.385.1539380045793;
        Fri, 12 Oct 2018 14:34:05 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id t85-v6sm3751969pfi.73.2018.10.12.14.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 14:34:04 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 0D98A300030; Sat, 13 Oct 2018 00:34:00 +0300 (+03)
Date:   Sat, 13 Oct 2018 00:33:59 +0300
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
Message-ID: <20181012213359.qpvq3obugbvy73bg@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012131946.zoab2lpfmrycmuju@kshutemo-mobl1>
 <20181012165719.GE223066@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012165719.GE223066@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66797
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

On Fri, Oct 12, 2018 at 09:57:19AM -0700, Joel Fernandes wrote:
> On Fri, Oct 12, 2018 at 04:19:46PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Oct 12, 2018 at 05:50:46AM -0700, Joel Fernandes wrote:
> > > On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> > > > On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > > > > Android needs to mremap large regions of memory during memory management
> > > > > related operations. The mremap system call can be really slow if THP is
> > > > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > > > pte at a time, and can be really slow across a large map. Turning on THP
> > > > > may not be a viable option, and is not for us. This patch speeds up the
> > > > > performance for non-THP system by copying at the PMD level when possible.
> > > > > 
> > > > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > > > 
> > > > > Before:
> > > > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > > > 
> > > > > After:
> > > > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > > > 
> > > > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > > > tlb every time we do this optimization since I couldn't find a way to
> > > > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > > > 
> > > > I looked into the code more and noticed move_pte() helper called from
> > > > move_ptes(). It changes PTE entry to suite new address.
> > > > 
> > > > It is only defined in non-trivial way on Sparc. I don't know much about
> > > > Sparc and it's hard for me to say if the optimization will break anything
> > > > there.
> > > 
> > > Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
> > > not modifying the PTE itself AFAICS:
> > > 
> > > #ifdef DCACHE_ALIASING_POSSIBLE
> > > #define __HAVE_ARCH_MOVE_PTE
> > > #define move_pte(pte, prot, old_addr, new_addr)                         \
> > > ({                                                                      \
> > >         pte_t newpte = (pte);                                           \
> > >         if (tlb_type != hypervisor && pte_present(pte)) {               \
> > >                 unsigned long this_pfn = pte_pfn(pte);                  \
> > >                                                                         \
> > >                 if (pfn_valid(this_pfn) &&                              \
> > >                     (((old_addr) ^ (new_addr)) & (1 << 13)))            \
> > >                         flush_dcache_page_all(current->mm,              \
> > >                                               pfn_to_page(this_pfn));   \
> > >         }                                                               \
> > >         newpte;                                                         \
> > > })
> > > #endif
> > > 
> > > If its an issue, then how do transparent huge pages work on Sparc?  I don't
> > > see the huge page code (move_huge_pages) during mremap doing anything special
> > > for Sparc architecture when moving PMDs..
> > 
> > My *guess* is that it will work fine on Sparc as it apprarently it only
> > cares about change in bit 13 of virtual address. It will never happen for
> > huge pages or when PTE page tables move.
> > 
> > But I just realized that the problem is bigger: since we pass new_addr to
> > the set_pte_at() we would need to audit all implementations that they are
> > safe with just moving PTE page table.
> > 
> > I would rather go with per-architecture enabling. It's much safer.
> 
> I'm Ok with the per-arch enabling, I agree its safer. So I should be adding a
> a new __HAVE_ARCH_MOVE_PMD right, or did you have a better name for that?

I believe Kconfig option is more cononical way to do this nowadays.
So CONFIG_HAVE_ARCH_MOVE_PMD, I guess. Or CONFIG_HAVE_MOVE_PMD.
An arch that supports it would select the option.

> Also, do you feel we should still need to remove the address argument from
> set_pte_alloc? Or should we leave that alone if we do per-arch?
> I figure I spent a bunch of time on that already anyway, and its a clean up
> anyway, so may as well do it. But perhaps that "pte_alloc cleanup" can then
> be a separate patch independent of this series?

Yeah. The cleanup makes sense anyway.

-- 
 Kirill A. Shutemov
