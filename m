Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2009 20:10:20 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10272 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097307AbZIPSKK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2009 20:10:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ab129f00000>; Wed, 16 Sep 2009 11:09:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Sep 2009 11:09:36 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Sep 2009 11:09:36 -0700
Message-ID: <4AB129DF.8060200@caviumnetworks.com>
Date:	Wed, 16 Sep 2009 11:09:35 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't write ones to reserved entryhi bits.
References: <1241812330-21041-1-git-send-email-ddaney@caviumnetworks.com> <20090527162937.GA9831@linux-mips.org>
In-Reply-To: <20090527162937.GA9831@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Sep 2009 18:09:36.0381 (UTC) FILETIME=[D996D2D0:01CA36F8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, May 08, 2009 at 12:52:10PM -0700, David Daney wrote:
> 
>> According to the MIPS64 Privileged Resource Architecture manual, only
>> values of zero may be written to bits 8..10 of CP0 entryhi.  We need
>> to add masking by ASID_MASK.
> 
> Yes, I've silently been relying on the hardware chopping off the excess
> bits for no better reason that it saving an instruction.  One of the
> functions you've touched is switch_mm() which is being used in context
> switches and any changes to it will show up in context switching
> benchmarks.
> 
> The patch you did (and along with that some older SMTC changes by Kevin)
> can be done slightly more elegant because we already have:
> 
> #define cpu_asid(cpu, mm)       (cpu_context((cpu), (mm)) & ASID_MASK)
> 
> in <asm/mmu_context.h>.
> 
> We used to optimize the ASID managment code by code patching even, see
> mmu_context.h in 78c388aed2b7184182c08428db1de6c872d815f5.
> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 

This is nice, but you never committed it.

David Daney.



>  arch/mips/include/asm/mmu_context.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
> index d7f3eb0..25a50fa 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -164,12 +164,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	 * having ASID_MASK smaller than the hardware maximum,
>  	 * make sure no "soft" bits become "hard"...
>  	 */
> -	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK)
> -			| (cpu_context(cpu, next) & ASID_MASK));
> +	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK) |
> +			 cpu_asid(cpu, next));
>  	ehb(); /* Make sure it propagates to TCStatus */
>  	evpe(mtflags);
>  #else
> -	write_c0_entryhi(cpu_context(cpu, next));
> +	write_c0_entryhi(cpu_asid(cpu, next));
>  #endif /* CONFIG_MIPS_MT_SMTC */
>  	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
>  
> @@ -225,11 +225,11 @@ activate_mm(struct mm_struct *prev, struct mm_struct *next)
>  	}
>  	/* See comments for similar code above */
>  	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK) |
> -	                 (cpu_context(cpu, next) & ASID_MASK));
> +	                 cpu_asid(cpu, next));
>  	ehb(); /* Make sure it propagates to TCStatus */
>  	evpe(mtflags);
>  #else
> -	write_c0_entryhi(cpu_context(cpu, next));
> +	write_c0_entryhi(cpu_asid(cpu, next));
>  #endif /* CONFIG_MIPS_MT_SMTC */
>  	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
>  
> 
