Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 11:48:36 +0200 (CEST)
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47773 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991947AbeHCJsdbb7d9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2018 11:48:33 +0200
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (LNeuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 024F3240002;
        Fri,  3 Aug 2018 09:47:49 +0000 (UTC)
Subject: Re: [PATCH v5 09/11] hugetlb: Introduce generic version of
 huge_ptep_set_wrprotect
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
References: <20180731060155.16915-1-alex@ghiti.fr>
 <20180731060155.16915-10-alex@ghiti.fr>
 <87h8kfhg7o.fsf@concordia.ellerman.id.au>
 <6acb1389-6998-bafb-cf69-174fd522c04c@ghiti.fr>
 <90bf556f-144d-24b8-d2f6-70fee4a30559@ghiti.fr>
 <87muu3hlzc.fsf@concordia.ellerman.id.au>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <ef7fbd80-84a9-0b39-f948-413dea6f6469@ghiti.fr>
Date:   Fri, 3 Aug 2018 11:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87muu3hlzc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65386
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

Hi Michael,

Thanks, I will then remove those two specific implementations and we'll 
use the generic ones.

I send a v6 asap.

Thanks again,

Alex


On 08/03/2018 10:51 AM, Michael Ellerman wrote:
> Hi Alex,
>
> Sorry missed your previous mail.
>
> Alex Ghiti <alex@ghiti.fr> writes:
>> Ok, I tried every defconfig available:
>>
>> - for the nohash/32, I found that I could use mpc885_ads_defconfig and I
>> activated HUGETLBFS.
>> I removed the definition of huge_ptep_set_wrprotect from
>> nohash/32/pgtable.h, add an #error in
>> include/asm-generic/hugetlb.h right before the generic definition of
>> huge_ptep_set_wrprotect,
>> and fell onto it at compile-time:
>> => I'm pretty confident then that removing the definition of
>> huge_ptep_set_wrprotect does not
>> break anythingin this case.
> Thanks, that sounds good.
>
>> - regardind book3s/32, I did not find any defconfig with
>> CONFIG_PPC_BOOK3S_32, CONFIG_PPC32
>> allowing to enable huge page support (ie CONFIG_SYS_SUPPORTS_HUGETLBFS)
>> => Do you have a defconfig that would allow me to try the same as above ?
> I think you're right, it's dead code AFAICS.
>
> We have:
>
> config PPC_BOOK3S_64
>          ...
> 	select SYS_SUPPORTS_HUGETLBFS
>
> config PPC_FSL_BOOK3E
>          ...
> 	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT || PPC64
>
> config PPC_8xx
> 	...
> 	select SYS_SUPPORTS_HUGETLBFS
>
>
> So we can't ever enable HUGETLBFS for Book3S 32.
>
> Presumably the code got copied when we split the headers apart.
>
> So I think you can just ignore that one, and we'll delete it.
>
> cheers
