Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 13:31:11 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:39319
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJLLbImLxfT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 13:31:08 +0200
Received: by mail-pf1-x444.google.com with SMTP id c25-v6so6060868pfe.6
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7AhKnmfvmp8KBJvG0N/KXKa/mMdyWfz5lA4HnS7BL8=;
        b=g54sfYi+w0crnYiSByxg5Nkl3eGqhJ6PN3wZFl+ctMzP2ovV+r5fma35R0NtLVm7f4
         n5dBPdHh/h+S00ymRa9yXbYyWCDNbz5qTo9fbzEBNajxgbVXHatOXKhWE2ymaeXn4b5+
         3y3wh4nrJJVcwBsKyp1ZdwGny9fgiF2ZGJoiLdnlO2hbOpRXU/jsB85IrZoJ+NpUk4uq
         jaOW+U4M0qLfRnRGAkxWtj5pjU2u4VJgE+Mmaw1D6h2dqW+o9dFjgqSLLoVlGTHQkemb
         O2qFRHSU7x5ebQd3d+IhwBYfRwpZqwIx0EmzYxOFIjiVnHWgdZ7DEtkH2GtuE3Iit1L9
         iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7AhKnmfvmp8KBJvG0N/KXKa/mMdyWfz5lA4HnS7BL8=;
        b=H+9vLkuqlOm3Qgx/EDiPxw7gRqYCmcgTMGlOYB+QgjUvPRN/1yN6LvHHY8tGH8a25d
         4f9ISwNC+0636ILyG2sHKJN8Pu8xu/XHzmZl8uviJ8/nnfGoFh40loraTu+orNrMWY78
         FKiAuCR5TlOzgSEl6pbq3NedwcbqqA8fZe9cSgPQDO1jxI1leF7yFAvSrGWB890x32Yk
         iMqyaW80E2YRAKxkLVfzZS/Mbp0rh2GFVc9FubfRLoEykvOfPs8YApUwescPE6n2uMkk
         2eSiOMfN0fXRKDeHizoPdTVGUIqs8URVmg4Du4s93J3DNvKp83nHHvsXyRZXfWRT/A+B
         jdWQ==
X-Gm-Message-State: ABuFfogfepWD5m6kC7kybpJmN6cP+FfrIU4j3sUxC54Ab1xfyyzWUsL5
        esveTtkwUEi3xGGEP2hvOGpDjg==
X-Google-Smtp-Source: ACcGV62lBfke4Nd6rzFvvGEYe+NYu7uJH2YfYRGmsZVhWDnzIbZPXUe0wUiVZh6jfZwYAfZZwYDRWA==
X-Received: by 2002:a63:194a:: with SMTP id 10-v6mr5233013pgz.192.1539343861937;
        Fri, 12 Oct 2018 04:31:01 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id o12-v6sm1985263pfh.20.2018.10.12.04.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:31:00 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 6FFFA300030; Fri, 12 Oct 2018 14:30:56 +0300 (+03)
Date:   Fri, 12 Oct 2018 14:30:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012013756.11285-2-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66767
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

On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> Android needs to mremap large regions of memory during memory management
> related operations. The mremap system call can be really slow if THP is
> not enabled. The bottleneck is move_page_tables, which is copying each
> pte at a time, and can be really slow across a large map. Turning on THP
> may not be a viable option, and is not for us. This patch speeds up the
> performance for non-THP system by copying at the PMD level when possible.
> 
> The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> completion times drops from 160-250 millesconds to 380-400 microseconds.
> 
> Before:
> Total mremap time for 1GB data: 242321014 nanoseconds.
> Total mremap time for 1GB data: 196842467 nanoseconds.
> Total mremap time for 1GB data: 167051162 nanoseconds.
> 
> After:
> Total mremap time for 1GB data: 385781 nanoseconds.
> Total mremap time for 1GB data: 388959 nanoseconds.
> Total mremap time for 1GB data: 402813 nanoseconds.
> 
> Incase THP is enabled, the optimization is skipped. I also flush the
> tlb every time we do this optimization since I couldn't find a way to
> determine if the low-level PTEs are dirty. It is seen that the cost of
> doing so is not much compared the improvement, on both x86-64 and arm64.

I looked into the code more and noticed move_pte() helper called from
move_ptes(). It changes PTE entry to suite new address.

It is only defined in non-trivial way on Sparc. I don't know much about
Sparc and it's hard for me to say if the optimization will break anything
there.

I think it worth to disable the optimization if __HAVE_ARCH_MOVE_PTE is
defined. Or make architectures state explicitely that the optimization is
safe.

> @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  			split_huge_pmd(vma, old_pmd, old_addr);
>  			if (pmd_trans_unstable(old_pmd))
>  				continue;
> +		} else if (extent == PMD_SIZE) {

Hm. What guarantees that new_addr is PMD_SIZE-aligned?
It's not obvious to me.

-- 
 Kirill A. Shutemov
