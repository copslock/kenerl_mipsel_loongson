Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 23:11:07 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19990 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491114Ab1FMVLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2011 23:11:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4df67d270000>; Mon, 13 Jun 2011 14:12:07 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 13 Jun 2011 14:10:06 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 13 Jun 2011 14:10:06 -0700
Message-ID: <4DF67CAE.1040804@caviumnetworks.com>
Date:   Mon, 13 Jun 2011 14:10:06 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Linux 2.6.39 on Cavium CN38xx
References: <1307653714.8271.130.camel@groeck-laptop> <4DF13E25.2060502@caviumnetworks.com> <20110609220614.GA13583@ericsson.com> <4DF15068.30906@caviumnetworks.com> <1307751642.8271.315.camel@groeck-laptop> <20110612164155.GA30615@ericsson.com>
In-Reply-To: <20110612164155.GA30615@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2011 21:10:06.0805 (UTC) FILETIME=[4555A050:01CC2A0E]
X-archive-position: 30368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10931

On 06/12/2011 09:41 AM, Guenter Roeck wrote:
> On Fri, Jun 10, 2011 at 08:20:42PM -0400, Guenter Roeck wrote:
> [ ... ]
>
>> Hi David,
>>
>> Turns out my primary problem is that octeon_irq_setup_secondary_ciu()
>> sets C0_STATUS to 0x1000efe0, ie all interrupts except IP4 are enabled.
>> This mask is primarily set through octeon_irq_percpu_enable(), which
>> sets C0_STATUS to 0x1000e3e0. The value differs from CPU 0, where
>> C0_STATUS is set to 0x10008ce0.
>>
>> This causes persistent spurious interrupts on our boards (both with
>> CN38xx and CN58xx), where C0_CAUSE persistently reads as zero in the
>> interrupt handling code but interrupts are triggered anyway. The
>> spurious interrupt problem goes away if I mask out IP0, IP1, IP5, and
>> IP6 at the end of octeon_irq_setup_secondary_ciu().
>>
> Answering part of my own question: The interrupt enable bits for secondary CPUs
> are all set through octeon_irq_core_eoi(), which is called from the per-CPU
> initialization code and enables each interrupt even if "desired_en" is false
> for a given bit. I modified octeon_irq_core_eoi() to
>
> 	if (cd->desired_en)
>                  set_c0_status(0x100<<  cd->bit);
>

That shouldn't be needed.  The logic in irq_cpu_online() should only 
call chip->irq_cpu_online() if the irq is enabled.


> which takes care of the problem. No idea if that is correct, though.
>
> The actual interrupt causing trouble and spurious interrupts in my case is,
> oddly enough, STATUSF_IP0. So far I have been unable to track down how that
> is triggered; I don't see the bit being set set in C0_CAUSE anywhere.
>
> Are there any means to trigger an IP0 interrupt other than by writing STATUSF_IP0
> into the C0_CAUSE register ?
>

No.  Nothing that I know of ever uses IP0 and IP1, so they should always 
be cleared.

David Daney.
