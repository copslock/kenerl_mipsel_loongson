Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2018 12:21:21 +0200 (CEST)
Received: from mail-pl1-x641.google.com ([IPv6:2607:f8b0:4864:20::641]:42296
        "EHLO mail-pl1-x641.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJ0KVOuU5sh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Oct 2018 12:21:14 +0200
Received: by mail-pl1-x641.google.com with SMTP id t6-v6so1615899plo.9
        for <linux-mips@linux-mips.org>; Sat, 27 Oct 2018 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ytoc7E/E+CDN+36oMCq4ib7UWrIKwi1XigueqliThJE=;
        b=ab1knh/8i2Gpv4Vxfi+YDSBKbX/LgufE79cYPr5GJEdQUVQbI970thsDIy0ZjV1q0k
         ZSfcWvh4GTM9Brshk9p+y4tQ9MlVv9xCOgRN+Mkl3IacQhaurmJjOF4ISMav3UWSPWT0
         QDI4JUUMAIPA35q0/cXsitIc3ySa7+/5ANkq6TLz2UHPpSbIN1fzgNHsIaIbSC3XX++1
         mylMnA2ff0XDd2sL+yXZDHQHXijLBXi1MJNMHNoE52RFFgyL7H1Hr53le1mRs/9vRlLJ
         8fln4V5coK7PbseEtgyE6znLwjAsimR/DLzPXzQyaRXpcBZcO/1WMqn8CO3ILrNZhl0z
         +0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ytoc7E/E+CDN+36oMCq4ib7UWrIKwi1XigueqliThJE=;
        b=kfiL9ryECWYnVNRcTZXIrLppSaDz0Q11zZuPtWyogwjLwzOvG4KvXL6dYd7thbTy4V
         CA8v7FnuBh8uwOgH+PhQUpIkn+YdTgHvh2fBvtxeG5vXUTr4fPdw2VGGqPAZQDD+BsGM
         Hlfvcx7jVfoXhmGwza1aqUMOC30QVvEZBsQrDUZf+Rf8CUHW0j8KdDA/Aqt9g80jHm/x
         CK7vc7Isj7KAvwML9vSEEdz0zSAHO2JEe0n3DNW5dmpsP27QC/nHff71OeHXprNozS2I
         7fbVWT9MvDZRO0uaJ+Jy1XmlnQILzB9DUZuJWtGiGicwpI0QJi4op2wgWaH6NeseUlVu
         zWUQ==
X-Gm-Message-State: AGRZ1gKIVdNZCYaKGy83V484T3ZYuuh2kh2AOkLc2cszc+dPbXPFwa+Q
        jrV0DSTPEf2QrdQL9jT8vp4=
X-Google-Smtp-Source: AJdET5dClbYQTLuFDbJ+0gDgS5/Hrs1bQO5PPuAbjI+vFXrDoU6PrAD4ZO8YmfARdAwQaa7m0KGriw==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3-v6mr6882579plt.339.1540635667807;
        Sat, 27 Oct 2018 03:21:07 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id z129-v6sm17506690pfb.40.2018.10.27.03.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 03:21:06 -0700 (PDT)
Date:   Sat, 27 Oct 2018 21:21:02 +1100
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
Message-ID: <20181027102102.GO8537@350D>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181025021350.GB13560@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025021350.GB13560@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <bsingharora@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66964
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

On Wed, Oct 24, 2018 at 07:13:50PM -0700, Joel Fernandes wrote:
> On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> [...]
> > > > +		pmd_t pmd;
> > > > +
> > > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > 
> > 
> > Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> > the code applies, why not just reuse as much as possible? The same comments
> > w.r.t mmap_sem helping protect against lock order issues applies as well.
> 
> I thought about this and when I looked into it, it seemed there are subtle
> differences that make such sharing not worth it (or not possible).
>

Could you elaborate on them?

Thanks,
Balbir Singh. 
