Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2018 23:40:23 +0100 (CET)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:37670
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeJ1WkOL1YoB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2018 23:40:14 +0100
Received: by mail-pg1-x541.google.com with SMTP id c10-v6so2938617pgq.4
        for <linux-mips@linux-mips.org>; Sun, 28 Oct 2018 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFtksEV3l5eq+mnfMA1OwOjA0oBp/IcRdRQ8wGi247I=;
        b=hzlz7jFWANzmnQYBfUjAY47ntJv9ruGodd92q7E4yeWjWXy4EZl6bPRcEO0kKVxcET
         8l/LxbyoIEOMIv2Qws7VhhdBdB2WSqhVRO2xFO6BoL6UVCnvmAbklAgUnFIPczbls2XR
         8t+tWl9FODh8azBtSJSVtOJ8ASXQGH4rOt//srkRKwJB3n5TPhA7eLFTkuIKOx//Tn6i
         wCdbM58gxJCZ3Wya+Xx9knz+xP1bKelI2gOlUgbKzh9xt2GwpzMnGwoSI1DVJtDgp4Fn
         d+gXcEV0Ha0CDx7RrL2gR1D2FtTk3tSVbj1J8r71HdedlxSopPgWOCsGk19JAS3kF9ps
         MWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFtksEV3l5eq+mnfMA1OwOjA0oBp/IcRdRQ8wGi247I=;
        b=f4YmYf4ystAX2N6OCCYwRGuc71NsmBOVpaWTsnYSkBP8SkTJIgcjhcA0pp+ZB8WOSu
         9b9SzV1Yv4qw4aWC96py+V+kgto35U7t3m5thTKAFPrL/XmmOw/wnelzC60sPpdvDPiR
         U+jbh9aJw9uU6JmLFvN0q/Gtf6YOG4bNBRjp0TYyHpEAqCvP8xt8TFs7Uu23WkCfiKUI
         5ra9yV2OiigcJun6x5hAU3f4IDurHxLrCk8QVrn+rD4HMLOl3gp6pQwqMXvlSvmenE4C
         Oc4BLVU8r6Q2H+DqQ9rAzCz5TJfB5jvVZISNJJRdD6Yrb46YojlTA5zT5NJBICkCY426
         fWlQ==
X-Gm-Message-State: AGRZ1gJjcRG4YCtczK3yd7Ad5LVbgCLZ+uzvBkZaYfDdUqPwg6qy9tK6
        MXn9OgtJuTDbiBGUUa3aPH8=
X-Google-Smtp-Source: AJdET5fu0DqTEYAGDBSaxsVyd0K3i3CEEiTSqETAuxd4rlFGA5L/e1X97o5DIUSGPTfJJWdGWN6dQw==
X-Received: by 2002:a63:181:: with SMTP id 123-v6mr11570471pgb.149.1540766407194;
        Sun, 28 Oct 2018 15:40:07 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id t4-v6sm19146464pfb.44.2018.10.28.15.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 15:40:05 -0700 (PDT)
Date:   Mon, 29 Oct 2018 09:40:02 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20181028224002.GA16399@350D>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181025021350.GB13560@joelaf.mtv.corp.google.com>
 <20181027102102.GO8537@350D>
 <20181027193917.GA51131@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027193917.GA51131@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <bsingharora@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bsingharora@gmail.com
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

On Sat, Oct 27, 2018 at 12:39:17PM -0700, Joel Fernandes wrote:
> Hi Balbir,
> 
> On Sat, Oct 27, 2018 at 09:21:02PM +1100, Balbir Singh wrote:
> > On Wed, Oct 24, 2018 at 07:13:50PM -0700, Joel Fernandes wrote:
> > > On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> > > [...]
> > > > > > +		pmd_t pmd;
> > > > > > +
> > > > > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > > > 
> > > > 
> > > > Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> > > > the code applies, why not just reuse as much as possible? The same comments
> > > > w.r.t mmap_sem helping protect against lock order issues applies as well.
> > > 
> > > I thought about this and when I looked into it, it seemed there are subtle
> > > differences that make such sharing not worth it (or not possible).
> > >
> > 
> > Could you elaborate on them?
> 
> The move_huge_page function is defined only for CONFIG_TRANSPARENT_HUGEPAGE
> so we cannot reuse it to begin with, since we have it disabled on our
> systems. I am not sure if it is a good idea to split that out and refactor it
> for reuse especially since our case is quite simple compared to huge pages.
> 
> There are also a couple of subtle differences between the move_normal_pmd and
> the move_huge_pmd. Atleast 2 of them are:
> 
> 1. We don't concern ourself with the PMD dirty bit, since the pages being
> moved are normal pages and at the soft-dirty bit accounting is at the PTE
> level, since we are not moving PTEs, we don't need to do that.
> 
> 2. The locking is simpler as Kirill pointed, pmd_lock cannot fail however
> __pmd_trans_huge_lock can.
> 
> I feel it is not super useful to refactor move_huge_pmd to support our case
> especially since move_normal_pmd is quite small, so IMHO the benefit of code
> reuse isn't there very much.
>

My big concern is that any bug fixes will need to monitor both paths.
Do you see a big overhead in checking the soft dirty bit? The locking is
a little different. Having said that, I am not strictly opposed to the
extra code, just concerned about missing fixes/updates as we find them.
 
> Do let me know your thoughts and thanks for your interest in this.
> 
>

Balbir Singh. 
