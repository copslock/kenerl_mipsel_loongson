Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 09:29:17 +0000 (GMT)
Received: from smtp-102.noc.nerim.net ([IPv6:::ffff:62.4.17.102]:63504 "EHLO
	mallaury.noc.nerim.net") by linux-mips.org with ESMTP
	id <S8225197AbTBGJ3Q>; Fri, 7 Feb 2003 09:29:16 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id B19F062E2A; Fri,  7 Feb 2003 10:29:14 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18h4ou-0000Vn-00; Fri, 07 Feb 2003 10:29:16 +0100
Date: Fri, 7 Feb 2003 10:29:16 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] r4k_switch task_struct/thread_info fixes
In-Reply-To: <20030206163647.F13258@mvista.com>
Message-ID: <Pine.LNX.4.21.0302071019550.1913-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

On Thu, 6 Feb 2003, Jun Sun wrote:

> Actually the following hunks are not right.  ST_OFF
> should be applied against the task_struct, which is a0,
> not thread_info (t3).

In 2.4 yes, not in 2.5.

include/linux/sched.h:469
> union thread_union {
>         struct thread_info thread_info;
>         unsigned long stack[INIT_THREAD_SIZE/sizeof(long)];
> };

That means the top of the stack is actually at (task->thread_info +
KERNEL_STACK_SIZE) in 2.5. See for example arch/mips64/kernel/ptrace.c:107

> Also see my next email before you rush into trying :-)

Ok, I'll look at it later.

Vivien.
