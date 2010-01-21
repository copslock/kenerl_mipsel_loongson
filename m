Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:14:21 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13050 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492191Ab0AVTOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2010 20:14:12 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b58b76d0000>; Thu, 21 Jan 2010 12:22:05 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 21 Jan 2010 12:21:46 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 21 Jan 2010 12:21:46 -0800
Message-ID: <4B58B759.8000002@caviumnetworks.com>
Date:   Thu, 21 Jan 2010 12:21:45 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     rostedt@goodmis.org
CC:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>,
        Andy Whitcroft <apw@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: Lots of bugs with current->state = TASK_*INTERRUPTIBLE
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>      <4B58A89A.8050405@caviumnetworks.com>   <1264102455.31321.293.camel@gandalf.stny.rr.com>        <4B58B1B3.6000502@caviumnetworks.com> <1264105104.31321.298.camel@gandalf.stny.rr.com>
In-Reply-To: <1264105104.31321.298.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2010 20:21:46.0065 (UTC) FILETIME=[5A82D410:01CA9AD7]
X-archive-position: 25627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14851

>>
>> This is what I thought.
>>
>> My cpu (Cavium Octeon) does not have out of order reads, so my wmb() is 
> 
> Can you have reads that are out of order wrt writes? Because the above
> does not have out of order reads. It just had a read that came before a
> write. The above code could look like:
> 
> (hypothetical assembly language)
> 
> 	ld r2, TASK_UNINTERRUPTIBLE
> 	st r2, (current->state)
> 	wmb
> 	ld r1, (x)
> 	cmp r1, 0
> 
> Is it possible for the CPU to do the load of r1 before storing r2? If
> so, then the bug still exists.
> 

Indeed it is.  Lockless operations make my head hurt.

Thanks for clarifying.

David Daney



> -- Steve
> 
> 
>> in fact a full mb() from the point of view of the current CPU.  So I 
>> think I could weaken my bariers in set_current_state() and still get 
>> correct operation.  However as you say...
>>
> 
> 
> 
