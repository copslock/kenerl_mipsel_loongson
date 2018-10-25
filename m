Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2018 04:14:02 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:38559
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeJYCN7SlZQJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2018 04:13:59 +0200
Received: by mail-pf1-x443.google.com with SMTP id b11-v6so1732499pfi.5
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 19:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5CbWcmgaWhK69oh2DEOguVgA2uKl1YpKoqaGwtGwge8=;
        b=q/q3QTdACzUlPpDQMN1kjcezMfcsn0Yv6fXB6ODPHDCxjW91L/KWd7ad+HnYMhVDLK
         4w8FEyzAp+rB09Si8JZs7MJE9NTlxjm6PO3Hk2MpIdxGl6P2KagjiLkUB/ExO2oGujpm
         CSZTqm0K2zOVm+Foil/VJrYg2JhZozpJsR9l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5CbWcmgaWhK69oh2DEOguVgA2uKl1YpKoqaGwtGwge8=;
        b=FIhvSz7hcL2/UuGQ19+CXFO+V+brwzV22Nwi4xisB+biFU72j8FgobQjqvOIqRlsWG
         w8ap6eJXAyaO1kQ3F0/4WgXRqAsZd3CTe5jSvOalIbye6HfH4HFAtv61+RovkCXaUsVv
         jYp54D0kV8bO8W+c1BAGAIQ+QKAluhUP75yDyaAtr+AjYSZcn0MFFH1UvCX8rVixYz/x
         1q+yZeKDZXeLh2N1NUSaGPbPsmFPNSamsU+Pd0g4lCtKn9i+90hfbSHQsGWsYaL0DmD9
         QatGuPFmRdZc6Vh8o/vRTXbFCKBITatFKo6OXe0W27FqOdPd0Zd2qFA4ghR/W8mbFifG
         KGeA==
X-Gm-Message-State: AGRZ1gJ8rDlIWwBzVP9YJTqwuZshwnhH4Igm29jsqGp+brjzWKNpUoqW
        +yBGAnxxeMzLIexyMAuMcxsJ9w==
X-Google-Smtp-Source: AJdET5dpMwn85VnY2OpxFWBdTBIZT6WEknqSNasg/mS3JU0dLY8ImJjZVFsNiBwxQlcm8wQ3lAxw+Q==
X-Received: by 2002:a63:441f:: with SMTP id r31-v6mr4853133pga.60.1540433632120;
        Wed, 24 Oct 2018 19:13:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 73-v6sm774464pft.178.2018.10.24.19.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 19:13:50 -0700 (PDT)
Date:   Wed, 24 Oct 2018 19:13:50 -0700
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
Message-ID: <20181025021350.GB13560@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024115733.GN8537@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66932
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

On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
[...]
> > > +		pmd_t pmd;
> > > +
> > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> 
> 
> Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> the code applies, why not just reuse as much as possible? The same comments
> w.r.t mmap_sem helping protect against lock order issues applies as well.

I thought about this and when I looked into it, it seemed there are subtle
differences that make such sharing not worth it (or not possible).

 - Joel
