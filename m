Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 13:42:59 +0200 (CEST)
Received: from mail-yx0-f195.google.com ([209.85.210.195]:62072 "EHLO
	mail-yx0-f195.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493506AbZIJLmw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 13:42:52 +0200
Received: by yxe33 with SMTP id 33so26734yxe.0
        for <multiple recipients>; Thu, 10 Sep 2009 04:42:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7R73+dcNZ/iprMyGpWrEPNSFWKJHTc5OpIXVRr/VIAw=;
        b=jcC4iqr8fOv2Y59ZtviP0K/SyHXnTG9f+xd+dy8atcWCl+jAKsk95048HNFRSNHr2y
         Q8uhdSxC02cyWwCGg0s8D/gNpO+BY7RlJT8lC2OFxe7If/ScmUTS3NTiE1qB+iBML3qW
         H4pZqBeZe45UzBQPiMyp0G1kCBqElXUqYWNcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O5RqNRfVzPblBVq+wWPERO89Nj+4ykCQ+Itjrym69Dk5YeEwKiPWGL9vmndC9Etn48
         M1TxVfBA6pDxaS4rmF912ubS9UvQ6NViGm/qCYX/T4q3OigKKhha0HnmuJInypNnyZE6
         PImtm/Scj1qKfdUxE0J689fvGW2fS5xniM3z8=
Received: by 10.90.225.5 with SMTP id x5mr848773agg.87.1252582966072;
        Thu, 10 Sep 2009 04:42:46 -0700 (PDT)
Received: from desktop ([58.31.9.46])
        by mx.google.com with ESMTPS id 39sm187805aga.71.2009.09.10.04.42.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 04:42:45 -0700 (PDT)
Date:	Thu, 10 Sep 2009 19:42:38 +0800
From:	Wu Fei <at.wufei@gmail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] cleanup vmalloc_fault for 64bit kernel
Message-ID: <20090910114238.GA7014@desktop>
References: <20090831132811.GA6924@desktop> <4AA7CB3E.1080807@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AA7CB3E.1080807@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <at.wufei@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: at.wufei@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 09, 2009 at 08:35:26AM -0700, David Daney wrote:
> Wu Fei wrote:
>> 64bit kernel won't arrive vmalloc_fault, it's not necessary or possible
>> to copy the page table from init_mm.pgd. swapper_pg_dir, module_pg_dir
>> and the process's pgd represent the different virtual address area, and
>> the tlb exception handler accesses the suitable one directly.
>>
>> Signed-off-by: Wu Fei <at.wufei@gmail.com>
>> ---
>>  arch/mips/mm/fault.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
>> index f956ecb..e769789 100644
>> --- a/arch/mips/mm/fault.c
>> +++ b/arch/mips/mm/fault.c
>> @@ -58,11 +58,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>>  	 * only copy the information from the master page table,
>>  	 * nothing more.
>>  	 */
>> +#ifdef CONFIG_32BIT
>>  	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
>>  		goto vmalloc_fault;
>> -#ifdef MODULE_START
>> -	if (unlikely(address >= MODULE_START && address < MODULE_END))
>> -		goto vmalloc_fault;
>>  #endif
>>  
>
> That is not correct.  You can still arrive at do_page_fault() from  
> faults in the vmalloc range.  We need to go directly to the panic code  

That's not a real problem, if do_page_fault() from faults in the vmalloc
range, find_vma() returns NULL and eventually it will arrive no_context.
But anyway, I think your patch is better and readable.

Thanks,
Wufei.

> as I did in my patch: Message-Id:  
> <1251931654-21268-1-git-send-email-ddaney@caviumnetworks.com>
>
> AKA: [PATCH] MIPS: Don't corrupt page tables on vmalloc fault.
>
>
>
>>  	/*
>> @@ -203,6 +201,7 @@ do_sigbus:
>>  	force_sig_info(SIGBUS, &info, tsk);
>>   	return;
>> +#ifdef CONFIG_32BIT
>>  vmalloc_fault:
>>  	{
>>  		/*
>> @@ -241,4 +240,5 @@ vmalloc_fault:
>>  			goto no_context;
>>  		return;
>>  	}
>> +#endif
>>  }
>
