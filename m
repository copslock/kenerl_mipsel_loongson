Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 18:14:02 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5456 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491046Ab0IXQN7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 18:13:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9cce630000>; Fri, 24 Sep 2010 09:14:27 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 24 Sep 2010 09:13:54 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 24 Sep 2010 09:13:54 -0700
Message-ID: <4C9CCE42.3030309@caviumnetworks.com>
Date:   Fri, 24 Sep 2010 09:13:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] MIPS: Add a platform hook for swiotlb setup.
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com> <1285281496-24696-9-git-send-email-ddaney@caviumnetworks.com> <4C9CCD1B.506@mvista.com>
In-Reply-To: <4C9CCD1B.506@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2010 16:13:54.0621 (UTC) FILETIME=[7C0F0ED0:01CB5C03]
X-archive-position: 27820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19427

On 09/24/2010 09:08 AM, Sergei Shtylyov wrote:
> Hello.
>
> David Daney wrote:
>
>> This allows platforms that are using the swiotlb to initialize it.
>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>> arch/mips/include/asm/bootinfo.h | 5 +++++
>> arch/mips/kernel/setup.c | 5 +++++
>> 2 files changed, 10 insertions(+), 0 deletions(-)
>
>> diff --git a/arch/mips/include/asm/bootinfo.h
>> b/arch/mips/include/asm/bootinfo.h
>> index 15a8ef0..b3cf989 100644
>> --- a/arch/mips/include/asm/bootinfo.h
>> +++ b/arch/mips/include/asm/bootinfo.h
>> @@ -125,4 +125,9 @@ extern unsigned long fw_arg0, fw_arg1, fw_arg2,
>> fw_arg3;
>> */
>> extern void plat_mem_setup(void);
>>
>> +/*
>> + * Optional platform hook to call swiotlb_setup().
>> + */
>> +extern void plat_swiotlb_setup(void);
>> +
>> #endif /* _ASM_BOOTINFO_H */
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index 85aef3f..8b650da 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -488,6 +488,11 @@ static void __init arch_mem_init(char **cmdline_p)
>>
>> bootmem_init();
>> sparse_init();
>> +
>> +#ifdef CONFIG_SWIOTLB
>> + plat_swiotlb_setup();
>> +#endif
>
> We should avoid #ifdef's in function bodies. Why not defile an empty
> 'inline' in the header above if CONFIG_SWIOTLB is not defined?
>

Good idea.  I will wait several days and collect any more feedback and 
generate a new patch set.

David Daney
