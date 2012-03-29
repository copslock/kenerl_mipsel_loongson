Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 03:34:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3437 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab2C2BeA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 03:34:00 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f73bc700000>; Wed, 28 Mar 2012 18:35:44 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Mar 2012 18:33:35 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Mar 2012 18:33:35 -0700
Message-ID: <4F73BC02.9090102@cavium.com>
Date:   Wed, 28 Mar 2012 18:33:54 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com> <20120328223155.AD0A63E0DAA@localhost>
In-Reply-To: <20120328223155.AD0A63E0DAA@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2012 01:33:35.0206 (UTC) FILETIME=[F541F060:01CD0D4B]
X-archive-position: 32812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/28/2012 03:31 PM, Grant Likely wrote:
> On Mon, 26 Mar 2012 12:31:19 -0700, David Daney<ddaney.cavm@gmail.com>  wrote:
>> From: David Daney<david.daney@cavium.com>
>>
>> Create two domains.  One for the GPIO lines, and the other for on-chip
>> sources.
>>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>> ---
> [...]
>> +struct octeon_irq_gpio_domain_data {
>> +	unsigned int base_hwirq;
>> +};
>
> Hmmm...
>
>> +static int octeon_irq_gpio_xlat(struct irq_domain *d,
>> +				struct device_node *node,
>> +				const u32 *intspec,
>> +				unsigned int intsize,
>> +				unsigned long *out_hwirq,
>> +				unsigned int *out_type)
>> +{
> [...]
>> +	*out_hwirq = gpiod->base_hwirq + pin;
>
> ...base_hwirq is only used here...
>
> [...]
>> +		gpiod = kzalloc(sizeof (*gpiod), GFP_KERNEL);
>> +		if (gpiod) {
>> +			/* gpio domain host_data is the base hwirq number. */
>> +			gpiod->base_hwirq = 16;
>> +			irq_domain_add_linear(gpio_node, 16,&octeon_irq_domain_gpio_ops, gpiod);
>
> ... and it is unconditionally set to 16.  It looks to me like
> base_hwirq and the associated kzalloc() is unnecessary.
>

There is a little information asymmetry here.  You don't know that I 
have a patch queued up to add another user of the GPIO irq_domain that 
has a different base_hwirq.

I could re-do this to hard code it, and then add it back.  But it would 
really just be busy work.

David Daney
