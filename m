Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2018 10:56:59 +0200 (CEST)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:55404 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992869AbeJZI4sdijEc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2018 10:56:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t4U6dJOCnA0c/EZV0nmuSLy/HD8d4dYO3ZonI67d8Vk=; b=DPhftboxJNVK8gljOSI9ek+lk
        cu0xqt1kC5w7yCxw6Jsznw1tHw2bNfFS/B99G90XrfF2EouGTY+fnjyh2fFe8Ea4pm+LfBzpKsORm
        vHKSHxTajvN1zlzwJSY3IQRIoUSjK9Ks0EaN70/cGAc3V1cVwVubUjQU8B8T3dcCN+Cny2z4IXEkf
        5989+J/lbf4qCCiiXPFuktGNapnha5La8DRY2VrXPeyZAvzLzZFAr0KwXyN2xKeaZefS1TlUOUz9Q
        v3E0AoVoDPrDe463fQg0erQi1phVVaaGU+vviNvYVqHIgoubM4nIzXXBkEBYhhWFO095CIUsfkQj8
        Onm8/N6Lg==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFxuk-00012P-H7; Fri, 26 Oct 2018 08:56:18 +0000
Received: by worktop (Postfix, from userid 1000)
        id 7F67E6E07BE; Fri, 26 Oct 2018 10:50:47 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:50:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
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
Message-ID: <20181026085047.GB3109@worktop.c.hoisthospitality.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
 <20181024083716.GN3109@worktop.c.hoisthospitality.com>
 <20181025104703.esl6wxyg2ihe4zoc@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025104703.esl6wxyg2ihe4zoc@kshutemo-mobl1>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66955
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

On Thu, Oct 25, 2018 at 01:47:03PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 24, 2018 at 10:37:16AM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> > > This series speeds up mremap(2) syscall by copying page tables at the
> > > PMD level even for non-THP systems. There is concern that the extra
> > > 'address' argument that mremap passes to pte_alloc may do something
> > > subtle architecture related in the future that may make the scheme not
> > > work.  Also we find that there is no point in passing the 'address' to
> > > pte_alloc since its unused. So this patch therefore removes this
> > > argument tree-wide resulting in a nice negative diff as well. Also
> > > ensuring along the way that the enabled architectures do not do anything
> > > funky with 'address' argument that goes unnoticed by the optimization.
> > 
> > Did you happen to look at the history of where that address argument
> > came from? -- just being curious here. ISTR something vague about
> > architectures having different paging structure for different memory
> > ranges.
> 
> I see some archicetures (i.e. sparc and, I believe power) used the address
> for coloring. It's not needed anymore. Page allocator and SL?B are good
> enough now.
> 
> See 3c936465249f ("[SPARC64]: Kill pgtable quicklists and use SLAB.")

Ah, shiny. Thanks.
