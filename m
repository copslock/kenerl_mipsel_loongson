Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N6usZ12272
	for linux-mips-outgoing; Tue, 22 Jan 2002 22:56:54 -0800
Received: from ns4.sony.co.jp (NS4.Sony.CO.JP [146.215.0.102])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N6ugP12269;
	Tue, 22 Jan 2002 22:56:43 -0800
Received: from mail1.sony.co.jp (GateKeeper11.Sony.CO.JP [146.215.0.74])
	by ns4.sony.co.jp (R8/Sony) with ESMTP id g0N5ucY75386;
	Wed, 23 Jan 2002 14:56:38 +0900 (JST)
Received: from mail1.sony.co.jp (localhost [127.0.0.1])
	by mail1.sony.co.jp (R8) with ESMTP id g0N5ubl22735;
	Wed, 23 Jan 2002 14:56:37 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail1.sony.co.jp (R8) with ESMTP id g0N5uZg22681;
	Wed, 23 Jan 2002 14:56:36 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id PAA04915; Wed, 23 Jan 2002 15:01:21 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id OAA16906; Wed, 23 Jan 2002 14:56:34 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g0N5uYJ08126; Wed, 23 Jan 2002 14:56:34 +0900 (JST)
To: kevink@mips.com
Cc: aj@suse.de, hjl@lucon.org, ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
In-Reply-To: <005301c1a368$87d27ed0$10eca8c0@grendel>
References: <20020122232529V.machida@sm.sony.co.jp>
	<005301c1a368$87d27ed0$10eca8c0@grendel>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020123145634M.machida@sm.sony.co.jp>
Date: Wed, 23 Jan 2002 14:56:34 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Kevin,

As you said, following codes can run fine if CPU has brach-likely.

From: "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
Date: Tue, 22 Jan 2002 18:16:25 +0100

> _atomic_inc_nollsc:
>         .set  noreorder
>         li    t0,MAGIC_COOKIE
> Retry:
>         mov      k1,t0
>         lw         t1,0(a0)
>         addiu    t1,t1,1
>         BEQL  k1,t0,done
>         sw        t1,0(a0)
>         b          Retry
>         nop
> done
>         jr        ra
>         nop
>  

	<snip>

> If there is any doubt about the possibility of the
> MAGIC_COOKIE value being left in k1 (or
> k0, which could also be used as the "LL flop"
> if its behavior is more easily constrained), an
> explicit operation at the end of the fault handlers
> could be used to clear the register.  That would
> still be far less complex and intrusive than the mods 
> that you suggest below.

I think we should always "clear" k1 at the end of exception handler.
(Above "clear" means "set !MAGIC_COOKIE"). It's conaervative way,
but robust aginst future changes in exception handler.


> It should in principle be SMP safe.

I don't think so.

Suppose that 
	THREAD A is bound to CPU A and THREAD B is bound to CPU B.
	THREAD A and THREAD B are running on_atomic_inc_nollsc(). 
Two threads are really running at the same time, without
context-switch. In this case nobody clear k1.


Anyway, I will merge your brach-likely method and make some changes.

This change will provide signle interface of user level
test-and-set(), without LL/SC instruction emulation nor
system-call. So everyone will be able to run single user program
binary to on following three types of CPUs;  
	CPU has LL/SC, 	
	CPU has no LL/SC, but has branch-likely and 
	CPU has neither LL/SC nor branch-likely.


---
Hiroyuki Machida
Sony Corp.
