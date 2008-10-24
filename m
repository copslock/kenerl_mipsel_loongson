Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 18:01:43 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:56964 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22306188AbYJXRBh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 18:01:37 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4901ff620000>; Fri, 24 Oct 2008 13:01:22 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 10:01:22 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 10:01:22 -0700
Message-ID: <4901FF61.4040907@caviumnetworks.com>
Date:	Fri, 24 Oct 2008 10:01:21 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 28/37] Cavium OCTEON FPU EMU exception as TLB exception
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-29-git-send-email-ddaney@caviumnetworks.com> <4901A5E3.3090702@ru.mvista.com>
In-Reply-To: <4901A5E3.3090702@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 17:01:22.0150 (UTC) FILETIME=[24288060:01C935FA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
> 
> ddaney@caviumnetworks.com wrote:
> 
>> The FPU exceptions come in as TLB exceptions -- see if this is
>> one of them, and act accordingly.
>>
>> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
>> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  arch/mips/mm/fault.c |   15 +++++++++++++++
>>  1 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
>> index fa636fc..9ce503a 100644
>> --- a/arch/mips/mm/fault.c
>> +++ b/arch/mips/mm/fault.c
>> @@ -47,6 +47,21 @@ asmlinkage void do_page_fault(struct pt_regs *regs, 
>> unsigned long write,
>>             field, regs->cp0_epc);
>>  #endif
>>  
>> +#ifdef CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
>>   
> 
>   Why this is not in the same patch that introduces this option?

Because the option was introduced in patch 01/37 along with all the rest 
of the new files.  I decided to add the Kconfig for the entire patch set 
  in a single go.  For an incremental patch, certainly Kconfig changes 
would probably be in the patch that adds their use.  But I think 
rigorous orthodoxy on this point in the initial patch set might make 
things less clear rather than improving the situation.


> 
>> +    /*
>> +     * Normally the FPU emulator uses a load word from address one
>> +     * to retake control of the CPU after executing the
>> +     * instruction in the delay slot of an emulated branch. The
>> +     * Octeon hardware unaligned access fix changes this from an
>> +     * address exception into a TLB exception. This code checks to
>> +     * see if this page fault was caused by an FPU emulation.
>> +     *
>> +     * Terminate if exception was recognized as a delay slot return */
>>   
> 
>   I'm back to nitpicking again, see chapter 8 for the preferred 
> multiuline comment style (you almost got it right :-).
> 
>> +    extern int do_dsemulret(struct pt_regs *);
>>   
> 
>   Won't this cause a warning about the declaration amidst of code? You 
> should be able to put it in this function's declaration block painlessly...
> 

Both of these last point will be addressed.

David Daney
