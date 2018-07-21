Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 02:25:24 +0200 (CEST)
Received: from userp2120.oracle.com ([156.151.31.85]:40930 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993852AbeGUAZVQA--L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 02:25:21 +0200
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6L0O4WQ108329;
        Sat, 21 Jul 2018 00:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Rd4LetHpeqk1ii2hpzsETqPQnreKMoZe60/Jlcry1DM=;
 b=KgT8m2sBy8fAyGM9TnwkTSH1UyfFzLM/W69KCryiFBsFspKXsksC4kfYWmhvoRLirxj6
 154I8bOwJ9TAZsyFz0pFmIsoMNa0NWLqrOAEaUcSQ4IQRbRZ5GSbj8XIg9Ep+2uV2A7v
 cVLxyLeo4wvvdJgX6Pecm4fbMxgvVRMaQrG4VnuBCDZbkEPnTv0ymy2akKH83SoDDP+R
 3p68gusvU5I5PK4+znRMiP/HchVdoZChR0C2LELtzbu5V+4VfPO2LJsXYOknAYXTWmev
 7djxl7rqMsHaLoiH6J41cLIyUt/Awo4CD55/KDXjAFPCvCag1mvoVogsjHt4i1xG7EdJ Aw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k9yjxd1ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jul 2018 00:24:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6L0OSb3013338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jul 2018 00:24:28 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6L0OGOe005456;
        Sat, 21 Jul 2018 00:24:19 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Jul 2018 17:24:15 -0700
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Alex Ghiti <alex@ghiti.fr>, Michal Hocko <mhocko@kernel.org>
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
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
Date:   Fri, 20 Jul 2018 17:24:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8960 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=808
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807210003
Return-Path: <mike.kravetz@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mike.kravetz@oracle.com
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

On 07/20/2018 11:37 AM, Alex Ghiti wrote:
> Does anyone have any suggestion about those patches ?

I only took a quick look.  From the hugetlb perspective, I like the
idea of moving routines to a common file.  If any of the arch owners
(or anyone else) agree, I can do a review of the series.
-- 
Mike Kravetz

> On 07/09/2018 02:16 PM, Michal Hocko wrote:
>> [CC hugetlb guys - http://lkml.kernel.org/r/20180705110716.3919-1-alex@ghiti.fr]
>>
>> On Thu 05-07-18 11:07:05, Alexandre Ghiti wrote:
>>> In order to reduce copy/paste of functions across architectures and then
>>> make riscv hugetlb port (and future ports) simpler and smaller, this
>>> patchset intends to factorize the numerous hugetlb primitives that are
>>> defined across all the architectures.
>>>
>>> Except for prepare_hugepage_range, this patchset moves the versions that
>>> are just pass-through to standard pte primitives into
>>> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
>>> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
>>>
>>> s390 architecture has not been tackled in this serie since it does not
>>> use asm-generic/hugetlb.h at all.
>>> powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).
>>>
>>> This patchset has been compiled on x86 only.
>>>
>>> Changelog:
>>>
>>> v4:
>>>    Fix powerpc build error due to misplacing of #include
>>>    <asm-generic/hugetlb.h> outside of #ifdef CONFIG_HUGETLB_PAGE, as
>>>    pointed by Christophe Leroy.
>>>
>>> v1, v2, v3:
>>>    Same version, just problems with email provider and misuse of
>>>    --batch-size option of git send-email
>>>
>>> Alexandre Ghiti (11):
>>>    hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
>>>    hugetlb: Introduce generic version of hugetlb_free_pgd_range
>>>    hugetlb: Introduce generic version of set_huge_pte_at
>>>    hugetlb: Introduce generic version of huge_ptep_get_and_clear
>>>    hugetlb: Introduce generic version of huge_ptep_clear_flush
>>>    hugetlb: Introduce generic version of huge_pte_none
>>>    hugetlb: Introduce generic version of huge_pte_wrprotect
>>>    hugetlb: Introduce generic version of prepare_hugepage_range
>>>    hugetlb: Introduce generic version of huge_ptep_set_wrprotect
>>>    hugetlb: Introduce generic version of huge_ptep_set_access_flags
>>>    hugetlb: Introduce generic version of huge_ptep_get
>>>
>>>   arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
>>>   arch/arm/include/asm/hugetlb.h               | 33 +----------
>>>   arch/arm64/include/asm/hugetlb.h             | 39 +++---------
>>>   arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
>>>   arch/mips/include/asm/hugetlb.h              | 40 +++----------
>>>   arch/parisc/include/asm/hugetlb.h            | 33 +++--------
>>>   arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +
>>>   arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
>>>   arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
>>>   arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
>>>   arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
>>>   arch/sh/include/asm/hugetlb.h                | 54 ++---------------
>>>   arch/sparc/include/asm/hugetlb.h             | 40 +++----------
>>>   arch/x86/include/asm/hugetlb.h               | 72 +----------------------
>>>   include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
>>>   15 files changed, 143 insertions(+), 384 deletions(-)
>>>
>>> -- 
>>> 2.16.2
> 
