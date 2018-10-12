Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 20:54:42 +0200 (CEST)
Received: from mout.web.de ([217.72.192.78]:53335 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993941AbeJLSyew9hJj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Oct 2018 20:54:34 +0200
Received: from [192.168.1.2] ([77.182.238.221]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1fRTIY0mGx-00yNhT; Fri, 12
 Oct 2018 20:52:01 +0200
Received: from [192.168.1.2] ([77.182.238.221]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1fRTIY0mGx-00yNhT; Fri, 12
 Oct 2018 20:52:01 +0200
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
To:     Joel Fernandes <joel@joelfernandes.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Michal Hocko <mhocko@kernel.org>,
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
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
Date:   Fri, 12 Oct 2018 20:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181012013756.11285-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kL1jfGghCfX5IqF0iVRDf8mQoouSapQgO45dI9woF05xgJDfw/d
 AA5sy1osx5PoQoz8e05NX77GNXJPHw9DPR0si3tMAft3cP3Og/UHQyAFEv44VXROloUsniB
 Y8tHxhnCqGSXk3sDOvyIeh0eyIwAL0z+iO5ZuRU8MJFacaGuv/K0/oO3MnIdqboq2zbaeLx
 atswja9Z0HU2X9bmK8r2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VYhd+82Fahk=:8qKapuTAK9PGC3QZTGFm93
 Cv2uqZ6//UeJGJZRMh8t6n/D607bhM1JOv0wjRaxbPn/FW+RXDkMkih/t/gcO0hiGvN00WxSH
 IUOZ5UtG4kENR0gAMawuKNvB3LYcHHG1grcbSDqQP/BP66NmXdnncdyC/Fje3KSEJqrBsRHgS
 flHBVB2rkw+Sy4wZAzvjDgK9v1jeeixWlZcCGq1hd6V8ua/ZFailYZ5twLThZPB30GH0alEeN
 4BtcuJtue0qkcUIWFRl1hmdRR5yZvHjT9G3LVxNawPDJYbR2E/TSC2W1COIT8+YT5YBMm0Fxv
 CVCdMWpPV1NaDj8bAFDmchFSwtoFeQlsxVrDtyH0gnZIAcDL1j4j4uaSLVIWcBXN5rhNFjK9H
 3NwtAoLBOLVGX9Ls6HdRK6GTJaYuo5EsxJI16AX32mKNB++RlDhqyr7bqfkkb/WqHXKs3eOTu
 c8F8lqPWVCFAApAGqYnH9taUkWETaXUpGv5nUcYPfjs4TbvOf7jgv4u2azPEp6x+w1COYQJo7
 p13QwmpRRaU/KPxmSbvhunzILyYWG1dQCFpQhDnbuYICSC2DtHVit2NMrNANj+BTHJ4SCceSi
 jTT9dKo7bVCOEQXehz7gqeY5s8xdjd8k+jT4gurpwowY5OZKnVS/YEw7tIuTSEOGTzURUzy9C
 kgRV9hC2Zaqx2MJYmkpaBJigq+1QkIcVVkao5vfZ7Aku6ztfDwqaN8kp6lTzAFV5YGDmPnfvt
 BNOLByR2sgQDnjzgmDIlkBLnLlcavYosoSLzlNhWeLW698K8b0Z67v3JhT9bQ9nF9ogTFxMZj
 +jTqXiDQcHh5AF+SdBNXVw6FkD2x241wRX0cbutTUEyrGYduAY=
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66791
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

> The changes were obtained by applying the following Coccinelle script.

A bit of clarification happened for its implementation details.
https://systeme.lip6.fr/pipermail/cocci/2018-October/005374.html

I have taken also another look at the following SmPL code.


> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";

I suggest to adjust the regular expression for this constraint
and in subsequent SmPL rules.

"^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";


> (
> - T3 fn(T1 E1, T2 E2);
> + T3 fn(T1 E1);
> |
> - T3 fn(T1 E1, T2 E2, T4 E4);
> + T3 fn(T1 E1, T2 E2);
> )

I propose to take an other SmPL disjunction into account here.

 T3 fn(T1 E1,
(
-      T2 E2
|      T2 E2,
-      T4 E4
)      );


> (
> - #define fn(a, b, c)@p e
> + #define fn(a, b) e
> |
> - #define fn(a, b)@p e
> + #define fn(a) e
> )

How do you think about to omit the metavariable “position p” here?

Regards,
Markus
