Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 02:12:57 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9821 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026357AbZEMBMv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 02:12:51 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0a1e7b0001>; Tue, 12 May 2009 21:12:27 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 18:12:11 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 18:12:11 -0700
Message-ID: <4A0A1E6B.6050908@caviumnetworks.com>
Date:	Tue, 12 May 2009 18:12:11 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't branch to eret in TLB refill.
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com> <20090513002337.GA12536@cuplxvomd02.corp.sa.net>
In-Reply-To: <20090513002337.GA12536@cuplxvomd02.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2009 01:12:11.0749 (UTC) FILETIME=[D81AB150:01C9D367]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> On Tue, May 12, 2009 at 03:45:16PM -0700, David Daney wrote:
>> If the TLB refill handler is too bit and needs to be split, there is
>> no need to branch around the split if the branch target would be an
>> eret.  Since the eret returns from the handler, control flow never
>> passes it.  A branch to an eret is equivalent to the eret itself.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  arch/mips/mm/tlbex.c |   50 +++++++++++++++++++++++++++++++++-----------------
>>  1 files changed, 33 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index 4dc4f3e..ffa7104 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -723,28 +731,36 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>>  		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
>>  		final_len = p - tlb_handler;
>>  	} else {
>> -		u32 *split = tlb_handler + 30;
>> -
>> -		/*
>> -		 * Find the split point.
>> -		 */
>> -		if (uasm_insn_has_bdelay(relocs, split - 1))
>> -			split--;
>> +		u32 *split;
>> +		if (split_on_eret) {
>> +			split = tlb_handler + 32;
>> +		} else {
>> +			split = tlb_handler + 30;
> 
> It would be a shame to pass up an opportunity to eliminate some of the
> pile of magic constants we have in the MIPS tree. Given that the MIPS
> documentation describes the size of the TLB Refill handler as 0x80 bytes,
> we could add something like:
> 

That would be a different patch according to the one patch per problem rule.

> /* Maximum # of instructions in exception vector for TLB Refill handler */
> #define MIPS64_TLB_REFILL_OPS	(0x80 / sizeof(union mips_instruction))
> 
> and could change the last few lines of the code above to, for example:
> 
> 		if (split_on_eret) {
> 			split = tlb_handler + MIPS64_TLB_REFILL_OPS;
> 		} else {
> 			split = tlb_handler + MIPS64_TLB_REFILL_OPS - 2;
> 
> (you'd need to include asm/inst.h to get union mips_instruction defined)

It is certainly possible to do something like that, but it isn't clear 
to me that it makes it any easier to understand.

> 
>> +
>> +			/*
>> +			 * Find the split point.
>> +			 */
>> +			if (uasm_insn_has_bdelay(relocs, split - 1))
>> +				split--;
>> +		}
> 
> The code itself makes sense. Does this case actually happen much, or was
> this just an itch?
> 

For my CPU it was happening 100% of the time when I add the soon to be 
submitted hugeTLBfs support patch.  Although I have not measured it, 
this code is so hot that keeping the normal case fitting on a single 
cache line should be a big win.

David Daney
