Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2011 19:05:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15201 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491774Ab1E0RFj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2011 19:05:39 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ddfda210000>; Fri, 27 May 2011 10:06:41 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 May 2011 10:05:37 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 May 2011 10:05:37 -0700
Message-ID: <4DDFD9E0.2090701@caviumnetworks.com>
Date:   Fri, 27 May 2011 10:05:36 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/6] MIPS: Prune some target specific code out
 of prom.c
References: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com> <1305930343-31259-5-git-send-email-ddaney@caviumnetworks.com> <20110527015845.GD5032@ponder.secretlab.ca>
In-Reply-To: <20110527015845.GD5032@ponder.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2011 17:05:37.0102 (UTC) FILETIME=[4C7CD6E0:01CC1C90]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/26/2011 06:58 PM, Grant Likely wrote:
> On Fri, May 20, 2011 at 03:25:41PM -0700, David Daney wrote:
>> This code is not common enough to be in a shared file.  It is also not
>> used by any existing boards, so just remove it.
>>
>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>> ---
>>   arch/mips/kernel/prom.c |   49 -----------------------------------------------
>>   1 files changed, 0 insertions(+), 49 deletions(-)
>>
>> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
>> index a19811e9..a07b6f1 100644
>> --- a/arch/mips/kernel/prom.c
>> +++ b/arch/mips/kernel/prom.c
>> @@ -59,52 +59,3 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>   	initrd_below_start_ok = 1;
>>   }
>>   #endif
>> -
>> -/*
>> - * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
>> - *
>> - * Currently the mapping mechanism is trivial; simple flat hwirq numbers are
>> - * mapped 1:1 onto Linux irq numbers.  Cascaded irq controllers are not
>> - * supported.
>> - */
>> -unsigned int irq_create_of_mapping(struct device_node *controller,
>> -				   const u32 *intspec, unsigned int intsize)
>> -{
>> -	return intspec[0];
>> -}
>> -EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>
> In $NEXT_KERNEL+1 irq_create_of_mapping will be replaced by common
> infrastructure code after irq_domain is merged, so this will become
> irrelevant anyway.

Yes, I saw your patch.  I will be tracking that as it gets merged.

>
>> -
>> -void __init early_init_devtree(void *params)
>> -{
>> -	/* Setup flat device-tree pointer */
>> -	initial_boot_params = params;
>> -
>> -	/* Retrieve various informations from the /chosen node of the
>> -	 * device-tree, including the platform type, initrd location and
>> -	 * size, and more ...
>> -	 */
>> -	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
>> -
>> -	/* Scan memory nodes */
>> -	of_scan_flat_dt(early_init_dt_scan_root, NULL);
>> -	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
>> -}
>> -
>> -void __init device_tree_init(void)
>> -{
>> -	unsigned long base, size;
>> -
>> -	if (!initial_boot_params)
>> -		return;
>> -
>> -	base = virt_to_phys((void *)initial_boot_params);
>> -	size = be32_to_cpu(initial_boot_params->totalsize);
>> -
>> -	/* Before we do anything, lets reserve the dt blob */
>> -	reserve_mem_mach(base, size);
>> -
>> -	unflatten_device_tree();
>> -
>> -	/* free the space reserved for the dt blob */
>> -	free_mem_mach(base, size);
>> -}
>
> I'm a little concerned that the MIPS platforms are not sharing the
> same DT init code.  This isn't really something that should need to be
> customized per-platform.
>

For better or worse, the Octeon kernel is booted with a protocol 
completely different than any other MIPS board.  So there has to be some 
custom code to find and initialize the device tree.

For boards that boot with the u-boot 'bootm' protocol, I think we need 
to pass the device tree in the environment like other architectures do. 
  The bootm code could, I think, be made common to all MIPS ports.

David Daney
