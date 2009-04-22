Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 07:54:16 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:47639 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S29570072AbZDVSCO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 19:02:14 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ef5b950001>; Wed, 22 Apr 2009 14:01:57 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 11:01:45 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 11:01:45 -0700
Message-ID: <49EF5B88.90004@caviumnetworks.com>
Date:	Wed, 22 Apr 2009 11:01:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com> <49EEE4EA.8040100@paralogos.com>
In-Reply-To: <49EEE4EA.8040100@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2009 18:01:45.0043 (UTC) FILETIME=[65ED1A30:01C9C374]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> David Daney wrote:
>> This is a preliminary patch to add a vdso to all user processes.
>> Still missing are ELF headers and .eh_frame information.  But it is
>> enough to allow us to move signal trampolines off of the stack.
>>
>> We allocate a single page (the vdso) and write all possible signal
>> trampolines into it.  The stack is moved down by one page and the vdso
>> is mapped into this space.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Note that for FPU-less CPUs, the kernel FP emulator also uses a user
> stack trampoline to execute instructions in the delay slots of emulated
> FP branches.  I didn't see any of the math-emu modules being tweaked in
> either part of your patch.  Presumably, one would want to move that
> operation into the vdso as well.  With the proposed patch, I'm not sure
> whether things would continue working normally as before, still using
> the user stack, or whether the dsemulret code depends on something that
> is changed by the patch, and will now implode.  Probably the former, but
> paranoia is not a character defect in OS kernel work. I don't have a
> test case handy (nor a test system any more), but compiling something
> like whetstone or linpack in C with a high degree of optimization will
> *probably* generate FP branches with live delay slots.
> 

It is an ugly problem.  I am trying to hack something up to fix it.

David Daney
