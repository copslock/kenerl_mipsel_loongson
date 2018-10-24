Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 10:37:59 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:38716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeJXIhusFC0i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 10:37:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d2jfpjjB7oLmUkq3D7u7NPvUnHT/Qv4wl7bB9GP1+OQ=; b=dN76Of2NrI7shDByrYt1spoOs
        fBUYXsTsK9Kj4I1LXQDJPK2xbkMaXWpCmI4B0RLlP+9OXOkAtMmh68ZXCVO3S/pBN6dU0lgxD8gWX
        nB/Mk2BBYcQ3IlsOKSD/gdq8fN/Vp8fQ1SEFiYUfrNVfW57MgKQ9LrENYhjAozBIELFjQvTEPJNi5
        bz9uiXLHG17dG6EVwpehVjKZCtfq1bMHlqor9mgtNLP7WP2m2pWVDPspQzaKuMyTnFdPaDUhc/6kR
        mJe495zAtAHoUNeijZ1k8/AMfxQaYrE6a6RZnTBSeFiJ345Pm3weHdfiQbp0l9zYh1YwhM+nt6XPS
        SmRzIXzSw==;
Received: from [185.7.230.213] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFEfH-0004So-Sa; Wed, 24 Oct 2018 08:37:20 +0000
Received: by worktop (Postfix, from userid 1000)
        id EDB716E08AB; Wed, 24 Oct 2018 10:37:16 +0200 (CEST)
Date:   Wed, 24 Oct 2018 10:37:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20181024083716.GN3109@worktop.c.hoisthospitality.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013013200.206928-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> This series speeds up mremap(2) syscall by copying page tables at the
> PMD level even for non-THP systems. There is concern that the extra
> 'address' argument that mremap passes to pte_alloc may do something
> subtle architecture related in the future that may make the scheme not
> work.  Also we find that there is no point in passing the 'address' to
> pte_alloc since its unused. So this patch therefore removes this
> argument tree-wide resulting in a nice negative diff as well. Also
> ensuring along the way that the enabled architectures do not do anything
> funky with 'address' argument that goes unnoticed by the optimization.

Did you happen to look at the history of where that address argument
came from? -- just being curious here. ISTR something vague about
architectures having different paging structure for different memory
ranges.
