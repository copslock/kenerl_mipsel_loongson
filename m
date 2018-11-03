Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Nov 2018 13:56:11 +0100 (CET)
Received: from mout.web.de ([217.72.192.78]:52341 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990395AbeKCMyLXZEkS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 3 Nov 2018 13:54:11 +0100
Received: from [192.168.1.2] ([77.182.136.36]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWj6V-1g3sYm0dBr-00XxSy; Sat, 03
 Nov 2018 13:51:35 +0100
Received: from [192.168.1.2] ([77.182.136.36]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWj6V-1g3sYm0dBr-00XxSy; Sat, 03
 Nov 2018 13:51:35 +0100
Subject: Re: [PATCH -next v2 1/3] mm: treewide: remove unused address argument
 from pte_alloc functions
To:     Joel Fernandes <joel@joelfernandes.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
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
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        Lokesh Gidra <lokeshgidra@google.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
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
References: <20181103040041.7085-1-joelaf@google.com>
 <20181103040041.7085-2-joelaf@google.com>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <fd939e7c-3d9e-760e-f20c-e7263f064153@users.sourceforge.net>
Date:   Sat, 3 Nov 2018 13:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181103040041.7085-2-joelaf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VsFj7PZvXTuItJtMK3DaoKAJBuiK9mXpGGY5+klibNLoFdxoEfJ
 LMXp3e5QGQjzwTHhuzc7WT6CSt1cWmztVsZoA0YtitXFQxXGg/1sFxtK/3NTNTBkQAE/vLx
 yfH10rM+HaCfDwS1a7MSrlUZRz1cWjsl+WROQOVkuX2Uyl621tQOWWcYzEdwOCFSZeezRw6
 yD79guZzI267srJxDvn3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1lqYMjBjtvM=:9WWP2ekn7iGjSIrji6zHLJ
 yBNKkUboO37rsUnXH2Hg1Nez21TNcgKLqB+iEAXeFxsuUWND5iqNTOV0f7iUhZ8LCVGERjosH
 eV3EIcmUs352FIYVcIl9pyl5kGfhyW9CVAKKA3Vtl3fCIVS0h7AUC/CRFfSTYRrqquFdLKY+D
 YY9tBgmKF4RLAo2VV77L0kpvX2Ex/oBUWcqIyxWKJbUKK+4M0oO4Hd1GX9jVpKEDNTzw9Mgv/
 7EcR7oIz4ZDbZIFAHhOkcxazCVjpGbsUt/2JruOkxclbJ8fM4SI/vREdND1Uu+RHQRIfr2h2g
 mvfANVUd2tKA7k1bjCrXUAyb6wb7lYUJR0j+OfLb3pMP/MTXDfpEfncDaW8uY1XIXYsPvgTms
 EpzszDs2kayp8qWmLSvYCtQOWJOBcm1YY61+mraL5tDhBLDaUmh+4KT6vr+Jh1K7kce7R05sE
 dcd8zBw+xXnrI9S0EB8blbb0HUC4VPSKqqDOpIqDlvxsduQE50MQpPbW2a8qQxsvmsh7DxHCG
 VgfYc7FNJpmIqqHy7PsbXSvsbY5CafBpbVG7PSxhOJkq7zcSNFUCySNea//ZYJbaJJilfhaRJ
 wpL6cKkQwaZzhNtfD2PEARWGxTRoJm7JVowCVrTOL7vPSSN1l9lqiKL45tT215MR9ACy9gWy4
 WjD8wcPjzKhPGyVZnegCom/pq3DYdY7Tm85VUpRHx7+4r/fv+iFVTEJ4ctNFSr6k0fSLVHrqL
 BoXtVj57lGWnx+igC+B3hHR/etawYfDXlpsvl5UPntkjZW5FyR7g3yQ05ThLCPg7UN2/gUt0k
 qV43NQj/N7LVgEkDDFH/sDs2unxECJIZFw/iKaEWlOlOEVoiv4=
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67063
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

> … There is concern that …

Does this wording need a small adjustment?


> The changes were obtained by applying the following Coccinelle script.

I would find it nicer if previous patch review comments will trigger
further useful effects here.
https://patchwork.kernel.org/patch/10637703/#22265203
https://lore.kernel.org/linuxppc-dev/03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net/
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg140009.html


If you have got difficulties with the usage of advanced regular expressions
for SmPL constraints, I suggest to use desired function names in SmPL lists
or disjunctions instead because of different run time characteristics
for such a source code transformation approach.


> // Note: I split the 'identifier fn' line, so if you are manually
> // running it, please unsplit it so it runs for you.

Please delete this questionable comment.

* The semantic patch language should handle the mentioned code formatting.
* You can use multi-line regular expressions (if it would be desired).


> @pte_alloc_func_def depends on patch exists@
> identifier E2;
> identifier fn =~

How do you think about to avoid the repetition of a SmPL key word at such places?

Regards,
Markus
