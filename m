Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2009 23:25:16 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6994 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024642AbZEKWZK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2009 23:25:10 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a08a5b20000>; Mon, 11 May 2009 18:24:50 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 May 2009 15:24:18 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 May 2009 15:24:17 -0700
Message-ID: <4A08A591.2040303@caviumnetworks.com>
Date:	Mon, 11 May 2009 15:24:17 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Paul Gortmaker <paul.gortmaker@windriver.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Remove execution hazard barriers for Octeon.
References: <1242069062-20991-1-git-send-email-ddaney@caviumnetworks.com> <7d1d9c250905111459p42ce2671n91625e6f62cb2d75@mail.gmail.com>
In-Reply-To: <7d1d9c250905111459p42ce2671n91625e6f62cb2d75@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2009 22:24:17.0939 (UTC) FILETIME=[393B8630:01C9D287]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Paul Gortmaker wrote:
> On Mon, May 11, 2009 at 3:11 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>> The Octeon has no execution hazards, so we can remove them and save an
>> instruction per TLB handler invocation.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  arch/mips/mm/tlbex.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index 3548acf..4b2ea1f 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -257,7 +257,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
>>        case tlb_indexed: tlbw = uasm_i_tlbwi; break;
>>        }
>>
>> -       if (cpu_has_mips_r2) {
>> +       if (cpu_has_mips_r2 && current_cpu_type() != CPU_CAVIUM_OCTEON) {
> 
> Assuming that it is feasible that some other future cores might also be
> free of execution hazards, wouldn't it be better to do:
> 
>   if (cpu_has_mips_r2 && cpu_has_exec_hazard) {


That would be a bit cleaner.  I will test a new patch.

Thanks,
David Daney


> 
> and then hide the CPU type listing (currently just one) in some header file?
> 
> Paul.
> 
