Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 22:56:39 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34009 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903508Ab2ILU4f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 22:56:35 +0200
Received: by obbta17 with SMTP id ta17so3496745obb.36
        for <multiple recipients>; Wed, 12 Sep 2012 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qRRupGy+jLT3bdqbyn8e1tMDubc+EYbZLTVrVRmvZnw=;
        b=JChgIHL/IWqc3fX6MN40C73H2X+CFAyXwKFhePLSWFVfIpNKAHcleZchTwy5e5iH6p
         WjZnYnnr00+VF+CQddicX1e9srJ+DreJqqRPmE6T1QQKsSc9uaeg1p80GZ1aggYUBlKg
         DuFc3eTcZgPQMivbskhGW9k91o62NmNG0+Jn7YDm/n9aolvPo/Kb+SSW94Zz0hX4Dz9h
         C9a0AZUl8ir62/UoALcPUQPi2g34hz7mXp2l4tDNK1OOBYTpOCukQac4DULWVZxdXv9d
         Xpb5dg2rjHbFgXNvzhkIo9AfCcRMlzyKdY6eYjHizfJoH7jVi+GidYBHuhGuXtUoyCni
         qNew==
Received: by 10.60.30.201 with SMTP id u9mr24274025oeh.51.1347483388460;
        Wed, 12 Sep 2012 13:56:28 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPS id ea6sm21321394obc.9.2012.09.12.13.56.25
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 13:56:27 -0700 (PDT)
Message-ID: <5050F6F8.6000008@gmail.com>
Date:   Wed, 12 Sep 2012 15:56:24 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
CC:     Cyril Chemparathy <cyril@ti.com>,
        devicetree-discuss@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux@openrisc.net, linuxppc-dev@lists.ozlabs.org,
        microblaze-uclinux@itee.uq.edu.au, x86@kernel.org,
        david.daney@cavium.com, benh@kernel.crashing.org,
        bigeasy@linutronix.de, grant.likely@secretlab.ca,
        paul.gortmaker@windriver.com, paulus@samba.org, hpa@zytor.com,
        m.szyprowski@samsung.com, jonas@southpole.se,
        linux@arm.linux.org.uk, a-jacquiot@ti.com, mingo@redhat.com,
        suzuki@in.ibm.com, mahesh@linux.vnet.ibm.com,
        linus.walleij@linaro.org, arnd@arndb.de, msalter@redhat.com,
        rob.herring@calxeda.com, tglx@linutronix.de, blogic@openwrt.org,
        dhowells@redhat.com, monstr@monstr.eu, ralf@linux-mips.org,
        tj@kernel.org
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com> <5050EF3F.6030003@gmail.com> <alpine.LFD.2.02.1209121629260.28681@xanadu.home>
In-Reply-To: <alpine.LFD.2.02.1209121629260.28681@xanadu.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On 09/12/2012 03:31 PM, Nicolas Pitre wrote:
> On Wed, 12 Sep 2012, Rob Herring wrote:
> 
>> On 09/12/2012 11:05 AM, Cyril Chemparathy wrote:
>>> On some PAE architectures, the entire range of physical memory could reside
>>> outside the 32-bit limit.  These systems need the ability to specify the
>>> initrd location using 64-bit numbers.
>>>
>>> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
>>> use 64-bit numbers instead of the current unsigned long.
>>
>> S-o-B?
>>
>>> ---
>>>  arch/arm/mm/init.c            |    2 +-
>>>  arch/c6x/kernel/devicetree.c  |    3 +--
>>>  arch/microblaze/kernel/prom.c |    3 +--
>>>  arch/mips/kernel/prom.c       |    3 +--
>>>  arch/openrisc/kernel/prom.c   |    3 +--
>>>  arch/powerpc/kernel/prom.c    |    3 +--
>>>  arch/x86/kernel/devicetree.c  |    3 +--
>>>  drivers/of/fdt.c              |   10 ++++++----
>>>  include/linux/of_fdt.h        |    3 +--
>>>  9 files changed, 14 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>>> index ad722f1..579792c 100644
>>> --- a/arch/arm/mm/init.c
>>> +++ b/arch/arm/mm/init.c
>>> @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
>>>  __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>>>  
>>>  #ifdef CONFIG_OF_FLATTREE
>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>
>> phys_initrd_start/size need to change too. Not sure about similar things
>> on other arches.
> 
> size ?

phys_initrd_size. Arguably, we'll never have a >4GB initrd with a PAE
system or perhaps run into other issues first (like space to decompress
it), but technically the DTS could specify one.

Rob
