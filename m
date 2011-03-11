Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2011 19:28:01 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4953 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491203Ab1CKS16 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Mar 2011 19:27:58 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d7a69e10000>; Fri, 11 Mar 2011 10:28:49 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 Mar 2011 10:27:54 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 Mar 2011 10:27:53 -0800
Message-ID: <4D7A69A9.40206@caviumnetworks.com>
Date:   Fri, 11 Mar 2011 10:27:53 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/12] MIPS: Octeon: Add a irq_create_of_mapping()
 implementation.
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com> <1299267744-17278-7-git-send-email-ddaney@caviumnetworks.com> <20110305010746.GD7579@angua.secretlab.ca>
In-Reply-To: <20110305010746.GD7579@angua.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2011 18:27:53.0951 (UTC) FILETIME=[094576F0:01CBE01A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/04/2011 05:07 PM, Grant Likely wrote:
> On Fri, Mar 04, 2011 at 11:42:18AM -0800, David Daney wrote:
[...]
>> +/*
>> + * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
>> + *
>> + * Octeon irq maps are a pair of indexes.  The first selects either
>> + * ciu0 or ciu1, the second is the bit within the ciu register.
>> + */
>
> Is each 'ciu' an interrupt controller, or a 'bank' within the
> controller?

The ciu0 and ciu1 are 'banks' within a single interrupt controller. 
Each of these 'banks' has 64 bits, each bit corresponds to the finest 
grained source that can be routed via the interrupt infrastructure. 
Each interrupt source can therefore be completely specified by its bank 
and bit numbers.

> Also, it is typical to have another cell for specifying
> flags if there is any kind of configuration for each irq line, like
> edge vs. level and active high or active low.  (the counter example is
> PCI which doesn't use a flags cell because all PCI irqs are level
> active.
>

If you look in patch 04/12, you will see that I have added such a flag 
cell to the device tree.  In the next revision of this patch, I will be 
adding the logic to actually configure the polarity and triggering based 
on the flag cell.

There are only 16 sources (GPIO pins that can actually be configured. 
The remaining sources will ignore the triggering flags as they are hard 
wired.


> You'll need to supply documentation for the ciu binding to
> Documentation/devicetree/bindings before this patch gets merged.

OK, I will work on that too.

Thanks,
David Daney
