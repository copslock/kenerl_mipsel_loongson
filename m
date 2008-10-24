Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 18:18:53 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:55962 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22307410AbYJXRSV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 18:18:21 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490203530000>; Fri, 24 Oct 2008 13:18:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 10:18:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 10:18:10 -0700
Message-ID: <49020352.1060705@caviumnetworks.com>
Date:	Fri, 24 Oct 2008 10:18:10 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix kgdb build error
References: <20081025001725.7ac18a1b.yoichi_yuasa@tripeaks.co.jp> <4901F851.8010103@caviumnetworks.com> <20081024170950.GC25297@linux-mips.org>
In-Reply-To: <20081024170950.GC25297@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 17:18:10.0503 (UTC) FILETIME=[7D2EF570:01C935FC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Oct 24, 2008 at 09:31:13AM -0700, David Daney wrote:
> 
>> Yoichi Yuasa wrote:
>>> ptrace.h needs #include <linux/types.h>
>>>
>> [...]
>>
>> Can you try this completely untested patch instead?
>>
>> If it works, I will give it a more thorough test over the next few
>> weeks.
> 
> This looks correct, I think.
> 
> Though I was wondering about two special cases:
> 
>   o 32-bit debugger debugging a 64-bit process
>   o 64-bit debugger debugging a 32-bit process
> 
> The unions make we wonder if that case was considered ...
> 

The ptrace interface only gives access to the raw watch registers, their 
width and thus the union element used is determined by how the kernel 
was built (32 or 64 bit).

It is up to the user space debugger to handle address space size issues. 
  The current gdb patch has only been tested on 32 bit systems.

David Daney
