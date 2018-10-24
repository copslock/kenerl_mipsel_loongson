Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 14:57:40 +0200 (CEST)
Received: from mail-pl1-x641.google.com ([IPv6:2607:f8b0:4864:20::641]:34333
        "EHLO mail-pl1-x641.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991162AbeJXM5hRDbhL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 14:57:37 +0200
Received: by mail-pl1-x641.google.com with SMTP id f10-v6so2216613plr.1
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u4uba2fx6yj15XJfXzXAGhRcWjDfkikfuZTGMLXtNuw=;
        b=QUWcy6Sl2uKBSxMKyAQKgPHaaZkxUyGKW1j/tcrhbSXB3vW5a56lXmFSTP0gzGbZK3
         vffkJDQW2WMbIFLuD1+6ufBku/+pf6UeruhfzRwNYwFgIuIJTiBEFtQd6OUHFAQ6eayl
         P+oyst7tx7B2tcyac+nAMIUnZnHfXCn48NySbAEzmKBcKrbkCpbDR97BYPvJugxN++Cj
         APyxLuPJd0VjY9bkSUeFLpZ1THRyudEGwY77knuPasZkTOLS31IxwdJtMwVSEmSEjNTT
         gafpbeBUtbqb+qibgmoy3fyXe8MHjyx6PnKU0Is89VSk3GMj5Rt4EKiaVNHGw+K4Tm+L
         MPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u4uba2fx6yj15XJfXzXAGhRcWjDfkikfuZTGMLXtNuw=;
        b=HMtu/ZjHAVh1In6JG84lontg63nUAJM3sfbeLqZTop6s+k8C2wgJdEum+52JIg5ryZ
         51iS43A3dDy4sqrinN+CgQ4bVFkS6F/lYOmFfudJwFraHkUeCasszl2TEXL4evCdaS1y
         2sGdqbYGhyoh0ssngODKOJWyEvIMlNhE47EO57hQgs7hveNFMaX6hoMHaxraspQebD6V
         HR0zBAc0nbfDQH5hv+o8NXkM6tOm+QmBwbJiV0fulbHxkbkCugluuOAWDzpZfwnFwqVI
         I/tUIjccJfcCdemqSpfkGilxh6gG7Fr5HIjd+J43M9PBzxJAJ9eVg7unt17edipThVKg
         flrg==
X-Gm-Message-State: AGRZ1gJrSCiRR1oUkdzS8KrnwxSxpIbwnB9dg451aXXKFyjCwHTw77QS
        n+Uh3ciyLKDk/5pmXARlBHkvHw==
X-Google-Smtp-Source: AJdET5f0Q09g2nkZdpmB3hAoSyWMxOfqRQx8u4VGhcieEr9jQ0pioGElufWMbGpMlhoL8pENMWgATQ==
X-Received: by 2002:a17:902:bf02:: with SMTP id bi2-v6mr2470661plb.186.1540385850462;
        Wed, 24 Oct 2018 05:57:30 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id l83-v6sm10557314pfi.172.2018.10.24.05.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 05:57:29 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1845F300225; Wed, 24 Oct 2018 15:57:24 +0300 (+03)
Date:   Wed, 24 Oct 2018 15:57:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        minchan@kernel.org, pantin@google.com, hughd@google.com,
        lokeshgidra@google.com, dancol@google.com, mhocko@kernel.org,
        akpm@linux-foundation.org,
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
Message-ID: <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024115733.GN8537@350D>
User-Agent: NeoMutt/20180716
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66919
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

On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> On Wed, Oct 24, 2018 at 01:12:56PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index 9e68a02a52b1..2fd163cff406 100644
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
> > 
> > How can it ever be false?
> > 
> > > +		pmd_t pmd;
> > > +
> > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> 
> 
> Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> the code applies, why not just reuse as much as possible? The same comments
> w.r.t mmap_sem helping protect against lock order issues applies as well.

pmd_lock() cannot fail, but __pmd_trans_huge_lock() can. We should not
copy the code blindly.

-- 
 Kirill A. Shutemov
