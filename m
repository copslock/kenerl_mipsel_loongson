Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 23:12:26 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15184 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492969Ab0A0WMW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2010 23:12:22 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b60ba4b0000>; Wed, 27 Jan 2010 14:12:27 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 27 Jan 2010 14:11:25 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 27 Jan 2010 14:11:24 -0800
Message-ID: <4B60BA0C.4060103@caviumnetworks.com>
Date:   Wed, 27 Jan 2010 14:11:24 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: Octeon Ethernet: Fix memory allocation.
References: <1264627373-31780-1-git-send-email-ddaney@caviumnetworks.com> <20100127213351.GA15380@linux-mips.org>
In-Reply-To: <20100127213351.GA15380@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2010 22:11:24.0935 (UTC) FILETIME=[AA4D3970:01CA9F9D]
X-archive-position: 25705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17857

Ralf Baechle wrote:
> On Wed, Jan 27, 2010 at 01:22:53PM -0800, David Daney wrote:
> 
>> After aligning the blocks returned by kmalloc, we need to save the
>> original pointer so they can be correctly freed.
>>
>> There are no guarantees about the alignment of SKB data, so we need to
>> handle worst case alignment.
>>
>> Since right shifts over subtraction have no distributive property, we
>> need to fix the back pointer calculation.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>
>> The original in the linux-queue tree is broken as it assumes the
>> kmalloc returns aligned blocks.  This is not the case when slab
>> debugging is enabled.
> 
> Queue updated - but shouldn't the magic numbers 128 rsp 256 all over this
> patch be replaced by L1_CACHE_SHIFT rsp 2 * L1_CACHE_SHIFT?
> 

Although the cache line size and alignment happen to match the size and 
alignment used by the FPA, they are different things.  So Probably it 
could be a different symbolic constant with a value of 128.

David Daney
