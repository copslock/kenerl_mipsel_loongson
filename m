Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 08:46:55 +0200 (CEST)
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56033 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeHTGqwhUHJ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 08:46:52 +0200
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (LNeuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2D8D61BF207;
        Mon, 20 Aug 2018 06:46:25 +0000 (UTC)
Subject: Re: [PATCH v6 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Michal Hocko <mhocko@kernel.org>
References: <20180806175711.24438-1-alex@ghiti.fr>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <81078a7f-09cf-7f19-f6bb-8a1f4968d6fb@ghiti.fr>
Date:   Mon, 20 Aug 2018 08:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180806175711.24438-1-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@ghiti.fr
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

Hi Michal,

This patchset got acked, tested and reviewed by quite a few people, and 
it has been suggested
that it should be included in -mm tree: could you tell me if something 
else needs to be done for
its inclusion ?

Thanks for your time,

Alex


On 08/06/2018 07:57 PM, Alexandre Ghiti wrote:
> [CC linux-mm for inclusion in -mm tree]
>                                                                                   
> In order to reduce copy/paste of functions across architectures and then
> make riscv hugetlb port (and future ports) simpler and smaller, this
> patchset intends to factorize the numerous hugetlb primitives that are
> defined across all the architectures.
>                                                                                   
> Except for prepare_hugepage_range, this patchset moves the versions that
> are just pass-through to standard pte primitives into
> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
>                                                                                   
> s390 architecture has not been tackled in this serie since it does not
> use asm-generic/hugetlb.h at all.
>                                                                                   
> This patchset has been compiled on all addressed architectures with
> success (except for parisc, but the problem does not come from this
> series).
>                                                                                   
> v6:
>    - Remove nohash/32 and book3s/32 powerpc specific implementations in
>      order to use the generic ones.
>    - Add all the Reviewed-by, Acked-by and Tested-by in the commits,
>      thanks to everyone.
>                                                                                   
> v5:
>    As suggested by Mike Kravetz, no need to move the #include
>    <asm-generic/hugetlb.h> for arm and x86 architectures, let it live at
>    the top of the file.
>                                                                                   
> v4:
>    Fix powerpc build error due to misplacing of #include
>    <asm-generic/hugetlb.h> outside of #ifdef CONFIG_HUGETLB_PAGE, as
>    pointed by Christophe Leroy.
>                                                                                   
> v1, v2, v3:
>    Same version, just problems with email provider and misuse of
>    --batch-size option of git send-email
>
> Alexandre Ghiti (11):
>    hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
>    hugetlb: Introduce generic version of hugetlb_free_pgd_range
>    hugetlb: Introduce generic version of set_huge_pte_at
>    hugetlb: Introduce generic version of huge_ptep_get_and_clear
>    hugetlb: Introduce generic version of huge_ptep_clear_flush
>    hugetlb: Introduce generic version of huge_pte_none
>    hugetlb: Introduce generic version of huge_pte_wrprotect
>    hugetlb: Introduce generic version of prepare_hugepage_range
>    hugetlb: Introduce generic version of huge_ptep_set_wrprotect
>    hugetlb: Introduce generic version of huge_ptep_set_access_flags
>    hugetlb: Introduce generic version of huge_ptep_get
>
>   arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
>   arch/arm/include/asm/hugetlb.h               | 30 ----------
>   arch/arm64/include/asm/hugetlb.h             | 39 +++---------
>   arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
>   arch/mips/include/asm/hugetlb.h              | 40 +++----------
>   arch/parisc/include/asm/hugetlb.h            | 33 +++--------
>   arch/powerpc/include/asm/book3s/32/pgtable.h |  6 --
>   arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
>   arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
>   arch/powerpc/include/asm/nohash/32/pgtable.h |  6 --
>   arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
>   arch/sh/include/asm/hugetlb.h                | 54 ++---------------
>   arch/sparc/include/asm/hugetlb.h             | 40 +++----------
>   arch/x86/include/asm/hugetlb.h               | 69 ----------------------
>   include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
>   15 files changed, 135 insertions(+), 394 deletions(-)
>
