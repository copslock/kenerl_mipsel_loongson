Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Dec 2004 00:16:25 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:46761 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225192AbULRAQU>; Sat, 18 Dec 2004 00:16:20 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1CfSGX-0005hX-0g
	for <linux-mips@linux-mips.org>; Fri, 17 Dec 2004 18:16:09 -0600
Message-ID: <41C377ED.1040502@realitydiluted.com>
Date: Fri, 17 Dec 2004 18:21:01 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Ideas on removing a compiler warning in 'init_task.c' ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

I am trying to clean up a few compiler warnings. Here is one remaining
one:

   CC      arch/mips/kernel/init_task.o
   arch/mips/kernel/init_task.c:15: warning: initialization makes integer from 
pointer without a cast

which has to do with this line:

   static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);

I actually broke out the macro and it is complaining about the initialization
of 'action' member in the 'sighand_struct' defined in 'include/linux/sched.h'.

   struct sighand_struct {
           atomic_t                count;
           struct k_sigaction      action[_NSIG];
           spinlock_t              siglock;
   };

I do not see this when compiling x86 code and the MIPS structure is
not that drastically different IMHO. Anyone have some ideas on this
one?

-Steve
