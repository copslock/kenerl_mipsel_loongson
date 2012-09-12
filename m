Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2012 01:47:38 +0200 (CEST)
Received: from devils.ext.ti.com ([198.47.26.153]:49657 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903508Ab2ILXrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2012 01:47:33 +0200
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q8CNk0r8005534;
        Wed, 12 Sep 2012 18:46:00 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
        by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q8CNk0Zs001064;
        Wed, 12 Sep 2012 18:46:00 -0500
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dfle72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.1.323.3; Wed, 12 Sep 2012
 18:45:59 -0500
Received: from [158.218.103.130] (gtla0875269.am.dhcp.ti.com
 [158.218.103.130])     by dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id
 q8CNjwdB007123;        Wed, 12 Sep 2012 18:45:58 -0500
Message-ID: <50511EB5.800@ti.com>
Date:   Wed, 12 Sep 2012 19:45:57 -0400
From:   Cyril Chemparathy <cyril@ti.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     <devicetree-discuss@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux@openrisc.net>,
        <linuxppc-dev@lists.ozlabs.org>,
        <microblaze-uclinux@itee.uq.edu.au>, <x86@kernel.org>,
        <david.daney@cavium.com>, <benh@kernel.crashing.org>,
        <bigeasy@linutronix.de>, <grant.likely@secretlab.ca>,
        <paul.gortmaker@windriver.com>, <paulus@samba.org>,
        <hpa@zytor.com>, <m.szyprowski@samsung.com>, <jonas@southpole.se>,
        <linux@arm.linux.org.uk>, <nico@linaro.org>, <a-jacquiot@ti.com>,
        <mingo@redhat.com>, <suzuki@in.ibm.com>,
        <mahesh@linux.vnet.ibm.com>, <linus.walleij@linaro.org>,
        <arnd@arndb.de>, <msalter@redhat.com>, <rob.herring@calxeda.com>,
        <tglx@linutronix.de>, <blogic@openwrt.org>, <dhowells@redhat.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tj@kernel.org>
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com> <5050EF3F.6030003@gmail.com>
In-Reply-To: <5050EF3F.6030003@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cyril@ti.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 9/12/2012 4:23 PM, Rob Herring wrote:
> On 09/12/2012 11:05 AM, Cyril Chemparathy wrote:
>> On some PAE architectures, the entire range of physical memory could reside
>> outside the 32-bit limit.  These systems need the ability to specify the
>> initrd location using 64-bit numbers.
>>
>> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
>> use 64-bit numbers instead of the current unsigned long.
>
> S-o-B?
>

Sorry about that, will include in v2.

[...]
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
>>   __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>>
>>   #ifdef CONFIG_OF_FLATTREE
>> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>
> phys_initrd_start/size need to change too. Not sure about similar things
> on other arches.
>

I've fixed phys_initrd_start (not size) in another patch, please see [1].

> Does u-boot need similar fixes?
>

We aren't there yet :-)  We are currently running this platform without 
u-boot.


[1] http://permalink.gmane.org/gmane.linux.kernel/1356713

-- 
Thanks
- Cyril
