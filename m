Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 18:39:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:16408
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLQjJI79cf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 18:39:09 +0200
X-IronPort-AV: E=Sophos;i="5.54,373,1534802400"; 
   d="scan'208";a="281932428"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 18:39:00 +0200
Date:   Fri, 12 Oct 2018 18:38:57 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        lokeshgidra@google.com, linux-riscv@lists.infradead.org,
        elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
        linux-s390@vger.kernel.org, dancol@google.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-snps-arc@lists.infradead.org, kernel-team@android.com,
        Sam Creasey <sammy@sammy.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-m68k@vger.kernel.org, openrisc@lists.librecores.org,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
        Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-parisc@vger.kernel.org, pantin@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
In-Reply-To: <20181012163433.GA223066@joelaf.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1810121838180.4366@hadrien>
References: <20181012013756.11285-1-joel@joelfernandes.org> <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk> <20181012163433.GA223066@joelaf.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <julia.lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia.lawall@lip6.fr
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

> I wrote something like this as below but it failed to compile, Julia any
> suggestions on how to express this?
>
> @pte_alloc_func_proto depends on patch exists@
> type T1, T2, T3, T4;
> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> @@
>
> (
> - T3 fn(T1, T2);
> + T3 fn(T1);
> |
> - T3 fn(T1, T2, T4);
> + T3 fn(T1, T2);
> )

What goes wrong?  It seems fine to me.

julia
