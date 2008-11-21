Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 23:51:19 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6468 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23823448AbYKUXvL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 23:51:11 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492748ef0000>; Fri, 21 Nov 2008 18:49:03 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 15:48:42 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 15:48:42 -0800
Message-ID: <492748DA.3030805@caviumnetworks.com>
Date:	Fri, 21 Nov 2008 15:48:42 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
References: <49260E4C.8080500@caviumnetworks.com> <20081121150023.032f7b5b.akpm@linux-foundation.org>
In-Reply-To: <20081121150023.032f7b5b.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2008 23:48:42.0736 (UTC) FILETIME=[AF72F700:01C94C33]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
>
> 
> Yup, this change will fix some compile warnings which will never be
> fixed in any other way for mips.
> 
>> +static inline void __noreturn BUG(void)
>> +{
>> +	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
>> +	/* Fool GCC into thinking the function doesn't return. */
>> +	while (1)
>> +		;
>> +}
> 
> This kind of sucks, doesn't it?  It adds instructions into the kernel
> text, very frequently on fast paths.  Those instructions are never
> executed, and we're blowing away i-cache just to quash compiler
> warnings.
> 
> For example, this:
> 
> --- a/arch/x86/include/asm/bug.h~a
> +++ a/arch/x86/include/asm/bug.h
> @@ -22,14 +22,12 @@ do {								\
>  		     ".popsection"				\
>  		     : : "i" (__FILE__), "i" (__LINE__),	\
>  		     "i" (sizeof(struct bug_entry)));		\
> -	for (;;) ;						\
>  } while (0)
>  
>  #else
>  #define BUG()							\
>  do {								\
>  	asm volatile("ud2");					\
> -	for (;;) ;						\
>  } while (0)
>  #endif
>  
> _
> 
> reduces the size of i386 mm/vmalloc.o text by 56 bytes.
> 
> I wonder if there is any clever way in which we can do this without
> introducing additional runtime cost.

As I said in the other part of the thread, We are working on a GCC patch 
that adds a new built-in function '__builtin_noreturn()', that you could 
substitute for 'for(;;);' that emits no instructions in this case.

David Daney
