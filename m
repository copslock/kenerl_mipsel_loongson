Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 23:13:25 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11927 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492036Ab0BAWNW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 23:13:22 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6752080001>; Mon, 01 Feb 2010 14:13:28 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 14:12:40 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 14:12:40 -0800
Message-ID: <4B6751D8.7080805@caviumnetworks.com>
Date:   Mon, 01 Feb 2010 14:12:40 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     guenter.roeck@ericsson.com
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] Virtual memory size detection for 64 bit MIPS CPUs
References: <1265058019-21484-1-git-send-email-guenter.roeck@ericsson.com>       <4B674ADD.1050306@caviumnetworks.com> <1265061872.5825.71.camel@groeck-laptop>
In-Reply-To: <1265061872.5825.71.camel@groeck-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Feb 2010 22:12:40.0378 (UTC) FILETIME=[AB55A9A0:01CAA38B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Guenter Roeck wrote:
> On Mon, 2010-02-01 at 16:42 -0500, David Daney wrote:
>> Guenter Roeck wrote:
>> [...]
>>>  
>>> +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
>>> +{
>>> +	if (cpu_has_64bits) {
>>> +		unsigned long zbits;
>>> +
>>> +		asm volatile(".set mips64\n"
>>> +			     "and %0, 0\n"
>>> +			     "dsubu %0, 1\n"
>>> +			     "dmtc0 %0, $10, 0\n"
>>> +			     "dmfc0 %0, $10, 0\n"
>>> +			     "dsll %0, %0, 2\n"
>>> +			     "dsra %0, %0, 2\n"
>>> +			     "dclz %0, %0\n"
>>> +			     ".set mips0\n"
>>> +			     : "=r" (zbits));
>>> +		c->vmbits = 64 - zbits;
>>> +	} else
>>> +		c->vmbits = 32;
>>> +}
>>> +
>> It should be possible to express this in 'pure' C using 
>> read_c0_entryhi()/write_c0_entryhi(), also you need to be sure you are 
> 
> Sure, no problem.
> 
>> not writing 1s to any reserved bits of the register.
>>
> That may be tricky, since the upper bits are reserved in some
> architectures. For example, the 20Kc core specification says that bits
> 61:40 are reserved and must be written with 0.
> 
> I can write, say, 0x3fffffffffff0000 to avoid writing into lower
> reserved bits, but that won't help for any upper reserved bits. Would
> that be acceptable / better ?


The MIPS64® Privileged Resource Architecture manual might be a better 
reference.

I would set 1s only in bits 13-63 (the VPN2 and R fields).  We don't 
support and don't really care about VPN2X, the upper bits are really the 
only ones of interest here.

David Daney
