Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 20:38:27 +0200 (CEST)
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44869 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGTSiYMSFL4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 20:38:24 +0200
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6B7D41C0002;
        Fri, 20 Jul 2018 18:37:52 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
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
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
Message-ID: <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
Date:   Fri, 20 Jul 2018 18:37:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180709141621.GD22297@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64996
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

Does anyone have any suggestion about those patches ?

On 07/09/2018 02:16 PM, Michal Hocko wrote:
> [CC hugetlb guys - http://lkml.kernel.org/r/20180705110716.3919-1-alex@ghiti.fr]
>
> On Thu 05-07-18 11:07:05, Alexandre Ghiti wrote:
>> In order to reduce copy/paste of functions across architectures and then
>> make riscv hugetlb port (and future ports) simpler and smaller, this
>> patchset intends to factorize the numerous hugetlb primitives that are
>> defined across all the architectures.
>>
>> Except for prepare_hugepage_range, this patchset moves the versions that
>> are just pass-through to standard pte primitives into
>> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
>> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
>>
>> s390 architecture has not been tackled in this serie since it does not
>> use asm-generic/hugetlb.h at all.
>> powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).
>>
>> This patchset has been compiled on x86 only.
>>
>> Changelog:
>>
>> v4:
>>    Fix powerpc build error due to misplacing of #include
>>    <asm-generic/hugetlb.h> outside of #ifdef CONFIG_HUGETLB_PAGE, as
>>    pointed by Christophe Leroy.
>>
>> v1, v2, v3:
>>    Same version, just problems with email provider and misuse of
>>    --batch-size option of git send-email
>>
>> Alexandre Ghiti (11):
>>    hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
>>    hugetlb: Introduce generic version of hugetlb_free_pgd_range
>>    hugetlb: Introduce generic version of set_huge_pte_at
>>    hugetlb: Introduce generic version of huge_ptep_get_and_clear
>>    hugetlb: Introduce generic version of huge_ptep_clear_flush
>>    hugetlb: Introduce generic version of huge_pte_none
>>    hugetlb: Introduce generic version of huge_pte_wrprotect
>>    hugetlb: Introduce generic version of prepare_hugepage_range
>>    hugetlb: Introduce generic version of huge_ptep_set_wrprotect
>>    hugetlb: Introduce generic version of huge_ptep_set_access_flags
>>    hugetlb: Introduce generic version of huge_ptep_get
>>
>>   arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
>>   arch/arm/include/asm/hugetlb.h               | 33 +----------
>>   arch/arm64/include/asm/hugetlb.h             | 39 +++---------
>>   arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
>>   arch/mips/include/asm/hugetlb.h              | 40 +++----------
>>   arch/parisc/include/asm/hugetlb.h            | 33 +++--------
>>   arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +
>>   arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
>>   arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
>>   arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
>>   arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
>>   arch/sh/include/asm/hugetlb.h                | 54 ++---------------
>>   arch/sparc/include/asm/hugetlb.h             | 40 +++----------
>>   arch/x86/include/asm/hugetlb.h               | 72 +----------------------
>>   include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
>>   15 files changed, 143 insertions(+), 384 deletions(-)
>>
>> -- 
>> 2.16.2
