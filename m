Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 02:47:08 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48173 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S29576064AbZDVSO6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 19:14:58 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ef5e800000>; Wed, 22 Apr 2009 14:14:24 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 11:13:44 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 11:13:44 -0700
Message-ID: <49EF5E58.2040901@caviumnetworks.com>
Date:	Wed, 22 Apr 2009 11:13:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/2] MIPS: Move signal return trampolines off the stack.
References: <49EE3B0F.3040506@caviumnetworks.com> <20090422180447.GC28623@cuplxvomd02.corp.sa.net>
In-Reply-To: <20090422180447.GC28623@cuplxvomd02.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2009 18:13:44.0460 (UTC) FILETIME=[12BB6CC0:01C9C376]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> On Tue, Apr 21, 2009 at 02:30:55PM -0700, David Daney wrote:
>> This patch set (against 2.6.29.1) creates a vdso and moves the signal
>> trampolines to it from their previous home on the stack.
>>
>> Tested with a 64-bit kernel on a Cavium Octeon cn3860 where I have the
>> following results from lmbench2:
>>
>> Before:
>> n64 - Signal handler overhead: 14.517 microseconds
>> n32 - Signal handler overhead: 14.497 microseconds
>> o32 - Signal handler overhead: 16.637 microseconds
>>
>> After:
>>
>> n64 - Signal handler overhead: 7.935 microseconds
>> n32 - Signal handler overhead: 7.334 microseconds
>> o32 - Signal handler overhead: 8.628 microseconds
> 
> Nice numbers, and something that will be even more critical as real-time
> features are added and used!
> 

non-SMP systems will probably not see so much improvement.

Although the numbers are nice, they are not the primary motivation 
behind the patch.  The real gains are in not having to interrupt all 
cores to invalidate their caches, and the possibility of eXecute Inhibit 
on the stack.

>> Comments encourged.
> 
> Only one comment, which I would not want to hold up acceptance:
> based on some numbers sent out recently, it looks like the kernel is
> experiencing some performance issues with exec() and I think this change will
> make it slightly slower. You could avoid this by deferring installation of
> the trampoline to the first use of a system call that registers a signal
> handler.
> 

I should try to measure this too.  Although this is what x86 et al. do. 
  It is by far much simpler and less prone to bugs that trying to hook 
into the system calls.  After an executable has had the chance to start 
additional threads and establish arbitrary mappings things get complicated.

David Daney
