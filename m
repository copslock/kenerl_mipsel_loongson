Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2018 21:39:29 +0200 (CEST)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:42866
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbeJ0Tj0ulzZ- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Oct 2018 21:39:26 +0200
Received: by mail-pl1-x644.google.com with SMTP id t6-v6so1966132plo.9
        for <linux-mips@linux-mips.org>; Sat, 27 Oct 2018 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHWCz3fu9TpC7J2ei9HeEkNKgFxDHuGGuLqn4Rh+JHE=;
        b=QPtsyBSUj6AojIo85azY8oUVJwGhm0RIqVohzSIMkkWGL/CZwEBPHYTna50E7Om4WA
         F5z18wGfy8lz5xFwg1vCwZ9ySWUf9QkWrrkAXwGsE1TwsrZ1HoqAWixpXJ3DliywdJzW
         CxbFyNe852Wb89cMxFXqW5ZHR3ew/TXqEJ1ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHWCz3fu9TpC7J2ei9HeEkNKgFxDHuGGuLqn4Rh+JHE=;
        b=eLNz+xOFvbsLa5RLzqUEJT1L19NCwlibrImcBm2bU7ifvL3l1QOP2vpTVeq9+dFTNT
         FEZh4i6GADvKRQpasVXKfLgYDUe0UgLai6Opna92vCurFWKOHKgup2QY+r3ejI99YEet
         lcQs6jtMe8REp8U+3h2Pk0AnJMOVy+cRmjiQ2/ZmioqfW8JQr8VW6z1kcMj5AV2zrSa7
         DeJk0G2i+QTYwv6/DZDbD3J371fX6F7S7QkUJyaDYU+/yAgMq8XZc0Tcieq/f1mwkGZk
         B06M2frLmUtQRx4LLEgHbtvA47HbDfh0BqSR+bIFKUyLmubrfsJ2k212i342hPoOFFv+
         xlFA==
X-Gm-Message-State: AGRZ1gIF6JMUS/0b0+mQW1AT+qQLvoi+jZN9gIUwdnLAolLn+gLS9Cuv
        EA5jbdvOOqYdEOMrPTS2BgfbQg==
X-Google-Smtp-Source: AJdET5f21mfpbfgLffX+k0qGngh7x8A4g9m9LTX1FSqvBjQFfP0xKIMF/O60+aOyl9qi4XLET8IsYQ==
X-Received: by 2002:a17:902:3381:: with SMTP id b1-v6mr8190467plc.323.1540669159792;
        Sat, 27 Oct 2018 12:39:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 11-v6sm23945581pfs.108.2018.10.27.12.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 12:39:18 -0700 (PDT)
Date:   Sat, 27 Oct 2018 12:39:17 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <20181027193917.GA51131@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181025021350.GB13560@joelaf.mtv.corp.google.com>
 <20181027102102.GO8537@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027102102.GO8537@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66965
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

Hi Balbir,

On Sat, Oct 27, 2018 at 09:21:02PM +1100, Balbir Singh wrote:
> On Wed, Oct 24, 2018 at 07:13:50PM -0700, Joel Fernandes wrote:
> > On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> > [...]
> > > > > +		pmd_t pmd;
> > > > > +
> > > > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > > 
> > > 
> > > Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> > > the code applies, why not just reuse as much as possible? The same comments
> > > w.r.t mmap_sem helping protect against lock order issues applies as well.
> > 
> > I thought about this and when I looked into it, it seemed there are subtle
> > differences that make such sharing not worth it (or not possible).
> >
> 
> Could you elaborate on them?

The move_huge_page function is defined only for CONFIG_TRANSPARENT_HUGEPAGE
so we cannot reuse it to begin with, since we have it disabled on our
systems. I am not sure if it is a good idea to split that out and refactor it
for reuse especially since our case is quite simple compared to huge pages.

There are also a couple of subtle differences between the move_normal_pmd and
the move_huge_pmd. Atleast 2 of them are:

1. We don't concern ourself with the PMD dirty bit, since the pages being
moved are normal pages and at the soft-dirty bit accounting is at the PTE
level, since we are not moving PTEs, we don't need to do that.

2. The locking is simpler as Kirill pointed, pmd_lock cannot fail however
__pmd_trans_huge_lock can.

I feel it is not super useful to refactor move_huge_pmd to support our case
especially since move_normal_pmd is quite small, so IMHO the benefit of code
reuse isn't there very much.

Do let me know your thoughts and thanks for your interest in this.

thanks,

 - Joel
