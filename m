Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2008 13:59:41 +0100 (BST)
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:14580 "EHLO
	smtpout.karoo.kcom.com") by ftp.linux-mips.org with ESMTP
	id S28583787AbYGZM7c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 26 Jul 2008 13:59:32 +0100
X-IronPort-AV: E=Sophos;i="4.31,255,1215385200"; 
   d="scan'208";a="15528816"
Received: from deneb.mcrowe.com (HELO mcrowe.com) ([82.152.148.4])
  by smtpout.karoo.kcom.com with ESMTP; 26 Jul 2008 13:57:09 +0100
Received: from mac by mcrowe.com with local (Exim 4.63)
	(envelope-from <mac@mcrowe.com>)
	id 1KMjMr-00008Z-Uh; Sat, 26 Jul 2008 13:59:25 +0100
Date:	Sat, 26 Jul 2008 13:59:25 +0100
From:	Mike Crowe <mac@mcrowe.com>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add severity levels to printk statements during kernel setup.
Message-ID: <20080726125925.GB32426@mcrowe.com>
References: <20080725134454.GA26225@mcrowe.com> <Pine.LNX.4.64.0807252002490.11082@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807252002490.11082@anakin>
X-url:	http://www.mcrowe.com/
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <mac@mcrowe.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mac@mcrowe.com
Precedence: bulk
X-list: linux-mips

On Fri, 25 Jul 2008, I wrote:
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -78,7 +78,7 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
>>  
>>  	/* Sanity check */
>>  	if (start + size < start) {
>> -		printk("Trying to add an invalid memory region, skipped\n");
>> +		printk(KERN_WARNING "Trying to add an invalid memory region, skipped\n");
 
On Fri, Jul 25, 2008 at 08:04:57PM +0200, Geert Uytterhoeven wrote:
> Why not convert to pr_warning(), while you're at it?

I can do. I'm just a bit behind the times. :-)

Should I use pr_{warning,err,info} everywhere rather than printk? Is
it worth fixing up the other calls to printk that I didn't need to
"fix"?

>> @@ -221,7 +221,7 @@ static void __init finalize_initrd(void)
>>  		goto disable;
>>  	}
>>  	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
>> -		printk("Initrd extends beyond end of memory");
>> +		printk(KERN_ERR "Initrd extends beyond end of memory");
>                                                                     ^
> There's no newline here, so...
> 
>>  		goto disable;
>>  	}
>>  
>> @@ -232,7 +232,7 @@ static void __init finalize_initrd(void)
>>  	       initrd_start, size);
>>  	return;
>>  disable:
>> -	printk(" - disabling initrd\n");
>> +	printk(KERN_ERR " - disabling initrd\n");
>                ^^^^^^^^
> ... probably this should be KERN_CONT.
> Note that I didn't check the other paths to get here.

Well spotted. I thought I'd checked those but obviously not carefully enough. I shall try again.

Thanks.

Mike.
