Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:14:43 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13052 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492195Ab0AVTON (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2010 20:14:13 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b58a8c00000>; Thu, 21 Jan 2010 11:19:28 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 21 Jan 2010 11:18:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 21 Jan 2010 11:18:50 -0800
Message-ID: <4B58A89A.8050405@caviumnetworks.com>
Date:   Thu, 21 Jan 2010 11:18:50 -0800
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
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>
In-Reply-To: <1263932978.31321.53.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2010 19:18:50.0767 (UTC) FILETIME=[904211F0:01CA9ACE]
X-archive-position: 25628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14852

Steven Rostedt wrote:
> Peter Zijlstra and I were doing a look over of places that assign
> current->state = TASK_*INTERRUPTIBLE, by simply looking at places with:
> 
>  $ git grep -A1 'state[[:space:]]*=[[:space:]]*TASK_[^R]'
> 
> and it seems there are quite a few places that looks like bugs. To be on
> the safe side, everything outside of a run queue lock that sets the
> current state to something other than TASK_RUNNING (or dead) should be
> using set_current_state().
> 
> 	current->state = TASK_INTERRUPTIBLE;
> 	schedule();
> 
> is probably OK, but it would not hurt to be consistent. Here's a few
> examples of likely bugs:
> 
[...]

This may be a bit off topic, but exactly which type of barrier should 
set_current_state() be implying?

On MIPS, set_mb() (which is used by set_current_state()) has a full mb().

Some MIPS based processors have a much lighter weight wmb().  Could 
wmb() be used in place of mb() here?

If not, an explanation of the required memory ordering semantics here 
would be appreciated.

I know the documentation says:

     set_current_state() includes a barrier so that the write of
     current->state is correctly serialised wrt the caller's subsequent
     test of whether to actually sleep:

  	set_current_state(TASK_UNINTERRUPTIBLE);
  	if (do_i_need_to_sleep())
  		schedule();


Since the current CPU sees the memory accesses in order, what can be 
happening on other CPUs that would require a full mb()?


Thanks,
David Daney
