Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2008 17:21:59 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:21889 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S29038288AbYFJQV4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jun 2008 17:21:56 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 9EBDB31E0C9;
	Tue, 10 Jun 2008 16:21:55 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 10 Jun 2008 16:21:55 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 10 Jun 2008 09:21:43 -0700
Message-ID: <484EAA16.80903@avtrex.com>
Date:	Tue, 10 Jun 2008 09:21:42 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Brian Foster <brian.foster@innova-card.com>,
	"Kevin D. Kissell" <KevinK@paralogos.com>,
	Andrew Dyer <adyer@righthandtech.com>,
	linux-mips@linux-mips.org
Subject: Re: Adding(?) XI support to MIPS-Linux?
References: <200806091658.10937.brian.foster@innova-card.com> <484D856B.5030306@paralogos.com> <20080609204627.GE11233@networkno.de> <200806101119.06227.brian.foster@innova-card.com> <a537dd660806100232v4cbf2cfeo397e94ac5a4d2104@mail.gmail.com> <20080610095702.GG11233@networkno.de>
In-Reply-To: <20080610095702.GG11233@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2008 16:21:43.0696 (UTC) FILETIME=[124F3900:01C8CB16]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Brian Foster wrote:
> [snip]
>   
>>  2) Kevin D. Kissell wrote:
>>  2)[ ... ]
>>  2) > Well, strictly speaking, you wouldn't actually *need* to modify
>>  2) > binutils to make specially tagged binaries.  [ ... ]
>>  2)
>>  2) This exists already in ld's -z execstack/noexecstack feature.
>>
>> Good point.  Thanks for the reminder.
>>
>>  2) It is not used by default because too many things depend on executable
>>  2) stacks on MIPS.
>>
>> Ah!  Can you be more specific please?  At the present time
>> I'm only aware of three situations where executable stacks
>> are magically used ("magic" meaning it's being done without
>> the programmer explicitly coding it):
>>
>>   1. sigreturn.
>>   2. something to do with FPU emulation?
>>   3. pointer to a nested function (gcc extension).
>>     
>
> Those, plus manually coded trampolines in e.g. foreign function
> interfacing (which are typically hidden in some library). I don't
> know if you can ignore that completely. :-)
>
>   
The trampolines in libffi are user allocated, so there is a choice of 
where to place them.  In libgcj (which uses the libffi trampolines) the 
trampolines are allocated on the heap and care is taken to set the 
execute permissions on the memory in question.  Other users may have 
problems, but by now most code should work as XI support has been 
present on x86 for quite some time now.

As long as there is a mechanism to make user space stacks (and heap) 
executable, there should be no problem.  People running code that 
requires it can switch off the XI support.

David Daney
>> And, significantly, I am do not know of any need for the
>> kernel-mode stacks to be executable.  Except, perhaps,
>> for case 3, the above are (should be?) user-land only.
>>     
>
> AFAIK nested functions are frowned upon in kernelspace.
>
>
> Thiemo
>
>   
