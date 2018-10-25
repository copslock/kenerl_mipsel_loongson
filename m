Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2018 04:21:33 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:44475
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeJYCV2dTvyJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2018 04:21:28 +0200
Received: by mail-pg1-x543.google.com with SMTP id w3-v6so3238896pgs.11
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3qWVWJhvBgQDe8YRsbgtRjpHQfuWQV3NPWrQqOgjm0=;
        b=WhUgko4o5JcJhUwoWI8kPjvkrH9YQTvlMUDHtdL2JJ5mCTuig+Mqt2sFNrTVhmJSgZ
         34O62c+REJyhBfJwS4DhKcn3WHO4O/TKsj/DlxdzkUHTNLB9x+bJAzgHPxnnVjbdI5DC
         PQKlOZe6+0JIfKGXqhkPj1W7WBMfDG+7PFQCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3qWVWJhvBgQDe8YRsbgtRjpHQfuWQV3NPWrQqOgjm0=;
        b=XQJhQLvOHBcfoZxWzZeXdOd7tS239yyuL9wd6GafxjNZZZhrVEuH+raNqRaqCCfati
         SD2ny5XfczDDehbRtGfcufZU7bbxlUV3swT8xQBZTWdw128d8AkCfG4TRlEiAgr+ZJ4u
         OMWYrfoDCdfHS2EzXbyfxdwgDLIVlsuGbe/pscYqJS9NZRyg81S73RS887HK9ZciOxbt
         /eYW/cGg1NqagIxYs+W/7ruD8oC5z4r7ROYvEsGaDpMIXPYCG61UxlwbCDWoA4sihpwP
         99pHunlc/Yk7jJ+VweRpaAfiJ75P3qFwtUz64i6nLsd/uRuXojVjiD4Abq1PzPZ2/zEv
         KFkg==
X-Gm-Message-State: AGRZ1gJOA/O3k2oilIHYMiOjTmaVb/vLEdw0YJtxPDJvzYhkBS8J7Rok
        hAO6wcKSqDYAq0yHfK6bSndp0w==
X-Google-Smtp-Source: AJdET5fQ846491taIkpUacXcNZHbPUwGXEdQnQATNy2W0qACW8LZiE3r2xKx5hJLJ1WKuWwXbkkY2Q==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr4758613pgd.110.1540434081712;
        Wed, 24 Oct 2018 19:21:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8041192pfs.108.2018.10.24.19.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 19:21:20 -0700 (PDT)
Date:   Wed, 24 Oct 2018 19:21:19 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>, akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
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
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, lokeshgidra@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 1/4] treewide: remove unused address argument from
 pte_alloc functions (v2)
Message-ID: <20181025022119.GC13560@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
 <20181024083716.GN3109@worktop.c.hoisthospitality.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024083716.GN3109@worktop.c.hoisthospitality.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66933
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

On Wed, Oct 24, 2018 at 10:37:16AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> > This series speeds up mremap(2) syscall by copying page tables at the
> > PMD level even for non-THP systems. There is concern that the extra
> > 'address' argument that mremap passes to pte_alloc may do something
> > subtle architecture related in the future that may make the scheme not
> > work.  Also we find that there is no point in passing the 'address' to
> > pte_alloc since its unused. So this patch therefore removes this
> > argument tree-wide resulting in a nice negative diff as well. Also
> > ensuring along the way that the enabled architectures do not do anything
> > funky with 'address' argument that goes unnoticed by the optimization.
> 
> Did you happen to look at the history of where that address argument
> came from? -- just being curious here. ISTR something vague about
> architectures having different paging structure for different memory
> ranges.

I didn't happen to do that analysis but from code analysis, no architecutre
is using it. Since its unused in the kernel, may be such architectures don't
exist or were removed, so we don't need to bother? Could you share more about
your concern with the removal of this argument?

thanks,

 - Joel
