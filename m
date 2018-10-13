Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 11:25:36 +0200 (CEST)
Received: from mout.web.de ([212.227.15.14]:37645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990406AbeJMJZdmYC1G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Oct 2018 11:25:33 +0200
Received: from [192.168.1.2] ([77.182.109.121]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljgd6-1fe7F90cKO-00bZio; Sat, 13
 Oct 2018 11:23:11 +0200
Received: from [192.168.1.2] ([77.182.109.121]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljgd6-1fe7F90cKO-00bZio; Sat, 13
 Oct 2018 11:23:11 +0200
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Michal Hocko <mhocko@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "James E. J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        pantin@google.com, Lokesh Gidra <lokeshgidra@google.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
 <20181012194210.GA27630@joelaf.mtv.corp.google.com>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e1be1dda-90ab-052d-496b-3de01ffc80d1@users.sourceforge.net>
Date:   Sat, 13 Oct 2018 11:22:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181012194210.GA27630@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:opVsTsdRSQYHnglK8xvkCUZUswSzgAiKoS+KIhCNIvHd3Yq3Ufx
 ceTjZIQMEq4s0BqtUDsQA+V/NSZ/iWF9ovz8l3V5T+EzWg7BbDd+DB1TsHw9ObirhajDCPf
 m94io4so/kUaQ+paPJXJjuENjQDWI0XLcPpR7a3huBeUNpGTXKQjSmr/JDL+b4gW6p57u4Z
 1BzRLcEsMoiZQwc663VQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v6MarwJQGgc=:Ymq3Px86/PQtPzMwB8SDWz
 2sVTW3LAMS2aIZ8Ekzl7/SDvldDrpm06rM73xwb0uYPMZ3GHwT//p8vaal6x17s8ay7WilQrz
 K1Bg967tVvkE9O+bHYv3RH85K5N3GlfnSnpVrzbF5FATwM77bmyW3MOdfKY7APM2E6r4svqKH
 MjIc6EhkL1944Pl4HVJszGwMBqx/ea3HMQWVGQE7Fd0Ebm1oh0deQfClHVkLGh8/eDgF8Djb6
 zhE9SKkfVZD6CWg7y9Zr8UuLknPaHhds4jQlAMO+YyPfNMHH3UXbXN3LViy8PQi9Sfu/wr8jr
 3+NabdySRdW+Eh9PkizWR+WbpiupacwKtItrKdb/mvDoVJACLixppwElNeEYZJCv3pD52wuiM
 eNEH08JILjZld6narndqV/zqIowHw7k2AsltgBKw0Mqlcd3QvKYQQZP0kzRbToXq5ZBasFKx6
 U+BMMQhDfw/6IIb5b051oCjD+wiruFio921rpsNCRU5y6aHnm+w7j8hRQukryGIa8LOrD4JCW
 yaRthF7hb06kDcJkklIkR9xn6uu3m37H3Ya+z/Dsj+VDmHFNkctUwe9XY3r0EKO0MJqy4riYs
 Lund5+9Dymq/dXSENAL9MmfFRdRSfOQ12yYUHLRKcOYrSNFpBluxLsiBkqcJq5jwuxdjSZhRe
 QzXp5jsYL6wwfiq9dly7RAYyGqQBu1TI8IMDHj5CyOWHrrPCt6S8e7162OjoHxsMqNTW8Aaoo
 z0PdDLyq3fVbSyAsDljIS3uoxrzwE7ryXbtER5vO5qv8MegP+wfnql8gFgSZR2DOoTwd1GhVk
 Nw4MxMBjGx6rPT068O9XO/l/2SyaNynS07fdGT4KUxwYM+p1nk=
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

>>> The changes were obtained by applying the following Coccinelle script.

How do you think about to adjust the order of provided information
in the commit description?
1. Update goals
2. Transformation implementation at the end


>> "^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";
> 
> Sure it looks more clever, but why?

1. Usage of non-capturing parentheses
2. Clearer specification which parts can be treated as optional
   in the search pattern.


> Ugh that's harder to read and confusing.

* Do you care for coding style and execution speed of regular expressions?

* If you would prefer to list function names without placeholders,
  you can eventually specify them also within SmPL disjunctions directly.

* It can look simpler to use an identifier list as a constraint variant.
  http://coccinelle.lip6.fr/docs/main_grammar002.html


> Again this is confusing.

The view points can be different for such SmPL code.

 T3 fn(T1 E1
(
-           , T2 E2
|           , T2 E2
-           , T4 E4
)     );


> It makes one think that maybe the second argument can also be removed

You expressed this as the first transformation possibility, didn't you?

You would like to delete an argument from the end of a function
or macro parameter (or expression) list.
I suggest then again to avoid the SmPL specification of source code additions
(plus lines in the file difference format).


> and requires careful observation that the ");" follows.

Yes, of course.

Would you care more in the distinction which code parts should be kept unchanged?


> Right, I don't need it in this case.

Thanks for your understanding that the metavariable “position p”
can be deleted in the SmPL rule “pte_alloc_macro”.


> But the script works either way.

I imagine that you can become interested in a bit nicer run time characteristics.


> I like to take more of a problem solving approach that makes sense,

This is usual.


> than aiming for perfection,

If you will work more with scripts for the semantic patch language,
you might become used to additional coding variants.


> after all this is a useful script that we do not need to check
> in once we finish with it.

I am curious if there will evolve a need to add similar transformation approaches
to a known script collection.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle?id=79fc170b1f5c36f486d886bfbd59eb4e62321128

Would you eventually like to run such scripts once more?

Regards,
Markus
