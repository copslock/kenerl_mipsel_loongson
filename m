Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 05:38:06 +0100 (CET)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:41200
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990471AbeKFEgD5U8vf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 05:36:03 +0100
Received: by mail-pg1-x541.google.com with SMTP id k13so5236007pga.8
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2018 20:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZO7f7AbR0Q/Tv9r9GFR6EhQOtVlvtqVzi+kHQIwd6Q=;
        b=vFP1Hs1wYQcIlWGzK/RquQm7mPiYOK37zkYc9g7HM5f1UakBrd0LproiSxWxB+J+cw
         LwUgBiOgB/Mof2uCb5M7ypmLMYM7sa/OYV8c2R4EJZNkyEzkll/fFaiA1VN/bVpLQDnv
         N2x7os/SUx/84UCqqI0dyLJ344I+8ENkn6mEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZO7f7AbR0Q/Tv9r9GFR6EhQOtVlvtqVzi+kHQIwd6Q=;
        b=anop37+l/8MioUVLm0fXRC235BLsdDAEDwx/XHEtXFyTDFyb76kXEO5rvnqgfKjD3Y
         OGC744PnyppfccNxW3npJpIPRC/Fh9vPYohIVMKWWhUUbat2aj7lUQZtbCFMs/9h9j8U
         BL9fDggSxWWlo49KHZP1ijUXLKt7To44U3PPuQsbq0CbugY/VLCF7ykZJy5seNg2SEdd
         99g2YSovr2jGZ3wE8bCP2NIZk3dHyBm4eyU2p22Ka8umxNulUWGsiy6neT2jzGV40/aV
         VbBVHvnfy4c8muJXDZVVhl352Y0nfoEcJnzdhgbPXn87Zq4CAnZ0lCtU56xs7vmmF7qZ
         LSTA==
X-Gm-Message-State: AGRZ1gJE3S15Ld9fgWzYE7BAzQhtc/UbZ44oqnmoXLj9RyufpNqrnMdh
        kDN5am36uvQUZrb0uHtN+o7diw==
X-Google-Smtp-Source: AJdET5ecnHmWHapBSfgQDaRa+d8XuLQo3dJlBpesDCXVYTiF4QhB2rt8xq4tK8y9MBGhfwYqJFpEjQ==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr21579640pgb.357.1541478962566;
        Mon, 05 Nov 2018 20:36:02 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id c87-v6sm43985294pfe.93.2018.11.05.20.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 20:36:01 -0800 (PST)
Date:   Mon, 5 Nov 2018 20:36:00 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
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
        kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        kvmarm@lists.cs.columbia.edu, Ley Foon Tan <lftan@altera.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vge.kvack.org, r.kernel.org@lithops.sigma-star.at,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
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
Message-ID: <20181106043600.GB139199@google.com>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
 <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
 <20181103183208.GA56850@google.com>
 <D6FB3C15-A8C1-4694-A434-A7489F590E05@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6FB3C15-A8C1-4694-A434-A7489F590E05@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67096
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

On Sun, Nov 04, 2018 at 12:56:48AM -0600, William Kucharski wrote:
> 
> 
> > On Nov 3, 2018, at 12:32 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > Looks like more architectures don't define set_pmd_at. I am thinking the
> > easiest way forward is to just do the following, instead of defining
> > set_pmd_at for every architecture that doesn't care about it. Thoughts?
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 7cf6b0943090..31ad64dcdae6 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -281,7 +281,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> > 			split_huge_pmd(vma, old_pmd, old_addr);
> > 			if (pmd_trans_unstable(old_pmd))
> > 				continue;
> > -		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
> > +		} else if (extent == PMD_SIZE) {
> > +#ifdef CONFIG_HAVE_MOVE_PMD
> > 			/*
> > 			 * If the extent is PMD-sized, try to speed the move by
> > 			 * moving at the PMD level if possible.
> > @@ -296,6 +297,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> > 				drop_rmap_locks(vma);
> > 			if (moved)
> > 				continue;
> > +#endif
> > 		}
> > 
> > 		if (pte_alloc(new_vma->vm_mm, new_pmd))
> > 
> 
> That seems reasonable as there are going to be a lot of architectures that never have
> mappings at the PMD level.

Ok, I will do it like this and resend.

> Have you thought about what might be needed to extend this paradigm to be able to
> perform remaps at the PUD level, given many architectures already support PUD-mapped
> pages?
> 

I have thought about this. I believe it is doable in the future. Off the top
I don't see an issue doing it, and it will also reduce the number of flushes.

thanks,

- Joel
