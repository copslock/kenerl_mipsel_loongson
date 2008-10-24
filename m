Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 16:56:38 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:56144 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22303026AbYJXP4G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 16:56:06 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4901f0040000>; Fri, 24 Oct 2008 11:55:48 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 08:55:47 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 08:55:47 -0700
Message-ID: <4901F003.3040904@caviumnetworks.com>
Date:	Fri, 24 Oct 2008 08:55:47 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Paul Gortmaker <paul.gortmaker@windriver.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 36/37] Cavium OCTEON: pmd_none - use pmd_val() in pmd_val().
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-37-git-send-email-ddaney@caviumnetworks.com> <4901C704.1090501@windriver.com>
In-Reply-To: <4901C704.1090501@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 15:55:47.0659 (UTC) FILETIME=[FB04D1B0:01C935F0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Paul Gortmaker wrote:
> ddaney@caviumnetworks.com wrote:
>> From: David Daney <ddaney@caviumnetworks.com>
>>
>> Before marking pmd_val as invalid_pte_table, factor in existing value
>> for pmd_val.
>>
>> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  arch/mips/include/asm/pgtable-64.h |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>   
> 
> Hi David,
> 
> I think you missed my feedback on this patch -- you should be the primary
> S.O.B.  on this, and at a minimum, it needs a better description of just 
> why
> this is required (if it actually is) on Cavium CPUs, but not on other 
> boards.
> 


Indeed, it was a screw-up on my part.  I hope to be able to remove this 
entire patch in the near future.

David Daney


> Thanks,
> Paul.
> 
>> diff --git a/arch/mips/include/asm/pgtable-64.h 
>> b/arch/mips/include/asm/pgtable-64.h
>> index 943515f..bb93bd5 100644
>> --- a/arch/mips/include/asm/pgtable-64.h
>> +++ b/arch/mips/include/asm/pgtable-64.h
>> @@ -129,7 +129,12 @@ extern pmd_t empty_bad_pmd_table[PTRS_PER_PMD];
>>   */
>>  static inline int pmd_none(pmd_t pmd)
>>  {
>> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
>> +    return (pmd_val(pmd) == (unsigned long) invalid_pte_table) ||
>> +                (!pmd_val(pmd));
>> +#else
>>      return pmd_val(pmd) == (unsigned long) invalid_pte_table;
>> +#endif
>>  }
>>  
>>  #define pmd_bad(pmd)        (pmd_val(pmd) & ~PAGE_MASK)
>>   
> 
> 
